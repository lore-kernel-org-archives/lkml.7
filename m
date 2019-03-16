Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A7CC10F03
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 17:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07D56218E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 17:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552756425;
	bh=1hRnNer1Th+qhxJlQc311/CL1Mf49C3eiYz2eCgtl8w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=HVpiwsG9Cfrb6/CffFNYBW3/Kt5QQeYGL/EK3YYHRnv1lsQjM6wHvj7R4K4HeG7Wh
	 R8ZYLymsvTYNKhIYiAyb5oCNd51M2wi4kZvIweRw58OytL7UzFBcpydoVf1ri/oLUg
	 Tb4doHOFuMw/NQPP6eK3Q1n78uYPTpvkvrDez9cU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbfCPRNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 13:13:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:49284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726653AbfCPRNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 13:13:43 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB646218D4;
        Sat, 16 Mar 2019 17:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552756421;
        bh=1hRnNer1Th+qhxJlQc311/CL1Mf49C3eiYz2eCgtl8w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AFEepg6OlDIWR34ntvN6x9b4hYK7+2VN+zKBVxLPJAy4KyZP1pXNeLI+Fmq2OuIVk
         28s8JRsFcXNzl7MH5einWqLxPQWWUcVtBk+7ca8RGQWi6Qji5gNvb765W+sQrnBJfc
         XJpbSJliWvokoMy2ZHOkWXoy0huNBBHiRKMyGbRI=
Date:   Sat, 16 Mar 2019 17:13:35 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     angus.ainslie@puri.sm, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tomas Novotny <tomas@novotny.cz>,
        Brian Masney <masneyb@onstation.org>,
        Robert Eshleman <bobbyeshleman@gmail.com>,
        Mathieu Othacehe <m.othacehe@gmail.com>,
        Parthiban Nallathambi <pn@denx.de>, ryang <decatf@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: light: vcnl4000 add support for the VCNL4040
 proximity and light sensor
Message-ID: <20190316171335.49c3ffa2@archlinux>
In-Reply-To: <20190315215425.24140-2-angus@akkea.ca>
References: <20190315215425.24140-1-angus@akkea.ca>
        <20190315215425.24140-2-angus@akkea.ca>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Mar 2019 14:54:24 -0700
"Angus Ainslie (Purism)" <angus@akkea.ca> wrote:

> The VCNL4040 is almost identical to the VCNL4200 as far as register
> layout goes but just need to check a different ID register location.
> 
> This does change the initialization sequence of the VCNL4200 to use word
> writes instead of byte writes. The VCNL4200 datasheet says that word read
> and writes should be used to access the registers but I don't have a 4200
> to test with. The VCNL4040 doesn't initialize properly with the byte
> writes.
> 
> devicetree hooks were also added.
> 
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>

Hi Angus,
A few things inline. Also.
1. Please break this up into a series. The word read thing (hopefully
after confirming it is fine on the older parts) should probably got in
as a fix for earlier kernels.  Hence needs to be in its own patch.
2. DT hooks should be in their own patch.
3. After the above we should have a patch adding the new device support.

Mostly good though. Hopefully we'll get confirmation the word change
is fine on all the sensors.  Peter?

Thanks,

Jonathan

