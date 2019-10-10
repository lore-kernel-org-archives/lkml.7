Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10580C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 20:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C040C20B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 20:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BJ8jq8Pf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfJJUsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 16:48:24 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46300 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfJJUsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 16:48:24 -0400
Received: by mail-pg1-f194.google.com with SMTP id b8so4390769pgm.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 13:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=r6xu82oQYUmtXhHP2fj0ZiVY9ale3ywYgTv6f+0xCAw=;
        b=BJ8jq8Pfl1utUrIw1vqmwneXHSBS7ob/3iITh+TKLSqXnx+M+xHg97Ph4I3dvwE7SV
         cadPYKJcUQ3LSJxlTuhh0Sci74/VSIPBK3ronOh/etMIZ59gDHDc1PkepuJ0qgQ1Tj/M
         sBPfH3rVqCuqUcGBCqXQ9FDwV3FcNLvXT1W3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r6xu82oQYUmtXhHP2fj0ZiVY9ale3ywYgTv6f+0xCAw=;
        b=spy4Tcogog18E8erZNjF8DpMzhu4F33S5gUcFFvE9pH28jvZ9Vbs0UK7eDt0iBcUea
         wVzd7+eAM/tZWfz+Tj7/TQbsCcezI2Z2UFa5MEp+hfz2gHokv4zNR/ChlyYEkzul67Oh
         0nMkkTdzam42BCo2QYR+jzmAsv4l4CqokKJSHByPZjDWXrGs83bbEEWqFQ/AXjK7I8dR
         J0N5SatphIZqsnMeaEm3EOyeM8x/V5YxHcT5BuLbENwPOMBxLZKcN1Qlgmfd73aW+eWu
         r3LeAE5GEeNSsrnAdO7gNy74wRefk3UKa/GyLBU0oOnIVFA1SrEMjvsSpUb0VFDT04DQ
         Ae5A==
X-Gm-Message-State: APjAAAVK9or7QPPdAiEwBQw4TWIvSzrYorpyd3kaZWwsJtNE7hImISkM
        CQixLLMcDDcdIr0BvcBhuYdRRw==
X-Google-Smtp-Source: APXvYqxvB0FIdlsXJRoXPU4pel7YJkYadJIh05jyA2/pUuJ3PxuCDUaZCYmQwns2vmwdV+uRW2RExQ==
X-Received: by 2002:a17:90a:9201:: with SMTP id m1mr13762509pjo.42.1570740502878;
        Thu, 10 Oct 2019 13:48:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 7sm5780851pgx.26.2019.10.10.13.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 13:48:22 -0700 (PDT)
Date:   Thu, 10 Oct 2019 13:48:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>
Subject: Re: [PATCH v3 06/10] lib/refcount: Move saturation warnings out of
 line
Message-ID: <201910101342.B6B4B3B6@keescook>
References: <20191007154703.5574-1-will@kernel.org>
 <20191007154703.5574-7-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007154703.5574-7-will@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 04:46:59PM +0100, Will Deacon wrote:
> Having the refcount saturation and warnings inline bloats the text,
> despite the fact that these paths should never be executed in normal
> operation.
> 
> Move the refcount saturation and warnings out of line to reduce the
> image size when refcount_t checking is enabled. Relative to an x86_64
> defconfig, the sizes reported by bloat-o-meter are:
> 
>  # defconfig+REFCOUNT_FULL, inline saturation (i.e. before this patch)
>  Total: Before=14762076, After=14915442, chg +1.04%
> 
>  # defconfig+REFCOUNT_FULL, out-of-line saturation (i.e. after this patch)
>  Total: Before=14762076, After=14835497, chg +0.50%

The downside of this change is that this means we get one warning per
refcount_saturation_type, where as before it was once per refcount
usage. I think, ultimately, this is okay, but it is a behavioral change
that might be worth pointing out.

