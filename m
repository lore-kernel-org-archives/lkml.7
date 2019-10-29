Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C8BCA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D6E521734
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HUuX5n8d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732637AbfJ2MjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 08:39:07 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:40206 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727039AbfJ2MjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 08:39:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=N+ehmygc9BxX7lvA6aGJbMWaouzap7HiKg9Ic+o14PY=; b=HUuX5n8dhPbVxklcvlDuEpP910
        2rrsNVRDtRIw8JqhZZIZtKDKW3KskJktVniS2bR6T4YczrftrnaBNVRyuIcjmxQRcvtK3FmnHGg+V
        +4Z8fxRY43XE3ox5a/XAlk7bYEsFboxxfF7KmzZqs+8P3hQUmkmNawSUeeX+B1/0i+z0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.92.2)
        (envelope-from <andrew@lunn.ch>)
        id 1iPQly-0004C1-Jz; Tue, 29 Oct 2019 13:38:54 +0100
Date:   Tue, 29 Oct 2019 13:38:54 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Jay Cliburn <jcliburn@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Chris Snook <chris.snook@gmail.com>,
        linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        "David S. Miller" <davem@davemloft.net>,
        Paul Burton <paul.burton@mips.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        James Hogan <jhogan@kernel.org>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        linux-mips@vger.kernel.org,
        Vivien Didelot <vivien.didelot@gmail.com>
Subject: Re: [PATCH v4 5/5] net: dsa: add support for Atheros AR9331 build-in
 switch
Message-ID: <20191029123854.GN15259@lunn.ch>
References: <20191022055743.6832-1-o.rempel@pengutronix.de>
 <20191022055743.6832-6-o.rempel@pengutronix.de>
 <20191023005850.GG5707@lunn.ch>
 <20191029071404.pl34q4rmadusc2u5@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029071404.pl34q4rmadusc2u5@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleksij

> > > +static void ar9331_sw_port_disable(struct dsa_switch *ds, int port)
> > > +{
> > > +	struct ar9331_sw_priv *priv = (struct ar9331_sw_priv *)ds->priv;
> > > +	struct regmap *regmap = priv->regmap;
> > > +	int ret;
> > > +
> > > +	ret = regmap_write(regmap, AR9331_SW_REG_PORT_STATUS(port), 0);
> > > +	if (ret)
> > > +		dev_err_ratelimited(priv->dev, "%s: %i\n", __func__, ret);
> > > +}
> > 
> > I've asked this before, but i don't remember the answer. Why are
> > port_enable and port_disable the same?
> 
> I have only MAC TX/RX enable bit. This bit is set by phylink_mac_link_up and
> removed by phylink_mac_link_down.
> The port enable I use only to set predictable state of the port
> register: all bits cleared. May be i should just drop port enable
> function? What do you think? 

At minimum, it needs a comment about why enable and disable are the
same. If i keep asking, others will as well.

If there is nothing useful to do, then drop it.

   Andrew

