Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE7AC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 03:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A866E2086D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 03:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730459AbfHHDlO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 23:41:14 -0400
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:49635 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728019AbfHHDlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 23:41:13 -0400
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x783efIu030575
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 8 Aug 2019 12:40:41 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x783efAY003936;
        Thu, 8 Aug 2019 12:40:41 +0900
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x783eeEd020078;
        Thu, 8 Aug 2019 12:40:41 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.148] [10.38.151.148]) by mail02.kamome.nec.co.jp with ESMTP id BT-MMP-7505107; Thu, 8 Aug 2019 12:36:24 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC20GP.gisp.nec.co.jp ([10.38.151.148]) with mapi id 14.03.0439.000; Thu, 8
 Aug 2019 12:36:23 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ltp@lists.linux.it" <ltp@lists.linux.it>,
        "Li Wang" <liwang@redhat.com>, Michal Hocko <mhocko@kernel.org>,
        Cyril Hrubis <chrubis@suse.cz>,
        "xishi.qiuxishi@alibaba-inc.com" <xishi.qiuxishi@alibaba-inc.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] hugetlbfs: fix hugetlb page migration/fault race
 causing SIGBUS
Thread-Topic: [PATCH] hugetlbfs: fix hugetlb page migration/fault race
 causing SIGBUS
Thread-Index: AQHVTX0N0YwnRs9J50WW+DT6/gmNh6bwAwsA
Date:   Thu, 8 Aug 2019 03:36:22 +0000
Message-ID: <20190808033622.GA28751@hori.linux.bs1.fc.nec.co.jp>
References: <20190808000533.7701-1-mike.kravetz@oracle.com>
In-Reply-To: <20190808000533.7701-1-mike.kravetz@oracle.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.150]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <BB43671309A3D0478266CADD63E511C9@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 05:05:33PM -0700, Mike Kravetz wrote:
> Li Wang discovered that LTP/move_page12 V2 sometimes triggers SIGBUS
> in the kernel-v5.2.3 testing.  This is caused by a race between hugetlb
> page migration and page fault.
> 
> If a hugetlb page can not be allocated to satisfy a page fault, the task
> is sent SIGBUS.  This is normal hugetlbfs behavior.  A hugetlb fault
> mutex exists to prevent two tasks from trying to instantiate the same
> page.  This protects against the situation where there is only one
> hugetlb page, and both tasks would try to allocate.  Without the mutex,
> one would fail and SIGBUS even though the other fault would be successful.
> 
> There is a similar race between hugetlb page migration and fault.
> Migration code will allocate a page for the target of the migration.
> It will then unmap the original page from all page tables.  It does
> this unmap by first clearing the pte and then writing a migration
> entry.  The page table lock is held for the duration of this clear and
> write operation.  However, the beginnings of the hugetlb page fault
> code optimistically checks the pte without taking the page table lock.
> If clear (as it can be during the migration unmap operation), a hugetlb
> page allocation is attempted to satisfy the fault.  Note that the page
> which will eventually satisfy this fault was already allocated by the
> migration code.  However, the allocation within the fault path could
> fail which would result in the task incorrectly being sent SIGBUS.
> 
> Ideally, we could take the hugetlb fault mutex in the migration code
> when modifying the page tables.  However, locks must be taken in the
> order of hugetlb fault mutex, page lock, page table lock.  This would
> require significant rework of the migration code.  Instead, the issue
> is addressed in the hugetlb fault code.  After failing to allocate a
> huge page, take the page table lock and check for huge_pte_none before
> returning an error.  This is the same check that must be made further
> in the code even if page allocation is successful.
> 
> Reported-by: Li Wang <liwang@redhat.com>
> Fixes: 290408d4a250 ("hugetlb: hugepage migration core")
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> Tested-by: Li Wang <liwang@redhat.com>

Thanks for the work and nice description.

Reviewed-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>

> ---
>  mm/hugetlb.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index ede7e7f5d1ab..6d7296dd11b8 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3856,6 +3856,25 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>  
>  		page = alloc_huge_page(vma, haddr, 0);
>  		if (IS_ERR(page)) {
> +			/*
> +			 * Returning error will result in faulting task being
> +			 * sent SIGBUS.  The hugetlb fault mutex prevents two
> +			 * tasks from racing to fault in the same page which
> +			 * could result in false unable to allocate errors.
> +			 * Page migration does not take the fault mutex, but
> +			 * does a clear then write of pte's under page table
> +			 * lock.  Page fault code could race with migration,
> +			 * notice the clear pte and try to allocate a page
> +			 * here.  Before returning error, get ptl and make
> +			 * sure there really is no pte entry.
> +			 */
> +			ptl = huge_pte_lock(h, mm, ptep);
> +			if (!huge_pte_none(huge_ptep_get(ptep))) {
> +				ret = 0;
> +				spin_unlock(ptl);
> +				goto out;
> +			}
> +			spin_unlock(ptl);
>  			ret = vmf_error(PTR_ERR(page));
>  			goto out;
>  		}
> -- 
> 2.20.1
> 
> 
