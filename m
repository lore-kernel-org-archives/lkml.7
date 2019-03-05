Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28822C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 18:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B703020645
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 18:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfCESKL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 13:10:11 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:60591 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbfCESKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 13:10:10 -0500
X-Originating-IP: 77.136.16.149
Received: from xps13 (149.16.136.77.rev.sfr.net [77.136.16.149])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 90DEE6000C;
        Tue,  5 Mar 2019 18:09:57 +0000 (UTC)
Date:   Tue, 5 Mar 2019 19:09:54 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Piotr Sroka <piotrs@cadence.com>
Cc:     <linux-kernel@vger.kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        "David Woodhouse" <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Paul Burton <paul.burton@mips.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Stefan Agner <stefan@agner.ch>, <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v2 1/2] mtd: nand: Add Cadence NAND controller driver
Message-ID: <20190305190954.6c38d681@xps13>
In-Reply-To: <20190219161823.22466-1-piotrs@cadence.com>
References: <20190219161406.4340-1-piotrs@cadence.com>
        <20190219161823.22466-1-piotrs@cadence.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Piotr,

Piotr Sroka <piotrs@cadence.com> wrote on Tue, 19 Feb 2019 16:18:23
+0000:

> This patch adds driver for Cadence HPNFC NAND controller.
> 
> Signed-off-by: Piotr Sroka <piotrs@cadence.com>
> ---
> Changes for v2:
> - create one universal wait function for all events instead of one
>   function per event.
> - split one big function executing nand operations to separate
>   functions one per each type of operation.
> - add erase atomic operation to nand operation parser
> - remove unnecessary includes.
> - remove unused register defines 
> - add support for multiple nand chips
> - remove all code using legacy functions
> - remove chip dependents parameters from dts bindings, they were
>   attached to the SoC specific compatible at the driver level
> - simplify interrupt handling
> - simplify timing calculations
> - fix calculation of maximum supported cs signals
> - simplify ecc size calculation
> - remove header file and put whole code to one c file
> ---
>  drivers/mtd/nand/raw/Kconfig                   |    8 +
>  drivers/mtd/nand/raw/Makefile                  |    1 +
>  drivers/mtd/nand/raw/cadence-nand-controller.c | 3288 ++++++++++++++++++++++++

This driver is way too massive, I am pretty sure it can shrink a
little bit more.
[...]

> +
> +struct cdns_nand_chip {
> +	struct cadence_nand_timings timings;
> +	struct nand_chip chip;
> +	u8 nsels;
> +	struct list_head node;
> +
> +	/*
> +	 * part of oob area of NANF flash memory page.
> +	 * This part is available for user to read or write.
> +	 */
> +	u32 avail_oob_size;
> +	/* oob area size of NANF flash memory page */
> +	u32 oob_size;
> +	/* main area size of NANF flash memory page */
> +	u32 main_size;

These fields are redundant and exist in mtd_info/nand_chip.

> +
> +	/* sector size few sectors are located on main area of NF memory page */
> +	u32 sector_size;
> +	u32 sector_count;
> +
> +	/* offset of BBM*/
> +	u8 bbm_offs;
> +	/* number of bytes reserved for BBM */
> +	u8 bbm_len;

Why do you bother at the controller driver level with bbm?

> +	/* ECC strength index */
> +	u8 corr_str_idx;
> +
> +	u8 cs[];
> +};
> +
> +struct ecc_info {
> +	int (*calc_ecc_bytes)(int step_size, int strength);
> +	int max_step_size;
> +};
> +

[...]

> +
> +static int cadence_nand_set_erase_detection(struct cdns_nand_ctrl *cdns_ctrl,
> +					    bool enable,
> +					    u8 bitflips_threshold)

What is this for?

> +{
> +	u32 reg;
> +
> +	if (cadence_nand_wait_for_value(cdns_ctrl, CTRL_STATUS,
> +					1000000,
> +					CTRL_STATUS_CTRL_BUSY, true))
> +		return -ETIMEDOUT;
> +
> +	reg = readl(cdns_ctrl->reg + ECC_CONFIG_0);
> +
> +	if (enable)
> +		reg |= ECC_CONFIG_0_ERASE_DET_EN;
> +	else
> +		reg &= ~ECC_CONFIG_0_ERASE_DET_EN;
> +
> +	writel(reg, cdns_ctrl->reg + ECC_CONFIG_0);
> +	writel(bitflips_threshold, cdns_ctrl->reg + ECC_CONFIG_1);
> +
> +	return 0;
> +}
> +
> +static int cadence_nand_set_access_width16(struct cdns_nand_ctrl *cdns_ctrl,
> +					   bool bit_bus16)
> +{
> +	u32 reg;
> +
> +	if (cadence_nand_wait_for_value(cdns_ctrl, CTRL_STATUS,
> +					1000000,
> +					CTRL_STATUS_CTRL_BUSY, true))
> +		return -ETIMEDOUT;
> +
> +	reg = readl(cdns_ctrl->reg + COMMON_SET);
> +
> +	if (!bit_bus16)
> +		reg &= ~COMMON_SET_DEVICE_16BIT;
> +	else
> +		reg |= COMMON_SET_DEVICE_16BIT;
> +	writel(reg, cdns_ctrl->reg + COMMON_SET);
> +
> +	return 0;
> +}
> +
> +static void
> +cadence_nand_clear_interrupt(struct cdns_nand_ctrl *cdns_ctrl,
> +			     struct cadence_nand_irq_status *irq_status)
> +{
> +	writel(irq_status->status, cdns_ctrl->reg + INTR_STATUS);
> +	writel(irq_status->trd_status, cdns_ctrl->reg + TRD_COMP_INT_STATUS);
> +	writel(irq_status->trd_error, cdns_ctrl->reg + TRD_ERR_INT_STATUS);
> +}
> +
> +static void
> +cadence_nand_read_int_status(struct cdns_nand_ctrl *cdns_ctrl,
> +			     struct cadence_nand_irq_status *irq_status)
> +{
> +	irq_status->status = readl(cdns_ctrl->reg + INTR_STATUS);
> +	irq_status->trd_status = readl(cdns_ctrl->reg
> +					 + TRD_COMP_INT_STATUS);
> +	irq_status->trd_error = readl(cdns_ctrl->reg + TRD_ERR_INT_STATUS);
> +}
> +
> +static u32 irq_detected(struct cdns_nand_ctrl *cdns_ctrl,
> +			struct cadence_nand_irq_status *irq_status)
> +{
> +	cadence_nand_read_int_status(cdns_ctrl, irq_status);
> +
> +	return irq_status->status || irq_status->trd_status ||
> +		irq_status->trd_error;
> +}
> +
> +static void cadence_nand_reset_irq(struct cdns_nand_ctrl *cdns_ctrl)
> +{
> +	spin_lock(&cdns_ctrl->irq_lock);
> +	memset(&cdns_ctrl->irq_status, 0, sizeof(cdns_ctrl->irq_status));
> +	memset(&cdns_ctrl->irq_mask, 0, sizeof(cdns_ctrl->irq_mask));
> +	spin_unlock(&cdns_ctrl->irq_lock);
> +}
> +
> +/*
> + * This is the interrupt service routine. It handles all interrupts
> + * sent to this device.
> + */
> +static irqreturn_t cadence_nand_isr(int irq, void *dev_id)
> +{
> +	struct cdns_nand_ctrl *cdns_ctrl = dev_id;
> +	struct cadence_nand_irq_status irq_status;
> +	irqreturn_t result = IRQ_NONE;
> +
> +	spin_lock(&cdns_ctrl->irq_lock);
> +
> +	if (irq_detected(cdns_ctrl, &irq_status)) {
> +		/* handle interrupt */
> +		/* first acknowledge it */
> +		cadence_nand_clear_interrupt(cdns_ctrl, &irq_status);
> +		/* store the status in the device context for someone to read */
> +		cdns_ctrl->irq_status.status |= irq_status.status;
> +		cdns_ctrl->irq_status.trd_status |= irq_status.trd_status;
> +		cdns_ctrl->irq_status.trd_error |= irq_status.trd_error;
> +		/* notify anyone who cares that it happened */
> +		complete(&cdns_ctrl->complete);
> +		/* tell the OS that we've handled this */
> +		result = IRQ_HANDLED;
> +	}
> +	spin_unlock(&cdns_ctrl->irq_lock);

Missing space

> +	return result;
> +}
> +
> +static void cadence_nand_set_irq_mask(struct cdns_nand_ctrl *cdns_ctrl,
> +				      struct cadence_nand_irq_status *irq_mask)
> +{
> +	writel(INTR_ENABLE_INTR_EN | irq_mask->status,
> +	       cdns_ctrl->reg + INTR_ENABLE);
> +
> +	writel(irq_mask->trd_error, cdns_ctrl->reg + TRD_ERR_INT_STATUS_EN);
> +}
> +

