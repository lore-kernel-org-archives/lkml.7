Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11236C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC9E6206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a0zmfpyQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbfG2QeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 12:34:05 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44132 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbfG2QeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 12:34:05 -0400
Received: by mail-pf1-f194.google.com with SMTP id t16so28274823pfe.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 09:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BpM9K2QhdEENlhQPUarvaYH4zigc2UW19IimoJ0sMK0=;
        b=a0zmfpyQjsGpnehgA8NjD1AqvkqpiZ99xxb1Ju1w6XyVfRgxo18Sc5PEvAftIyEqzG
         PStxyZI3TbhdbpzC/6YSu9Ldh7F9yfVXHQeIeq1Riu7RbWMNARSwI6Hy8l+WY+SLTd50
         aAMYip6GO2FeGAQ3Crceyw/fx7Ajh3LliQpcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BpM9K2QhdEENlhQPUarvaYH4zigc2UW19IimoJ0sMK0=;
        b=bgPxVYt6pE/lUwbW0Xv0QPq6g5HN8/GRXQzLrSaobBkzyNTSBvUkGDw4m9wbEMaQQE
         w1rDU83XECv4jbwlaLhuUdXC7ZbVt8lNBxWrgIKuDbGPo7qnMUbGep2uj7a53Woxk7SK
         HEhtejXGj9CB/ltGPAC2n/7uiqXXR8Bo64VqJEcIZveaJErekzPAteYLdj63+fPhIPRF
         DVtgYWrDM7X0OnouhzAD5wYwNS1O+WO+vhEIevFGaE/JUCDG6BGjNtPtUE2dsp3Lm4HC
         VTnTSiBgVSp9732aDbjxQPYKZHKImMsCjXn8Xm36+YfRaWplI9oAsRq64BXMBS9J8Y4G
         b4kA==
X-Gm-Message-State: APjAAAXG3iruOeXYjMJe2rzv8FbZs+cTyZbuwYmgm6/P/epb0gy8O6io
        wN+Bjbv/HT90t9RVkq8EqjL1hQ==
X-Google-Smtp-Source: APXvYqwDy5PcobqhWiy0r9d8BjQy2ju5SIgDvvK97K1QD+PtAEQS0V47PZex4n5iTBVMe4RgCQyAwg==
X-Received: by 2002:a63:ff20:: with SMTP id k32mr105391293pgi.445.1564418044320;
        Mon, 29 Jul 2019 09:34:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g1sm102525135pgg.27.2019.07.29.09.34.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jul 2019 09:34:03 -0700 (PDT)
Date:   Mon, 29 Jul 2019 09:34:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] ARM/hw_breakpoint: Mark expected switch fall-throughs
Message-ID: <201907290934.6C8AE8C@keescook>
References: <20190728231651.GA22123@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190728231651.GA22123@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2019 at 06:16:51PM -0500, Gustavo A. R. Silva wrote:
> Mark switch cases where we are expecting to fall through.
> 
> This patch fixes the following warnings:
> 
> arch/arm/kernel/hw_breakpoint.c: In function 'hw_breakpoint_arch_parse':
> arch/arm/kernel/hw_breakpoint.c:609:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if (hw->ctrl.len == ARM_BREAKPOINT_LEN_2)
>       ^
> arch/arm/kernel/hw_breakpoint.c:611:2: note: here
>   case 3:
>   ^~~~
> arch/arm/kernel/hw_breakpoint.c:613:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if (hw->ctrl.len == ARM_BREAKPOINT_LEN_1)
>       ^
> arch/arm/kernel/hw_breakpoint.c:615:2: note: here
>   default:
>   ^~~~~~~
> arch/arm/kernel/hw_breakpoint.c: In function 'arch_build_bp_info':
> arch/arm/kernel/hw_breakpoint.c:544:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if ((hw->ctrl.type != ARM_BREAKPOINT_EXECUTE)
>       ^
> arch/arm/kernel/hw_breakpoint.c:547:2: note: here
>   default:
>   ^~~~~~~
> In file included from include/linux/kernel.h:11,
>                  from include/linux/list.h:9,
>                  from include/linux/preempt.h:11,
>                  from include/linux/hardirq.h:5,
>                  from arch/arm/kernel/hw_breakpoint.c:16:
> arch/arm/kernel/hw_breakpoint.c: In function 'hw_breakpoint_pending':
> include/linux/compiler.h:78:22: warning: this statement may fall through [-Wimplicit-fallthrough=]
>  # define unlikely(x) __builtin_expect(!!(x), 0)
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> include/asm-generic/bug.h:136:2: note: in expansion of macro 'unlikely'
>   unlikely(__ret_warn_on);     \
>   ^~~~~~~~
> arch/arm/kernel/hw_breakpoint.c:863:3: note: in expansion of macro 'WARN'
>    WARN(1, "Asynchronous watchpoint exception taken. Debugging results may be unreliable\n");
>    ^~~~
> arch/arm/kernel/hw_breakpoint.c:864:2: note: here
>   case ARM_ENTRY_SYNC_WATCHPOINT:
>   ^~~~
> arch/arm/kernel/hw_breakpoint.c: In function 'core_has_os_save_restore':
> arch/arm/kernel/hw_breakpoint.c:910:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if (oslsr & ARM_OSLSR_OSLM0)
>       ^
> arch/arm/kernel/hw_breakpoint.c:912:2: note: here
>   default:
>   ^~~~~~~
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/arm/kernel/hw_breakpoint.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
> index af8b8e15f589..b0c195e3a06d 100644
> --- a/arch/arm/kernel/hw_breakpoint.c
> +++ b/arch/arm/kernel/hw_breakpoint.c
> @@ -544,6 +544,7 @@ static int arch_build_bp_info(struct perf_event *bp,
>  		if ((hw->ctrl.type != ARM_BREAKPOINT_EXECUTE)
>  			&& max_watchpoint_len >= 8)
>  			break;
> +		/* Else, fall through */
>  	default:
>  		return -EINVAL;
>  	}
> @@ -608,10 +609,12 @@ int hw_breakpoint_arch_parse(struct perf_event *bp,
>  		/* Allow halfword watchpoints and breakpoints. */
>  		if (hw->ctrl.len == ARM_BREAKPOINT_LEN_2)
>  			break;
> +		/* Else, fall through */
>  	case 3:
>  		/* Allow single byte watchpoint. */
>  		if (hw->ctrl.len == ARM_BREAKPOINT_LEN_1)
>  			break;
> +		/* Else, fall through */
>  	default:
>  		ret = -EINVAL;
>  		goto out;
> @@ -861,6 +864,7 @@ static int hw_breakpoint_pending(unsigned long addr, unsigned int fsr,
>  		break;
>  	case ARM_ENTRY_ASYNC_WATCHPOINT:
>  		WARN(1, "Asynchronous watchpoint exception taken. Debugging results may be unreliable\n");
> +		/* Fall through */
>  	case ARM_ENTRY_SYNC_WATCHPOINT:
>  		watchpoint_handler(addr, fsr, regs);
>  		break;
> @@ -909,6 +913,7 @@ static bool core_has_os_save_restore(void)
>  		ARM_DBG_READ(c1, c1, 4, oslsr);
>  		if (oslsr & ARM_OSLSR_OSLM0)
>  			return true;
> +		/* Else, fall through */
>  	default:
>  		return false;
>  	}
> -- 
> 2.22.0
> 

-- 
Kees Cook
