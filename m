Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED11C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 12:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AB16218F0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 12:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387617AbfGYMKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 08:10:32 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51555 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfGYMKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 08:10:32 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hqcZp-00047K-JK; Thu, 25 Jul 2019 14:10:29 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hqcZn-0006oY-6i; Thu, 25 Jul 2019 14:10:27 +0200
Date:   Thu, 25 Jul 2019 14:10:27 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Stefan Roese <sr@denx.de>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yegor Yefremov <yegorslists@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: Re: [PATCH 1/2 v9] serial: mctrl_gpio: Check if GPIO property
 exisits before requesting it
Message-ID: <20190725121027.xc52wshky74wgebt@pengutronix.de>
References: <20190620062420.11650-1-sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190620062420.11650-1-sr@denx.de>
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

On Thu, Jun 20, 2019 at 08:24:19AM +0200, Stefan Roese wrote:
> This patch adds a check for the GPIOs property existence, before the
> GPIO is requested. This fixes an issue seen when the 8250 mctrl_gpio
> support is added (2nd patch in this patch series) on x86 platforms using
> ACPI.
> 
> Here Mika's comments from 2016-08-09:
> 
> "
> I noticed that with v4.8-rc1 serial console of some of our Broxton
> systems does not work properly anymore. I'm able to see output but input
> does not work.
> 
> I bisected it down to commit 4ef03d328769eddbfeca1f1c958fdb181a69c341
> ("tty/serial/8250: use mctrl_gpio helpers").
> 
> The reason why it fails is that in ACPI we do not have names for GPIOs
> (except when _DSD is used) so we use the "idx" to index into _CRS GPIO
> resources. Now mctrl_gpio_init_noauto() goes through a list of GPIOs
> calling devm_gpiod_get_index_optional() passing "idx" of 0 for each. The
> UART device in Broxton has following (simplified) ACPI description:
> 
>     Device (URT4)
>     {
>         ...
>         Name (_CRS, ResourceTemplate () {
>             GpioIo (Exclusive, PullDefault, 0x0000, 0x0000, IoRestrictionOutputOnly,
>                     "\\_SB.GPO0", 0x00, ResourceConsumer)
>             {
>                 0x003A
>             }
>             GpioIo (Exclusive, PullDefault, 0x0000, 0x0000, IoRestrictionOutputOnly,
>                     "\\_SB.GPO0", 0x00, ResourceConsumer)
>             {
>                 0x003D
>             }
>         })
> 
> In this case it finds the first GPIO (0x003A which happens to be RX pin
> for that UART), turns it into GPIO which then breaks input for the UART
> device. This also breaks systems with bluetooth connected to UART (those
> typically have some GPIOs in their _CRS).
> 
> Any ideas how to fix this?
> 
> We cannot just drop the _CRS index lookup fallback because that would
> break many existing machines out there so maybe we can limit this to
> only DT enabled machines. Or alternatively probe if the property first
> exists before trying to acquire the GPIOs (using
> device_property_present()).
> "
> 
> This patch implements the fix suggested by Mika in his statement above.
> 
> Signed-off-by: Stefan Roese <sr@denx.de>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Tested-by: Yegor Yefremov <yegorslists@googlemail.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Yegor Yefremov <yegorslists@googlemail.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Giulio Benetti <giulio.benetti@micronovasrl.com>
> ---
> v9:
> - Rebased on top of "tty-next", patch 2/3 dropped as its already applied
> 
> v8:
> - Rebased on top of "tty-next"
> 
> v7:
> - Include <linux/property.h> to fix compile breakage on OMAP
> 
> v6:
> - No change
> 
> v5:
> - Simplified the code a bit (Andy)
> - Added gpio_str == NULL handling (Andy)
> 
> v4:
> - Add missing free() calls (Johan)
> - Added Mika's reviewed by tag
> - Added Johan to Cc
> 
> v3:
> - No change
> 
> v2:
> - Include the problem description and analysis from Mika into the commit
>   text, as suggested by Greg.
> 
>  drivers/tty/serial/serial_mctrl_gpio.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/serial/serial_mctrl_gpio.c
> index 39ed56214cd3..2b400189be91 100644
> --- a/drivers/tty/serial/serial_mctrl_gpio.c
> +++ b/drivers/tty/serial/serial_mctrl_gpio.c
> @@ -12,6 +12,7 @@
>  #include <linux/termios.h>
>  #include <linux/serial_core.h>
>  #include <linux/module.h>
> +#include <linux/property.h>
>  
>  #include "serial_mctrl_gpio.h"
>  
> @@ -116,6 +117,19 @@ struct mctrl_gpios *mctrl_gpio_init_noauto(struct device *dev, unsigned int idx)
>  
>  	for (i = 0; i < UART_GPIO_MAX; i++) {
>  		enum gpiod_flags flags;
> +		char *gpio_str;
> +		bool present;
> +
> +		/* Check if GPIO property exists and continue if not */
> +		gpio_str = kasprintf(GFP_KERNEL, "%s-gpios",
> +				     mctrl_gpios_desc[i].name);
> +		if (!gpio_str)
> +			continue;

Is it a good idea to handle a memory allocation problem with a continue?

> +		present = device_property_present(dev, gpio_str);
> +		kfree(gpio_str);
> +		if (!present)
> +			continue;
>  

Assuming this fixes the situation on x86 this means that there
device_property_present(...) returns false and
devm_gpiod_get_index_optional returns an error code.

I wonder what the problem is here. Is CONFIG_GPIOLIB on in the failing
situation?

I assume this will end in the usual discussion if gpiod_get_*_optional
should return an error code if GPIOLIB is off.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
