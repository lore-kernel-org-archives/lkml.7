Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D7CC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF83D206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564498762;
	bh=GN5JgO500Q88w3MjuWFls/YYFLEYpuIuhF/ihvdE2W0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Nyh0zJ+zmAvMOlV66kTrMAcNGtmht0O8GeoCDhpm1zzd5rH3Ux4y+kQfo5tXde3/C
	 YBW0fyoiG7Tbk2XjeETvFsAPHwYs9J8hhAYzP53cdeAAcxIuT/2bXDyB67jwceDJJd
	 Uv1nKiW5ZDeq47Fx/YEr+ZR3vjWA4sLpWVVyAmvU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731926AbfG3O7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 10:59:21 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55072 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728526AbfG3O7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 10:59:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=q2mZoui6udBRuKFOD8sPcNVwLKdo8WonOPR0Qr0qLl4=; b=sUh6HbsLaMglxXUyFaT4PAHWh
        vaWqy21YTyot3IWcSwMCKn4FZtxyh7WK34XkfZYzHfhF+xUbR38l615/+14u5hWOAzzOFDaC6FJgP
        ffnYJkCqITJOnP9Xm1a++tPWjMkes1yrONBiFp3GY3OHwl3T21WNi7+xsNfLz0gdwI90A=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hsTaP-0007nU-8e; Tue, 30 Jul 2019 14:58:45 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 540752742CB5; Tue, 30 Jul 2019 15:58:44 +0100 (BST)
Date:   Tue, 30 Jul 2019 15:58:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Thomas Preston <thomas.preston@codethink.co.uk>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Kirill Marinushkin <kmarinushkin@birdec.tech>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Vinod Koul <vkoul@kernel.org>,
        Annaliese McDermond <nh6z@nh6z.net>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Patrick Glaser <pglaser@tesla.com>,
        Rob Duncan <rduncan@tesla.com>, Nate Case <ncase@tesla.com>
Subject: Re: [PATCH v2 2/3] ASoC: Add codec driver for ST TDA7802
Message-ID: <20190730145844.GI4264@sirena.org.uk>
References: <20190730120937.16271-1-thomas.preston@codethink.co.uk>
 <20190730120937.16271-3-thomas.preston@codethink.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="poJSiGMzRSvrLGLs"
Content-Disposition: inline
In-Reply-To: <20190730120937.16271-3-thomas.preston@codethink.co.uk>
X-Cookie: Times approximate.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--poJSiGMzRSvrLGLs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 30, 2019 at 01:09:36PM +0100, Thomas Preston wrote:

> index 000000000000..0f82a88bc1a4
> --- /dev/null
> +++ b/sound/soc/codecs/tda7802.c
> @@ -0,0 +1,509 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * tda7802.c  --  codec driver for ST TDA7802

Please make the entire comment a C++ one so this looks intentional.

> +static int tda7802_digital_mute(struct snd_soc_dai *dai, int mute)
> +{
> +	const u8 mute_disabled = mute ? 0 : IB2_DIGITAL_MUTE_DISABLED;

Please write normal conditional statements to make the code easier to
read.

> +	case SND_SOC_BIAS_STANDBY:
> +		err = regulator_enable(tda7802->enable_reg);
> +		if (err < 0) {
> +			dev_err(component->dev, "Could not enable.\n");
> +			return err;
> +		}
> +		dev_dbg(component->dev, "Regulator enabled\n");
> +		msleep(ENABLE_DELAY_MS);

Is this delay needed by the device or is it for the regulator to ramp?
If it's for the regulator to ramp then the regulator should be doing it.

> +	case SND_SOC_BIAS_OFF:
> +		regcache_mark_dirty(component->regmap);

If the regulator is going off you should really be marking the device as
cache only.

> +		err = regulator_disable(tda7802->enable_reg);
> +		if (err < 0)
> +			dev_err(component->dev, "Could not disable.\n");

Any non-zero value from regulator_disable() is an error, there's similar
error checking issues in other places.

> +static const struct snd_kcontrol_new tda7802_snd_controls[] = {
> +	SOC_SINGLE("Channel 4 Tristate", TDA7802_IB0, 7, 1, 0),
> +	SOC_SINGLE("Channel 3 Tristate", TDA7802_IB0, 6, 1, 0),
> +	SOC_SINGLE("Channel 2 Tristate", TDA7802_IB0, 5, 1, 0),
> +	SOC_SINGLE("Channel 1 Tristate", TDA7802_IB0, 4, 1, 0),

These look like simple on/off switches so should have Switch at the end
of the control name.  It's also not clear to me why this is exported to
userspace - why would this change at runtime and won't any changes need
to be coordinated with whatever else is connected to the signal?

> +	SOC_ENUM("Mute time", mute_time),
> +	SOC_SINGLE("Unmute channels 1 & 3", TDA7802_IB2, 4, 1, 0),
> +	SOC_SINGLE("Unmute channels 2 & 4", TDA7802_IB2, 3, 1, 0),

These are also Switch controls.  There are *lots* of problems with
control names, see control-names.rst.

> +static const struct snd_soc_component_driver tda7802_component_driver = {
> +	.set_bias_level = tda7802_set_bias_level,
> +	.idle_bias_on = 1,

Any reason to keep the device powered up?  It looks like the power on
process is just powering things up and writing the register cache out
and there's not that many registers so the delay is trivial.

> +	tda7802->enable_reg = devm_regulator_get(dev, "enable");
> +	if (IS_ERR(tda7802->enable_reg)) {
> +		dev_err(dev, "Failed to get enable regulator\n");

It's better to print error codes if you have them and are printing a
diagnostic so people have more to go on when debugging problems.

--poJSiGMzRSvrLGLs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1AWyMACgkQJNaLcl1U
h9CSRAf+JnRHblFvE8wz05/KmaqsoJ72DsJH6tOksd0/ifd52UjtRhoB3jIhVaR2
lJtx2+K9jHM8Q/tEBDNGXlzFt7MoUcvfgHfvAZ0Mfbkfvoox60KTJnh2C1B+Yr7i
TIVNSQJSN+NtdtSYs2BaFkk/Zrj7Q9kDj7BHHOBeK7fDkq8PTRdLHU1YjB+HlrTT
nRXLv1mXRa1cI+caoQRIXcQEOmW+VLlMasEFiSNS/0I3UtHgn2UHezS3Z+MHUJ4F
TOmV2MyA/S4wW70Cus6iZs7BO0aCYLQFJmFgtd0t+C3nMKvSILwBWidIzK9WYuc6
CeQAgukY5VCt+NmFvl4l2irCODm7Bg==
=Gl9u
-----END PGP SIGNATURE-----

--poJSiGMzRSvrLGLs--
