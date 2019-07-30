Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DECFC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B732067D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732616AbfG3Ptw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 11:49:52 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:51548 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727534AbfG3Pts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 11:49:48 -0400
Received: from [167.98.27.226] (helo=[10.35.6.253])
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1hsUNZ-0001X8-C3; Tue, 30 Jul 2019 16:49:33 +0100
Subject: Re: [alsa-devel] [PATCH v2 2/3] ASoC: Add codec driver for ST TDA7802
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Marco Felsch <m.felsch@pengutronix.de>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Kirill Marinushkin <kmarinushkin@birdec.tech>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        linux-kernel@vger.kernel.org, Nate Case <ncase@tesla.com>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Annaliese McDermond <nh6z@nh6z.net>,
        Rob Duncan <rduncan@tesla.com>,
        Patrick Glaser <pglaser@tesla.com>,
        Jerome Brunet <jbrunet@baylibre.com>
References: <20190730120937.16271-1-thomas.preston@codethink.co.uk>
 <20190730120937.16271-3-thomas.preston@codethink.co.uk>
 <20190730123825.GG54126@ediswmail.ad.cirrus.com>
From:   Thomas Preston <thomas.preston@codethink.co.uk>
Message-ID: <4285701d-ae61-208b-8f38-ac44e77ad9b5@codethink.co.uk>
Date:   Tue, 30 Jul 2019 16:49:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190730123825.GG54126@ediswmail.ad.cirrus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/2019 13:38, Charles Keepax wrote:
> On Tue, Jul 30, 2019 at 01:09:36PM +0100, Thomas Preston wrote:
>> Add an I2C based codec driver for ST TDA7802 amplifier. The amplifier
>> supports 4 audio channels but can support up to 16 with multiple
>> devices.
>>
>> Signed-off-by: Thomas Preston <thomas.preston@codethink.co.uk>
>> Cc: Patrick Glaser <pglaser@tesla.com>
>> Cc: Rob Duncan <rduncan@tesla.com>
>> Cc: Nate Case <ncase@tesla.com>
>> ---
>> Changes since v1:
>> - Use ALSA kcontrol interface to expose device controls to userland
>> 	- Gain
>> 	- Channel diagnostic mode
>> 	- Impedance efficiency optimiser. I decided against setting this
>> 	  as a DT property since it seems like something that can be
>> 	  changed on the fly.
>> - Add regmap default values
>> 	- Channel unmute by default is added in a downstream patch.
>> 	- I'm not sure if I should keep this since they're all zero,
>> 	  although there are other drivers will all-zero reg_defaults.
>> - I believe the "//" style is used for SPDX headers in normal C source files.
>>   https://lwn.net/Articles/739183/
>> - Drop the "enable" sysfs device attribute.
>> - Don't set TDM format using magic numbers.
>> - Set sample rate using hw_params.
>> - Remove unecessary defines.
>> - Use DAPM to handle AMP_ON.
>> - Cosmetic fixups
>>
>>  sound/soc/codecs/Kconfig   |   6 +
>>  sound/soc/codecs/Makefile  |   2 +
>>  sound/soc/codecs/tda7802.c | 509 +++++++++++++++++++++++++++++++++++++
>>  3 files changed, 517 insertions(+)
>>  create mode 100644 sound/soc/codecs/tda7802.c
>>
>> +++ b/sound/soc/codecs/tda7802.c
>> @@ -0,0 +1,509 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * tda7802.c  --  codec driver for ST TDA7802
>> + *
>> + * Copyright (C) 2016-2019 Tesla Motors, Inc.
>> + */
> 
> Better to make the whole comment // see something like
> sound/soc/codecs/cs47l35.c for an example.
> 

I will update to "//" style. Is this a new standard? There aren't many
comments like that in 4.14 (my target kernel) - I can see a lot more
in 5.3.

My intention was:

1. Apply the SPDX rules to SPDX bit.     Documentation/process/license-rules.rst
2. Use multi-line comments for the rest. Documentation/process/coding-style.rst

>> +static int tda7802_set_bias_level(struct snd_soc_component *component,
>> +		enum snd_soc_bias_level level)
>> +{
>> +	const struct tda7802_priv *tda7802 =
>> +		snd_soc_component_get_drvdata(component);
>> +	struct snd_soc_dapm_context *dapm_context =
>> +			snd_soc_component_get_dapm(component);
>> +	const enum snd_soc_bias_level oldlevel =
>> +		snd_soc_dapm_get_bias_level(dapm_context);
>> +	int err = 0;
>> +
>> +	dev_dbg(component->dev, "%s level %d\n", __func__, level);
>> +
>> +	switch (level) {
>> +	case SND_SOC_BIAS_ON:
>> +		break;
>> +	case SND_SOC_BIAS_PREPARE:
>> +		break;
>> +	case SND_SOC_BIAS_STANDBY:
>> +		err = regulator_enable(tda7802->enable_reg);
>> +		if (err < 0) {
>> +			dev_err(component->dev, "Could not enable.\n");
>> +			return err;
>> +		}
>> +		dev_dbg(component->dev, "Regulator enabled\n");
>> +		msleep(ENABLE_DELAY_MS);
>> +
>> +		if (oldlevel == SND_SOC_BIAS_OFF) {
>> +			dev_dbg(component->dev, "Syncing regcache\n");
>> +			err = regcache_sync(component->regmap);
>> +			if (err < 0)
>> +				dev_err(component->dev,
>> +					"Could not sync regcache, %d\n", err);
> 
> If your doing a regcache_sync I would probably have expected to
> see calls to regcache_cache_only.
> 
> If the device needs syncing that implies the hardware registers
> have lost state, so there is little point in writing to them
> if they are unavailable/about to loose their state.
> 

Ah, from the comments I thought I only needed to call regcache_mark_dirty...

>> +		}
>> +		break;
>> +	case SND_SOC_BIAS_OFF:
>> +		regcache_mark_dirty(component->regmap);
>> +		err = regulator_disable(tda7802->enable_reg);
>> +		if (err < 0)
>> +			dev_err(component->dev, "Could not disable.\n");
>> +		break;
>> +	}
>> +
>> +	return err;
>> +}

So I think the correct order is:

device_off:
	regcache_cache_only
	power-off (enable)
	regcache_mark_dirty

device_on:
	power-on (enable)
	regcache_sync

I will double-check the register state is actually lost too. Fiddling
with the cache might be completely unnecessary.

Many thanks
