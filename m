Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C51C4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 07:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A19F2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 07:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VMXKg+nE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfFZHGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 03:06:51 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46683 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfFZHGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 03:06:50 -0400
Received: by mail-io1-f67.google.com with SMTP id i10so959544iol.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 00:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u94vxob2SrQiWiR32vSHPUe28bBMbdJvX+quOFiRIe4=;
        b=VMXKg+nEEH/ksApacPol6+RHMDCcfwTm4prt5zxds86nFMfCPWBTSvEuWqzWnBG7nL
         qWum/stOqDRcHLID6xVa7dNuzwab00uJa9PkJ2BQzDbMUmAQOuAn4A8mk/TxQscdlpgq
         834fvN3flZR8EelVrtjGBx2LuBDglQK4z0K7goZ3aEyTKDH6LdiKWkduh/GuLpxLV+ob
         fCB2wKCcY2AQvEQ2TaZ9v+YxD8OH75E1f/wIC/7g9NziySm7uRmUHlz7UHUdYND2U7sO
         LnztQg4Blru/dtWMGH6RtUy8KSlUaMRwhcWbtn0N2MYUOdGGFOpolh4RhrJ30O4yq+2e
         8XkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u94vxob2SrQiWiR32vSHPUe28bBMbdJvX+quOFiRIe4=;
        b=PcNKRwwR0Wjhp/PeAWPtq6BjXdCoSzQYoG8XWCQvQqzhHfjlrlGvch1zVJVDS6CicR
         cviSGSObcXNJ48LwJAO3aNmkOHwO6XLSuqM2vyc+34216RbiCAFpueivu41OO5RcxFRf
         wFt77rbwGB/64vBdsKgzxE/e0deVKbxO5GnP7Ij/RuyQVAlASDbSZ+gygILv7EsV7jDE
         jwEYdbtfxQF4C+Q4EbdhC9OG3HsCQLIJHDjTnoMCBNi8WftA7MhYgIfCXY5tjNBebtgI
         zROroO4awrmF8084byoAFkgHKYqjQnuREt8tRofXGEiFuBvEpDIgpPWTm670NUIdVLbK
         pHlg==
X-Gm-Message-State: APjAAAUEnnI7cQIiEa9/laaeWrJr2Al8PLQigmDF9sDorMklyQ9iFr/v
        vKqV+ojrugHCykYvk/baLuOdTHbEbWC/DwTvxBfaLQ==
X-Google-Smtp-Source: APXvYqwifeDzdNlUZpwjBY8J7RLuaCite3HcilCUVCyG1sd4TgJIOv4iw3avZEGOcpBykyAsl8NAL4ezvnGpNEDepfc=
X-Received: by 2002:a5d:9d97:: with SMTP id 23mr3432834ion.204.1561532810008;
 Wed, 26 Jun 2019 00:06:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190626042017.54773-1-natechancellor@gmail.com>
In-Reply-To: <20190626042017.54773-1-natechancellor@gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 26 Jun 2019 09:06:36 +0200
Message-ID: <CAKv+Gu_jhKsQN-pPyXQn5iFh1wikJirGZ4vxsME7oLJTUO6MmA@mail.gmail.com>
Subject: Re: [PATCH] arm64/efi: Mark __efistub_stext_offset as an absolute
 symbol explicitly
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Fangrui Song <maskray@google.com>,
        Peter Smith <peter.smith@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jun 2019 at 06:20, Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> After r363059 and r363928 in LLVM, a build using ld.lld as the linker
> with CONFIG_RANDOMIZE_BASE enabled fails like so:
>
> ld.lld: error: relocation R_AARCH64_ABS32 cannot be used against symbol
> __efistub_stext_offset; recompile with -fPIC
>
> Fangrui and Peter figured out that ld.lld is incorrectly considering
> __efistub_stext_offset as a relative symbol because of the order in
> which symbols are evaluated. _text is treated as an absolute symbol
> and stext is a relative symbol, making __efistub_stext_offset a
> relative symbol.
>
> Adding ABSOLUTE will force ld.lld to evalute this expression in the
> right context and does not change ld.bfd's behavior. ld.lld will
> need to be fixed but the developers do not see a quick or simple fix
> without some research (see the linked issue for further explanation).
> Add this simple workaround so that ld.lld can continue to link kernels.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/561
> Link: https://github.com/llvm/llvm-project/commit/025a815d75d2356f2944136269aa5874721ec236
> Link: https://github.com/llvm/llvm-project/commit/249fde85832c33f8b06c6b4ac65d1c4b96d23b83
> Debugged-by: Fangrui Song <maskray@google.com>
> Debugged-by: Peter Smith <peter.smith@linaro.org>
> Suggested-by: Fangrui Song <maskray@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  arch/arm64/kernel/image.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/kernel/image.h b/arch/arm64/kernel/image.h
> index 04ca08086d35..9a2d2227907c 100644
> --- a/arch/arm64/kernel/image.h
> +++ b/arch/arm64/kernel/image.h
> @@ -67,7 +67,7 @@
>
>  #ifdef CONFIG_EFI
>
> -__efistub_stext_offset = stext - _text;
> +__efistub_stext_offset = ABSOLUTE(stext - _text);
>
>  /*
>   * The EFI stub has its own symbol namespace prefixed by __efistub_, to
> --
> 2.22.0
>
