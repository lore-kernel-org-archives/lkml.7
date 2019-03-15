Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524B5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 295FC217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbfCONsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 09:48:13 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:56031 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbfCONsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 09:48:13 -0400
X-Originating-IP: 90.88.22.102
Received: from aptenodytes (aaubervilliers-681-1-80-102.w90-88.abo.wanadoo.fr [90.88.22.102])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 3D92224000E;
        Fri, 15 Mar 2019 13:48:08 +0000 (UTC)
Message-ID: <3206b448f031ce22acc2db979781f19c1dded20c.camel@bootlin.com>
Subject: Re: [linux-sunxi] [PATCH 3/6] drm/sun4i: dsi: Add bridge support
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     jagan@amarulasolutions.com, Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com, linux-amarula@amarulasolutions.com
Date:   Fri, 15 Mar 2019 14:48:07 +0100
In-Reply-To: <20190315134555.ekpywymjx3xqmdhf@flea>
References: <20190315130825.9005-1-jagan@amarulasolutions.com>
         <20190315130825.9005-4-jagan@amarulasolutions.com>
         <c232d5620d6a3272a6064ce9ccdec5c86a3a7950.camel@bootlin.com>
         <20190315134555.ekpywymjx3xqmdhf@flea>
Organization: Bootlin
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2019-03-15 at 14:45 +0100, Maxime Ripard wrote:
> On Fri, Mar 15, 2019 at 02:32:55PM +0100, Paul Kocialkowski wrote:
> > Hi,
> > 
> > On Fri, 2019-03-15 at 18:38 +0530, Jagan Teki wrote:
> > > Some display panels would come up with a non-DSI output which
> > > can have an option to connect DSI interface by means of bridge
> > > convertor.
> > > 
> > > This DSI to non-DSI bridge convertor would require a bridge
> > > driver that would communicate the DSI controller for bridge
> > > functionalities.
> > > 
> > > So, add support for bridge functionalities in Allwinner DSI
> > > controller.
> > 
> > See a few comments below.
> > 
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > ---
> > >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 65 +++++++++++++++++++-------
> > >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h |  1 +
> > >  2 files changed, 49 insertions(+), 17 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > index 0960b96b62cc..64d74313b842 100644
> > > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > @@ -781,6 +781,9 @@ static void sun6i_dsi_encoder_enable(struct drm_encoder *encoder)
> > >  	if (!IS_ERR(dsi->panel))
> > >  		drm_panel_prepare(dsi->panel);
> > >  
> > > +	if (!IS_ERR(dsi->bridge))
> > > +		drm_bridge_pre_enable(dsi->bridge);
> > > +
> > >  	/*
> > >  	 * FIXME: This should be moved after the switch to HS mode.
> > >  	 *
> > > @@ -796,6 +799,9 @@ static void sun6i_dsi_encoder_enable(struct drm_encoder *encoder)
> > >  	if (!IS_ERR(dsi->panel))
> > >  		drm_panel_enable(dsi->panel);
> > >  
> > > +	if (!IS_ERR(dsi->bridge))
> > > +		drm_bridge_enable(dsi->bridge);
> > > +
> > >  	sun6i_dsi_start(dsi, DSI_START_HSC);
> > >  
> > >  	udelay(1000);
> > > @@ -812,6 +818,9 @@ static void sun6i_dsi_encoder_disable(struct drm_encoder *encoder)
> > >  	if (!IS_ERR(dsi->panel)) {
> > >  		drm_panel_disable(dsi->panel);
> > >  		drm_panel_unprepare(dsi->panel);
> > > +	} else if (!IS_ERR(dsi->bridge)) {
> > > +		drm_bridge_disable(dsi->bridge);
> > > +		drm_bridge_post_disable(dsi->bridge);
> > >  	}
> > >  
> > >  	phy_power_off(dsi->dphy);
> > > @@ -973,11 +982,16 @@ static int sun6i_dsi_attach(struct mipi_dsi_host *host,
> > >  	struct sun6i_dsi *dsi = host_to_sun6i_dsi(host);
> > >  
> > >  	dsi->device = device;
> > > -	dsi->panel = of_drm_find_panel(device->dev.of_node);
> > > -	if (IS_ERR(dsi->panel))
> > > -		return PTR_ERR(dsi->panel);
> > >  
> > > -	dev_info(host->dev, "Attached device %s\n", device->name);
> > > +	dsi->bridge = of_drm_find_bridge(device->dev.of_node);
> > > +	if (!dsi->bridge) {
> > 
> > You are using IS_ERR to check that the bridge is alive in the changes
> > above, but switch to checking that it's non-NULL at this point.
> > 
> > Are both guaranteed to be interchangeable?
> 
> They aren't. Any ERR_PTR will be !NULL
> 
> > > +		dsi->panel = of_drm_find_panel(device->dev.of_node);
> > > +		if (IS_ERR(dsi->panel))
> > > +			return PTR_ERR(dsi->panel);
> > > +	}
> > 
> > You should probably use drm_of_find_panel_or_bridge instead of
> > duplicating the logic here.
> 
> Or we can even use the drm_panel_bridge_add to simplify things.

Indeed, I was just looking at that and it seems to be specifically
tailored for this use case.

Cheers,

Paul

-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

