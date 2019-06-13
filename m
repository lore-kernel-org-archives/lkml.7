Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C77C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8355720665
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="YleoHbS7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391521AbfFMQNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:13:07 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:48496 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731311AbfFMQNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 12:13:01 -0400
Received: from [192.168.0.20] (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9C5F652B;
        Thu, 13 Jun 2019 18:12:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1560442379;
        bh=O/PZY85pTQxQmUoStPvJKbejGO3f+dYiYwhdTvsNeVA=;
        h=Subject:To:Cc:References:From:Reply-To:Date:In-Reply-To:From;
        b=YleoHbS7pkKOhtICOcD/5Rpxd/M9jclI6y9NieMlRKvuH6xduRu7U1M5E4/M2UsxH
         semZ1DMjy1Y6yAd9L7rlNIj3AHUeUpCC8OKaYYYbwYLorQYP+9EeHWLFGKHeEbBdsp
         bEuXv4uy3FUl0Pd3dD+DUsryNmxr62lsxkV9qcyw=
Subject: Re: [PATCH 4/4] media: zd1301_demod: don't check retval after our own
 assignemt
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-media@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org, Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20190613155421.16408-1-wsa+renesas@sang-engineering.com>
 <20190613155421.16408-5-wsa+renesas@sang-engineering.com>
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Reply-To: kieran.bingham+renesas@ideasonboard.com
Organization: Ideas on Board
Message-ID: <add2dbb7-3036-8052-6063-2aa85c93f8b4@ideasonboard.com>
Date:   Thu, 13 Jun 2019 17:12:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190613155421.16408-5-wsa+renesas@sang-engineering.com>
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

With title fixed,

Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/media/dvb-frontends/zd1301_demod.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/media/dvb-frontends/zd1301_demod.c b/drivers/media/dvb-frontends/zd1301_demod.c
> index 96adbba7a82b..bbabe6a2d4f4 100644
> --- a/drivers/media/dvb-frontends/zd1301_demod.c
> +++ b/drivers/media/dvb-frontends/zd1301_demod.c
> @@ -421,8 +421,7 @@ static int zd1301_demod_i2c_master_xfer(struct i2c_adapter *adapter,
>  	} else {
>  		dev_dbg(&pdev->dev, "unknown msg[0].len=%u\n", msg[0].len);
>  		ret = -EOPNOTSUPP;
> -		if (ret)
> -			goto err;
> +		goto err;
>  	}
>  
>  	return num;
> 

