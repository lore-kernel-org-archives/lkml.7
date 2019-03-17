Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF7BC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 15:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D558B21019
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 15:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="otd8Jp2T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfCQPsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 11:48:31 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:56471 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727400AbfCQPs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 11:48:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=tBIhQIi4ZTn01iZjkTLI+q7SovrG/d/r+dxu3j6bFWw=; b=otd8Jp2TWzGB0l0rUPiUMNr8Pi
        nkIAfy4eUKD8g3qd96ZYrX9WSDdiEg00NlzQidopMRH+uTkADGPU2IZxKf71wy2NbRuqUZvVigM9R
        vGr9AdB3tgUzVNj3eMCqOIvBfEXSGG8k/MzmgXcEs5I3a7fm846hnAjsgN+xW3cT2kPU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1h5Y1N-0005y3-B5; Sun, 17 Mar 2019 16:48:21 +0100
Date:   Sun, 17 Mar 2019 16:48:21 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Kevin Hilman <khilman@baylibre.com>, netdev@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] net: phy: add amlogic g12a mdio mux support
Message-ID: <20190317154821.GA22226@lunn.ch>
References: <20190314140135.19184-1-jbrunet@baylibre.com>
 <20190314140135.19184-3-jbrunet@baylibre.com>
 <20190316025448.GD29548@lunn.ch>
 <13432d537f671c8065693b7e53348f812e8bbc04.camel@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13432d537f671c8065693b7e53348f812e8bbc04.camel@baylibre.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2019 at 06:02:45PM +0100, Jerome Brunet wrote:
> On Sat, 2019-03-16 at 03:54 +0100, Andrew Lunn wrote:
> > On Thu, Mar 14, 2019 at 03:01:34PM +0100, Jerome Brunet wrote:
> > > > +static int _g12a_enable_internal_mdio(struct g12a_mdio_mux *priv)
> > 
> > You would generally use the _ prefix when you have a locked and an
> > unlocked version. I don't see anything like this here. So please drop
> > the _ .
> > 
> 
> will do
> 
> > Nice to see the generic clock framework being used. I just wonder if
> > this is the correct place to have this clock code. Can it be made part
> > of the SoC clock code?
> 
> the PLL is local to this particular device.
> 
> In 'Soc clock code' (driver/clk/meson in this case) we usually put clock
> controllers. Those controllers feeds the different devices of the SoC but we
> tends some more clock elements in the consumer device
> 
> Usually, it is just a few mux, dividers and gates (like in
> drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c) but in this case, we have
> a PLL. IMO, it belongs here. Do you see a problem with this ?

Hi Jerome

Some maintainers like to have code in their directory structure. It
would be good to check that the clock maintainer in happy with clock
code under the network driver subtree. Also, the clock maintainer
should also review this code. So please at least Cc: the clock
maintainer and clock list on the next submission, as well as netdev. I
personally don't know the clock code well enough to review such code.

	   Andrew
