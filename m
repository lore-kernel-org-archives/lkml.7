Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5170CC4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 07:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28F002085A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 07:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uSxFPFz1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfFZHHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 03:07:14 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36083 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfFZHHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 03:07:13 -0400
Received: by mail-io1-f67.google.com with SMTP id h6so1080216ioh.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 00:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YO3NTtUqQg+q5y+jLevvg6DdA+MqWwydBFISViHdvIg=;
        b=uSxFPFz1oOhSaCmWOKp7072jHy7BtOTB5oQPPcoEsjkMzC0GDSdCUibZ0FnOAbKoN+
         V22GqVPuxH+X7LFD3UGeDwKZzHTfEdw2lSv1IxhOB6vL7VEKGE3Eeps4viQAFq8brg8/
         WHPQs+sZh/FXV83NvXHnx2R06RkWQLPoUDTz5HJiZTbMXv/uqAfA6ji7dkWrHBij0l5N
         Ngxq0uvzA2UK9pMGLxHQekggDgkrXY7BIgDg3nNPPF5jgXNbTaIwFPQvTLcEYv41Ks7D
         vmIytaUPzzz3nObxwbEkIppJTv02PwMaGz5QG3iCow7IL/VmILcJ00jcYIGeXtpmi9kT
         fRrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YO3NTtUqQg+q5y+jLevvg6DdA+MqWwydBFISViHdvIg=;
        b=gzTi70iwoEDyvyniI9Ay7Svkwl/g/vEwIwAJpl4EB8nCr7e53z1xaaHPXlA/Jhw6xm
         DZ7ZTWPbV7rRTbThDwnqCTrU8t/5Y+l3gn7f7pZgA1bWewkK4dwjKeT0bR445vrUU43G
         tsBJf19bdNSxXnm6vXx4ffem8haASIxrwHhXBFmbshRXv4p/CZNin3brbn7UmwclCLmi
         icU7ABl//cbZhJ4VpWPC/6Uk0J/hGHcWu0AVJ544KJQi5Hhu+AU4ET8vU4ujEEOv6/O9
         X/HRth9HJ+yXH9CQd1F5y/zTP2Qnpi585Lx+J5UwCn+5yd4/LD16ZVG3j2RAuPWDF7aU
         PQog==
X-Gm-Message-State: APjAAAVLru9cfDno3tpvc7ESFnkNvNNqC5JWn4VZoAhGonvD2jgHUzMP
        V7UyPmLroUcX0a2zv+HJTbNMHKqb/UuRjYnkF+tZo1DlmFc=
X-Google-Smtp-Source: APXvYqwUVeURJFgq5+tDgeunYYmLvd6FqPHhlPb/ql/shK6VJGGdE9qcDN4/pinr9Th11F4v8t/w1seE5/vbWzXl9qw=
X-Received: by 2002:a5d:9d83:: with SMTP id 3mr3210336ion.65.1561532832763;
 Wed, 26 Jun 2019 00:07:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190626042017.54773-1-natechancellor@gmail.com>
In-Reply-To: <20190626042017.54773-1-natechancellor@gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 26 Jun 2019 09:07:00 +0200
Message-ID: <CAKv+Gu85xLD+-CqwgNQtC3Hr9z2R5bm5th8_zd_jMSzA3JE8og@mail.gmail.com>
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

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

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
