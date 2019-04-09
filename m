Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA48C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 06:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93FE120880
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 06:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfDIGn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 02:43:28 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41160 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfDIGn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 02:43:27 -0400
Received: by mail-lj1-f195.google.com with SMTP id k8so13394249lja.8;
        Mon, 08 Apr 2019 23:43:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dojvh5C6mz+VIKO3HuOFiWuFHkUl4wLKGs+2Is0aJkE=;
        b=ZoNmUD+BM6Pyy3scpGS/SmxkgHqYfdx7/5py09N1cnYtH9+K/kKXc7Ko1oEBDClnRU
         vKUYf+1RQZQskR/G8K8ZvEVNpO/JxkEJmRJ1DVEthAyE/u43k7mXCmMR7M9IJM2ujbo8
         7EYeXmraojhTlABtxEndIHmvmR6LqSoLVcNarqYqKQzGdSuNlIfOowIgh4sQdWJxdGuH
         C73DxFAATdfL3MUOKW7VXKgouEGwagIbgBivQJQjx5F4QiC0axTcZCvVUz1HxNC+HIG3
         o5cIoUQyOyFMPhDsSGabbBO/4mrvuA1JJ8RidNiYGKn+mgA+d8/DyKiCjXU/7BFH/nWg
         ACOQ==
X-Gm-Message-State: APjAAAWHME+8pFIyaGi5rtuqPlUtQRCjwCMkMjF05kaUnXFBp5k4ahwS
        z16xDhjF49hbU5mC3QfhEMIq56WSfTF79J4/mxQ=
X-Google-Smtp-Source: APXvYqwWlLtq8cuVIJnz2uPQidl6q464I3VAO67BZNlihvw8FkItGROri/sPn2QvKwGARwG06FGFeCfTH9iwLm8a8zc=
X-Received: by 2002:a2e:9e4d:: with SMTP id g13mr16061952ljk.12.1554792205921;
 Mon, 08 Apr 2019 23:43:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190408212648.2407234-1-arnd@arndb.de> <20190408212648.2407234-3-arnd@arndb.de>
 <20190408220312.GA18333@archlinux-i9>
In-Reply-To: <20190408220312.GA18333@archlinux-i9>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 9 Apr 2019 08:43:09 +0200
Message-ID: <CAK8P3a39NqQOp+0=WYuWh0UmpH=kEFLKyymNYm8DH-0gx9XaaQ@mail.gmail.com>
Subject: Re: [PATCH 03/12] s390: purgatory: pass --target option to clang
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Philipp Rudo <prudo@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 9, 2019 at 12:03 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Mon, Apr 08, 2019 at 11:26:16PM +0200, Arnd Bergmann wrote:
> > The purgatory Makefile does not inherit the original cflags,
> > so clang falls back to the default target architecture when
> > building it, typically this would be x86 when cross-compiling.
> >
> > Pass --target=s390x-linux to all compilers that understand
> > this option.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  arch/s390/purgatory/Makefile | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/s390/purgatory/Makefile b/arch/s390/purgatory/Makefile
> > index ce6a3f75065b..3a14b968cec3 100644
> > --- a/arch/s390/purgatory/Makefile
> > +++ b/arch/s390/purgatory/Makefile
> > @@ -22,6 +22,7 @@ KBUILD_CFLAGS := -fno-strict-aliasing -Wall -Wstrict-prototypes
> >  KBUILD_CFLAGS += -Wno-pointer-sign -Wno-sign-compare
> >  KBUILD_CFLAGS += -fno-zero-initialized-in-bss -fno-builtin -ffreestanding
> >  KBUILD_CFLAGS += -c -MD -Os -m64 -msoft-float -fno-common
> > +KBUILD_CFLAGS += $(call cc-option,--target=s390x-linux)
> >  KBUILD_CFLAGS += $(call cc-option,-fno-PIE)
> >  KBUILD_AFLAGS := $(filter-out -DCC_USING_EXPOLINE,$(KBUILD_AFLAGS))
> >
> Would
>
> ifdef CONFIG_CC_IS_CLANG
> KBUILD_CFLAGS += --target=s390x-linux
> endif
>
> be a little clearer (and save a cc-option call)?

Fine with me as well. Actually I noticed later that we need the same
thing for arch/s390/boot/Makefile and arch/s390/boot/compressed/Makefile
in some form, so maybe we should drop this one for now and find
a solution that works for all three of them. The boot stuff is the one
patch I did not send, since I did not think I had a good solution there,
just one that happened to make it build.

> Otherwise, makes sense.
>
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

 Thanks,

       Arnd
