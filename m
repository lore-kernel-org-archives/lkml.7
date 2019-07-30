Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872CFC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62672206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729638AbfG3OEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 10:04:31 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:48049 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728255AbfG3OEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 10:04:30 -0400
Received: from [167.98.27.226] (helo=[10.35.6.253])
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1hsSjk-0006nP-P6; Tue, 30 Jul 2019 15:04:20 +0100
Subject: Re: [alsa-devel] [PATCH v2 3/3] ASoC: TDA7802: Add turn-on diagnostic
 routine
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Marco Felsch <m.felsch@pengutronix.de>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Kirill Marinushkin <kmarinushkin@birdec.tech>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Annaliese McDermond <nh6z@nh6z.net>,
        Jerome Brunet <jbrunet@baylibre.com>
References: <20190730120937.16271-1-thomas.preston@codethink.co.uk>
 <20190730120937.16271-4-thomas.preston@codethink.co.uk>
 <20190730124158.GH54126@ediswmail.ad.cirrus.com>
From:   Thomas Preston <thomas.preston@codethink.co.uk>
Message-ID: <e7a879d3-36c2-2df8-97c0-3c4bbd2e7ea2@codethink.co.uk>
Date:   Tue, 30 Jul 2019 15:04:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190730124158.GH54126@ediswmail.ad.cirrus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Thanks for getting back to me so quickly.

On 30/07/2019 13:41, Charles Keepax wrote:
> On Tue, Jul 30, 2019 at 01:09:37PM +0100, Thomas Preston wrote:
>> Add a debugfs device node which initiates the turn-on diagnostic routine
>> feature of the TDA7802 amplifier. The four status registers (one per
>> channel) are returned.
>>
>> Signed-off-by: Thomas Preston <thomas.preston@codethink.co.uk>
>> ---
>> Changes since v1:
>> - Rename speaker-test to (turn-on) diagnostics
>> - Move turn-on diagnostic to debugfs as there is no standard ALSA
>>   interface for this kind of routine.
>>
>>  sound/soc/codecs/tda7802.c | 186 ++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 185 insertions(+), 1 deletion(-)
>>
>> +static int tda7802_bulk_update(struct regmap *map, struct reg_update *update,
>> +		size_t update_count)
>> +{
>> +	int i, err;
>> +
>> +	for (i = 0; i < update_count; i++) {
>> +		err = regmap_update_bits(map, update[i].reg, update[i].mask,
>> +				update[i].val);
>> +		if (err < 0)
>> +			return err;
>> +	}
>> +
>> +	return i;
>> +}
> 
> This could probably be removed using regmap_multi_reg_write.
> 

The problem is that I want to retain the state of the other bits in those
registers. Maybe I should make a copy of the backed up state, set the bits
I want to off-device, then either:

1. Write the changes with regmap_multi_reg_write
2. Write all six regs again (if my device doesn't support the multi_reg)

>> +static int tda7802_probe(struct snd_soc_component *component)
>> +{
>> +	struct tda7802_priv *tda7802 = snd_soc_component_get_drvdata(component);
>> +	struct device *dev = &tda7802->i2c->dev;
>> +	int err;
>> +
>> +	tda7802->debugfs = debugfs_create_dir(dev_name(dev), NULL);
>> +	if (IS_ERR_OR_NULL(tda7802->debugfs)) {
>> +		dev_info(dev,
>> +			"Failed to create debugfs node, err %ld\n",
>> +			PTR_ERR(tda7802->debugfs));
>> +		return 0;
>> +	}
>> +
>> +	mutex_init(&tda7802->diagnostic_mutex);
>> +	err = debugfs_create_file("diagnostic", 0444, tda7802->debugfs, tda7802,
>> +			&tda7802_diagnostic_fops);
>> +	if (err < 0) {
>> +		dev_err(dev,
>> +			"debugfs: Failed to create diagnostic node, err %d\n",
>> +			err);
>> +		goto cleanup_diagnostic;
>> +	}
> 
> You shouldn't be failing the driver probe if debugfs fails, it
> should be purely optional.
> 

Got it, thanks.
