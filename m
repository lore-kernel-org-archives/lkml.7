Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773E8C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 16:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5593421849
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 16:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390758AbfGRQmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 12:42:11 -0400
Received: from verein.lst.de ([213.95.11.211]:60829 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728014AbfGRQmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 12:42:10 -0400
Received: by verein.lst.de (Postfix, from userid 2005)
        id 414D6227A81; Thu, 18 Jul 2019 18:42:07 +0200 (CEST)
Date:   Thu, 18 Jul 2019 18:42:07 +0200
From:   Torsten Duwe <duwe@lst.de>
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Sean Paul <seanpaul@chromium.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Harald Geyer <harald@ccbib.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] drm/bridge: Add Analogix anx6345 support
Message-ID: <20190718164207.GA29501@lst.de>
References: <20190604122150.29D6468B05@newverein.lst.de> <CGME20190604122331epcas1p45e234dfad3f1288cb557e3bae7f9af38@epcas1p4.samsung.com> <20190604122302.006A168C7B@newverein.lst.de> <610ab353-7e05-81b6-2cc4-2dac09823d42@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <610ab353-7e05-81b6-2cc4-2dac09823d42@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 11:13:10AM +0200, Andrzej Hajda wrote:
> On 04.06.2019 14:23, Torsten Duwe wrote:
> > +
> > +static void anx6345_poweron(struct anx6345 *anx6345)
> > +{
> > +	int err;
> > +
> > +	/* Ensure reset is asserted before starting power on sequence */
> > +	gpiod_set_value_cansleep(anx6345->gpiod_reset, 1);
> 
> With fixed devm_gpiod_get below this line can be removed.

In any case, reset must be asserted for this procedure to succeed...

> > +static enum drm_mode_status
> > +anx6345_bridge_mode_valid(struct drm_bridge *bridge,
> > +			  const struct drm_display_mode *mode)
> > +{
> > +	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
> > +		return MODE_NO_INTERLACE;
> > +
> > +	/* Max 1200p at 5.4 Ghz, one lane */
> > +	if (mode->clock > 154000)
> > +		return MODE_CLOCK_HIGH;
> 
> I wonder if you shouldn't take into account training results here, ie.
> training perfrormed before validation.

Sure, but this is verbatim from the anx78xx.c sibling, code provided
by analogix. Lacking in-depth datasheets, this is probably the best effort.

> > +
> > +	/* 2.5V digital core power regulator  */
> > +	anx6345->dvdd25 = devm_regulator_get(dev, "dvdd25-supply");
> > +	if (IS_ERR(anx6345->dvdd25)) {
> > +		DRM_ERROR("dvdd25-supply not found\n");
> > +		return PTR_ERR(anx6345->dvdd25);
> > +	}
> > +
> > +	/* GPIO for chip reset */
> > +	anx6345->gpiod_reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> 
> Shouldn't be set to GPIOD_OUT_HIGH?

It used to be in the original submission, and confused even more people ;-)
Fact is, the reset for this chip _is_ low active; I'm following
Documentation/devicetree/bindings/gpio/gpio.txt, "1.1) GPIO specifier
best practices", which I find rather comprehensive.

Any suggestions on how to phrase this even better are appreciated.

> > +};
> > +module_i2c_driver(anx6345_driver);
> > +
> > +MODULE_DESCRIPTION("ANX6345 eDP Transmitter driver");
> > +MODULE_AUTHOR("Enric Balletbo i Serra <enric.balletbo@collabora.com>");
> 
> Submitter, patch author, and module author are different, this can be
> correct, but maybe somebody forgot to update some of these fields.

As mentioned in the v2 cover letter, I had a closer look on which code got
actually introduced and which lines were simply copied around, and made the
copyright and authorship stick to where they belong. *I* believe this is
correct now; specific improvements welcome.

	Torsten


