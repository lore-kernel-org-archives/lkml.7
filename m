Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4657C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 10:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BB352070D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 10:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="a7Wth4vw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387528AbfG2K7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 06:59:14 -0400
Received: from onstation.org ([52.200.56.107]:35266 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387424AbfG2K7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 06:59:13 -0400
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 92ECD3E910;
        Mon, 29 Jul 2019 10:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1564397953;
        bh=B34EPjeFIk9ftJgqn8Fp8+yWcxoptA9g3QIqaX9hknE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a7Wth4vwYR67Zwup95jIVDDr+Lq1PjJFyDtK6Z0sy9RVm1LGK5bvuGFU9HetMjJkg
         ut9XfKk3tdyJFC7AfhVagNHa3St4GiNjUaPtoeV4VpA0lhHtWx5sWQBwb99IERRc/Z
         VfC8E3u7PR1uvNfNhCyBXK++M8hRraWpktIGKZrY=
Date:   Mon, 29 Jul 2019 06:59:12 -0400
From:   Brian Masney <masneyb@onstation.org>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: tsl2772: Use device-managed API
Message-ID: <20190729105912.GA2302@onstation.org>
References: <20190729100339.24054-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729100339.24054-1-hslester96@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chuhong,

On Mon, Jul 29, 2019 at 06:03:39PM +0800, Chuhong Yuan wrote:
> Use devm_iio_device_register to simplify
> the code.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

Thank you for the patch. The patch description doesn't match what all is
done below. This should also be broken up into multiple patches since a
patch should only do one thing. The regulator changes should be in their
own patch, and some of the devm changes may require multiple patches.
When writing your changelog, if your patch description has the word
'and', then that may be a hint that you need to break up your patch a
little bit. That's not always the case, but something to keep in mind.

A few minor comments below.

> ---
> Changes in v2:
>   - Use regulator_bulk_() to shrink driver
>     size.
>   - Utilize more devm functions to simplify
>     the code.
>   - Remove several redundant functions.
> 
>  drivers/iio/light/tsl2772.c | 116 +++++++++++-------------------------
>  1 file changed, 34 insertions(+), 82 deletions(-)
> 
> diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
> index 83cece921843..946537c8586f 100644
> --- a/drivers/iio/light/tsl2772.c
> +++ b/drivers/iio/light/tsl2772.c
> @@ -131,7 +131,10 @@ enum {
>  enum {
>  	TSL2772_CHIP_UNKNOWN = 0,
>  	TSL2772_CHIP_WORKING = 1,
> -	TSL2772_CHIP_SUSPENDED = 2
> +	TSL2772_CHIP_SUSPENDED = 2,
> +	TSL2772_SUPPLY_VDD = 0,
> +	TSL2772_SUPPLY_VDDIO = 1,
> +	TSL2772_NUM_SUPPLIES = 2
>  };

This is a really minor nitpick but can these either use a #define or be
placed in its own enum block?

>  
>  /* Per-device data */
> @@ -161,8 +164,7 @@ struct tsl2772_chip {
>  	struct mutex prox_mutex;
>  	struct mutex als_mutex;
>  	struct i2c_client *client;
> -	struct regulator *vdd_supply;
> -	struct regulator *vddio_supply;
> +	struct regulator_bulk_data reg[TSL2772_NUM_SUPPLIES];

Since there's other changes, maybe name this 'supplies'? I think of
'reg' as an address.

>  	u16 prox_data;
>  	struct tsl2772_als_info als_cur_info;
>  	struct tsl2772_settings settings;
> @@ -697,46 +699,7 @@ static void tsl2772_disable_regulators_action(void *_data)
>  {
>  	struct tsl2772_chip *chip = _data;
>  
> -	regulator_disable(chip->vdd_supply);
> -	regulator_disable(chip->vddio_supply);
> -}
> -
> -static int tsl2772_enable_regulator(struct tsl2772_chip *chip,
> -				    struct regulator *regulator)
> -{
> -	int ret;
> -
> -	ret = regulator_enable(regulator);
> -	if (ret < 0) {
> -		dev_err(&chip->client->dev, "Failed to enable regulator: %d\n",
> -			ret);
> -		return ret;
> -	}
> -
> -	return 0;
> -}
> -
> -static struct regulator *tsl2772_get_regulator(struct tsl2772_chip *chip,
> -					       char *name)
> -{
> -	struct regulator *regulator;
> -	int ret;
> -
> -	regulator = devm_regulator_get(&chip->client->dev, name);
> -	if (IS_ERR(regulator)) {
> -		if (PTR_ERR(regulator) != -EPROBE_DEFER)
> -			dev_err(&chip->client->dev,
> -				"Failed to get %s regulator %d\n",
> -				name, (int)PTR_ERR(regulator));
> -
> -		return regulator;
> -	}
> -
> -	ret = tsl2772_enable_regulator(chip, regulator);
> -	if (ret < 0)
> -		return ERR_PTR(ret);
> -
> -	return regulator;
> +	regulator_bulk_disable(ARRAY_SIZE(chip->reg), chip->reg);
>  }
>  
>  static int tsl2772_chip_on(struct iio_dev *indio_dev)
> @@ -860,6 +823,13 @@ static int tsl2772_chip_off(struct iio_dev *indio_dev)
>  	return tsl2772_write_control_reg(chip, 0x00);
>  }
>  
> +static void tsl2772_chip_off_action(void *data)
> +{
> +	struct iio_dev *indio_dev = data;
> +
> +	tsl2772_chip_off(indio_dev);
> +}
> +
>  /**
>   * tsl2772_invoke_change - power cycle the device to implement the user
>   *                         parameters
> @@ -1797,20 +1767,22 @@ static int tsl2772_probe(struct i2c_client *clientp,
>  	chip->client = clientp;
>  	i2c_set_clientdata(clientp, indio_dev);
>  
> -	chip->vddio_supply = tsl2772_get_regulator(chip, "vddio");
> -	if (IS_ERR(chip->vddio_supply))
> -		return PTR_ERR(chip->vddio_supply);
> +	chip->reg[TSL2772_SUPPLY_VDD].supply = "vdd";
> +	chip->reg[TSL2772_SUPPLY_VDDIO].supply = "vddio";
>  
> -	chip->vdd_supply = tsl2772_get_regulator(chip, "vdd");
> -	if (IS_ERR(chip->vdd_supply)) {
> -		regulator_disable(chip->vddio_supply);
> -		return PTR_ERR(chip->vdd_supply);
> -	}
> +	ret = devm_regulator_bulk_get(&clientp->dev, ARRAY_SIZE(chip->reg),
> +		chip->reg);
> +	if (ret < 0)
> +		return ret;

Add a dev_err like the other error paths in probe function. Users can
use the tracing subsystem to see why this failed but an error message
in dmesg is much easier for users to find. Also be sure to check for the
EPROBE_DEFER case.

Brian
