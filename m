Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1F9C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 02:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02FF82067B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 02:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="SULQ0aUL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfKKCgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 21:36:52 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45149 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbfKKCgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 21:36:50 -0500
Received: by mail-ed1-f66.google.com with SMTP id b5so10692259eds.12
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2019 18:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EUrEftNBotZRmamMjZf+7wcByK3TrrvQAevsRHHxM3I=;
        b=SULQ0aULd3u/aCVWCLj80EWv6uLHoH1+hM5ggFrAQWk1GFNACw4lmf3XOfCENV0g/1
         yeCgNQWqxExHQG3gDHEFYxDjh+mlmv4Outtmhz+0iyXk/V9Rg7S+CBJhiMrCyJckRKZf
         ijwIKkmyYlab5CXkTSELrhYTEx75v9cFBQ0xZNZH29czgav++1w9gENnJx+VpizgmLVL
         r8GP+WDcSVDQH04gvFIVz1Jkv0vQXf5SZgDs98ex7srehIB50gJQn81XCNEGSy/Ndoi9
         FyfKZ+ifsvpWmZRiQY8Zi+QAmP/KRKQVaWj9wLT0ui6DTzcTxs0R3DLgtEDkZuP9kEMV
         CaGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EUrEftNBotZRmamMjZf+7wcByK3TrrvQAevsRHHxM3I=;
        b=la7LNU4JkAWafRfPPc5fxC2NxJsaWNCWJYzsTyf5hc+en5IHA2IZAchGp5k8gVMAzR
         2FCDuDD4DIz2dWJzy8K5Jg4Ve0nyHhEOioEW5FErWm8dsaPJOZKfr+KRR1WUh/K6PMg3
         1v2aCSNRhfhq3CfOqQHZ7G63BRLjF+c7/p1c8Lf85c1YCg8kkz18LcWAk7CyJLoqNDPc
         wNG15EYOWYv0czCDldpWXkqIje1uRw84GcfKiiuZp+ir/UG1G8tE8gPOvOacIWgm1rRi
         9Oip1Fj0TbpJ7kDzWcGmCsUA949iNR7w2LyBNhyP7fFyJ6/7HQAM+yvaX2m9W5e4U/nw
         QgBg==
X-Gm-Message-State: APjAAAU5J3irb6faMk+vy5BhmxRp1VslHmVTD+nEqcjMVzDSBMq1AP7T
        CGYmScBpoiPef7e52VaTa0cbB++gBtRn9Tf+NKKv5g==
X-Google-Smtp-Source: APXvYqw01OaHjEqaML0Q/wUNAOq5QSeReweaP1MtIZ0zQhqqMHFhtOuJhxTLbtcM/0e284Nxk12KxX+fZnfjA8uUHOU=
X-Received: by 2002:a17:906:4dd5:: with SMTP id f21mr20454702ejw.203.1573439808834;
 Sun, 10 Nov 2019 18:36:48 -0800 (PST)
MIME-Version: 1.0
References: <20191111004211.96425-1-olof@lixom.net> <20191111023255.GY25889@lunn.ch>
In-Reply-To: <20191111023255.GY25889@lunn.ch>
From:   Olof Johansson <olof@lixom.net>
Date:   Sun, 10 Nov 2019 18:36:35 -0800
Message-ID: <CAOesGMgokhLiTnAc7b04FPYY=i7ehCE5a3jJaj4j_UDuqR_DHA@mail.gmail.com>
Subject: Re: [PATCH] net: mdio-octeon: Fix pointer/integer casts
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10, 2019 at 6:32 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Sun, Nov 10, 2019 at 04:42:11PM -0800, Olof Johansson wrote:
> > Fixes a bunch of these warnings on arm allmodconfig:
> >
> > In file included from /build/drivers/net/phy/mdio-cavium.c:11:
> > /build/drivers/net/phy/mdio-cavium.c: In function 'cavium_mdiobus_set_mode':
> > /build/drivers/net/phy/mdio-cavium.h:114:37: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
> >   114 | #define oct_mdio_readq(addr)  readq((void *)addr)
> >       |                                     ^
> > /build/drivers/net/phy/mdio-cavium.c:21:16: note: in expansion of macro 'oct_mdio_readq'
> >    21 |  smi_clk.u64 = oct_mdio_readq(p->register_base + SMI_CLK);
> >       |                ^~~~~~~~~~~~~~
> >
> > Fixes: 171a9bae68c7 ("staging/octeon: Allow test build on !MIPS")
> > Signed-off-by: Olof Johansson <olof@lixom.net>
> > ---
> >  drivers/net/phy/mdio-cavium.h  | 14 +++++++-------
> >  drivers/net/phy/mdio-octeon.c  |  5 ++---
> >  drivers/net/phy/mdio-thunder.c |  2 +-
> >  3 files changed, 10 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/net/phy/mdio-cavium.h b/drivers/net/phy/mdio-cavium.h
> > index b7f89ad27465f..1cf81f0bc585f 100644
> > --- a/drivers/net/phy/mdio-cavium.h
> > +++ b/drivers/net/phy/mdio-cavium.h
> > @@ -90,7 +90,7 @@ union cvmx_smix_wr_dat {
> >
> >  struct cavium_mdiobus {
> >       struct mii_bus *mii_bus;
> > -     u64 register_base;
> > +     void __iomem *register_base;
> >       enum cavium_mdiobus_mode mode;
> >  };
> >
> > @@ -98,20 +98,20 @@ struct cavium_mdiobus {
> >
> >  #include <asm/octeon/octeon.h>
> >
> > -static inline void oct_mdio_writeq(u64 val, u64 addr)
> > +static inline void oct_mdio_writeq(u64 val, void __iomem *addr)
> >  {
> > -     cvmx_write_csr(addr, val);
> > +     cvmx_write_csr((u64)addr, val);
> >  }
>
> Hi Olof
>
> Humm. The warning goes away, but is it really any better?
>
> Did you try also changing the stub function in
> drivers/staging/octeon/octeon-stubs.h so it takes void __iomem?  Or
> did that cause a lot more warnings from other places?

That percolates through a bunch of MIPS code that I didn't feel like
getting into. So indeed, I stopped at that point.


-Olof
