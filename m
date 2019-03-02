Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3CAC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 00:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AAEF2083D
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 00:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHCp+GHH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfCBANN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 19:13:13 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38724 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfCBANN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 19:13:13 -0500
Received: by mail-ed1-f65.google.com with SMTP id h58so21513087edb.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 16:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y15bGOJo8xEfy54QkP7NJDbo2jkEDGfMsy+7oWVtBMs=;
        b=iHCp+GHHtz+XBl+/cPsLwBHPAyZyR1O27SdzyvcV5Ef3N7qN6jH9hf55gBWUzNErPJ
         6aBz7ljhARPYoq3IgF5qjB6fuP74VIqX4wBgb7GbpNC5K/oMtbQtiW34FDOXnpGmUJne
         opZ0Rf64sEbgkY7fRECPgoDHbQZjllwwIzWJNS1+0kuGtbtU+81xHUTVPWpYukmbkI85
         Mypp9n3z0i8Tqp+QJ99J507oup2ZSFkrQWPJJJn0xPanNpa77xkKnbw0Qse/sdaXIKmQ
         gn6Fv67tPxYIB+QQ3K9jhDKI6OR57CHyHf7H3+nYI77bfYKUx1hBP5k52L6skXweEOAV
         Cuyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y15bGOJo8xEfy54QkP7NJDbo2jkEDGfMsy+7oWVtBMs=;
        b=axa5QmlFqhhq76/oKynKFqxPerchUPAt090A3YGoF+/dxIptI6kq5XNOZZPPdrCrRa
         XVr0Wl+EH9TE4anlRPkCn/J3yWVVhSWA5CWpe0X709MX88kLijbTVPfj5yzD2IxNMWTg
         UkIXy0aL+M0WIxr+XrJup9cHQX+pGAr96euwHR3BhARhjLunsfyEFgjH+M9/L0fkPbTR
         ywaJjZKhviCMLRKpi6ueRCUCNiWufejKeVBV0xRRwHRd/N86HLS0B0yd/roCFQ/+f48z
         TxmK90ViP+3f3K2NHupDpyWFeo4EZfMnyBdJGBuqsjwAQs/PJoJJT2CCGHLdwMereRjR
         RPIQ==
X-Gm-Message-State: APjAAAVHk6D1qxbxQB31uLzHDMhHjMUckpHLnPpIDO+UimheUkpu3j9N
        +J8Uo61szEoZlOguIR0gylYxpeeZ7Fc=
X-Google-Smtp-Source: APXvYqz+b9u1iUZSC1T68DUhDuN638u6wY0ZIoeniokPf0i436GjSPxpeWXGEZT8+QXhYEXB8HIODg==
X-Received: by 2002:a17:906:5944:: with SMTP id g4mr4800183ejr.105.1551485591130;
        Fri, 01 Mar 2019 16:13:11 -0800 (PST)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id b22sm6284227edb.5.2019.03.01.16.13.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 01 Mar 2019 16:13:10 -0800 (PST)
Date:   Fri, 1 Mar 2019 17:13:08 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     bp@alien8.de, niravd@google.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/boot: clean up headers
Message-ID: <20190302001308.GA8146@archlinux-ryzen>
References: <20190302000715.130116-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190302000715.130116-1-ndesaulniers@google.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 04:07:14PM -0800, Nick Desaulniers wrote:
> The inclusion of <linux/kernel.h> was causing issue as the definition of
> __arch_hweight64 from arch/x86/include/asm/arch_hweight.h eventually gets
> included. The definition is problematic when compiled with -m16 (all code
> in arch/x86/boot/ is) as the "D" inline assembly constraint is rejected
> by both compilers when passed an argument of type long long (regardless
> of signedness, anything smaller is fine).
> 
> Because GCC performs inlining before semantic analysis, and
> __arch_hweight64 is dead in this translation unit, GCC does not report
> any issues at compile time.  Clang does the semantic analysis in the
> front end, before inlining (run in the middle) can determine the code is
> dead. I consider this another case of PR33587, which I think we can do
> more work to solve.
> 
> It turns out that arch/x86/boot/string.c doesn't actually need
> linux/kernel.h, simply linux/limits.h and linux/compiler.h. Include them,
> and sort the headers alphabetically.
> 
> Link: https://bugs.llvm.org/show_bug.cgi?id=33587
> Link: https://github.com/ClangBuiltLinux/linux/issues/347
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
> Note that this only regresses for us on linux-next (not mainline).
> 
>  arch/x86/boot/string.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/boot/string.c b/arch/x86/boot/string.c
> index 315a67b8896b..f149316116d0 100644
> --- a/arch/x86/boot/string.c
> +++ b/arch/x86/boot/string.c
> @@ -12,10 +12,11 @@
>   * Very basic string functions
>   */
>  
> -#include <linux/types.h>
> -#include <linux/kernel.h>
> -#include <linux/errno.h>
>  #include <asm/asm.h>
> +#include <linux/compiler.h>
> +#include <linux/errno.h>
> +#include <linux/limits.h>
> +#include <linux/types.h>
>  #include "ctype.h"
>  #include "string.h"
>  
> -- 
> 2.21.0.352.gf09ad66450-goog
> 
