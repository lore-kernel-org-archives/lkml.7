Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DBFC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 16:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D69F20645
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 16:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQZ2NgMq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729640AbfFFQFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 12:05:49 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37905 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729595AbfFFQFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 12:05:43 -0400
Received: by mail-pf1-f193.google.com with SMTP id a186so1789594pfa.5;
        Thu, 06 Jun 2019 09:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RsUBXGCWWwX7lyjcxWY8cLlq71Ab4rZ0DW+0q/5EnKk=;
        b=kQZ2NgMq7OSik7fMh83uJyEoEcPZwmwHs1jR+D94vMj/RCdGcG1yt2mmdwY5yPfcao
         Ot1F6nQZK+rcWU+pxiTV6KtEPDmZStHTiRWdyhFH0dedPlaWe2luEsEZjcexAthRYoYc
         eHZ8a2GpOFBo0YksDkQQbwNPrG5Y8Amf567FrDk0mFEu0/QX+2vwqW05c8/XDnrDHjof
         jPuZYPEalDmfN+ZaNKMQJEC28TDALHmFoCEsMzkF8/WoJyAjVH4A7FGK8PI5scAY+KZ2
         PTAlfDPluWNm8DKWnfR+kJSe9jUp7UbvX/MF10HeI+0Qj03keyaE6YCxropzR2680R2B
         Gppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=RsUBXGCWWwX7lyjcxWY8cLlq71Ab4rZ0DW+0q/5EnKk=;
        b=Si2o6YmwjWmgyrvqOI05iaxa6LUe3+RhOYvy1/DswCupec/8uSbTLQE4ESCNNMeYIC
         Uv5WAmyrtZurrmsQWHbuZcEHaqFDKNhfh3MplIE2IP5QhzjXJB57muXJ9Y6Itwa/bMru
         tu/W5aviHUuoHr3EqJtWrt664rxJ+FdKJyY+5hAUCqoewuftgefSZUFTzUPvw5DciDXj
         ZT/gM3V8I0JlqpQqHDiMWF6xXVDpDB8Utnvy/VAoPoY0o6h3PMzLGfusQOKT8+dbBHxr
         Fyty24w/dDYEJIWkkT5VKcpzua4HJ7xnhn5ckQX8XqJmS+WxP+wIzH5h5M6fOplOYFjj
         YPdg==
X-Gm-Message-State: APjAAAU4u5e22M0NGzXtL74+6+TQoWThG5sKZOe1/xp/yboMTxIhiRLS
        lG9Sx2+JnLeajzhU8gRu5i8=
X-Google-Smtp-Source: APXvYqxdYZT7ZicCPTapEFHqm9bYk5t5/iR2qqdEFJmqcjLLy7yFRYBTEByjzh/AWIwb0ncE8f9F5g==
X-Received: by 2002:a17:90a:2627:: with SMTP id l36mr612651pje.71.1559837142266;
        Thu, 06 Jun 2019 09:05:42 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 188sm6099699pfe.30.2019.06.06.09.05.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 09:05:40 -0700 (PDT)
Date:   Thu, 6 Jun 2019 09:05:38 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        "amy.shih" <amy.shih@advantech.com.tw>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] hwmon: (nct7904) Avoid fall-through warnings
Message-ID: <20190606160538.GA29430@roeck-us.net>
References: <20190606140659.GA2970@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606140659.GA2970@embeddedor>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

On Thu, Jun 06, 2019 at 09:06:59AM -0500, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, this patch silences
> the following warnings:
> 

Thanks a lot for the patch. I pulled the patch introducing the problem
due to other issues with it.

Guenter

> drivers/hwmon/nct7904.c: In function 'nct7904_in_is_visible':
> drivers/hwmon/nct7904.c:313:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if (channel > 0 && (data->vsen_mask & BIT(index)))
>       ^
> drivers/hwmon/nct7904.c:315:2: note: here
>   case hwmon_in_min:
>   ^~~~
> drivers/hwmon/nct7904.c: In function 'nct7904_fan_is_visible':
> drivers/hwmon/nct7904.c:230:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if (data->fanin_mask & (1 << channel))
>       ^
> drivers/hwmon/nct7904.c:232:2: note: here
>   case hwmon_fan_min:
>   ^~~~
> drivers/hwmon/nct7904.c: In function 'nct7904_temp_is_visible':
> drivers/hwmon/nct7904.c:443:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if (channel < 5) {
>       ^
> drivers/hwmon/nct7904.c:450:2: note: here
>   case hwmon_temp_max:
>   ^~~~
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/hwmon/nct7904.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
> index dd450dd29ac7..bf35dfd2d3a7 100644
> --- a/drivers/hwmon/nct7904.c
> +++ b/drivers/hwmon/nct7904.c
> @@ -229,6 +229,7 @@ static umode_t nct7904_fan_is_visible(const void *_data, u32 attr, int channel)
>  	case hwmon_fan_alarm:
>  		if (data->fanin_mask & (1 << channel))
>  			return 0444;
> +		break;
>  	case hwmon_fan_min:
>  		if (data->fanin_mask & (1 << channel))
>  			return 0644;
> @@ -312,6 +313,7 @@ static umode_t nct7904_in_is_visible(const void *_data, u32 attr, int channel)
>  	case hwmon_in_alarm:
>  		if (channel > 0 && (data->vsen_mask & BIT(index)))
>  			return 0444;
> +		break;
>  	case hwmon_in_min:
>  	case hwmon_in_max:
>  		if (channel > 0 && (data->vsen_mask & BIT(index)))
> @@ -447,6 +449,7 @@ static umode_t nct7904_temp_is_visible(const void *_data, u32 attr, int channel)
>  			if (data->has_dts & BIT(channel - 5))
>  				return 0444;
>  		}
> +		break;
>  	case hwmon_temp_max:
>  	case hwmon_temp_max_hyst:
>  	case hwmon_temp_emergency:
> -- 
> 2.21.0
> 
