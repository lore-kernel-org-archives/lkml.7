Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0539C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 20:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B8023404
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 20:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbfH2U6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 16:58:02 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:42777 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbfH2U6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 16:58:01 -0400
X-Originating-IP: 90.65.161.137
Received: from localhost (lfbn-1-1545-137.w90-65.abo.wanadoo.fr [90.65.161.137])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id E216A240010;
        Thu, 29 Aug 2019 20:57:58 +0000 (UTC)
Date:   Thu, 29 Aug 2019 22:57:52 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH 1/2] rtc: max77686: convert to devm_i2c_new_dummy_device()
Message-ID: <20190829205752.GL21922@piout.net>
References: <20190820154239.8230-1-wsa+renesas@sang-engineering.com>
 <20190820154239.8230-2-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820154239.8230-2-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/08/2019 17:42:37+0200, Wolfram Sang wrote:
> I was about to simplify the call to i2c_unregister_device() when I
> realized that converting to devm_i2c_new_dummy_device() will simplify
> the driver a lot. So I took this approach.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> Build tested only, buildbot is happy, too.
> 
> Please apply to your tree.
> 

I'm confused because I already applied:
https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git/commit/?h=rtc-next&id=7150710f3084de8d35ce3221eeae2caee8813f92

>  drivers/rtc/rtc-max77686.c | 17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
> index d04fd1024697..4027b33034dc 100644
> --- a/drivers/rtc/rtc-max77686.c
> +++ b/drivers/rtc/rtc-max77686.c
> @@ -693,8 +693,8 @@ static int max77686_init_rtc_regmap(struct max77686_rtc_info *info)
>  		goto add_rtc_irq;
>  	}
>  
> -	info->rtc = i2c_new_dummy_device(parent_i2c->adapter,
> -				  info->drv_data->rtc_i2c_addr);
> +	info->rtc = devm_i2c_new_dummy_device(info->dev, parent_i2c->adapter,
> +					      info->drv_data->rtc_i2c_addr);
>  	if (IS_ERR(info->rtc)) {
>  		dev_err(info->dev, "Failed to allocate I2C device for RTC\n");
>  		return PTR_ERR(info->rtc);
> @@ -705,7 +705,7 @@ static int max77686_init_rtc_regmap(struct max77686_rtc_info *info)
>  	if (IS_ERR(info->rtc_regmap)) {
>  		ret = PTR_ERR(info->rtc_regmap);
>  		dev_err(info->dev, "Failed to allocate RTC regmap: %d\n", ret);
> -		goto err_unregister_i2c;
> +		return ret;
>  	}
>  
>  add_rtc_irq:
> @@ -715,15 +715,10 @@ static int max77686_init_rtc_regmap(struct max77686_rtc_info *info)
>  				  &info->rtc_irq_data);
>  	if (ret < 0) {
>  		dev_err(info->dev, "Failed to add RTC irq chip: %d\n", ret);
> -		goto err_unregister_i2c;
> +		return ret;
>  	}
>  
>  	return 0;
> -
> -err_unregister_i2c:
> -	if (info->rtc)
> -		i2c_unregister_device(info->rtc);
> -	return ret;
>  }
>  
>  static int max77686_rtc_probe(struct platform_device *pdev)
> @@ -786,8 +781,6 @@ static int max77686_rtc_probe(struct platform_device *pdev)
>  
>  err_rtc:
>  	regmap_del_irq_chip(info->rtc_irq, info->rtc_irq_data);
> -	if (info->rtc)
> -		i2c_unregister_device(info->rtc);
>  
>  	return ret;
>  }
> @@ -798,8 +791,6 @@ static int max77686_rtc_remove(struct platform_device *pdev)
>  
>  	free_irq(info->virq, info);
>  	regmap_del_irq_chip(info->rtc_irq, info->rtc_irq_data);
> -	if (info->rtc)
> -		i2c_unregister_device(info->rtc);
>  
>  	return 0;
>  }
> -- 
> 2.20.1
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
