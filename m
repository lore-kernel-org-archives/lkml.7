Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10941C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC47D216F4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qvuLlLh1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbfFYQOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 12:14:12 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59802 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbfFYQOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 12:14:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=aQdBGxvRtV3egQNaV+FgFAJvHnZYb/6wNg9IAnKU1fI=; b=qvuLlLh1NXFNjoeyUfJT/hi+94
        WTuVlmRGFjslST4ex4tYK4VR8G6yTKRRQsTmzMjXW2m2u9Pnsipli062XEj2gaKuYHXv+C6wQvm7s
        4waDgFgJ+vjHXJYWfFyV9GhqtQGCKcqmsOmJ0OTzr0FFA6Ml8iAn1NW1bLtofc6fgU/Ls0+eV/Bq0
        QpiLpxRahNcufJDql1o20ZVePf4Dp44HjNBjsxdG/cN9JwtDp6zOjt8wJFOIOJqN9WkGHtBcNVnDA
        xBNfc+BIY84Q/tTshz95tlobEoQ0+e/kUKxR5nDeXAesa5iFi/Hk8oZGR+8rakjo9Nokq2HVYJn9h
        0g4z0GIA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hfo58-0003Pg-Ce; Tue, 25 Jun 2019 16:14:06 +0000
Subject: Re: [PATCH 1/2] timekeeping: add missing non-_ns functions for fast
 accessors
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>
References: <20190625081912.14813-1-Jason@zx2c4.com>
 <20190625081912.14813-2-Jason@zx2c4.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a4591ed8-37e3-37f3-13e6-f067d93cbb25@infradead.org>
Date:   Tue, 25 Jun 2019 09:14:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190625081912.14813-2-Jason@zx2c4.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/25/19 1:19 AM, Jason A. Donenfeld wrote:
> Previously there was no analogue to get proper ktime_t versions of the
> fast variety of ktime invocations. This commit makes the interface
> uniform with the other accessors.
> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
>  Documentation/core-api/timekeeping.rst |  7 +++-
>  include/linux/timekeeping.h            | 28 ++++++++++++--
>  kernel/time/timekeeping.c              | 52 +++++++++++++-------------
>  3 files changed, 55 insertions(+), 32 deletions(-)
> 

Hi,
There are a few minor documentation problems here.  See below.

> diff --git a/Documentation/core-api/timekeeping.rst b/Documentation/core-api/timekeeping.rst
> index 20ee447a50f3..29d38a86faac 100644
> --- a/Documentation/core-api/timekeeping.rst
> +++ b/Documentation/core-api/timekeeping.rst
> @@ -94,7 +94,7 @@ different format depending on what is required by the user:
>  	down the seconds to the full seconds of the last timer tick
>  	using the respective reference.
>  
> -Coarse and fast_ns access
> +Coarse and fast access
>  -------------------------

The "underline ---" length should match the heading length.

>  
>  Some additional variants exist for more specialized cases:

> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index d911c8470149..db0081a14b90 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c

> @@ -497,47 +496,46 @@ EXPORT_SYMBOL_GPL(ktime_get_raw_fast_ns);
>   * partially updated.  Since the tk->offs_boot update is a rare event, this
>   * should be a rare occurrence which postprocessing should be able to handle.
>   */
> -u64 notrace ktime_get_boot_fast_ns(void)
> +ktime_t notrace ktime_get_boottime_fast(void)
>  {
>  	struct timekeeper *tk = &tk_core.timekeeper;
>  
> -	return (ktime_get_mono_fast_ns() + ktime_to_ns(tk->offs_boot));
> +	return ktime_add(ktime_get_mono_fast(), tk->offs_boot);
>  }
> -EXPORT_SYMBOL_GPL(ktime_get_boot_fast_ns);
> +EXPORT_SYMBOL_GPL(ktime_get_boottime_fast);
>  
>  
>  /*
> - * See comment for __ktime_get_fast_ns() vs. timestamp ordering
> + * See comment for __ktime_get_fast() vs. timestamp ordering
>   */
> -static __always_inline u64 __ktime_get_real_fast_ns(struct tk_fast *tkf)
> +static __always_inline ktime_t __ktime_get_real_fast(struct tk_fast *tkf)
>  {
>  	struct tk_read_base *tkr;
>  	unsigned int seq;
> -	u64 now;
> +	ktime_t now;
>  
>  	do {
>  		seq = raw_read_seqcount_latch(&tkf->seq);
>  		tkr = tkf->base + (seq & 0x01);
> -		now = ktime_to_ns(tkr->base_real);
> -
> -		now += timekeeping_delta_to_ns(tkr,
> +		now = ktime_add_ns(tkr->base_real,
> +			timekeeping_delta_to_ns(tkr,
>  				clocksource_delta(
>  					tk_clock_read(tkr),
>  					tkr->cycle_last,
> -					tkr->mask));
> +					tkr->mask)));
>  	} while (read_seqcount_retry(&tkf->seq, seq));
>  
>  	return now;
>  }
>  
>  /**
> - * ktime_get_real_fast_ns: - NMI safe and fast access to clock realtime.
> + * ktime_get_real_fast: - NMI safe and fast access to clock realtime.

The function name line should not contain a ':' character.
(I know, you didn't change that.)

>   */
> -u64 ktime_get_real_fast_ns(void)
> +ktime_t ktime_get_real_fast(void)
>  {
> -	return __ktime_get_real_fast_ns(&tk_fast_mono);
> +	return __ktime_get_real_fast(&tk_fast_mono);
>  }
> -EXPORT_SYMBOL_GPL(ktime_get_real_fast_ns);
> +EXPORT_SYMBOL_GPL(ktime_get_real_fast);
>  
>  /**
>   * halt_fast_timekeeper - Prevent fast timekeeper from accessing clocksource.
> 

thnx.
-- 
~Randy