[...]

> +
> +/* hardware initialization */
> +static int cadence_nand_hw_init(struct cdns_nand_ctrl *cdns_ctrl)
> +{
> +	int status = 0;
> +	u32 reg;
> +
> +	status = cadence_nand_wait_for_value(cdns_ctrl, CTRL_STATUS,
> +					     1000000,
> +					     CTRL_STATUS_INIT_COMP, false);
> +	if (status)
> +		return status;
> +
> +	reg = readl(cdns_ctrl->reg + CTRL_VERSION);
> +
> +	dev_info(cdns_ctrl->dev,
> +		 "%s: cadence nand controller version reg %x\n",
> +		 __func__, reg);
> +
> +	/* disable cache and multiplane */
> +	writel(0, cdns_ctrl->reg + MULTIPLANE_CFG);
> +	writel(0, cdns_ctrl->reg + CACHE_CFG);
> +
> +	/* clear all interrupts */
> +	writel(0xFFFFFFFF, cdns_ctrl->reg + INTR_STATUS);
> +
> +	cadence_nand_get_caps(cdns_ctrl);
> +	cadence_nand_read_bch_cfg(cdns_ctrl);

No, you cannot rely on the bootloader's configuration. And I suppose
this is what the first call to read_bch_cfg does?

> +
> +	/*
> +	 * set io width access to 8
> +	 * it is because during SW device dicovering width access
> +	 * is expected to be 8
> +	 */
> +	status = cadence_nand_set_access_width16(cdns_ctrl, false);
> +
> +	return status;
> +}
> +
> +#define TT_OOB_AREA		1
> +#define TT_MAIN_OOB_AREAS	2
> +#define TT_RAW_PAGE		3
> +#define TT_BBM			4
> +#define TT_MAIN_OOB_AREA_EXT	5
> +
> +/* prepare size of data to transfer */
> +static int
> +cadence_nand_prepare_data_size(struct nand_chip *chip,
> +			       int transfer_type)
> +{
> +	struct cdns_nand_ctrl *cdns_ctrl = to_cdns_nand_ctrl(chip->controller);
> +	struct cdns_nand_chip *cdns_chip = to_cdns_nand_chip(chip);
> +	u32 sec_size = 0, last_sec_size, offset = 0, sec_cnt = 1;
> +	u32 ecc_size = chip->ecc.bytes;
> +	u32 data_ctrl_size = 0;
> +	u32 reg = 0;
> +
> +	if (cdns_ctrl->curr_trans_type == transfer_type)
> +		return 0;
> +
> +	switch (transfer_type) {

Please turn the controller driver as dumb as possible. You should not
care which part of the OOB area you are accessing.

> +	case TT_OOB_AREA:
> +		offset = cdns_chip->main_size - cdns_chip->sector_size;
> +		ecc_size = ecc_size * (offset / cdns_chip->sector_size);
> +		offset = offset + ecc_size;
> +		sec_cnt = 1;
> +		last_sec_size = cdns_chip->sector_size
> +			+ cdns_chip->avail_oob_size;
> +		break;
> +	case TT_MAIN_OOB_AREA_EXT:
> +		sec_cnt = cdns_chip->sector_count;
> +		last_sec_size = cdns_chip->sector_size;
> +		sec_size = cdns_chip->sector_size;
> +		data_ctrl_size = cdns_chip->avail_oob_size;
> +		break;
> +	case TT_MAIN_OOB_AREAS:
> +		sec_cnt = cdns_chip->sector_count;
> +		last_sec_size = cdns_chip->sector_size
> +			+ cdns_chip->avail_oob_size;
> +		sec_size = cdns_chip->sector_size;
> +		break;
> +	case TT_RAW_PAGE:
> +		last_sec_size = cdns_chip->main_size + cdns_chip->oob_size;
> +		break;
> +	case TT_BBM:
> +		offset = cdns_chip->main_size + cdns_chip->bbm_offs;
> +		last_sec_size = 8;
> +		break;
> +	default:
> +		dev_err(cdns_ctrl->dev, "Data size preparation failed\n");
> +		return -EINVAL;
> +	}
> +
> +	reg = 0;
> +	reg |= FIELD_PREP(TRAN_CFG_0_OFFSET, offset);
> +	reg |= FIELD_PREP(TRAN_CFG_0_SEC_CNT, sec_cnt);
> +	writel(reg, cdns_ctrl->reg + TRAN_CFG_0);
> +
> +	reg = 0;
> +	reg |= FIELD_PREP(TRAN_CFG_1_LAST_SEC_SIZE, last_sec_size);
> +	reg |= FIELD_PREP(TRAN_CFG_1_SECTOR_SIZE, sec_size);
> +	writel(reg, cdns_ctrl->reg + TRAN_CFG_1);
> +
> +	reg = readl(cdns_ctrl->reg + CONTROL_DATA_CTRL);
> +	reg &= ~CONTROL_DATA_CTRL_SIZE;
> +	reg |= FIELD_PREP(CONTROL_DATA_CTRL_SIZE, data_ctrl_size);
> +	writel(reg, cdns_ctrl->reg + CONTROL_DATA_CTRL);
> +
> +	cdns_ctrl->curr_trans_type = transfer_type;
> +
> +	return 0;
> +}
> +

[...]

