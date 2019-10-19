Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16388CA9EAC
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 09:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC6572082F
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 09:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfJSJon convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 05:44:43 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:40889 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbfJSJom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 05:44:42 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 4C90DE0009;
        Sat, 19 Oct 2019 09:44:36 +0000 (UTC)
Date:   Sat, 19 Oct 2019 11:44:34 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH 11/46] ARM: pxa: cmx270: use platform device for nand
Message-ID: <20191019114417.5268f7e4@xps13>
In-Reply-To: <20191018154201.1276638-11-arnd@arndb.de>
References: <20191018154052.1276506-1-arnd@arndb.de>
        <20191018154201.1276638-11-arnd@arndb.de>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Arnd Bergmann <arnd@arndb.de> wrote on Fri, 18 Oct 2019 17:41:26 +0200:

> The driver traditionally hardcodes the MMIO register address and
> the GPIO numbers from data defined in platform header files.
> 
> To make it indepdendent of that, use a memory resource for the
> registers, and a gpio lookup table to replace the gpio numbers.

Looks good to me besides the typo s/indepdendent/independent/.

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

> 
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Brian Norris <computersforpeace@gmail.com>
> Cc: Marek Vasut <marek.vasut@gmail.com>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: linux-mtd@lists.infradead.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-pxa/cm-x270.c        | 25 +++++++++
>  drivers/mtd/nand/raw/cmx270_nand.c | 88 +++++++++++-------------------
>  2 files changed, 56 insertions(+), 57 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/cm-x270.c b/arch/arm/mach-pxa/cm-x270.c
> index 9baad11314f2..6d80400d8887 100644
> --- a/arch/arm/mach-pxa/cm-x270.c
> +++ b/arch/arm/mach-pxa/cm-x270.c
> @@ -40,6 +40,10 @@
>  #define GPIO19_WLAN_STRAP	(19)
>  #define GPIO102_WLAN_RST	(102)
>  
> +/* NAND GPIOS */
> +#define GPIO_NAND_CS		(11)
> +#define GPIO_NAND_RB		(89)
> +
>  static unsigned long cmx270_pin_config[] = {
>  	/* AC'97 */
>  	GPIO28_AC97_BITCLK,
> @@ -403,6 +407,26 @@ static void __init cmx270_init_spi(void)
>  static inline void cmx270_init_spi(void) {}
>  #endif
>  
> +static struct gpiod_lookup_table cmx270_nand_gpio_table = {
> +	.dev_id = "cmx270-nand",
> +	.table = {
> +		GPIO_LOOKUP("gpio-pxa", GPIO_NAND_CS, "cs", GPIO_ACTIVE_HIGH),
> +		GPIO_LOOKUP("gpio-pxa", GPIO_NAND_RB, "rb", GPIO_ACTIVE_HIGH),
> +		{ },
> +	},
> +};
> +
> +static struct resource cmx270_nand_resources[] __initdata = {
> +	DEFINE_RES_MEM(PXA_CS1_PHYS, 12),
> +};
> +
> +static void __init cmx270_init_nand(void)
> +{
> +	platform_device_register_simple("cmx270-nand", -1,
> +					cmx270_nand_resources, 1);
> +	gpiod_add_lookup_table(&cmx270_nand_gpio_table);
> +}
> +
>  void __init cmx270_init(void)
>  {
>  	pxa2xx_mfp_config(ARRAY_AND_SIZE(cmx270_pin_config));
> @@ -416,4 +440,5 @@ void __init cmx270_init(void)
>  	cmx270_init_ohci();
>  	cmx270_init_2700G();
>  	cmx270_init_spi();
> +	cmx270_init_nand();
>  }
> diff --git a/drivers/mtd/nand/raw/cmx270_nand.c b/drivers/mtd/nand/raw/cmx270_nand.c
> index 7af3d0bdcdb8..31cb20858c46 100644
> --- a/drivers/mtd/nand/raw/cmx270_nand.c
> +++ b/drivers/mtd/nand/raw/cmx270_nand.c
> @@ -15,18 +15,17 @@
>  #include <linux/mtd/rawnand.h>
>  #include <linux/mtd/partitions.h>
>  #include <linux/slab.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/module.h>
>  #include <linux/soc/pxa/cpu.h>
> +#include <linux/platform_device.h>
>  
>  #include <asm/io.h>
>  #include <asm/irq.h>
>  #include <asm/mach-types.h>
>  
> -#include <mach/addr-map.h>
> -
> -#define GPIO_NAND_CS	(11)
> -#define GPIO_NAND_RB	(89)
> +static struct gpio_desc *gpiod_nand_cs;
> +static struct gpio_desc *gpiod_nand_rb;
>  
>  /* MTD structure for CM-X270 board */
>  static struct mtd_info *cmx270_nand_mtd;
> @@ -70,14 +69,14 @@ static void cmx270_read_buf(struct nand_chip *this, u_char *buf, int len)
>  
>  static inline void nand_cs_on(void)
>  {
> -	gpio_set_value(GPIO_NAND_CS, 0);
> +	gpiod_set_value(gpiod_nand_cs, 0);
>  }
>  
>  static void nand_cs_off(void)
>  {
>  	dsb();
>  
> -	gpio_set_value(GPIO_NAND_CS, 1);
> +	gpiod_set_value(gpiod_nand_cs, 1);
>  }
>  
>  /*
> @@ -120,48 +119,41 @@ static int cmx270_device_ready(struct nand_chip *this)
>  {
>  	dsb();
>  
> -	return (gpio_get_value(GPIO_NAND_RB));
> +	return (gpiod_get_value(gpiod_nand_rb));
>  }
>  
>  /*
>   * Main initialization routine
>   */
> -static int __init cmx270_init(void)
> +static int cmx270_probe(struct platform_device *pdev)
>  {
>  	struct nand_chip *this;
> +	struct device *dev = &pdev->dev;
>  	int ret;
>  
> -	if (!(machine_is_armcore() && cpu_is_pxa27x()))
> -		return -ENODEV;
> -
> -	ret = gpio_request(GPIO_NAND_CS, "NAND CS");
> +	gpiod_nand_cs = devm_gpiod_get(dev, "cs", GPIOD_OUT_HIGH);
> +	ret = PTR_ERR_OR_ZERO(gpiod_nand_cs);
>  	if (ret) {
>  		pr_warn("CM-X270: failed to request NAND CS gpio\n");
>  		return ret;
>  	}
>  
> -	gpio_direction_output(GPIO_NAND_CS, 1);
> -
> -	ret = gpio_request(GPIO_NAND_RB, "NAND R/B");
> +	gpiod_nand_rb = devm_gpiod_get(dev, "rb", GPIOD_IN);
> +	ret = PTR_ERR_OR_ZERO(gpiod_nand_rb);
>  	if (ret) {
>  		pr_warn("CM-X270: failed to request NAND R/B gpio\n");
> -		goto err_gpio_request;
> +		return ret;
>  	}
>  
> -	gpio_direction_input(GPIO_NAND_RB);
> -
>  	/* Allocate memory for MTD device structure and private data */
> -	this = kzalloc(sizeof(struct nand_chip), GFP_KERNEL);
> -	if (!this) {
> -		ret = -ENOMEM;
> -		goto err_kzalloc;
> -	}
> +	this = devm_kzalloc(dev, sizeof(struct nand_chip), GFP_KERNEL);
> +	if (!this)
> +		return -ENOMEM;
>  
> -	cmx270_nand_io = ioremap(PXA_CS1_PHYS, 12);
> +	cmx270_nand_io = devm_platform_ioremap_resource(pdev, 0);
>  	if (!cmx270_nand_io) {
>  		pr_debug("Unable to ioremap NAND device\n");
> -		ret = -EINVAL;
> -		goto err_ioremap;
> +		return -EINVAL;
>  	}
>  
>  	cmx270_nand_mtd = nand_to_mtd(this);
> @@ -189,48 +181,30 @@ static int __init cmx270_init(void)
>  	ret = nand_scan(this, 1);
>  	if (ret) {
>  		pr_notice("No NAND device\n");
> -		goto err_scan;
> +		return ret;
>  	}
>  
>  	/* Register the partitions */
> -	ret = mtd_device_register(cmx270_nand_mtd, partition_info,
> -				  NUM_PARTITIONS);
> -	if (ret)
> -		goto err_scan;
> -
> -	/* Return happy */
> -	return 0;
> -
> -err_scan:
> -	iounmap(cmx270_nand_io);
> -err_ioremap:
> -	kfree(this);
> -err_kzalloc:
> -	gpio_free(GPIO_NAND_RB);
> -err_gpio_request:
> -	gpio_free(GPIO_NAND_CS);
> -
> -	return ret;
> -
> +	return mtd_device_register(cmx270_nand_mtd, partition_info,
> +				   NUM_PARTITIONS);
>  }
> -module_init(cmx270_init);
>  
>  /*
>   * Clean up routine
>   */
> -static void __exit cmx270_cleanup(void)
> +static int cmx270_remove(struct platform_device *pdev)
>  {
> -	/* Release resources, unregister device */
>  	nand_release(mtd_to_nand(cmx270_nand_mtd));
>  
> -	gpio_free(GPIO_NAND_RB);
> -	gpio_free(GPIO_NAND_CS);
> -
> -	iounmap(cmx270_nand_io);
> -
> -	kfree(mtd_to_nand(cmx270_nand_mtd));
> +	return 0;
>  }
> -module_exit(cmx270_cleanup);
> +
> +static struct platform_driver cmx270_nand_driver = {
> +	.driver.name = "cmx270-nand",
> +	.probe = cmx270_probe,
> +	.remove = cmx270_remove,
> +};
> +module_platform_driver(cmx270_nand_driver);
>  
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Mike Rapoport <mike@compulab.co.il>");




Thanks,
Miquèl
