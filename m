Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82AD1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 09:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5777E2085A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 09:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfCNJhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 05:37:03 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59811 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfCNJhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 05:37:02 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1h4MnL-0003zx-NK; Thu, 14 Mar 2019 10:36:59 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1h4MnL-0001ca-Ea; Thu, 14 Mar 2019 10:36:59 +0100
Date:   Thu, 14 Mar 2019 10:36:59 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-can@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH 4/4] leds: netdev trigger: allow setting initial values
 in device tree
Message-ID: <20190314093659.srtlgqljcasbawva@pengutronix.de>
References: <20190311144227.GA4404@amd>
 <20190313202615.22883-1-linux@rasmusvillemoes.dk>
 <20190313202615.22883-5-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190313202615.22883-5-linux@rasmusvillemoes.dk>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Mar 13, 2019 at 09:26:15PM +0100, Rasmus Villemoes wrote:
> It can be quite convenient to initialize a netdev-triggered LED with a
> device name and setting the rx,tx,link properties from device tree,
> instead of having to do that in an init script in userspace.

Well, you'd do this in an udev rule instead of an init script.

> My main motivation for this is to be able to switch away from the
> deprecated CONFIG_CAN_LEDS, so add an example based on that and add a
> pointer in the net/can/Kconfig file.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  .../devicetree/bindings/leds/common.txt       | 17 ++++++++++
>  drivers/leds/trigger/ledtrig-netdev.c         | 31 +++++++++++++++++++
>  drivers/net/can/Kconfig                       |  3 +-
>  3 files changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/leds/common.txt b/Documentation/devicetree/bindings/leds/common.txt
> index 7cb88460a47c..4f3a97e73417 100644
> --- a/Documentation/devicetree/bindings/leds/common.txt
> +++ b/Documentation/devicetree/bindings/leds/common.txt
> @@ -43,6 +43,23 @@ Optional properties for child nodes:
>                  Documentation/ABI/testing/sysfs-class-led-trigger-netdev)
>                  to reflect the state and activity of a net device.
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

Maybe make this:

	device = <&can0>;

?

> +                };
> +
> +                can be used to replace 'linux,default-trigger =
> +                "can0-rxtx"' that relies on the deprecated
> +                CONFIG_CAN_LEDS.

Mentioning "CONFIG_CAN_LEDS" is wrong for a binding document that is
supposed to be independent from the kernel.

>  - led-pattern : Array of integers with default pattern for certain triggers.
>                  Each trigger may parse this property differently:
>                  - one-shot : two numbers specifying delay on and delay off (in ms),
> diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
> index 55153a7e8433..1f7c86df1e91 100644
> --- a/drivers/leds/trigger/ledtrig-netdev.c
> +++ b/drivers/leds/trigger/ledtrig-netdev.c
> @@ -20,6 +20,7 @@
>  #include <linux/list.h>
>  #include <linux/module.h>
>  #include <linux/netdevice.h>
> +#include <linux/of.h>
>  #include <linux/spinlock.h>
>  #include <linux/timer.h>
>  #include "../leds.h"
> @@ -395,6 +396,35 @@ static void netdev_trig_work(struct work_struct *work)
>  			(atomic_read(&trigger_data->interval)*2));
>  }
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

if set_device contained the length check you'd have it in only one
place.

> +	}
> +	set_baseline_state(trigger_data);
> +
> +	of_node_put(np);
> +}
> +
>  static int netdev_trig_activate(struct led_classdev *led_cdev)
>  {
>  	struct led_netdev_data *trigger_data;
> @@ -418,6 +448,7 @@ static int netdev_trig_activate(struct led_classdev *led_cdev)
>  	trigger_data->mode = 0;
>  	atomic_set(&trigger_data->interval, msecs_to_jiffies(50));
>  	trigger_data->last_activity = 0;
> +	netdev_trig_of_init(led_cdev, trigger_data);
>  
>  	led_set_trigger_data(led_cdev, trigger_data);
>  
> diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
> index e0f0ad7a550a..91703a96b636 100644
> --- a/drivers/net/can/Kconfig
> +++ b/drivers/net/can/Kconfig
> @@ -77,7 +77,8 @@ config CAN_LEDS
>  	# everything that this driver is doing. This is marked as broken
>  	# because it uses stuff that is intended to be changed or removed.
>  	# Please consider switching to the netdev trigger and confirm it
> -	# fulfills your needs instead of fixing this driver.
> +	# fulfills your needs instead of fixing this driver. See e.g.
> +	# Documentation/devicetree/bindings/leds/common.txt
>  	depends on BROKEN
>  	select LEDS_TRIGGERS
>  	---help---

This hunk can better live in the patch adding to
Documentation/devicetree/bindings/leds/common.txt or a separate patch.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
