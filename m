Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A95C33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 13:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D87A72080A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 13:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578402329;
	bh=apNSL3PMyGRKcM1kAnunLDnLtKL85BQqwIs99ReMZoA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0IE1kl37cqsm3oJDSC/4QCvqNbLOuEsh2ak4qdJqjKvlU8BQsRq3CLucbnmdORYmj
	 zsMEui4OK6p64BscdPbl0XNfBYCyPirOa0hG+MKvyb98nDmjsyLSuMXJfCTeqN+xCO
	 fDdmb4oBFSUyFj1qCCaMeLekhhAnOFOeb0FxUQxQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgAGNF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 08:05:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:51580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726937AbgAGNF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 08:05:28 -0500
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E9192080A;
        Tue,  7 Jan 2020 13:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578402327;
        bh=apNSL3PMyGRKcM1kAnunLDnLtKL85BQqwIs99ReMZoA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=D8PKQZFge8BLwyl0k0OcOUcBS6qfwuWmY+aCyCftFgDnjmeWhK6lO8Zcd8QviaHzo
         xnvXq/5IzbRR7E5VYcXZ+OPfgXZwOh1NivzEHlSX8P5EC/oG20U19Dea6ydRhtq/c5
         I3sQnwqsw4PAVKb8C/EfIgXOoqVDitXcaHo0QgEQ=
Received: by mail-lj1-f178.google.com with SMTP id j26so54609508ljc.12;
        Tue, 07 Jan 2020 05:05:27 -0800 (PST)
X-Gm-Message-State: APjAAAUGZgJWI4eO7wxaDuclHdIQKX4fH+NrLKu8E+oSQgTAmeERt2IB
        KCvvtq5348Jjx7uPZd1ctiIAlfKgKXgWGEAM6nQ=
X-Google-Smtp-Source: APXvYqyPTwJcXp6FzwLRmy/Rvf2ZAGxyXSuvaBP4C0J5akCTiUsEzFmHdzE/quymJKQwjm0ZM9llu2OHwAk3G/ZYAYo=
X-Received: by 2002:a2e:870b:: with SMTP id m11mr62140678lji.93.1578402325748;
 Tue, 07 Jan 2020 05:05:25 -0800 (PST)
MIME-Version: 1.0
References: <1578399963-2229-1-git-send-email-krzk@kernel.org> <CAMuHMdULcBE1inRzTRFJeRDToT1wW+nrMEfiUs7DxMLR0tqb3w@mail.gmail.com>
In-Reply-To: <CAMuHMdULcBE1inRzTRFJeRDToT1wW+nrMEfiUs7DxMLR0tqb3w@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 7 Jan 2020 14:05:14 +0100
X-Gmail-Original-Message-ID: <CAJKOXPcbUfUcmU2O50M5Hs2y6ggg-m5qU-AJ6HjSL9dFTCp64A@mail.gmail.com>
Message-ID: <CAJKOXPcbUfUcmU2O50M5Hs2y6ggg-m5qU-AJ6HjSL9dFTCp64A@mail.gmail.com>
Subject: Re: [PATCH] sh: clk: Fix discarding const qualifier warning
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jan 2020 at 14:00, Geert Uytterhoeven <geert@linux-m68k.org> wrot=
e:
>
> Hi Krzysztof,
>
> On Tue, Jan 7, 2020 at 1:26 PM Krzysztof Kozlowski <krzk@kernel.org> wrot=
e:
> > ioreadX() accepts pointer to non-const memory.  This fixes warnings
> > like:
> >
> >     drivers/sh/clk/cpg.c: In function =E2=80=98r8=E2=80=99:
> >     drivers/sh/clk/cpg.c:41:17: warning: passing argument 1 of =E2=80=
=98ioread8=E2=80=99
> >         discards =E2=80=98const=E2=80=99 qualifier from pointer target =
type [-Wdiscarded-qualifiers]
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> Thanks for your patch!
>
> > --- a/drivers/sh/clk/cpg.c
> > +++ b/drivers/sh/clk/cpg.c
> > @@ -36,17 +36,17 @@ static void sh_clk_write(int value, struct clk *clk=
)
> >                 iowrite32(value, clk->mapped_reg);
> >  }
> >
> > -static unsigned int r8(const void __iomem *addr)
> > +static unsigned int r8(void __iomem *addr)
> >  {
> >         return ioread8(addr);
> >  }
>
> Isn't the real issue that some implementations of ioreadX() take const,
> while others don't?
>
> Even the generic ones disagree:
>
>     include/asm-generic/io.h:static inline u8 ioread8(const volatile
> void __iomem *addr)
>     include/asm-generic/iomap.h:extern unsigned int ioread8(void __iomem =
*);
>
> IMHO they all should take "const volatile void __iomem *".

Since this is a SuperH driver, I adjusted it to the SuperH
implementation - lack of const. However iIndeed it makes sense to have
them all taking "const"... Let me check, if I can fix it (without the
real HW).

Best regards,
Krzysztof
