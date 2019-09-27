Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCF4C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 15:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9517A205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 15:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="HDfInl7c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbfI0PrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 11:47:18 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:29043 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbfI0PrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 11:47:18 -0400
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x8RFl8pg012289;
        Sat, 28 Sep 2019 00:47:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x8RFl8pg012289
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1569599229;
        bh=0YR/Az+CB16U9fbkYCW2HvtbjzSrTM2QIFsD0wKaTiE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HDfInl7cA/BLT0w+VA5sVcBeh+46do44mxSArJG/7nJkjBY1talPjvSivr+gNbFw0
         h+zLJcAhELvueUsTwSmgtBWA6AALKq0P7uojTw9dasyC0SKTMs0RO90zcRRyOMxUxW
         Ltyt4fG2MVw/BdcQ/bKsX6Avc+lie8ulJewGaxQWhVAZWtZDrcvwwRXOBAFFEU9w9N
         5cE2tzB5q2Vksqi389idAC744BuF+sJLqMYHTkgz+6uA9cPA/t9vIO+h15u/jzeccX
         jJL9sFnMsK24iuSnwtWAcABJi4A5QKgMkIIPptEkkysmfke30P/pz21d/Y1udrWyl1
         MRjGijVjzEyIA==
X-Nifty-SrcIP: [209.85.222.41]
Received: by mail-ua1-f41.google.com with SMTP id b14so2079858uap.6;
        Fri, 27 Sep 2019 08:47:09 -0700 (PDT)
X-Gm-Message-State: APjAAAVNzheGWsnp7F2vT4F97567LH7KJMAitxzq0+FQPwC3E4GvoW+Y
        h8ZX9XB15Lo9wpIwwF7cj31hZRoNfBA0nCRWnQw=
X-Google-Smtp-Source: APXvYqwHMmMTACsPXv679DAxPCpVLapQs+iMVrZo9luuGhd1H/3f77vuQJP4S9/AVoVuGyx+pL3IL6Y+11QqrIaNJWc=
X-Received: by 2002:ab0:6355:: with SMTP id f21mr3136372uap.40.1569599227984;
 Fri, 27 Sep 2019 08:47:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190922113436.10396-1-yamada.masahiro@socionext.com>
In-Reply-To: <20190922113436.10396-1-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 28 Sep 2019 00:46:32 +0900
X-Gmail-Original-Message-ID: <CAK7LNARXA4MnDyYHLphYEqMfEbh=cMk0i=pzDRbEODTeM+cJ4Q@mail.gmail.com>
Message-ID: <CAK7LNARXA4MnDyYHLphYEqMfEbh=cMk0i=pzDRbEODTeM+cJ4Q@mail.gmail.com>
Subject: Re: [PATCH] sparc: vdso: fix build error of vdso32
To:     "David S . Miller" <davem@davemloft.net>,
        sparclinux <sparclinux@vger.kernel.org>
Cc:     Anatoly Pugachev <matorola@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 22, 2019 at 8:36 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Since commit 54b8ae66ae1a ("kbuild: change *FLAGS_<basetarget>.o to
> take the path relative to $(obj)"), sparc allmodconfig fails to build
> as follows:
>
>   CC      arch/sparc/vdso/vdso32/vclock_gettime.o
> unrecognized e_machine 18 arch/sparc/vdso/vdso32/vclock_gettime.o
> arch/sparc/vdso/vdso32/vclock_gettime.o: failed
>
> The cause of the breakage is that -pg flag not being dropped.
>
> The vdso32 files are located in the vdso32/ subdirectory, but I missed
> to update the Makefile.
>
> Fixes: 54b8ae66ae1a ("kbuild: change *FLAGS_<basetarget>.o to take the path relative to $(obj)")
> Reported-by: Anatoly Pugachev <matorola@gmail.com>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>


I am copy-pasting Tested-by from the reporter:

Tested-by: Anatoly Pugachev <matorola@gmail.com>

It was given here:

https://lkml.org/lkml/2019/9/25/197




>  arch/sparc/vdso/Makefile | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
> index 324a23947585..399bc22b1cf8 100644
> --- a/arch/sparc/vdso/Makefile
> +++ b/arch/sparc/vdso/Makefile
> @@ -67,12 +67,14 @@ $(vobjs): KBUILD_CFLAGS := $(filter-out $(GCC_PLUGINS_CFLAGS) $(SPARC_REG_CFLAGS
>  #
>  CFLAGS_REMOVE_vdso-note.o = -pg
>  CFLAGS_REMOVE_vclock_gettime.o = -pg
> +CFLAGS_REMOVE_vdso32/vdso-note.o = -pg
> +CFLAGS_REMOVE_vdso32/vclock_gettime.o = -pg
>
>  $(obj)/%.so: OBJCOPYFLAGS := -S
>  $(obj)/%.so: $(obj)/%.so.dbg FORCE
>         $(call if_changed,objcopy)
>
> -CPPFLAGS_vdso32.lds = $(CPPFLAGS_vdso.lds)
> +CPPFLAGS_vdso32/vdso32.lds = $(CPPFLAGS_vdso.lds)
>  VDSO_LDFLAGS_vdso32.lds = -m elf32_sparc -soname linux-gate.so.1
>
>  #This makes sure the $(obj) subdirectory exists even though vdso32/
> --
> 2.17.1
>


-- 
Best Regards
Masahiro Yamada
