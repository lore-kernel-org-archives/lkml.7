Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14A9C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 03:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B30DC22DD3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 03:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qkBxCppP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfHUDoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 23:44:18 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43322 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfHUDoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 23:44:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mKEAQVe8pGeZG2unL0rDaPgFTJavZFuc/xTAFuOwVBE=; b=qkBxCppP0eq7zZvXrM0k7tNLaT
        KiYXt2hUP+V1+XDENHP5LdPNjJ6lDzjdcZwvIRdwFUJZSQTQl2trfzaXOH2uTVNlK2yBGJmDyPI++
        LcEkyb2sZoub5EvgflUfqufUQJcfAd/vvI6GrTdILYov7xeZQxD3ceyv4ZBvfz0RiZRbYslm87e2+
        Mu3CVD5KxG7U2EGL6KpD2/mBKKJX99ZIHP8WcCeD2ozCtdOmxUDzfHvh6AuJvbVdLd61q4DVwLCat
        8WqheE4qMG3np+1xCLI+Og6+EDCQgTrIYAn3F0zEJj/eGDqsF5qQ4H98BklKkCwH60J9OZkpBrB64
        Z11N/cBQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=[192.168.1.17])
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i0HXi-0000zD-Ih; Wed, 21 Aug 2019 03:44:14 +0000
Subject: Re: [PATCH] drm/amd/display: Fix 32-bit divide error in
 wait_for_alt_mode
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20190820235713.3429-1-natechancellor@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <fdb89dea-8da7-12af-fc73-aa3c13929e83@infradead.org>
Date:   Tue, 20 Aug 2019 20:44:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190820235713.3429-1-natechancellor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/19 4:57 PM, Nathan Chancellor wrote:
> When building arm32 allyesconfig:
> 
> ld.lld: error: undefined symbol: __aeabi_uldivmod
>>>> referenced by dc_link.c
>>>> gpu/drm/amd/display/dc/core/dc_link.o:(wait_for_alt_mode) in archive drivers/built-in.a
>>>> referenced by dc_link.c
>>>> gpu/drm/amd/display/dc/core/dc_link.o:(wait_for_alt_mode) in archive drivers/built-in.a
> 
> time_taken_in_ns is of type unsigned long long so we need to use div_u64
> to avoid this error.
> 
> Fixes: b5b1f4554904 ("drm/amd/display: Enable type C hotplug")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> index f2d78d7b089e..8634923b4444 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> @@ -721,7 +721,7 @@ bool wait_for_alt_mode(struct dc_link *link)
>  			time_taken_in_ns = dm_get_elapse_time_in_ns(
>  				link->ctx, finish_timestamp, enter_timestamp);
>  			DC_LOG_WARNING("Alt mode entered finished after %llu ms\n",
> -				       time_taken_in_ns / 1000000);
> +				       div_u64(time_taken_in_ns, 1000000));
>  			return true;
>  		}
>  
> @@ -730,7 +730,7 @@ bool wait_for_alt_mode(struct dc_link *link)
>  	time_taken_in_ns = dm_get_elapse_time_in_ns(link->ctx, finish_timestamp,
>  						    enter_timestamp);
>  	DC_LOG_WARNING("Alt mode has timed out after %llu ms\n",
> -			time_taken_in_ns / 1000000);
> +			div_u64(time_taken_in_ns, 1000000));
>  	return false;
>  }
>  
> 


-- 
~Randy
