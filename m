Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89D3C04E84
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81A1E206C1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1gv8NEy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfE1PGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 11:06:44 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45810 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbfE1PGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 11:06:44 -0400
Received: by mail-pf1-f194.google.com with SMTP id s11so11651577pfm.12;
        Tue, 28 May 2019 08:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mm2eg5VvBxWkTD+xyKpkkSmitl4OkwjYISivJ/RPFTo=;
        b=m1gv8NEyhr5iGJZTmKRVo6dWfuvkiP68dIT1XD5P1l0CjFL3A+5K14UmwEQgVrgHbE
         zuF7s5hzluEkLOjCCx0Sovww4luN6X8OhkHkuOpKVhez5lPMiYV7jRlMxzPuo3zBnx0b
         GXnifUd9P7Yc36Tp4vZqTLHEin3IYOExQjxoaL2sSd5I7bDQPvnVLxbocNjL90LQRtSx
         fXtW8uEaseCV4oy8rZ/Js+4TyQV6VCZ81IpiZK/6xBsQl4Xpk3WRSNkyrSFao2ESfWRr
         wSgBHcvHggwEi31SuWwMNmVcV3dREZj5MT7ZxrI9r+kTIKRk4QnHWzYENP/9azBmDzpm
         v20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=mm2eg5VvBxWkTD+xyKpkkSmitl4OkwjYISivJ/RPFTo=;
        b=WNAZdmMCnNynkZFDsPhQ9njDgzcnZGyW5BXZavHoCtlodGYWHS37XkymUr3HrdpJt/
         kFfOjMpr+rqmVAauaXbhEZbktLUjYnw6VYJzAjkDXxtdBT6kwxcwrJrJ2+aW/MUTap5u
         puFRk2VeV7SDd4U1duyga3+w7qSusXXVnuTI81IWyh4okOCTVvIaLKjR/0QUlMGmpVgj
         awg1s773AEYhlq/LJDziF0fYJZMaCce7tNv31bwG84i+bEx4fmo4Z2uN2namby0yxJZx
         YXAQKVYpAUcofOJa5MpkticZLQo7C/13fSvqAo1o2eFcu4LSK5KGWihh8TB8KKg0XqCJ
         FTqA==
X-Gm-Message-State: APjAAAVCVioWOavhTXuYyVfcXUxtnnqLAxYrMraHp+yRUia3nQkDY/d8
        C+xXZZLZI6aAr0HcsC5j43udever
X-Google-Smtp-Source: APXvYqzRF+4I2yVFArh9jdQwAK+CNlNUXHU+L4V8cuhCR8gytl9r2S/2Ep0orCThJo74ZH/Y9TOOyw==
X-Received: by 2002:aa7:8a95:: with SMTP id a21mr82896169pfc.215.1559056003383;
        Tue, 28 May 2019 08:06:43 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c127sm15415538pfb.107.2019.05.28.08.06.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 08:06:42 -0700 (PDT)
Date:   Tue, 28 May 2019 08:06:40 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eduardo Valentin <eduval@amazon.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: core: fix potential memory leak in
 *hwmon_device_register*
Message-ID: <20190528150640.GA5516@roeck-us.net>
References: <20190517231337.27859-1-eduval@amazon.com>
 <20190517231337.27859-3-eduval@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517231337.27859-3-eduval@amazon.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eduardo,

On Fri, May 17, 2019 at 04:13:37PM -0700, Eduardo Valentin wrote:
> When registering a hwmon device with HWMON_C_REGISTER_TZ flag
> in place, the hwmon subsystem will attempt to register the device
> also with the thermal subsystem. When the of-thermal registration
> fails, __hwmon_device_register jumps to ida_remove, leaving
> the locally allocated hwdev pointer and also the hdev registered.
> 
> This patch fixes both issues by jumping to a new label that
> will first unregister hdev and the fall into the kfree of hwdev
> to finally remove the idas and propagate the error code.
> 
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-hwmon@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Eduardo Valentin <eduval@amazon.com>
> ---
>  drivers/hwmon/hwmon.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
> index 6b3559f58b67..6f1194952189 100644
> --- a/drivers/hwmon/hwmon.c
> +++ b/drivers/hwmon/hwmon.c
> @@ -637,7 +637,7 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
>  								hwdev, j);
>  					if (err) {
>  						device_unregister(hdev);
> -						goto ida_remove;
> +						goto device_unregister;

Good find, but device_unregister() is already called above.
You need to either remove that, or replace the goto to point to free_hwmon.
The new label would probably the cleaner solution since it follows the
coding style.

Thanks
Guenter

>  					}
>  				}
>  			}
> @@ -646,6 +646,8 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
>  
>  	return hdev;
>  
> +device_unregister:
> +	device_unregister(hdev);
>  free_hwmon:
>  	kfree(hwdev);
>  ida_remove:
> -- 
> 2.21.0
> 
