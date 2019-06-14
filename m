Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3641C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 07:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7A28217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 07:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VeS3CU0G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfFNHDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 03:03:03 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46807 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfFNHDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 03:03:02 -0400
Received: by mail-io1-f68.google.com with SMTP id i10so3412465iol.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 00:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/e9SMaz1f2hGhr+Y7ePFxQlAt1pAXhkHDxZGScVnsP0=;
        b=VeS3CU0GVfEu7mUzCPUp6p8noRpmTbKdsRVKGt5bZ4jZnOSQhpuqS+ezrT+pak6Dc4
         wCCOwBgDRwBJPwMdJdXl9ISTJZgvJVhwnxtLKKyovc07NM/cjyPDPQsrrEtSfVvR1bDA
         IAuZZgXXVBUlis5movc1J9Nxn7jJoc9wK1V2yrB0jG32i+tZ9ii9CKS4mszok4ieLBvk
         Rk1EBY/iZaFkhvgzNS3AsIW2B6tVwziphPKYyJbMNQQs5ynzTSn874Hu8rrAePxMF/c4
         UpbX4ImEi2jtEVWL0lAhtd8KupAEgjqL/1GHGIjqMO0WgUSDYfVw0w6ecfBdH+3Par36
         fWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/e9SMaz1f2hGhr+Y7ePFxQlAt1pAXhkHDxZGScVnsP0=;
        b=CQrirEk94jY+YxAqB5UbliRK8dtCgqCu3R4CKit99q2467hakdBgH/24/6hIh0sXEj
         jsp6eXMgsoXRH9bJ2wl5e6WlIG7k/sML0CDTr2aAfjL6MF284z9gMlrNxEbV+4t/KleK
         XdBqLtUqcNdmk8r9W6Obq/bzpXsbIbKjnL/muhy8sIPS0pYx2Fx9hna4Gqu+Hq+KrpDv
         a5J2U9bTEASAIFK4JUgmN7NpyFIJUW2+Kp2OpSIcM6forXmbdqy2ghF2x1ryq44oeAcX
         JKYMikW4H9+Y7k/S039b2FQ32tc2mYvfJx8Dqf3E/1Pdvw93lLtGRCF45T2iEou5WOXu
         vsxQ==
X-Gm-Message-State: APjAAAVPxHiNP3Zt5fFaAlefv8gs9sgGvLHHUFKrXPFb2pM0OFqA6Tvm
        0QzY3/nC5nSvRCK9eRGuTl4rSL8TGfbLpQt2Ag5oFg==
X-Google-Smtp-Source: APXvYqy6ncGT/KFf173rk/8qVGA0xxyZvKYmkEWhVq/Wy6GUm3QlOI5jun6ArLYaraXYK9V3vC277oAE7HAUOelPlDY=
X-Received: by 2002:a5e:820a:: with SMTP id l10mr5570290iom.283.1560495781891;
 Fri, 14 Jun 2019 00:03:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190614025932.533-1-f.fainelli@gmail.com>
In-Reply-To: <20190614025932.533-1-f.fainelli@gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 14 Jun 2019 09:02:49 +0200
Message-ID: <CAKv+Gu8U1=Yxo7Mw6WsJbe82sRpjAq91HGW5XJi77ee+=BkGeA@mail.gmail.com>
Subject: Re: [PATCH] arm64: Allow user selection of ARM64_MODULE_PLTS
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jun 2019 at 04:59, Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> Make ARM64_MODULE_PLTS a selectable Kconfig symbol, since some people
> might have very big modules spilling out of the dedicated module area
> into vmalloc. Help text is copied from the ARM 32-bit counterpart.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/arm64/Kconfig | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 697ea0510729..36befe987b73 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1418,8 +1418,20 @@ config ARM64_SVE
>           KVM in the same kernel image.
>
>  config ARM64_MODULE_PLTS
> -       bool
> +       bool "Use PLTs to allow module memory to spill over into vmalloc area"
>         select HAVE_MOD_ARCH_SPECIFIC
> +       help
> +         Allocate PLTs when loading modules so that jumps and calls whose
> +         targets are too far away for their relative offsets to be encoded
> +         in the instructions themselves can be bounced via veneers in the
> +         module's PLT. This allows modules to be allocated in the generic
> +         vmalloc area after the dedicated module memory area has been
> +         exhausted. The modules will use slightly more memory, but after
> +         rounding up to page size, the actual memory footprint is usually
> +         the same.
> +
> +         Disabling this is usually safe for small single-platform
> +         configurations. If unsure, say y.
>

I don't mind adding this, but it makes sense to add an explanation why
KASLR enables this. E.g.,

"""
When running with address space randomization (KASLR), the module
region itself may be too far away for ordinary relative jumps and
calls, and so in that case, module PLTs are required and cannot be
disabled.
"""

>  config ARM64_PSEUDO_NMI
>         bool "Support for NMI-like interrupts"
> --
> 2.17.1
>
