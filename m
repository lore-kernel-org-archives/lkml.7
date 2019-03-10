Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89330C10F03
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 10:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E572086A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 10:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552213584;
	bh=+bXHFZWZxv1YKAl32B/pzoIeQZ3IJGiaz9begOFdhiU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Zb0JX5A3SitTKU6dU03W31icFRGBeYzaRayCru9RMge9CqCUjLNJ+Ivau9tvC4MEk
	 4irjC9vCKzZNjDkJXcGKJjGaZAOSh1C+mJKE0PWSegFhEnC90Hn8MhRjIspZvSzAFu
	 QAJHnAiL8GqdqNx6upZ6SVHaUlIwTiglxMmh2XBY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfCJK0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 06:26:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:45160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbfCJK0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 06:26:22 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F88720645;
        Sun, 10 Mar 2019 10:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552213582;
        bh=+bXHFZWZxv1YKAl32B/pzoIeQZ3IJGiaz9begOFdhiU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hadkg2v0t7X2s6zsKxJZVxnU7JTfWJ+R8KiZDDke1I1ocZdT6vLZs9ybx6GA99fUT
         R3RUwoZjh/pUfTLCsu3suUzzgpA9n7WbVeFbu1DmtVCOOiMXTGCy5bDTzuBBCuv/mj
         RNyzXtkuP3gHl/4pqtO3sC9EWA2JeiDPbWu+j9Gc=
Date:   Sun, 10 Mar 2019 10:26:16 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: hmc5843_spi: fix a NULL pointer dereference
Message-ID: <20190310102616.55b03f11@archlinux>
In-Reply-To: <20190309185628.21059-1-kjlu@umn.edu>
References: <20190309185628.21059-1-kjlu@umn.edu>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  9 Mar 2019 12:56:27 -0600
Kangjie Lu <kjlu@umn.edu> wrote:

> In case devm_regmap_init_spi fails and returns NULL, the fix
> returns an error to avoid NULL pointer dereference
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>

Hi.

The fix is good, but please do the same for the i2c element of
the driver. I'd like them both in a single patch as it's exactly
the same issue in the same driver.

Minor comment inline on how I think it could be a tiny bit
nicer.

Thanks,

Jonathan

> ---
>  drivers/iio/magnetometer/hmc5843_spi.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/magnetometer/hmc5843_spi.c b/drivers/iio/magnetometer/hmc5843_spi.c
> index 535f03a70d63..15e2f7cbb3b5 100644
> --- a/drivers/iio/magnetometer/hmc5843_spi.c
> +++ b/drivers/iio/magnetometer/hmc5843_spi.c
> @@ -59,6 +59,12 @@ static int hmc5843_spi_probe(struct spi_device *spi)
>  {
>  	int ret;
>  	const struct spi_device_id *id = spi_get_device_id(spi);
> +	struct regmap *devm_regmap = devm_regmap_init_spi(spi,
> +			&hmc5843_spi_regmap_config);
Split this into the variable instantiation and the assignment.
That will let you (I think) avoid the nasty alignement.
Also, no need to have the devm_ prefix on the variable name.

	struct regmap *regmap;

	regmap = devm_regmap_init(spi, &hmc5843_spi_regmap_config);

> +
> +	if (IS_ERR(devm_regmap))
> +		return PTR_ERR(devm_regmap);
> +
>  
>  	spi->mode = SPI_MODE_3;
>  	spi->max_speed_hz = 8000000;
> @@ -68,7 +74,7 @@ static int hmc5843_spi_probe(struct spi_device *spi)
>  		return ret;
>  
>  	return hmc5843_common_probe(&spi->dev,
> -			devm_regmap_init_spi(spi, &hmc5843_spi_regmap_config),
> +			devm_regmap,
>  			id->driver_data, id->name);
>  }
>  

