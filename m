Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F34C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6A0021479
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfEHIg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 04:36:27 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:47104 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbfEHIg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 04:36:27 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id D5F24FB03;
        Wed,  8 May 2019 10:36:23 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uXuJkEUUAiLW; Wed,  8 May 2019 10:36:22 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 403EA47B7D; Wed,  8 May 2019 10:36:22 +0200 (CEST)
Date:   Wed, 8 May 2019 10:36:22 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thierry Reding <treding@nvidia.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Johan Hovold <johan@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>, Li Jun <jun.li@nxp.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Robert Chiras <robert.chiras@nxp.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v10 2/2] phy: Add driver for mixel mipi dphy found on
 NXP's i.MX8 SoCs
Message-ID: <20190508083622.GA3948@bogon.m.sigxcpu.org>
References: <cover.1557215047.git.agx@sigxcpu.org>
 <299e28042e0a24c0cde593873bdfb15e18187a92.1557215047.git.agx@sigxcpu.org>
 <20190507181223.GC15122@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190507181223.GC15122@ravnborg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Tue, May 07, 2019 at 08:12:23PM +0200, Sam Ravnborg wrote:
> Hi Guido.
> 
> Looks good now, stumbled upon a few details I missed in last round.
> With these considered / fixed you can add my
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> 
> 	Sam
> 
> > +#define CM(x)	(				\
> > +		((x) <	32)?0xe0|((x)-16) :	\
> > +		((x) <	64)?0xc0|((x)-32) :	\
> > +		((x) < 128)?0x80|((x)-64) :	\
> > +		((x) - 128))
> > +#define CN(x)	(((x) == 1)?0x1f : (((CN_BUF)>>((x)-1))&0x1f))
> > +#define CO(x)	((CO_BUF)>>(8-(x))&0x3)
> 
> A few spaces around the operators may help readability a little.
> 
> > +static int phy_write(struct phy *phy, u32 value, unsigned int reg)
> > +{
> > +	struct mixel_dphy_priv *priv = phy_get_drvdata(phy);
> > +	int ret;
> > +
> > +	ret = regmap_write(priv->regmap, reg, value);
> > +	if (ret < 0)
> > +		dev_err(&phy->dev, "Failed to write DPHY reg %d: %d", reg, ret);
> 
> I have recently learned that one has to remember trailign "\n"- please
> add.
> Check all other dev_xxx as I noticed the newline is missing in a few
> more places.

Argh...I thought I've fixed these up already but that was in the
corresponding NWL driver only. Fixed now, thanks.

> 
> > +
> > +	dev_dbg(&phy->dev, "hs_clk/ref_clk=%ld/%ld ⩰ %d/%d\n",
>                                                    ^
> 
> There was another of the symbols my terminal cannot show.
> 

Thanks! I've incorporated your suggestions and will send out a v11 by
the end of the week in case there's more comments coming in.
Cheers,
 -- Guido

