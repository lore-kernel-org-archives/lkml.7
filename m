Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589CFC432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 08:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D86F20872
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 08:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442817AbfIYIhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 04:37:21 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2716 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405350AbfIYIhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 04:37:20 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D8E29B19EFCEC1C85424;
        Wed, 25 Sep 2019 16:37:18 +0800 (CST)
Received: from [127.0.0.1] (10.57.88.168) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Wed, 25 Sep 2019
 16:37:12 +0800
Subject: Re: [PATCH] tty:vt: Add check the return value of kzalloc to avoid
 oops
To:     Nicolas Pitre <nico@fluxnic.net>
CC:     Greg KH <gregkh@linuxfoundation.org>, <penberg@cs.helsinki.fi>,
        <jslaby@suse.com>, <textshell@uchuujin.de>, <sam@ravnborg.org>,
        <daniel.vetter@ffwll.ch>, <mpatocka@redhat.com>,
        <ghalat@redhat.com>, <linux-kernel@vger.kernel.org>,
        <yangyingliang@huawei.com>, <yuehaibing@huawei.com>,
        <zengweilin@huawei.com>
References: <1568884695-56789-1-git-send-email-nixiaoming@huawei.com>
 <20190919092933.GA2684163@kroah.com>
 <nycvar.YSQ.7.76.1909192251210.24536@knanqh.ubzr>
 <20190920060426.GA473496@kroah.com>
 <bee63793-e9f4-ecc4-7966-765207009c75@huawei.com>
 <nycvar.YSQ.7.76.1909222347410.24536@knanqh.ubzr>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Message-ID: <0a21cb45-d67b-ac3f-7fcb-de29ca28fbeb@huawei.com>
Date:   Wed, 25 Sep 2019 16:37:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <nycvar.YSQ.7.76.1909222347410.24536@knanqh.ubzr>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.57.88.168]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/9/23 11:50, Nicolas Pitre wrote:
> On Sat, 21 Sep 2019, Xiaoming Ni wrote:
> 
>> @ Nicolas Pitre
>> Can I make a v2 patch based on your advice ?
>> Or you will submit a patch for "GFP_WONTFAIL" yourself ?
> 
> Here's a patch implementing what I had in mind. This is compile tested 
> only.
> 
> ----- >8
> 
> Subject: [PATCH] mm: add __GFP_WONTFAIL and GFP_ONBOOT
> 
> Some memory allocations are very unlikely to fail during system boot.
> Because of that, the code often doesn't bother to check for allocation
> failure, but this gets reported anyway.
> 
> As an alternative to adding code to check for NULL that has almost no
> chance of ever being exercised, let's use a GFP flag to identify those
> cases and panic the kernel if allocation failure ever occurs.
> 
> Conversion of one such instance is also included.
> 
> Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
> 
.....
....

>  /**
> @@ -285,6 +293,9 @@ struct vm_area_struct;
>   * available and will not wake kswapd/kcompactd on failure. The _LIGHT
>   * version does not attempt reclaim/compaction at all and is by default used
>   * in page fault path, while the non-light is used by khugepaged.
> + *
> + * %GFP_ONBOOT is for relatively small allocations that are not expected
> + * to fail while the system is booting.
>   */
>  #define GFP_ATOMIC	(__GFP_HIGH|__GFP_ATOMIC|__GFP_KSWAPD_RECLAIM)
>  #define GFP_KERNEL	(__GFP_RECLAIM | __GFP_IO | __GFP_FS)
> @@ -300,6 +311,7 @@ struct vm_area_struct;
>  #define GFP_TRANSHUGE_LIGHT	((GFP_HIGHUSER_MOVABLE | __GFP_COMP | \
>  			 __GFP_NOMEMALLOC | __GFP_NOWARN) & ~__GFP_RECLAIM)
>  #define GFP_TRANSHUGE	(GFP_TRANSHUGE_LIGHT | __GFP_DIRECT_RECLAIM)
> +#define GFP_ONBOOT	(GFP_NOWAIT | __GFP_WONTFAIL)
>  

Isn't it better to bind GFP_ONBOOT and GFP_NOWAIT?
Can be not GFP_NOWAIT when applying for memory at boot time

>  /* Convert GFP flags to their corresponding migrate type */
>  #define GFP_MOVABLE_MASK (__GFP_RECLAIMABLE|__GFP_MOVABLE)
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index ff5484fdbd..36dee09f7f 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4625,6 +4625,14 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  fail:
>  	warn_alloc(gfp_mask, ac->nodemask,
>  			"page allocation failure: order:%u", order);
> +	if (gfp_mask & __GFP_WONTFAIL) {

Is it more intuitive to use __GFP_DIE_IF_FAIL as the flag name?

> +		/*
> +		 * The assumption was wrong. This is never supposed to happen.
> +		 * Caller most likely won't check for a returned NULL either.
> +		 * So the only reasonable thing to do is to pannic.
> +		 */
> +		panic("Failed to allocate memory despite GFP_WONTFAIL\n");
> +	}
>  got_pg:
>  	return page;
>  }
> 
> .
> 

thanks
Niaoming Ni

