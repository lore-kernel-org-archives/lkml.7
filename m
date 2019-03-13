Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB38C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 17:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFB802075C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 17:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="tFGS8Adb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfCMRjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 13:39:06 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:29183 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfCMRjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 13:39:04 -0400
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x2DHcs5C014255;
        Thu, 14 Mar 2019 02:38:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x2DHcs5C014255
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1552498735;
        bh=kOxq/SmZsWCGOCdDaFfVwweAG7CAulDEp/I2CLqOGPA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tFGS8AdbBNWhv8oIAB8/S/JxtMlFhUiaazqAoyyp68WADx6nNZr9TLkbKKADHGGku
         5HJZbKXwSyxRAqS4z/Rol2WhhBkAQ9T0hlIH0jgsLPOJLEAd/xX3HVkdb6lH2Ubu0a
         1VT3NLyliFlxVnpUtmkNXwi/Kg5XpmTFcNYrAIMHb4fTCrG8+MWm9bLRT1qSrXeyPl
         GCIpCVDQFLPjGrxmnizldP6wGG+TewOjn/dEZ74C7km4C68fmI7VcvE9yeUbi7Odlc
         aklgfQbzFsLdENFdmsyYj6ek/ofb8svQyb/UM3TpWoVSY5W+YmupGUmALrSA10VMqu
         Q7MlGskwW+c9A==
X-Nifty-SrcIP: [209.85.222.51]
Received: by mail-ua1-f51.google.com with SMTP id a42so962321uad.1;
        Wed, 13 Mar 2019 10:38:54 -0700 (PDT)
X-Gm-Message-State: APjAAAU1afU8gvhyJ/AfwcdssIZ0yKX3yj1/bhmN9Qy+U2a8DFIy6x86
        nlkYtxjiFTm5/P0YVkpkju1lQ3IeyW6yex0tslA=
X-Google-Smtp-Source: APXvYqyjKM8oZ+Aeo9AOWpIEduG3QpFxA2PQp6wRBgPmr4ehpgC8QQ92vWpZxOKIPUNbZlxcO/VWlQ85TQbcFuEOFE4=
X-Received: by 2002:ab0:648c:: with SMTP id p12mr23115060uam.93.1552498733629;
 Wed, 13 Mar 2019 10:38:53 -0700 (PDT)
MIME-Version: 1.0
References: <1548400703-27945-1-git-send-email-yamada.masahiro@socionext.com> <CAK7LNARf-P0Qjj2ScgQHk2yFw13h7zXk0VCB0MJe3W2ka3s40A@mail.gmail.com>
In-Reply-To: <CAK7LNARf-P0Qjj2ScgQHk2yFw13h7zXk0VCB0MJe3W2ka3s40A@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 14 Mar 2019 02:38:17 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQES1uci6MucHCE2dN2bKV3grLzLi76Q=ycYqCAWzWwRw@mail.gmail.com>
Message-ID: <CAK7LNAQES1uci6MucHCE2dN2bKV3grLzLi76Q=ycYqCAWzWwRw@mail.gmail.com>
Subject: Re: [PATCH] ia64: prefix header search path with $(srctree)/
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        linux-ia64@vger.kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 1:54 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Fri, Jan 25, 2019 at 4:21 PM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > Currently, the Kbuild core manipulates header search paths in a crazy
> > way [1].
> >
> > To fix this mess, I want all Makefiles to add explicit $(srctree)/ to
> > the search paths in the srctree. Some Makefiles are already written in
> > that way, but not all. The goal of this work is to make the notation
> > consistent, and finally get rid of the gross hacks.
> >
> > Having whitespaces after -I does not matter since commit 48f6e3cf5bc6
> > ("kbuild: do not drop -I without parameter").
> >
> > I removed some header search paths because I was able to build ia64
> > without them.
> >
> > [1]: https://patchwork.kernel.org/patch/9632347/
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
>
>
> ia64 development is not very active these days.
>
> I will wait for response from the maintainers.
>
> If they are silent, I want to pick up this to my kbuild tree.


Applied to linux-kbuild.




>
> Thanks.
>
>
> >  arch/ia64/sn/kernel/Makefile     | 2 +-
> >  arch/ia64/sn/kernel/sn2/Makefile | 2 --
> >  arch/ia64/sn/pci/Makefile        | 2 --
> >  arch/ia64/sn/pci/pcibr/Makefile  | 2 +-
> >  4 files changed, 2 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/ia64/sn/kernel/Makefile b/arch/ia64/sn/kernel/Makefile
> > index d27df1d..9c349dd 100644
> > --- a/arch/ia64/sn/kernel/Makefile
> > +++ b/arch/ia64/sn/kernel/Makefile
> > @@ -7,7 +7,7 @@
> >  # Copyright (C) 1999,2001-2006,2008 Silicon Graphics, Inc.  All Rights Reserved.
> >  #
> >
> > -ccflags-y := -Iarch/ia64/sn/include
> > +ccflags-y := -I $(srctree)/arch/ia64/sn/include
> >
> >  obj-y                          += setup.o bte.o bte_error.o irq.o mca.o idle.o \
> >                                    huberror.o io_acpi_init.o io_common.o \
> > diff --git a/arch/ia64/sn/kernel/sn2/Makefile b/arch/ia64/sn/kernel/sn2/Makefile
> > index 3d09108..170bde4 100644
> > --- a/arch/ia64/sn/kernel/sn2/Makefile
> > +++ b/arch/ia64/sn/kernel/sn2/Makefile
> > @@ -9,7 +9,5 @@
> >  # sn2 specific kernel files
> >  #
> >
> > -ccflags-y := -Iarch/ia64/sn/include
> > -
> >  obj-y += cache.o io.o ptc_deadlock.o sn2_smp.o sn_proc_fs.o \
> >          prominfo_proc.o timer.o timer_interrupt.o sn_hwperf.o
> > diff --git a/arch/ia64/sn/pci/Makefile b/arch/ia64/sn/pci/Makefile
> > index df2a901..321576b 100644
> > --- a/arch/ia64/sn/pci/Makefile
> > +++ b/arch/ia64/sn/pci/Makefile
> > @@ -7,6 +7,4 @@
> >  #
> >  # Makefile for the sn pci general routines.
> >
> > -ccflags-y := -Iarch/ia64/sn/include
> > -
> >  obj-y := pci_dma.o tioca_provider.o tioce_provider.o pcibr/
> > diff --git a/arch/ia64/sn/pci/pcibr/Makefile b/arch/ia64/sn/pci/pcibr/Makefile
> > index 396bcae..712f6af 100644
> > --- a/arch/ia64/sn/pci/pcibr/Makefile
> > +++ b/arch/ia64/sn/pci/pcibr/Makefile
> > @@ -7,7 +7,7 @@
> >  #
> >  # Makefile for the sn2 io routines.
> >
> > -ccflags-y := -Iarch/ia64/sn/include
> > +ccflags-y := -I $(srctree)/arch/ia64/sn/include
> >
> >  obj-y                          +=  pcibr_dma.o pcibr_reg.o \
> >                                     pcibr_ate.o pcibr_provider.o
> > --
> > 2.7.4
> >
>
>
> --
> Best Regards
> Masahiro Yamada



-- 
Best Regards
Masahiro Yamada
