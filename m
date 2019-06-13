Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43228C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 256B72063F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404578AbfFMRIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 13:08:07 -0400
Received: from mga03.intel.com ([134.134.136.65]:41569 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729811AbfFMRIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 13:08:06 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jun 2019 10:08:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,369,1557212400"; 
   d="scan'208";a="184684275"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by fmsmga002.fm.intel.com with ESMTP; 13 Jun 2019 10:08:03 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hbTCk-0006KB-GS; Thu, 13 Jun 2019 20:08:02 +0300
Date:   Thu, 13 Jun 2019 20:08:02 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Stefan Roese <sr@denx.de>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yegor Yefremov <yegorslists@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: Re: [PATCH 1/3 v6] serial: mctrl_gpio: Check if GPIO property
 exisits before requesting it
Message-ID: <20190613170802.GE9224@smile.fi.intel.com>
References: <20190613154542.32438-1-sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613154542.32438-1-sr@denx.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 05:45:40PM +0200, Stefan Roese wrote:
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

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Stefan Roese <sr@denx.de>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Yegor Yefremov <yegorslists@googlemail.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Giulio Benetti <giulio.benetti@micronovasrl.com>
> ---
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
>  drivers/tty/serial/serial_mctrl_gpio.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/serial/serial_mctrl_gpio.c
> index 39ed56214cd3..65348887a749 100644
> --- a/drivers/tty/serial/serial_mctrl_gpio.c
> +++ b/drivers/tty/serial/serial_mctrl_gpio.c
> @@ -116,6 +116,19 @@ struct mctrl_gpios *mctrl_gpio_init_noauto(struct device *dev, unsigned int idx)
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
> +
> +		present = device_property_present(dev, gpio_str);
> +		kfree(gpio_str);
> +		if (!present)
> +			continue;
>  
>  		if (mctrl_gpios_desc[i].dir_out)
>  			flags = GPIOD_OUT_LOW;
> -- 
> 2.22.0
> 

-- 
With Best Regards,
Andy Shevchenko


