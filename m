Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6C0C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 11:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 578032089C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 11:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570880086;
	bh=MLIYy09xXiNKtFM7Du7Vsz4gtjB6l5q/YwnKYLL7yos=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=RLElU04T9qKmraHiG0iUVpZS/75oJYxLGef8zZN79jJSH/jqqV7ytstoc2Ts1Tdqf
	 dwUFZS9ktznPU2P/wtQVTImImhyeBg+GdI0lqUBE65hJjUVmuFx4rI+UTmsCvuDTUS
	 4ytJaX/CPDg76VL6hV3aWJU1AxWCp8iYe4rGFio4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbfJLLeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 07:34:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:41720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729267AbfJLLek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 07:34:40 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED0E921A4A;
        Sat, 12 Oct 2019 11:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570880079;
        bh=MLIYy09xXiNKtFM7Du7Vsz4gtjB6l5q/YwnKYLL7yos=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p+c/Bx1tqX0FY7ajIr4Ii8M9zXpqHJ3uJlgcbs6fwgJpPaBM5rQD6cy34uxGEBYt+
         4SzIHTGXP5bXgSB8Ft1CMApHuVhKuJve7lIpHAVTh0SB+hYXWgBojUSi5HHAvQSSti
         +ipCOy+aYy5U7BReFQUBkbU2QR9GkhMdbgtycu7w=
Date:   Sat, 12 Oct 2019 12:29:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 4/8] iio: adc: max1027: Prepare the introduction of
 different resolutions
Message-ID: <20191012122912.5882d2e7@archlinux>
In-Reply-To: <20191011144347.19146-5-miquel.raynal@bootlin.com>
References: <20191011144347.19146-1-miquel.raynal@bootlin.com>
        <20191011144347.19146-5-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Oct 2019 16:43:43 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Maxim's max1027/29/31 series returns the measured voltages with a
> resolution of 10 bits. There is a very similar series, max1227/29/31
> which works identically but uses a resolution of 12 bits. Prepare the
> support for these chips by turning the 'depth' into a macro parameter
> instead of hardcoding it everywhere. Also reorganize just a bit the
> macros at the top to avoid repeating tens of lines when adding support
> for a new chip.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/max1027.c | 74 +++++++++++++++++----------------------
>  1 file changed, 32 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
> index f9b473ee6711..8b449044bef5 100644
> --- a/drivers/iio/adc/max1027.c
> +++ b/drivers/iio/adc/max1027.c
> @@ -83,7 +83,7 @@ static const struct of_device_id max1027_adc_dt_ids[] = {
>  MODULE_DEVICE_TABLE(of, max1027_adc_dt_ids);
>  #endif
>  
> -#define MAX1027_V_CHAN(index)						\
> +#define MAX1027_V_CHAN(index, depth)					\
>  	{								\
>  		.type = IIO_VOLTAGE,					\
>  		.indexed = 1,						\
> @@ -93,7 +93,7 @@ MODULE_DEVICE_TABLE(of, max1027_adc_dt_ids);
>  		.scan_index = index + 1,				\
>  		.scan_type = {						\
>  			.sign = 'u',					\
> -			.realbits = 10,					\
> +			.realbits = depth,				\
>  			.storagebits = 16,				\
>  			.shift = 2,					\
>  			.endianness = IIO_BE,				\
> @@ -115,52 +115,42 @@ MODULE_DEVICE_TABLE(of, max1027_adc_dt_ids);
>  		},							\
>  	}
>  
> +#define MAX1X27_CHANNELS(depth)			\
> +	MAX1027_T_CHAN,				\
> +	MAX1027_V_CHAN(0, depth),		\
> +	MAX1027_V_CHAN(1, depth),		\
> +	MAX1027_V_CHAN(2, depth),		\
> +	MAX1027_V_CHAN(3, depth),		\
> +	MAX1027_V_CHAN(4, depth),		\
> +	MAX1027_V_CHAN(5, depth),		\
> +	MAX1027_V_CHAN(6, depth),		\
> +	MAX1027_V_CHAN(7, depth)
> +
> +#define MAX1X29_CHANNELS(depth)			\
> +	MAX1X27_CHANNELS(depth),		\
> +	MAX1027_V_CHAN(8, depth),		\
> +	MAX1027_V_CHAN(9, depth),		\
> +	MAX1027_V_CHAN(10, depth),		\
> +	MAX1027_V_CHAN(11, depth)
> +
> +#define MAX1X31_CHANNELS(depth)			\
> +	MAX1X27_CHANNELS(depth),		\
> +	MAX1X29_CHANNELS(depth),		\
> +	MAX1027_V_CHAN(12, depth),		\
> +	MAX1027_V_CHAN(13, depth),		\
> +	MAX1027_V_CHAN(14, depth),		\
> +	MAX1027_V_CHAN(15, depth)
> +
>  static const struct iio_chan_spec max1027_channels[] = {
> -	MAX1027_T_CHAN,
> -	MAX1027_V_CHAN(0),
> -	MAX1027_V_CHAN(1),
> -	MAX1027_V_CHAN(2),
> -	MAX1027_V_CHAN(3),
> -	MAX1027_V_CHAN(4),
> -	MAX1027_V_CHAN(5),
> -	MAX1027_V_CHAN(6),
> -	MAX1027_V_CHAN(7)
> +	MAX1X27_CHANNELS(10),
>  };
>  
>  static const struct iio_chan_spec max1029_channels[] = {
> -	MAX1027_T_CHAN,
> -	MAX1027_V_CHAN(0),
> -	MAX1027_V_CHAN(1),
> -	MAX1027_V_CHAN(2),
> -	MAX1027_V_CHAN(3),
> -	MAX1027_V_CHAN(4),
> -	MAX1027_V_CHAN(5),
> -	MAX1027_V_CHAN(6),
> -	MAX1027_V_CHAN(7),
> -	MAX1027_V_CHAN(8),
> -	MAX1027_V_CHAN(9),
> -	MAX1027_V_CHAN(10),
> -	MAX1027_V_CHAN(11)
> +	MAX1X29_CHANNELS(10),
>  };
>  
>  static const struct iio_chan_spec max1031_channels[] = {
> -	MAX1027_T_CHAN,
> -	MAX1027_V_CHAN(0),
> -	MAX1027_V_CHAN(1),
> -	MAX1027_V_CHAN(2),
> -	MAX1027_V_CHAN(3),
> -	MAX1027_V_CHAN(4),
> -	MAX1027_V_CHAN(5),
> -	MAX1027_V_CHAN(6),
> -	MAX1027_V_CHAN(7),
> -	MAX1027_V_CHAN(8),
> -	MAX1027_V_CHAN(9),
> -	MAX1027_V_CHAN(10),
> -	MAX1027_V_CHAN(11),
> -	MAX1027_V_CHAN(12),
> -	MAX1027_V_CHAN(13),
> -	MAX1027_V_CHAN(14),
> -	MAX1027_V_CHAN(15)
> +	MAX1X31_CHANNELS(10),
>  };
>  
>  static const unsigned long max1027_available_scan_masks[] = {
> @@ -284,7 +274,7 @@ static int max1027_read_raw(struct iio_dev *indio_dev,
>  			break;
>  		case IIO_VOLTAGE:
>  			*val = 2500;
> -			*val2 = 10;
> +			*val2 = chan->scan_type.realbits;
>  			ret = IIO_VAL_FRACTIONAL_LOG2;
>  			break;
>  		default:

