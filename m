Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69247C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 12:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 394B7229F3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 12:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZgU8NX20"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404597AbfGYMTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 08:19:32 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35345 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfGYMTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 08:19:31 -0400
Received: by mail-wm1-f65.google.com with SMTP id l2so44540885wmg.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 05:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=LTAelRykTcQsMGZiOD2meawU2MXWXjMpurunnVZ0OLs=;
        b=ZgU8NX20SnrH4JTyQkdwQsJijQ4lrxhmhV1VvRzqnyzVG94k9thoc7CqtqDOyytybv
         Oo/mD+ynA48dpK5RKUim4K+Jj5tEO+kSi7T5Y4J6SFAS2DUgXobCGMWNVMUzIDOpSB+6
         xpRHG7bY4hcqy9LQDfS5C7nhfQQ1cJxDimTnw97cYWbt94oSwTeOPzo0IAUBqEQJ4tZy
         MqfbovAX3n47iMNT2kQ66tzQ5c60WVbSSO2oMdqo++MaQDXKACN9lIwnHd9giYrp9B1a
         fLSx4Sbu6iHk5vOiZ6OvZIrGP5fvUsZuDANwEWWEynmCjGneRlggmpXnHlckatzFVYSm
         JR2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LTAelRykTcQsMGZiOD2meawU2MXWXjMpurunnVZ0OLs=;
        b=jQPf7P8NTC27AMla4LBNrcX55IeDaj7+aR5lqJvoTpReqczKM+SkuwKeouP+V4MnyU
         t3wg2stHIGcaX0q4pLhYyGc1WfDzNuM1CTH4S2mWJioYiRm+/BtILR5gnS0J/Aw5H6pn
         fWWh6j4yg29BamF/fKZqCW9+Z8NlIjgSvOXwXHx0j5soveGhDeJNBylZD/t9aWswj2yI
         GcTz5iqXUcHSJFkEpkvCw3PPJW/9BumKQi4yrMM2Upr0Sgb+4nPQKyrzakz3So196G59
         T6/FFBoO5LuOKlPsvwB9rJljIckhTCTn7DZEQrk0TlvehICtuh+dhAl3g2XwQqlSrlju
         EQ6Q==
X-Gm-Message-State: APjAAAU8PhP2wVyWFWLrsi8A789kIZWfXqvl/K6PhSwsvrgViUpWqvqK
        5LVsaQ9mtI+QAqZfiLf57toUqYMsQaE=
X-Google-Smtp-Source: APXvYqyzNZrg7xg4CbziCpPXUm4u/iD59jJI+9EAM99K1GccLpzVlSzH0hKdtOJtJenWbAvRF+JYEw==
X-Received: by 2002:a7b:c215:: with SMTP id x21mr79962509wmi.38.1564057169615;
        Thu, 25 Jul 2019 05:19:29 -0700 (PDT)
Received: from dell ([2.27.35.164])
        by smtp.gmail.com with ESMTPSA id y2sm40416390wrl.4.2019.07.25.05.19.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jul 2019 05:19:29 -0700 (PDT)
Date:   Thu, 25 Jul 2019 13:19:17 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     tony.xie@rock-chips.com, stefan@olimex.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mfd: rk808: Mark rk8xx_resume and rk8xx_suspend as
 __maybe_unused
Message-ID: <20190725121917.GH23883@dell>
References: <20190711033006.55320-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190711033006.55320-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jul 2019, YueHaibing wrote:

> Fix build warning:
> 
> drivers/mfd/rk808.c:752:12: warning: 'rk8xx_resume' defined but not used [-Wunused-function]
> drivers/mfd/rk808.c:732:12: warning: 'rk8xx_suspend' defined but not used [-Wunused-function]
> 
> The function is declared unconditionally but only called
> while CONFIG_PM_SLEEP is set.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/mfd/rk808.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Arnd already fixed this.

> diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
> index 601cefb..9a9e631 100644
> --- a/drivers/mfd/rk808.c
> +++ b/drivers/mfd/rk808.c
> @@ -729,7 +729,7 @@ static int rk808_remove(struct i2c_client *client)
>  	return 0;
>  }
>  
> -static int rk8xx_suspend(struct device *dev)
> +static int __maybe_unused rk8xx_suspend(struct device *dev)
>  {
>  	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
>  	int ret = 0;
> @@ -749,7 +749,7 @@ static int rk8xx_suspend(struct device *dev)
>  	return ret;
>  }
>  
> -static int rk8xx_resume(struct device *dev)
> +static int __maybe_unused rk8xx_resume(struct device *dev)
>  {
>  	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
>  	int ret = 0;

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
