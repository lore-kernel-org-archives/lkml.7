Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A40C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 21:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D390206D5
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 21:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wTf08lNe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfLIVMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 16:12:48 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36064 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfLIVMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 16:12:47 -0500
Received: by mail-pf1-f196.google.com with SMTP id x184so6416917pfb.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 13:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=reyZZJheLd9yHQxDntXi/qlyLtQlfdLU5vTmTSU2J4w=;
        b=wTf08lNeP17+SN7FmdBXOMHbX47zfgrkLvREVS5gXOgqNTkW7U9Cch1XQfVdtEc2gg
         aA15kTWlGED0Hum556nKwbzPSZ5EaE4X6MGEueaj7Fi6Qf2Kl1yQtEOaa7LRyKmcV8gs
         BoFFOpT0JRzbBNq7FVQNPow/WgjFEiCVdYwIFQbWXYeI7iLuTtQs4HzlzkTrJ0fB26iv
         HaCAtSASApe9u958UOkUL/qCoc9ebU/VQmMKcH+gECZA2newVCGxrAi5qjtPLCV8WyXX
         blp+7DgHmrwGR2Oht2SHVZ8shW+/F7czJteB5NgIYPKJ+elPO390ybYmu8eTbz2MgtAs
         jQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=reyZZJheLd9yHQxDntXi/qlyLtQlfdLU5vTmTSU2J4w=;
        b=ZpnGSP5+InxDGQHwbEXxfIsr2B7ecnzD9ZSRUGxzF1xisC7i/mJ6tgS0gVSbt490IT
         6VXWJsWDHPcGThrgaXQCMUA7uGTCUCjKHxo9YAs8kP2SlrCxYJaQTQlwIS3NWrtLTZL6
         vlTZW5rP18Kfc4PJWLdjzftk1f+zhogHgrL/+lMdbi8Z39mfW99HRB85OnURzReUrPHe
         FfyRPucZ46jSDGsJ2D29a9Vc4ODJ7KzMROvxTLjScQZQ2tAOZHeAVj+3vuMhRIa1OB3n
         aX+awE6NeGM4phoCypLHAk+VykWbmh858+zKEdkV1ggqqXf/yZEGnVrcqr6tx4Kob7ef
         FOgw==
X-Gm-Message-State: APjAAAXMPE4Iy0kUDBVg2PHBKyOpt7MrNUds4J6xaojj1SaR0tMCDL04
        nIy2qJC15z/8j1u3B9baN+QUjVIWd727zs4ZhYvrcw==
X-Google-Smtp-Source: APXvYqwLGMPwEIVk+sSMIlstyIzR4bv6rsf8nn9gwB56VsbsfzQTut0FeK9yEhGwUb5Py3QiR4RBRkiRmZBRsJWcnXg=
X-Received: by 2002:a65:590f:: with SMTP id f15mr20500805pgu.381.1575925966701;
 Mon, 09 Dec 2019 13:12:46 -0800 (PST)
MIME-Version: 1.0
References: <20191209200338.12546-1-natechancellor@gmail.com>
In-Reply-To: <20191209200338.12546-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 9 Dec 2019 13:12:35 -0800
Message-ID: <CAKwvOdkWYqYD-036putggpCyq44xuLVsN9krzC98pmHoKe_0uw@mail.gmail.com>
Subject: Re: [PATCH] powerpc/44x: Adjust indentation in ibm4xx_denali_fixup_memsize
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 9, 2019 at 12:04 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> ../arch/powerpc/boot/4xx.c:231:3: warning: misleading indentation;
> statement is not part of the previous 'else' [-Wmisleading-indentation]
>         val = SDRAM0_READ(DDR0_42);
>         ^
> ../arch/powerpc/boot/4xx.c:227:2: note: previous statement is here
>         else
>         ^
>
> This is because there is a space at the beginning of this line; remove
> it so that the indentation is consistent according to the Linux kernel
> coding style and clang no longer warns.
>
> Fixes: d23f5099297c ("[POWERPC] 4xx: Adds decoding of 440SPE memory size to boot wrapper library")

ah, can even see it in the diff. Thanks for the patch.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> Link: https://github.com/ClangBuiltLinux/linux/issues/780
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  arch/powerpc/boot/4xx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/boot/4xx.c b/arch/powerpc/boot/4xx.c
> index 1699e9531552..00c4d843a023 100644
> --- a/arch/powerpc/boot/4xx.c
> +++ b/arch/powerpc/boot/4xx.c
> @@ -228,7 +228,7 @@ void ibm4xx_denali_fixup_memsize(void)
>                 dpath = 8; /* 64 bits */
>
>         /* get address pins (rows) */
> -       val = SDRAM0_READ(DDR0_42);
> +       val = SDRAM0_READ(DDR0_42);
>
>         row = DDR_GET_VAL(val, DDR_APIN, DDR_APIN_SHIFT);
>         if (row > max_row)
> --
> 2.24.0
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20191209200338.12546-1-natechancellor%40gmail.com.



-- 
Thanks,
~Nick Desaulniers
