Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2F5C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5318208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hP0L+/KQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbfDYIbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 04:31:37 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56082 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfDYIbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 04:31:36 -0400
Received: by mail-wm1-f67.google.com with SMTP id o25so8095712wmf.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 01:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=GWpIqCV7aecpMJDzErQLOdtmuPZHqCWUKmKXLbghbKI=;
        b=hP0L+/KQyanCVoc5vqKGpH6+jTijjQqLSkNDVUYAD26PJNgqOxbodYVV2Q6jMNjn9K
         kjNoMQloh61PtfujPTaGFU8KlZWYtbGabGYXl+3V/dsOaG2KumlPazUuXxNKVHV4K2MJ
         SjQ3k9vJFDAtt5KtN7J2BBvH/bBInPPE9L8+/mlCYyJvME86pSJ9DvpP1Z8lYNiyXStV
         32Liy2ev5/p6DZL2EHCnmPIppVcGWtfTaGhfR/AXKgojeY9Ta1MH3Wb2XbWg2MPGlsDL
         HRW50cSTXX5bQ0YCr9CjTIIXsIIKPrYMxRGc/dDXnACkmopmdPZf5GB+l2cit4MfzXoJ
         wxIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GWpIqCV7aecpMJDzErQLOdtmuPZHqCWUKmKXLbghbKI=;
        b=B20IyXfcAxe8e/5qxW4CwaAa9pbaoU5ajHJ4z5SbqTMFcTLyHzws+rncGUaKgfo3sm
         Aobz1YJJWTc8N1Iys6gg21xZFVtvtg1hR/1gc6+taTIPfFtzMU+4zjzKwv4A0cA2iVMY
         gpo8piJQAU+v4lToSHYEW7Q8cFxvkOc0Ua7r4EVuZpMbLGh9NY2rLaMJkFwEopDv8ce4
         GDDoEdmuvtBV4/BJVu5y96aCKzex5+KKQObDCU0CBptMENdlhx7v48UEF5V7ig0NZVfP
         r8h2MwulVs0CjFLFfZqbU9pQ9qC+dsPbIgB4wnSCZZ7pCmZg0ul7qXGtGZkKbiilY8FC
         UcPg==
X-Gm-Message-State: APjAAAWLjLYycqcqgRaapKDJYOH/GDLhQI0L9YEDMCmnnTRNOWiBAa3+
        M9vRQM1W6VxpS147gEBs12jf5g==
X-Google-Smtp-Source: APXvYqzavN/8ruLVB/G8VnnIMLB846LPaCXKCFS0bKkx3Bug5OmZx37TYyoeEZOmY3KMpMJkgRyyTA==
X-Received: by 2002:a05:600c:28d:: with SMTP id 13mr2548009wmk.82.1556181094795;
        Thu, 25 Apr 2019 01:31:34 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id a22sm19230678wmj.44.2019.04.25.01.31.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 01:31:33 -0700 (PDT)
Date:   Thu, 25 Apr 2019 09:31:32 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Claudiu.Beznea@microchip.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        Ludovic.Desroches@microchip.com, bbrezillon@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, thierry.reding@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 5/7] pwm: atmel-hlcdc: add compatible for SAM9X60
 HLCDC's PWM
Message-ID: <20190425083132.GD14758@dell>
References: <1551780434-4580-1-git-send-email-claudiu.beznea@microchip.com>
 <1551780434-4580-6-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1551780434-4580-6-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Mar 2019, Claudiu.Beznea@microchip.com wrote:

> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> 
> Add compatible string for SAM9X60 HLCDC's PWM.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> Acked-by: Thierry Reding <thierry.reding@gmail.com>
> ---
>  drivers/pwm/pwm-atmel-hlcdc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
> index 54c6633d9b5d..331ca0233d9e 100644
> --- a/drivers/pwm/pwm-atmel-hlcdc.c
> +++ b/drivers/pwm/pwm-atmel-hlcdc.c
> @@ -246,6 +246,9 @@ static const struct of_device_id atmel_hlcdc_dt_ids[] = {
>  		.compatible = "atmel,sama5d4-hlcdc",
>  		.data = &atmel_hlcdc_pwm_sama5d3_errata,
>  	},
> +	{
> +		.compatible = "microchip,sam9x60-hlcdc",
> +	},

Please make this a single line entry, like the one below.

>  	{ /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, atmel_hlcdc_dt_ids);

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
