Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29ABC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9FCD2068E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOCQ8dKn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbfKVFwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 00:52:32 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39889 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbfKVFw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:52:27 -0500
Received: by mail-pl1-f195.google.com with SMTP id o9so2651834plk.6;
        Thu, 21 Nov 2019 21:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ckLwa/VOAk8CvjaGKDK4OpF4xZPUB1jalCdAAe4Ph14=;
        b=XOCQ8dKn0cFcZmYo9Y3f8p/f32J34C5arVvVNW7bAuVSIdRxkQ3NhYTA19JBKxfy85
         6SvTKCyrlVzzm5SPQ45PZULT/RF7QXuhEgm8AjHlv0Z/WPyKfNPpqT0gbst4OdTsa/NZ
         SgxgSbVnXQExo+FipLVfxiq6dVO+twjqoNHlhz7JJUYfBBGihpUYoE6jQ0jrLh5ITYTe
         4bREYgEMESCdCWOlu1iS6LYi72iqzzSF5VOqCMCxsMLWkJeD9aFgF9ez1oVJ/R4907Sc
         bXHalbX3kqjMLCP3OzPLeuo220JYYvyTvkW+fAkqcqeX76dRcPGxdETzqVcoYwC9wz65
         g7cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ckLwa/VOAk8CvjaGKDK4OpF4xZPUB1jalCdAAe4Ph14=;
        b=c6fZF67K0szbVY4xyyKNaKqtMBC1J3gBba4yMTBDBFXzcXhppdeAPlLtMtEOzOptxN
         Jk73V9SBcp5nqiIgTNY4k5i7Xcb3yNplYsURx4qYjpQOSfY57INMGmjEzWzymM8sJyq7
         R/Dofst0QIK3EyyappC7VourqcdHNCzSXc+T6+jicx6V88ID0fPKl0vqbCBwVvEXaVnm
         Gx5gOrWinYCe2fMfyTsBucjnpgtCe+wue1rjZd5gQJszBXlFPieYAH9FWj7LY8LPY62Z
         /HkjruJtgwIQirqTg/Pi8riVIjoXaH4bi+WNH/qS1zo9CJZdsG/F8SJsgL9UhnvDU9FE
         suHA==
X-Gm-Message-State: APjAAAWwOYFwbsN7bSl3+kFcmZEJm13YG1BiYeiG3xIriEwW6mg6z2/l
        4ueCXiyiGGH6Qv8FjhUzjkmza94W
X-Google-Smtp-Source: APXvYqywnXZbUloOg9v2/MEC9tVggw4Z6GO5iNfkOqFY20G+9JvjSna7ZWiyzs6FbZAHlBnTxD7Spw==
X-Received: by 2002:a17:902:6bc3:: with SMTP id m3mr12367822plt.329.1574401945999;
        Thu, 21 Nov 2019 21:52:25 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i2sm5073190pgt.34.2019.11.21.21.52.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 21:52:25 -0800 (PST)
Subject: Re: [PATCH] hwmon: Fix Kconfig indentation
To:     Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
References: <20191120134153.15418-1-krzk@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <e93c7c7e-dac7-8c8d-c68a-edaa9106d6ac@roeck-us.net>
Date:   Thu, 21 Nov 2019 21:52:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191120134153.15418-1-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/19 5:41 AM, Krzysztof Kozlowski wrote:
> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
> 	$ sed -e 's/^        /\t/' -i */Kconfig
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Quite frankly I'd rather not have to deal with such cosmetic changes.

Guenter

> ---
>   drivers/hwmon/Kconfig | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 2b73d5fc7966..1dc4f1226496 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -495,10 +495,10 @@ config SENSORS_F75375S
>   	  will be called f75375s.
>   
>   config SENSORS_MC13783_ADC
> -        tristate "Freescale MC13783/MC13892 ADC"
> -        depends on MFD_MC13XXX
> -        help
> -          Support for the A/D converter on MC13783 and MC13892 PMIC.
> +	tristate "Freescale MC13783/MC13892 ADC"
> +	depends on MFD_MC13XXX
> +	help
> +	  Support for the A/D converter on MC13783 and MC13892 PMIC.
>   
>   config SENSORS_FSCHMD
>   	tristate "Fujitsu Siemens Computers sensor chips"
> @@ -1314,10 +1314,10 @@ config SENSORS_NPCM7XX
>   	imply THERMAL
>   	help
>   	  This driver provides support for Nuvoton NPCM750/730/715/705 PWM
> -          and Fan controllers.
> +	  and Fan controllers.
>   
> -          This driver can also be built as a module. If so, the module
> -          will be called npcm750-pwm-fan.
> +	  This driver can also be built as a module. If so, the module
> +	  will be called npcm750-pwm-fan.
>   
>   config SENSORS_NSA320
>   	tristate "ZyXEL NSA320 and compatible fan speed and temperature sensors"
> 

