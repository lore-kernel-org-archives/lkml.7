Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269F6C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8290206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gKbX9paO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730134AbfDPRRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:17:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33472 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728478AbfDPRRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:17:42 -0400
Received: by mail-wr1-f68.google.com with SMTP id q1so28204587wrp.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 10:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bKzTzl5uqTJZw1NnpSLye4rLfSAxeWSNvGIXCP2/oiw=;
        b=gKbX9paOXwC0dXSOYoKDJV3+vydTqjtzrIbHOQEEtPpU1cJUQwtFk256a8WwBEDC+F
         YC6fbhCBdPvWJDBcacrx8lxHoq4rN+cDClBufqVSn9rqGcEEiRt3EnKkafSHPwnreWox
         XTn2ZklmYxRwq1vnpkLcO3HG/cg3rL0lkbKJJ2OPkz5ColWihyi/6cmfBIC3HKW9VEVj
         AswEtbbmngy4/n0GZs8s8EvdjYtP6ekjOYbGL1DcIOFyCRKA4Z/s1ZH3Gb+CI9nNanxx
         Be+KThAS89ZX8J0C8nmYM1qSq5P/Ie9nWItKKHnzSPvEQPRQaSichVNW8RcXmaDSTaPC
         K8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bKzTzl5uqTJZw1NnpSLye4rLfSAxeWSNvGIXCP2/oiw=;
        b=bwuezYkQh9JPsaNda9svrvGUSl8Bfuh2gVGRB7gIi/a9HdwU7mMeIg1UfAEvfKhX30
         ycO4zlP3hstUljzDZhJPeyarHYiTz244VQNK3IVIwOWxiK9vHQAkyTrviy3FubJhm0ON
         p8PfZqeW5pA3c5/UNb8INM5v7Uvgqyv8kD8pRb/mbwi2WH3rROoBUlJNdZh4km9T4KH+
         mrLUwIry65PanxCA7bvpSAFnqtBpY+qtdPXsnxoimLcaWRznt8QsE97EwQwIxZ97yK6M
         l/eukweB0BRRbUE8Lyi9dKZpxDVmgryYBnw5hyG4ORdmnNZzI8+ADxxlh5BrKH9/Mnb2
         CsJg==
X-Gm-Message-State: APjAAAWVz+9Bd5kbfPLJNEJ42A/LjzPmhsiklv0AbyJweO2+mNhw/e/b
        Wk0FD1BBd0i9VhjzQi1tWNGdXSG4QUc=
X-Google-Smtp-Source: APXvYqwFxgPkEDbMUSKlylzoYJOW76qyULDxS3N4oLwiCnOJDs+kXQWsJ6h3McJGsCrVZlMLzTrpYQ==
X-Received: by 2002:a05:6000:1111:: with SMTP id z17mr53046085wrw.103.1555435059861;
        Tue, 16 Apr 2019 10:17:39 -0700 (PDT)
Received: from [192.168.0.41] (50.251.95.92.rev.sfr.net. [92.95.251.50])
        by smtp.googlemail.com with ESMTPSA id r16sm42679707wrx.37.2019.04.16.10.17.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 10:17:39 -0700 (PDT)
Subject: Re: [PATCH v4 12/12] thermal: qoriq: Add hwmon support
To:     Andrey Smirnov <andrew.smirnov@gmail.com>, linux-pm@vger.kernel.org
Cc:     Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
References: <20190413082748.29990-1-andrew.smirnov@gmail.com>
 <20190413082748.29990-13-andrew.smirnov@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <b0fb8610-25c5-255d-8d4e-7722d37c70d7@linaro.org>
Date:   Tue, 16 Apr 2019 19:17:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190413082748.29990-13-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2019 10:27, Andrey Smirnov wrote:
> Expose thermal readings as a HWMON device, so that it could be
> accessed using lm-sensors.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Angus Ainslie (Purism) <angus@akkea.ca>
> Cc: linux-imx@nxp.com
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>


>  drivers/thermal/qoriq_thermal.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> index 5c459a9d0db3..897b3424b43b 100644
> --- a/drivers/thermal/qoriq_thermal.c
> +++ b/drivers/thermal/qoriq_thermal.c
> @@ -12,6 +12,7 @@
>  #include <linux/thermal.h>
>  
>  #include "thermal_core.h"
> +#include "thermal_hwmon.h"
>  
>  #define SITES_MAX	16
>  
> @@ -93,6 +94,10 @@ static int qoriq_tmu_register_tmu_zone(struct device *dev,
>  		case -ENODEV:
>  			continue;
>  		case 0:
> +			ret = devm_thermal_add_hwmon_sysfs(tzd);
> +			if (ret)
> +				dev_warn(dev,
> +				     "Failed to add hwmon sysfs attributes\n");
>  			break;
>  		default:
>  			regmap_write(qdata->regmap, REGS_TMR, TMR_DISABLE);
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

