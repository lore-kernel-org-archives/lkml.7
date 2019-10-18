Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775C6CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BA9C2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNarsndy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632802AbfJRI14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 04:27:56 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40715 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392728AbfJRI1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 04:27:55 -0400
Received: by mail-ed1-f65.google.com with SMTP id v38so3910362edm.7;
        Fri, 18 Oct 2019 01:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zDSqcOkP2VMM+VEiT/vRGRAsfqP4fI01tx/F/lL/3zY=;
        b=GNarsndyF0j+Y7MyOM682hGvUhawyi9GWj/5AnmRiAn3Cis7AAXKrGt44hmJno6jyE
         rEE7+ZNavYBrLHUyCeRxc4ebtm3auILatI/UlpEGifoEo1tVHDRgAbP4Qm/UHz9oRZg2
         oHZ5EMgUYGJ3AXZkI2AmM5WtakVk3zt4QzzPnm7xzfwaV3KkEU7w0Vtnp+vl6Sgi990a
         h4hwmc0EMhSf9PW05wHsNa4cEEO0ytiN9eiOm3tqvFxNK5tlPZpXily1AS36skhCxerG
         52Q6Wf7fdxrKNQDPx0rze6tkQzyVL48xYAftqISJEUJ1DZ3Td+EpvPYNJCkdf1xTl4UL
         AGMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zDSqcOkP2VMM+VEiT/vRGRAsfqP4fI01tx/F/lL/3zY=;
        b=UjKhlxL2T4cyCnVjnzQmnAAa81pzj5Z25HCgACzfp2EFlunGj61SUher+xiN6y81Nm
         RB4s4P0a8k4gBfAfeqrm0jfB9f4MwiOTWfMdzSIPipisJEssCbQA8onJhpj8jValGJXp
         gO31+EYnw5ALJxNRpsTGxi4xysoy7qO5m9Zc+N2j+8e6aq1cmTsPnErbHEQojjIf1RWb
         QlBvO6lMQSMUCuIGdbzS98h5F3qoLaT2YYG/YF/9AgC9qAW9S2Iuv2J5qhczbhz7kyvR
         8/qzjVfy/b82S3PVfwnT8A/1KsBtezDkdN0n6hi+8hRilX/CN0dDI/bocwpWV/LSxRQC
         8Ohw==
X-Gm-Message-State: APjAAAX/WOC/tuyuMcjT/UXYV1hIIqnQgN4GMNrvngbIF/qT6jWXjg+6
        24ITGVAh30JRUjymr+LFeKhR7+Bibdl5yEG8/l3ZPite
X-Google-Smtp-Source: APXvYqzM8bpfqOg09DXLhEx8bCSMXiB5z3QiM35Q+iXMFoXOZQNth9n4ShsTqJ6X31CfKoWCmgf32N3Qz0DCGqV0kyo=
X-Received: by 2002:a05:6402:7ca:: with SMTP id u10mr8320134edy.20.1571387273291;
 Fri, 18 Oct 2019 01:27:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190922113436.10396-1-yamada.masahiro@socionext.com> <CAK7LNARXA4MnDyYHLphYEqMfEbh=cMk0i=pzDRbEODTeM+cJ4Q@mail.gmail.com>
In-Reply-To: <CAK7LNARXA4MnDyYHLphYEqMfEbh=cMk0i=pzDRbEODTeM+cJ4Q@mail.gmail.com>
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Fri, 18 Oct 2019 11:27:42 +0300
Message-ID: <CADxRZqy-3x4ZMSdGoxc1F2uE3x33kugD_wXdmUwBMy1s6Hqz0Q@mail.gmail.com>
Subject: Re: [PATCH] sparc: vdso: fix build error of vdso32
To:     sparclinux <sparclinux@vger.kernel.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 6:47 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Sun, Sep 22, 2019 at 8:36 PM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > Since commit 54b8ae66ae1a ("kbuild: change *FLAGS_<basetarget>.o to
> > take the path relative to $(obj)"), sparc allmodconfig fails to build
> > as follows:
> >
> >   CC      arch/sparc/vdso/vdso32/vclock_gettime.o
> > unrecognized e_machine 18 arch/sparc/vdso/vdso32/vclock_gettime.o
> > arch/sparc/vdso/vdso32/vclock_gettime.o: failed
> >
> > The cause of the breakage is that -pg flag not being dropped.
> >
> > The vdso32 files are located in the vdso32/ subdirectory, but I missed
> > to update the Makefile.
> >
> > Fixes: 54b8ae66ae1a ("kbuild: change *FLAGS_<basetarget>.o to take the path relative to $(obj)")
> > Reported-by: Anatoly Pugachev <matorola@gmail.com>
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> >
>
>
> I am copy-pasting Tested-by from the reporter:
>
> Tested-by: Anatoly Pugachev <matorola@gmail.com>
>
> It was given here:
>
> https://lkml.org/lkml/2019/9/25/197
>
>
>
>
> >  arch/sparc/vdso/Makefile | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
> > index 324a23947585..399bc22b1cf8 100644
> > --- a/arch/sparc/vdso/Makefile
> > +++ b/arch/sparc/vdso/Makefile
> > @@ -67,12 +67,14 @@ $(vobjs): KBUILD_CFLAGS := $(filter-out $(GCC_PLUGINS_CFLAGS) $(SPARC_REG_CFLAGS
> >  #
> >  CFLAGS_REMOVE_vdso-note.o = -pg
> >  CFLAGS_REMOVE_vclock_gettime.o = -pg
> > +CFLAGS_REMOVE_vdso32/vdso-note.o = -pg
> > +CFLAGS_REMOVE_vdso32/vclock_gettime.o = -pg
> >
> >  $(obj)/%.so: OBJCOPYFLAGS := -S
> >  $(obj)/%.so: $(obj)/%.so.dbg FORCE
> >         $(call if_changed,objcopy)
> >
> > -CPPFLAGS_vdso32.lds = $(CPPFLAGS_vdso.lds)
> > +CPPFLAGS_vdso32/vdso32.lds = $(CPPFLAGS_vdso.lds)
> >  VDSO_LDFLAGS_vdso32.lds = -m elf32_sparc -soname linux-gate.so.1
> >
> >  #This makes sure the $(obj) subdirectory exists even though vdso32/


Hello!

Can someone please pull/apply this to master ?!

Thanks!
