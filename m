Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E175AC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4244820578
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxfSHhbu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbfDYSm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:42:29 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45651 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfDYSm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 14:42:28 -0400
Received: by mail-lj1-f194.google.com with SMTP id y6so530930ljd.12;
        Thu, 25 Apr 2019 11:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jHtDQCF3J4/Fd0goxVfyw29gMvOXtnHF/+TB1AFi+PA=;
        b=gxfSHhbue02amZCW/HKumTMHfDazFLnbGs4+CcAK3JWOGiIBQ77Y3wxh/Hi/phQrQk
         46AvTfX6gKgERWH8j1aJxRqwB2SEP18dGad256k0ohUphcGshP/qihtVWUYfQvkvQdzo
         G+2fDf5nz/8rQbaoFQH/2wtVuutk61jLcNUWI4ztZ4tQSUOuORMnWA0VSb0OXCsAj5DL
         clyymphCRZNpU5Wl5Axd/u7vhC10b7V+ZLfUc51hLtJ6+sIyudtXFloUziv4xd/jYMyb
         A4MlJoEBv28GbaU75wtPSX3J6E/vjWtesRphPvn7Ks02SOjTP7O61VjrDY3Eq14HwB1c
         n/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jHtDQCF3J4/Fd0goxVfyw29gMvOXtnHF/+TB1AFi+PA=;
        b=sRdt7UIF/BeKdlyHBpUgRvzg+ao9vT+oKPdtdacOJYV6ptwZXX2X6oZU7LONe50Sus
         OndYluZxLGB4b20i3QI9b1gGjLdgqXTpBrArmN5di6ew2+5l7h4CuCYsWDDn/jl98u3w
         xSIPwkfRF7tcNY3gpJ7+QOREGlA/F9xeyjeQ6SJG6ncFbMnb3pP+33s2hJSVJmxETUfX
         +m+dfRCyaOuXhh2sfToS2ZM3XNWyVrBtzWQitLvSWhfSDZ3qJO8g4eaM/UfMevMPLpPi
         +s4K7+50P9frqlSqyeHEN5Jw3R1AaMKHfyNflw2eRWUHeNjcd5Raz59yHT5XBWIQBzJY
         hHbA==
X-Gm-Message-State: APjAAAVDL5sDejHfWCBg1DlMQEjJCuP9hKkWeE3bz8TFkolzQ542ejir
        R7mcH1V4NmzMLjNecbm97Rw=
X-Google-Smtp-Source: APXvYqw7pc6j+FGos+HfZeuasTlDnwSgAGwgJuK9NFgch75dBE/0/spDG8KMWm7FjYhH12pnO2oykw==
X-Received: by 2002:a2e:3c0a:: with SMTP id j10mr10465394lja.164.1556217745997;
        Thu, 25 Apr 2019 11:42:25 -0700 (PDT)
Received: from z50.localnet (109241207190.gdansk.vectranet.pl. [109.241.207.190])
        by smtp.gmail.com with ESMTPSA id k4sm1374991lja.18.2019.04.25.11.42.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 11:42:24 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Ladislav Michl <ladis@linux-mips.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: Re: [PATCH v3] mtd: rawnand: ams-delta: Drop board specific partition info
Date:   Thu, 25 Apr 2019 20:42:22 +0200
Message-ID: <3173726.PU223hZCOI@z50>
In-Reply-To: <20190424221428.GA4172@lenoch>
References: <20190324223344.24590-1-jmkrzyszt@gmail.com> <20190424180212.10830-1-jmkrzyszt@gmail.com> <20190424221428.GA4172@lenoch>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ladislav,

On Thursday, April 25, 2019 12:14:28 AM CEST Ladislav Michl wrote:
> Hi Janusz,
> 
> On Wed, Apr 24, 2019 at 08:02:12PM +0200, Janusz Krzysztofik wrote:
> > After recent modifications, only a hardcoded partition info makes
> > the driver device specific.  Other than that, the driver uses GPIO
> > exclusively and can be used on any hardware.
> > 
> > Drop the partition info and use MTD partition parser with default list
> > of parser names instead.  For the OF parser to work correctly, pass
> > device of_node to mtd.
> > 
> > Amstrad Delta users should append the following partition info to their
> > kernel command line, possibly embedding it in CONFIG_CMDLINE:
> > 
> > mtdparts=ams-delta-nand:3584k(Kernel),256k(u-boot),256k(u-boot_params),\
> > 256k(Amstrad_LDR),27m(File_system),768k(PBL_reserved)
> 
> now, when driver is no longer Amstrad Delta specific, why would you want
> to have ams-delta-nand hardcoded on kernel cmdline? I'm assuming at some
> point this driver will become gpio-nand [*] or something like that and
> asking users to change their kernel cmdline twice is just unwise :)

Hmm, I have no idea of a good name for the driver if not "gpio-nand". Can you 
suggest one?
As a workaround, I can add a platform device id table to the driver with "ams-
delta-nand" as a supported device name in hope that survives possible future 
driver renaming.

> [*] btw, it is really shame gpio-nand name is already taken by driver
> living in drivers/mtd/nand/raw/gpio.c which is more likely gpio-mem-nand
> used by at least CompuLab CM-X255 and Picochip picoXcell.

I think the best approach would be to expose NAND data ports of those machines 
as GPIO ports, possibly reusing the "gpio-nand" driver code while creating a 
new GPIO driver for them if "basic-mmio-gpio" occurs inappropriate, and use 
the pure GPIO NAND driver on top.

