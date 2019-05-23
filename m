Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A43C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 12:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C91D221019
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 12:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730662AbfEWMpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 08:45:34 -0400
Received: from verein.lst.de ([213.95.11.211]:46617 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729698AbfEWMpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 08:45:33 -0400
Received: by newverein.lst.de (Postfix, from userid 2005)
        id 139CB68AFE; Thu, 23 May 2019 14:45:09 +0200 (CEST)
Date:   Thu, 23 May 2019 14:45:08 +0200
From:   Torsten Duwe <duwe@lst.de>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Sean Paul <seanpaul@chromium.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Harald Geyer <harald@ccbib.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] drm/bridge: Add Analogix anx6345 support
Message-ID: <20190523124508.GC15685@lst.de>
References: <20190523065013.2719D68B05@newverein.lst.de> <20190523065356.0734568BFE@newverein.lst.de> <20190523075041.GC4745@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523075041.GC4745@pendragon.ideasonboard.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 10:50:41AM +0300, Laurent Pinchart wrote:
> Hi Torsten,
> 
> Thank you for the patch.

Thank you for the thorough review!

> On Thu, May 23, 2019 at 08:53:56AM +0200, Torsten Duwe wrote:
> > +{
> > +	struct anx6345 *anx6345 = connector_to_anx6345(connector);
> > +	int err, num_modes = 0;
> > +	bool power_off = false;
> > +
> > +	mutex_lock(&anx6345->lock);
> > +
> > +	if (!anx6345->edid) {
> 
> Could the chip be used with a hot-pluggable display, or is it guaranteed
> that EDID will never change ?

The chip itself is capable of (e)DP hot-plugging, so the signals suggest.
See the previous discussions about what to expect on the output side.
Currently, the driver does not handle hot-plugging.

> > +
> > +	err = drm_of_find_panel_or_bridge(client->dev.of_node, 1, 0,
> > +					  &anx6345->panel, NULL);
> > +	if (err == -EPROBE_DEFER)
> > +		return err;
> > +
> > +	if (err)
> > +		DRM_DEBUG("No panel found\n");
> 
> Shouldn't this be fatal ?

No, basically same as above. On the output side, there can be a panel,
another bridge, or some eDP plug. If the DT didn't explicitly specify
a panel or a bridge, we can still generate video output as soon as
there is valid EDID data.

Your other points went straight onto my TODO list.

	Torsten

