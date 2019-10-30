Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0813BCA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 18:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C738D2087E
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 18:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kIHCplPZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfJ3Sj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 14:39:27 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43024 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfJ3Sj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 14:39:27 -0400
Received: by mail-pf1-f196.google.com with SMTP id 3so2167552pfb.10
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 11:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aUJD4GCXt/o2VxCREdNL6McCQEUc/pMgJK8nDGNwgVI=;
        b=kIHCplPZvVokWODcdtzNeC7Oq0vauMgurxyR8RFxsJolUEbxierUtJKKW1C0+Qo/+8
         ZAuLreJULmAMkvL4/7BK3B3YaCCy+Gm+CmNdx60XvPuCpeIpMLuHgrRzE8sXMRXamaWn
         0sKiX0pfIVYmH57P1BmPX7Bf+s4HlH9Q5yYic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aUJD4GCXt/o2VxCREdNL6McCQEUc/pMgJK8nDGNwgVI=;
        b=rMdO1DfHht50H5ou0FrU/k8NOas2gI4TBk1jVnC0TR46BHw2eWTaggGo6q5pPChpUQ
         4rLgTwW/j6Ah5x0n0yBqguxIFB188aTHv6NRDuxi8T+5qLc+1TVX3yhshXT/8Xazv//0
         3+X3puEUfh/4r75glKfYRgGcIrV+sVODIw7rKvRz6nWADoFQ79933W6TmviaQE5NYWXU
         +xr9rJTV++icCyI7Bb5EbqS2YN2eEPOJgWbQZnNiC73uMam7CyHq0dE9y+9l1UPKHUyX
         jMolLVJUln6EyPWtZrRppFgfF96vUnYWIIUml38axzm/ZErbLic8di+4y0bSffIHqeXL
         T6rQ==
X-Gm-Message-State: APjAAAWOT6QCvZokvcZokEA8vz/QtVEdaF+AexmadszGyxENyTfHTu63
        Ogcod3Ecdlt/G9J2TJKJN6BMgg==
X-Google-Smtp-Source: APXvYqyjRubEDRmq/ua1/FcH/xqv4Fnpk0545hhlOVOcNlNiJQRgevFFbGMkSok+sGHydnRXdsUbpg==
X-Received: by 2002:a65:64d4:: with SMTP id t20mr908440pgv.181.1572460766003;
        Wed, 30 Oct 2019 11:39:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h189sm511245pge.88.2019.10.30.11.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 11:39:25 -0700 (PDT)
Date:   Wed, 30 Oct 2019 11:39:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>
Subject: Re: [PATCH v4 06/10] lib/refcount: Move saturation warnings out of
 line
Message-ID: <201910301139.A1A3E4F997@keescook>
References: <20191030143035.19440-1-will@kernel.org>
 <20191030143035.19440-7-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030143035.19440-7-will@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 02:30:31PM +0000, Will Deacon wrote:
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
> 
> A side-effect of this change is that we now only get one warning per
> refcount saturation type, rather than one per problematic call-site.
> 
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Elena Reshetova <elena.reshetova@intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Will Deacon <will@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  include/linux/refcount.h | 39 ++++++++++++++++++++-------------------
>  lib/refcount.c           | 28 ++++++++++++++++++++++++++++
>  2 files changed, 48 insertions(+), 19 deletions(-)
> 
> diff --git a/include/linux/refcount.h b/include/linux/refcount.h
> index e3b218d669ce..1cd0a876a789 100644
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
> @@ -154,10 +164,8 @@ static inline __must_check bool refcount_add_not_zero(int i, refcount_t *r)
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
> @@ -182,11 +190,10 @@ static inline void refcount_add(int i, refcount_t *r)
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
> @@ -253,10 +260,8 @@ static inline __must_check bool refcount_sub_and_test(int i, refcount_t *r)
>  		return true;
>  	}
>  
> -	if (unlikely(old < 0 || old - i < 0)) {
> -		refcount_set(r, REFCOUNT_SATURATED);
> -		WARN_ONCE(1, "refcount_t: underflow; use-after-free.\n");
> -	}
> +	if (unlikely(old < 0 || old - i < 0))
> +		refcount_warn_saturate(r, REFCOUNT_SUB_UAF);
>  
>  	return false;
>  }
> @@ -291,12 +296,8 @@ static inline __must_check bool refcount_dec_and_test(refcount_t *r)
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
> index 3a534fbebdcc..8b7e249c0e10 100644
> --- a/lib/refcount.c
> +++ b/lib/refcount.c
> @@ -8,6 +8,34 @@
>  #include <linux/spinlock.h>
>  #include <linux/bug.h>
>  
> +#define REFCOUNT_WARN(str)	WARN_ONCE(1, "refcount_t: " str ".\n")
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
> +		break;
> +	default:
> +		REFCOUNT_WARN("unknown saturation event!?");
> +	}
> +}
> +EXPORT_SYMBOL(refcount_warn_saturate);
> +
>  /**
>   * refcount_dec_if_one - decrement a refcount if it is 1
>   * @r: the refcount
> -- 
> 2.24.0.rc0.303.g954a862665-goog
> 

-- 
Kees Cook
