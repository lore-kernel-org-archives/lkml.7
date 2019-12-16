Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71C7C2D0C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 16:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE8C2206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 16:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qyo3qjQ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfLPQYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 11:24:09 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52722 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfLPQYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 11:24:09 -0500
Received: by mail-wm1-f67.google.com with SMTP id p9so7422036wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 08:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=llbkzlKSPIxwUXHWHgtqCw4kPqPvje1n5crDMdl/6tU=;
        b=qyo3qjQ6M9XGQSxgffMeMJUKMr8fujgew/LhXKhz2wdQG0sirrHw705Vp5FMH1Gene
         AMpppauj9lm4EqTDVn5sKT7re72xJWRtemS3Ltbdl3KKiwbH0Xkd3dsfBeRSKdipx15B
         v4ARdMaqDVZlhL5xZTWtjqai9RjyEcvFQxSH2ukyT3mL0wKR5DuvzB1joAD+IfnOldTa
         3VrfnJT4ZkiCVHcrPRubHViFym19DaqlL9/pC9tZlmp8/OAbVjcVZjPDw1EGSUydpQmX
         vwxiQxpufqd46BDsGnYd+x9cvJVZhd2IGq3ftVPSY6dmRrMWIrj494qqGVfYJqCw1Q33
         Us9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=llbkzlKSPIxwUXHWHgtqCw4kPqPvje1n5crDMdl/6tU=;
        b=NZSwVg6viRNJojL8JPD5Tpu+52TROoPIUj0SxuUdT2+3WaR5w+y26FKia1zX8Vl2zp
         iyfLW+r1/e6dSYZCFeQbbIGOr7vELvSGdVEPrt/Xg956J8ROBt9olPohdVOmV7+Y3t9M
         uxR35Ytb+9x8uU9iqR4Sck3jomJ3/8gclXR8hdYyRSu3Q3+zuBkwFoO2XxwyDIcrCi44
         4acp93EuwgiT+LQye3o+BF2Ea3c4MlzOPWggdSjThrMCYApbu77xZUCDtll5fA3NhBy9
         ev/850/TJcKaVP2woTrEmsc+yoEecm3Hns6rvZip3j5GR2PIF2BfZoS64Ta5hhGXU3+6
         JQdA==
X-Gm-Message-State: APjAAAW0276g7e6lLbt4bNpFFUThVyVoXAqLx1Gqlaq4tCbyTaEwe3Rx
        Lx5FOn9yGWr8V1lOkj7e9DJhwA==
X-Google-Smtp-Source: APXvYqw/af4JJwzf37BYYywEn5ThaK6uC1VvISuGJMJj+/VkvCJB0tA9xjXtKQNDvnU5wA80dfkrJw==
X-Received: by 2002:a7b:c847:: with SMTP id c7mr31241155wml.3.1576513447276;
        Mon, 16 Dec 2019 08:24:07 -0800 (PST)
Received: from dell ([185.17.149.202])
        by smtp.gmail.com with ESMTPSA id h8sm23512856wrx.63.2019.12.16.08.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 08:24:06 -0800 (PST)
Date:   Mon, 16 Dec 2019 16:24:06 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     sam@ravnborg.org, bbrezillon@kernel.org, airlied@linux.ie,
        daniel@ffwll.ch, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] mfd: atmel-hlcdc: return in case of error
Message-ID: <20191216162406.GQ2369@dell>
References: <1576249496-4849-1-git-send-email-claudiu.beznea@microchip.com>
 <1576249496-4849-5-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1576249496-4849-5-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Dec 2019, Claudiu Beznea wrote:

> For HLCDC timing engine configurations bit ATMEL_HLCDC_SIP of
> ATMEL_HLCDC_SR needs to be polled before applying new config. In case of
> timeout there is no indicator about this, so, return in case of timeout
> and also print a message about this.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  drivers/mfd/atmel-hlcdc.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mfd/atmel-hlcdc.c b/drivers/mfd/atmel-hlcdc.c
> index 92bfcaa62ace..a1e46c87b956 100644
> --- a/drivers/mfd/atmel-hlcdc.c
> +++ b/drivers/mfd/atmel-hlcdc.c
> @@ -40,10 +40,17 @@ static int regmap_atmel_hlcdc_reg_write(void *context, unsigned int reg,
>  
>  	if (reg <= ATMEL_HLCDC_DIS) {
>  		u32 status;
> -
> -		readl_poll_timeout_atomic(hregmap->regs + ATMEL_HLCDC_SR,
> -					  status, !(status & ATMEL_HLCDC_SIP),
> -					  1, 100);
> +		int ret;
> +
> +		ret = readl_poll_timeout_atomic(hregmap->regs + ATMEL_HLCDC_SR,
> +						status,
> +						!(status & ATMEL_HLCDC_SIP),
> +						1, 100);
> +		if (ret) {
> +			dev_err(hregmap->dev,
> +				"Timeout waiting for ATMEL_HLCDC_SIP\n");

Nit: Just in case you have to rework this, placing register names in
the kernel log isn't usually helpful.  Can you swap it out for a more
user friendly message?

"Timed out waiting for ..."

... X status
... Y to update
... setting Z configuration

Etc.

> +			return ret;
> +		}
>  	}
>  
>  	writel(val, hregmap->regs + reg);

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
