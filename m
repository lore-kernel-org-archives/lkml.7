Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7455C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9335A218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lsk4Okhz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbfDXIE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 04:04:56 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44526 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbfDXIEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 04:04:55 -0400
Received: by mail-ed1-f68.google.com with SMTP id i13so15020742edf.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 01:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=f3fvwEXom1LGpxngwni4Uzj3rYvQHtrnJN7iXdOxe2U=;
        b=Lsk4OkhzrZAPrlJN6mv4NCRKSFlRJzJ9XEGus9hRbJJoJk6NCnOU0Ex0VJ3iK48glP
         1t8/TZFDFf61aDLLWLqiEXGDyIItHuNRx3LCYEIVINzDViQba45yI5bKOyimIPVj7IjW
         4MZz28ks4NtKMbma55rPmhChxjIfUiXYZp1Y+3osS/JuJj4NiYnDMvNVsA0dBfSlig39
         aXORmTo+dGZXD4gzCAJuUzKcwHAwqwz0mTC/lpjGvaMacQd5xE/zAGf6vn8Xc8eGDXSQ
         BD3RfHZ+LPdLhGAAu2uQcMQeCglSUtEEnLU38L1dWNFrzLj89KiyXCPmTCsyPXq50PAm
         55yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=f3fvwEXom1LGpxngwni4Uzj3rYvQHtrnJN7iXdOxe2U=;
        b=aWj+YF+YopB2SmFV4pV6vuuWudXXs0z3l5fQpLql3I1FP0wBuUPiNkU5/EP0p50Cze
         LMUu3tY3lPLOLSzj+py1tciiNQhU8r1ASl5Xl3NSgoqG3+Wtqmz6/q9fHTHzvIQ9FkJz
         IH4wMpR6/2mB+d/7nx3u18vf/UX68tgzeIy2OSzbWSr0jsVMdwrGNSW64ePwY5Y2YCQ1
         xZ+gVP9xaj0UX377Hq0+tVyoeEYA1tGqjEJe3huIQuVqwvBZ8h+FYSn7FH5gGD0ZlfgH
         oaq3R4G19fkM/iGKNLEs0kdsF6VJp4HN2/mccGfAaLgy868dUWmekjKA0ON1wNVmTLhd
         Ba8A==
X-Gm-Message-State: APjAAAWLiebMAfqQFNvP39ylU1sFBYzXX2YxBmMJjz3iY7//HXo00oQr
        v1G2L3i0+46EFZUT84nqTnNhZSMVQQNGV126nkM=
X-Google-Smtp-Source: APXvYqwdJvUve5VmpfnocuN3bMT+o2Twgk/QMxONIZDoGfyFmgLOh+CG4KAM/Oz+aHgGs5zxTAsxAUNFJhwqztveVbc=
X-Received: by 2002:a50:be01:: with SMTP id a1mr19595371edi.12.1556093093668;
 Wed, 24 Apr 2019 01:04:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190423211932.4906-1-ndesaulniers@google.com>
 <CAEbi=3fn42-rcXOh28N09G9Gng8o9RE8_A8=ow0=JeMEXVF_ig@mail.gmail.com> <CAK7LNAQaPoL=bWzY_HcbJqM_s3j4+RC=-HFL+DwJWNOCTvNOfQ@mail.gmail.com>
In-Reply-To: <CAK7LNAQaPoL=bWzY_HcbJqM_s3j4+RC=-HFL+DwJWNOCTvNOfQ@mail.gmail.com>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Wed, 24 Apr 2019 16:04:17 +0800
Message-ID: <CAEbi=3fSP4OkxkDPYBuae5mQ0U3hwpK1K6W2haqAt1kKDaz43g@mail.gmail.com>
Subject: Re: [PATCH] nds32: vdso: drop unnecessary cc-ldoption
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Vincent Chen <deanbo422@gmail.com>,
        clang-built-linux@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro Yamada <yamada.masahiro@socionext.com> =E6=96=BC 2019=E5=B9=B44=E6=
=9C=8824=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=883:54=E5=AF=AB=E9=81=
=93=EF=BC=9A
>
> On Wed, Apr 24, 2019 at 3:59 PM Greentime Hu <green.hu@gmail.com> wrote:
> >
> > Hi Nick & Yamada,
> >
> > Nick Desaulniers <ndesaulniers@google.com> =E6=96=BC 2019=E5=B9=B44=E6=
=9C=8824=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=885:19=E5=AF=AB=E9=81=
=93=EF=BC=9A
> > >
> > > Towards the goal of removing cc-ldoption, it seems that --hash-style=
=3D
> > > was added to binutils 2.17.50.0.2 in 2006. The minimal required versi=
on
> > > of binutils for the kernel according to
> > > Documentation/process/changes.rst is 2.20.
> > >
> > > Link: https://gcc.gnu.org/ml/gcc/2007-01/msg01141.html
> > > Cc: clang-built-linux@googlegroups.com
> > > Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > > ---
> > >  arch/nds32/kernel/vdso/Makefile | 6 ++----
> > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/arch/nds32/kernel/vdso/Makefile b/arch/nds32/kernel/vdso=
/Makefile
> > > index e6c50a701313..d379645cad74 100644
> > > --- a/arch/nds32/kernel/vdso/Makefile
> > > +++ b/arch/nds32/kernel/vdso/Makefile
> > > @@ -11,10 +11,8 @@ obj-vdso :=3D note.o datapage.o sigreturn.o gettim=
eofday.o
> > >  targets :=3D $(obj-vdso) vdso.so vdso.so.dbg
> > >  obj-vdso :=3D $(addprefix $(obj)/, $(obj-vdso))
> > >
> > > -ccflags-y :=3D -shared -fno-common -fno-builtin
> > > -ccflags-y +=3D -nostdlib -Wl,-soname=3Dlinux-vdso.so.1 \
> > > -               $(call cc-ldoption, -Wl$(comma)--hash-style=3Dsysv)
> > > -ccflags-y +=3D -fPIC -Wl,-shared -g
> > > +ccflags-y :=3D -shared -fno-common -fno-builtin -nostdlib -fPIC -Wl,=
-shared -g \
> > > +       -Wl,-soname=3Dlinux-vdso.so.1 -Wl,--hash-style=3Dsysv
> > >
> > >  # Disable gcov profiling for VDSO code
> > >  GCOV_PROFILE :=3D n
> >
> > Thank you.
> > Acked-by: Greentime Hu <greentime@andestech.com>
>
>
> Who do you expect to pick up this patch?
>
> You are the NDS32 maintainer
> according to MAINTAINERS.
>
>
> ANDES ARCHITECTURE
> M:      Greentime Hu <green.hu@gmail.com>
> M:      Vincent Chen <deanbo422@gmail.com>
> T:      git https://github.com/andestech/linux.git
> S:      Supported
> F:      arch/nds32/
> F:      Documentation/devicetree/bindings/interrupt-controller/andestech,=
ativic32.txt
> F:      Documentation/devicetree/bindings/nds32/
> K:      nds32
> N:      nds32
>
>
> You do not maintain https://github.com/andestech/linux.git any more, do y=
ou?

Hi Yamada,

I think I should update this MAINTAINERS file.
I will pick it in this repo
https://git.kernel.org/pub/scm/linux/kernel/git/greentime/linux.git