> ---
>  drivers/iio/light/vcnl4000.c | 89 ++++++++++++++++++++++++++++++------
>  1 file changed, 76 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index 04fd0d4b6f19..6e1f02aa6696 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -10,13 +10,14 @@
>   *
>   * IIO driver for:
>   *   VCNL4000/10/20 (7-bit I2C slave address 0x13)
> + *   VCNL4040 (7-bit I2C slave address 0x60)
>   *   VCNL4200 (7-bit I2C slave address 0x51)
>   *
>   * TODO:
>   *   allow to adjust IR current
>   *   proximity threshold and event handling
>   *   periodic ALS/proximity measurement (VCNL4010/20)
> - *   interrupts (VCNL4010/20, VCNL4200)
> + *   interrupts (VCNL4010/20/40, VCNL4200)
>   */
>  
>  #include <linux/module.h>
> @@ -30,6 +31,7 @@
>  #define VCNL4000_DRV_NAME "vcnl4000"
>  #define VCNL4000_PROD_ID	0x01
>  #define VCNL4010_PROD_ID	0x02 /* for VCNL4020, VCNL4010 */
> +#define VCNL4040_PROD_ID	0x86
>  #define VCNL4200_PROD_ID	0x58
>  
>  #define VCNL4000_COMMAND	0x80 /* Command register */
> @@ -49,6 +51,8 @@
>  #define VCNL4200_AL_DATA	0x09 /* Ambient light data */
>  #define VCNL4200_DEV_ID		0x0e /* Device ID, slave address and version */
>  
> +#define VCNL4040_DEV_ID		0x0c /* Device ID, slave address and version */
> +
>  /* Bit masks for COMMAND register */
>  #define VCNL4000_AL_RDY		BIT(6) /* ALS data ready? */
>  #define VCNL4000_PS_RDY		BIT(5) /* proximity data ready? */
> @@ -58,6 +62,7 @@
>  enum vcnl4000_device_ids {
>  	VCNL4000,
>  	VCNL4010,
> +	VCNL4040,
>  	VCNL4200,
>  };
>  
> @@ -90,6 +95,7 @@ static const struct i2c_device_id vcnl4000_id[] = {
>  	{ "vcnl4000", VCNL4000 },
>  	{ "vcnl4010", VCNL4010 },
>  	{ "vcnl4020", VCNL4010 },
> +	{ "vcnl4040", VCNL4040 },
>  	{ "vcnl4200", VCNL4200 },
>  	{ }
>  };
> @@ -128,31 +134,56 @@ static int vcnl4000_init(struct vcnl4000_data *data)
>  
>  static int vcnl4200_init(struct vcnl4000_data *data)
>  {
> -	int ret;
> +	int ret, id;
>  
>  	ret = i2c_smbus_read_word_data(data->client, VCNL4200_DEV_ID);
>  	if (ret < 0)
>  		return ret;
>  
> -	if ((ret & 0xff) != VCNL4200_PROD_ID)
> -		return -ENODEV;
> +	id = ret & 0xff;
> +
> +	if (id != VCNL4200_PROD_ID) {
> +		ret = i2c_smbus_read_word_data(data->client, VCNL4040_DEV_ID);
> +		if (ret < 0)
> +			return ret;
> +
> +		id = ret & 0xff;
> +
> +		if (id != VCNL4040_PROD_ID)
> +			return -ENODEV;
> +
> +	}
> +
> +	dev_dbg(&data->client->dev, "device id 0x%x", id);
>  
>  	data->rev = (ret >> 8) & 0xf;
>  
>  	/* Set defaults and enable both channels */
> -	ret = i2c_smbus_write_byte_data(data->client, VCNL4200_AL_CONF, 0x00);
> +	ret = i2c_smbus_write_word_data(data->client, VCNL4200_AL_CONF, 0x00);
>  	if (ret < 0)
>  		return ret;
> -	ret = i2c_smbus_write_byte_data(data->client, VCNL4200_PS_CONF1, 0x00);
> +	ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1, 0x00);
>  	if (ret < 0)
>  		return ret;
>  
> +	switch (id) {
> +	case VCNL4200_PROD_ID:
> +		/* Integration time is 50ms, but the experiments */
> +		/* show 54ms in total. */
> +		data->vcnl4200_al.sampling_rate = ktime_set(0, 54000 * 1000);
> +		data->vcnl4200_ps.sampling_rate = ktime_set(0, 4200 * 1000);
> +		break;
> +	case VCNL4040_PROD_ID:
> +		/* Integration time is 80ms, add 10ms. */
> +		data->vcnl4200_al.sampling_rate = ktime_set(0, 100000 * 1000);
> +		data->vcnl4200_ps.sampling_rate = ktime_set(0, 100000 * 1000);
> +		break;
> +	}
> +
>  	data->al_scale = 24000;
>  	data->vcnl4200_al.reg = VCNL4200_AL_DATA;
>  	data->vcnl4200_ps.reg = VCNL4200_PS_DATA;
> -	/* Integration time is 50ms, but the experiments show 54ms in total. */
> -	data->vcnl4200_al.sampling_rate = ktime_set(0, 54000 * 1000);
> -	data->vcnl4200_ps.sampling_rate = ktime_set(0, 4200 * 1000);
> +
>  	data->vcnl4200_al.last_measurement = ktime_set(0, 0);
>  	data->vcnl4200_ps.last_measurement = ktime_set(0, 0);
>  	mutex_init(&data->vcnl4200_al.lock);
> @@ -194,8 +225,11 @@ static int vcnl4000_measure(struct vcnl4000_data *data, u8 req_mask,
>  
>  	ret = i2c_smbus_read_i2c_block_data(data->client,
>  		data_reg, sizeof(buf), (u8 *) &buf);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "smbus read failed 0x%02x\n",
> +			ret);
Unrelated change...  Should not be here.

