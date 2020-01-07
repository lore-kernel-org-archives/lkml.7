Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6262AC33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 13:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38A3D2081E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 13:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578403984;
	bh=STfBZXnkqTSTEpUcr5/2/iHrX6scyOv4v8L4omm+Bi8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ew4JN+90W0EmX1B0wZmhsgHpuyTcog2XYfGRscdz93++eL0lxA7BRjjGuuHf8VHFW
	 H1uivi6UgFKMnA585rSNih/lrbhjpoIiaBwQQLq4rVVLNHDseJornfOyRWd95038h+
	 Jth9ywyOLmmJEmlsgakdYcpNtlDeI8kzk/m2sh7c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbgAGNdD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 08:33:03 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35194 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727959AbgAGNdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 08:33:01 -0500
Received: by mail-ed1-f67.google.com with SMTP id f8so6793629edv.2;
        Tue, 07 Jan 2020 05:33:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pwQBt0e96jtNHxOuZgzdGdXnbx40udEIwW5CMKe5MvI=;
        b=iGwLcrq/WdFf8HuwiY+fX7Ok3vV0FHa6FBVT57eS33X+870plUo2DlUYcmnvITo9ft
         gNjhVlBWNx3PP2aNnQxC0IPfKgwI54iJVVTpaxOtWUKF7YvcYHDD2BB43AFMMZrUpM4R
         FnFKh7Gf0RTF+zYx5tP3YwWfE3uiH4ERisFlXRwlXY3q3ayj0gF5HUbHKIzYWAc/tpPs
         mMr4v6Ulp1PwMG6L3ka8SY5Uo+OhLUBqEzPWTG/oK6VNw5Qb5wmts2fGevFTPBGFUT5j
         XOlqrkyFc/HGD0lGhBmVHkcxv+oy0g790HhFrA4lB+PoOBabyhwEHJ+BsO2i6160jwhB
         TCXQ==
X-Gm-Message-State: APjAAAWxUXYsByUmYB27Ffuos4OG90Dfjzi1Jg7ABEX7G8JEeHeO0B2/
        Ip1Qru7a7IyJpqY8iK1UIh0=
X-Google-Smtp-Source: APXvYqy5u4qGiRiMpC2dS9D7/45j6Cx25ZLH25nmZfAmt/7A2dDgZk2q0kwniQBGTUOMt+VdIH/o2A==
X-Received: by 2002:a50:fc99:: with SMTP id f25mr114269076edq.250.1578403979322;
        Tue, 07 Jan 2020 05:32:59 -0800 (PST)
Received: from pi3 ([194.230.155.149])
        by smtp.googlemail.com with ESMTPSA id v2sm8019498ejj.44.2020.01.07.05.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 05:32:58 -0800 (PST)
Date:   Tue, 7 Jan 2020 14:32:56 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] sh: clk: Fix discarding const qualifier warning
Message-ID: <20200107133256.GA648@pi3>
References: <1578399963-2229-1-git-send-email-krzk@kernel.org>
 <CAMuHMdULcBE1inRzTRFJeRDToT1wW+nrMEfiUs7DxMLR0tqb3w@mail.gmail.com>
 <CAJKOXPcbUfUcmU2O50M5Hs2y6ggg-m5qU-AJ6HjSL9dFTCp64A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAJKOXPcbUfUcmU2O50M5Hs2y6ggg-m5qU-AJ6HjSL9dFTCp64A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 02:05:14PM +0100, Krzysztof Kozlowski wrote:
> On Tue, 7 Jan 2020 at 14:00, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > Hi Krzysztof,
> >
> > On Tue, Jan 7, 2020 at 1:26 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > ioreadX() accepts pointer to non-const memory.  This fixes warnings
> > > like:
> > >
> > >     drivers/sh/clk/cpg.c: In function ‘r8’:
> > >     drivers/sh/clk/cpg.c:41:17: warning: passing argument 1 of ‘ioread8’
> > >         discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
> > >
> > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> >
> > Thanks for your patch!
> >
> > > --- a/drivers/sh/clk/cpg.c
> > > +++ b/drivers/sh/clk/cpg.c
> > > @@ -36,17 +36,17 @@ static void sh_clk_write(int value, struct clk *clk)
> > >                 iowrite32(value, clk->mapped_reg);
> > >  }
> > >
> > > -static unsigned int r8(const void __iomem *addr)
> > > +static unsigned int r8(void __iomem *addr)
> > >  {
> > >         return ioread8(addr);
> > >  }
> >
> > Isn't the real issue that some implementations of ioreadX() take const,
> > while others don't?
> >
> > Even the generic ones disagree:
> >
> >     include/asm-generic/io.h:static inline u8 ioread8(const volatile
> > void __iomem *addr)
> >     include/asm-generic/iomap.h:extern unsigned int ioread8(void __iomem *);
> >
> > IMHO they all should take "const volatile void __iomem *".
> 
> Since this is a SuperH driver, I adjusted it to the SuperH
> implementation - lack of const. However iIndeed it makes sense to have
> them all taking "const"... Let me check, if I can fix it (without the
> real HW).

That will be non-trivial because many platforms define ioreadX() with
non-const. For example entire alpha with many its implementations of
ioread(). Even include/asm-generic/iomap.h defines them as non-const...

Best regards,
Krzysztof

