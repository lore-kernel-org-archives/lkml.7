Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12252C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 22:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E51C92662E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 22:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfFCWNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 18:13:51 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36830 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfFCWNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 18:13:51 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 5CB1B261114
Message-ID: <57649a3c8809b3dd0abbd2955aea46f06f881d96.camel@collabora.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_lpc: Choose Microchip EC at
 runtime
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     Nick Crews <ncrews@chromium.org>,
        Guenter Roeck <groeck@chromium.org>, kernel@collabora.com,
        Duncan Laurie <dlaurie@google.com>,
        Benson Leung <bleung@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Mon, 03 Jun 2019 17:56:18 -0300
In-Reply-To: <20190530171120.31590-1-enric.balletbo@collabora.com>
References: <20190530171120.31590-1-enric.balletbo@collabora.com>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

On Thu, 2019-05-30 at 19:11 +0200, Enric Balletbo i Serra wrote:
> On many boards, communication between the kernel and the Embedded
> Controller happens over an LPC bus. In these cases, the kernel config
> CONFIG_CROS_EC_LPC is enabled. Some of these LPC boards contain a
> Microchip Embedded Controller (MEC) that is different from the regular
> EC. On these devices, the same LPC bus is used, but the protocol is
> a little different. In these cases, the CONFIG_CROS_EC_LPC_MEC kernel
> config is enabled. Currently, the kernel decides at compile-time whether
> or not to use the MEC variant, and, when that kernel option is selected
> it breaks the other boards. We would like a kind of runtime detection to
> avoid this.
> 
> This patch adds that detection mechanism by probing the protocol at
> runtime, first we assume that a MEC variant is connected, and if the
> protocol fails it fallbacks to the regular EC. This adds a bit of
> overload because we try to read twice on those LPC boards that doesn't
> contain a MEC variant, but is a better solution than having to select the
> EC variant at compile-time.
> 
> While here also fix the alignment in Kconfig file for this config option
> replacing the spaces by tabs.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> Hi,
> 
> This is the first attempt to solve the issue to be able to select at
> runtime the CrOS MEC variant. My first thought was check for a device ID,
> the MEC1322 has a register that contains the device ID, however I am not
> sure if we can read that register from the host without modifying the
> firmware. Also, I am not sure if the MEC1322 is the only device used
> that supports that LPC protocol variant, so I ended with a more easy
> solution, check if the protocol fails or not. Some background on this
> issue can be found [1] and [2]
> 
> The patch has been tested on:
>  - Acer Chromebook R11 (Cyan - MEC variant)
>  - Pixel Chromebook 2015 (Samus - non-MEC variant)
>  - Dell Chromebook 11 (Wolf - non-MEC variant)
>  - Toshiba Chromebook (Leon - non-MEC variant)
> 
> Nick, could you test the patch for Wilco?
> 
> Best regards,
>  Enric
> 
> [1] https://bugs.chromium.org/p/chromium/issues/detail?id=932626
> [2] https://chromium-review.googlesource.com/c/chromiumos/overlays/chromiumos-overlay/+/1474254
> 
>  drivers/platform/chrome/Kconfig           | 29 +++++-----------
>  drivers/platform/chrome/Makefile          |  3 +-
>  drivers/platform/chrome/cros_ec_lpc.c     | 15 ++++++--
>  drivers/platform/chrome/cros_ec_lpc_reg.c | 42 +++++++++--------------
>  drivers/platform/chrome/cros_ec_lpc_reg.h |  3 ++
>  drivers/platform/chrome/wilco_ec/Kconfig  |  2 +-
>  6 files changed, 43 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
> index 2826f7136f65..453e69733842 100644
> --- a/drivers/platform/chrome/Kconfig
> +++ b/drivers/platform/chrome/Kconfig
> @@ -83,28 +83,17 @@ config CROS_EC_SPI
>  	  'pre-amble' bytes before the response actually starts.
>  
>  config CROS_EC_LPC
> -        tristate "ChromeOS Embedded Controller (LPC)"
> -        depends on MFD_CROS_EC && ACPI && (X86 || COMPILE_TEST)
> -        help
> -          If you say Y here, you get support for talking to the ChromeOS EC
> -          over an LPC bus. This uses a simple byte-level protocol with a
> -          checksum. This is used for userspace access only. The kernel
> -          typically has its own communication methods.
> -
> -          To compile this driver as a module, choose M here: the
> -          module will be called cros_ec_lpc.
> -
> -config CROS_EC_LPC_MEC
> -	bool "ChromeOS Embedded Controller LPC Microchip EC (MEC) variant"
> -	depends on CROS_EC_LPC
> -	default n
> +	tristate "ChromeOS Embedded Controller (LPC)"
> +	depends on MFD_CROS_EC && ACPI && (X86 || COMPILE_TEST)
>  	help
> -	  If you say Y here, a variant LPC protocol for the Microchip EC
> -	  will be used. Note that this variant is not backward compatible
> -	  with non-Microchip ECs.
> +	  If you say Y here, you get support for talking to the ChromeOS EC
> +	  over an LPC bus, including the LPC Microchip EC (MEC) variant.
> +	  This uses a simple byte-level protocol with a checksum. This is
> +	  used for userspace access only. The kernel typically has its own
> +	  communication methods.
>  
> -	  If you have a ChromeOS Embedded Controller Microchip EC variant
> -	  choose Y here.
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called cros_ec_lpcs.
>  
>  config CROS_EC_PROTO
>          bool
> diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
> index 1b2f1dcfcd5c..d6416411888f 100644
> --- a/drivers/platform/chrome/Makefile
> +++ b/drivers/platform/chrome/Makefile
> @@ -9,8 +9,7 @@ obj-$(CONFIG_CHROMEOS_TBMC)		+= chromeos_tbmc.o
>  obj-$(CONFIG_CROS_EC_I2C)		+= cros_ec_i2c.o
>  obj-$(CONFIG_CROS_EC_RPMSG)		+= cros_ec_rpmsg.o
>  obj-$(CONFIG_CROS_EC_SPI)		+= cros_ec_spi.o
> -cros_ec_lpcs-objs			:= cros_ec_lpc.o cros_ec_lpc_reg.o
> -cros_ec_lpcs-$(CONFIG_CROS_EC_LPC_MEC)	+= cros_ec_lpc_mec.o
> +cros_ec_lpcs-objs			:= cros_ec_lpc.o cros_ec_lpc_reg.o cros_ec_lpc_mec.o
>  obj-$(CONFIG_CROS_EC_LPC)		+= cros_ec_lpcs.o
>  obj-$(CONFIG_CROS_EC_PROTO)		+= cros_ec_proto.o cros_ec_trace.o
>  obj-$(CONFIG_CROS_KBD_LED_BACKLIGHT)	+= cros_kbd_led_backlight.o
> diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
> index c9c240fbe7c6..2cbc71c8edba 100644
> --- a/drivers/platform/chrome/cros_ec_lpc.c
> +++ b/drivers/platform/chrome/cros_ec_lpc.c
> @@ -248,10 +248,21 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
>  		return -EBUSY;
>  	}
>  
> +	/*
> +	 * Read the mapped ID twice, the first one is assuming the
> +	 * EC is a Microchip Embedded Controller (MEC) variant, if the
> +	 * protocol fails, fallback to the non MEC variant and try to
> +	 * read again the ID.
> +	 */
>  	cros_ec_lpc_read_bytes(EC_LPC_ADDR_MEMMAP + EC_MEMMAP_ID, 2, buf);
>  	if (buf[0] != 'E' || buf[1] != 'C') {
> -		dev_err(dev, "EC ID not detected\n");
> -		return -ENODEV;
> +		cros_ec_is_microchip = false;
> +		cros_ec_lpc_read_bytes(EC_LPC_ADDR_MEMMAP + EC_MEMMAP_ID,
> +				       2, buf);
> +		if (buf[0] != 'E' || buf[1] != 'C') {
> +			dev_err(dev, "EC ID not detected\n");
> +			return -ENODEV;
> +		}
>  	}
>  
>  	if (!devm_request_region(dev, EC_HOST_CMD_REGION0,
> diff --git a/drivers/platform/chrome/cros_ec_lpc_reg.c b/drivers/platform/chrome/cros_ec_lpc_reg.c
> index 0f5cd0ac8b49..953580ac207e 100644
> --- a/drivers/platform/chrome/cros_ec_lpc_reg.c
> +++ b/drivers/platform/chrome/cros_ec_lpc_reg.c
> @@ -9,6 +9,12 @@
>  
>  #include "cros_ec_lpc_mec.h"
>  
> +/*
> + * Assume that the Embedded Controller is the Microhcip variant, we will
> + * mark as false if that's not the case.
> + */
> +bool cros_ec_is_microchip = true;
> +

I'm reluctant to add global state to the kernel, specially when it's something
that's not per-kernel but rather a property of the cros ec device.

Maybe this can be represented with a priv data inside a union:

struct cros_ec_lpc_hw {
        u8 (*read_bytes)(unsigned int offset, unsigned int length, u8 *dest);
        ...
};

struct cros_ec_device {
...
        union {
                struct cros_ec_lpc_hw lpc_priv;
        }
};

You can then detect the protocol at probe time, and assign the I/O
hooks (read_bytes, etc).

Should work the same way, but with a different design.

Thanks,
Eze

