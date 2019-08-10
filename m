Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BEFC433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 08:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4789218AD
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 08:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbfHJIVZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 04:21:25 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33940 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbfHJIVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 04:21:25 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 3DE1528CF23;
        Sat, 10 Aug 2019 09:21:23 +0100 (BST)
Date:   Sat, 10 Aug 2019 10:21:21 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     soc@kernel.org, Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 12/16] mtd: rawnand: remove w90x900 driver
Message-ID: <20190810102121.07bf8c37@collabora.com>
In-Reply-To: <20190809202749.742267-13-arnd@arndb.de>
References: <20190809202749.742267-1-arnd@arndb.de>
        <20190809202749.742267-13-arnd@arndb.de>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  9 Aug 2019 22:27:40 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> The ARM w90x900 platform is getting removed, so this driver is obsolete.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

One less driver to convert to ->exec_op(), Yay! 

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/mtd/nand/raw/Kconfig       |   8 -
>  drivers/mtd/nand/raw/Makefile      |   1 -
>  drivers/mtd/nand/raw/nuc900_nand.c | 304 -----------------------------
>  3 files changed, 313 deletions(-)
>  delete mode 100644 drivers/mtd/nand/raw/nuc900_nand.c
> 
> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
> index 5a711d8beaca..0e5c5e02ee6f 100644
> --- a/drivers/mtd/nand/raw/Kconfig
> +++ b/drivers/mtd/nand/raw/Kconfig
> @@ -351,14 +351,6 @@ config MTD_NAND_SOCRATES
>  	help
>  	  Enables support for NAND Flash chips wired onto Socrates board.
>  
> -config MTD_NAND_NUC900
> -	tristate "Nuvoton NUC9xx/w90p910 NAND controller"
> -	depends on ARCH_W90X900 || COMPILE_TEST
> -	depends on HAS_IOMEM
> -	help
> -	  This enables the driver for the NAND Flash on evaluation board based
> -	  on w90p910 / NUC9xx.
> -
>  source "drivers/mtd/nand/raw/ingenic/Kconfig"
>  
>  config MTD_NAND_FSMC
> diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
> index efaf5cd25edc..d7f6c237e37c 100644
> --- a/drivers/mtd/nand/raw/Makefile
> +++ b/drivers/mtd/nand/raw/Makefile
> @@ -41,7 +41,6 @@ obj-$(CONFIG_MTD_NAND_SH_FLCTL)		+= sh_flctl.o
>  obj-$(CONFIG_MTD_NAND_MXC)		+= mxc_nand.o
>  obj-$(CONFIG_MTD_NAND_SOCRATES)		+= socrates_nand.o
>  obj-$(CONFIG_MTD_NAND_TXX9NDFMC)	+= txx9ndfmc.o
> -obj-$(CONFIG_MTD_NAND_NUC900)		+= nuc900_nand.o
>  obj-$(CONFIG_MTD_NAND_MPC5121_NFC)	+= mpc5121_nfc.o
>  obj-$(CONFIG_MTD_NAND_VF610_NFC)	+= vf610_nfc.o
>  obj-$(CONFIG_MTD_NAND_RICOH)		+= r852.o
> diff --git a/drivers/mtd/nand/raw/nuc900_nand.c b/drivers/mtd/nand/raw/nuc900_nand.c
> deleted file mode 100644
> index 13bf7b2894d3..000000000000
> --- a/drivers/mtd/nand/raw/nuc900_nand.c
> +++ /dev/null
> @@ -1,304 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Copyright © 2009 Nuvoton technology corporation.
> - *
> - * Wan ZongShun <mcuos.com@gmail.com>
> - */
> -
> -#include <linux/slab.h>
> -#include <linux/module.h>
> -#include <linux/interrupt.h>
> -#include <linux/io.h>
> -#include <linux/platform_device.h>
> -#include <linux/delay.h>
> -#include <linux/clk.h>
> -#include <linux/err.h>
> -
> -#include <linux/mtd/mtd.h>
> -#include <linux/mtd/rawnand.h>
> -#include <linux/mtd/partitions.h>
> -
> -#define REG_FMICSR   	0x00
> -#define REG_SMCSR    	0xa0
> -#define REG_SMISR    	0xac
> -#define REG_SMCMD    	0xb0
> -#define REG_SMADDR   	0xb4
> -#define REG_SMDATA   	0xb8
> -
> -#define RESET_FMI	0x01
> -#define NAND_EN		0x08
> -#define READYBUSY	(0x01 << 18)
> -
> -#define SWRST		0x01
> -#define PSIZE		(0x01 << 3)
> -#define DMARWEN		(0x03 << 1)
> -#define BUSWID		(0x01 << 4)
> -#define ECC4EN		(0x01 << 5)
> -#define WP		(0x01 << 24)
> -#define NANDCS		(0x01 << 25)
> -#define ENDADDR		(0x01 << 31)
> -
> -#define read_data_reg(dev)		\
> -	__raw_readl((dev)->reg + REG_SMDATA)
> -
> -#define write_data_reg(dev, val)	\
> -	__raw_writel((val), (dev)->reg + REG_SMDATA)
> -
> -#define write_cmd_reg(dev, val)		\
> -	__raw_writel((val), (dev)->reg + REG_SMCMD)
> -
> -#define write_addr_reg(dev, val)	\
> -	__raw_writel((val), (dev)->reg + REG_SMADDR)
> -
> -struct nuc900_nand {
> -	struct nand_chip chip;
> -	void __iomem *reg;
> -	struct clk *clk;
> -	spinlock_t lock;
> -};
> -
> -static inline struct nuc900_nand *mtd_to_nuc900(struct mtd_info *mtd)
> -{
> -	return container_of(mtd_to_nand(mtd), struct nuc900_nand, chip);
> -}
> -
> -static const struct mtd_partition partitions[] = {
> -	{
> -	 .name = "NAND FS 0",
> -	 .offset = 0,
> -	 .size = 8 * 1024 * 1024
> -	},
> -	{
> -	 .name = "NAND FS 1",
> -	 .offset = MTDPART_OFS_APPEND,
> -	 .size = MTDPART_SIZ_FULL
> -	}
> -};
> -
> -static unsigned char nuc900_nand_read_byte(struct nand_chip *chip)
> -{
> -	unsigned char ret;
> -	struct nuc900_nand *nand = mtd_to_nuc900(nand_to_mtd(chip));
> -
> -	ret = (unsigned char)read_data_reg(nand);
> -
> -	return ret;
> -}
> -
> -static void nuc900_nand_read_buf(struct nand_chip *chip,
> -				 unsigned char *buf, int len)
> -{
> -	int i;
> -	struct nuc900_nand *nand = mtd_to_nuc900(nand_to_mtd(chip));
> -
> -	for (i = 0; i < len; i++)
> -		buf[i] = (unsigned char)read_data_reg(nand);
> -}
> -
> -static void nuc900_nand_write_buf(struct nand_chip *chip,
> -				  const unsigned char *buf, int len)
> -{
> -	int i;
> -	struct nuc900_nand *nand = mtd_to_nuc900(nand_to_mtd(chip));
> -
> -	for (i = 0; i < len; i++)
> -		write_data_reg(nand, buf[i]);
> -}
> -
> -static int nuc900_check_rb(struct nuc900_nand *nand)
> -{
> -	unsigned int val;
> -	spin_lock(&nand->lock);
> -	val = __raw_readl(nand->reg + REG_SMISR);
> -	val &= READYBUSY;
> -	spin_unlock(&nand->lock);
> -
> -	return val;
> -}
> -
> -static int nuc900_nand_devready(struct nand_chip *chip)
> -{
> -	struct nuc900_nand *nand = mtd_to_nuc900(nand_to_mtd(chip));
> -	int ready;
> -
> -	ready = (nuc900_check_rb(nand)) ? 1 : 0;
> -	return ready;
> -}
> -
> -static void nuc900_nand_command_lp(struct nand_chip *chip,
> -				   unsigned int command,
> -				   int column, int page_addr)
> -{
> -	struct mtd_info *mtd = nand_to_mtd(chip);
> -	struct nuc900_nand *nand = mtd_to_nuc900(mtd);
> -
> -	if (command == NAND_CMD_READOOB) {
> -		column += mtd->writesize;
> -		command = NAND_CMD_READ0;
> -	}
> -
> -	write_cmd_reg(nand, command & 0xff);
> -
> -	if (column != -1 || page_addr != -1) {
> -
> -		if (column != -1) {
> -			if (chip->options & NAND_BUSWIDTH_16 &&
> -					!nand_opcode_8bits(command))
> -				column >>= 1;
> -			write_addr_reg(nand, column);
> -			write_addr_reg(nand, column >> 8 | ENDADDR);
> -		}
> -		if (page_addr != -1) {
> -			write_addr_reg(nand, page_addr);
> -
> -			if (chip->options & NAND_ROW_ADDR_3) {
> -				write_addr_reg(nand, page_addr >> 8);
> -				write_addr_reg(nand, page_addr >> 16 | ENDADDR);
> -			} else {
> -				write_addr_reg(nand, page_addr >> 8 | ENDADDR);
> -			}
> -		}
> -	}
> -
> -	switch (command) {
> -	case NAND_CMD_CACHEDPROG:
> -	case NAND_CMD_PAGEPROG:
> -	case NAND_CMD_ERASE1:
> -	case NAND_CMD_ERASE2:
> -	case NAND_CMD_SEQIN:
> -	case NAND_CMD_RNDIN:
> -	case NAND_CMD_STATUS:
> -		return;
> -
> -	case NAND_CMD_RESET:
> -		if (chip->legacy.dev_ready)
> -			break;
> -		udelay(chip->legacy.chip_delay);
> -
> -		write_cmd_reg(nand, NAND_CMD_STATUS);
> -		write_cmd_reg(nand, command);
> -
> -		while (!nuc900_check_rb(nand))
> -			;
> -
> -		return;
> -
> -	case NAND_CMD_RNDOUT:
> -		write_cmd_reg(nand, NAND_CMD_RNDOUTSTART);
> -		return;
> -
> -	case NAND_CMD_READ0:
> -		write_cmd_reg(nand, NAND_CMD_READSTART);
> -		/* fall through */
> -
> -	default:
> -
> -		if (!chip->legacy.dev_ready) {
> -			udelay(chip->legacy.chip_delay);
> -			return;
> -		}
> -	}
> -
> -	/* Apply this short delay always to ensure that we do wait tWB in
> -	 * any case on any machine. */
> -	ndelay(100);
> -
> -	while (!chip->legacy.dev_ready(chip))
> -		;
> -}
> -
> -
> -static void nuc900_nand_enable(struct nuc900_nand *nand)
> -{
> -	unsigned int val;
> -	spin_lock(&nand->lock);
> -	__raw_writel(RESET_FMI, (nand->reg + REG_FMICSR));
> -
> -	val = __raw_readl(nand->reg + REG_FMICSR);
> -
> -	if (!(val & NAND_EN))
> -		__raw_writel(val | NAND_EN, nand->reg + REG_FMICSR);
> -
> -	val = __raw_readl(nand->reg + REG_SMCSR);
> -
> -	val &= ~(SWRST|PSIZE|DMARWEN|BUSWID|ECC4EN|NANDCS);
> -	val |= WP;
> -
> -	__raw_writel(val, nand->reg + REG_SMCSR);
> -
> -	spin_unlock(&nand->lock);
> -}
> -
> -static int nuc900_nand_probe(struct platform_device *pdev)
> -{
> -	struct nuc900_nand *nuc900_nand;
> -	struct nand_chip *chip;
> -	struct mtd_info *mtd;
> -	struct resource *res;
> -
> -	nuc900_nand = devm_kzalloc(&pdev->dev, sizeof(struct nuc900_nand),
> -				   GFP_KERNEL);
> -	if (!nuc900_nand)
> -		return -ENOMEM;
> -	chip = &(nuc900_nand->chip);
> -	mtd = nand_to_mtd(chip);
> -
> -	mtd->dev.parent		= &pdev->dev;
> -	spin_lock_init(&nuc900_nand->lock);
> -
> -	nuc900_nand->clk = devm_clk_get(&pdev->dev, NULL);
> -	if (IS_ERR(nuc900_nand->clk))
> -		return -ENOENT;
> -	clk_enable(nuc900_nand->clk);
> -
> -	chip->legacy.cmdfunc	= nuc900_nand_command_lp;
> -	chip->legacy.dev_ready	= nuc900_nand_devready;
> -	chip->legacy.read_byte	= nuc900_nand_read_byte;
> -	chip->legacy.write_buf	= nuc900_nand_write_buf;
> -	chip->legacy.read_buf	= nuc900_nand_read_buf;
> -	chip->legacy.chip_delay	= 50;
> -	chip->options		= 0;
> -	chip->ecc.mode		= NAND_ECC_SOFT;
> -	chip->ecc.algo		= NAND_ECC_HAMMING;
> -
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	nuc900_nand->reg = devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(nuc900_nand->reg))
> -		return PTR_ERR(nuc900_nand->reg);
> -
> -	nuc900_nand_enable(nuc900_nand);
> -
> -	if (nand_scan(chip, 1))
> -		return -ENXIO;
> -
> -	mtd_device_register(mtd, partitions, ARRAY_SIZE(partitions));
> -
> -	platform_set_drvdata(pdev, nuc900_nand);
> -
> -	return 0;
> -}
> -
> -static int nuc900_nand_remove(struct platform_device *pdev)
> -{
> -	struct nuc900_nand *nuc900_nand = platform_get_drvdata(pdev);
> -
> -	nand_release(&nuc900_nand->chip);
> -	clk_disable(nuc900_nand->clk);
> -
> -	return 0;
> -}
> -
> -static struct platform_driver nuc900_nand_driver = {
> -	.probe		= nuc900_nand_probe,
> -	.remove		= nuc900_nand_remove,
> -	.driver		= {
> -		.name	= "nuc900-fmi",
> -	},
> -};
> -
> -module_platform_driver(nuc900_nand_driver);
> -
> -MODULE_AUTHOR("Wan ZongShun <mcuos.com@gmail.com>");
> -MODULE_DESCRIPTION("w90p910/NUC9xx nand driver!");
> -MODULE_LICENSE("GPL");
> -MODULE_ALIAS("platform:nuc900-fmi");

