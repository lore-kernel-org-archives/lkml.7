Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A16EC5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28D10217F5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v72MaS+E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732412AbfKFRYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 12:24:03 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41787 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729511AbfKFRYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 12:24:02 -0500
Received: by mail-pl1-f194.google.com with SMTP id d29so5387751plj.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 09:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L53qqYgrERAW9zaeKnbt4pvYYWM8Rc69Hp8/MLhvFjk=;
        b=v72MaS+Eu9HFi/1smcs3U+ySpiW17mD19bxUrw5gG+asTflYwmedpdz4s0FUyTFCd5
         3p7OeuNdwHq+g8JFXMjjfCl+tDbVgurujeHlCYsl+aBK3eLlVFJAH3mqc9eZQ94V6/jK
         xVeTnxAcF7yftlusIKNK4+s1JD8AhZj/+IxCklMbHQXaT51NUgCP4eK1XIAG6I4QFVYn
         tM1NPpbyXipFd5PDYhtj8H3rXAiECWEUz02v3Fw8QtHmr8waP6ra6lMnq90hCGvr57Wo
         SM5tGCTfnGhjlfpNXIaNxudhT0CSv6Wk36Lo8Csj8KXhKAiLzcXgM3400v8XtkYz1gQf
         Kwdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L53qqYgrERAW9zaeKnbt4pvYYWM8Rc69Hp8/MLhvFjk=;
        b=PeJqKk5nUSqix/Yl8Mdc8qrSE0brvBRh6uio/Y6Zmdmaoq4DlnozGaFH6rQCjuPPd6
         wE9PbQrEDEuYIxJcdYdwVCtr7W4YzIp3lz/sALbsiPGD6MDgLiuSTFpMt2PiwOkMc3cD
         +ZXAhuLhrA4VDDvfAdiYinMcNmOiZe08NoncqbFkoVY+NSFgdzm30UdePqt8XM4o4cV5
         Z1jHklrJM2geVI74WGzSFa6MrMN1MVInu6FPDwSkas4AF0XmG231wjO9VVUpkITjlBjt
         cOK8PeDbSh0c+nFZmv4gnzTRhE55X4pUHzq8Gd2Ff77NYtLKXO+YxDsHqaFYuiO2uSOr
         cgXA==
X-Gm-Message-State: APjAAAUr9MApZDpLQgy2LtnaBcJFF4tnd9JwUNm8YFtnw4AZc5ZSPXKD
        0NYvHdl6jKKXXA7UCq4OLt87/g5eOcC57G3TbLOWQA==
X-Google-Smtp-Source: APXvYqynE69PDzBmnxAcpCSDpD5OLy3nG+kKXCFWcE9LIrPqpUc2NRBDhQF9t4cdd7V54ZHoU7WfujSb0m2Cs/rVRn4=
X-Received: by 2002:a17:902:8498:: with SMTP id c24mr1141086plo.223.1573061041582;
 Wed, 06 Nov 2019 09:24:01 -0800 (PST)
MIME-Version: 1.0
References: <CAKwvOdmSo=BWGnaVeejez6K0Tukny2niWXrr52YvOPDYnXbOsg@mail.gmail.com>
 <20191106120629.28423-1-ilie.halip@gmail.com>
In-Reply-To: <20191106120629.28423-1-ilie.halip@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 6 Nov 2019 09:23:50 -0800
Message-ID: <CAKwvOdnJR3vbHd6Z0eLK9CppABWFL4E0Rjh6SzDN6U6mShS2qQ@mail.gmail.com>
Subject: Re: [PATCH V2] x86/boot: explicitly place .eh_frame after .rodata
To:     Ilie Halip <ilie.halip@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 6, 2019 at 4:06 AM Ilie Halip <ilie.halip@gmail.com> wrote:
>
> When using GCC as compiler and LLVM's lld as linker, linking
> setup.elf fails:
>       LD      arch/x86/boot/setup.elf
>     ld.lld: error: init sections too big!
>
> This happens because ld.lld has different rules for placing
> orphan sections (i.e. sections not mentioned in a linker script)
> compared to ld.bfd.
>
> Particularly, in this case, the merged .eh_frame section is
> placed before __end_init, which triggers an assert in the script.
>
> Explicitly place this section after .rodata, in accordance with
> ld.bfd's behavior.
>
> Signed-off-by: Ilie Halip <ilie.halip@gmail.com>
> Link: https://github.com/ClangBuiltLinux/linux/issues/760

Thanks for following up with a v2.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
> Changes in V2:
>  * removed wildcard for input sections (.eh_frame* -> .eh_frame)
>
>  arch/x86/boot/setup.ld | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/x86/boot/setup.ld b/arch/x86/boot/setup.ld
> index 0149e41d42c2..30ce52635cd0 100644
> --- a/arch/x86/boot/setup.ld
> +++ b/arch/x86/boot/setup.ld
> @@ -25,6 +25,7 @@ SECTIONS
>
>         . = ALIGN(16);
>         .rodata         : { *(.rodata*) }
> +       .eh_frame       : { *(.eh_frame) }
>
>         .videocards     : {
>                 video_cards = .;
> --
> 2.17.1
>


-- 
Thanks,
~Nick Desaulniers
