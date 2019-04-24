Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E2BC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F5C9206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t9Vz1mfd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729897AbfDXG5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 02:57:18 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35354 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfDXG5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 02:57:18 -0400
Received: by mail-ed1-f66.google.com with SMTP id y67so14913348ede.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 23:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DNh0ufsiWetZMwuUMmUtgMWb+K7Ya3sJmdkxiGc9vsI=;
        b=t9Vz1mfdXifqgLblOsvyZ1SWzKZagINGMwdZibtbwtHuTN60r0OH9mzyS/Rkj5Z8KW
         Liy33hB5eabCZQ6ug1VCulshe3XraSh2QVicwEoV5Oce/QtL4hoJ77LsKYrQ3TE5kfuu
         LRgG2lVeQm4DM3F379pVtDAl0n8Gu6V4vlHWjK8Ky9ZTTE+yqNyTLUe/H4ww5V4R1ZBw
         ir8PwaiFdMdKK0mgUvElPosL0BV3DHZJZcrPB13+NvvLT6Gs5I90hvKr4J1rMzWQLr+H
         axY8xvzaz/4+SxZoHLe6/SHzPtZTGC085Nx7Olp4v6McYeSsgSL5hmu+t9kWt2SXbMZ0
         JfjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DNh0ufsiWetZMwuUMmUtgMWb+K7Ya3sJmdkxiGc9vsI=;
        b=VILHSswTV9mx0LYbCE+EP0mazmj9dHpXfxSik13g2/WqVIrgC9Hc8ar19AixCP6X+g
         //FDNb92dwy7MuAKvCati7iGGj4MfIZ0RzdGaSmBmMJY4LXomVX7O/05WPFbwL4pk5jf
         mDxAuyipR/4Xd6xIWbgVLtFuL+yuVuB3LPLAB0BVJOTU+fH5vRhZJoV/ar+L9a6CbcmX
         ABE2eeHreYFKxpglXg7ORzBts+q7NqG7Ah0nZaQri/cRbXbUYyqQuQJsbkvjWKaYCIdC
         xhrCsP1zQ5dg5EQyrcfC4t8RCpiv7Jzs+UUPIl4clUFGaiAtnq2qyBZdJXA6oIurjoz0
         ubag==
X-Gm-Message-State: APjAAAXdtH168ATBIveej4NDzzore63GLjvErkbiov7RNAQAzdAz9kcq
        3zYFzHjCszCzrDL7kwA9rbEen9isbIW4SrRq0vI=
X-Google-Smtp-Source: APXvYqz3mtijqW0wvTmNd5Yp2Ht4KpvsxGP8iMOxY6YyfJJdIPA1sMaeIa2SVQWhv5MWb3KTRlzcHi8/hVnfesBh13g=
X-Received: by 2002:a17:906:1811:: with SMTP id v17mr15222117eje.109.1556089036296;
 Tue, 23 Apr 2019 23:57:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190423211932.4906-1-ndesaulniers@google.com>
In-Reply-To: <20190423211932.4906-1-ndesaulniers@google.com>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Wed, 24 Apr 2019 14:56:39 +0800
Message-ID: <CAEbi=3fn42-rcXOh28N09G9Gng8o9RE8_A8=ow0=JeMEXVF_ig@mail.gmail.com>
Subject: Re: [PATCH] nds32: vdso: drop unnecessary cc-ldoption
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Vincent Chen <deanbo422@gmail.com>,
        clang-built-linux@googlegroups.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick & Yamada,

Nick Desaulniers <ndesaulniers@google.com> =E6=96=BC 2019=E5=B9=B44=E6=9C=
=8824=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=885:19=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> Towards the goal of removing cc-ldoption, it seems that --hash-style=3D
> was added to binutils 2.17.50.0.2 in 2006. The minimal required version
> of binutils for the kernel according to
> Documentation/process/changes.rst is 2.20.
>
> Link: https://gcc.gnu.org/ml/gcc/2007-01/msg01141.html
> Cc: clang-built-linux@googlegroups.com
> Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  arch/nds32/kernel/vdso/Makefile | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/arch/nds32/kernel/vdso/Makefile b/arch/nds32/kernel/vdso/Mak=
efile
> index e6c50a701313..d379645cad74 100644
> --- a/arch/nds32/kernel/vdso/Makefile
> +++ b/arch/nds32/kernel/vdso/Makefile
> @@ -11,10 +11,8 @@ obj-vdso :=3D note.o datapage.o sigreturn.o gettimeofd=
ay.o
>  targets :=3D $(obj-vdso) vdso.so vdso.so.dbg
>  obj-vdso :=3D $(addprefix $(obj)/, $(obj-vdso))
>
> -ccflags-y :=3D -shared -fno-common -fno-builtin
> -ccflags-y +=3D -nostdlib -Wl,-soname=3Dlinux-vdso.so.1 \
> -               $(call cc-ldoption, -Wl$(comma)--hash-style=3Dsysv)
> -ccflags-y +=3D -fPIC -Wl,-shared -g
> +ccflags-y :=3D -shared -fno-common -fno-builtin -nostdlib -fPIC -Wl,-sha=
red -g \
> +       -Wl,-soname=3Dlinux-vdso.so.1 -Wl,--hash-style=3Dsysv
>
>  # Disable gcov profiling for VDSO code
>  GCOV_PROFILE :=3D n

Thank you.
Acked-by: Greentime Hu <greentime@andestech.com>
