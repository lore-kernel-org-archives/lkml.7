Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD10C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 12:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9E9B20857
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 12:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PYZeGXAc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfDIMPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 08:15:06 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:55091 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726535AbfDIMPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 08:15:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=5MD0QGE8HMnZEwh9ib4ODjfQ8egR2VR1Li2Ef+UBmAs=; b=PYZeGXAcN63LYcpv9rA7OuOhri
        mDkT1Z9Rvf9TisRXrESWeAAvb89wf3Ta63+cBtt/8+ZzH+zKQ7rOrOLogG9j6fhe0qeLK6nKaoVQl
        Rvdli2XzCOx0Teo/g2QQfmqccPfDVYs9sImzVtYHeih+9J/W6vCaEbpXp4c0C3b9Y4q8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hDpeQ-000409-9B; Tue, 09 Apr 2019 14:14:54 +0200
Date:   Tue, 9 Apr 2019 14:14:54 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>
Subject: Re: [PATCH net-next v3] net: dsa: mv88e6xxx: Prevent suspend to RAM
Message-ID: <20190409121454.GB28742@lunn.ch>
References: <20190205110728.11451-1-miquel.raynal@bootlin.com>
 <20190408215540.GA27929@amd>
 <20190409090643.0d8ce19a@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409090643.0d8ce19a@xps13>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 09:06:43AM +0200, Miquel Raynal wrote:
> Hi Pavel,
> 
> Pavel Machek <pavel@ucw.cz> wrote on Mon, 8 Apr 2019 23:55:41 +0200:
> 
> > On Tue 2019-02-05 12:07:28, Miquel Raynal wrote:
> > > On one hand, the mv88e6xxx driver has a work queue called in loop
> > > which will attempt register accesses after MDIO bus suspension, that
> > > entirely freezes the platform during suspend.
> > > 
> > > On the other hand, the DSA core is not ready yet to support suspend to
> > > RAM operation because so far there is no way to recover reliably the
> > > switch configuration.
> > > 
> > > To avoid the kernel to freeze when suspending with a switch driven by
> > > the mv88e6xxx driver, we choose to prevent the driver suspension and
> > > in the same way, the whole platform.
> > > 
> > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>  
> > 
> > Could we at least do printk() so that user knows what went wrong?
> > 
> > Debugging s2ram is usually not easy :-(.
> 
> I suppose you will be told that suspend was refused by a driver
> (probably without stating which one though). You may send a patch to add
> a trace if you think it is important, as this change as already been
> merged.

Hi Miquel, Pavel

I don't know the s2ram code at all, but this seems like a generic
problem. The core should be reporting which driver returned an error,
not the driver itself.

    Andrew
