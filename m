Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACF6C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 10:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2F1A21773
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 10:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390533AbfEXK0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 06:26:13 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44012 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390447AbfEXK0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 06:26:12 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 75CCD27FC0A
Subject: Re: [PATCH v4 3/3] platform/chrome: cros_ec_spi: Request the SPI
 thread be realtime
To:     Douglas Anderson <dianders@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Benson Leung <bleung@chromium.org>
Cc:     linux-rockchip@lists.infradead.org, drinkcat@chromium.org,
        Guenter Roeck <groeck@chromium.org>, briannorris@chromium.org,
        mka@chromium.org, linux-kernel@vger.kernel.org
References: <20190515164814.258898-1-dianders@chromium.org>
 <20190515164814.258898-4-dianders@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <1150bf3c-2c95-170e-f45a-0e0117910dd1@collabora.com>
Date:   Fri, 24 May 2019 12:26:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190515164814.258898-4-dianders@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 15/5/19 18:48, Douglas Anderson wrote:
> All currently known ECs in the wild are very sensitive to timing.
> Specifically the ECs are known to drop a transfer if more than 8 ms
> passes from the assertion of the chip select until the transfer
> finishes.
> 
> Let's use the new feature introduced in the patch (spi: Allow SPI
> devices to request the pumping thread be realtime") to request the SPI
> pumping thread be realtime.  This means that if we get shunted off to
> the SPI thread for whatever reason we won't get downgraded to low
> priority.
> 
> NOTES:
> - We still need to keep ourselves as high priority since the SPI core
>   doesn't guarantee that all transfers end up on the pumping thread
>   (in fact, it tries pretty hard to do them in the calling context).
> - If future Chrome OS ECs ever fix themselves to be less sensitive
>   then we could consider adding a property (or compatible string) to
>   not set this property.  For now we need it across the board.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Guenter Roeck <groeck@chromium.org>
> ---

queued for 5.3

Thanks,
 Enric

> 
> Changes in v4: None
> Changes in v3:
> - Updated description and variable name since we no longer force.
> 
> Changes in v2:
> - Renamed variable to "force_rt_transfers".
> 
>  drivers/platform/chrome/cros_ec_spi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
> index 1e38a885c539..daf3119191c8 100644
> --- a/drivers/platform/chrome/cros_ec_spi.c
> +++ b/drivers/platform/chrome/cros_ec_spi.c
> @@ -740,6 +740,7 @@ static int cros_ec_spi_probe(struct spi_device *spi)
>  
>  	spi->bits_per_word = 8;
>  	spi->mode = SPI_MODE_0;
> +	spi->rt = true;
>  	err = spi_setup(spi);
>  	if (err < 0)
>  		return err;
> 
