Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A41EC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A3FD2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Mw3rCB4c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730006AbfDXHyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 03:54:15 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:29762 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729767AbfDXHyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 03:54:14 -0400
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x3O7s7Hw001120
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 16:54:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x3O7s7Hw001120
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1556092448;
        bh=d8tLUPQuotT5ix5INuwcDDtJ04zVlYR579nlv7aEMAY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Mw3rCB4cp16IDv9Q0MMLtobh35DJSBdnjnVUTxDKgOupY0ttm5e6peMqbfogKCSVY
         dmEXn/jMZ8d3ldKhJXiqC01glKFnGd55hs8D8NneMaePFEyoDeKmhbgTUr9R6It9V9
         EEJWvCZ9b6zHbhybyOkaqD+uT7INnUR8lCKb62vzzMZu7DyFKnisjAYU9heqaP2ffR
         6H5CVW3bMLMx5GbWIdt9U35Zi93evVKQ4FhKnpPsVhz1CaNXTCiACkV5qKwLAXd768
         xCMaLJt9Ub9A+L9JLb/t03iBk2Nbatdz+7YyzgkIH3VBAx4DH2JwalixPZVIaEmb6v
         5oWKfLMu/s/Ww==
X-Nifty-SrcIP: [209.85.222.51]
Received: by mail-ua1-f51.google.com with SMTP id n16so5697596uae.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 00:54:07 -0700 (PDT)
X-Gm-Message-State: APjAAAVi+ToNHoW+iNmV76DDBkEKwYAYk8oz/oI2fy+LjcXzoE9nNfho
        T+8AnuhU7NkemkDXgs46I51VWRs2dtRsQ5hD3Lw=
X-Google-Smtp-Source: APXvYqzhm8k+7OGkHRnEANdXMXLjXmdwvKtCLlAdOLC1qAnlptmu10ApMVxgFnNQZRCChH3NqjAAbYEVOGl0uoFuEnQ=
X-Received: by 2002:ab0:20c1:: with SMTP id z1mr2133420ual.109.1556092446522;
 Wed, 24 Apr 2019 00:54:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190423211932.4906-1-ndesaulniers@google.com> <CAEbi=3fn42-rcXOh28N09G9Gng8o9RE8_A8=ow0=JeMEXVF_ig@mail.gmail.com>
In-Reply-To: <CAEbi=3fn42-rcXOh28N09G9Gng8o9RE8_A8=ow0=JeMEXVF_ig@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 24 Apr 2019 16:53:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQaPoL=bWzY_HcbJqM_s3j4+RC=-HFL+DwJWNOCTvNOfQ@mail.gmail.com>
Message-ID: <CAK7LNAQaPoL=bWzY_HcbJqM_s3j4+RC=-HFL+DwJWNOCTvNOfQ@mail.gmail.com>
Subject: Re: [PATCH] nds32: vdso: drop unnecessary cc-ldoption
To:     Greentime Hu <green.hu@gmail.com>
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

On Wed, Apr 24, 2019 at 3:59 PM Greentime Hu <green.hu@gmail.com> wrote:
>
> Hi Nick & Yamada,
>
> Nick Desaulniers <ndesaulniers@google.com> =E6=96=BC 2019=E5=B9=B44=E6=9C=
=8824=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=885:19=E5=AF=AB=E9=81=93=
=EF=BC=9A
> >
> > Towards the goal of removing cc-ldoption, it seems that --hash-style=3D
> > was added to binutils 2.17.50.0.2 in 2006. The minimal required version
> > of binutils for the kernel according to
> > Documentation/process/changes.rst is 2.20.
> >
> > Link: https://gcc.gnu.org/ml/gcc/2007-01/msg01141.html
> > Cc: clang-built-linux@googlegroups.com
> > Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
> >  arch/nds32/kernel/vdso/Makefile | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/nds32/kernel/vdso/Makefile b/arch/nds32/kernel/vdso/M=
akefile
> > index e6c50a701313..d379645cad74 100644
> > --- a/arch/nds32/kernel/vdso/Makefile
> > +++ b/arch/nds32/kernel/vdso/Makefile
> > @@ -11,10 +11,8 @@ obj-vdso :=3D note.o datapage.o sigreturn.o gettimeo=
fday.o
> >  targets :=3D $(obj-vdso) vdso.so vdso.so.dbg
> >  obj-vdso :=3D $(addprefix $(obj)/, $(obj-vdso))
> >
> > -ccflags-y :=3D -shared -fno-common -fno-builtin
> > -ccflags-y +=3D -nostdlib -Wl,-soname=3Dlinux-vdso.so.1 \
> > -               $(call cc-ldoption, -Wl$(comma)--hash-style=3Dsysv)
> > -ccflags-y +=3D -fPIC -Wl,-shared -g
> > +ccflags-y :=3D -shared -fno-common -fno-builtin -nostdlib -fPIC -Wl,-s=
hared -g \
> > +       -Wl,-soname=3Dlinux-vdso.so.1 -Wl,--hash-style=3Dsysv
> >
> >  # Disable gcov profiling for VDSO code
> >  GCOV_PROFILE :=3D n
>
> Thank you.
> Acked-by: Greentime Hu <greentime@andestech.com>


Who do you expect to pick up this patch?

You are the NDS32 maintainer
according to MAINTAINERS.


ANDES ARCHITECTURE
M:      Greentime Hu <green.hu@gmail.com>
M:      Vincent Chen <deanbo422@gmail.com>
T:      git https://github.com/andestech/linux.git
S:      Supported
F:      arch/nds32/
F:      Documentation/devicetree/bindings/interrupt-controller/andestech,at=
ivic32.txt
F:      Documentation/devicetree/bindings/nds32/
K:      nds32
N:      nds32


You do not maintain https://github.com/andestech/linux.git any more, do you=
?


--=20
Best Regards
Masahiro Yamada
