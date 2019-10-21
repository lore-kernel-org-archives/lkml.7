Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6BFCA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1038C20873
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfJUJVn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 05:21:43 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:52023 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbfJUJVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 05:21:41 -0400
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x9L9LP3H000336
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 21 Oct 2019 18:21:25 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x9L9LPT4031056;
        Mon, 21 Oct 2019 18:21:25 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x9L9LNXx028916;
        Mon, 21 Oct 2019 18:21:25 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.152] [10.38.151.152]) by mail03.kamome.nec.co.jp with ESMTP id BT-MMP-84056; Mon, 21 Oct 2019 18:20:47 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC24GP.gisp.nec.co.jp ([10.38.151.152]) with mapi id 14.03.0439.000; Mon,
 21 Oct 2019 18:20:46 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Oscar Salvador <osalvador@suse.de>
CC:     "mhocko@kernel.org" <mhocko@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 14/16] mm,hwpoison: Return 0 if the page is
 already poisoned in soft-offline
Thread-Topic: [RFC PATCH v2 14/16] mm,hwpoison: Return 0 if the page is
 already poisoned in soft-offline
Thread-Index: AQHVhPYyXKqj3nxce0SU95ZyoSgHHadkQNcA
Date:   Mon, 21 Oct 2019 09:20:46 +0000
Message-ID: <20191021092046.GA19876@hori.linux.bs1.fc.nec.co.jp>
References: <20191017142123.24245-1-osalvador@suse.de>
 <20191017142123.24245-15-osalvador@suse.de>
In-Reply-To: <20191017142123.24245-15-osalvador@suse.de>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.96]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <5C2CE62D02FF7C4CA6ACEE42D9FC5D3F@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 04:21:21PM +0200, Oscar Salvador wrote:
> Currently, there is an inconsistency when calling soft-offline from
> different paths on a page that is already poisoned.
> 
> 1) madvise:
> 
>         madvise_inject_error skips any poisoned page and continues
>         the loop.
>         If that was the only page to madvise, it returns 0.
> 
> 2) /sys/devices/system/memory/:
> 
>         Whe calling soft_offline_page_store()->soft_offline_page(),
>         we return -EBUSY in case the page is already poisoned.
>         This is inconsistent with a) the above example and b)
>         memory_failure, where we return 0 if the page was poisoned.
> 
> Fix this by dropping the PageHWPoison() check in madvise_inject_error,
> and let soft_offline_page return 0 if it finds the page already poisoned.
> 
> Please, note that this represents an user-api change, since now the return
> error when calling soft_offline_page_store()->soft_offline_page() will be different.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Looks good to me.

Acked-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>

> ---
>  mm/madvise.c        | 3 ---
>  mm/memory-failure.c | 4 ++--
>  2 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 8a0b1f901d72..9ca48345ce45 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -887,9 +887,6 @@ static int madvise_inject_error(int behavior,
>  		 */
>  		put_page(page);
>  
> -		if (PageHWPoison(page))
> -			continue;
> -
>  		if (behavior == MADV_SOFT_OFFLINE) {
>  			pr_info("Soft offlining pfn %#lx at process virtual address %#lx\n",
>  				 pfn, start);
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 3d491c0d3f91..c038896bedf0 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1767,7 +1767,7 @@ static int __soft_offline_page(struct page *page)
>  		unlock_page(page);
>  		put_page(page);
>  		pr_info("soft offline: %#lx page already poisoned\n", pfn);
> -		return -EBUSY;
> +		return 0;
>  	}
>  
>  	if (!PageHuge(page))
> @@ -1866,7 +1866,7 @@ int soft_offline_page(struct page *page)
>  
>  	if (PageHWPoison(page)) {
>  		pr_info("soft offline: %#lx page already poisoned\n", pfn);
> -		return -EBUSY;
> +		return 0;
>  	}
>  
>  	get_online_mems();
> -- 
> 2.12.3
> 
> 
