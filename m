Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0E4C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 17:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E44A215EA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 17:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392114AbfFLRPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 13:15:07 -0400
Received: from mga01.intel.com ([192.55.52.88]:22360 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729107AbfFLRPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 13:15:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2019 10:15:06 -0700
X-ExtLoop1: 1
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.252.15.160]) ([10.252.15.160])
  by fmsmga004.fm.intel.com with ESMTP; 12 Jun 2019 10:14:58 -0700
Subject: Re: [PATCH v1 3/4] ASoC: tda7802: Add enable device attribute
To:     Thomas Preston <thomas.preston@codethink.co.uk>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
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
        linux-kernel@vger.kernel.org
References: <20190611174909.12162-1-thomas.preston@codethink.co.uk>
 <20190611174909.12162-4-thomas.preston@codethink.co.uk>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <1546f318-2b34-b42c-7aa3-a51429020bca@intel.com>
Date:   Wed, 12 Jun 2019 19:14:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190611174909.12162-4-thomas.preston@codethink.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-06-11 19:49, Thomas Preston wrote:
> Add a device attribute to control the enable regulator. Write 1 to
> enable, 0 to disable (ref-count minus one), or -1 to force disable the
> physical pin.
> 
> To disable a set of amplifiers wired to the same enable gpio, each
> device must be disabled. For example:
> 
> 	echo 0 > /sys/devices/.../device:00/enable
> 	echo 0 > /sys/devices/.../device:01/enable
> 
> In an emergency, we can force disable from any device:
> 
> 	echo -1 > /sys/devices/.../device:00/enable
> 
> Signed-off-by: Thomas Preston <thomas.preston@codethink.co.uk>
> Cc: Patrick Glaser <pglaser@tesla.com>
> Cc: Rob Duncan <rduncan@tesla.com>
> Cc: Nate Case <ncase@tesla.com>
> ---
>   sound/soc/codecs/tda7802.c | 65 +++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 64 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/tda7802.c b/sound/soc/codecs/tda7802.c
> index 38ca52de85f0..62aae011d9f1 100644
> --- a/sound/soc/codecs/tda7802.c
> +++ b/sound/soc/codecs/tda7802.c
> @@ -458,6 +458,42 @@ static struct snd_soc_dai_driver tda7802_dai_driver = {
>   	.ops = &tda7802_dai_ops,
>   };
>   
> +static ssize_t enable_show(struct device *dev, struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct tda7802_priv *tda7802 = dev_get_drvdata(dev);
> +	int enabled = regulator_is_enabled(tda7802->enable_reg) ? 1 : 0;
> +
> +	return scnprintf(buf, PAGE_SIZE, "%d\n", enabled);
> +}
> +
> +static ssize_t enable_store(struct device *dev, struct device_attribute *attr,
> +		const char *buf, size_t count)
> +{
> +	struct tda7802_priv *tda7802 = dev_get_drvdata(dev);
> +	int err;
> +
> +	if (sysfs_streq(buf, "1")) {
> +		err = regulator_enable(tda7802->enable_reg);
> +		if (err < 0)
> +			dev_err(dev, "Could not enable (sysfs)\n");
> +	} else if (sysfs_streq(buf, "0")) {
> +		err = regulator_disable(tda7802->enable_reg);
> +		if (err < 0)
> +			dev_err(dev, "Could not disable (sysfs)\n");
> +	} else if (sysfs_streq(buf, "-1")) {
> +		err = regulator_force_disable(tda7802->enable_reg);
> +		if (err < 0)
> +			dev_err(dev, "Could not force disable (sysfs)\n");
> +	} else {
> +		return -EINVAL;
> +	}
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR_RW(enable);
> +
>   /* read device tree or ACPI properties from device */
>   static int tda7802_read_properties(struct tda7802_priv *tda7802)
>   {
> @@ -493,7 +529,34 @@ static int tda7802_read_properties(struct tda7802_priv *tda7802)
>   	return err;
>   }
>   
> -static const struct snd_soc_component_driver tda7802_component_driver;
> +static int tda7802_probe(struct snd_soc_component *component)
> +{
> +	struct tda7802_priv *tda7802 = snd_soc_component_get_drvdata(component);
> +	struct device *dev = &tda7802->i2c->dev;
> +	int err;
> +
> +	dev_dbg(dev, "%s\n", __func__);

Function name alone ain't very informational. Is this intended?

> +
> +	err = device_create_file(dev, &dev_attr_enable);
> +	if (err < 0) {
> +		dev_err(dev, "Could not create enable attr\n");
> +		return err;
> +	}

Regardless of outcome, you'll be returning err here. Consider leaving 
error message alone within if-statement. Remove redundant brackets if 
you decide to do so.

> +
> +	return err;
> +}
> +
> +static void tda7802_remove(struct snd_soc_component *component)
> +{
> +	struct tda7802_priv *tda7802 = snd_soc_component_get_drvdata(component);
> +
> +	device_remove_file(&tda7802->i2c->dev, &dev_attr_enable);
> +}
> +
> +static const struct snd_soc_component_driver tda7802_component_driver = {
> +	.probe = tda7802_probe,
> +	.remove = tda7802_remove,
> +};
>   
>   static int tda7802_i2c_probe(struct i2c_client *i2c,
>   			     const struct i2c_device_id *id)
> 
