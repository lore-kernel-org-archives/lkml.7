Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC27C43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 21:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 530DD20843
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 21:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfD1VIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 17:08:20 -0400
Received: from smtp-out.xnet.cz ([178.217.244.18]:37603 "EHLO smtp-out.xnet.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725982AbfD1VIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 17:08:20 -0400
Received: from meh.true.cz (meh.true.cz [108.61.167.218])
        (Authenticated sender: petr@true.cz)
        by smtp-out.xnet.cz (Postfix) with ESMTPSA id A0BEE3417;
        Sun, 28 Apr 2019 23:08:16 +0200 (CEST)
Received: from localhost (meh.true.cz [local])
        by meh.true.cz (OpenSMTPD) with ESMTPA id 818325c1;
        Sun, 28 Apr 2019 23:08:15 +0200 (CEST)
Date:   Sun, 28 Apr 2019 23:08:14 +0200
From:   Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Alban Bedel <albeu@free.fr>
Subject: Re: [PATCH v2 3/4] net: macb: Drop nvmem_get_mac_address usage
Message-ID: <20190428210814.GA346@meh.true.cz>
Reply-To: Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>
References: <1556456002-13430-1-git-send-email-ynezz@true.cz>
 <1556456002-13430-4-git-send-email-ynezz@true.cz>
 <20190428165637.GJ23059@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190428165637.GJ23059@lunn.ch>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Lunn <andrew@lunn.ch> [2019-04-28 18:56:37]:

Hi Andrew,

> On Sun, Apr 28, 2019 at 02:53:21PM +0200, Petr Štetiar wrote:
> > of_get_mac_address now uses NVMEM under the hood, so it's not necessary
> > to call it manually anymore.
> > 
> > Signed-off-by: Petr Štetiar <ynezz@true.cz>
> > ---
> >  drivers/net/ethernet/cadence/macb_main.c | 12 +++---------
> >  1 file changed, 3 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> > index 3da2795..1b98bc8 100644
> > --- a/drivers/net/ethernet/cadence/macb_main.c
> > +++ b/drivers/net/ethernet/cadence/macb_main.c
> > @@ -4172,16 +4172,10 @@ static int macb_probe(struct platform_device *pdev)
> >  		bp->rx_intr_mask |= MACB_BIT(RXUBR);
> >  
> >  	mac = of_get_mac_address(np);
> > -	if (mac) {
> > +	if (mac)
> >  		ether_addr_copy(bp->dev->dev_addr, mac);
> > -	} else {
> > -		err = nvmem_get_mac_address(&pdev->dev, bp->dev->dev_addr);
> > -		if (err) {
> > -			if (err == -EPROBE_DEFER)
>
> The EPRODE_DEFER is interesting here. your change to
> of_get_mac_address() does not seem to handle that case. It probably
> should. We don't want it to fail and end up with a random MAC
> addresses etc, because the NVMEM has not probed yet.

so if I understand this correctly, it probably means, that this approach with
modified of_get_mac_address is dead end as current of_get_mac_address users
don't expect and handle possible -EPROBE_DEFER error, so I would need to
change all the current users, which is nonsense.

-- ynezz