> 
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Elena Reshetova <elena.reshetova@intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  include/linux/refcount.h | 39 ++++++++++++++++++++-------------------
>  lib/refcount.c           | 28 ++++++++++++++++++++++++++++
>  2 files changed, 48 insertions(+), 19 deletions(-)
> 
> diff --git a/include/linux/refcount.h b/include/linux/refcount.h
> index 7f9aa6511142..40ddff74a96c 100644
> --- a/include/linux/refcount.h
> +++ b/include/linux/refcount.h
> @@ -23,6 +23,16 @@ typedef struct refcount_struct {
>  
>  #define REFCOUNT_INIT(n)	{ .refs = ATOMIC_INIT(n), }
>  
> +enum refcount_saturation_type {
> +	REFCOUNT_ADD_NOT_ZERO_OVF,
> +	REFCOUNT_ADD_OVF,
> +	REFCOUNT_ADD_UAF,
> +	REFCOUNT_SUB_UAF,
> +	REFCOUNT_DEC_LEAK,
> +};
> +
> +void refcount_warn_saturate(refcount_t *r, enum refcount_saturation_type t);
> +
>  /**
>   * refcount_set - set a refcount's value
>   * @r: the refcount
> @@ -116,10 +126,8 @@ static inline __must_check bool refcount_add_not_zero(int i, refcount_t *r)
>  			break;
>  	} while (!atomic_try_cmpxchg_relaxed(&r->refs, &old, old + i));
>  
> -	if (unlikely(old < 0 || old + i < 0)) {
> -		refcount_set(r, REFCOUNT_SATURATED);
> -		WARN_ONCE(1, "refcount_t: saturated; leaking memory.\n");
> -	}
> +	if (unlikely(old < 0 || old + i < 0))
> +		refcount_warn_saturate(r, REFCOUNT_ADD_NOT_ZERO_OVF);
>  
>  	return old;
>  }
> @@ -144,11 +152,10 @@ static inline void refcount_add(int i, refcount_t *r)
>  {
>  	int old = atomic_fetch_add_relaxed(i, &r->refs);
>  
> -	WARN_ONCE(!old, "refcount_t: addition on 0; use-after-free.\n");
> -	if (unlikely(old <= 0 || old + i <= 0)) {
> -		refcount_set(r, REFCOUNT_SATURATED);
> -		WARN_ONCE(old, "refcount_t: saturated; leaking memory.\n");
> -	}
> +	if (unlikely(!old))
> +		refcount_warn_saturate(r, REFCOUNT_ADD_UAF);
> +	else if (unlikely(old < 0 || old + i < 0))
> +		refcount_warn_saturate(r, REFCOUNT_ADD_OVF);
>  }
>  
>  /**
> @@ -215,10 +222,8 @@ static inline __must_check bool refcount_sub_and_test(int i, refcount_t *r)
>  		return true;
>  	}
>  
> -	if (unlikely(old - i < 0)) {
> -		refcount_set(r, REFCOUNT_SATURATED);
> -		WARN_ONCE(1, "refcount_t: underflow; use-after-free.\n");
> -	}
> +	if (unlikely(old - i < 0))
> +		refcount_warn_saturate(r, REFCOUNT_SUB_UAF);
>  
>  	return false;
>  }
> @@ -253,12 +258,8 @@ static inline __must_check bool refcount_dec_and_test(refcount_t *r)
>   */
>  static inline void refcount_dec(refcount_t *r)
>  {
> -	int old = atomic_fetch_sub_release(1, &r->refs);
> -
> -	if (unlikely(old <= 1)) {
> -		refcount_set(r, REFCOUNT_SATURATED);
> -		WARN_ONCE(1, "refcount_t: decrement hit 0; leaking memory.\n");
> -	}
> +	if (unlikely(atomic_fetch_sub_release(1, &r->refs) <= 1))
> +		refcount_warn_saturate(r, REFCOUNT_DEC_LEAK);
>  }
>  #else /* CONFIG_REFCOUNT_FULL */
>  
> diff --git a/lib/refcount.c b/lib/refcount.c
> index 3a534fbebdcc..6a61d39f9390 100644
> --- a/lib/refcount.c
> +++ b/lib/refcount.c
> @@ -8,6 +8,34 @@
>  #include <linux/spinlock.h>
>  #include <linux/bug.h>
>  
> +#define REFCOUNT_WARN(str)	WARN_ONCE(1, "refcount_t: " str ".\n")

This define seems like overkill for just adding a prefix to 5 uses...

> +
> +void refcount_warn_saturate(refcount_t *r, enum refcount_saturation_type t)
> +{
> +	refcount_set(r, REFCOUNT_SATURATED);
> +
> +	switch (t) {
> +	case REFCOUNT_ADD_NOT_ZERO_OVF:
> +		REFCOUNT_WARN("saturated; leaking memory");
> +		break;
> +	case REFCOUNT_ADD_OVF:
> +		REFCOUNT_WARN("saturated; leaking memory");
> +		break;
> +	case REFCOUNT_ADD_UAF:
> +		REFCOUNT_WARN("addition on 0; use-after-free");
> +		break;
> +	case REFCOUNT_SUB_UAF:
> +		REFCOUNT_WARN("underflow; use-after-free");
> +		break;
> +	case REFCOUNT_DEC_LEAK:
> +		REFCOUNT_WARN("decrement hit 0; leaking memory");

Even the longest doesn't line wrap:

		WARN_ONCE(1, "refcount_t: decrement hit 0; leaking memory\n");

> +		break;
> +	default:
> +		WARN_ON(1);

This deserves a string too, yes?

		WARN_ONCE(1, "refcount_t: unknown saturation event!?\n");

> +	}
> +}
> +EXPORT_SYMBOL(refcount_warn_saturate);
> +
>  /**
>   * refcount_dec_if_one - decrement a refcount if it is 1
>   * @r: the refcount
> -- 
> 2.23.0.581.g78d2f28ef7-goog
> 

Otherwise, okay, I grudgingly accept the loss of warnings when running
the lkdtm tests in order to gain back some text size... :)

-- 
Kees Cook
