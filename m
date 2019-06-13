Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6CCC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8E9B20679
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="tH2xvhXj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391253AbfFMQMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:12:21 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:48476 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390977AbfFMQMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 12:12:16 -0400
Received: from [192.168.0.20] (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6DAE552B;
        Thu, 13 Jun 2019 18:12:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1560442334;
        bh=MDH6/vK3lmQEB1yXnrBhx9bgNlNkvKRT+GvpqLMcQf0=;
        h=Subject:To:Cc:References:Reply-To:From:Date:In-Reply-To:From;
        b=tH2xvhXjuEMzf4zdBEwlAvfY2JBdUFSH44OnRgHh8Q8RMgmlPbakCco5RzRNqi/GD
         +aX/JGtbTi9sHrxEbXYsrsGhyrHAKasUQrQ6uHItZkpjVjLwG5x4tloXKZaVgiy9BB
         qT6QzQGT0F927yg19zhqDFzwpLcW+4nlaHjWPz5Q=
Subject: Re: [PATCH 3/4] media: mn88473: don't check retval after our own
 assignemt
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-media@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org, Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20190613155421.16408-1-wsa+renesas@sang-engineering.com>
 <20190613155421.16408-4-wsa+renesas@sang-engineering.com>
Reply-To: kieran.bingham+renesas@ideasonboard.com
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Organization: Ideas on Board
Message-ID: <d4440370-3927-931c-9202-c32eeddf405f@ideasonboard.com>
Date:   Thu, 13 Jun 2019 17:12:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190613155421.16408-4-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On 13/06/2019 16:54, Wolfram Sang wrote:
> No need to check a retval after we assigned a constant to it.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

With title fixed.

Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

> ---
>  drivers/media/dvb-frontends/mn88473.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/dvb-frontends/mn88473.c b/drivers/media/dvb-frontends/mn88473.c
> index 08118b38533b..d1b11909825c 100644
> --- a/drivers/media/dvb-frontends/mn88473.c
> +++ b/drivers/media/dvb-frontends/mn88473.c
> @@ -661,8 +661,7 @@ static int mn88473_probe(struct i2c_client *client,
>  	if (dev->client[1] == NULL) {
>  		ret = -ENODEV;
>  		dev_err(&client->dev, "I2C registration failed\n");
> -		if (ret)
> -			goto err_regmap_0_regmap_exit;
> +		goto err_regmap_0_regmap_exit;
>  	}
>  	dev->regmap[1] = regmap_init_i2c(dev->client[1], &regmap_config);
>  	if (IS_ERR(dev->regmap[1])) {
> @@ -675,8 +674,7 @@ static int mn88473_probe(struct i2c_client *client,
>  	if (dev->client[2] == NULL) {
>  		ret = -ENODEV;
>  		dev_err(&client->dev, "2nd I2C registration failed\n");
> -		if (ret)
> -			goto err_regmap_1_regmap_exit;
> +		goto err_regmap_1_regmap_exit;
>  	}
>  	dev->regmap[2] = regmap_init_i2c(dev->client[2], &regmap_config);
>  	if (IS_ERR(dev->regmap[2])) {
> 

