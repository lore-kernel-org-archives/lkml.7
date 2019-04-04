Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20BCC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70B862184B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kxHsw/DQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732248AbfDDJGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:06:04 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36227 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732222AbfDDJF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:05:58 -0400
Received: by mail-pf1-f194.google.com with SMTP id z5so1043278pfn.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 02:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Uimt7gAGSLfQIgkWqmVinadcR4umzOLD6cDQ3S0gnEk=;
        b=kxHsw/DQShn+uWHuggKAIFYiD9wnsOigNUOAhPZ3G1p7cjt/8+kTdqYfwva4d/V6Ax
         FHMy6/NTfXWwFwLgHlCLsBHt0hXUsn7z+xgTGoP3lcUocy/EVZ7gwEq3DJaLbXetLDVp
         idJNFbnXN/m599HZPGMOYYPJfya7N9wmBfmc6UpQY4aYtRddeYKlTesTI5PCsX4XesKh
         TjT/Tk7ZKIAol5mpladqIvPFyhAhDkvAjxXEAoJQMffLAyW3xLS84rV0noMda30DTpvm
         bfKJKwDgAU9NAZR/vXEEYk03Ld//LhUEy+phfKG7CAMTKKRjSN31rISRJ1nnRhXQ8DMz
         EOEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Uimt7gAGSLfQIgkWqmVinadcR4umzOLD6cDQ3S0gnEk=;
        b=p30YLhXy/+JfZq33gGEZ0IYpWnhp8yyJKSVJfb1euvzZbU69HmAn/VBvwNn1GlxZU6
         sIdSTPR1Dk9xBokdK2h23IQA116Npgfk0jQI+djd7ceSQTWFJ3YJTeWDacAYvy4R5SGp
         qw/iJj93CD1t4wGxLoxK4LPGslNpoby88HxdrhiJaimX3RikEfLs4iB5k6hEQ4kI1Kvc
         o2wVGJVVq4LvJ9l5fLGZ7YGzc8c+TL7qASd1KlahRKM97VoG4/6x8GwofnrXQPeQ3y3g
         JpNHaghZuXek2/xYNkC1acyjH/C2UU8Xp9zkrcHqnDB+Pk/2XSa66ZAvn+nj49QDuoz4
         8wCg==
X-Gm-Message-State: APjAAAU90bO8lH/cbU7TbybKYhKWtheBIAogpBPlcBZZ3oUdA2OZ37u0
        F967snmmUvL0Hyl1QuLXrUkaC/Sl/ZPovw==
X-Google-Smtp-Source: APXvYqwCHosBCOv12QmX1Thp8vDW0ghL6b1INBdym5kJ7Er4ZgHjE2LRB2lQTKUim9dNfuPSNFL0bQ==
X-Received: by 2002:a63:6f0a:: with SMTP id k10mr4631169pgc.78.1554368756159;
        Thu, 04 Apr 2019 02:05:56 -0700 (PDT)
Received: from [10.71.14.66] ([147.50.13.10])
        by smtp.googlemail.com with ESMTPSA id f63sm18442922pfc.180.2019.04.04.02.05.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 02:05:55 -0700 (PDT)
Subject: Re: [PATCH v3 11/13] thermal: qoriq: Do not report invalid
 temperature reading
To:     Andrey Smirnov <andrew.smirnov@gmail.com>, linux-pm@vger.kernel.org
Cc:     Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
References: <20190401041418.5999-1-andrew.smirnov@gmail.com>
 <20190401041418.5999-12-andrew.smirnov@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <6b2bb239-dc98-df92-1999-0ae914732e17@linaro.org>
Date:   Thu, 4 Apr 2019 11:05:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190401041418.5999-12-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2019 06:14, Andrey Smirnov wrote:
> Before returning measured temperature data to upper layer we need to
> make sure that the reading was marked as "valid" to avoid reporting
> bogus data.

Is it possible to add a comment above the read_poll to describe the
layout of the register ? That will help to understand the valid bit.

Is the valid bit reset after reading the value?

Other than that, Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Angus Ainslie (Purism) <angus@akkea.ca>
> Cc: linux-imx@nxp.com
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/thermal/qoriq_thermal.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> index 7ff93dfcd68b..9d227654f879 100644
> --- a/drivers/thermal/qoriq_thermal.c
> +++ b/drivers/thermal/qoriq_thermal.c
> @@ -37,6 +37,7 @@
>  #define REGS_TRITSR(n)	(0x100 + 16 * (n)) /* Immediate Temperature
>  					    * Site Register
>  					    */
> +#define TRITSR_V	BIT(31)
>  #define REGS_TTRnCR(n)	(0xf10 + 4 * (n)) /* Temperature Range n
>  					   * Control Register
>  					   */
> @@ -62,10 +63,18 @@ static int tmu_get_temp(void *p, int *temp)
>  	struct qoriq_sensor *qsensor = p;
>  	struct qoriq_tmu_data *qdata = qoriq_sensor_to_data(qsensor);
>  	u32 val;
> +	int ret;
>  
> -	regmap_read(qdata->regmap, REGS_TRITSR(qsensor->id), &val);
> -	*temp = (val & 0xff) * 1000;
> +	ret = regmap_read_poll_timeout(qdata->regmap,
> +				       REGS_TRITSR(qsensor->id),
> +				       val,
> +				       val & TRITSR_V,
> +				       USEC_PER_MSEC,
> +				       10 * USEC_PER_MSEC);
> +	if (ret)
> +		return ret;
>  
> +	*temp = (val & 0xff) * 1000;
>  	return 0;
>  }
>  
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

