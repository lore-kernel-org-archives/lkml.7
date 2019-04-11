Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D6EC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70F042184B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfDKKTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 06:19:36 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34409 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfDKKTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 06:19:35 -0400
Received: by mail-qt1-f196.google.com with SMTP id k2so6426022qtm.1;
        Thu, 11 Apr 2019 03:19:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yQGHOSC48OIUpGf1QtgmfsbHYfMuFfaHHgjPohpbRRg=;
        b=hZKP41bqrONwWzBMj022gRZfDburthbgrgyyZ950T7WNrR45casrRI+zdJvf/JPtfK
         d9PpMt8Ct79Gs6dYtMiZmqEbfIo4IfaiBuF246bPofZ2c0ra0JNd4HTOshpBpv3Yfs0N
         9vVUBRYp6GS1sJLNT5A6f66+iz159q8iwi4+rlnpJOvwla5WPBEG4ZiubzBeufCwVCgp
         XlGSUUlOiazUzSMVoZMkf8w2Dy368KAQgIZXTeyID4bxaV9ej9rcVgVOdmRig5oZ4jJq
         UyIqtLwLlng1aDmWnSjSElDJikP0YkjaScuRIWyugFhroZy2lwFnGlUp2MF1J1qmTC8x
         7byA==
X-Gm-Message-State: APjAAAWKu0tojJBiNDq9/4LKklBCK1Cfn2LRPIOU2fP40YEHGG3xkFMO
        X9M1CjV3TWZsFdF5zHjdncEeDW7HYBBwiVOwuzE=
X-Google-Smtp-Source: APXvYqznX8ly33WqUQFKtzdNlChzvdTLmx9FzLciQeQ/YzeJv0wnSBaVECRhrALrggZIzbjCKlHY2ngvmnizGcRgpb0=
X-Received: by 2002:a0c:f68a:: with SMTP id p10mr40148054qvn.126.1554977974611;
 Thu, 11 Apr 2019 03:19:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190410201300.3528984-1-arnd@arndb.de> <20190411062349.GB4126@osiris>
In-Reply-To: <20190411062349.GB4126@osiris>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 11 Apr 2019 12:19:18 +0200
Message-ID: <CAK8P3a175Cy5ojmh+EAEz9E8tjXKPkwpXsKg5qc7zxZd6OWUhQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] s390: only build for new CPUs with clang
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Philipp Rudo <prudo@linux.vnet.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 8:24 AM Heiko Carstens
<heiko.carstens@de.ibm.com> wrote:
>
> On Wed, Apr 10, 2019 at 10:12:40PM +0200, Arnd Bergmann wrote:
> > llvm does does not understand -march=z9-109 and older target
> > specifiers, so disable the respective Kconfig settings and
> > the logic to make the boot code work on old systems when
> > building with clang.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  arch/s390/Kconfig       | 6 ++++++
> >  arch/s390/boot/Makefile | 2 ++
> >  2 files changed, 8 insertions(+)
> ...
> > diff --git a/arch/s390/boot/Makefile b/arch/s390/boot/Makefile
> > index c844eaf24ed7..953a74d04990 100644
> > --- a/arch/s390/boot/Makefile
> > +++ b/arch/s390/boot/Makefile
> > @@ -11,6 +11,7 @@ KASAN_SANITIZE := n
> >  KBUILD_AFLAGS := $(KBUILD_AFLAGS_DECOMPRESSOR)
> >  KBUILD_CFLAGS := $(KBUILD_CFLAGS_DECOMPRESSOR)
> >
> > +ifndef CONFIG_CC_IS_CLANG
> >  #
> >  # Use -march=z900 for als.c to be able to print an error
> >  # message if the kernel is started on a machine which is too old
> > @@ -25,6 +26,7 @@ CFLAGS_als.o                        += -march=z900
> >  CFLAGS_REMOVE_sclp_early_core.o      += $(CC_FLAGS_MARCH)
> >  CFLAGS_sclp_early_core.o     += -march=z900
> >  endif
> > +endif
>
> This contradicts the whole purpose of als.c - printing an error
> message to the console if the kernel is compiled for a newer
> architecture than it is running on (and therefore uses instructions
> unknown to the current system).
> If this can't be fixed/changed in clang, then it should be at least
> changed to the lowest possible architecture.

Ok, I'll do that. I originally did something like it, but then went back
to the simpler workaround to just make it compile.

      Arnd
