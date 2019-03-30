Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43236C10F00
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 14:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13883218D8
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 14:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553957026;
	bh=wp9S2ftnE76F5P4cBeAOxHCls5MzvF7w/Gz9WPjdNg4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Xr7ypaYKEOZb+X8HFmGAja8VkR/etpns9zK8HTbpjpZReSvWws2Sz2+iA4arkOxnw
	 xdHj1IGcZ9yQBMBLAhkCMqy6f4142ZoSlWAIEtCTGqq3UJANm+hk6DmeSkevMh+erR
	 ihPRPaRzk3Yg0p0qU2rXNdYvKcPm0knOK3psPMPY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730943AbfC3Ono (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 10:43:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:53054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730415AbfC3Ono (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 10:43:44 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14357218A3;
        Sat, 30 Mar 2019 14:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553957022;
        bh=wp9S2ftnE76F5P4cBeAOxHCls5MzvF7w/Gz9WPjdNg4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=q9aDCRxYEj552/6eEXZjZDem0cUKHZV5oRBZTRkDbZuVftxPWWmFTlxzZ8PjqtlS3
         1H+Za4N0JqZsRvvPPuJPs48m+lxdGeP9nObkfks7GODmMqG+sIYpbN/UuWwDA/KrSY
         kD0yxQ42uLu24d5EmOhXEqB2aiG8yJMZwOwWsoI8=
Date:   Sat, 30 Mar 2019 14:43:36 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, broonie@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 3/3] mfd: cros: Update EC to use BIT() and merge
Message-ID: <20190330144336.5fd8b9a0@archlinux>
In-Reply-To: <CAPUE2uuh2TvUiQCuG7KzQ=GD5Gm3C5ZbfZ42J0__H2R6yD1j9Q@mail.gmail.com>
References: <CAPUE2uti=fketJ4vJw34et_y9L_gsEUwXNDdjg0sG8Z27ir1Hg@mail.gmail.com>
        <20190329175628.31481-1-gwendal@chromium.org>
        <CAPUE2uuh2TvUiQCuG7KzQ=GD5Gm3C5ZbfZ42J0__H2R6yD1j9Q@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Mar 2019 10:56:37 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

What is "and merge" referring to in the title?

> Instead of using 1 << ..., use BIT() cleaner and safer.
> Fix minor fixes since major cros_ec_commands.h cleanup was uploaded.
> 
> TEST=compile.

Personally I'd prefer this is a a couple of patches as several
different changes going on.

A few minor comments below.

> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  include/linux/mfd/cros_ec_commands.h | 268 ++++++++++++++-------------
>  1 file changed, 143 insertions(+), 125 deletions(-)
> 
> diff --git a/include/linux/mfd/cros_ec_commands.h
> b/include/linux/mfd/cros_ec_commands.h
> index ea25e1644d23..5c4764e3db6f 100644
> --- a/include/linux/mfd/cros_ec_commands.h
> +++ b/include/linux/mfd/cros_ec_commands.h
> @@ -46,7 +46,7 @@ extern "C"{
>  #define EC_PROTO_VERSION          0x00000002
...
> 
>  /**
>   * struct ec_response_get_protocol_info - Response to the get protocol info.
> @@ -1347,12 +1347,12 @@ enum ec_feature_code {
>  	EC_FEATURE_AUDIO_CODEC = 38,
>  	/* EC Supports SCP. */
>  	EC_FEATURE_SCP = 39,
> -	/* The MCU is Intel Integrated Sensor Hub */
> +	/* The MCU is an Integrated Sensor Hub */

Unrelated from the other changes so I'd like to see it in a separate
patch.

>  	EC_FEATURE_ISH = 40,
>  };
...
>  enum ec_led_colors {
>  	EC_LED_COLOR_RED = 0,
> @@ -2438,6 +2438,7 @@ enum motionsensor_chip {
>  	MOTIONSENSE_CHIP_LIS2DE = 15,
>  	MOTIONSENSE_CHIP_LIS2MDL = 16,
>  	MOTIONSENSE_CHIP_LSM6DS3 = 17,
> +	MOTIONSENSE_CHIP_LSM6DSO = 18,

Why is this here?

>  	MOTIONSENSE_CHIP_MAX,
>  };
> 
...
> 
>  enum mkbp_config_valid {
Bit odd that this was an enum in the first place..

I checked and it doesn't seem that the type is used anywhere,
so I would just make this set of defines.

> -	EC_MKBP_VALID_SCAN_PERIOD		= 1 << 0,
> -	EC_MKBP_VALID_POLL_TIMEOUT		= 1 << 1,
> -	EC_MKBP_VALID_MIN_POST_SCAN_DELAY	= 1 << 3,
> -	EC_MKBP_VALID_OUTPUT_SETTLE		= 1 << 4,
> -	EC_MKBP_VALID_DEBOUNCE_DOWN		= 1 << 5,
> -	EC_MKBP_VALID_DEBOUNCE_UP		= 1 << 6,
> -	EC_MKBP_VALID_FIFO_MAX_DEPTH		= 1 << 7,
> +	EC_MKBP_VALID_SCAN_PERIOD		= BIT(0),
> +	EC_MKBP_VALID_POLL_TIMEOUT		= BIT(1),
> +	EC_MKBP_VALID_MIN_POST_SCAN_DELAY	= BIT(3),
> +	EC_MKBP_VALID_OUTPUT_SETTLE		= BIT(4),
> +	EC_MKBP_VALID_DEBOUNCE_DOWN		= BIT(5),
> +	EC_MKBP_VALID_DEBOUNCE_UP		= BIT(6),
> +	EC_MKBP_VALID_FIFO_MAX_DEPTH		= BIT(7),
>  };
> 
...


