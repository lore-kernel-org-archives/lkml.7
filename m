Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5E4C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 00:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A2DF20663
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 00:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pQBT652E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfCEAQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 19:16:02 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45226 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfCEAQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 19:16:02 -0500
Received: by mail-pf1-f195.google.com with SMTP id v21so4203692pfm.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 16:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lXYrBu5vz3W4l2HgNcPBzMuXU43JYbEUVXCXcZMYMLE=;
        b=pQBT652EOC8u10iYUgwwfPkBiglFGWCel/mpuJj4L68eBpBOVYjcFOvEuAopkSzJ/z
         zUfg1v8YlbtKGiBaE2tFPmyv2PngYfF1a4hqpPiWrlilQOskezV56gE4ganzcbr8ktAH
         bTK/QJQ4e+ICnvxmwBBHCmCBWb05jcbjo2GCXtUKOEhPPU720HmujfEjerva2/LSnULt
         1T9x9u1PW+I14qfy9d4cIxEo8Ej3h2/qsav+cELmzRWVREsA9hwBR/JsV+xV/zAGuSKt
         2HDSgysqbNY/hsJNW9TRr4Zd/+9IzG4kycwCUCLWGjuiUbv6yfsWPpmnFAh8HVqVK2v9
         vX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lXYrBu5vz3W4l2HgNcPBzMuXU43JYbEUVXCXcZMYMLE=;
        b=lz2WXHSzCJyJnQ6rzSK9j5y45mZ+7ptjYjN6DqqDYePgusBG6De8EAPGQ2t1n5fih7
         zJ0FVWjHIKhLIP0D44qNYH73B2Tua66SbTaJ9Wy4/WIeD0vdEeb6C6FPYHeZv90tU8pr
         tH5ej7j/9FJybkQuq92o6b889UUoR4lMEhAiOX1QwJpZ69+QEPmLwEhpWTO5xfYHZHnH
         TvoZrIRr1fZzF2tbkuhFTsJPICehv5LigPDs/VikxbE4Ak3YnT19wIkZNjMwHI4vzKtW
         rLqo3Vik0E6tqWY1xKeKnufM2dEx7f9cYMTSRuWPiNOZWvIBXsEpDclkcOtUp79zJRY1
         A3xA==
X-Gm-Message-State: AHQUAuaznQ4Xpt5tmY2QCS2ApAbEE3I5IuENPHcECLvC5bBMsXNbQWsA
        wI81eRSFYeN/6PWVxHJyvg14+D0Q874Facw+l7zbXQ==
X-Google-Smtp-Source: AHgI3IYyVzEErTujIFAOOkEv59VwNltFgrId46NTJq3VKPzDP4gZcsarZ169z0DFLtYdjFQYFVKz9KDNZynVhZud08k=
X-Received: by 2002:a62:398d:: with SMTP id u13mr22534509pfj.32.1551744960708;
 Mon, 04 Mar 2019 16:16:00 -0800 (PST)
MIME-Version: 1.0
References: <20190305095100.243a40e3@canb.auug.org.au> <20190305001221.31343-1-ndesaulniers@google.com>
In-Reply-To: <20190305001221.31343-1-ndesaulniers@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 4 Mar 2019 16:15:49 -0800
Message-ID: <CAKwvOdmCnwcUCNT0q=+g9sjTdg_tv3WMC6wWyOhkzDPqFMUhbA@mail.gmail.com>
Subject: Re: [PATCH v3] x86/boot: clean up headers
To:     Borislav Petkov <bp@alien8.de>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        =?UTF-8?Q?Nirav_Dav=C3=A9?= <niravd@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 4, 2019 at 4:12 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
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

Well, should have cut that out of the commit message too in V3...sigh.
Boris assuming everyone's ok with this patch; can you just drop this
sentence from the commit message should you apply the patch (or shall
I send a v4)?

>
> Link: https://bugs.llvm.org/show_bug.cgi?id=33587
> Link: https://github.com/ClangBuiltLinux/linux/issues/347
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> Tested-by: Nathan Chancellor <natechancellor@gmail.com>
> Suggested-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
> Changes V2 -> V3:
> * keep linux/types.h
>
> Changes V1 -> V2:
> * Add Reviewed, Tested, Suggested tags.
> * Drop linux/types.h; it's included in linux/limits.h.
>
>  arch/x86/boot/string.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/boot/string.c b/arch/x86/boot/string.c
> index 315a67b8896b..90154df8f125 100644
> --- a/arch/x86/boot/string.c
> +++ b/arch/x86/boot/string.c
> @@ -13,8 +13,9 @@
>   */
>
>  #include <linux/types.h>
> -#include <linux/kernel.h>
> +#include <linux/compiler.h>
>  #include <linux/errno.h>
> +#include <linux/limits.h>
>  #include <asm/asm.h>
>  #include "ctype.h"
>  #include "string.h"
> --
> 2.21.0.352.gf09ad66450-goog
>


-- 
Thanks,
~Nick Desaulniers
