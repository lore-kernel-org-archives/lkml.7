Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E674C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC4E20820
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tp7ig4g2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387594AbfDDJ2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:28:11 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45511 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733256AbfDDJMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:12:03 -0400
Received: by mail-pl1-f195.google.com with SMTP id bf11so838318plb.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 02:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ho43q3ROWJazw+Rd9c9gzv+hCkvhmE/L//gBmBUcEp0=;
        b=Tp7ig4g2M8jb3pSr3J1Aw0NfmeTlvurBOQ6tTc/hRJOCV+m1546bj4CLMqOC5ZRsZR
         WD8CThHtG/lAABQ+j9BHrXEoBtgB3tZ9bIhX8k+R/WaZarL5wVU8UK3um1U6jNrAaIpT
         n/C6vbreKy7jD9YETRyUnN/WoTTISixbORYvRA0FBM8wQJEo6/YumFCUg+SN8tuprZCT
         pC4+mkkwZazr9IPjaqV4D0LVyJiPd8Ar7NKkmsgUCn4KWQ40kYZ/YLmzQIbnKBf3aIqg
         F+XGiaV1/AV9lqcUTHsEsug178sY2RvK+UMIsbqQlahYIl69J3OWkqZeTIk+pbOLdq54
         IveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ho43q3ROWJazw+Rd9c9gzv+hCkvhmE/L//gBmBUcEp0=;
        b=d6l2kh0l7fXW4BqA71pPKR4re4qzsQJnieVa368pjn4eg3HB6P9V3Vzhla+CQl/nMm
         /ehuY4ay9EZBKMMW6KEqpsKwQGMuOukmqAIdQ7bG8HHo2VlFD6Kb1IqaoaefPFkunLe3
         ceGui+RiTMS/oIZsHGNOOKXZgw2VkXfQErztt68kZKhOsL/deanqcuL0QBqDxA8ka2Cf
         ySJmJHXnumiKj8SdCfY62dH44pu1J3C8k9+nZdAweE8o7qnOJl+L0SoCBXqJKuquOamV
         gQTPy1FBm6Cp6h4XcfY7KITl3UcKf2xRSawRaEu1IJKOwMcjAaokuTzmuiEjrREQoqx/
         3zKQ==
X-Gm-Message-State: APjAAAXVDOAASA17Uw5Rf7fNstwoekFUmC0YgNPSJ+HMh+fxvEE/ZvU6
        N8IiCRRuSmJbFQVe0XoeUTRDj21S6pBIWQ==
X-Google-Smtp-Source: APXvYqxxhbJgcp9lbT51cziPd5CZWvti5ggfpY8B2+tXAbE07bXEzORQfkVfqTq+e8Rp50rV5KNt8w==
X-Received: by 2002:a17:902:8d83:: with SMTP id v3mr5076368plo.283.1554369122382;
        Thu, 04 Apr 2019 02:12:02 -0700 (PDT)
Received: from [10.71.14.66] ([147.50.13.10])
        by smtp.googlemail.com with ESMTPSA id p189sm4415154pfg.184.2019.04.04.02.11.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 02:12:01 -0700 (PDT)
Subject: Re: [PATCH v3 13/13] thermal: qoriq: Add hwmon support
To:     Andrey Smirnov <andrew.smirnov@gmail.com>, linux-pm@vger.kernel.org
Cc:     Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
References: <20190401041418.5999-1-andrew.smirnov@gmail.com>
 <20190401041418.5999-14-andrew.smirnov@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <4c6ef4cb-8214-cda6-bfa9-8f0887fc2170@linaro.org>
Date:   Thu, 4 Apr 2019 11:11:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190401041418.5999-14-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2019 06:14, Andrey Smirnov wrote:
> Expose thermal readings as a HWMON device, so that it could be
> accessed using lm-sensors.
> 
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
>  drivers/thermal/qoriq_thermal.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> index 9d227654f879..7fb9321a0d8c 100644
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
> @@ -103,7 +104,10 @@ static int qoriq_tmu_register_tmu_zone(struct device *dev,
>  		case -ENODEV:
>  			continue;
>  		case 0:
> -			break;
> +			ret = devm_thermal_add_hwmon_sysfs(tzd);
> +			if (!ret)
> +				break;
> +			/* fallthrough */

Do we really want to disable the thermal zone if the hwmon fails to
register ?

>  		default:
>  			regmap_write(qdata->regmap, REGS_TMR, TMR_DISABLE);
>  			return ret;
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

