Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D571C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 10:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18FB721019
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 10:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pjJCru1a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbfCNKcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 06:32:24 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36612 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbfCNKcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 06:32:24 -0400
Received: by mail-lj1-f195.google.com with SMTP id v10so4327449lji.3;
        Thu, 14 Mar 2019 03:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7O+dLdFq/mvb4A56YlPPGJkeVTKEdQbk9vN9uHyNE4Q=;
        b=pjJCru1auQChh1wGkQiSQg6dT++kvXxYKecbIcOv8yOmzJOiB4PUix/ryRPkMCkucZ
         4Uywde7C6tihMsreOivvr5tNs3/UHzEblH8RfRz4jdklVNp47ETHySNEXIFQV+LpZXzK
         wd5H4KhfA57oo5Ei0xhzHqU5wv6GjWrn+vaLjyBv7BiJuWi//BoErZjtrfIA1I7rBLAV
         ldCBdGINorrtLfl+uTFncVBlKXsRxInAd7i2UQR6Sz56caw5tgQEwrrNS8uxnObtsxCU
         pLK07a4/FpZOaoTRCNtgdxE3p6lmQgC16/0g9UNeBp7ObvuTX+N2TV52HtTBsw47geL9
         3zOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7O+dLdFq/mvb4A56YlPPGJkeVTKEdQbk9vN9uHyNE4Q=;
        b=UywaLjs+hBhoL/MgwuC3Fwnt1jJ6Vc3iquS+Ocp3UhkyfIrwclH70SWdEZiHy8H0xF
         QMhOkxNmIoHIpAbKWkcbTdst6AUMhHZN9Q2fdUqk3WM0WQngL6HRKpg2WDD75kb/I/lO
         pS9YfkhdA0nTwkYYC/r0a1hL9moXzYgNKv7rOkxLUyH3klVJjv29hutT0c4mGybaRhe0
         xsR6PZT+3wav9FZHRu0cHpp/bciFTaAfSf8X/QBq8QVuspRL9KA7r2d5g3vj97ok8uhw
         mF3XPyVch5wpF4omwdfVZrurB0SCE7bLhqdJDskaQkv3IkEo3yGxwyfH9FsYPuZHjFr6
         SK1g==
X-Gm-Message-State: APjAAAXjjNgR0PUBa7YhXJiiScAruB3SwFOEDY+0paTiEv7NRIX6q6Ty
        ZnfQIvq2BcKSk1LT6TTaHUFKmM90
X-Google-Smtp-Source: APXvYqxlEJQrNmcYdbqVe3nX2SJr7b4eg/tXhjQinFM0gfFL4crSFhmoyJ2HUSmNpjsODe4nXSXIbw==
X-Received: by 2002:a2e:7817:: with SMTP id t23mr698044ljc.174.1552559540735;
        Thu, 14 Mar 2019 03:32:20 -0700 (PDT)
Received: from [192.168.1.18] (ckl5.neoplus.adsl.tpnet.pl. [83.31.87.5])
        by smtp.gmail.com with ESMTPSA id f1sm2342330ljf.40.2019.03.14.03.32.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 03:32:20 -0700 (PDT)
Subject: Re: [PATCH 4/4] leds: netdev trigger: allow setting initial values in
 device tree
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Pavel Machek <pavel@ucw.cz>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-can@vger.kernel.org,
        netdev@vger.kernel.org
References: <20190311144227.GA4404@amd>
 <20190313202615.22883-1-linux@rasmusvillemoes.dk>
 <20190313202615.22883-5-linux@rasmusvillemoes.dk>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <98fda0ee-555d-86a5-a4f1-1774271e4b6d@gmail.com>
Date:   Thu, 14 Mar 2019 11:32:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190313202615.22883-5-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rasmus,

Thank you for the patch set.

I have one comment below.

