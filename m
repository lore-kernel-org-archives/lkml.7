Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBA3C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 16:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1563E20652
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 16:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UX01wX2y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbfFQQ5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 12:57:23 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36571 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbfFQQ5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 12:57:23 -0400
Received: by mail-pl1-f194.google.com with SMTP id k8so3356766plt.3;
        Mon, 17 Jun 2019 09:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4Z8Vbr3YKnaNKpG8GfJhiPwpSsNIVi+eSrGRZZOg1QU=;
        b=UX01wX2yPj1xnYn4erV0D1hmO1GgcPwwXWfq7d3YGWoJA5L4u4LO91RTA0SHoQpwBa
         O1SVTvbYXqSUyIQRqUk2GIxfpj2XxjtPd0Cs3M8bm+rWCZam7B9HLrCd0aXyl8USFktd
         6BLd8CflsJA3b8yFlsr65fmfym9TuxqmtIm/nDRdlvj2NV6BnWmiAkL4eWUTDeoOQEpt
         j66Q9tuZd11qhcmn2BEUw8La7GKJfBfy088Z+/00O4UrbLhXuK/zTYXOJgEaUlVx1vBG
         tzMOsrIPdRrBEkXcHXRta31Xu+LsACa8SI4Qb4+jXA/54tcVGR/6Jiqzj1qVBZ9Goumv
         XZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=4Z8Vbr3YKnaNKpG8GfJhiPwpSsNIVi+eSrGRZZOg1QU=;
        b=AcoTOydi6CnBHpZM0wg/AclTXYZOtn7UUOSf8CYFlHPzjAT8F78F3+rmqfmHsDa7yH
         1cXOKQzGSzclO3a3oTCB5jjYKgDx2pd0YnqiLfeDghDqKaKta7GfhtlTyuHJWeIl8ktz
         9ScfNti16nXddcqUy/X8AsSZh5a56ShbsXAMO6Fkzi1Hdglkrv6y31rlQvfi+4NgTxfo
         Bj0aXFhTivmg9/4BF6GBE/P1h+LPJpBRCnbc/hGzyMGm3ZB88pV6sqpuTHT39tkNRZ9z
         nOYqM5zhOrO01YFtbSoE3L0f6YGLNUfdeCNGZuBikCvB9O/F0QhTEAXWKq60tRCx4XZS
         oSnQ==
X-Gm-Message-State: APjAAAUlNnZmeDGckzO6bwI1Ot5dC8fxO/DIeXHD6J8zFDpiHY+CgzTC
        3NDwCH217e2UbPa83SPgkWE9+h3d
X-Google-Smtp-Source: APXvYqwyKt1tbHQ1bIcJua69G5GT/9t2S8tJsKAfc5/KyAyJMF435G8FVut4dfvk9viBbAsxuDqRxw==
X-Received: by 2002:a17:902:8d89:: with SMTP id v9mr85271774plo.99.1560790642106;
        Mon, 17 Jun 2019 09:57:22 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s12sm10664111pji.30.2019.06.17.09.57.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 09:57:21 -0700 (PDT)
Date:   Mon, 17 Jun 2019 09:57:19 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Jean-Francois Dagenais <jeff.dagenais@gmail.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (max6650) Fix unused variable warning
Message-ID: <20190617165719.GA12640@roeck-us.net>
References: <20190617123746.769592-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617123746.769592-1-arnd@arndb.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 02:34:30PM +0200, Arnd Bergmann wrote:
> The newly added variable is only used in an #if block:
> 
> drivers/hwmon/max6650.c: In function 'max6650_probe':
> drivers/hwmon/max6650.c:766:33: error: unused variable 'cooling_dev' [-Werror=unused-variable]
> 
> Change the #if to if() so the compiler can see what is actually
> going on.
> 
> Fixes: a8463754a5a9 ("hwmon: (max6650) Use devm function to register thermal device")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/max6650.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/hwmon/max6650.c b/drivers/hwmon/max6650.c
> index 5fdad4645cca..3d9d371c35b5 100644
> --- a/drivers/hwmon/max6650.c
> +++ b/drivers/hwmon/max6650.c
> @@ -467,8 +467,6 @@ static int max6650_init_client(struct max6650_data *data,
>  	return 0;
>  }
>  
> -#if IS_ENABLED(CONFIG_THERMAL)
> -
>  static int max6650_get_max_state(struct thermal_cooling_device *cdev,
>  				 unsigned long *state)
>  {
> @@ -517,7 +515,6 @@ static const struct thermal_cooling_device_ops max6650_cooling_ops = {
>  	.get_cur_state = max6650_get_cur_state,
>  	.set_cur_state = max6650_set_cur_state,
>  };
> -#endif
>  
>  static int max6650_read(struct device *dev, enum hwmon_sensor_types type,
>  			u32 attr, int channel, long *val)
> @@ -795,14 +792,16 @@ static int max6650_probe(struct i2c_client *client,
>  	if (err)
>  		return err;
>  
> -#if IS_ENABLED(CONFIG_THERMAL)
> -	cooling_dev = devm_thermal_of_cooling_device_register(dev, dev->of_node,
> -				client->name, data, &max6650_cooling_ops);
> -	if (IS_ERR(cooling_dev)) {
> -		dev_warn(dev, "thermal cooling device register failed: %ld\n",
> -			 PTR_ERR(cooling_dev));
> +	if (IS_ENABLED(CONFIG_THERMAL)) {
> +		cooling_dev = devm_thermal_of_cooling_device_register(dev,
> +						dev->of_node, client->name,
> +						data, &max6650_cooling_ops);
> +		if (IS_ERR(cooling_dev)) {
> +			dev_warn(dev, "thermal cooling device register failed: %ld\n",
> +				 PTR_ERR(cooling_dev));
> +		}
>  	}
> -#endif
> +
>  	return 0;
>  }
>  
