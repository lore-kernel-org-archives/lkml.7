Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13996C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 07:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC56A208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 07:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405497AbfFLHZ7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 03:25:59 -0400
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:44754 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728561AbfFLHZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 03:25:42 -0400
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x5C7PHtx003180
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 12 Jun 2019 16:25:17 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x5C7PG92019680;
        Wed, 12 Jun 2019 16:25:17 +0900
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x5C7PGFv022790;
        Wed, 12 Jun 2019 16:25:16 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.148] [10.38.151.148]) by mail02.kamome.nec.co.jp with ESMTP id BT-MMP-5900495; Wed, 12 Jun 2019 16:24:18 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC20GP.gisp.nec.co.jp ([10.38.151.148]) with mapi id 14.03.0319.002; Wed,
 12 Jun 2019 16:24:17 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        "xishi.qiuxishi@alibaba-inc.com" <xishi.qiuxishi@alibaba-inc.com>,
        "Chen, Jerry T" <jerry.t.chen@intel.com>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] mm: hugetlb: soft-offline:
 dissolve_free_huge_page() return zero on !PageHuge
Thread-Topic: [PATCH v2 2/2] mm: hugetlb: soft-offline:
 dissolve_free_huge_page() return zero on !PageHuge
Thread-Index: AQHVH2UOI3n3iV7mFEufJF8BQjmdkqaWHQeAgADtBAA=
Date:   Wed, 12 Jun 2019 07:24:16 +0000
Message-ID: <20190612072422.GA28614@hori.linux.bs1.fc.nec.co.jp>
References: <1560154686-18497-1-git-send-email-n-horiguchi@ah.jp.nec.com>
 <1560154686-18497-3-git-send-email-n-horiguchi@ah.jp.nec.com>
 <039dd97d-83f5-f71a-e78f-a451b0064903@oracle.com>
In-Reply-To: <039dd97d-83f5-f71a-e78f-a451b0064903@oracle.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.150]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <BCCB33A416C92644BE29C96ADEA07518@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 10:16:03AM -0700, Mike Kravetz wrote:
> On 6/10/19 1:18 AM, Naoya Horiguchi wrote:
> > madvise(MADV_SOFT_OFFLINE) often returns -EBUSY when calling soft offline
> > for hugepages with overcommitting enabled. That was caused by the suboptimal
> > code in current soft-offline code. See the following part:
> > 
> >     ret = migrate_pages(&pagelist, new_page, NULL, MPOL_MF_MOVE_ALL,
> >                             MIGRATE_SYNC, MR_MEMORY_FAILURE);
> >     if (ret) {
> >             ...
> >     } else {
> >             /*
> >              * We set PG_hwpoison only when the migration source hugepage
> >              * was successfully dissolved, because otherwise hwpoisoned
> >              * hugepage remains on free hugepage list, then userspace will
> >              * find it as SIGBUS by allocation failure. That's not expected
> >              * in soft-offlining.
> >              */
> >             ret = dissolve_free_huge_page(page);
> >             if (!ret) {
> >                     if (set_hwpoison_free_buddy_page(page))
> >                             num_poisoned_pages_inc();
> >             }
> >     }
> >     return ret;
> > 
> > Here dissolve_free_huge_page() returns -EBUSY if the migration source page
> > was freed into buddy in migrate_pages(), but even in that case we actually
> > has a chance that set_hwpoison_free_buddy_page() succeeds. So that means
> > current code gives up offlining too early now.
> > 
> > dissolve_free_huge_page() checks that a given hugepage is suitable for
> > dissolving, where we should return success for !PageHuge() case because
> > the given hugepage is considered as already dissolved.
> > 
> > This change also affects other callers of dissolve_free_huge_page(),
> > which are cleaned up together.
> > 
> > Reported-by: Chen, Jerry T <jerry.t.chen@intel.com>
> > Tested-by: Chen, Jerry T <jerry.t.chen@intel.com>
> > Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> > Fixes: 6bc9b56433b76 ("mm: fix race on soft-offlining")
> > Cc: <stable@vger.kernel.org> # v4.19+
> > ---
> >  mm/hugetlb.c        | 15 +++++++++------
> >  mm/memory-failure.c |  5 +----
> >  2 files changed, 10 insertions(+), 10 deletions(-)
> > 
> > diff --git v5.2-rc3/mm/hugetlb.c v5.2-rc3_patched/mm/hugetlb.c
> > index ac843d3..048d071 100644
> > --- v5.2-rc3/mm/hugetlb.c
> > +++ v5.2-rc3_patched/mm/hugetlb.c
> > @@ -1519,7 +1519,12 @@ int dissolve_free_huge_page(struct page *page)
> 
> Please update the function description for dissolve_free_huge_page() as
> well.  It currently says, "Returns -EBUSY if the dissolution fails because
> a give page is not a free hugepage" which is no longer true as a result of
> this change.

Thanks for pointing out, I completely missed that.

> 
> >  	int rc = -EBUSY;
> >  
> >  	spin_lock(&hugetlb_lock);
> > -	if (PageHuge(page) && !page_count(page)) {
> > +	if (!PageHuge(page)) {
> > +		rc = 0;
> > +		goto out;
> > +	}
> > +
> > +	if (!page_count(page)) {
> >  		struct page *head = compound_head(page);
> >  		struct hstate *h = page_hstate(head);
> >  		int nid = page_to_nid(head);
> > @@ -1564,11 +1569,9 @@ int dissolve_free_huge_pages(unsigned long start_pfn, unsigned long end_pfn)
> >  
> >  	for (pfn = start_pfn; pfn < end_pfn; pfn += 1 << minimum_order) {
> >  		page = pfn_to_page(pfn);
> > -		if (PageHuge(page) && !page_count(page)) {
> > -			rc = dissolve_free_huge_page(page);
> > -			if (rc)
> > -				break;
> > -		}
> 
> We may want to consider keeping at least the PageHuge(page) check before
> calling dissolve_free_huge_page().  dissolve_free_huge_pages is called as
> part of memory offline processing.  We do not know if the memory to be offlined
> contains huge pages or not.  With your changes, we are taking hugetlb_lock
> on each call to dissolve_free_huge_page just to discover that the page is
> not a huge page.
> 
> You 'could' add a PageHuge(page) check to dissolve_free_huge_page before
> taking the lock.  However, you would need to check again after taking the
> lock.

Right, I'll do this.

What was in my mind when writing this was that I actually don't like
PageHuge because it's slow (not inlined) and called anywhere in mm code,
so I like to reduce it if possible.
But I now see that dissolve_free_huge_page() are relatively rare event
rather than hugepage allocation/free, so dissolve_free_huge_page should take
burden to precheck PageHuge instead of speculatively taking hugetlb_lock
and disrupting the hot path.

Thanks,
- Naoya
