Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D9BC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 17:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 754DF20872
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 17:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvgNB75X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501950AbfIXRbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 13:31:13 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33707 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730774AbfIXRbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 13:31:13 -0400
Received: by mail-wm1-f68.google.com with SMTP id r17so2104608wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 10:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=LL8ftQ0d2EQqhK1mSpuOYEUw7ofHsHcjJlXF2qrplCw=;
        b=DvgNB75XuqGGblo1ms9oDqpoBCZoTPlZr1rH7g56HqFDY+Gzsyp5DwLqYJnwzhUvF7
         Tbv6ld+xq53tIzVOCYlGyDrLZR1COb5YM/cdqupRGOoVKhAhG00mkFrrCp/A4gOC9rrx
         kOMsbNnMB8MjIhLYrc6grddJmohEZihZwvfI10mnCk71t7YSB9ROVDvWjZu0fFkaqw2N
         BuVSITikLaj+Gv/ERTU2P6ZJJsiZqD9cE6H03Yy65PHgBDEqBkjLWVuOWhh1QhwrkdSw
         eNFUO2P6nsWgY/gbnokrzfaXg5qXnb4ecFZncIUBsU1QzDJi3XcuDaLd2Jqa1ufgqkl2
         FdbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=LL8ftQ0d2EQqhK1mSpuOYEUw7ofHsHcjJlXF2qrplCw=;
        b=E2915zgnVRZBBp1vKF/0WdDI7e75P/ZiH/ptRdx2t9qVBBaSnZ187MI55JggoluGof
         3+fKST2GMD0wgNqB8xJPGIvVoamNVAjfuZB1T4XTIIDRj5JlpuESgoxO4G7bNQleK34I
         vHAFrqXs8jWKChz7o8n7/nx/BRwpQRODJ05Rk1o90JsT0HLLbyUnlVJWEGa0lgiTsiDv
         Mv400sOwDnJVJ3XC9fH7aUO1/Gb0IGLwtLr19O06q9YAPA+AJXEyLPe1XilYl0RcUt2y
         dNALf+umxQkB28o53ioiDA2IpCI2up/Sy2SehLNkJPNAYBcDQXvxlgGX1hLfV92Hk18q
         Jo/A==
X-Gm-Message-State: APjAAAU3z2Ew+7ND6eupi5sWOaN+shY5EgQ6bai3NLvAZcamM9B34a1s
        3notmjtkGu4VrE/7+toX344so9DWJ0SrMAiF5GQ=
X-Google-Smtp-Source: APXvYqxthEBNTtbpdPxhMlEv0yP/Mgg3wzFie/YO5Ei3cWHpB/XsyeSXNGOHLhbvk7R6/HiC09HcBNAQEjVE3Ae7Og0=
X-Received: by 2002:a1c:3281:: with SMTP id y123mr1297282wmy.118.1569346271157;
 Tue, 24 Sep 2019 10:31:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190923222403.22956-1-ndesaulniers@google.com>
In-Reply-To: <20190923222403.22956-1-ndesaulniers@google.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 24 Sep 2019 19:30:59 +0200
Message-ID: <CA+icZUX-2W9S1tnRgSmqAWUFqfv=kUqZFxo=+H-M1Kfj0pA6ag@mail.gmail.com>
Subject: Re: [PATCH] x86, realmode: explicitly set ENTRY in linker script
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 12:24 AM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> Linking with ld.lld via $ make LD=ld.lld produces the warning:
> ld.lld: warning: cannot find entry symbol _start; defaulting to 0x1000
>
> Linking with ld.bfd shows the default entry is 0x1000:
> $ readelf -h arch/x86/realmode/rm/realmode.elf | grep Entry
>   Entry point address:               0x1000
>
> While ld.lld is being pedantic, just set the entry point explicitly,
> instead of depending on the implicit default.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/216

Reported-by: Sedat Dilek <sedat.dilek@gmail.com> (seen on my first
steps when linking with LLD on x86-64)

> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  arch/x86/realmode/rm/realmode.lds.S | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/x86/realmode/rm/realmode.lds.S b/arch/x86/realmode/rm/realmode.lds.S
> index 3bb980800c58..2034f5f79bff 100644
> --- a/arch/x86/realmode/rm/realmode.lds.S
> +++ b/arch/x86/realmode/rm/realmode.lds.S
> @@ -11,6 +11,7 @@
>
>  OUTPUT_FORMAT("elf32-i386")
>  OUTPUT_ARCH(i386)
> +ENTRY(0x1000)
>
>  SECTIONS
>  {
> --
> 2.23.0.351.gc4317032e6-goog
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20190923222403.22956-1-ndesaulniers%40google.com.
