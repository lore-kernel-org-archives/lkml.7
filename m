Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB153C606CF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 09:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30D842084B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 09:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="cppAMmfS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfGJJys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 05:54:48 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:56808 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfGJJyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 05:54:47 -0400
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x6A9sgmp001340
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 18:54:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x6A9sgmp001340
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1562752483;
        bh=wZxsXv3WIaYTljW6aasMT3VMX3W+OBT6hDSikiAjYU8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cppAMmfSziHzNw3QPCqvYGxtASmwsfaxFZD9tScf2nQDpyD8fMvpnMpbOF0H13jLA
         TxSNrKqWEsiRSeM+jY1ti8pJiGrg4fxEMkGnaLG2A4aDlKXlMYvJbAw9H5A9KpqpkT
         fqUgdQ6iB/QJV5CL4a6FLbFV5dlUZ7gAsa9CBs/LL56VpkSEazUyJQ3TrYeoQzeZTq
         Ctc0mkTukW0soeaOLKIBCeC3moMMPJ3vtsAuEFhZ3srLeqVl398R/AJ1XkAWF/Tcwo
         CRK4qIRqxKGYZGinwoiqp7nep1kF3dE3q+uJhUDaB9Cygl56epeSOrn7pB0Od7qqTT
         S9Kzu4G5p1X0Q==
X-Nifty-SrcIP: [209.85.217.51]
Received: by mail-vs1-f51.google.com with SMTP id h28so1080898vsl.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 02:54:43 -0700 (PDT)
X-Gm-Message-State: APjAAAXTpioC4NGlrpfdZ89jeBAfizRCigiYnfupFxy6TXKTWUFkZjiJ
        L5Rus45xlYTxOA+H6QRayT3qZoocBC6Qav2HsDs=
X-Google-Smtp-Source: APXvYqxji+IBpsKEUlMjit3TzT6DNhRUlj99qLYH0If42BHRy8jugDJ4geeVshp/7HYjypa0ryai/Hv/TS//EpHlQ/U=
X-Received: by 2002:a67:fc45:: with SMTP id p5mr17151977vsq.179.1562752482167;
 Wed, 10 Jul 2019 02:54:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNASSCvLSXVikR7GenXyb8KywpWKVc1Z=5v3c93rxJ+G73w@mail.gmail.com>
 <20190710082335.uzusesefimzpjd3f@shell.armlinux.org.uk>
In-Reply-To: <20190710082335.uzusesefimzpjd3f@shell.armlinux.org.uk>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 10 Jul 2019 18:54:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQpiY4CBawEFhQHeTPSrbrRkNoYCtK4jBak+skyyMqESA@mail.gmail.com>
Message-ID: <CAK7LNAQpiY4CBawEFhQHeTPSrbrRkNoYCtK4jBak+skyyMqESA@mail.gmail.com>
Subject: Re: Question about ARM FASTFPE
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 5:23 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Wed, Jul 10, 2019 at 01:30:24PM +0900, Masahiro Yamada wrote:
> > Hi.
> >
> > I have a question about the following code
> > in arch/arm/Makefile:
> >
> >
> > # Do we have FASTFPE?
> > FASTFPE :=arch/arm/fastfpe
> > ifeq ($(FASTFPE),$(wildcard $(FASTFPE)))
> > FASTFPE_OBJ :=$(FASTFPE)/
> > endif
> >
> >
> > Since arch/arm/fastfpe does not exist in the upstream tree,
> > I guess this is a hook to compile downstream source code.
> >
> > If a user puts arch/arm/fastfpe/ into their local source tree,
> > Kbuild is supposed to compile the files in it.
> >
> > Is this correct?
> >
> >
> > If so, I am afraid this would not work for O= building.
> >
> > $(wildcard ...) checks if this directory exists in the *objtree*,
> > while scripts/Makefile.build needs to include
> > arch/arm/fastfpe/Makefile from *srctree*.
> >
> > I think the correct code should be like follows:
> >
> > # Do we have FASTFPE?
> > FASTFPE :=arch/arm/fastfpe
> > ifneq ($(wildcard $(srctree)/$(FASTFPE)),)
> > FASTFPE_OBJ :=$(FASTFPE)/
> > endif
> >
> >
> > Having said that, I am not sure this code is worth fixing.
> >
> > This code was added around v2.5.1.9,
>
> ... as a _result_ of a discussion and deciding not to upstream it,
> but to still allow its use.  Fastfpe is faster than nwfpe (so has
> a definite advantage for FP intensive applications) but we decided
> we didn't want two FP emulation codes in the kernel.  However, if
> someone wants to use it, it has to be built into the kernel, it
> can't be modular.


IMHO, the entry in Makefile and Kconfig should be removed
from upstream, then moved to a part of the fastfpe local patch.



-- 
Best Regards
Masahiro Yamada
