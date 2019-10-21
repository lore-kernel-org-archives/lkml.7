Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7794CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 07:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B06E82089C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 07:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfJUHFr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 03:05:47 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:48478 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfJUHFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 03:05:47 -0400
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x9L75X5d015633
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 21 Oct 2019 16:05:33 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x9L75XAx018806;
        Mon, 21 Oct 2019 16:05:33 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x9L75Wvl020457;
        Mon, 21 Oct 2019 16:05:33 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.151] [10.38.151.151]) by mail01b.kamome.nec.co.jp with ESMTP id BT-MMP-9685657; Mon, 21 Oct 2019 16:04:41 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC23GP.gisp.nec.co.jp ([10.38.151.151]) with mapi id 14.03.0439.000; Mon,
 21 Oct 2019 16:04:40 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Oscar Salvador <osalvador@suse.de>
CC:     "mhocko@kernel.org" <mhocko@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 09/16] mm,hwpoison: Unify THP handling for hard
 and soft offline
Thread-Topic: [RFC PATCH v2 09/16] mm,hwpoison: Unify THP handling for hard
 and soft offline
Thread-Index: AQHVhPZEHfGD3bd9MkGP7p/dXrA8ladkGtAA
Date:   Mon, 21 Oct 2019 07:04:40 +0000
Message-ID: <20191021070439.GC9037@hori.linux.bs1.fc.nec.co.jp>
References: <20191017142123.24245-1-osalvador@suse.de>
 <20191017142123.24245-10-osalvador@suse.de>
In-Reply-To: <20191017142123.24245-10-osalvador@suse.de>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.96]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <ACAC5400327B2B44B0993E28BA42104F@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 04:21:16PM +0200, Oscar Salvador wrote:
> Place the THP's page handling in a helper and use it
> from both hard and soft-offline machinery, so we get rid
> of some duplicated code.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  mm/memory-failure.c | 48 ++++++++++++++++++++++--------------------------
>  1 file changed, 22 insertions(+), 26 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 836d671fb74f..37b230b8cfe7 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1066,6 +1066,25 @@ static int identify_page_state(unsigned long pfn, struct page *p,
>  	return page_action(ps, p, pfn);
>  }
>  
> +static int try_to_split_thp_page(struct page *page, const char *msg)
> +{
> +	lock_page(page);
> +	if (!PageAnon(page) || unlikely(split_huge_page(page))) {
> +		unsigned long pfn = page_to_pfn(page);
> +
> +		unlock_page(page);
> +		if (!PageAnon(page))
> +			pr_info("%s: %#lx: non anonymous thp\n", msg, pfn);
> +		else
> +			pr_info("%s: %#lx: thp split failed\n", msg, pfn);
> +		put_page(page);
> +		return -EBUSY;
> +	}
> +	unlock_page(page);
> +
> +	return 0;
> +}
> +
>  static int memory_failure_hugetlb(unsigned long pfn, int flags)
>  {
>  	struct page *p = pfn_to_page(pfn);
> @@ -1288,21 +1307,8 @@ int memory_failure(unsigned long pfn, int flags)
>  	}
>  
>  	if (PageTransHuge(hpage)) {
> -		lock_page(p);
> -		if (!PageAnon(p) || unlikely(split_huge_page(p))) {
> -			unlock_page(p);
> -			if (!PageAnon(p))
> -				pr_err("Memory failure: %#lx: non anonymous thp\n",
> -					pfn);
> -			else
> -				pr_err("Memory failure: %#lx: thp split failed\n",
> -					pfn);
> -			if (TestClearPageHWPoison(p))
> -				num_poisoned_pages_dec();
> -			put_page(p);
> +		if (try_to_split_thp_page(p, "Memory Failure") < 0)
>  			return -EBUSY;

Although this is not a cleanup thing, this failure path means that
hwpoison is handled (PG_hwpoison is marked), so action_result() should
be called.  I'll add a patch for this later.

Anyway, this cleanup patch looks fine to me.

Acked-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>

> -		}
> -		unlock_page(p);
>  		VM_BUG_ON_PAGE(!page_count(p), p);
>  		hpage = compound_head(p);
>  	}
> @@ -1801,19 +1807,9 @@ static int soft_offline_in_use_page(struct page *page)
>  	int mt;
>  	struct page *hpage = compound_head(page);
>  
> -	if (!PageHuge(page) && PageTransHuge(hpage)) {
> -		lock_page(page);
> -		if (!PageAnon(page) || unlikely(split_huge_page(page))) {
> -			unlock_page(page);
> -			if (!PageAnon(page))
> -				pr_info("soft offline: %#lx: non anonymous thp\n", page_to_pfn(page));
> -			else
> -				pr_info("soft offline: %#lx: thp split failed\n", page_to_pfn(page));
> -			put_page(page);
> +	if (!PageHuge(page) && PageTransHuge(hpage))
> +		if (try_to_split_thp_page(page, "soft offline") < 0)
>  			return -EBUSY;
> -		}
> -		unlock_page(page);
> -	}
>  
>  	/*
>  	 * Setting MIGRATE_ISOLATE here ensures that the page will be linked
> -- 
> 2.12.3
> 
> 
