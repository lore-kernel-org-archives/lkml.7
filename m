Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDB8C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 06:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB15206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 06:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfGaGIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 02:08:38 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48429 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725209AbfGaGIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 02:08:38 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1hshlD-0001W1-99; Wed, 31 Jul 2019 08:06:51 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1hshl6-0004Dx-RL; Wed, 31 Jul 2019 08:06:44 +0200
Date:   Wed, 31 Jul 2019 08:06:44 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Thomas Preston <thomas.preston@codethink.co.uk>
Cc:     Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Kirill Marinushkin <kmarinushkin@birdec.tech>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Takashi Iwai <tiwai@suse.com>,
        Annaliese McDermond <nh6z@nh6z.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Nate Case <ncase@tesla.com>, Rob Duncan <rduncan@tesla.com>,
        Patrick Glaser <pglaser@tesla.com>,
        linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [alsa-devel] [PATCH v2 2/3] ASoC: Add codec driver for ST TDA7802
Message-ID: <20190731060644.yrewu2kvrlootyyl@pengutronix.de>
References: <20190730120937.16271-1-thomas.preston@codethink.co.uk>
 <20190730120937.16271-3-thomas.preston@codethink.co.uk>
 <20190730145844.GI4264@sirena.org.uk>
 <fe11c806-2285-558c-e35c-d8f61de00784@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe11c806-2285-558c-e35c-d8f61de00784@codethink.co.uk>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:04:35 up 74 days, 12:22, 46 users,  load average: 0.05, 0.07,
 0.03
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

again sorry for jumping in..

On 19-07-30 18:26, Thomas Preston wrote:
> On 30/07/2019 15:58, Mark Brown wrote:
> > On Tue, Jul 30, 2019 at 01:09:36PM +0100, Thomas Preston wrote:
> > 
> >> index 000000000000..0f82a88bc1a4
> >> --- /dev/null
> >> +++ b/sound/soc/codecs/tda7802.c
> >> @@ -0,0 +1,509 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * tda7802.c  --  codec driver for ST TDA7802
> > 
> > Please make the entire comment a C++ one so this looks intentional.
> > 
> 
> Ok thanks.
> 
> >> +static int tda7802_digital_mute(struct snd_soc_dai *dai, int mute)
> >> +{
> >> +	const u8 mute_disabled = mute ? 0 : IB2_DIGITAL_MUTE_DISABLED;
> > 
> > Please write normal conditional statements to make the code easier to
> > read.
> > 
> 
> On it.
> 
> >> +	case SND_SOC_BIAS_STANDBY:
> >> +		err = regulator_enable(tda7802->enable_reg);
> >> +		if (err < 0) {
> >> +			dev_err(component->dev, "Could not enable.\n");
> >> +			return err;
> >> +		}
> >> +		dev_dbg(component->dev, "Regulator enabled\n");
> >> +		msleep(ENABLE_DELAY_MS);
> > 
> > Is this delay needed by the device or is it for the regulator to ramp?
> > If it's for the regulator to ramp then the regulator should be doing it.
> > 
> 
> According to the datasheet the device itself takes 10ms to rise from 0V
> after PLLen is enabled. There are additional rise times but they are
> negligible with default capacitor configuration (which we have).
> 
> Good to know about the regulator rising configuration though. Thanks.

Isn't it the regulator we mentioned to not use that because it is a
GPIO?

Regards,
  Marco

> >> +	case SND_SOC_BIAS_OFF:
> >> +		regcache_mark_dirty(component->regmap);
> > 
> > If the regulator is going off you should really be marking the device as
> > cache only.
> > 
> 
> Got it, thanks.
> 
> >> +		err = regulator_disable(tda7802->enable_reg);
> >> +		if (err < 0)
> >> +			dev_err(component->dev, "Could not disable.\n");
> > 
> > Any non-zero value from regulator_disable() is an error, there's similar
> > error checking issues in other places.
> > 
> 
> I return the error at the end of the function, but I'll bring it back here
> for consistency.
> 
> >> +static const struct snd_kcontrol_new tda7802_snd_controls[] = {
> >> +	SOC_SINGLE("Channel 4 Tristate", TDA7802_IB0, 7, 1, 0),
> >> +	SOC_SINGLE("Channel 3 Tristate", TDA7802_IB0, 6, 1, 0),
> >> +	SOC_SINGLE("Channel 2 Tristate", TDA7802_IB0, 5, 1, 0),
> >> +	SOC_SINGLE("Channel 1 Tristate", TDA7802_IB0, 4, 1, 0),
> > 
> > These look like simple on/off switches so should have Switch at the end
> > of the control name.  It's also not clear to me why this is exported to
> > userspace - why would this change at runtime and won't any changes need
> > to be coordinated with whatever else is connected to the signal?
> > 
> >> +	SOC_ENUM("Mute time", mute_time),
> >> +	SOC_SINGLE("Unmute channels 1 & 3", TDA7802_IB2, 4, 1, 0),
> >> +	SOC_SINGLE("Unmute channels 2 & 4", TDA7802_IB2, 3, 1, 0),
> > 
> > These are also Switch controls.  There are *lots* of problems with
> > control names, see control-names.rst.
> > 
> 
> Ok thanks, I didn't know about the "Switch" suffix, I will read
> control-names.rst.
> 
> I will move Tristate to DT properties. I was also unsure about the
> Impedance Efficiency Optimiser but the datasheet doesn't go into much
> detail about this so I left it exposed.
> 
> They both seemed like user configurable options in the context of a
> test rig, but I agree - who knows what this output might be connected
> to in other systems. I will lock them down in DT. Thanks.
> 
> >> +static const struct snd_soc_component_driver tda7802_component_driver = {
> >> +	.set_bias_level = tda7802_set_bias_level,
> >> +	.idle_bias_on = 1,
> > 
> > Any reason to keep the device powered up?  It looks like the power on
> > process is just powering things up and writing the register cache out
> > and there's not that many registers so the delay is trivial.
> > 
> 
> Ah no, I think that's a mistake. I want the PLLen to switch off in
> idle/suspend and the device should restore on wake.
> 
> >> +	tda7802->enable_reg = devm_regulator_get(dev, "enable");
> >> +	if (IS_ERR(tda7802->enable_reg)) {
> >> +		dev_err(dev, "Failed to get enable regulator\n");
> > 
> > It's better to print error codes if you have them and are printing a
> > diagnostic so people have more to go on when debugging problems.
> 
> Yep on it.
> 
> Many thanks, I appreciate the feedback.
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
