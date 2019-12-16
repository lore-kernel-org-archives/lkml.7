Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752FDC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 13:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CED620409
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 13:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbfLPNsQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 08:48:16 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:50891 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbfLPNsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 08:48:15 -0500
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 351A2C0003;
        Mon, 16 Dec 2019 13:48:11 +0000 (UTC)
Date:   Mon, 16 Dec 2019 14:48:10 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH] drm/panel: simple: Support reset GPIOs
Message-ID: <20191216144810.18710ed3@xps13>
In-Reply-To: <20191216132732.mmqivmpnq4mio6oo@gilmour.lan>
References: <20191213181325.26228-1-miquel.raynal@bootlin.com>
        <20191216130615.qs6ub7bwqofwvhr7@gilmour.lan>
        <20191216141036.24c22899@xps13>
        <20191216132732.mmqivmpnq4mio6oo@gilmour.lan>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

Maxime Ripard <maxime@cerno.tech> wrote on Mon, 16 Dec 2019 14:27:32
+0100:

> On Mon, Dec 16, 2019 at 02:10:36PM +0100, Miquel Raynal wrote:
> > > >  drivers/gpu/drm/panel/panel-simple.c | 12 +++++++++++-
> > > >  1 file changed, 11 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> > > > index 5d487686d25c..15dd495c347d 100644
> > > > --- a/drivers/gpu/drm/panel/panel-simple.c
> > > > +++ b/drivers/gpu/drm/panel/panel-simple.c
> > > > @@ -110,6 +110,7 @@ struct panel_simple {
> > > >  	struct i2c_adapter *ddc;
> > > >
> > > >  	struct gpio_desc *enable_gpio;
> > > > +	struct gpio_desc *reset_gpio;
> > > >
> > > >  	struct drm_display_mode override_mode;
> > > >  };
> > > > @@ -433,12 +434,21 @@ static int panel_simple_probe(struct device *dev, const struct panel_desc *desc)
> > > >  	if (IS_ERR(panel->supply))
> > > >  		return PTR_ERR(panel->supply);
> > > >
> > > > +	panel->reset_gpio = devm_gpiod_get_optional(dev, "reset",
> > > > +						    GPIOD_OUT_LOW);
> > > > +	if (IS_ERR(panel->reset_gpio)) {
> > > > +		err = PTR_ERR(panel->reset_gpio);
> > > > +		if (err != -EPROBE_DEFER)
> > > > +			dev_err(dev, "failed to request reset pin: %d\n", err);
> > > > +		return err;
> > > > +	}
> > > > +  
> > >
> > > However, I'm wondering if it wouldn't be better to just have the
> > > device maintained in reset at probe (so OUT_HIGH) and moved out of
> > > reset during either the prepare or enable callbacks.
> > >
> > > This is pretty much what is happening with the enable-gpios already.
> > >
> > > Also, panels usually need to wait for a minimum time after you
> > > deassert the reset line. How is that dealt with?
> > >
> > > I guess a good way to do that would be to add that duration to the
> > > panel description, since this is pretty much device specific.  
> >
> > What about the case were your Bootloader displays something and you
> > don't want the panel to blink ?  
> 
> The Bootloader to Linux transition will make the panel blink already,
> since the display engine is going to be reset / reconfigured during
> the transition.
> 
> The only way to implement this would be to implement properly the
> reset callbacks in all you display drivers to recreate the DRM state
> from the hardware state, and then you'll be able to just switch to the
> new buffer.
> 
> Only Intel does this at the time though, and that's way outside of the
> scope of this patch...
> 
> > Right now I am just forcing the reset to be deasserted.  
> 
> ... Especially since the very next line after your patch forces the
> panel to be disabled.
> 

Is the addition of the reset support (as proposed by Maxime)
interesting from your point of view? As you answered that you were not
understanding the needs for such a change, I prefer to ask before
spending more time on it.


Thanks,
Miquèl
