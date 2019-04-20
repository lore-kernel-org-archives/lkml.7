Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8520C282E1
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 02:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B11EC21479
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 02:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfDTCgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 22:36:44 -0400
Received: from icp-osb-irony-out8.external.iinet.net.au ([203.59.1.225]:55092
        "EHLO icp-osb-irony-out8.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725858AbfDTCgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 22:36:44 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AHAABKhbpc/zXSMGcNWRkBAQEBAQE?=
 =?us-ascii?q?BAQEBAQEHAQEBAQEBgVQBAQEBAQELAYQkhA6TegaBCAglg12Fa5B+hH0Chjw?=
 =?us-ascii?q?3Bg4BAwEBAQQBAQEBAoZgAQEBAyMEEUEQCw0LAgImAgJXBg0GAgEBgx6BdaV?=
 =?us-ascii?q?TcXwzGoUthGaBCycBgVyKBHiBB4E4DIJfPodOglcEinaHE0+TeQmCCpIkIYw?=
 =?us-ascii?q?IA4kGokmBeDMaCCgIgyeCGheOMWCQcgEB?=
X-IPAS-Result: =?us-ascii?q?A2AHAABKhbpc/zXSMGcNWRkBAQEBAQEBAQEBAQEHAQEBA?=
 =?us-ascii?q?QEBgVQBAQEBAQELAYQkhA6TegaBCAglg12Fa5B+hH0Chjw3Bg4BAwEBAQQBA?=
 =?us-ascii?q?QEBAoZgAQEBAyMEEUEQCw0LAgImAgJXBg0GAgEBgx6BdaVTcXwzGoUthGaBC?=
 =?us-ascii?q?ycBgVyKBHiBB4E4DIJfPodOglcEinaHE0+TeQmCCpIkIYwIA4kGokmBeDMaC?=
 =?us-ascii?q?CgIgyeCGheOMWCQcgEB?=
X-IronPort-AV: E=Sophos;i="5.60,372,1549900800"; 
   d="scan'208";a="213638864"
Received: from unknown (HELO [10.44.0.192]) ([103.48.210.53])
  by icp-osb-irony-out8.iinet.net.au with ESMTP; 20 Apr 2019 10:36:38 +0800
Subject: Re: [PATCH 1/6] ARM: ks8695: watchdog: stop using mach/*.h
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>, arm@kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org
References: <20190415202501.941196-1-arnd@arndb.de>
From:   Greg Ungerer <gerg@uclinux.org>
Message-ID: <f74bf54d-1e5b-5947-9a47-022a39b4d51f@uclinux.org>
Date:   Sat, 20 Apr 2019 12:36:37 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415202501.941196-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 16/4/19 6:24 am, Arnd Bergmann wrote:
> drivers should not rely on machine specific headers but
> get their information from the platform device.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I like the whole series, thanks for doing this.

I haven't looked at the KS8695 in a long time now. I am not sure
that I have any working hardware - but I will have a look around my lab
and see if I can find something.

I'll get back to you with acks and tested bys soon.

Regards
Greg



> ---
>   arch/arm/mach-ks8695/devices.c | 13 ++++++++++++-
>   drivers/watchdog/Kconfig       |  2 +-
>   drivers/watchdog/ks8695_wdt.c  | 30 +++++++++++++++++-------------
>   3 files changed, 30 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm/mach-ks8695/devices.c b/arch/arm/mach-ks8695/devices.c
> index 61cf20beb45f..57766817d86f 100644
> --- a/arch/arm/mach-ks8695/devices.c
> +++ b/arch/arm/mach-ks8695/devices.c
> @@ -169,11 +169,22 @@ void __init ks8696_add_device_hpna(void)
>   /* --------------------------------------------------------------------
>    *  Watchdog
>    * -------------------------------------------------------------------- */
> +#define KS8695_TMR_OFFSET      (0xF0000 + 0xE400)
> +#define KS8695_TMR_PA          (KS8695_IO_PA + KS8695_TMR_OFFSET)
> +static struct resource ks8695_wdt_resources[] = {
> +	[0] = {
> +		.name	= "tmr",
> +		.start	= KS8695_TMR_PA,
> +		.end	= KS8695_TMR_PA + 0xf,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +};
>   
>   static struct platform_device ks8695_wdt_device = {
>   	.name		= "ks8695_wdt",
>   	.id		= -1,
> -	.num_resources	= 0,
> +	.resource	= ks8695_wdt_resources,
> +	.num_resources	= ARRAY_SIZE(ks8695_wdt_resources),
>   };
>   
>   static void __init ks8695_add_device_watchdog(void)
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 242eea859637..046e01daef57 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -397,7 +397,7 @@ config IXP4XX_WATCHDOG
>   
>   config KS8695_WATCHDOG
>   	tristate "KS8695 watchdog"
> -	depends on ARCH_KS8695
> +	depends on ARCH_KS8695 || COMPILE_TEST
>   	help
>   	  Watchdog timer embedded into KS8695 processor. This will reboot your
>   	  system when the timeout is reached.
> diff --git a/drivers/watchdog/ks8695_wdt.c b/drivers/watchdog/ks8695_wdt.c
> index 1e41818a44bc..87c542c2f912 100644
> --- a/drivers/watchdog/ks8695_wdt.c
> +++ b/drivers/watchdog/ks8695_wdt.c
> @@ -23,10 +23,8 @@
>   #include <linux/watchdog.h>
>   #include <linux/io.h>
>   #include <linux/uaccess.h>
> -#include <mach/hardware.h>
>   
> -#define KS8695_TMR_OFFSET	(0xF0000 + 0xE400)
> -#define KS8695_TMR_VA		(KS8695_IO_VA + KS8695_TMR_OFFSET)
> +#define KS8695_CLOCK_RATE  25000000
>   
>   /*
>    * Timer registers
> @@ -57,6 +55,7 @@ MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
>   
>   static unsigned long ks8695wdt_busy;
>   static DEFINE_SPINLOCK(ks8695_lock);
> +static void __iomem *tmr_reg;
>   
>   /* ......................................................................... */
>   
> @@ -69,8 +68,8 @@ static inline void ks8695_wdt_stop(void)
>   
>   	spin_lock(&ks8695_lock);
>   	/* disable timer0 */
> -	tmcon = __raw_readl(KS8695_TMR_VA + KS8695_TMCON);
> -	__raw_writel(tmcon & ~TMCON_T0EN, KS8695_TMR_VA + KS8695_TMCON);
> +	tmcon = __raw_readl(tmr_reg + KS8695_TMCON);
> +	__raw_writel(tmcon & ~TMCON_T0EN, tmr_reg + KS8695_TMCON);
>   	spin_unlock(&ks8695_lock);
>   }
>   
> @@ -84,15 +83,15 @@ static inline void ks8695_wdt_start(void)
>   
>   	spin_lock(&ks8695_lock);
>   	/* disable timer0 */
> -	tmcon = __raw_readl(KS8695_TMR_VA + KS8695_TMCON);
> -	__raw_writel(tmcon & ~TMCON_T0EN, KS8695_TMR_VA + KS8695_TMCON);
> +	tmcon = __raw_readl(tmr_reg + KS8695_TMCON);
> +	__raw_writel(tmcon & ~TMCON_T0EN, tmr_reg + KS8695_TMCON);
>   
>   	/* program timer0 */
> -	__raw_writel(tval | T0TC_WATCHDOG, KS8695_TMR_VA + KS8695_T0TC);
> +	__raw_writel(tval | T0TC_WATCHDOG, tmr_reg + KS8695_T0TC);
>   
>   	/* re-enable timer0 */
> -	tmcon = __raw_readl(KS8695_TMR_VA + KS8695_TMCON);
> -	__raw_writel(tmcon | TMCON_T0EN, KS8695_TMR_VA + KS8695_TMCON);
> +	tmcon = __raw_readl(tmr_reg + KS8695_TMCON);
> +	__raw_writel(tmcon | TMCON_T0EN, tmr_reg + KS8695_TMCON);
>   	spin_unlock(&ks8695_lock);
>   }
>   
> @@ -105,9 +104,9 @@ static inline void ks8695_wdt_reload(void)
>   
>   	spin_lock(&ks8695_lock);
>   	/* disable, then re-enable timer0 */
> -	tmcon = __raw_readl(KS8695_TMR_VA + KS8695_TMCON);
> -	__raw_writel(tmcon & ~TMCON_T0EN, KS8695_TMR_VA + KS8695_TMCON);
> -	__raw_writel(tmcon | TMCON_T0EN, KS8695_TMR_VA + KS8695_TMCON);
> +	tmcon = __raw_readl(tmr_reg + KS8695_TMCON);
> +	__raw_writel(tmcon & ~TMCON_T0EN, tmr_reg + KS8695_TMCON);
> +	__raw_writel(tmcon | TMCON_T0EN, tmr_reg + KS8695_TMCON);
>   	spin_unlock(&ks8695_lock);
>   }
>   
> @@ -238,6 +237,11 @@ static struct miscdevice ks8695wdt_miscdev = {
>   static int ks8695wdt_probe(struct platform_device *pdev)
>   {
>   	int res;
> +	struct resource *resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +
> +	tmr_reg = devm_ioremap_resource(&pdev->dev, resource);
> +	if (!tmr_reg)
> +		return -ENXIO;
>   
>   	if (ks8695wdt_miscdev.parent)
>   		return -EBUSY;
> 
