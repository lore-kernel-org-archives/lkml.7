Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E58C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 06:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FF6020866
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 06:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fd/jFlYC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfFEGU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 02:20:57 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:54782 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfFEGU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 02:20:57 -0400
Received: by mail-it1-f195.google.com with SMTP id h20so1821770itk.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 23:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AtqHgH8AzfqBusRXColLPq524pdyprOlKwBMhdGimOs=;
        b=fd/jFlYC3NKCnlc10GNS/xXh9Mu8jhirQNjNqRwQ/3oWrENyNxUUvb7jukL+cJ8nOr
         0PeUOMwn3wjpv/MP5l8IeFEc0KjgSwJV3wmT9pj+2q3d2pK7p9SB/8qyp96wR2qKgU4Q
         lHisNH/bC4oxyGBh7finpaMpQbGtUd6Pj1Ta8jwitm8bDl/sz7aKwT8U1p4pVBLDuIy6
         GtLWeIUC6V+BH2bVSMY2thRJoBHSUgRdwNFSTaoagBpYEVDTR/BNQTG2E4hodA0SCwrA
         xYQJuqb7vjP3YuWW8Xz7JUeWts1b5tamD2b2r8o+XYdXTBEnmgL6TFu04xyJuea0hTPt
         i/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AtqHgH8AzfqBusRXColLPq524pdyprOlKwBMhdGimOs=;
        b=EO+pwaXWUBZZu2kkNOlKRovex+vleJCtIZ5GMhh+Q5V3T+BenpDMWZmxD1Wl3HO4Pg
         QI6PXucE357ntD77SS16UOqzU05/GEUhjXI675+GcSAkS7NQUxfeuNYzY6Tf68WfzXWI
         fDCUSRYC/q3JoC5bMYt4g24sPOpOz1lpwfCaDw3yRVH9MKT3Fhun2y+gTV3tI9XHC+Pp
         ++cOY8xKxxjwOGCCbEZWNG/WMRHPplutbAfyZmO5XWRY7PR0MTAiNCwz8ym+9yBseNpX
         EtHJ89N9UFqcpQvnIi5Z5HVukNEs89kDZOg++rNbq40dA2z3HRbWV2aTHcHFoGPllI0c
         BlQw==
X-Gm-Message-State: APjAAAWDXleNS0VY7l+rMOSa/8txpyqX7qLjdCG0qDYfSvUtCET3b3Ps
        46Q0aSZrPUnO03chma2zG7ZUsFqI60JbqPFY8Hjdug==
X-Google-Smtp-Source: APXvYqzlkR0mSGTo4qj6zCzfKyaEQVD5KunaL/j2L2/jGoUBjIoSTeh8jGEtvNNxjrzNn8XcY+RumpVbcR/wbdYMgp0=
X-Received: by 2002:a24:6b86:: with SMTP id v128mr18073861itc.104.1559715656168;
 Tue, 04 Jun 2019 23:20:56 -0700 (PDT)
MIME-Version: 1.0
References: <201906042224.42A2CCB2BE@keescook>
In-Reply-To: <201906042224.42A2CCB2BE@keescook>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 5 Jun 2019 08:20:44 +0200
Message-ID: <CAKv+Gu8m=6BgqfjrvrGEjX1Z3=W-YJhv-jrDXhC5+EoRuOG3qA@mail.gmail.com>
Subject: Re: [PATCH] lib/test_stackinit: Handle Clang auto-initialization pattern
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jun 2019 at 07:25, Kees Cook <keescook@chromium.org> wrote:
>
> While the gcc plugin for automatic stack variable initialization (i.e.
> CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL) performs initialization with
> 0x00 bytes, the Clang automatic stack variable initialization (i.e.
> CONFIG_INIT_STACK_ALL) uses various type-specific patterns that are
> typically 0xAA. Therefore the stackinit selftest has been fixed to check
> that bytes are no longer the test fill pattern of 0xFF (instead of looking
> for bytes that have become 0x00). This retains the test coverage for the
> 0x00 pattern of the gcc plugin while adding coverage for the mostly 0xAA
> pattern of Clang.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  lib/test_stackinit.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/lib/test_stackinit.c b/lib/test_stackinit.c
> index e97dc54b4fdf..2d7d257a430e 100644
> --- a/lib/test_stackinit.c
> +++ b/lib/test_stackinit.c
> @@ -12,7 +12,7 @@
>
>  /* Exfiltration buffer. */
>  #define MAX_VAR_SIZE   128
> -static char check_buf[MAX_VAR_SIZE];
> +static u8 check_buf[MAX_VAR_SIZE];
>
>  /* Character array to trigger stack protector in all functions. */
>  #define VAR_BUFFER      32
> @@ -106,9 +106,18 @@ static noinline __init int test_ ## name (void)                    \
>                                                                 \
>         /* Fill clone type with zero for per-field init. */     \
>         memset(&zero, 0x00, sizeof(zero));                      \
> +       /* Clear entire check buffer for 0xFF overlap test. */  \
> +       memset(check_buf, 0x00, sizeof(check_buf));             \
>         /* Fill stack with 0xFF. */                             \
>         ignored = leaf_ ##name((unsigned long)&ignored, 1,      \
>                                 FETCH_ARG_ ## which(zero));     \
> +       /* Verify all bytes overwritten with 0xFF. */           \
> +       for (sum = 0, i = 0; i < target_size; i++)              \
> +               sum += (check_buf[i] != 0xFF);                  \
> +       if (sum) {                                              \
> +               pr_err(#name ": leaf fill was not 0xFF!?\n");   \
> +               return 1;                                       \
> +       }                                                       \
>         /* Clear entire check buffer for later bit tests. */    \
>         memset(check_buf, 0x00, sizeof(check_buf));             \
>         /* Extract stack-defined variable contents. */          \
> @@ -126,9 +135,9 @@ static noinline __init int test_ ## name (void)                     \
>                 return 1;                                       \
>         }                                                       \
>                                                                 \
> -       /* Look for any set bits in the check region. */        \
> -       for (i = 0; i < sizeof(check_buf); i++)                 \
> -               sum += (check_buf[i] != 0);                     \
> +       /* Look for any bytes still 0xFF in check region. */    \
> +       for (sum = 0, i = 0; i < target_size; i++)              \
> +               sum += (check_buf[i] == 0xFF);                  \
>                                                                 \
>         if (sum == 0)                                           \
>                 pr_info(#name " ok\n");                         \
> @@ -162,13 +171,13 @@ static noinline __init int leaf_ ## name(unsigned long sp,        \
>          * Keep this buffer around to make sure we've got a     \
>          * stack frame of SOME kind...                          \
>          */                                                     \
> -       memset(buf, (char)(sp && 0xff), sizeof(buf));           \
> +       memset(buf, (char)(sp & 0xff), sizeof(buf));            \
>         /* Fill variable with 0xFF. */                          \
>         if (fill) {                                             \
>                 fill_start = &var;                              \
>                 fill_size = sizeof(var);                        \
>                 memset(fill_start,                              \
> -                      (char)((sp && 0xff) | forced_mask),      \
> +                      (char)((sp & 0xff) | forced_mask),       \
>                        fill_size);                              \
>         }                                                       \
>                                                                 \
> --
> 2.17.1
>
>
> --
> Kees Cook