On 3/13/19 9:26 PM, Rasmus Villemoes wrote:
> It can be quite convenient to initialize a netdev-triggered LED with a
> device name and setting the rx,tx,link properties from device tree,
> instead of having to do that in an init script in userspace.
> 
> My main motivation for this is to be able to switch away from the
> deprecated CONFIG_CAN_LEDS, so add an example based on that and add a
> pointer in the net/can/Kconfig file.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>   .../devicetree/bindings/leds/common.txt       | 17 ++++++++++
>   drivers/leds/trigger/ledtrig-netdev.c         | 31 +++++++++++++++++++
>   drivers/net/can/Kconfig                       |  3 +-
>   3 files changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/leds/common.txt b/Documentation/devicetree/bindings/leds/common.txt
> index 7cb88460a47c..4f3a97e73417 100644
> --- a/Documentation/devicetree/bindings/leds/common.txt
> +++ b/Documentation/devicetree/bindings/leds/common.txt
> @@ -43,6 +43,23 @@ Optional properties for child nodes:
>                   Documentation/ABI/testing/sysfs-class-led-trigger-netdev)
>                   to reflect the state and activity of a net device.
>   
> +                The optional child node netdev can be used to
> +                configure initial values for the link, rx, tx and
> +                device_name properties. For example, setting
> +                linux,default-trigger = "netdev" and adding the child
> +                node
> +
> +                netdev {
> +                    rx;
> +                    tx;
> +                    link;
> +                    device-name = "can0";
> +                };
> +
> +                can be used to replace 'linux,default-trigger =
> +                "can0-rxtx"' that relies on the deprecated
> +                CONFIG_CAN_LEDS.
> +
>   - led-pattern : Array of integers with default pattern for certain triggers.
>                   Each trigger may parse this property differently:
>                   - one-shot : two numbers specifying delay on and delay off (in ms),
> diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
> index 55153a7e8433..1f7c86df1e91 100644
> --- a/drivers/leds/trigger/ledtrig-netdev.c
> +++ b/drivers/leds/trigger/ledtrig-netdev.c
> @@ -20,6 +20,7 @@
>   #include <linux/list.h>
>   #include <linux/module.h>
>   #include <linux/netdevice.h>
> +#include <linux/of.h>
>   #include <linux/spinlock.h>
>   #include <linux/timer.h>
>   #include "../leds.h"
> @@ -395,6 +396,35 @@ static void netdev_trig_work(struct work_struct *work)
>   			(atomic_read(&trigger_data->interval)*2));
>   }
>   
> +static void netdev_trig_of_init(struct led_classdev *led_cdev,
> +				struct led_netdev_data *trigger_data)
> +{
> +	struct device_node *np = led_cdev->dev->of_node;
> +	const char *device_name;
> +
> +	if (!np)
> +		return;
> +	np = of_get_child_by_name(np, "netdev");
> +	if (!np)
> +		return;
> +
> +	if (of_property_read_bool(np, "link"))
> +		__set_bit(NETDEV_LED_LINK, &trigger_data->mode);
> +	if (of_property_read_bool(np, "tx"))
> +		__set_bit(NETDEV_LED_TX, &trigger_data->mode);
> +	if (of_property_read_bool(np, "rx"))
> +		__set_bit(NETDEV_LED_RX, &trigger_data->mode);
> +	if (!of_property_read_string(np, "device-name", &device_name)) {
> +		unsigned len = strlen(device_name);
> +
> +		if (len < IFNAMSIZ)
> +			set_device(trigger_data, device_name, len);
> +	}
> +	set_baseline_state(trigger_data);
> +
> +	of_node_put(np);
> +}
> +
>   static int netdev_trig_activate(struct led_classdev *led_cdev)
>   {
>   	struct led_netdev_data *trigger_data;
> @@ -418,6 +448,7 @@ static int netdev_trig_activate(struct led_classdev *led_cdev)
>   	trigger_data->mode = 0;
>   	atomic_set(&trigger_data->interval, msecs_to_jiffies(50));
>   	trigger_data->last_activity = 0;
> +	netdev_trig_of_init(led_cdev, trigger_data);

You want to execute this only if recently introduced flag
LED_INIT_DEFAULT_TRIGGER is set. Please compare how
drivers/leds/trigger/ledtrig-pattern.c uses it.

>   
>   	led_set_trigger_data(led_cdev, trigger_data);
>   
> diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
> index e0f0ad7a550a..91703a96b636 100644
> --- a/drivers/net/can/Kconfig
> +++ b/drivers/net/can/Kconfig
> @@ -77,7 +77,8 @@ config CAN_LEDS
>   	# everything that this driver is doing. This is marked as broken
>   	# because it uses stuff that is intended to be changed or removed.
>   	# Please consider switching to the netdev trigger and confirm it
> -	# fulfills your needs instead of fixing this driver.
> +	# fulfills your needs instead of fixing this driver. See e.g.
> +	# Documentation/devicetree/bindings/leds/common.txt
>   	depends on BROKEN
>   	select LEDS_TRIGGERS
>   	---help---
> 

-- 
Best regards,
Jacek Anaszewski
