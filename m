Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D152C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 12:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2414F20693
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 12:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="fqB7AJK2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730449AbfG3Mkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 08:40:49 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:33370 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727937AbfG3Mks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 08:40:48 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x6UCXjXq021707;
        Tue, 30 Jul 2019 07:38:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=6HCkdIwaoyyCwQknwT42TOpVmmhCKXspp52zKlcFeyo=;
 b=fqB7AJK2Us/yKa/m8XKIw+52gadnVyb7wkhGgZXZ7B7AtnaZ9G/IZieauUPQrSJIFunq
 AVcakZwFCfHMgrFZ2RGeUTwk6pYHPudLaO+4zgRBe2PrKUBUQlnvEYCna7j1Rka6S5aH
 WFtQmNDnSn5f9NbdnGelbYXAPzzjtxiKyMxgKecCnFzOwf9lng5uZbnf/r3IJzM1XZgH
 FJBk5wko7bplEmNTgYs5FqwZX6dDZweqQKIaaNy8RyT99epPf7l+OuKRIavO3NTIPO+L
 KK1RUHmNHWBgthQ7AnA/tJdtpZd0fSJAGRIVQHKSTC+uBmnG7d+FFJAxAqTZ+TXnBY2o cA== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 2u0mapmtdu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 30 Jul 2019 07:38:28 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Tue, 30 Jul
 2019 13:38:25 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Tue, 30 Jul 2019 13:38:25 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 06F0745;
        Tue, 30 Jul 2019 13:38:25 +0100 (BST)
Date:   Tue, 30 Jul 2019 13:38:25 +0100
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Thomas Preston <thomas.preston@codethink.co.uk>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Kirill Marinushkin <kmarinushkin@birdec.tech>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Vinod Koul <vkoul@kernel.org>,
        Annaliese McDermond <nh6z@nh6z.net>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Patrick Glaser <pglaser@tesla.com>,
        Rob Duncan <rduncan@tesla.com>, Nate Case <ncase@tesla.com>
Subject: Re: [PATCH v2 2/3] ASoC: Add codec driver for ST TDA7802
Message-ID: <20190730123825.GG54126@ediswmail.ad.cirrus.com>
References: <20190730120937.16271-1-thomas.preston@codethink.co.uk>
 <20190730120937.16271-3-thomas.preston@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190730120937.16271-3-thomas.preston@codethink.co.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1907300132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 01:09:36PM +0100, Thomas Preston wrote:
> Add an I2C based codec driver for ST TDA7802 amplifier. The amplifier
> supports 4 audio channels but can support up to 16 with multiple
> devices.
> 
> Signed-off-by: Thomas Preston <thomas.preston@codethink.co.uk>
> Cc: Patrick Glaser <pglaser@tesla.com>
> Cc: Rob Duncan <rduncan@tesla.com>
> Cc: Nate Case <ncase@tesla.com>
> ---
> Changes since v1:
> - Use ALSA kcontrol interface to expose device controls to userland
> 	- Gain
> 	- Channel diagnostic mode
> 	- Impedance efficiency optimiser. I decided against setting this
> 	  as a DT property since it seems like something that can be
> 	  changed on the fly.
> - Add regmap default values
> 	- Channel unmute by default is added in a downstream patch.
> 	- I'm not sure if I should keep this since they're all zero,
> 	  although there are other drivers will all-zero reg_defaults.
> - I believe the "//" style is used for SPDX headers in normal C source files.
>   https://lwn.net/Articles/739183/
> - Drop the "enable" sysfs device attribute.
> - Don't set TDM format using magic numbers.
> - Set sample rate using hw_params.
> - Remove unecessary defines.
> - Use DAPM to handle AMP_ON.
> - Cosmetic fixups
> 
>  sound/soc/codecs/Kconfig   |   6 +
>  sound/soc/codecs/Makefile  |   2 +
>  sound/soc/codecs/tda7802.c | 509 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 517 insertions(+)
>  create mode 100644 sound/soc/codecs/tda7802.c
> 
> +++ b/sound/soc/codecs/tda7802.c
> @@ -0,0 +1,509 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * tda7802.c  --  codec driver for ST TDA7802
> + *
> + * Copyright (C) 2016-2019 Tesla Motors, Inc.
> + */

Better to make the whole comment // see something like
sound/soc/codecs/cs47l35.c for an example.

> +static int tda7802_set_bias_level(struct snd_soc_component *component,
> +		enum snd_soc_bias_level level)
> +{
> +	const struct tda7802_priv *tda7802 =
> +		snd_soc_component_get_drvdata(component);
> +	struct snd_soc_dapm_context *dapm_context =
> +			snd_soc_component_get_dapm(component);
> +	const enum snd_soc_bias_level oldlevel =
> +		snd_soc_dapm_get_bias_level(dapm_context);
> +	int err = 0;
> +
> +	dev_dbg(component->dev, "%s level %d\n", __func__, level);
> +
> +	switch (level) {
> +	case SND_SOC_BIAS_ON:
> +		break;
> +	case SND_SOC_BIAS_PREPARE:
> +		break;
> +	case SND_SOC_BIAS_STANDBY:
> +		err = regulator_enable(tda7802->enable_reg);
> +		if (err < 0) {
> +			dev_err(component->dev, "Could not enable.\n");
> +			return err;
> +		}
> +		dev_dbg(component->dev, "Regulator enabled\n");
> +		msleep(ENABLE_DELAY_MS);
> +
> +		if (oldlevel == SND_SOC_BIAS_OFF) {
> +			dev_dbg(component->dev, "Syncing regcache\n");
> +			err = regcache_sync(component->regmap);
> +			if (err < 0)
> +				dev_err(component->dev,
> +					"Could not sync regcache, %d\n", err);

If your doing a regcache_sync I would probably have expected to
see calls to regcache_cache_only.

If the device needs syncing that implies the hardware registers
have lost state, so there is little point in writing to them
if they are unavailable/about to loose their state.

> +		}
> +		break;
> +	case SND_SOC_BIAS_OFF:
> +		regcache_mark_dirty(component->regmap);
> +		err = regulator_disable(tda7802->enable_reg);
> +		if (err < 0)
> +			dev_err(component->dev, "Could not disable.\n");
> +		break;
> +	}
> +
> +	return err;
> +}

Thanks,
Charles