>  		goto fail;
> +	}
>  
>  	mutex_unlock(&data->vcnl4000_lock);
>  	*val = be16_to_cpu(buf);
> @@ -216,6 +250,8 @@ static int vcnl4200_measure(struct vcnl4000_data *data,
>  
>  	mutex_lock(&chan->lock);
>  
> +	ret = i2c_smbus_read_word_data(data->client, chan->reg);
> +
>  	next_measurement = ktime_add(chan->last_measurement,
>  			chan->sampling_rate);
>  	delta = ktime_us_delta(next_measurement, ktime_get());
> @@ -226,8 +262,12 @@ static int vcnl4200_measure(struct vcnl4000_data *data,
>  	mutex_unlock(&chan->lock);
>  
>  	ret = i2c_smbus_read_word_data(data->client, chan->reg);
> -	if (ret < 0)
> +
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "smbus read failed 0x%02x\n",
> +			ret);
Unrelated change.

>  		return ret;
> +	}
>  
>  	*val = ret;
>  
> @@ -271,6 +311,12 @@ static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
>  		.measure_light = vcnl4000_measure_light,
>  		.measure_proximity = vcnl4000_measure_proximity,
>  	},
> +	[VCNL4040] = {
> +		.prod = "VCNL4040",
> +		.init = vcnl4200_init,
> +		.measure_light = vcnl4200_measure_light,
> +		.measure_proximity = vcnl4200_measure_proximity,
> +	},
>  	[VCNL4200] = {
>  		.prod = "VCNL4200",
>  		.init = vcnl4200_init,
> @@ -350,7 +396,7 @@ static int vcnl4000_probe(struct i2c_client *client,
>  	if (ret < 0)
>  		return ret;
>  
> -	dev_dbg(&client->dev, "%s Ambient light/proximity sensor, Rev: %02x\n",
> +	dev_err(&client->dev, "%s Ambient light/proximity sensor, Rev: %02x\n",
>  		data->chip_spec->prod, data->rev);
Unrelated change. It's also not an error!

>  
>  	indio_dev->dev.parent = &client->dev;
> @@ -373,6 +419,23 @@ static struct i2c_driver vcnl4000_driver = {
>  
>  module_i2c_driver(vcnl4000_driver);
>  
> +#ifdef CONFIG_OF
> +static const struct of_device_id vcnl_4000_of_match[] = {
> +	{
> +		.compatible = "vishay,vcnl4000",
> +		.data = "VCNL4000",
> +	},
> +	{
> +		.compatible = "vishay,vcnl4040",
> +		.data = "VCNL4040",
> +	},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, vcnl4000_of_match);
> +#else
> +#define vcnl_4000_of_match NULL
> +#endif
Don't bother with the guard barriers.  The cost is small and we now
want the of_device_id table even on acpi platforms.

Also would expect this to be used as the match table.

> +
>  MODULE_AUTHOR("Peter Meerwald <pmeerw@pmeerw.net>");
> -MODULE_DESCRIPTION("Vishay VCNL4000 proximity/ambient light sensor driver");
> +MODULE_DESCRIPTION("Vishay VCNL4xx0 proximity/ambient light sensor driver");
don't add wild cards. It goes wrong far too often.
>  MODULE_LICENSE("GPL");

