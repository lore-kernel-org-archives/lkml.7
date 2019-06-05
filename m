Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DFDC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 20:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE4952067C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 20:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2rPos/u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfFEUil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 16:38:41 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45726 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbfFEUik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 16:38:40 -0400
Received: by mail-pg1-f196.google.com with SMTP id w34so13021786pga.12;
        Wed, 05 Jun 2019 13:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Kyi91WMR4AvwDRIy5DxgM0o6bNXmSrWa07y0x+D4CAE=;
        b=H2rPos/u564e/RMxlV0kDV5IpWYrSjoJZs3LwzOA5spNEigtkKwhdm+sVNo+rle9on
         iHahXa4VDiKz3mdzMYnqMj5rDggFiHfMUtBPEuqJmHKl3S4cWVl5An67zYqOeuuZhJbd
         n548Nb8/qTkZKWXMqIRLgC015pk7VKJa4LnukLtgyNDR+UBRpSLsqDQ5ofuZkfyFoair
         n+fs2oAiOYcv3+yh98+B3sVNiWC8lhqBB/q8R3yJEiJGsD5jY5u3Ywi/UeP7EkNgMwN5
         QwfYU1xxIU8OaS8tNjtTckhKY1CO3+RpcbwwY4UAlSdJCxlCNEZZuDCPhVYYeI4zlP6N
         +xpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Kyi91WMR4AvwDRIy5DxgM0o6bNXmSrWa07y0x+D4CAE=;
        b=Ww5y2q1GIn6V0PHlFv6WVJfX4ixqpfJ4K5d5c6VGnzprUuph7wdUu77StcvkS0Ixer
         VZMwWdHkg7RJ+bgH6Me42RBUUbl5OueNjBmk5t0r7ytSyI6k1kCGnt9N2F5Dw9CJ0oyA
         FwvG36M9Nmk/EvIqNLjeaJ0N0ReEhH3b/wECZbOD/8q1VVVuY/wYxoZApviIqJ/F66jV
         Ohcsr95Es2dmbBTmyRuOLRFyiz/xgUSE7dFuLlrtOhA41kn9rF+NHnG6k4jPZL88fBtg
         PXYbWmqLv/+SfWWbgr6K5mtuxoYRauJGHE3YVB4XbEIRfZ+w1Q7cVGGWCtyNEBqdBvIH
         /1ww==
X-Gm-Message-State: APjAAAWVmUhOEPZCGH7T5IwbafE8uy2zF3vjLBshIy0ozVzxUXfGY67D
        tZ0/fiq/INFtB0dbAr6tm8s=
X-Google-Smtp-Source: APXvYqwgj03QmQKBLMhlLogbCOnzgbDTK8FMHjvQS6CX/TQmvvPXBAZAqJSqcV8zooVwaTW3ZMFPaA==
X-Received: by 2002:a63:91c4:: with SMTP id l187mr771892pge.95.1559767119687;
        Wed, 05 Jun 2019 13:38:39 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n13sm20788638pff.59.2019.06.05.13.38.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 13:38:38 -0700 (PDT)
Date:   Wed, 5 Jun 2019 13:38:38 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eduardo Valentin <eduval@amazon.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 2/2] hwmon: core: fix potential memory leak in
 *hwmon_device_register*
Message-ID: <20190605203837.GA30238@roeck-us.net>
References: <20190530025605.3698-1-eduval@amazon.com>
 <20190530025605.3698-3-eduval@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530025605.3698-3-eduval@amazon.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 07:56:05PM -0700, Eduardo Valentin wrote:
> When registering a hwmon device with HWMON_C_REGISTER_TZ flag
> in place, the hwmon subsystem will attempt to register the device
> also with the thermal subsystem. When the of-thermal registration
> fails, __hwmon_device_register jumps to ida_remove, leaving
> the locally allocated hwdev pointer.
> 
> This patch fixes the leak by jumping to a new label that
> will first unregister hdev and then fall into the kfree of hwdev
> to finally remove the idas and propagate the error code.
> 

Hah, actually this is wrong. hwdev is freed indirectly with the
device_unregister() call. See commit 74e3512731bd ("hwmon: (core)
Fix double-free in __hwmon_device_register()").

It may make sense to add a respective comment to the code, though.

Guenter

> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-hwmon@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Eduardo Valentin <eduval@amazon.com>
> ---
> V1->V2: removed the device_unregister() before jumping
> into the new label, as suggested in the first review round.
> 
>  drivers/hwmon/hwmon.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
> index 429784edd5ff..620f05fc412a 100644
> --- a/drivers/hwmon/hwmon.c
> +++ b/drivers/hwmon/hwmon.c
> @@ -652,10 +652,8 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
>  				if (info[i]->config[j] & HWMON_T_INPUT) {
>  					err = hwmon_thermal_add_sensor(dev,
>  								hwdev, j);
> -					if (err) {
> -						device_unregister(hdev);
> -						goto ida_remove;
> -					}
> +					if (err)
> +						goto device_unregister;
>  				}
>  			}
>  		}
> @@ -663,6 +661,8 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
>  
>  	return hdev;
>  
> +device_unregister:
> +	device_unregister(hdev);
>  free_hwmon:
>  	kfree(hwdev);
>  ida_remove:
