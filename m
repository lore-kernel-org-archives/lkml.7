Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83ECC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 11:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EF1720811
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 11:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intenta.de header.i=@intenta.de header.b="KhPOXntO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbfDYLbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 07:31:06 -0400
Received: from mail.intenta.de ([178.249.25.132]:43823 "EHLO mail.intenta.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727218AbfDYLbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 07:31:05 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Apr 2019 07:31:01 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=intenta.de; s=dkim1;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:CC:To:From:Date; bh=1YrDf/rI7almzFHlmV1rQti3G7PZAvh6kFJon9dNAms=;
        b=KhPOXntOTCS+3OWZKq176cnc6TTnB4ZLk+darpgmHhDL6aRspCh2+OAYAWbLLc08NTG3rR/eDL+Lr8Rys//HDv1+uyi/NXAyK5sGpPz8ZMohUyYw3yvwC/SEz8pQAEJim8bL5GZYomWCXHfEuUOCSEubzWeA2I5qM478s9kTl6lq0YuP2thvKUX6KvcNmB/CofuvRCfkvsSWOgn8ZivpXZ+U1z38EQV4TfvLClmia0ulBWVTcW9n/lmtC8vnK90oulwuroJxKMbxskOYpvRuuC+PgdtOSPatfp8I3wbJ7/z2zVV4nq0J88kgnopDZOqvYehooo3VDxxpUgoYRohHuw==;
X-CTCH-RefID: str=0001.0A0C0208.5CC198BB.0096,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Date:   Thu, 25 Apr 2019 13:23:39 +0200
From:   Helmut Grohne <helmut.grohne@intenta.de>
To:     Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
CC:     <bbrezillon@kernel.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <marek.vasut@gmail.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <michals@xilinx.com>, <nagasureshkumarrelli@gmail.com>
Subject: Re: [LINUX PATCH v14] mtd: rawnand: pl353: Add basic driver for arm
 pl353 smc nand interface
Message-ID: <20190425112338.dipgmqqfuj45gx6s@laureti-dev>
References: <1555326613-26739-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1555326613-26739-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: ICSMA002.intenta.de (10.10.16.48) To ICSMA002.intenta.de
 (10.10.16.48)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without much knowledge of the nand framework, I attempted reviewing the
code. Hope this helps.

Helmut

On Mon, Apr 15, 2019 at 04:40:13PM +0530, Naga Sureshkumar Relli wrote:
> diff --git a/drivers/mtd/nand/raw/pl353_nand.c b/drivers/mtd/nand/raw/pl353_nand.c
> new file mode 100644
> index 0000000..eb63778
> --- /dev/null
> +++ b/drivers/mtd/nand/raw/pl353_nand.c
> @@ -0,0 +1,1399 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ARM PL353 NAND flash controller driver
> + *
> + * Copyright (C) 2017 Xilinx, Inc
> + * Author: Punnaiah chowdary kalluri <punnaiah@xilinx.com>
> + * Author: Naga Sureshkumar Relli <nagasure@xilinx.com>
> + *
> + */
> +
> +#include <linux/err.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/ioport.h>
> +#include <linux/irq.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/rawnand.h>
> +#include <linux/mtd/nand_ecc.h>
> +#include <linux/mtd/partitions.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/pl353-smc.h>
> +#include <linux/clk.h>
> +
> +#define PL353_NAND_DRIVER_NAME "pl353-nand"
> +
> +/* NAND flash driver defines */
> +#define PL353_NAND_CMD_PHASE	1	/* End command valid in command phase */
> +#define PL353_NAND_DATA_PHASE	2	/* End command valid in data phase */

The two macros above are entirely unused. They're a relict from an
earlier driver version of the driver and were used in struct
pl35x_nand_command_format member end_cmd_valid. I think they can safely
be removed now.

> +#define PL353_NAND_ECC_SIZE	512	/* Size of data for ECC operation */
> +
> +/* Flash memory controller operating parameters */
> +
> +#define PL353_NAND_ECC_CONFIG	(BIT(4)  |	/* ECC read at end of page */ \
> +				 (0 << 5))	/* No Jumping */

This macro is also unused even in older versions of the driver.

> +/* AXI Address definitions */
> +#define START_CMD_SHIFT		3
> +#define END_CMD_SHIFT		11
> +#define END_CMD_VALID_SHIFT	20
> +#define ADDR_CYCLES_SHIFT	21
> +#define CLEAR_CS_SHIFT		21
> +#define ECC_LAST_SHIFT		10
> +#define COMMAND_PHASE		(0 << 19)
> +#define DATA_PHASE		BIT(19)
> +
> +#define PL353_NAND_ECC_LAST	BIT(ECC_LAST_SHIFT)	/* Set ECC_Last */
> +#define PL353_NAND_CLEAR_CS	BIT(CLEAR_CS_SHIFT)	/* Clear chip select */
> +
> +#define PL353_NAND_ECC_BUSY_TIMEOUT	(1 * HZ)
> +#define PL353_NAND_DEV_BUSY_TIMEOUT	(1 * HZ)

These timeouts are a second each. I've remarked earlier that you are
waiting with cpu_relax() on these. Having the CPU spin for a full second
is bad. Please try using less intensive waiting methods for such long
delays or reduce the timeouts.

> +#define PL353_NAND_LAST_TRANSFER_LENGTH	4
> +#define PL353_NAND_ECC_VALID_SHIFT	24
> +#define PL353_NAND_ECC_VALID_MASK	0x40
> +#define PL353_ECC_BITS_BYTEOFF_MASK	0x1FF
> +#define PL353_ECC_BITS_BITOFF_MASK	0x7
> +#define PL353_ECC_BIT_MASK		0xFFF
> +#define PL353_TREA_MAX_VALUE		1
> +#define PL353_MAX_ECC_CHUNKS		4
> +#define PL353_MAX_ECC_BYTES		3
> +
> +struct pl353_nfc_op {
> +	u32 cmnds[4];

Why does this hold 4 elements? In the code, this array is only indexed
with 0 and 1.

> +	u32 end_cmd;

What is the purpose of this field. It is never accessed.

> +	u32 addrs;
> +	u32 naddrs;
> +	u32 addr5;
> +	u32 addr6;

Why are addr5 and addr6 u32? You only ever store u8 values in here. How
about merging them into an u16 addr56? Doing so would make the access in
pl353_nand_exec_op_cmd simpler and move a little complexity into
pl353_nfc_parse_instructions.

> +	unsigned int data_instr_idx;
> +	unsigned int rdy_timeout_ms;
> +	unsigned int rdy_delay_ns;
> +	unsigned int cle_ale_delay_ns;

What is the purpose of this field. It is set in two places, but never
read. No driver logic depends on its value.

> +	const struct nand_op_instr *data_instr;
> +};
> +
> +/**
> + * struct pl353_nand_controller - Defines the NAND flash controller driver
> + *				  instance
> + * @chip:		NAND chip information structure
> + * @dev:		Parent device (used to print error messages)
> + * @regs:		Virtual address of the NAND flash device
> + * @buf_addr:		Virtual address of the NAND flash device for
> + *			data read/writes
> + * @addr_cycles:	Address cycles
> + * @mclk:		Memory controller clock
> + * @buswidth:		Bus width 8 or 16
> + */
> +struct pl353_nand_controller {
> +	struct nand_controller controller;
> +	struct nand_chip chip;
> +	struct device *dev;
> +	void __iomem *regs;
> +	void __iomem *buf_addr;

I find the use of buf_addr unfortunate. It is consumed by two functions
pl353_nand_read_data_op and pl353_nand_write_data_op. All other
functions update its value. Semantically, its value is regs + some
flags. For the updaters that means a complex logic where they first have
to subtract reg, then change flags and add reg again. To make matters
worse, this computation involves __force casts between long and __iomem
(which yielded complaints in earlier reviews).  I think it would
simplify the code if you replaced buf_addr with something like
addr_flags and then compute buf_addr as regs + addr_flags in those two
consumers. What do you think?

> +	u8 addr_cycles;
> +	struct clk *mclk;

All you need here is the memory clock frequency. Wouldn't it be easier
to extract that frequency once during probe and store it here? That
assumes a constant frequency, but if the frequency isn't constant, you
have a race condition.

> +	u32 buswidth;
> +};
> +
> +static inline struct pl353_nand_controller *
> +			to_pl353_nand(struct nand_chip *chip)
> +{
> +	return container_of(chip, struct pl353_nand_controller, chip);
> +}
> +
> +static int pl353_ecc_ooblayout16_ecc(struct mtd_info *mtd, int section,
> +				     struct mtd_oob_region *oobregion)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +
> +	if (section >= chip->ecc.steps)
> +		return -ERANGE;
> +
> +	oobregion->offset = (section * chip->ecc.bytes);
> +	oobregion->length = chip->ecc.bytes;
> +
> +	return 0;
> +}
> +
> +static int pl353_ecc_ooblayout16_free(struct mtd_info *mtd, int section,
> +				      struct mtd_oob_region *oobregion)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +
> +	if (section >= chip->ecc.steps)
> +		return -ERANGE;
> +
> +	oobregion->offset = (section * chip->ecc.bytes) + 8;
> +	oobregion->length = 8;
> +
> +	return 0;
> +}
> +
> +static const struct mtd_ooblayout_ops pl353_ecc_ooblayout16_ops = {
> +	.ecc = pl353_ecc_ooblayout16_ecc,
> +	.free = pl353_ecc_ooblayout16_free,
> +};
> +
> +static int pl353_ecc_ooblayout64_ecc(struct mtd_info *mtd, int section,
> +				     struct mtd_oob_region *oobregion)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +
> +	if (section >= chip->ecc.steps)
> +		return -ERANGE;
> +
> +	oobregion->offset = (section * chip->ecc.bytes) + 52;
> +	oobregion->length = chip->ecc.bytes;
> +
> +	return 0;
> +}
> +
> +static int pl353_ecc_ooblayout64_free(struct mtd_info *mtd, int section,
> +				      struct mtd_oob_region *oobregion)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +
> +	if (section)
> +		return -ERANGE;
> +
> +	if (section >= chip->ecc.steps)
> +		return -ERANGE;

We already know that section == 0 here. This second condition can only
be met if chip->ecc.steps < 0. Is that really what you want to test
here?

> +
> +	oobregion->offset = (section * chip->ecc.bytes) + 2;
> +	oobregion->length = 50;
> +
> +	return 0;
> +}
> +
> +static const struct mtd_ooblayout_ops pl353_ecc_ooblayout64_ops = {
> +	.ecc = pl353_ecc_ooblayout64_ecc,
> +	.free = pl353_ecc_ooblayout64_free,
> +};
> +
> +/* Generic flash bbt decriptors */
> +static u8 bbt_pattern[] = { 'B', 'b', 't', '0' };
> +static u8 mirror_pattern[] = { '1', 't', 'b', 'B' };
> +
> +static struct nand_bbt_descr bbt_main_descr = {
> +	.options = NAND_BBT_LASTBLOCK | NAND_BBT_CREATE | NAND_BBT_WRITE
> +		| NAND_BBT_2BIT | NAND_BBT_VERSION | NAND_BBT_PERCHIP,
> +	.offs = 4,
> +	.len = 4,
> +	.veroffs = 20,
> +	.maxblocks = 4,
> +	.pattern = bbt_pattern

I have a general question concerning the nand framework here. The
pattern member in struct nand_bbt_descr is not declared const.
Therefore, bbt_pattern cannot be const here. As far as I looked, all
accesses of pattern use it with memcmp or as source for memcpy. Also the
diskonchip.c driver assigns a string constant here. This suggests, that
pattern should be declared const or that diskonchip.c is doing it wrong.

> +};
> +
> +static struct nand_bbt_descr bbt_mirror_descr = {
> +	.options = NAND_BBT_LASTBLOCK | NAND_BBT_CREATE | NAND_BBT_WRITE
> +		| NAND_BBT_2BIT | NAND_BBT_VERSION | NAND_BBT_PERCHIP,
> +	.offs = 4,
> +	.len = 4,
> +	.veroffs = 20,
> +	.maxblocks = 4,
> +	.pattern = mirror_pattern
> +};
> +
> +static void pl353_nfc_force_byte_access(struct nand_chip *chip,
> +					bool force_8bit)
> +{
> +	int ret;
> +	struct pl353_nand_controller *xnfc =
> +		container_of(chip, struct pl353_nand_controller, chip);
> +
> +	if (xnfc->buswidth == 8)

This buswidth member is never assigned anywhere. Thus the value is
always 0 and this comparison always fails.

> +		return;
> +
> +	if (force_8bit)
> +		ret = pl353_smc_set_buswidth(PL353_SMC_MEM_WIDTH_8);
> +	else
> +		ret = pl353_smc_set_buswidth(PL353_SMC_MEM_WIDTH_16);
> +
> +	if (ret)
> +		dev_err(xnfc->dev, "Error in Buswidth\n");
> +}
> +
> +static inline int pl353_wait_for_dev_ready(struct nand_chip *chip)
> +{
> +	unsigned long timeout = jiffies + PL353_NAND_DEV_BUSY_TIMEOUT;
> +
> +	do {
> +		if (pl353_smc_get_nand_int_status_raw()) {
> +			pl353_smc_clr_nand_int();
> +			break;
> +
> +		cpu_relax();
> +	} while (!time_after_eq(jiffies, timeout));
> +
> +	if (time_after_eq(jiffies, timeout)) {
> +		pr_err("%s timed out\n", __func__);
> +		return -ETIMEDOUT;
> +	}

This could be simplified and avoid repeating the timeout condition:

	while (!pl353_smc_get_nand_int_status_raw()) {
		if (time_after_eq(jiffies, timeout)) {
			pr_err("%s timed out\n", __func__);
			return -ETIMEDOUT;
		}
		cpu_relax();
	}
	pl353_smc_clr_nand_int();

> +
> +	return 0;
> +}
> +
> +/**
> + * pl353_nand_read_data_op - read chip data into buffer
> + * @chip:	Pointer to the NAND chip info structure
> + * @in:		Pointer to the buffer to store read data
> + * @len:	Number of bytes to read
> + * @force_8bit:	Force 8-bit bus access
> + * Return:	Always return zero
> + */
> +static void pl353_nand_read_data_op(struct nand_chip *chip, u8 *in,
> +				    unsigned int len, bool force_8bit)
> +{
> +	int i;
> +	struct pl353_nand_controller *xnfc = to_pl353_nand(chip);
> +
> +	if (force_8bit)
> +		pl353_nfc_force_byte_access(chip, true);
> +
> +	if ((IS_ALIGNED((uint32_t)in, sizeof(uint32_t)) &&
> +	     IS_ALIGNED(len, sizeof(uint32_t))) || !force_8bit) {
> +		u32 *ptr = (u32 *)in;
> +
> +		len /= 4;
> +		for (i = 0; i < len; i++)
> +			ptr[i] = readl(xnfc->buf_addr);
> +	} else {
> +		for (i = 0; i < len; i++)
> +			in[i] = readb(xnfc->buf_addr);
> +	}
> +
> +	if (force_8bit)
> +		pl353_nfc_force_byte_access(chip, false);
> +}
> +
> +/**
> + * pl353_nand_write_buf - write buffer to chip
> + * @mtd:	Pointer to the mtd info structure
> + * @buf:	Pointer to the buffer to store write data
> + * @len:	Number of bytes to write
> + * @force_8bit:	Force 8-bit bus access
> + */
> +static void pl353_nand_write_data_op(struct nand_chip *chip, const u8 *buf,
> +				     int len, bool force_8bit)
> +{
> +	int i;
> +	struct pl353_nand_controller *xnfc = to_pl353_nand(chip);
> +
> +	if (force_8bit)
> +		pl353_nfc_force_byte_access(chip, true);
> +
> +	if ((IS_ALIGNED((uint32_t)buf, sizeof(uint32_t)) &&
> +	     IS_ALIGNED(len, sizeof(uint32_t))) || !force_8bit) {
> +		u32 *ptr = (u32 *)buf;
> +
> +		len /= 4;
> +		for (i = 0; i < len; i++)
> +			writel(ptr[i], xnfc->buf_addr);
> +	} else {
> +		for (i = 0; i < len; i++)
> +			writeb(buf[i], xnfc->buf_addr);
> +	}
> +
> +	if (force_8bit)
> +		pl353_nfc_force_byte_access(chip, false);
> +}
> +
> +static inline int pl353_wait_for_ecc_done(void)
> +{
> +	unsigned long timeout = jiffies + PL353_NAND_ECC_BUSY_TIMEOUT;
> +
> +	do {
> +		if (pl353_smc_ecc_is_busy())
> +			cpu_relax();
> +		else
> +			break;
> +	} while (!time_after_eq(jiffies, timeout));
> +
> +	if (time_after_eq(jiffies, timeout)) {
> +		pr_err("%s timed out\n", __func__);
> +		return -ETIMEDOUT;
> +	}

This could be simplified and avoid repeating the timeout condition:

	while (pl353_smc_ecc_is_busy()) {
		if (time_after_eq(jiffies, timeout)) {
			pr_err("%s timed out\n", __func__);
			return -ETIMEDOUT;
		}
		cpu_relax();
	}

> +
> +	return 0;
> +}
> +
> +/**
> + * pl353_nand_calculate_hwecc - Calculate Hardware ECC
> + * @mtd:	Pointer to the mtd_info structure
> + * @data:	Pointer to the page data
> + * @ecc:	Pointer to the ECC buffer where ECC data needs to be stored
> + *
> + * This function retrieves the Hardware ECC data from the controller and returns
> + * ECC data back to the MTD subsystem.
> + * It operates on a number of 512 byte blocks of NAND memory and can be
> + * programmed to store the ECC codes after the data in memory. For writes,
> + * the ECC is written to the spare area of the page. For reads, the result of
> + * a block ECC check are made available to the device driver.
> + *
> + * ------------------------------------------------------------------------
> + * |               n * 512 blocks                  | extra  | ecc    |     |
> + * |                                               | block  | codes  |     |
> + * ------------------------------------------------------------------------
> + *
> + * The ECC calculation uses a simple Hamming code, using 1-bit correction 2-bit
> + * detection. It starts when a valid read or write command with a 512 byte
> + * aligned address is detected on the memory interface.
> + *
> + * Return:	0 on success or error value on failure
> + */
> +static int pl353_nand_calculate_hwecc(struct nand_chip *chip,
> +				      const u8 *data, u8 *ecc)
> +{
> +	u32 ecc_value;
> +	u8 chunk, ecc_byte, ecc_status;
> +
> +	for (chunk = 0; chunk < PL353_MAX_ECC_CHUNKS; chunk++) {
> +		/* Read ECC value for each block */
> +		ecc_value = pl353_smc_get_ecc_val(chunk);
> +		ecc_status = (ecc_value >> PL353_NAND_ECC_VALID_SHIFT);
> +
> +		/* ECC value valid */
> +		if (ecc_status & PL353_NAND_ECC_VALID_MASK) {
> +			for (ecc_byte = 0; ecc_byte < PL353_MAX_ECC_BYTES;
> +			     ecc_byte++) {
> +				/* Copy ECC bytes to MTD buffer */
> +				*ecc = ~ecc_value & 0xFF;
> +				ecc_value = ecc_value >> 8;
> +				ecc++;
> +			}
> +		} else {
> +			pr_warn("%s status failed\n", __func__);
> +			return -1;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * pl353_nand_correct_data - ECC correction function
> + * @mtd:	Pointer to the mtd_info structure
> + * @buf:	Pointer to the page data
> + * @read_ecc:	Pointer to the ECC value read from spare data area
> + * @calc_ecc:	Pointer to the calculated ECC value
> + *
> + * This function corrects the ECC single bit errors & detects 2-bit errors.
> + *
> + * Return:	0 if no ECC errors found
> + *		1 if single bit error found and corrected.
> + *		-1 if multiple uncorrectable ECC errors found.
> + */
> +static int pl353_nand_correct_data(struct nand_chip *chip, unsigned char *buf,
> +				   unsigned char *read_ecc,
> +				   unsigned char *calc_ecc)
> +{
> +	unsigned char bit_addr;
> +	unsigned int byte_addr;
> +	unsigned short ecc_odd, ecc_even, read_ecc_lower, read_ecc_upper;
> +	unsigned short calc_ecc_lower, calc_ecc_upper;
> +
> +	read_ecc_lower = (read_ecc[0] | (read_ecc[1] << 8)) &
> +			  PL353_ECC_BIT_MASK;
> +	read_ecc_upper = ((read_ecc[1] >> 4) | (read_ecc[2] << 4)) &
> +			  PL353_ECC_BIT_MASK;
> +
> +	calc_ecc_lower = (calc_ecc[0] | (calc_ecc[1] << 8)) &
> +			  PL353_ECC_BIT_MASK;
> +	calc_ecc_upper = ((calc_ecc[1] >> 4) | (calc_ecc[2] << 4)) &
> +			  PL353_ECC_BIT_MASK;
> +
> +	ecc_odd = read_ecc_lower ^ calc_ecc_lower;
> +	ecc_even = read_ecc_upper ^ calc_ecc_upper;
> +
> +	/* no error */
> +	if (!ecc_odd && !ecc_even)
> +		return 0;
> +
> +	if (ecc_odd == (~ecc_even & PL353_ECC_BIT_MASK)) {
> +		/* bits [11:3] of error code is byte offset */
> +		byte_addr = (ecc_odd >> 3) & PL353_ECC_BITS_BYTEOFF_MASK;
> +		/* bits [2:0] of error code is bit offset */
> +		bit_addr = ecc_odd & PL353_ECC_BITS_BITOFF_MASK;
> +		/* Toggling error bit */
> +		buf[byte_addr] ^= (BIT(bit_addr));
> +		return 1;
> +	}
> +
> +	/* one error in parity */
> +	if (hweight32(ecc_odd | ecc_even) == 1)
> +		return 1;
> +
> +	/* Uncorrectable error */
> +	return -1;
> +}
> +
> +static void pl353_prepare_cmd(struct nand_chip *chip,
> +			      int page, int column, int start_cmd, int end_cmd,
> +			      bool read)
> +{
> +	unsigned long data_phase_addr;
> +	u32 end_cmd_valid = 0;
> +	unsigned long cmd_phase_addr = 0, cmd_phase_data = 0;
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +
> +	struct pl353_nand_controller *xnfc = to_pl353_nand(chip);
> +
> +	end_cmd_valid = read ? 1 : 0;
> +
> +	cmd_phase_addr = (unsigned long __force)xnfc->regs +
> +			 ((xnfc->addr_cycles
> +			 << ADDR_CYCLES_SHIFT) |
> +			 (end_cmd_valid << END_CMD_VALID_SHIFT) |
> +			 (COMMAND_PHASE) |
> +			 (end_cmd << END_CMD_SHIFT) |
> +			 (start_cmd << START_CMD_SHIFT));
> +
> +	/* Get the data phase address */
> +	data_phase_addr = (unsigned long __force)xnfc->regs +
> +			  ((0x0 << CLEAR_CS_SHIFT) |
> +			  (0 << END_CMD_VALID_SHIFT) |
> +			  (DATA_PHASE) |
> +			  (end_cmd << END_CMD_SHIFT) |
> +			  (0x0 << ECC_LAST_SHIFT));
> +
> +	xnfc->buf_addr = (void __iomem * __force)data_phase_addr;
> +
> +	if (chip->options & NAND_BUSWIDTH_16)
> +		column /= 2;
> +	cmd_phase_data = column;
> +	if (mtd->writesize > PL353_NAND_ECC_SIZE) {
> +		cmd_phase_data |= page << 16;
> +		/* Another address cycle for devices > 128MiB */
> +		if (chip->options & NAND_ROW_ADDR_3) {
> +			writel_relaxed(cmd_phase_data,
> +				       (void __iomem * __force)cmd_phase_addr);
> +			cmd_phase_data = (page >> 16);
> +		}
> +	} else {
> +		cmd_phase_data |= page << 8;
> +	}
> +
> +	writel_relaxed(cmd_phase_data, (void __iomem * __force)cmd_phase_addr);
> +}
> +
> +/**
> + * pl353_nand_read_oob - [REPLACEABLE] the most common OOB data read function
> + * @mtd:	Pointer to the mtd_info structure
> + * @chip:	Pointer to the nand_chip structure
> + * @page:	Page number to read
> + *
> + * Return:	Always return zero
> + */
> +static int pl353_nand_read_oob(struct nand_chip *chip,
> +			       int page)
> +{
> +	struct pl353_nand_controller *xnfc = to_pl353_nand(chip);
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +	unsigned long data_phase_addr;
> +	unsigned long nand_offset = (unsigned long __force)xnfc->regs;
> +	u8 *p;
> +
> +	chip->pagebuf = -1;
> +	if (mtd->writesize < PL353_NAND_ECC_SIZE)
> +		return 0;
> +
> +	pl353_prepare_cmd(chip, page, mtd->writesize, NAND_CMD_READ0,
> +			  NAND_CMD_READSTART, 1);
> +	if (pl353_wait_for_dev_ready(chip))
> +		return -ETIMEDOUT;
> +
> +	p = chip->oob_poi;
> +	pl353_nand_read_data_op(chip, p,
> +				(mtd->oobsize -
> +				PL353_NAND_LAST_TRANSFER_LENGTH), false);
> +	p += (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
> +	data_phase_addr = (unsigned long __force)xnfc->buf_addr;
> +	data_phase_addr -= nand_offset;
> +	data_phase_addr |= PL353_NAND_CLEAR_CS;
> +	data_phase_addr += nand_offset;
> +	xnfc->buf_addr = (void __iomem * __force)data_phase_addr;
> +	pl353_nand_read_data_op(chip, p, PL353_NAND_LAST_TRANSFER_LENGTH,
> +				false);
> +
> +	return 0;
> +}
> +
> +/**
> + * pl353_nand_write_oob - [REPLACEABLE] the most common OOB data write function
> + * @mtd:	Pointer to the mtd info structure
> + * @chip:	Pointer to the NAND chip info structure
> + * @page:	Page number to write
> + *
> + * Return:	Zero on success and EIO on failure
> + */
> +static int pl353_nand_write_oob(struct nand_chip *chip,
> +				int page)
> +{
> +	struct pl353_nand_controller *xnfc = to_pl353_nand(chip);
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +	unsigned long nand_offset = (unsigned long __force)xnfc->regs;
> +	unsigned long data_phase_addr;
> +	const u8 *buf = chip->oob_poi;
> +
> +	chip->pagebuf = -1;
> +	pl353_prepare_cmd(chip, page, mtd->writesize, NAND_CMD_SEQIN,
> +			  NAND_CMD_PAGEPROG, 0);
> +
> +	pl353_nand_write_data_op(chip, buf,
> +				 (mtd->oobsize -
> +				 PL353_NAND_LAST_TRANSFER_LENGTH), false);
> +	buf += (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
> +
> +	data_phase_addr = (unsigned long __force)xnfc->buf_addr;
> +	data_phase_addr -= nand_offset;
> +	data_phase_addr |= PL353_NAND_CLEAR_CS;
> +	data_phase_addr |= (1 << END_CMD_VALID_SHIFT);
> +	data_phase_addr += nand_offset;
> +	xnfc->buf_addr = (void __iomem * __force)data_phase_addr;
> +	pl353_nand_write_data_op(chip, buf, PL353_NAND_LAST_TRANSFER_LENGTH,
> +				 false);
> +	if (pl353_wait_for_dev_ready(chip))
> +		return -ETIMEDOUT;
> +
> +	return 0;
> +}
> +
> +/**
> + * pl353_nand_read_page_raw - [Intern] read raw page data without ecc
> + * @mtd:		Pointer to the mtd info structure
> + * @chip:		Pointer to the NAND chip info structure
> + * @buf:		Pointer to the data buffer
> + * @oob_required:	Caller requires OOB data read to chip->oob_poi
> + * @page:		Page number to read
> + *
> + * Return:	Always return zero
> + */
> +static int pl353_nand_read_page_raw(struct nand_chip *chip,
> +				    u8 *buf, int oob_required, int page)
> +{
> +	struct pl353_nand_controller *xnfc = to_pl353_nand(chip);
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +	unsigned long nand_offset = (unsigned long __force)xnfc->regs;
> +	unsigned long data_phase_addr;
> +	u8 *p;
> +
> +	pl353_prepare_cmd(chip, page, 0, NAND_CMD_READ0,
> +			  NAND_CMD_READSTART, 1);
> +	if (pl353_wait_for_dev_ready(chip))
> +		return -ETIMEDOUT;
> +
> +	pl353_nand_read_data_op(chip, buf, mtd->writesize, false);
> +	p = chip->oob_poi;
> +	pl353_nand_read_data_op(chip, p,
> +				(mtd->oobsize -
> +				PL353_NAND_LAST_TRANSFER_LENGTH), false);
> +	p += (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
> +
> +	data_phase_addr = (unsigned long __force)xnfc->buf_addr;
> +	data_phase_addr -= nand_offset;
> +	data_phase_addr |= PL353_NAND_CLEAR_CS;
> +	data_phase_addr += nand_offset;
> +	xnfc->buf_addr = (void __iomem * __force)data_phase_addr;
> +
> +	pl353_nand_read_data_op(chip, p, PL353_NAND_LAST_TRANSFER_LENGTH,
> +				false);
> +
> +	return 0;
> +}
> +
> +/**
> + * pl353_nand_write_page_raw - [Intern] raw page write function
> + * @mtd:		Pointer to the mtd info structure
> + * @chip:		Pointer to the NAND chip info structure
> + * @buf:		Pointer to the data buffer
> + * @oob_required:	Caller requires OOB data read to chip->oob_poi
> + * @page:		Page number to write
> + *
> + * Return:	Always return zero
> + */
> +static int pl353_nand_write_page_raw(struct nand_chip *chip,
> +				     const u8 *buf, int oob_required,
> +				     int page)
> +{
> +	struct pl353_nand_controller *xnfc = to_pl353_nand(chip);
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +	unsigned long nand_offset = (unsigned long __force)xnfc->regs;
> +	unsigned long data_phase_addr;
> +	u8 *p;
> +
> +	pl353_prepare_cmd(chip, page, 0, NAND_CMD_SEQIN,
> +			  NAND_CMD_PAGEPROG, 0);
> +	pl353_nand_write_data_op(chip, buf, mtd->writesize, false);
> +	p = chip->oob_poi;
> +	pl353_nand_write_data_op(chip, p,
> +				 (mtd->oobsize -
> +				 PL353_NAND_LAST_TRANSFER_LENGTH), false);
> +	p += (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
> +
> +	data_phase_addr = (unsigned long __force)xnfc->buf_addr;
> +	data_phase_addr -= nand_offset;
> +	data_phase_addr |= PL353_NAND_CLEAR_CS;
> +	data_phase_addr |= (1 << END_CMD_VALID_SHIFT);
> +	data_phase_addr += nand_offset;
> +	xnfc->buf_addr = (void __iomem * __force)data_phase_addr;
> +	pl353_nand_write_data_op(chip, p, PL353_NAND_LAST_TRANSFER_LENGTH,
> +				 false);
> +
> +	return 0;
> +}
> +
> +/**
> + * nand_write_page_hwecc - Hardware ECC based page write function
> + * @mtd:		Pointer to the mtd info structure
> + * @chip:		Pointer to the NAND chip info structure
> + * @buf:		Pointer to the data buffer
> + * @oob_required:	Caller requires OOB data read to chip->oob_poi
> + * @page:		Page number to write
> + *
> + * This functions writes data and hardware generated ECC values in to the page.
> + *
> + * Return:	Always return zero
> + */
> +static int pl353_nand_write_page_hwecc(struct nand_chip *chip,
> +				       const u8 *buf, int oob_required,
> +				       int page)
> +{
> +	int eccsize = chip->ecc.size;
> +	int eccsteps = chip->ecc.steps;
> +	u8 *ecc_calc = chip->ecc.calc_buf;
> +	u8 *oob_ptr;
> +	const u8 *p = buf;
> +	u32 ret;
> +	struct pl353_nand_controller *xnfc = to_pl353_nand(chip);
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +	unsigned long nand_offset = (unsigned long __force)xnfc->regs;
> +	unsigned long data_phase_addr;
> +
> +	pl353_prepare_cmd(chip, page, 0, NAND_CMD_SEQIN,
> +			  NAND_CMD_PAGEPROG, 0);
> +
> +	for ( ; (eccsteps - 1); eccsteps--) {
> +		pl353_nand_write_data_op(chip, p, eccsize, false);
> +		p += eccsize;
> +	}
> +	pl353_nand_write_data_op(chip, p,
> +				 (eccsize - PL353_NAND_LAST_TRANSFER_LENGTH),
> +				 false);
> +	p += (eccsize - PL353_NAND_LAST_TRANSFER_LENGTH);
> +
> +	/* Set ECC Last bit to 1 */
> +	data_phase_addr = (unsigned long __force)xnfc->buf_addr;
> +	data_phase_addr -= nand_offset;
> +	data_phase_addr |= PL353_NAND_ECC_LAST;
> +	data_phase_addr += nand_offset;
> +	xnfc->buf_addr = (void __iomem * __force)data_phase_addr;
> +	pl353_nand_write_data_op(chip, p, PL353_NAND_LAST_TRANSFER_LENGTH,
> +				 false);
> +
> +	/* Wait till the ECC operation is complete or timeout */
> +	ret = pl353_wait_for_ecc_done();
> +	if (ret)
> +		dev_err(xnfc->dev, "ECC Timeout\n");
> +	p = buf;
> +	ret = chip->ecc.calculate(chip, p, &ecc_calc[0]);
> +	if (ret)
> +		return ret;
> +
> +	/* Wait for ECC to be calculated and read the error values */
> +	ret = mtd_ooblayout_set_eccbytes(mtd, ecc_calc, chip->oob_poi,
> +					 0, chip->ecc.total);
> +	if (ret)
> +		return ret;
> +	/* Clear ECC last bit */
> +	data_phase_addr = (unsigned long __force)xnfc->buf_addr;
> +	data_phase_addr -= nand_offset;
> +	data_phase_addr &= ~PL353_NAND_ECC_LAST;
> +	data_phase_addr += nand_offset;
> +	xnfc->buf_addr = (void __iomem * __force)data_phase_addr;
> +
> +	/* Write the spare area with ECC bytes */
> +	oob_ptr = chip->oob_poi;
> +	pl353_nand_write_data_op(chip, oob_ptr,
> +				 (mtd->oobsize -
> +				 PL353_NAND_LAST_TRANSFER_LENGTH), false);
> +
> +	data_phase_addr = (unsigned long __force)xnfc->buf_addr;
> +	data_phase_addr -= nand_offset;
> +	data_phase_addr |= PL353_NAND_CLEAR_CS;
> +	data_phase_addr |= (1 << END_CMD_VALID_SHIFT);
> +	data_phase_addr += nand_offset;
> +	xnfc->buf_addr = (void __iomem * __force)data_phase_addr;
> +	oob_ptr += (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
> +	pl353_nand_write_data_op(chip, oob_ptr, PL353_NAND_LAST_TRANSFER_LENGTH,
> +				 false);
> +	if (pl353_wait_for_dev_ready(chip))
> +		return -ETIMEDOUT;
> +
> +	return 0;
> +}
> +
> +/**
> + * pl353_nand_read_page_hwecc - Hardware ECC based page read function
> + * @mtd:		Pointer to the mtd info structure
> + * @chip:		Pointer to the NAND chip info structure
> + * @buf:		Pointer to the buffer to store read data
> + * @oob_required:	Caller requires OOB data read to chip->oob_poi
> + * @page:		Page number to read
> + *
> + * This functions reads data and checks the data integrity by comparing
> + * hardware generated ECC values and read ECC values from spare area.
> + * There is a limitation in SMC controller, that we must set ECC LAST on
> + * last data phase access, to tell ECC block not to expect any data further.
> + * Ex:  When number of ECC STEPS are 4, then till 3 we will write to flash
> + * using SMC with HW ECC enabled. And for the last ECC STEP, we will subtract
> + * 4bytes from page size, and will initiate a transfer. And the remaining 4 as
> + * one more transfer with ECC_LAST bit set in NAND data phase register to
> + * notify ECC block not to expect any more data. The last block should be align
> + * with end of 512 byte block. Because of this limitation, we are not using
> + * core routines.
> + *
> + * Return:	0 always and updates ECC operation status in to MTD structure
> + */
> +static int pl353_nand_read_page_hwecc(struct nand_chip *chip,
> +				      u8 *buf, int oob_required, int page)
> +{
> +	int i, stat, eccsize = chip->ecc.size;
> +	int eccbytes = chip->ecc.bytes;
> +	int eccsteps = chip->ecc.steps;
> +	u8 *p = buf;
> +	u8 *ecc_calc = chip->ecc.calc_buf;
> +	u8 *ecc = chip->ecc.code_buf;
> +	unsigned int max_bitflips = 0;
> +	u8 *oob_ptr;
> +	u32 ret;
> +	unsigned long data_phase_addr;
> +	unsigned long nand_offset = (unsigned long __force)xnfc->regs;
> +	struct pl353_nand_controller *xnfc = to_pl353_nand(chip);
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +
> +	pl353_prepare_cmd(chip, page, 0, NAND_CMD_READ0,
> +			  NAND_CMD_READSTART, 1);
> +	if (pl353_wait_for_dev_ready(chip))
> +		return -ETIMEDOUT;
> +
> +	for ( ; (eccsteps - 1); eccsteps--) {
> +		pl353_nand_read_data_op(chip, p, eccsize, false);
> +		p += eccsize;
> +	}
> +
> +	pl353_nand_read_data_op(chip, p,
> +				(eccsize - PL353_NAND_LAST_TRANSFER_LENGTH),
> +				false);
> +	p += (eccsize - PL353_NAND_LAST_TRANSFER_LENGTH);
> +
> +	/* Set ECC Last bit to 1 */
> +	data_phase_addr = (unsigned long __force)xnfc->buf_addr;
> +	data_phase_addr -= nand_offset;
> +	data_phase_addr |= PL353_NAND_ECC_LAST;
> +	data_phase_addr += nand_offset;
> +	xnfc->buf_addr = (void __iomem * __force)data_phase_addr;
> +	pl353_nand_read_data_op(chip, p, PL353_NAND_LAST_TRANSFER_LENGTH,
> +				false);
> +
> +	/* Wait till the ECC operation is complete or timeout */
> +	ret = pl353_wait_for_ecc_done();
> +	if (ret)
> +		dev_err(xnfc->dev, "ECC Timeout\n");
> +
> +	/* Read the calculated ECC value */
> +	p = buf;
> +	ret = chip->ecc.calculate(chip, p, &ecc_calc[0]);
> +	if (ret)
> +		return ret;
> +
> +	/* Clear ECC last bit */
> +	data_phase_addr = (unsigned long __force)xnfc->buf_addr;
> +	data_phase_addr -= nand_offset;
> +	data_phase_addr &= ~PL353_NAND_ECC_LAST;
> +	data_phase_addr += nand_offset;
> +	xnfc->buf_addr = (void __iomem * __force)data_phase_addr;
> +
> +	/* Read the stored ECC value */
> +	oob_ptr = chip->oob_poi;
> +	pl353_nand_read_data_op(chip, oob_ptr,
> +				(mtd->oobsize -
> +				PL353_NAND_LAST_TRANSFER_LENGTH), false);
> +
> +	/* de-assert chip select */
> +	data_phase_addr = (unsigned long __force)xnfc->buf_addr;
> +	data_phase_addr -= nand_offset;
> +	data_phase_addr |= PL353_NAND_CLEAR_CS;
> +	data_phase_addr += nand_offset;
> +	xnfc->buf_addr = (void __iomem * __force)data_phase_addr;
> +
> +	oob_ptr += (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
> +	pl353_nand_read_data_op(chip, oob_ptr, PL353_NAND_LAST_TRANSFER_LENGTH,
> +				false);
> +
> +	ret = mtd_ooblayout_get_eccbytes(mtd, ecc, chip->oob_poi, 0,
> +					 chip->ecc.total);
> +	if (ret)
> +		return ret;
> +
> +	eccsteps = chip->ecc.steps;
> +	p = buf;
> +
> +	/* Check ECC error for all blocks and correct if it is correctable */
> +	for (i = 0 ; eccsteps; eccsteps--, i += eccbytes, p += eccsize) {
> +		stat = chip->ecc.correct(chip, p, &ecc[i], &ecc_calc[i]);
> +		if (stat < 0) {
> +			mtd->ecc_stats.failed++;
> +		} else {
> +			mtd->ecc_stats.corrected += stat;
> +			max_bitflips = max_t(unsigned int, max_bitflips, stat);
> +		}
> +	}
> +
> +	return max_bitflips;
> +}
> +
> +/* NAND framework ->exec_op() hooks and related helpers */
> +static void pl353_nfc_parse_instructions(struct nand_chip *chip,
> +					 const struct nand_subop *subop,
> +					 struct pl353_nfc_op *nfc_op)
> +{
> +	const struct nand_op_instr *instr = NULL;
> +	unsigned int op_id, offset, naddrs;
> +	int i;
> +	const u8 *addrs;
> +
> +	memset(nfc_op, 0, sizeof(struct pl353_nfc_op));
> +	for (op_id = 0; op_id < subop->ninstrs; op_id++) {
> +		instr = &subop->instrs[op_id];
> +
> +		switch (instr->type) {
> +		case NAND_OP_CMD_INSTR:
> +			if (op_id)
> +				nfc_op->cmnds[1] = instr->ctx.cmd.opcode;
> +			else
> +				nfc_op->cmnds[0] = instr->ctx.cmd.opcode;
> +			nfc_op->cle_ale_delay_ns = instr->delay_ns;
> +			break;
> +
> +		case NAND_OP_ADDR_INSTR:
> +			offset = nand_subop_get_addr_start_off(subop, op_id);
> +			naddrs = nand_subop_get_num_addr_cyc(subop, op_id);
> +			addrs = &instr->ctx.addr.addrs[offset];
> +			nfc_op->addrs = instr->ctx.addr.addrs[offset];
> +			for (i = 0; i < min_t(unsigned int, 4, naddrs); i++) {
> +				nfc_op->addrs |= instr->ctx.addr.addrs[i] <<

I don't quite understand what this code does, but it looks strange to
me. I compared it to other drivers. The code here is quite similar to
marvell_nand.c. It seems like we are copying a varying number (0 to 6)
of addresses from the buffer instr->ctx.addr.addrs. However their
indices are special: 0, 1, 2, 3, offset + 4, offset + 5. This is
non-consecutive and different from marvell_nand.c in this regard. Could
it be that you really meant index offset+i here?

> +						 (8 * i);
> +			}
> +
> +			if (naddrs >= 5)
> +				nfc_op->addr5 = addrs[4];
> +			if (naddrs >= 6)
> +				nfc_op->addr6 = addrs[5];
> +			nfc_op->naddrs = nand_subop_get_num_addr_cyc(subop,
> +								     op_id);
> +			nfc_op->cle_ale_delay_ns = instr->delay_ns;
> +			break;
> +
> +		case NAND_OP_DATA_IN_INSTR:
> +			nfc_op->data_instr = instr;
> +			nfc_op->data_instr_idx = op_id;
> +			break;
> +
> +		case NAND_OP_DATA_OUT_INSTR:
> +			nfc_op->data_instr = instr;
> +			nfc_op->data_instr_idx = op_id;
> +			break;
> +
> +		case NAND_OP_WAITRDY_INSTR:
> +			nfc_op->rdy_timeout_ms = instr->ctx.waitrdy.timeout_ms;
> +			nfc_op->rdy_delay_ns = instr->delay_ns;
> +			break;
> +		}
> +	}
> +}
> +
> +static void cond_delay(unsigned int ns)
> +{
> +	if (!ns)
> +		return;
> +
> +	if (ns < 10000)
> +		ndelay(ns);
> +	else
> +		udelay(DIV_ROUND_UP(ns, 1000));
> +}

This function has an exact copy in marvell_nand.c. Would it make sense
to move it to a more central place? There are only two copies yet.

Note that on arm (the primary target of this driver), ndelay is
implemented using udelay.

> +/**
> + * pl353_nand_exec_op_cmd - Send command to NAND device
> + * @chip:	Pointer to the NAND chip info structure
> + * @subop:	Pointer to array of instructions
> + * Return:	Always return zero
> + */
> +static int pl353_nand_exec_op_cmd(struct nand_chip *chip,
> +				  const struct nand_subop *subop)
> +{
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +	const struct nand_op_instr *instr;
> +	struct pl353_nfc_op nfc_op = {};
> +	struct pl353_nand_controller *xnfc = to_pl353_nand(chip);
> +	unsigned long cmd_phase_data = 0, end_cmd_valid = 0;
> +	unsigned long cmd_phase_addr, data_phase_addr, end_cmd;
> +	unsigned int op_id, len;
> +	bool reading;
> +
> +	pl353_nfc_parse_instructions(chip, subop, &nfc_op);
> +	instr = nfc_op.data_instr;
> +	op_id = nfc_op.data_instr_idx;
> +
> +	pl353_smc_clr_nand_int();
> +	/* Get the command phase address */
> +	if (nfc_op.cmnds[1] != 0) {
> +		if (nfc_op.cmnds[0] == NAND_CMD_SEQIN)
> +			end_cmd_valid = 0;
> +		else
> +			end_cmd_valid = 1;
> +		end_cmd = nfc_op.cmnds[1];
> +	}  else {
> +		end_cmd = 0x0;

In this branch, nfc_op.cmnds[1] == 0, so end_cmd is always
nfc_op.cmnds[1]. Would it make sense to pull the assignment out of the
branch?

> +	}
> +
> +	/*
> +	 * The SMC defines two phases of commands when transferring data to or
> +	 * from NAND flash.
> +	 * Command phase: Commands and optional address information are written
> +	 * to the NAND flash.The command and address can be associated with
> +	 * either a data phase operation to write to or read from the array,
> +	 * or a status/ID register transfer.
> +	 * Data phase: Data is either written to or read from the NAND flash.
> +	 * This data can be either data transferred to or from the array,
> +	 * or status/ID register information.
> +	 */
> +	cmd_phase_addr = (unsigned long __force)xnfc->regs +
> +			 ((nfc_op.naddrs << ADDR_CYCLES_SHIFT) |
> +			 (end_cmd_valid << END_CMD_VALID_SHIFT) |
> +			 (COMMAND_PHASE) |
> +			 (end_cmd << END_CMD_SHIFT) |
> +			 (nfc_op.cmnds[0] << START_CMD_SHIFT));
> +
> +	/* Get the data phase address */
> +	end_cmd_valid = 0;
> +
> +	data_phase_addr = (unsigned long __force)xnfc->regs +
> +			  ((0x0 << CLEAR_CS_SHIFT) |
> +			  (end_cmd_valid << END_CMD_VALID_SHIFT) |
> +			  (DATA_PHASE) |
> +			  (end_cmd << END_CMD_SHIFT) |
> +			  (0x0 << ECC_LAST_SHIFT));
> +	xnfc->buf_addr = (void __iomem * __force)data_phase_addr;
> +
> +	/* Command phase AXI Read & Write */
> +	if (nfc_op.naddrs >= 5) {
> +		if (mtd->writesize > PL353_NAND_ECC_SIZE) {
> +			cmd_phase_data = nfc_op.addrs;
> +			/* Another address cycle for devices > 128MiB */
> +			if (chip->options & NAND_ROW_ADDR_3) {
> +				writel_relaxed(cmd_phase_data,
> +					       (void __iomem * __force)
> +					       cmd_phase_addr);
> +				cmd_phase_data = nfc_op.addr5;
> +				if (nfc_op.naddrs >= 6)
> +					cmd_phase_data |= (nfc_op.addr6 << 8);
> +			}
> +		}
> +	}  else {
> +		if (nfc_op.addrs != -1) {
> +			int column = nfc_op.addrs;
> +			/*
> +			 * Change read/write column, read id etc
> +			 * Adjust columns for 16 bit bus width
> +			 */
> +			if ((chip->options & NAND_BUSWIDTH_16) &&
> +			    (nfc_op.cmnds[0] == NAND_CMD_READ0 ||
> +				nfc_op.cmnds[0] == NAND_CMD_SEQIN ||
> +				nfc_op.cmnds[0] == NAND_CMD_RNDOUT ||
> +				nfc_op.cmnds[0] == NAND_CMD_RNDIN)) {
> +				column >>= 1;
> +			}
> +			cmd_phase_data = column;
> +		}
> +	}
> +
> +	writel_relaxed(cmd_phase_data, (void __iomem * __force)cmd_phase_addr);
> +	if (!nfc_op.data_instr) {
> +		if (nfc_op.rdy_timeout_ms) {
> +			if (pl353_wait_for_dev_ready(chip))
> +				return -ETIMEDOUT;
> +		}
> +
> +		return 0;
> +	}
> +
> +	reading = (nfc_op.data_instr->type == NAND_OP_DATA_IN_INSTR);
> +	if (!reading) {
> +		len = nand_subop_get_data_len(subop, op_id);
> +		pl353_nand_write_data_op(chip, instr->ctx.data.buf.out,
> +					 len, instr->ctx.data.force_8bit);
> +		if (nfc_op.rdy_timeout_ms) {
> +			if (pl353_wait_for_dev_ready(chip))
> +				return -ETIMEDOUT;
> +		}
> +
> +		cond_delay(nfc_op.rdy_delay_ns);
> +	}
> +
> +	if (reading) {

You could use an else branch instead of inverting the condition here.
When Miquel complained about this in v13, you said you'd change it,
but you didn't.

> +		len = nand_subop_get_data_len(subop, op_id);
> +		cond_delay(nfc_op.rdy_delay_ns);
> +		if (nfc_op.rdy_timeout_ms) {
> +			if (pl353_wait_for_dev_ready(chip))
> +				return -ETIMEDOUT;
> +		}
> +
> +		pl353_nand_read_data_op(chip, instr->ctx.data.buf.in, len,
> +					instr->ctx.data.force_8bit);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct nand_op_parser pl353_nfc_op_parser = NAND_OP_PARSER
> +	(NAND_OP_PARSER_PATTERN
> +		(pl353_nand_exec_op_cmd,
> +		NAND_OP_PARSER_PAT_CMD_ELEM(true),
> +		NAND_OP_PARSER_PAT_ADDR_ELEM(true, 7),
> +		NAND_OP_PARSER_PAT_WAITRDY_ELEM(true),
> +		NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, 2048)),
> +	NAND_OP_PARSER_PATTERN
> +		(pl353_nand_exec_op_cmd,
> +		NAND_OP_PARSER_PAT_CMD_ELEM(false),
> +		NAND_OP_PARSER_PAT_ADDR_ELEM(false, 7),
> +		NAND_OP_PARSER_PAT_CMD_ELEM(false),
> +		NAND_OP_PARSER_PAT_WAITRDY_ELEM(false),
> +		NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, 2048)),
> +	NAND_OP_PARSER_PATTERN
> +		(pl353_nand_exec_op_cmd,
> +		NAND_OP_PARSER_PAT_CMD_ELEM(false),
> +		NAND_OP_PARSER_PAT_ADDR_ELEM(true, 7),
> +		NAND_OP_PARSER_PAT_CMD_ELEM(true),
> +		NAND_OP_PARSER_PAT_WAITRDY_ELEM(false)),
> +	NAND_OP_PARSER_PATTERN
> +		(pl353_nand_exec_op_cmd,
> +		NAND_OP_PARSER_PAT_CMD_ELEM(false),
> +		NAND_OP_PARSER_PAT_ADDR_ELEM(false, 8),
> +		NAND_OP_PARSER_PAT_DATA_OUT_ELEM(false, 2048),
> +		NAND_OP_PARSER_PAT_CMD_ELEM(true),
> +		NAND_OP_PARSER_PAT_WAITRDY_ELEM(true)),
> +	NAND_OP_PARSER_PATTERN
> +		(pl353_nand_exec_op_cmd,
> +		NAND_OP_PARSER_PAT_CMD_ELEM(false)),
> +	);
> +
> +static int pl353_nfc_exec_op(struct nand_chip *chip,
> +			     const struct nand_operation *op,
> +			     bool check_only)
> +{
> +	return nand_op_parser_exec_op(chip, &pl353_nfc_op_parser,
> +					      op, check_only);
> +}
> +
> +/**
> + * pl353_nand_ecc_init - Initialize the ecc information as per the ecc mode
> + * @mtd:	Pointer to the mtd_info structure
> + * @ecc:	Pointer to ECC control structure
> + * @ecc_mode:	ondie ecc status
> + *
> + * This function initializes the ecc block and functional pointers as per the
> + * ecc mode
> + *
> + * Return:	0 on success or negative errno.
> + */
> +static int pl353_nand_ecc_init(struct mtd_info *mtd, struct nand_ecc_ctrl *ecc,
> +			       int ecc_mode)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +	struct pl353_nand_controller *xnfc = to_pl353_nand(chip);
> +	int err = 0, ret;

These variables serve the same purpose. Both err and ret determine the
return value of this function. Can you merge them into one variable?

> +
> +	ecc->read_oob = pl353_nand_read_oob;
> +	ecc->write_oob = pl353_nand_write_oob;
> +	if (ecc_mode == NAND_ECC_ON_DIE) {
> +		ecc->write_page_raw = pl353_nand_write_page_raw;
> +		ecc->read_page_raw = pl353_nand_read_page_raw;
> +		/*
> +		 * On-Die ECC spare bytes offset 8 is used for ECC codes
> +		 * Use the BBT pattern descriptors
> +		 */
> +		chip->bbt_td = &bbt_main_descr;
> +		chip->bbt_md = &bbt_mirror_descr;
> +		ret = pl353_smc_set_ecc_mode(PL353_SMC_ECCMODE_BYPASS);
> +		if (ret)
> +			return ret;
> +
> +	} else {
> +		ecc->mode = NAND_ECC_HW;
> +		/* Hardware ECC generates 3 bytes ECC code for each 512 bytes */
> +		ecc->bytes = 3;
> +		ecc->strength = 1;
> +		ecc->calculate = pl353_nand_calculate_hwecc;
> +		ecc->correct = pl353_nand_correct_data;
> +		ecc->read_page = pl353_nand_read_page_hwecc;
> +		ecc->size = PL353_NAND_ECC_SIZE;
> +		ecc->read_page = pl353_nand_read_page_hwecc;
> +		ecc->write_page = pl353_nand_write_page_hwecc;
> +		pl353_smc_set_ecc_pg_size(mtd->writesize);
> +		switch (mtd->writesize) {
> +		case SZ_512:
> +		case SZ_1K:
> +		case SZ_2K:
> +			pl353_smc_set_ecc_mode(PL353_SMC_ECCMODE_APB);
> +			break;
> +		default:
> +			ecc->calculate = nand_calculate_ecc;
> +			ecc->correct = nand_correct_data;
> +			ecc->size = 256;
> +			break;
> +		}
> +
> +		if (mtd->oobsize == 16) {
> +			mtd_set_ooblayout(mtd, &pl353_ecc_ooblayout16_ops);
> +		} else if (mtd->oobsize == 64) {
> +			mtd_set_ooblayout(mtd, &pl353_ecc_ooblayout64_ops);
> +		} else {
> +			err = -ENXIO;
> +			dev_err(xnfc->dev, "Unsupported oob Layout\n");
> +		}
> +	}
> +
> +	return err;
> +}
> +
> +static int pl353_nfc_setup_data_interface(struct nand_chip *chip, int csline,
> +					  const struct nand_data_interface
> +					  *conf)
> +{
> +	struct pl353_nand_controller *xnfc = to_pl353_nand(chip);
> +	const struct nand_sdr_timings *sdr;
> +	u32 timings[7], mckperiodps;
> +
> +	if (csline == NAND_DATA_IFACE_CHECK_ONLY)
> +		return 0;
> +
> +	sdr = nand_get_sdr_timings(conf);
> +	if (IS_ERR(sdr))
> +		return PTR_ERR(sdr);
> +
> +	/*
> +	 * SDR timings are given in pico-seconds while NFC timings must be
> +	 * expressed in NAND controller clock cycles.
> +	 */
> +	mckperiodps = NSEC_PER_SEC / clk_get_rate(xnfc->mclk);
> +	mckperiodps *= 1000;
> +	if (sdr->tRC_min <= 20000)
> +		/*
> +		 * PL353 SMC needs one extra read cycle in SDR Mode 5
> +		 * This is not written anywhere in the datasheet but
> +		 * the results observed during testing.
> +		 */
> +		timings[0] = DIV_ROUND_UP(sdr->tRC_min, mckperiodps) + 1;
> +	else
> +		timings[0] = DIV_ROUND_UP(sdr->tRC_min, mckperiodps);
> +
> +	timings[1] = DIV_ROUND_UP(sdr->tWC_min, mckperiodps);
> +	/*
> +	 * For all SDR modes, PL353 SMC needs tREA max value as 1,
> +	 * Results observed during testing.
> +	 */
> +	timings[2] = PL353_TREA_MAX_VALUE;
> +	timings[3] = DIV_ROUND_UP(sdr->tWP_min, mckperiodps);
> +	timings[4] = DIV_ROUND_UP(sdr->tCLR_min, mckperiodps);
> +	timings[5] = DIV_ROUND_UP(sdr->tAR_min, mckperiodps);
> +	timings[6] = DIV_ROUND_UP(sdr->tRR_min, mckperiodps);
> +	pl353_smc_set_cycles(timings);
> +
> +	return 0;
> +}
> +
> +static int pl353_nand_attach_chip(struct nand_chip *chip)
> +{
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +	struct pl353_nand_controller *xnfc = to_pl353_nand(chip);
> +	int ret;
> +
> +	if (chip->options & NAND_BUSWIDTH_16) {
> +		ret = pl353_smc_set_buswidth(PL353_SMC_MEM_WIDTH_16);
> +		if (ret) {
> +			dev_err(xnfc->dev, "Set BusWidth failed\n");
> +			return ret;
> +		}
> +	}
> +
> +	if (mtd->writesize <= SZ_512)
> +		xnfc->addr_cycles = 1;
> +	else
> +		xnfc->addr_cycles = 2;
> +
> +	if (chip->options & NAND_ROW_ADDR_3)
> +		xnfc->addr_cycles += 3;
> +	else
> +		xnfc->addr_cycles += 2;
> +
> +	ret = pl353_nand_ecc_init(mtd, &chip->ecc, chip->ecc.mode);
> +	if (ret) {
> +		dev_err(xnfc->dev, "ECC init failed\n");
> +		return ret;
> +	}
> +
> +	if (!mtd->name) {
> +		/*
> +		 * If the new bindings are used and the bootloader has not been
> +		 * updated to pass a new mtdparts parameter on the cmdline, you
> +		 * should define the following property in your NAND node, ie:
> +		 *
> +		 *	label = "pl353-nand";
> +		 *
> +		 * This way, mtd->name will be set by the core when
> +		 * nand_set_flash_node() is called.
> +		 */
> +		mtd->name = devm_kasprintf(xnfc->dev, GFP_KERNEL,
> +					   "%s", PL353_NAND_DRIVER_NAME);
> +		if (!mtd->name) {
> +			dev_err(xnfc->dev, "Failed to allocate mtd->name\n");
> +			return -ENOMEM;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct nand_controller_ops pl353_nand_controller_ops = {
> +	.attach_chip = pl353_nand_attach_chip,
> +	.exec_op = pl353_nfc_exec_op,
> +	.setup_data_interface = pl353_nfc_setup_data_interface,
> +};
> +
> +/**
> + * pl353_nand_probe - Probe method for the NAND driver
> + * @pdev:	Pointer to the platform_device structure
> + *
> + * This function initializes the driver data structures and the hardware.
> + * The NAND driver has dependency with the pl353_smc memory controller
> + * driver for initializing the NAND timing parameters, bus width, ECC modes,
> + * control and status information.
> + *
> + * Return:	0 on success or error value on failure
> + */
> +static int pl353_nand_probe(struct platform_device *pdev)
> +{
> +	struct pl353_nand_controller *xnfc;
> +	struct mtd_info *mtd;
> +	struct nand_chip *chip;
> +	struct resource *res;
> +	struct device_node *np, *dn;
> +	u32 ret, val;
> +
> +	xnfc = devm_kzalloc(&pdev->dev, sizeof(*xnfc), GFP_KERNEL);
> +	if (!xnfc)
> +		return -ENOMEM;
> +
> +	xnfc->dev = &pdev->dev;
> +	nand_controller_init(&xnfc->controller);
> +	xnfc->controller.ops = &pl353_nand_controller_ops;
> +	/* Map physical address of NAND flash */
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	xnfc->regs = devm_ioremap_resource(xnfc->dev, res);
> +	if (IS_ERR(xnfc->regs))
> +		return PTR_ERR(xnfc->regs);
> +
> +	chip = &xnfc->chip;
> +	chip->controller = &xnfc->controller;
> +	mtd = nand_to_mtd(chip);
> +	nand_set_controller_data(chip, xnfc);
> +	mtd->priv = chip;
> +	mtd->owner = THIS_MODULE;
> +	nand_set_flash_node(chip, xnfc->dev->of_node);
> +
> +	np = of_get_next_parent(xnfc->dev->of_node);
> +	xnfc->mclk = of_clk_get(np, 0);

I think it would be more robust to look up the clock by name rather than
index to mirror what pl353-smc does:

	xnfc->mclk = of_clk_get_by_name(np, "memclk");

> +	if (IS_ERR(xnfc->mclk)) {
> +		dev_err(xnfc->dev, "Failed to retrieve MCK clk\n");
> +		return PTR_ERR(xnfc->mclk);
> +	}
> +
> +	dn = nand_get_flash_node(chip);
> +	ret = of_property_read_u32(dn, "nand-bus-width", &val);
> +	if (ret)
> +		val = 8;

This val seems to be entirely unused.

> +
> +	/* Set the device option and flash width */
> +	chip->options = NAND_BUSWIDTH_AUTO;
> +	chip->bbt_options = NAND_BBT_USE_FLASH;
> +	platform_set_drvdata(pdev, xnfc);
> +	ret = nand_scan(chip, 1);
> +	if (ret) {
> +		dev_err(xnfc->dev, "could not scan the nand chip\n");
> +		return ret;
> +	}
> +
> +	ret = mtd_device_register(mtd, NULL, 0);
> +	if (ret) {
> +		dev_err(xnfc->dev, "Failed to register mtd device: %d\n", ret);
> +		nand_cleanup(chip);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * pl353_nand_remove - Remove method for the NAND driver
> + * @pdev:	Pointer to the platform_device structure
> + *
> + * This function is called if the driver module is being unloaded. It frees all
> + * resources allocated to the device.
> + *
> + * Return:	0 on success or error value on failure
> + */
> +static int pl353_nand_remove(struct platform_device *pdev)
> +{
> +	struct pl353_nand_controller *xnfc = platform_get_drvdata(pdev);
> +	struct mtd_info *mtd = nand_to_mtd(&xnfc->chip);
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +
> +	/* Release resources, unregister device */
> +	nand_release(chip);
> +
> +	return 0;
> +}
> +
> +/* Match table for device tree binding */
> +static const struct of_device_id pl353_nand_of_match[] = {
> +	{ .compatible = "arm,pl353-nand-r2p1" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, pl353_nand_of_match);
> +
> +/*
> + * pl353_nand_driver - This structure defines the NAND subsystem platform driver
> + */
> +static struct platform_driver pl353_nand_driver = {
> +	.probe		= pl353_nand_probe,
> +	.remove		= pl353_nand_remove,
> +	.driver		= {
> +		.name	= PL353_NAND_DRIVER_NAME,
> +		.of_match_table = pl353_nand_of_match,
> +	},
> +};
> +
> +module_platform_driver(pl353_nand_driver);
> +
> +MODULE_AUTHOR("Xilinx, Inc.");
> +MODULE_ALIAS("platform:" PL353_NAND_DRIVER_NAME);
> +MODULE_DESCRIPTION("ARM PL353 NAND Flash Driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.7.4
> 