> +static int cadence_nand_read_page(struct nand_chip *chip,
> +				  u8 *buf, int oob_required, int page)
> +{
> +	struct cdns_nand_ctrl *cdns_ctrl = to_cdns_nand_ctrl(chip->controller);
> +	struct cdns_nand_chip *cdns_chip = to_cdns_nand_chip(chip);
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +	int status = 0;
> +	int ecc_err_count = 0;
> +
> +	status = cadence_nand_select_target(chip);
> +	if (status)
> +		return status;
> +
> +	cadence_nand_set_skip_bytes_conf(cdns_ctrl, cdns_chip->bbm_len,
> +					 cdns_chip->main_size
> +					 + cdns_chip->bbm_offs, 1);
> +
> +	/* if data buffer is can be accessed by DMA and data_control feature
> +	 * is supported then transfer data and oob directly
> +	 */

No net-style comments please.

> +	if (cadence_nand_dma_buf_ok(cdns_ctrl, buf, cdns_chip->main_size) &&
> +	    cdns_ctrl->caps2.data_control_supp) {
> +		u8 *oob;
> +
> +		if (oob_required)
> +			oob = chip->oob_poi;
> +		else
> +			oob = cdns_ctrl->buf + cdns_chip->main_size;
> +
> +		cadence_nand_prepare_data_size(chip, TT_MAIN_OOB_AREA_EXT);
> +		status = cadence_nand_cdma_transfer(cdns_ctrl,
> +						    cdns_chip->cs[chip->cur_cs],
> +						    page, buf, oob,
> +						    cdns_chip->main_size,
> +						    cdns_chip->avail_oob_size,
> +						    DMA_FROM_DEVICE, true);
> +	/* otherwise use bounce buffer */
> +	} else {
> +		cadence_nand_prepare_data_size(chip, TT_MAIN_OOB_AREAS);
> +		status = cadence_nand_cdma_transfer(cdns_ctrl,
> +						    cdns_chip->cs[chip->cur_cs],
> +						    page, cdns_ctrl->buf,
> +						    NULL, cdns_chip->main_size
> +						    + cdns_chip->avail_oob_size,
> +						    0, DMA_FROM_DEVICE, true);
> +
> +		memcpy(buf, cdns_ctrl->buf, cdns_chip->main_size);
> +		if (oob_required)
> +			memcpy(chip->oob_poi,
> +			       cdns_ctrl->buf + cdns_chip->main_size,
> +			       cdns_chip->oob_size);
> +	}
> +
> +	switch (status) {
> +	case STAT_ECC_UNCORR:
> +		mtd->ecc_stats.failed++;
> +		ecc_err_count++;
> +		break;
> +	case STAT_ECC_CORR:
> +		ecc_err_count = FIELD_GET(CDMA_CS_MAXERR,
> +					  cdns_ctrl->cdma_desc->status);
> +		mtd->ecc_stats.corrected += ecc_err_count;
> +		break;
> +	case STAT_ERASED:
> +	case STAT_OK:
> +		break;
> +	default:
> +		dev_err(cdns_ctrl->dev, "read page failed\n");
> +		return -EIO;
> +	}
> +
> +	if (oob_required)
> +		if (cadence_nand_read_bbm(chip, page, chip->oob_poi))
> +			return -EIO;
> +
> +	return ecc_err_count;
> +}
> +
> +static int cadence_nand_read_page_raw(struct nand_chip *chip,
> +				      u8 *buf, int oob_required, int page)
> +{
> +	struct cdns_nand_ctrl *cdns_ctrl = to_cdns_nand_ctrl(chip->controller);
> +	struct cdns_nand_chip *cdns_chip = to_cdns_nand_chip(chip);
> +	int oob_skip = cdns_chip->bbm_len;

Why do you skip the BBM?

In any of the read_page/oob helpers I don't think this is relevant at
all.

> +	int writesize = cdns_chip->main_size;
> +	int ecc_steps = chip->ecc.steps;
> +	int ecc_size = chip->ecc.size;
> +	int ecc_bytes = chip->ecc.bytes;
> +	void *tmp_buf = cdns_ctrl->buf;
> +	int i, pos, len;
> +	int status = 0;
> +
> +	status = cadence_nand_select_target(chip);
> +	if (status)
> +		return status;
> +
> +	cadence_nand_set_skip_bytes_conf(cdns_ctrl, 0, 0, 0);
> +
> +	cadence_nand_prepare_data_size(chip, TT_RAW_PAGE);
> +	status = cadence_nand_cdma_transfer(cdns_ctrl,
> +					    cdns_chip->cs[chip->cur_cs],
> +					    page, cdns_ctrl->buf,
> +					    NULL,
> +					    cdns_chip->main_size
> +					    + cdns_chip->oob_size,
> +					    0, DMA_FROM_DEVICE, false);
> +
> +	switch (status) {
> +	case STAT_ERASED:
> +	case STAT_OK:
> +		break;
> +	default:
> +		dev_err(cdns_ctrl->dev, "read raw page failed\n");
> +		return -EIO;
> +	}
> +
> +	/* Arrange the buffer for syndrome payload/ecc layout */
> +	if (buf) {
> +		for (i = 0; i < ecc_steps; i++) {
> +			pos = i * (ecc_size + ecc_bytes);
> +			len = ecc_size;
> +
> +			if (pos >= writesize)
> +				pos += oob_skip;
> +			else if (pos + len > writesize)
> +				len = writesize - pos;
> +
> +			memcpy(buf, tmp_buf + pos, len);
> +			buf += len;
> +			if (len < ecc_size) {
> +				len = ecc_size - len;
> +				memcpy(buf, tmp_buf + writesize + oob_skip,
> +				       len);
> +				buf += len;
> +			}
> +		}
> +	}
> +
> +	if (oob_required) {
> +		u8 *oob = chip->oob_poi;
> +		u32 oob_data_offset = (cdns_chip->sector_count - 1) *
> +			(cdns_chip->sector_size + chip->ecc.bytes)
> +			+ cdns_chip->sector_size + oob_skip;
> +
> +		/* OOB free */
> +		memcpy(oob, tmp_buf + oob_data_offset,
> +		       cdns_chip->avail_oob_size);
> +
> +		/* BBM at the beginning of the OOB area */
> +		memcpy(oob, tmp_buf + writesize, oob_skip);
> +
> +		oob += cdns_chip->avail_oob_size;
> +
> +		/* OOB ECC */
> +		for (i = 0; i < ecc_steps; i++) {
> +			pos = ecc_size + i * (ecc_size + ecc_bytes);
> +			len = ecc_bytes;
> +
> +			if (i == (ecc_steps - 1))
> +				pos += cdns_chip->avail_oob_size;
> +
> +			if (pos >= writesize)
> +				pos += oob_skip;
> +			else if (pos + len > writesize)
> +				len = writesize - pos;
> +
> +			memcpy(oob, tmp_buf + pos, len);
> +			oob += len;
> +			if (len < ecc_bytes) {
> +				len = ecc_bytes - len;
> +				memcpy(oob, tmp_buf + writesize + oob_skip,
> +				       len);
> +				oob += len;
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int cadence_nand_read_oob_raw(struct nand_chip *chip,
> +				     int page)
> +{
> +	return cadence_nand_read_page_raw(chip, NULL, true, page);
> +}
> +
> +static void cadence_nand_slave_dma_transfer_finished(void *data)
> +{
> +	struct completion *finished = data;
> +
> +	complete(finished);
> +}
> +
> +static int cadence_nand_slave_dma_transfer(struct cdns_nand_ctrl *cdns_ctrl,
> +					   void *buf,
> +					   dma_addr_t dev_dma, size_t len,
> +					   enum dma_data_direction dir)
> +{
> +	DECLARE_COMPLETION_ONSTACK(finished);
> +	struct dma_chan *chan;
> +	struct dma_device *dma_dev;
> +	dma_addr_t src_dma, dst_dma, buf_dma;
> +	struct dma_async_tx_descriptor *tx;
> +	dma_cookie_t cookie;
> +
> +	chan = cdns_ctrl->dmac;
> +	dma_dev = chan->device;
> +
> +	buf_dma = dma_map_single(dma_dev->dev, buf, len, dir);
> +	if (dma_mapping_error(dma_dev->dev, buf_dma)) {
> +		dev_err(cdns_ctrl->dev, "Failed to map DMA buffer\n");
> +		goto err;
> +	}
> +
> +	if (dir == DMA_FROM_DEVICE) {
> +		src_dma = cdns_ctrl->io.dma;
> +		dst_dma = buf_dma;
> +	} else {
> +		src_dma = buf_dma;
> +		dst_dma = cdns_ctrl->io.dma;
> +	}
> +
> +	tx = dmaengine_prep_dma_memcpy(cdns_ctrl->dmac, dst_dma, src_dma, len,
> +				       DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
> +	if (!tx) {
> +		dev_err(cdns_ctrl->dev, "Failed to prepare DMA memcpy\n");
> +		goto err_unmap;
> +	}
> +
> +	tx->callback = cadence_nand_slave_dma_transfer_finished;
> +	tx->callback_param = &finished;
> +
> +	cookie = dmaengine_submit(tx);
> +	if (dma_submit_error(cookie)) {
> +		dev_err(cdns_ctrl->dev, "Failed to do DMA tx_submit\n");
> +		goto err_unmap;
> +	}
> +
> +	dma_async_issue_pending(cdns_ctrl->dmac);
> +	wait_for_completion(&finished);
> +
> +	dma_unmap_single(cdns_ctrl->dev, buf_dma, len, dir);
> +
> +	return 0;
> +
> +err_unmap:
> +	dma_unmap_single(cdns_ctrl->dev, buf_dma, len, dir);
> +
> +err:
> +	dev_dbg(cdns_ctrl->dev, "Fall back to CPU I/O\n");
> +
> +	return -EIO;
> +}
> +
> +static int cadence_nand_read_buf(struct cdns_nand_ctrl *cdns_ctrl,
> +static int cadence_nand_write_buf(struct cdns_nand_ctrl *cdns_ctrl,
> +static int cadence_nand_cmd_opcode(struct nand_chip *chip,
> +static int cadence_nand_cmd_address(struct nand_chip *chip,
> +static int cadence_nand_cmd_erase(struct nand_chip *chip,
> +static int cadence_nand_cmd_data(struct nand_chip *chip,

This looks pretty familiar with the legacy approach, I think you just
renamed some functions instead of trying to fit the ->exec_op interface
and there is probably a lot to do on this side that would reduce the
driver size. There are plenty of operations done by each of the above
helpers that should probably factored out.

> +
> +static const struct nand_op_parser cadence_nand_op_parser = NAND_OP_PARSER(
> +	NAND_OP_PARSER_PATTERN(
> +		cadence_nand_cmd_erase,
> +		NAND_OP_PARSER_PAT_CMD_ELEM(false),
> +		NAND_OP_PARSER_PAT_ADDR_ELEM(false, MAX_ERASE_ADDRESS_CYC),
> +		NAND_OP_PARSER_PAT_CMD_ELEM(false),
> +		NAND_OP_PARSER_PAT_WAITRDY_ELEM(false)),
> +	NAND_OP_PARSER_PATTERN(
> +		cadence_nand_cmd_opcode,
> +		NAND_OP_PARSER_PAT_CMD_ELEM(false)),
> +	NAND_OP_PARSER_PATTERN(
> +		cadence_nand_cmd_address,
> +		NAND_OP_PARSER_PAT_ADDR_ELEM(false, MAX_ADDRESS_CYC)),
> +	NAND_OP_PARSER_PATTERN(
> +		cadence_nand_cmd_data,
> +		NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, MAX_DATA_SIZE)),
> +	NAND_OP_PARSER_PATTERN(
> +		cadence_nand_cmd_data,
> +		NAND_OP_PARSER_PAT_DATA_OUT_ELEM(false, MAX_DATA_SIZE)),
> +	NAND_OP_PARSER_PATTERN(
> +		cadence_nand_cmd_waitrdy,
> +		NAND_OP_PARSER_PAT_WAITRDY_ELEM(false))
> +	);
> +
> +static int cadence_nand_exec_op(struct nand_chip *chip,
> +				const struct nand_operation *op,
> +				bool check_only)
> +{
> +	int status = cadence_nand_select_target(chip);
> +
> +	if (status)
> +		return status;
> +
> +	return nand_op_parser_exec_op(chip, &cadence_nand_op_parser, op,
> +				      check_only);
> +}
> +
> +static int cadence_nand_ooblayout_free(struct mtd_info *mtd, int section,
> +				       struct mtd_oob_region *oobregion)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +	struct cdns_nand_chip *cdns_chip = to_cdns_nand_chip(chip);
> +
> +	if (section)
> +		return -ERANGE;
> +
> +	oobregion->offset = cdns_chip->bbm_len;
> +	oobregion->length = cdns_chip->avail_oob_size
> +		- cdns_chip->bbm_len;
> +
> +	return 0;
> +}
> +
> +static int cadence_nand_ooblayout_ecc(struct mtd_info *mtd, int section,
> +				      struct mtd_oob_region *oobregion)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +	struct cdns_nand_chip *cdns_chip = to_cdns_nand_chip(chip);
> +
> +	if (section)
> +		return -ERANGE;
> +
> +	oobregion->offset = cdns_chip->avail_oob_size;
> +	oobregion->length = chip->ecc.total;
> +
> +	return 0;
> +}
> +
> +static const struct mtd_ooblayout_ops cadence_nand_ooblayout_ops = {
> +	.free = cadence_nand_ooblayout_free,
> +	.ecc = cadence_nand_ooblayout_ecc,
> +};
> +
> +static int calc_cycl(u32 timing, u32 clock)
> +{
> +	if (timing == 0 || clock == 0)
> +		return 0;
> +
> +	if ((timing % clock) > 0)
> +		return timing / clock;
> +	else
> +		return timing / clock - 1;
> +}
> +
> +static int
> +cadence_nand_setup_data_interface(struct nand_chip *chip, int chipnr,
> +				  const struct nand_data_interface *conf)
> +{
> +	const struct nand_sdr_timings *sdr;
> +	struct cdns_nand_ctrl *cdns_ctrl = to_cdns_nand_ctrl(chip->controller);
> +	struct cdns_nand_chip *cdns_chip = to_cdns_nand_chip(chip);
> +	struct cadence_nand_timings *t = &cdns_chip->timings;
> +	u32 reg;
> +	u32 board_delay = cdns_ctrl->board_delay;
> +	u32 clk_period = DIV_ROUND_DOWN_ULL(1000000000000ULL,
> +						cdns_ctrl->nf_clk_rate);
> +	u32 nand2_delay = cdns_ctrl->caps1->nand2_delay;
> +	u32 tceh_cnt, tcs_cnt, tadl_cnt, tccs_cnt, tcdqsh = 0;
> +	u32 tcdqss = 0, tckwr = 0, tcr_cnt, tcr = 0, tcres = 0;
> +	u32 tfeat_cnt, tpre = 0, trhz_cnt, trpst = 0, tvdly = 0;
> +	u32 tpsth = 0, trhw_cnt, twb_cnt, twh_cnt = 0, twhr_cnt;
> +	u32 twpst = 0, twrck = 0, tcals = 0, tcwaw = 0, twp_cnt = 0;
> +	u32 if_skew = cdns_ctrl->caps1->if_skew;
> +	u32 board_delay_with_skew_min = board_delay - if_skew;
> +	u32 board_delay_with_skew_max = board_delay + if_skew;
> +	u32 dqs_sampl_res;
> +	u32 phony_dqs_mod;
> +	u32 phony_dqs_comb_delay;
> +	u32 trp_cnt = 0, trh_cnt = 0;
> +	u32 tdvw, tdvw_min, tdvw_max;
> +	u32 extended_read_mode;
> +	u32 extended_wr_mode;
> +	u32 dll_phy_dqs_timing = 0, phony_dqs_timing = 0, rd_del_sel = 0;
> +	u32 tcwaw_cnt;
> +	u32 tvdly_cnt;
> +	u8 x;
> +
> +	sdr = nand_get_sdr_timings(conf);
> +	if (IS_ERR(sdr))
> +		return PTR_ERR(sdr);
> +
> +	memset(t, 0, sizeof(*t));
> +	//------------------------------------------------------------------
> +	// sampling point calculation
> +	//------------------------------------------------------------------

There are quite a few comments like this that should be just like:

        /* Comment */

> +	if (cdns_ctrl->caps2.is_phy_type_dll) {
> +		dqs_sampl_res = clk_period / 2;
> +		phony_dqs_mod = 2;//for DLL phy
> +
> +		phony_dqs_comb_delay = 4 * nand2_delay;
> +		if (cdns_ctrl->caps1->phy_dll_aging)
> +			phony_dqs_comb_delay += nand2_delay;
> +		if (cdns_ctrl->caps1->phy_per_bit_deskew)
> +			phony_dqs_comb_delay += nand2_delay;
> +
> +	} else {
> +		dqs_sampl_res = clk_period;//for async phy
> +		phony_dqs_mod = 1;//for async phy

Same for these comments, they are not compliant with the Linux kernel
coding style.

> +		phony_dqs_comb_delay = 0;
> +	}
> +
> +	tdvw_min = sdr->tREA_max + board_delay_with_skew_max
> +		+ phony_dqs_comb_delay;
> +	/*
> +	 * the idea of those calculation is to get the optimum value
> +	 * for tRP and tRH timings if it is NOT possible to sample data
> +	 * with optimal tRP/tRH settings the parameters will be extended
> +	 */
> +	if (sdr->tRC_min <= clk_period &&
> +	    sdr->tRP_min <= (clk_period / 2) &&
> +	    sdr->tREH_min <= (clk_period / 2)) {

Will this situation really happen?

> +		//performance mode
> +		tdvw = sdr->tRHOH_min + clk_period / 2 - sdr->tREA_max;
> +		tdvw_max = clk_period / 2 + sdr->tRHOH_min
> +			+ board_delay_with_skew_min - phony_dqs_comb_delay;
> +		/*
> +		 * check if data valid window and sampling point can be found
> +		 * and is not on the edge (ie. we have hold margin)
> +		 * if not extend the tRP timings
> +		 */
> +		if (tdvw > 0) {
> +			if (tdvw_max > tdvw_min &&
> +			    (tdvw_max % dqs_sampl_res) > 0) {
> +				/*
> +				 * there is valid sampling point so
> +				 * extended mode is allowed
> +				 */
> +				extended_read_mode = 0;
> +			} else {
> +				/*
> +				 * no valid sampling point so the RE pulse
> +				 * need to be widen widening by half clock
> +				 * cycle should be sufficient
> +				 * to find sampling point
> +				 */
> +				extended_read_mode = 1;
> +				tdvw_max = clk_period + sdr->tRHOH_min
> +					+ board_delay_with_skew_min
> +					- phony_dqs_comb_delay;
> +			}
> +		} else {
> +			/*
> +			 * there is no valid window
> +			 * to be able to sample data the tRP need to be widen
> +			 * very safe calculations are performed here
> +			 */
> +			trp_cnt = (sdr->tREA_max + board_delay_with_skew_max
> +				   + dqs_sampl_res) / clk_period;
> +			extended_read_mode = 1;
> +			tdvw_max = (trp_cnt + 1) * clk_period
> +				+ sdr->tRHOH_min
> +				+ board_delay_with_skew_min
> +				- phony_dqs_comb_delay;
> +		}
> +
> +	} else {
> +		//extended read mode
> +		extended_read_mode = 1;
> +		trp_cnt = calc_cycl(sdr->tRP_min, clk_period);
> +		if (sdr->tREH_min >= (sdr->tRC_min - ((trp_cnt + 1)
> +						      * clk_period))) {
> +			trh_cnt = calc_cycl(sdr->tREH_min, clk_period);
> +		} else {
> +			trh_cnt = calc_cycl(sdr->tRC_min
> +					    - ((trp_cnt + 1)
> +					       * clk_period),
> +					    clk_period);
> +		}
> +
> +		tdvw = sdr->tRHOH_min + ((trp_cnt + 1) * clk_period)
> +			- sdr->tREA_max;
> +		/*
> +		 * check if data valid window and sampling point can be found
> +		 * or if it is at the edge check if previous is valid
> +		 * - if not extend the tRP timings
> +		 */
> +		if (tdvw > 0) {
> +			tdvw_max = (trp_cnt + 1) * clk_period
> +				+ sdr->tRHOH_min
> +				+ board_delay_with_skew_min
> +				- phony_dqs_comb_delay;
> +
> +			if ((((tdvw_max / dqs_sampl_res)
> +			      * dqs_sampl_res) <= tdvw_min) ||
> +			    (((tdvw_max % dqs_sampl_res) == 0) &&
> +			     (((tdvw_max / dqs_sampl_res - 1)
> +			       * dqs_sampl_res) <= tdvw_min))) {
> +				/*
> +				 * data valid window width is lower than
> +				 * sampling resolution and do not hit any
> +				 * sampling point to be sure the sampling point
> +				 * will be found the RE low pulse width will be
> +				 *  extended by one clock cycle
> +				 */
> +				trp_cnt = trp_cnt + 1;
> +			}
> +		} else {
> +			/*
> +			 * there is no valid window
> +			 * to be able to sample data the tRP need to be widen
> +			 * very safe calculations are performed here
> +			 */
> +			trp_cnt = (sdr->tREA_max + board_delay_with_skew_max
> +				   + dqs_sampl_res) / clk_period;
> +		}
> +		tdvw_max = (trp_cnt + 1) * clk_period
> +			+ sdr->tRHOH_min + board_delay_with_skew_min
> +			- phony_dqs_comb_delay;
> +	}
> +
> +	if (cdns_ctrl->caps2.is_phy_type_dll) {

Is the else part allowed?

> +		u32 tpre_cnt = calc_cycl(tpre, clk_period);
> +		u32 tcdqss_cnt = calc_cycl(tcdqss + if_skew, clk_period);
> +		u32 tpsth_cnt = calc_cycl(tpsth + if_skew, clk_period);
> +
> +		u32 trpst_cnt = calc_cycl(trpst + if_skew, clk_period) + 1;
> +		u32 twpst_cnt = calc_cycl(twpst + if_skew, clk_period) + 1;
> +		u32 tcres_cnt = calc_cycl(tcres + if_skew, clk_period) + 1;
> +		u32 tcdqsh_cnt = calc_cycl(tcdqsh + if_skew, clk_period) + 5;
> +
> +		tcr_cnt = calc_cycl(tcr + if_skew, clk_period);
> +		/*
> +		 * skew not included because this timing defines duration of
> +		 * RE or DQS before data transfer
> +		 */
> +		tpsth_cnt = tpsth_cnt + 1;
> +		reg = FIELD_PREP(TOGGLE_TIMINGS0_TPSTH, tpsth_cnt);
> +		reg |= FIELD_PREP(TOGGLE_TIMINGS0_TCDQSS, tcdqss_cnt);
> +		reg |= FIELD_PREP(TOGGLE_TIMINGS0_TPRE, tpre_cnt);
> +		reg |= FIELD_PREP(TOGGLE_TIMINGS0_TCR, tcr_cnt);
> +		t->toggle_timings_0 = reg;
> +		dev_dbg(cdns_ctrl->dev, "TOGGLE_TIMINGS_0_SDR\t%x\n", reg);
> +
> +		//toggle_timings_1 - tRPST,tWPST
> +		reg = FIELD_PREP(TOGGLE_TIMINGS1_TCDQSH, tcdqsh_cnt);
> +		reg |= FIELD_PREP(TOGGLE_TIMINGS1_TCRES, tcres_cnt);
> +		reg |= FIELD_PREP(TOGGLE_TIMINGS1_TRPST, trpst_cnt);
> +		reg |= FIELD_PREP(TOGGLE_TIMINGS1_TWPST, twpst_cnt);
> +		t->toggle_timings_1 = reg;
> +		dev_dbg(cdns_ctrl->dev, "TOGGLE_TIMINGS_1_SDR\t%x\n", reg);
> +	}
> +
> +	if (sdr->tWC_min <= clk_period &&
> +	    (sdr->tWP_min + if_skew) <= (clk_period / 2) &&
> +	    (sdr->tWH_min + if_skew) <= (clk_period / 2)) {
> +		extended_wr_mode = 0;
> +	} else {
> +		extended_wr_mode = 1;
> +		twp_cnt = calc_cycl(sdr->tWP_min + if_skew, clk_period);
> +		if ((twp_cnt + 1) * clk_period < (tcals + if_skew))
> +			twp_cnt = calc_cycl(tcals + if_skew, clk_period);
> +
> +		if (sdr->tWH_min >= (sdr->tWC_min - ((twp_cnt + 1)
> +						     * clk_period))) {
> +			twh_cnt = calc_cycl(sdr->tWH_min + if_skew,
> +					    clk_period);
> +		} else {
> +			twh_cnt = calc_cycl((sdr->tWC_min
> +					     - (twp_cnt + 1) * clk_period)
> +					    + if_skew, clk_period);
> +		}
> +	}
> +
> +	reg = FIELD_PREP(ASYNC_TOGGLE_TIMINGS_TRH, trh_cnt);
> +	reg |= FIELD_PREP(ASYNC_TOGGLE_TIMINGS_TRP, trp_cnt);
> +	reg |= FIELD_PREP(ASYNC_TOGGLE_TIMINGS_TWH, twh_cnt);
> +	reg |= FIELD_PREP(ASYNC_TOGGLE_TIMINGS_TWP, twp_cnt);
> +	t->async_toggle_timings = reg;
> +	dev_dbg(cdns_ctrl->dev, "ASYNC_TOGGLE_TIMINGS_SDR\t%x\n", reg);
> +
> +	if (cdns_ctrl->caps2.is_phy_type_dll) {
> +		/*
> +		 * sync_timings - tCKWR,tWRCK,tCAD
> +		 * sync timing are related to the clock so the skew
> +		 * is minor and do not need to be included into calculations
> +		 */
> +		u32 tckwr_cnt = calc_cycl(tckwr, clk_period);
> +		u32 twrck_cnt = calc_cycl(twrck, clk_period);
> +		u32 tcad_cnt = 0;
> +
> +		reg = FIELD_PREP(SYNC_TIMINGS_TCKWR, tckwr_cnt);
> +		reg |= FIELD_PREP(SYNC_TIMINGS_TWRCK, twrck_cnt);
> +		reg |= FIELD_PREP(SYNC_TIMINGS_TCAD, tcad_cnt);
> +		t->sync_timings = reg;
> +		dev_dbg(cdns_ctrl->dev, "SYNC_TIMINGS_SDR\t%x\n", reg);
> +	}
> +
> +	tadl_cnt = calc_cycl((sdr->tADL_min + if_skew), clk_period);
> +	tccs_cnt = calc_cycl((sdr->tCCS_min + if_skew), clk_period);
> +	twhr_cnt = calc_cycl((sdr->tWHR_min + if_skew), clk_period);
> +	trhw_cnt = calc_cycl((sdr->tRHW_min + if_skew), clk_period);
> +	reg = FIELD_PREP(TIMINGS0_TADL, tadl_cnt);
> +
> +	/*
> +	 * if timing exceeds delay field in timing register
> +	 * then use maximum value

Please use plain english in comments, with capitals and periods.

> +	 */
> +	if (FIELD_FIT(TIMINGS0_TCCS, tccs_cnt))
> +		reg |= FIELD_PREP(TIMINGS0_TCCS, tccs_cnt);
> +	else
> +		reg |= TIMINGS0_TCCS;
> +
> +	reg |= FIELD_PREP(TIMINGS0_TWHR, twhr_cnt);
> +	reg |= FIELD_PREP(TIMINGS0_TRHW, trhw_cnt);
> +	t->timings0 = reg;
> +	dev_dbg(cdns_ctrl->dev, "TIMINGS0_SDR\t%x\n", reg);
> +
> +	//the following is related to single signal so skew is not needed

No //

> +	trhz_cnt = calc_cycl(sdr->tRHZ_max, clk_period);
> +	trhz_cnt = trhz_cnt + 1;
> +	twb_cnt = calc_cycl((sdr->tWB_max + board_delay), clk_period);
> +	/*
> +	 * because of the two stage syncflop the value must be increased by 3
> +	 * first value is related with sync, second value is related
> +	 * with output if delay
> +	 */
> +	twb_cnt = twb_cnt + 3 + 5;
> +	/*
> +	 * the following is related to the we edge of the random data input
> +	 * sequence so skew is not needed
> +	 */
> +	tcwaw_cnt = calc_cycl(tcwaw, clk_period);
> +	tvdly_cnt = calc_cycl((tvdly + if_skew), clk_period);
> +	reg = FIELD_PREP(TIMINGS1_TRHZ, trhz_cnt);
> +	reg |= FIELD_PREP(TIMINGS1_TWB, twb_cnt);
> +	reg |= FIELD_PREP(TIMINGS1_TCWAW, tcwaw_cnt);
> +	reg |= FIELD_PREP(TIMINGS1_TVDLY, tvdly_cnt);
> +	t->timings1 = reg;
> +	dev_dbg(cdns_ctrl->dev, "TIMINGS1_SDR\t%x\n", reg);
> +
> +	tfeat_cnt = calc_cycl(sdr->tFEAT_max, clk_period);
> +	if (tfeat_cnt < twb_cnt)
> +		tfeat_cnt = twb_cnt;
> +
> +	tceh_cnt = calc_cycl(sdr->tCEH_min, clk_period);
> +	tcs_cnt = calc_cycl((sdr->tCS_min + if_skew), clk_period);
> +
> +	reg = FIELD_PREP(TIMINGS2_TFEAT, tfeat_cnt);
> +	reg |= FIELD_PREP(TIMINGS2_CS_HOLD_TIME, tceh_cnt);
> +	reg |= FIELD_PREP(TIMINGS2_CS_SETUP_TIME, tcs_cnt);
> +	t->timings2 = reg;
> +	dev_dbg(cdns_ctrl->dev, "TIMINGS2_SDR\t%x\n", reg);
> +
> +	if (cdns_ctrl->caps2.is_phy_type_dll) {
> +		reg = DLL_PHY_CTRL_DLL_RST_N;
> +		if (extended_wr_mode)
> +			reg |= DLL_PHY_CTRL_EXTENDED_WR_MODE;
> +		if (extended_read_mode)
> +			reg |= DLL_PHY_CTRL_EXTENDED_RD_MODE;
> +
> +		reg |= FIELD_PREP(DLL_PHY_CTRL_RS_HIGH_WAIT_CNT, 7);
> +		reg |= FIELD_PREP(DLL_PHY_CTRL_RS_IDLE_CNT, 7);
> +		t->dll_phy_ctrl = reg;
> +		dev_dbg(cdns_ctrl->dev, "DLL_PHY_CTRL_SDR\t%x\n", reg);
> +	}
> +
> +	/*
> +	 * sampling point calculation
> +	 */
> +
> +	if ((tdvw_max % dqs_sampl_res) > 0)
> +		x = 0;
> +	else
> +		x = 1;
> +
> +	if ((tdvw_max / dqs_sampl_res - x) * dqs_sampl_res > tdvw_min) {
> +		/*
> +		 * if "number" of sampling point is:
> +		 * - even then phony_dqs_sel 0
> +		 * - odd then phony_dqs_sel 1
> +		 */
> +		if (((tdvw_max / dqs_sampl_res - x) % 2) > 0) {
> +			//odd
> +			dll_phy_dqs_timing = 0x00110004;
> +			phony_dqs_timing = tdvw_max
> +				/ (dqs_sampl_res * phony_dqs_mod) - x;
> +			if (!cdns_ctrl->caps2.is_phy_type_dll)
> +				phony_dqs_timing--;
> +
> +		} else {
> +			//even
> +			dll_phy_dqs_timing = 0x00100004;
> +			phony_dqs_timing = (tdvw_max
> +					    / dqs_sampl_res - x)
> +				/ phony_dqs_mod;
> +			phony_dqs_timing--;
> +		}
> +		rd_del_sel = phony_dqs_timing + 3;
> +	} else {
> +		dev_warn(cdns_ctrl->dev,
> +			 "ERROR %d : cannot find valid sampling point\n", x);
> +	}
> +
> +	reg = FIELD_PREP(PHY_CTRL_PHONY_DQS, phony_dqs_timing);
> +	if (cdns_ctrl->caps2.is_phy_type_dll)
> +		reg  |= PHY_CTRL_SDR_DQS;
> +	t->phy_ctrl = reg;
> +	dev_dbg(cdns_ctrl->dev, "PHY_CTRL_REG_SDR\t%x\n", reg);
> +
> +	if (cdns_ctrl->caps2.is_phy_type_dll) {
> +		dev_dbg(cdns_ctrl->dev, "PHY_TSEL_REG_SDR\t%x\n", 0);
> +		dev_dbg(cdns_ctrl->dev, "PHY_DQ_TIMING_REG_SDR\t%x\n", 2);
> +		dev_dbg(cdns_ctrl->dev, "PHY_DQS_TIMING_REG_SDR\t%x\n",
> +			dll_phy_dqs_timing);
> +		t->phy_dqs_timing = dll_phy_dqs_timing;
> +
> +		reg = FIELD_PREP(PHY_GATE_LPBK_CTRL_RDS, rd_del_sel);
> +		dev_dbg(cdns_ctrl->dev, "PHY_GATE_LPBK_CTRL_REG_SDR\t%x\n",
> +			reg);
> +		t->phy_gate_lpbk_ctrl = reg;
> +
> +		dev_dbg(cdns_ctrl->dev, "PHY_DLL_MASTER_CTRL_REG_SDR\t%lx\n",
> +			PHY_DLL_MASTER_CTRL_BYPASS_MODE);
> +		dev_dbg(cdns_ctrl->dev, "PHY_DLL_SLAVE_CTRL_REG_SDR\t%x\n", 0);
> +	}
> +
> +	return 0;
> +}

This function is so complicated !!! How can this even work? Really, it
is hard to get into the code and follow, I am sure you can do
something.

> +
> +int cadence_nand_attach_chip(struct nand_chip *chip)
> +{
> +	struct cdns_nand_ctrl *cdns_ctrl = to_cdns_nand_ctrl(chip->controller);
> +	struct cdns_nand_chip *cdns_chip = to_cdns_nand_chip(chip);
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +	u32 max_oob_data_size;
> +	int ret = 0;
> +
> +	if (chip->options & NAND_BUSWIDTH_16) {
> +		ret = cadence_nand_set_access_width16(cdns_ctrl, true);
> +		if (ret)
> +			goto free_buf;
> +	}
> +
> +	chip->bbt_options |= NAND_BBT_USE_FLASH;
> +	chip->bbt_options |= NAND_BBT_NO_OOB;
> +	chip->ecc.mode = NAND_ECC_HW;
> +
> +	chip->options |= NAND_NO_SUBPAGE_WRITE;
> +
> +	cdns_chip->bbm_offs = chip->badblockpos;
> +	if (chip->options & NAND_BUSWIDTH_16) {
> +		cdns_chip->bbm_offs &= ~0x01;
> +		cdns_chip->bbm_len = 2;
> +	} else {
> +		cdns_chip->bbm_len = 1;
> +	}
> +
> +	ret = nand_ecc_choose_conf(chip,
> +				   &cdns_ctrl->ecc_caps,
> +				   mtd->oobsize - cdns_chip->bbm_len);
> +	if (ret) {
> +		dev_err(cdns_ctrl->dev, "ECC configuration failed\n");
> +		goto free_buf;
> +	}
> +
> +	dev_dbg(cdns_ctrl->dev,
> +		"chosen ECC settings: step=%d, strength=%d, bytes=%d\n",
> +		chip->ecc.size, chip->ecc.strength, chip->ecc.bytes);
> +
> +	/* Error correction */
> +	cdns_chip->main_size = mtd->writesize;
> +	cdns_chip->sector_size = chip->ecc.size;
> +	cdns_chip->sector_count = cdns_chip->main_size / cdns_chip->sector_size;
> +	cdns_chip->oob_size = mtd->oobsize;
> +	cdns_chip->avail_oob_size = cdns_chip->oob_size
> +		- cdns_chip->sector_count * chip->ecc.bytes;
> +
> +	max_oob_data_size = MAX_OOB_SIZE_PER_SECTOR;
> +
> +	if (cdns_chip->avail_oob_size > max_oob_data_size)
> +		cdns_chip->avail_oob_size = max_oob_data_size;
> +
> +	if ((cdns_chip->avail_oob_size + cdns_chip->bbm_len
> +	     + cdns_chip->sector_count
> +	     * chip->ecc.bytes) > mtd->oobsize)
> +		cdns_chip->avail_oob_size -= 4;
> +
> +	cdns_chip->corr_str_idx =
> +		cadence_nand_get_ecc_strength_idx(cdns_ctrl,
> +						  chip->ecc.strength);
> +
> +	ret = cadence_nand_set_ecc_strength(cdns_ctrl,
> +					    cdns_chip->corr_str_idx);
> +	if (ret)
> +		return ret;
> +
> +	ret = cadence_nand_set_erase_detection(cdns_ctrl, true,
> +					       chip->ecc.strength);
> +	if (ret)
> +		return ret;
> +
> +	/* override the default read operations */
> +	chip->ecc.read_page = cadence_nand_read_page;
> +	chip->ecc.read_page_raw = cadence_nand_read_page_raw;
> +	chip->ecc.write_page = cadence_nand_write_page;
> +	chip->ecc.write_page_raw = cadence_nand_write_page_raw;
> +	chip->ecc.read_oob = cadence_nand_read_oob;
> +	chip->ecc.write_oob = cadence_nand_write_oob;
> +	chip->ecc.read_oob_raw = cadence_nand_read_oob_raw;
> +	chip->ecc.write_oob_raw = cadence_nand_write_oob_raw;
> +
> +	if ((mtd->writesize + mtd->oobsize) > cdns_ctrl->buf_size) {
> +		cdns_ctrl->buf_size = mtd->writesize + mtd->oobsize;
> +		kfree(cdns_ctrl->buf);
> +		cdns_ctrl->buf = kzalloc(cdns_ctrl->buf_size, GFP_KERNEL);
> +		if (!cdns_ctrl->buf) {
> +			ret = -ENOMEM;
> +			goto free_buf;
> +		}
> +	}
> +
> +	/* Is 32-bit DMA supported? */
> +	ret = dma_set_mask(cdns_ctrl->dev, DMA_BIT_MASK(32));
> +	if (ret) {
> +		dev_err(cdns_ctrl->dev, "no usable DMA configuration\n");
> +		goto free_buf;
> +	}
> +
> +	mtd_set_ooblayout(mtd, &cadence_nand_ooblayout_ops);
> +
> +	return 0;
> +
> +free_buf:
> +	kfree(cdns_ctrl->buf);
> +
> +	return ret;
> +}
> +
> +static const struct nand_controller_ops cadence_nand_controller_ops = {
> +	.attach_chip = cadence_nand_attach_chip,
> +	.exec_op = cadence_nand_exec_op,
> +	.setup_data_interface = cadence_nand_setup_data_interface,
> +};
> +
> +static int cadence_nand_chip_init(struct cdns_nand_ctrl *cdns_ctrl,
> +				  struct device_node *np)
> +{
> +	struct cdns_nand_chip *cdns_chip;
> +	struct mtd_info *mtd;
> +	struct nand_chip *chip;
> +	int nsels, ret, i;
> +	u32 cs;
> +
> +	nsels = of_property_count_elems_of_size(np, "reg", sizeof(u32));
> +	if (nsels <= 0) {
> +		dev_err(cdns_ctrl->dev, "missing/invalid reg property\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Alloc the nand chip structure */
> +	cdns_chip = devm_kzalloc(cdns_ctrl->dev, sizeof(*cdns_chip) +
> +				 (nsels * sizeof(u8)),
> +				 GFP_KERNEL);
> +	if (!cdns_chip) {
> +		dev_err(cdns_ctrl->dev, "could not allocate chip structure\n");
> +		return -ENOMEM;
> +	}
> +
> +	cdns_chip->nsels = nsels;
> +
> +	for (i = 0; i < nsels; i++) {
> +		/* Retrieve CS id */
> +		ret = of_property_read_u32_index(np, "reg", i, &cs);
> +		if (ret) {
> +			dev_err(cdns_ctrl->dev,
> +				"could not retrieve reg property: %d\n",
> +				ret);
> +			return ret;
> +		}
> +
> +		if (cs >= cdns_ctrl->caps2.max_banks) {
> +			dev_err(cdns_ctrl->dev,
> +				"invalid reg value: %u (max CS = %d)\n",
> +				cs, cdns_ctrl->caps2.max_banks);
> +			return -EINVAL;
> +		}
> +
> +		if (test_and_set_bit(cs, &cdns_ctrl->assigned_cs)) {
> +			dev_err(cdns_ctrl->dev,
> +				"CS %d already assigned\n", cs);
> +			return -EINVAL;
> +		}
> +
> +		cdns_chip->cs[i] = cs;
> +	}
> +
> +	chip = &cdns_chip->chip;
> +	chip->controller = &cdns_ctrl->controller;
> +	nand_set_flash_node(chip, np);
> +
> +	mtd = nand_to_mtd(chip);
> +	mtd->dev.parent = cdns_ctrl->dev;
> +
> +	/*
> +	 * Default to HW ECC engine mode. If the nand-ecc-mode property is given
> +	 * in the DT node, this entry will be overwritten in nand_scan_ident().
> +	 */
> +	chip->ecc.mode = NAND_ECC_HW;
> +
> +	/*
> +	 * Save a reference value for timing registers before
> +	 * ->setup_data_interface() is called.
> +	 */
> +	cadence_nand_get_timings(cdns_ctrl, &cdns_chip->timings);

You cannot rely on the Bootloader's configuration. This driver should
derive it.

> +
> +	ret = nand_scan(chip, cdns_chip->nsels);
> +	if (ret) {
> +		dev_err(cdns_ctrl->dev, "could not scan the nand chip\n");
> +		return ret;
> +	}
> +
> +	ret = mtd_device_register(mtd, NULL, 0);
> +	if (ret) {
> +		dev_err(cdns_ctrl->dev,
> +			"failed to register mtd device: %d\n", ret);
> +		nand_release(chip);

I think you should call nand_cleanup instead of nand_release here has
the mtd device is not registered yet.

> +		return ret;
> +	}
> +
> +	list_add_tail(&cdns_chip->node, &cdns_ctrl->chips);
> +
> +	return 0;
> +}
> +
> +static int cadence_nand_chips_init(struct cdns_nand_ctrl *cdns_ctrl)
> +{
> +	struct device_node *np = cdns_ctrl->dev->of_node;
> +	struct device_node *nand_np;
> +	int max_cs = cdns_ctrl->caps2.max_banks;
> +	int nchips;
> +	int ret;
> +
> +	nchips = of_get_child_count(np);
> +
> +	if (nchips > max_cs) {
> +		dev_err(cdns_ctrl->dev,
> +			"too many NAND chips: %d (max = %d CS)\n",
> +			nchips, max_cs);
> +		return -EINVAL;
> +	}
> +
> +	for_each_child_of_node(np, nand_np) {
> +		ret = cadence_nand_chip_init(cdns_ctrl, nand_np);
> +		if (ret) {
> +			of_node_put(nand_np);
> +			return ret;
> +		}

If nand_chip_init() fails on another chip than the first one, there is
some garbage collection to do.

> +	}
> +
> +	return 0;
> +}
> +
> +static int cadence_nand_init(struct cdns_nand_ctrl *cdns_ctrl)
> +{
> +	dma_cap_mask_t mask;
> +	int ret = 0;
> +
> +	cdns_ctrl->cdma_desc = dma_alloc_coherent(cdns_ctrl->dev,
> +						  sizeof(*cdns_ctrl->cdma_desc),
> +						  &cdns_ctrl->dma_cdma_desc,
> +						  GFP_KERNEL);
> +	if (!cdns_ctrl->dma_cdma_desc)
> +		return -ENOMEM;
> +
> +	cdns_ctrl->buf_size = 16 * 1024;

s/1024/SZ_1K/

> +	cdns_ctrl->buf = kmalloc(cdns_ctrl->buf_size, GFP_KERNEL);

If you use kmalloc here then this buffer will always be DMA-able,
right?

> +	if (!cdns_ctrl->buf) {
> +		goto free_buf_desc;
> +		ret = -ENOMEM;
> +	}
> +
> +	if (devm_request_irq(cdns_ctrl->dev, cdns_ctrl->irq, cadence_nand_isr,
> +			     IRQF_SHARED, "cadence-nand-controller",
> +			     cdns_ctrl)) {
> +		dev_err(cdns_ctrl->dev, "Unable to allocate IRQ\n");
> +		ret = -ENODEV;
> +		goto free_buf;
> +	}
> +
> +	spin_lock_init(&cdns_ctrl->irq_lock);
> +	init_completion(&cdns_ctrl->complete);
> +
> +	ret = cadence_nand_hw_init(cdns_ctrl);
> +	if (ret)
> +		goto disable_irq;
> +
> +	dma_cap_zero(mask);
> +	dma_cap_set(DMA_MEMCPY, mask);
> +
> +	if (cdns_ctrl->caps1->has_dma) {
> +		cdns_ctrl->dmac = dma_request_channel(mask, NULL, NULL);
> +		if (!cdns_ctrl->dmac) {
> +			dev_err(cdns_ctrl->dev,
> +				"Unable to get a dma channel\n");
> +			ret = -EBUSY;
> +			goto disable_irq;
> +		}
> +	}
> +
> +	nand_controller_init(&cdns_ctrl->controller);
> +	INIT_LIST_HEAD(&cdns_ctrl->chips);
> +
> +	cdns_ctrl->controller.ops = &cadence_nand_controller_ops;
> +	cdns_ctrl->curr_corr_str_idx = 0xFF;
> +
> +	ret = cadence_nand_chips_init(cdns_ctrl);
> +	if (ret) {
> +		dev_err(cdns_ctrl->dev, "Failed to register MTD: %d\n",
> +			ret);
> +		goto dma_release_chnl;
> +	}
> +
> +	return 0;
> +
> +dma_release_chnl:
> +	if (cdns_ctrl->dmac)
> +		dma_release_channel(cdns_ctrl->dmac);
> +
> +disable_irq:
> +	cadence_nand_irq_cleanup(cdns_ctrl->irq, cdns_ctrl);
> +
> +free_buf:
> +	kfree(cdns_ctrl->buf);
> +
> +free_buf_desc:
> +	dma_free_coherent(cdns_ctrl->dev, sizeof(struct cadence_nand_cdma_desc),
> +			  cdns_ctrl->cdma_desc, cdns_ctrl->dma_cdma_desc);
> +
> +	return ret;
> +}
> +
> +static void cadence_nand_chips_cleanup(struct cdns_nand_ctrl *cdns_ctrl)
> +{
> +	struct cdns_nand_chip *entry, *temp;
> +
> +	list_for_each_entry_safe(entry, temp, &cdns_ctrl->chips, node) {
> +		nand_release(&entry->chip);
> +		list_del(&entry->node);
> +	}
> +}
> +
> +/* driver exit point */
> +static void cadence_nand_remove(struct cdns_nand_ctrl *cdns_ctrl)
> +{
> +	cadence_nand_chips_cleanup(cdns_ctrl);
> +	cadence_nand_irq_cleanup(cdns_ctrl->irq, cdns_ctrl);
> +	kfree(cdns_ctrl->buf);
> +	dma_free_coherent(cdns_ctrl->dev, sizeof(struct cadence_nand_cdma_desc),
> +			  cdns_ctrl->cdma_desc, cdns_ctrl->dma_cdma_desc);
> +
> +	if (cdns_ctrl->dmac)
> +		dma_release_channel(cdns_ctrl->dmac);
> +}
> +
> +struct cadence_nand_dt {
> +	struct cdns_nand_ctrl cdns_ctrl;
> +	struct clk *clk;
> +};
> +
> +static const struct cadence_nand_dt_devdata cadnence_nand_default = {
> +	.if_skew = 0,
> +	.nand2_delay = 37,
> +	.phy_dll_aging = 1,
> +	.phy_per_bit_deskew = 1,
> +	.has_dma = 1,
> +};
> +
> +static const struct of_device_id cadence_nand_dt_ids[] = {
> +	{
> +		.compatible = "cdns,hpnfc",
> +		.data = &cadnence_nand_default

s/cadnence/cadence/

> +	}, {/* cadence */}

Useless comment

> +};
> +
> +MODULE_DEVICE_TABLE(of, cadence_nand_dt_ids);
> +
> +static int cadence_nand_dt_probe(struct platform_device *ofdev)
> +{
> +	struct resource *res;
> +	struct cadence_nand_dt *dt;
> +	struct cdns_nand_ctrl *cdns_ctrl;
> +	int ret;
> +	const struct of_device_id *of_id;
> +	const struct cadence_nand_dt_devdata *devdata;
> +	u32 val;
> +
> +	of_id = of_match_device(cadence_nand_dt_ids, &ofdev->dev);
> +	if (of_id) {
> +		ofdev->id_entry = of_id->data;
> +		devdata = of_id->data;
> +	} else {
> +		pr_err("Failed to find the right device id.\n");
> +		return -ENOMEM;
> +	}
> +
> +	dt = devm_kzalloc(&ofdev->dev, sizeof(*dt), GFP_KERNEL);
> +	if (!dt)
> +		return -ENOMEM;
> +
> +	cdns_ctrl = &dt->cdns_ctrl;
> +	cdns_ctrl->caps1 = devdata;
> +
> +	cdns_ctrl->dev = &ofdev->dev;
> +	cdns_ctrl->irq = platform_get_irq(ofdev, 0);
> +	if (cdns_ctrl->irq < 0) {
> +		dev_err(&ofdev->dev, "no irq defined\n");
> +		return cdns_ctrl->irq;
> +	}
> +	dev_info(cdns_ctrl->dev, "IRQ: nr %d\n", cdns_ctrl->irq);
> +
> +	res = platform_get_resource(ofdev, IORESOURCE_MEM, 0);
> +	cdns_ctrl->reg = devm_ioremap_resource(cdns_ctrl->dev, res);
> +	if (IS_ERR(cdns_ctrl->reg)) {
> +		dev_err(&ofdev->dev, "devm_ioremap_resource res 0 failed\n");
> +		return PTR_ERR(cdns_ctrl->reg);
> +	}
> +
> +	res = platform_get_resource(ofdev, IORESOURCE_MEM, 1);
> +	cdns_ctrl->io.dma = res->start;
> +	cdns_ctrl->io.virt = devm_ioremap_resource(&ofdev->dev, res);
> +	if (IS_ERR(cdns_ctrl->io.virt)) {
> +		dev_err(cdns_ctrl->dev, "devm_ioremap_resource res 1 failed\n");
> +		return PTR_ERR(cdns_ctrl->io.virt);
> +	}
> +
> +	dt->clk = devm_clk_get(cdns_ctrl->dev, "nf_clk");
> +	if (IS_ERR(dt->clk))
> +		return PTR_ERR(dt->clk);
> +
> +	cdns_ctrl->nf_clk_rate = clk_get_rate(dt->clk);
> +
> +	ret = of_property_read_u32(ofdev->dev.of_node,
> +				   "cdns,board-delay", &val);
> +	if (ret) {
> +		dev_warn(cdns_ctrl->dev, "missing cdns,board-delay property\n");
> +		val = 0;
> +	}
> +	cdns_ctrl->board_delay = val;
> +
> +	ret = cadence_nand_init(cdns_ctrl);
> +	if (ret)
> +		return ret;
> +
> +	platform_set_drvdata(ofdev, dt);
> +	return 0;
> +}
> +
> +static int cadence_nand_dt_remove(struct platform_device *ofdev)
> +{
> +	struct cadence_nand_dt *dt = platform_get_drvdata(ofdev);
> +
> +	cadence_nand_remove(&dt->cdns_ctrl);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver cadence_nand_dt_driver = {
> +	.probe		= cadence_nand_dt_probe,
> +	.remove		= cadence_nand_dt_remove,
> +	.driver		= {
> +		.name	= "cadence-nand-controller",
> +		.of_match_table = cadence_nand_dt_ids,
> +	},
> +};
> +
> +module_platform_driver(cadence_nand_dt_driver);
> +
> +MODULE_AUTHOR("Piotr Sroka <piotrs@cadence.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Driver for Cadence NAND flash controller");
> +


Thanks,
Miquèl
