Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B967CC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 06:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98F81222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 06:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfKMGIz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 01:08:55 -0500
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:38411 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfKMGIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 01:08:55 -0500
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id xAD68XOF026408
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 13 Nov 2019 15:08:33 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id xAD68Xib010372;
        Wed, 13 Nov 2019 15:08:33 +0900
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id xAD64PCr013961;
        Wed, 13 Nov 2019 15:08:33 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.149] [10.38.151.149]) by mail03.kamome.nec.co.jp with ESMTP id BT-MMP-711271; Wed, 13 Nov 2019 15:02:04 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC21GP.gisp.nec.co.jp ([10.38.151.149]) with mapi id 14.03.0439.000; Wed,
 13 Nov 2019 15:02:03 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
CC:     Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 01/16] mm,hwpoison: cleanup unused PageHuge()
 check
Thread-Topic: [RFC PATCH v2 01/16] mm,hwpoison: cleanup unused PageHuge()
 check
Thread-Index: AQHVhPYzQyNwsIsv3k6BqLdb1qTKQ6dfsyIAgARmlwCAIu1QAIABJ+YA
Date:   Wed, 13 Nov 2019 06:02:03 +0000
Message-ID: <20191113060202.GA3503@hori.linux.bs1.fc.nec.co.jp>
References: <20191017142123.24245-1-osalvador@suse.de>
 <20191017142123.24245-2-osalvador@suse.de>
 <20191018114832.GK5017@dhcp22.suse.cz>
 <20191021070046.GA8782@hori.linux.bs1.fc.nec.co.jp>
 <87d0dxs2ql.fsf@linux.ibm.com>
In-Reply-To: <87d0dxs2ql.fsf@linux.ibm.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.150]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <6EE8F565F6E5FB42A7EDC191D45757AC@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 05:52:58PM +0530, Aneesh Kumar K.V wrote:
> Naoya Horiguchi <n-horiguchi@ah.jp.nec.com> writes:
> 
> > On Fri, Oct 18, 2019 at 01:48:32PM +0200, Michal Hocko wrote:
> >> On Thu 17-10-19 16:21:08, Oscar Salvador wrote:
> >> > From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> >> > 
> >> > Drop the PageHuge check since memory_failure forks into memory_failure_hugetlb()
> >> > for hugetlb pages.
> >> > 
> >> > Signed-off-by: Oscar Salvador <osalvador@suse.de>
> >> > Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> >> 
> >> s-o-b chain is reversed.
> >> 
> >> The code is a bit confusing. Doesn't this check aim for THP?
> >
> > No, PageHuge() is false for thp, so this if branch is just dead code.
> 
> memory_failure()
> {
> 
> 	if (PageTransHuge(hpage)) {
> 		lock_page(p);
> 		if (!PageAnon(p) || unlikely(split_huge_page(p))) {
> 			unlock_page(p);
> 			if (!PageAnon(p))
> 				pr_err("Memory failure: %#lx: non anonymous thp\n",
> 					pfn);
> 			else
> 				pr_err("Memory failure: %#lx: thp split failed\n",
> 					pfn);
> 			if (TestClearPageHWPoison(p))
> 				num_poisoned_pages_dec();
> 			put_hwpoison_page(p);
> 			return -EBUSY;
> 		}
> 		unlock_page(p);
> 		VM_BUG_ON_PAGE(!page_count(p), p);
> 		hpage = compound_head(p);
> 	}
> 
> }
> 
> Do we need that hpage = compund_head(p) conversion there? We should just
> be able to say hpage = p, or even better after this change use p
> directly instead of hpage in the code following?

Thanks for the comment, the target page never be in compound_page
(without races leading to MF_MSG_DIFFERENT_COMPOUND path), so hpage
shouldn't be used afterward.  We also have obsolete comment, so
I feel like the following changes:

  diff --git a/mm/memory-failure.c b/mm/memory-failure.c
  index 392ac277b17d..c9df0f183d6c 100644
  --- a/mm/memory-failure.c
  +++ b/mm/memory-failure.c
  @@ -1319,7 +1319,6 @@ int memory_failure(unsigned long pfn, int flags)
   		}
   		unlock_page(p);
   		VM_BUG_ON_PAGE(!page_count(p), p);
  -		hpage = compound_head(p);
   	}
   
   	/*
  @@ -1391,11 +1390,8 @@ int memory_failure(unsigned long pfn, int flags)
   	/*
   	 * Now take care of user space mappings.
   	 * Abort on fail: __delete_from_page_cache() assumes unmapped page.
  -	 *
  -	 * When the raw error page is thp tail page, hpage points to the raw
  -	 * page after thp split.
   	 */
  -	if (!hwpoison_user_mappings(p, pfn, flags, &hpage)) {
  +	if (!hwpoison_user_mappings(p, pfn, flags, &p)) {
   		action_result(pfn, MF_MSG_UNMAP_FAILED, MF_IGNORED);
   		res = -EBUSY;
   		goto out;

Thanks,
Naoya Horiguchi
