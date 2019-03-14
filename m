Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F92AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 643F021019
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TgVrSegf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbfCNOZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 10:25:02 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:47025 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfCNOZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 10:25:02 -0400
Received: by mail-lj1-f193.google.com with SMTP id z26so4772807lja.13;
        Thu, 14 Mar 2019 07:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GL7ivHolIpbLrQMvm5OFCgQLnvg/inketaGwVxG8Spc=;
        b=TgVrSegfdNOg0sWh7zA1qzms2lCrcJM5+dTFvgPXghzRDlPEYi8MVo3Xiw2024Y6tT
         LGRLaH3Y2NF3I2UFjA6sAnysqdW8LoEcCxK0EL2Xx7qcGRgrxLG1vnTT9/Hg8427ONa1
         hVSf3QZIKvMl+QM3xLmik2UEV8+Us7pR+TpaHb7j8RFmxuN2DaeNZm0C1ykwkapgHY3l
         EuoiMoDB/CMszIbrs5rYUdVSlZ38iYq4ytiy9Ss+ZxCQ8GXKfp71xpP8W26yF4Q4hyWV
         8NfZ0wVM8OxThNCJsKxfc3eQeIQleyKxarBrHYOtJRnMfD27LVYzjZkrcDU/k202c9Lm
         w8ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GL7ivHolIpbLrQMvm5OFCgQLnvg/inketaGwVxG8Spc=;
        b=ett0xjCAt54Ll8VIJ0WjXHxX0MA+lfO7xDKihD5GeFaX0ZrABdURDmz55fkSAzPDLA
         ElyNpvzRYU7ViqH3zoFLPjHVEJXZWcFu7KGrW5jkd9bX2UOdXWonphJf7jdD/W5CvSdi
         csUdNrfDReJUq1pp1pKsb/B5T5Kab3oKi5aTc5huke7CrfYYbN+kCiNAvOMCa0vH+FJL
         x9SR/ENEoKFhCIi/MRaK8TInorMduYG6fy25hVOXYgEaHwsP1/yheMvmyUqrxKHYVnRM
         HD500Lzv1lW0IWzSF8YujjI5YH9TjUG9fMDbIOw0dT8mzb3jI31cIQK6guG0HT9kJTlZ
         F6sw==
X-Gm-Message-State: APjAAAWLGN15IPXdvN28ID7UB0IznWjbWyVIXSmFDg88NeFpBMKvqUbC
        O94vfmqwX9UJh5mOuqj72CiO2Evs
X-Google-Smtp-Source: APXvYqxpuWmclw6HvZ62o0IR3JVfBOSRkxYWVSIGNLolYKSCQ7qK11cHzV1ThkYEQEs+elH8YG5YkA==
X-Received: by 2002:a2e:8701:: with SMTP id m1mr1037174lji.132.1552573498982;
        Thu, 14 Mar 2019 07:24:58 -0700 (PDT)
Received: from [192.168.1.18] (bfw164.neoplus.adsl.tpnet.pl. [83.28.60.164])
        by smtp.gmail.com with ESMTPSA id s26sm896476ljj.77.2019.03.14.07.24.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 07:24:58 -0700 (PDT)
Subject: Re: [PATCH v2 6/6] leds: netdev trigger: allow setting initial values
 in device tree
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Pavel Machek <pavel@ucw.cz>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20190313202615.22883-1-linux@rasmusvillemoes.dk>
 <20190314140619.3309-1-linux@rasmusvillemoes.dk>
 <20190314140619.3309-7-linux@rasmusvillemoes.dk>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <742bd6b2-0a11-858e-d727-204b0313265e@gmail.com>
Date:   Thu, 14 Mar 2019 15:24:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190314140619.3309-7-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rasmus,

Thank you for the update.
Still, there is one thing to improve.

On 3/14/19 3:06 PM, Rasmus Villemoes wrote:
> It can be quite convenient to initialize a netdev-triggered LED with a
> device name and setting the rx,tx,link properties from device tree,
> instead of having to do that in an init script (or udev rule) in
> userspace.
> 
> My main motivation for this is to be able to switch away from the
> deprecated CONFIG_CAN_LEDS. The example added to common.txt
> corresponds to switching linux,default-trigger = "can0-rxtx" to
> "netdev" and adding the indicated netdev subnode.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>   .../devicetree/bindings/leds/common.txt       | 11 +++++++
>   drivers/leds/trigger/ledtrig-netdev.c         | 30 +++++++++++++++++++
>   2 files changed, 41 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/leds/common.txt b/Documentation/devicetree/bindings/leds/common.txt
> index 7cb88460a47c..f8078c4cf6f8 100644
> --- a/Documentation/devicetree/bindings/leds/common.txt
> +++ b/Documentation/devicetree/bindings/leds/common.txt
> @@ -43,6 +43,17 @@ Optional properties for child nodes:
>                   Documentation/ABI/testing/sysfs-class-led-trigger-netdev)
>                   to reflect the state and activity of a net device.
>   
> +                The optional child node netdev can be used to
> +                configure initial values for the link, rx, tx and
> +                device_name properties. For example,
> +
> +                netdev {
> +                    rx;
> +                    tx;
> +                    link;
> +                    device-name = "can0";
> +                };
> +
>   - led-pattern : Array of integers with default pattern for certain triggers.
>                   Each trigger may parse this property differently:
>                   - one-shot : two numbers specifying delay on and delay off (in ms),
> diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
> index e4a76ce4e4c7..387932cfea55 100644
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
> @@ -400,6 +401,33 @@ static void netdev_trig_work(struct work_struct *work)
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
> +	if (!of_property_read_string(np, "device-name", &device_name))
> +		netdev_trig_set_device(trigger_data, device_name,
> +				       strlen(device_name));
> +
> +	set_baseline_state(trigger_data);
> +
> +	of_node_put(np);
> +}
> +
>   static int netdev_trig_activate(struct led_classdev *led_cdev)
>   {
>   	struct led_netdev_data *trigger_data;
> @@ -423,6 +451,8 @@ static int netdev_trig_activate(struct led_classdev *led_cdev)
>   	trigger_data->mode = 0;
>   	atomic_set(&trigger_data->interval, msecs_to_jiffies(50));
>   	trigger_data->last_activity = 0;
> +	if (led_cdev->flags & LED_INIT_DEFAULT_TRIGGER)
> +		netdev_trig_of_init(led_cdev, trigger_data);

We don't necessarily want OF settings to be used for initialization on
each LED trigger activation for the LED class device, but only on the
first one. That's why the triggers using this flags clean it here:

led_cdev->flags &= ~LED_INIT_DEFAULT_TRIGGER;

>   
>   	led_set_trigger_data(led_cdev, trigger_data);
>   
> 

-- 
Best regards,
Jacek Anaszewski
