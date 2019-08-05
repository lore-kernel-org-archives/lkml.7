Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A263C32751
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 15:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E828216B7
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 15:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565017457;
	bh=hNtIxM9tns9/3ZnqcjZqPe0wE5g9uKJD8Xeg17jshfM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=gavjw80Sh32fY0DQIcqhSDUJMKsWByeWRiI0LKsPIlK2rMlnpVjOK1F1qJGX7j83G
	 z05gzTSgRqzLvfHktOYlaSiDW7pPLvDKcJsxAGg5ku9he2kDPHFoS2m7Zn8Af30OLo
	 4I7HfmMu5OP03cnOJCVepbSEtEoIGbMdmEMyZX1I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729429AbfHEPEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 11:04:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:36770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727259AbfHEPEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 11:04:15 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58F73206C1;
        Mon,  5 Aug 2019 15:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565017454;
        bh=hNtIxM9tns9/3ZnqcjZqPe0wE5g9uKJD8Xeg17jshfM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rcxkhtDZ2ihANUQjCoijR78KBqCnz5SmZqivach6iH1R2mSoLsvaZBG49+4lrAcnR
         CdcdgXYFQOzfNbmsb10q9oO1NU+J/ymhD6J8mDv2ss1qR8yWrgLZxnha6arYb8LxRJ
         hq6wdzsnIU5gQsH6SR8WdTRdR9U+ryy7N0PRE/CI=
Date:   Mon, 5 Aug 2019 16:04:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Brian Masney <masneyb@onstation.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: tsl2772: Use device-managed API
Message-ID: <20190805160356.2fbd7868@archlinux>
In-Reply-To: <20190731030415.8062-1-hslester96@gmail.com>
References: <20190731030415.8062-1-hslester96@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jul 2019 11:04:15 +0800
Chuhong Yuan <hslester96@gmail.com> wrote:

> Use devm_() APIs to simplify the code.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
> Changes in v3:
>   - Split v2 into two patches.
> 
>  drivers/iio/light/tsl2772.c | 36 +++++++++++++++---------------------
>  1 file changed, 15 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
> index 83cece921843..f1134f183be7 100644
> --- a/drivers/iio/light/tsl2772.c
> +++ b/drivers/iio/light/tsl2772.c
> @@ -860,6 +860,13 @@ static int tsl2772_chip_off(struct iio_dev *indio_dev)
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
> @@ -1807,10 +1814,10 @@ static int tsl2772_probe(struct i2c_client *clientp,
>  		return PTR_ERR(chip->vdd_supply);
>  	}
>  
> -	ret = devm_add_action(&clientp->dev, tsl2772_disable_regulators_action,
> +	ret = devm_add_action_or_reset(&clientp->dev,
> +				tsl2772_disable_regulators_action,

Please fix that alignment in here.

Thanks,

Jonathan

>  			      chip);
>  	if (ret < 0) {
> -		tsl2772_disable_regulators_action(chip);
>  		dev_err(&clientp->dev, "Failed to setup regulator cleanup action %d\n",
>  			ret);
>  		return ret;
> @@ -1877,15 +1884,14 @@ static int tsl2772_probe(struct i2c_client *clientp,
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = iio_device_register(indio_dev);
> -	if (ret) {
> -		tsl2772_chip_off(indio_dev);
> -		dev_err(&clientp->dev,
> -			"%s: iio registration failed\n", __func__);
> +	ret = devm_add_action_or_reset(&clientp->dev,
> +					tsl2772_chip_off_action,
> +					indio_dev);
> +
> +	if (ret < 0)
>  		return ret;
> -	}
>  
> -	return 0;
> +	return devm_iio_device_register(&clientp->dev, indio_dev);
>  }
>  
>  static int tsl2772_suspend(struct device *dev)
> @@ -1922,17 +1928,6 @@ static int tsl2772_resume(struct device *dev)
>  	return tsl2772_chip_on(indio_dev);
>  }
>  
> -static int tsl2772_remove(struct i2c_client *client)
> -{
> -	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> -
> -	tsl2772_chip_off(indio_dev);
> -
> -	iio_device_unregister(indio_dev);
> -
> -	return 0;
> -}
> -
>  static const struct i2c_device_id tsl2772_idtable[] = {
>  	{ "tsl2571", tsl2571 },
>  	{ "tsl2671", tsl2671 },
> @@ -1979,7 +1974,6 @@ static struct i2c_driver tsl2772_driver = {
>  	},
>  	.id_table = tsl2772_idtable,
>  	.probe = tsl2772_probe,
> -	.remove = tsl2772_remove,
>  };
>  
>  module_i2c_driver(tsl2772_driver);

