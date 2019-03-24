Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CD0C4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 17:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B46F220870
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 17:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553448307;
	bh=WSPLCDlk7TFlc3nWysN0eiayRc3hCzzHNtNVw+3KqY4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=T1hDxxTF9klCOWhD7nB3qj3iBLhndNWrSmzLU+WpqD5AXaR4ZKQrraLxkL0kOz9L8
	 gT/fcbx1OrVDSVdU5MB6Nb6Q/FlzS5AdxSyykMucOqWW23YfWXcNAhMl47u0Zi9KOG
	 RrDBO6hME4ASPqpFImLLufGNLCPt06YBeGxr90G8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbfCXRZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 13:25:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:36884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727249AbfCXRZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 13:25:06 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2361720989;
        Sun, 24 Mar 2019 17:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553448305;
        bh=WSPLCDlk7TFlc3nWysN0eiayRc3hCzzHNtNVw+3KqY4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sfYWKU6P09zQMdJD0XaQQ6pqnPUFWGgeSR6n8O57l8q9CNqsjYwvqp41VTInLKZPG
         XCnUmLKKsn+lNbtDDeg5kVBq56HYei79mNDz0H56u6McICNwGFaSgc1TQMWPcX9+Id
         +80jB0RcqcA67djkbDACua+HVDa7SDqomATm+Wmw=
Date:   Sun, 24 Mar 2019 17:24:59 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tomas Novotny <tomas@novotny.cz>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] iio: light: vcnl4000 add support for the
 VCNL4040 proximity and light sensor
Message-ID: <20190324172459.21d36181@archlinux>
In-Reply-To: <20190321154047.23236-5-angus@akkea.ca>
References: <20190321154047.23236-1-angus@akkea.ca>
        <20190321154047.23236-5-angus@akkea.ca>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2019 08:40:46 -0700
"Angus Ainslie (Purism)" <angus@akkea.ca> wrote:

> The VCNL4040 is almost identical to the VCNL4200 as far as register
> layout goes but just need to check a different ID register location.
> 
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/light/vcnl4000.c | 51 ++++++++++++++++++++++++++++++------
>  1 file changed, 43 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index 308cb2d2b641..12c52f2b853a 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -1,8 +1,9 @@
>  /*
> - * vcnl4000.c - Support for Vishay VCNL4000/4010/4020/4200 combined ambient
> + * vcnl4000.c - Support for Vishay VCNL4000/4010/4020/4040/4200 combined ambient
>   * light and proximity sensor
>   *
>   * Copyright 2012 Peter Meerwald <pmeerw@pmeerw.net>
> + * Copyright 2019 Pursim SPC
>   *
>   * This file is subject to the terms and conditions of version 2 of
>   * the GNU General Public License.  See the file COPYING in the main
> @@ -10,13 +11,14 @@
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
> @@ -30,6 +32,7 @@
>  #define VCNL4000_DRV_NAME "vcnl4000"
>  #define VCNL4000_PROD_ID	0x01
>  #define VCNL4010_PROD_ID	0x02 /* for VCNL4020, VCNL4010 */
> +#define VCNL4040_PROD_ID	0x86
>  #define VCNL4200_PROD_ID	0x58
>  
>  #define VCNL4000_COMMAND	0x80 /* Command register */
> @@ -49,6 +52,8 @@
>  #define VCNL4200_AL_DATA	0x09 /* Ambient light data */
>  #define VCNL4200_DEV_ID		0x0e /* Device ID, slave address and version */
>  
> +#define VCNL4040_DEV_ID		0x0c /* Device ID and version */
> +
>  /* Bit masks for COMMAND register */
>  #define VCNL4000_AL_RDY		BIT(6) /* ALS data ready? */
>  #define VCNL4000_PS_RDY		BIT(5) /* proximity data ready? */
> @@ -58,6 +63,7 @@
>  enum vcnl4000_device_ids {
>  	VCNL4000,
>  	VCNL4010,
> +	VCNL4040,
>  	VCNL4200,
>  };
>  
> @@ -90,6 +96,7 @@ static const struct i2c_device_id vcnl4000_id[] = {
>  	{ "vcnl4000", VCNL4000 },
>  	{ "vcnl4010", VCNL4010 },
>  	{ "vcnl4020", VCNL4010 },
> +	{ "vcnl4040", VCNL4040 },
>  	{ "vcnl4200", VCNL4200 },
>  	{ }
>  };
> @@ -128,14 +135,26 @@ static int vcnl4000_init(struct vcnl4000_data *data)
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
> +	}
> +
> +	dev_dbg(&data->client->dev, "device id 0x%x", id);
>  
>  	data->rev = (ret >> 8) & 0xf;
>  
> @@ -150,9 +169,19 @@ static int vcnl4200_init(struct vcnl4000_data *data)
>  	data->al_scale = 24000;
>  	data->vcnl4200_al.reg = VCNL4200_AL_DATA;
>  	data->vcnl4200_ps.reg = VCNL4200_PS_DATA;
> -	/* Integration time is 50ms, but the experiments show 54ms in total. */
> -	data->vcnl4200_al.sampling_rate = ktime_set(0, 54000 * 1000);
> -	data->vcnl4200_ps.sampling_rate = ktime_set(0, 4200 * 1000);
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
>  	data->vcnl4200_al.last_measurement = ktime_set(0, 0);
>  	data->vcnl4200_ps.last_measurement = ktime_set(0, 0);
>  	mutex_init(&data->vcnl4200_al.lock);
> @@ -271,6 +300,12 @@ static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
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