> Otherwise your work on this driver is so amazing that I just spent
> couple of hours finding that phone and compiling some decent userspace
> for it :) Thank you!

I'm glad you like it :-)
Janusz

> 
> > For their convenience, that information is added to the board Kconfig
> > entry help text, as well as CONFIG_MTD_CMDLINE_PARTS symbol is selected
> > automatically from the board Kconfig entry if the NAND driver is also
> > selected.
> > 
> > Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
> > ---
> > Changelog:
> > v2->v3:
> > - add information on the requirement for passing partition info via
> >   kernel command line to the board Kconfig entry help text
> > v1->v2:
> > - fix a typo poitned out by Aaro - thanks!
> > - fix device_node not passed to OF parser via mtd_info
> > - commit message reworded and reformatted a bit for better readability
> > 
> >  arch/arm/mach-omap1/Kconfig      |  7 ++++++-
> >  drivers/mtd/nand/raw/ams-delta.c | 29 ++---------------------------
> >  2 files changed, 8 insertions(+), 28 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap1/Kconfig b/arch/arm/mach-omap1/Kconfig
> > index c4694f26b5c4..41a47d251cac 100644
> > --- a/arch/arm/mach-omap1/Kconfig
> > +++ b/arch/arm/mach-omap1/Kconfig
> > @@ -164,17 +164,22 @@ config MACH_NOKIA770
> >  	  have such a device.
> >  
> >  config MACH_AMS_DELTA
> > -	bool "Amstrad E3 (Delta)"
> > +	bool "Amstrad E3 (Delta) - see help for important information"
> >  	depends on ARCH_OMAP1 && ARCH_OMAP15XX
> >  	select FIQ
> >  	select GPIO_GENERIC_PLATFORM
> >  	select LEDS_GPIO_REGISTER
> >  	select REGULATOR
> >  	select REGULATOR_FIXED_VOLTAGE
> > +	select MTD_CMDLINE_PARTS if MTD_NAND_AMS_DELTA
> >  	help
> >  	  Support for the Amstrad E3 (codename Delta) videophone. Say Y 
here
> >  	  if you have such a device.
> >  
> > +	  If you are using built-in NAND, append the following partition
> > +	  info to kernel command line:
> > +	  mtdparts=ams-delta-nand:3584k(Kernel),256k(u-boot),256k(u-
boot_params),256k(Amstrad_LDR),27m(File_system),768k(PBL_reserved)
> > +
> >  config MACH_OMAP_GENERIC
> >  	bool "Generic OMAP board"
> >  	depends on ARCH_OMAP1 && (ARCH_OMAP15XX || ARCH_OMAP16XX)
> > diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-
delta.c
> > index 8312182088c1..e0f09179bbda 100644
> > --- a/drivers/mtd/nand/raw/ams-delta.c
> > +++ b/drivers/mtd/nand/raw/ams-delta.c
> > @@ -41,31 +41,6 @@ struct ams_delta_nand {
> >  	bool			data_in;
> >  };
> >  
> > -/*
> > - * Define partitions for flash devices
> > - */
> > -
> > -static const struct mtd_partition partition_info[] = {
> > -	{ .name		= "Kernel",
> > -	  .offset	= 0,
> > -	  .size		= 3 * SZ_1M + SZ_512K },
> > -	{ .name		= "u-boot",
> > -	  .offset	= 3 * SZ_1M + SZ_512K,
> > -	  .size		= SZ_256K },
> > -	{ .name		= "u-boot params",
> > -	  .offset	= 3 * SZ_1M + SZ_512K + SZ_256K,
> > -	  .size		= SZ_256K },
> > -	{ .name		= "Amstrad LDR",
> > -	  .offset	= 4 * SZ_1M,
> > -	  .size		= SZ_256K },
> > -	{ .name		= "File system",
> > -	  .offset	= 4 * SZ_1M + 1 * SZ_256K,
> > -	  .size		= 27 * SZ_1M },
> > -	{ .name		= "PBL reserved",
> > -	  .offset	= 32 * SZ_1M - 3 * SZ_256K,
> > -	  .size		=  3 * SZ_256K },
> > -};
> > -
> >  static void ams_delta_write_commit(struct ams_delta_nand *priv)
> >  {
> >  	gpiod_set_value(priv->gpiod_nwe, 0);
> > @@ -238,6 +213,7 @@ static int ams_delta_init(struct platform_device 
*pdev)
> >  	mtd->dev.parent = &pdev->dev;
> >  
> >  	nand_set_controller_data(this, priv);
> > +	nand_set_flash_node(this, pdev->dev.of_node);
> >  
> >  	priv->gpiod_rdy = devm_gpiod_get_optional(&pdev->dev, "rdy", 
GPIOD_IN);
> >  	if (IS_ERR(priv->gpiod_rdy)) {
> > @@ -315,8 +291,7 @@ static int ams_delta_init(struct platform_device 
*pdev)
> >  		return err;
> >  
> >  	/* Register the partitions */
> > -	err = mtd_device_register(mtd, partition_info,
> > -				  ARRAY_SIZE(partition_info));
> > +	err = mtd_device_parse_register(mtd, NULL, NULL, NULL, 0);
> >  	if (err)
> >  		goto err_nand_cleanup;
> >  
> 




