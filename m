Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0CEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 110772082F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="CesW61Gs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbfCUNdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 09:33:49 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41164 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727857AbfCUNds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 09:33:48 -0400
Received: from nazgul.tnic (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 69AC81EC02AE;
        Thu, 21 Mar 2019 14:33:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553175226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=wSX/OG/9bBzQkBxrQChjO5ACCWfsqwqKYEqfl3wrWq8=;
        b=CesW61GsSxGgb28plWXH1wuQD8dlYzvIwYd1K98W7EV6Ag+jxwW1ASIE72bWGySGeo8fhb
        zDqgmZsK16o1LuMgwflw9e8BTIiB9JEX5Gay3EkKdiC8LzMl0hQvomyua+9GURLgtg2KfM
        VbuBy3XukMN2ATvfdhxrxUEstfdPvZU=
Date:   Thu, 21 Mar 2019 14:33:40 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yash Shah <yash.shah@sifive.com>
Cc:     linux-riscv@lists.infradead.org, linux-edac@vger.kernel.org,
        palmer@sifive.com, paul.walmsley@sifive.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, aou@eecs.berkeley.edu, mchehab@kernel.org,
        devicetree@vger.kernel.org, sachin.ghadi@sifive.com
Subject: Re: [PATCH 2/2] edac: sifive: Add EDAC driver for SiFive FU540-C000
 chip
Message-ID: <20190321133340.GB7047@nazgul.tnic>
References: <1553082728-9232-1-git-send-email-yash.shah@sifive.com>
 <1553082728-9232-3-git-send-email-yash.shah@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1553082728-9232-3-git-send-email-yash.shah@sifive.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 05:22:08PM +0530, Yash Shah wrote:
> This EDAC driver supports:
> - Initial configuration reporting on bootup via debug logs
> - ECC event monitoring and reporting through the EDAC framework
> - ECC event injection
> 
> This driver is partially based on pnd2_edac.c and altera_edac.c
> 
> Initially L2 Cache controller is added as a subcomponent to
> this EDAC driver.
> 
> Signed-off-by: Yash Shah <yash.shah@sifive.com>

...

> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index e286b5b..112d9d1 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -440,6 +440,19 @@ config EDAC_ALTERA_SDMMC
>  	  Support for error detection and correction on the
>  	  Altera SDMMC FIFO Memory for Altera SoCs.
>  
> +config EDAC_SIFIVE
> +	tristate "Sifive ECC"
> +	depends on RISCV
> +	help
> +	  Support for error detection and correction on the SiFive SoCs.
> +
> +config EDAC_SIFIVE_L2

That config item is unused. Drop it.

> +	bool "SiFive L2 Cache ECC"
> +	depends on EDAC_SIFIVE=y
> +	help
> +	  Support for error detection and correction of the L2 cache
> +	  memory on SiFive SoCs.
> +
>  config EDAC_SYNOPSYS
>  	tristate "Synopsys DDR Memory Controller"
>  	depends on ARCH_ZYNQ || ARCH_ZYNQMP

...

> +/*
> + * sifive_edac_l2_int_handler - ISR function for l2 cache controller
> + * @irq:	Irq Number
> + * @device:	Pointer to the edac device controller instance
> + *
> + * This routine is triggered whenever there is ECC error detected
> + *
> + * Return: Always returns IRQ_HANDLED
> + */
> +static irqreturn_t sifive_edac_l2_int_handler(int irq, void *device)
> +{
> +	struct edac_device_ctl_info *dci =
> +					(struct edac_device_ctl_info *)device;

No ugly linebreaks like that - just let it stick out even if it is > 80
cols long.

> +	struct sifive_edac_device_dev *drvdata = dci->pvt_info;
> +	u32 regval, add_h, add_l;
> +
> +	if (irq == drvdata->irq[dir_corr]) {
> +		add_h = readl(drvdata->base + SIFIVE_EDAC_DIRFIX_HIGH);
> +		add_l = readl(drvdata->base + SIFIVE_EDAC_DIRFIX_LOW);
> +		dev_err(dci->dev,
> +			"DirError at address 0x%08X.%08X\n", add_h, add_l);

Same here and below.

> +		regval = readl(drvdata->base + SIFIVE_EDAC_DIRFIX_COUNT);
> +		edac_device_handle_ce(dci, 0, 0, "DirECCFix");
> +	}
> +	if (irq == drvdata->irq[data_corr]) {
> +		add_h = readl(drvdata->base + SIFIVE_EDAC_DATFIX_HIGH);
> +		add_l = readl(drvdata->base + SIFIVE_EDAC_DATFIX_LOW);
> +		dev_err(dci->dev,
> +			"DataError at address 0x%08X.%08X\n", add_h, add_l);
> +		regval = readl(drvdata->base + SIFIVE_EDAC_DATFIX_COUNT);
> +		edac_device_handle_ce(dci, 0, 0, "DatECCFix");
> +	}
> +	if (irq == drvdata->irq[data_uncorr]) {
> +		add_h = readl(drvdata->base + SIFIVE_EDAC_DATFAIL_HIGH);
> +		add_l = readl(drvdata->base + SIFIVE_EDAC_DATFAIL_LOW);
> +		dev_err(dci->dev,
> +			"DataFail at address 0x%08X.%08X\n", add_h, add_l);
> +		regval = readl(drvdata->base + SIFIVE_EDAC_DATFAIL_COUNT);
> +		edac_device_handle_ue(dci, 0, 0, "DatECCFail");
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void sifive_edac_l2_config_read(struct edac_device_ctl_info *dci)
> +{
> +	struct sifive_edac_device_dev *drvdata = dci->pvt_info;
> +	u32 regval, val;
> +
> +	regval = readl(drvdata->base + SIFIVE_EDAC_CONFIG);
> +	val = regval & 0xFF;
> +	dev_info(dci->dev, "No. of Banks in the cache: %d\n", val);
> +	val = (regval & 0xFF00) >> 8;
> +	dev_info(dci->dev, "No. of ways per bank: %d\n", val);
> +	val = (regval & 0xFF0000) >> 16;
> +	dev_info(dci->dev, "Sets per bank: %llu\n", (uint64_t)1 << val);
> +	val = (regval & 0xFF000000) >> 24;
> +	dev_info(dci->dev,
> +		 "Bytes per cache block: %llu\n", (uint64_t)1 << val);
> +}
> +
> +static const struct sifive_edac_device_prv l2ecc_data = {
> +	.setup = sifive_edac_l2_config_read,
> +	.inject_fops = &sifive_edac_l2_fops,
> +	.ecc_irq_handler = sifive_edac_l2_int_handler,
> +};
> +
> +/*
> + * sifive_edac_device_probe()
> + *	This is a generic EDAC device driver that will support
> + *	various SiFive memory devices as well as the memories
> + *	for other peripherals. Module specific initialization is
> + *	done by passing the function index in the device tree.

This comment doesn't have anything to do with that function but rather
belongs at the top of this file.

> + */
> +static int sifive_edac_device_probe(struct platform_device *pdev)
> +{
> +	struct edac_device_ctl_info *dci;
> +	struct sifive_edac_device_dev *drvdata;
> +	int rc, i;
> +	struct resource *res;
> +	void __iomem *baseaddr;
> +	struct device_node *np = pdev->dev.of_node;
> +	char *ecc_name = (char *)np->name;
> +	static int dev_instance;

Please sort function local variables declaration in a reverse christmas
tree order:

	<type_a> longest_variable_name;
	<type_b> shorter_var_name;
	<type_c> even_shorter;
	<type_d> i;

> +
> +	/* Get the data from the platform device */
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	baseaddr = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(baseaddr))
> +		return PTR_ERR(baseaddr);
> +
> +	dci = edac_device_alloc_ctl_info(sizeof(*drvdata), ecc_name,
> +					 1, ecc_name, 1, 1, NULL, 0,
> +					 dev_instance++);
> +	if (IS_ERR(dci))
> +		return PTR_ERR(dci);
> +
> +	drvdata = dci->pvt_info;
> +	drvdata->base = baseaddr;
> +	drvdata->edac_dev_name = ecc_name;
> +	dci->dev = &pdev->dev;
> +	dci->mod_name = "Sifive ECC Manager";
> +	dci->ctl_name = dev_name(&pdev->dev);
> +	dci->dev_name = dev_name(&pdev->dev);
> +
> +	 /* Get driver specific data for this EDAC device */
> +	drvdata->data = of_match_node(sifive_edac_device_of_match, np)->data;
> +
> +	setup_sifive_debug(dci, drvdata->data);
> +
> +	if (drvdata->data->setup)
> +		drvdata->data->setup(dci);
> +
> +	for (i = 0; i < SIFIVE_EDAC_MAX_INTR; i++) {
> +		drvdata->irq[i] = platform_get_irq(pdev, i);
> +		rc = devm_request_irq(&pdev->dev, drvdata->irq[i],
> +				      sifive_edac_l2_int_handler, 0,
> +				      dev_name(&pdev->dev), (void *)dci);
> +		if (rc) {
> +			dev_err(&pdev->dev,
> +				"Could not request IRQ %d\n", drvdata->irq[i]);
> +			goto del_edac_device;
> +		}
> +	}
> +
> +	rc = edac_device_add_device(dci);
> +	if (rc) {
> +		dev_err(&pdev->dev, "failed to register with EDAC core\n");
> +		goto del_edac_device;
> +	}

Call setup_sifive_debug() in the success case here so that you don't
have to teardown below.

> +
> +	return rc;
> +
> +del_edac_device:
> +	teardown_sifive_debug();
> +	edac_device_del_device(&pdev->dev);
> +	edac_device_free_ctl_info(dci);

Those three can be replaced by a call to sifive_edac_device_remove() ?

Btw, you have prefixed your static functions with "sifive_edac_" which
doesn't make much sense and you have long names for no good reason.

> +
> +	return rc;
> +}
> +
> +static int sifive_edac_device_remove(struct platform_device *pdev)
> +{
> +	struct edac_device_ctl_info *dci = platform_get_drvdata(pdev);
> +
> +	teardown_sifive_debug();
> +	edac_device_del_device(&pdev->dev);
> +	edac_device_free_ctl_info(dci);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id sifive_edac_device_of_match[] = {
> +	{ .compatible = "sifive,ccache0", .data = &l2ecc_data },
> +	{ /* end of table */ },
> +};
> +MODULE_DEVICE_TABLE(of, sifive_edac_device_of_match);
> +
> +static struct platform_driver sifive_edac_device_driver = {
> +	.driver = {
> +		 .name = "sifive_edac_device",

"device"? I think it is clear that it is a device and thus kinda
tautological. "sifive_edac" should be enough...

Last but not least, building this driver with the riscv64 cross compilers from
here:

http://cdn.kernel.org/pub/tools/crosstool/files/bin/

fails like below. With the riscv32 compiler it fails the same.

Provided I'm not doing anything wrong, you should not be sending me
half-baked stuff which doesn't even build.

drivers/edac/sifive_edac.c: In function 'sifive_edac_device_probe':
drivers/edac/sifive_edac.c:231:16: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
  drvdata->data = of_match_node(sifive_edac_device_of_match, np)->data;
                ^
In file included from drivers/edac/sifive_edac.c:10:
drivers/edac/sifive_edac.c: At top level:
./include/linux/module.h:130:42: error: redefinition of '__inittest'
  static inline initcall_t __maybe_unused __inittest(void)  \
                                          ^~~~~~~~~~
./include/linux/device.h:1647:1: note: in expansion of macro 'module_init'
 module_init(__driver##_init); \
 ^~~~~~~~~~~
./include/linux/platform_device.h:233:2: note: in expansion of macro 'module_driver'
  module_driver(__platform_driver, platform_driver_register, \
  ^~~~~~~~~~~~~
drivers/edac/sifive_edac.c:293:1: note: in expansion of macro 'module_platform_driver'
 module_platform_driver(sifive_edac_device_driver);
 ^~~~~~~~~~~~~~~~~~~~~~
./include/linux/module.h:130:42: note: previous definition of '__inittest' was here
  static inline initcall_t __maybe_unused __inittest(void)  \
                                          ^~~~~~~~~~
./include/linux/device.h:1647:1: note: in expansion of macro 'module_init'
 module_init(__driver##_init); \
 ^~~~~~~~~~~
./include/linux/platform_device.h:233:2: note: in expansion of macro 'module_driver'
  module_driver(__platform_driver, platform_driver_register, \
  ^~~~~~~~~~~~~
drivers/edac/sifive_edac.c:57:1: note: in expansion of macro 'module_platform_driver'
 module_platform_driver(sifive_edac_driver);
 ^~~~~~~~~~~~~~~~~~~~~~
./include/linux/module.h:132:6: error: redefinition of 'init_module'
  int init_module(void) __copy(initfn) __attribute__((alias(#initfn)));
      ^~~~~~~~~~~
./include/linux/device.h:1647:1: note: in expansion of macro 'module_init'
 module_init(__driver##_init); \
 ^~~~~~~~~~~
./include/linux/platform_device.h:233:2: note: in expansion of macro 'module_driver'
  module_driver(__platform_driver, platform_driver_register, \
  ^~~~~~~~~~~~~
drivers/edac/sifive_edac.c:293:1: note: in expansion of macro 'module_platform_driver'
 module_platform_driver(sifive_edac_device_driver);
 ^~~~~~~~~~~~~~~~~~~~~~
./include/linux/module.h:132:6: note: previous definition of 'init_module' was here
  int init_module(void) __copy(initfn) __attribute__((alias(#initfn)));
      ^~~~~~~~~~~
./include/linux/device.h:1647:1: note: in expansion of macro 'module_init'
 module_init(__driver##_init); \
 ^~~~~~~~~~~
./include/linux/platform_device.h:233:2: note: in expansion of macro 'module_driver'
  module_driver(__platform_driver, platform_driver_register, \
  ^~~~~~~~~~~~~
drivers/edac/sifive_edac.c:57:1: note: in expansion of macro 'module_platform_driver'
 module_platform_driver(sifive_edac_driver);
 ^~~~~~~~~~~~~~~~~~~~~~
./include/linux/module.h:136:42: error: redefinition of '__exittest'
  static inline exitcall_t __maybe_unused __exittest(void)  \
                                          ^~~~~~~~~~
./include/linux/device.h:1652:1: note: in expansion of macro 'module_exit'
 module_exit(__driver##_exit);
 ^~~~~~~~~~~
./include/linux/platform_device.h:233:2: note: in expansion of macro 'module_driver'
  module_driver(__platform_driver, platform_driver_register, \
  ^~~~~~~~~~~~~
drivers/edac/sifive_edac.c:293:1: note: in expansion of macro 'module_platform_driver'
 module_platform_driver(sifive_edac_device_driver);
 ^~~~~~~~~~~~~~~~~~~~~~
./include/linux/module.h:136:42: note: previous definition of '__exittest' was here
  static inline exitcall_t __maybe_unused __exittest(void)  \
                                          ^~~~~~~~~~
./include/linux/device.h:1652:1: note: in expansion of macro 'module_exit'
 module_exit(__driver##_exit);
 ^~~~~~~~~~~
./include/linux/platform_device.h:233:2: note: in expansion of macro 'module_driver'
  module_driver(__platform_driver, platform_driver_register, \
  ^~~~~~~~~~~~~
drivers/edac/sifive_edac.c:57:1: note: in expansion of macro 'module_platform_driver'
 module_platform_driver(sifive_edac_driver);
 ^~~~~~~~~~~~~~~~~~~~~~
./include/linux/module.h:138:7: error: redefinition of 'cleanup_module'
  void cleanup_module(void) __copy(exitfn) __attribute__((alias(#exitfn)));
       ^~~~~~~~~~~~~~
./include/linux/device.h:1652:1: note: in expansion of macro 'module_exit'
 module_exit(__driver##_exit);
 ^~~~~~~~~~~
./include/linux/platform_device.h:233:2: note: in expansion of macro 'module_driver'
  module_driver(__platform_driver, platform_driver_register, \
  ^~~~~~~~~~~~~
drivers/edac/sifive_edac.c:293:1: note: in expansion of macro 'module_platform_driver'
 module_platform_driver(sifive_edac_device_driver);
 ^~~~~~~~~~~~~~~~~~~~~~
./include/linux/module.h:138:7: note: previous definition of 'cleanup_module' was here
  void cleanup_module(void) __copy(exitfn) __attribute__((alias(#exitfn)));
       ^~~~~~~~~~~~~~
./include/linux/device.h:1652:1: note: in expansion of macro 'module_exit'
 module_exit(__driver##_exit);
 ^~~~~~~~~~~
./include/linux/platform_device.h:233:2: note: in expansion of macro 'module_driver'
  module_driver(__platform_driver, platform_driver_register, \
  ^~~~~~~~~~~~~
drivers/edac/sifive_edac.c:57:1: note: in expansion of macro 'module_platform_driver'
 module_platform_driver(sifive_edac_driver);
 ^~~~~~~~~~~~~~~~~~~~~~
make[3]: *** [scripts/Makefile.build:285: drivers/edac/sifive_edac.o] Error 1
make[2]: *** [scripts/Makefile.build:489: drivers/edac] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/home/boris/kernel/linux-2.6/Makefile:1046: drivers] Error 2
make: *** [Makefile:170: sub-make] Error 2

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
