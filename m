Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E64FC04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 12:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C36C22173E
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 12:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfELMYx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 08:24:53 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:58319 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfELMYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 08:24:52 -0400
X-Originating-IP: 109.190.253.16
Received: from xps13 (unknown [109.190.253.16])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id F2C131C0004;
        Sun, 12 May 2019 12:24:38 +0000 (UTC)
Date:   Sun, 12 May 2019 14:24:26 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Piotr Sroka <piotrs@cadence.com>
Cc:     <linux-kernel@vger.kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Paul Burton <paul.burton@mips.com>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Marcel Ziswiler" <marcel.ziswiler@toradex.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Stefan Agner <stefan@agner.ch>, <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v2 1/2] mtd: nand: Add Cadence NAND controller driver
Message-ID: <20190512142426.11453a6c@xps13>
In-Reply-To: <20190321093356.GA19577@global.cadence.com>
References: <20190219161406.4340-1-piotrs@cadence.com>
        <20190219161823.22466-1-piotrs@cadence.com>
        <20190305190954.6c38d681@xps13>
        <20190321093356.GA19577@global.cadence.com>
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

Sorry for de delay.

Piotr Sroka <piotrs@cadence.com> wrote on Thu, 21 Mar 2019 09:33:58
+0000:

> The 03/05/2019 19:09, Miquel Raynal wrote:
> >EXTERNAL MAIL
> >
> >
> >Hi Piotr,
> >
> >Piotr Sroka <piotrs@cadence.com> wrote on Tue, 19 Feb 2019 16:18:23
> >+0000:
> >  
> >> This patch adds driver for Cadence HPNFC NAND controller.
> >>
> >> Signed-off-by: Piotr Sroka <piotrs@cadence.com>
> >> ---
> >> Changes for v2:
> >> - create one universal wait function for all events instead of one
> >>   function per event.
> >> - split one big function executing nand operations to separate
> >>   functions one per each type of operation.
> >> - add erase atomic operation to nand operation parser
> >> - remove unnecessary includes.
> >> - remove unused register defines
> >> - add support for multiple nand chips
> >> - remove all code using legacy functions
> >> - remove chip dependents parameters from dts bindings, they were
> >>   attached to the SoC specific compatible at the driver level
> >> - simplify interrupt handling
> >> - simplify timing calculations
> >> - fix calculation of maximum supported cs signals
> >> - simplify ecc size calculation
> >> - remove header file and put whole code to one c file
> >> ---
> >>  drivers/mtd/nand/raw/Kconfig                   |    8 +
> >>  drivers/mtd/nand/raw/Makefile                  |    1 +
> >>  drivers/mtd/nand/raw/cadence-nand-controller.c | 3288 ++++++++++++++++++++++++  
> >
> >This driver is way too massive, I am pretty sure it can shrink a
> >little bit more.
> >[...]
> >  
> I will try to make it shorer but it will be difucult to achive. It is because - there are a lot of calculation needed for PHY      - ECC are interleaved with data (like on marvell-nand or gpmi-nand).
>    Therefore:    + RAW mode is complicated    + protecting BBM increases number of lines of source code
> - need to support two DMA engines internal and external (slave) We will see on next patch version what is the result.      That page layout looks:

Maybe you don't need to support both internal and external DMA?

I am pretty sure there are rooms for size reduction.

> 
>   +-----------------------------------------
>   | Data 1 | ECC 1 | ... | Data N  | ECC N |    +-----------------------------------------
> 
>        ----------------------------------+
>         Last Data | OOB bytes | Last ECC |
>        ----------------------------------+
> 	    /\ 	    ||         OOB area started
>      usualy vendor specified BBM
> 
> Flash OOB area starts somewhere in last data sector. Flash OOB area contains part of last sector, oob data (accessible by driver), and last ECC code   >> +
> >> +struct cdns_nand_chip {
> >> +	struct cadence_nand_timings timings;
> >> +	struct nand_chip chip;
> >> +	u8 nsels;
> >> +	struct list_head node;
> >> +
> >> +	/*
> >> +	 * part of oob area of NANF flash memory page.
> >> +	 * This part is available for user to read or write.
> >> +	 */
> >> +	u32 avail_oob_size;
> >> +	/* oob area size of NANF flash memory page */
> >> +	u32 oob_size;
> >> +	/* main area size of NANF flash memory page */
> >> +	u32 main_size;  
> >
> >These fields are redundant and exist in mtd_info/nand_chip.
> >  
> Ok I will use the parameters from mtd_info.
> >> +
> >> +	/* sector size few sectors are located on main area of NF memory page */
> >> +	u32 sector_size;
> >> +	u32 sector_count;
> >> +
> >> +	/* offset of BBM*/
> >> +	u8 bbm_offs;
> >> +	/* number of bytes reserved for BBM */
> >> +	u8 bbm_len;  
> >
> >Why do you bother at the controller driver level with bbm?
> >  
> When ECC is enabled then BBM is somewhere in last data sector. So for write operation real BBM will be overwritten. For read operation
> it will be read from wrong offset. To protect BBM we use HW feature skip bytes. To be able to properly configure this feature we need to
> know what is the offset of BBM.   >> +
> >> +static int cadence_nand_set_erase_detection(struct cdns_nand_ctrl *cdns_ctrl,
> >> +					    bool enable,
> >> +					    u8 bitflips_threshold)  
> >
> >What is this for?  
> Fucntions enables/disables hardware detection of erased data
> pages. >

Ok, the name is not very explicit , maybe you could tell this with a
comment.

> >> +
> >> +/* hardware initialization */
> >> +static int cadence_nand_hw_init(struct cdns_nand_ctrl *cdns_ctrl)
> >> +{
> >> +	int status = 0;
> >> +	u32 reg;
> >> +
> >> +	status = cadence_nand_wait_for_value(cdns_ctrl, CTRL_STATUS,
> >> +					     1000000,
> >> +					     CTRL_STATUS_INIT_COMP, false);
> >> +	if (status)
> >> +		return status;
> >> +
> >> +	reg = readl(cdns_ctrl->reg + CTRL_VERSION);
> >> +
> >> +	dev_info(cdns_ctrl->dev,
> >> +		 "%s: cadence nand controller version reg %x\n",
> >> +		 __func__, reg);
> >> +
> >> +	/* disable cache and multiplane */
> >> +	writel(0, cdns_ctrl->reg + MULTIPLANE_CFG);
> >> +	writel(0, cdns_ctrl->reg + CACHE_CFG);
> >> +
> >> +	/* clear all interrupts */
> >> +	writel(0xFFFFFFFF, cdns_ctrl->reg + INTR_STATUS);
> >> +
> >> +	cadence_nand_get_caps(cdns_ctrl);
> >> +	cadence_nand_read_bch_cfg(cdns_ctrl);  
> >
> >No, you cannot rely on the bootloader's configuration. And I suppose
> >this is what the first call to read_bch_cfg does?  
> I do not realy on boot loader. Just read NAND flash
> controller configuration from read only capabilities registers.

Ok, if these are RO registers, it's fine. But maybe don't call the
function "read bch config" which suggest that this is something you can
change.

> 
> 
> >> +
> >> +#define TT_OOB_AREA		1
> >> +#define TT_MAIN_OOB_AREAS	2
> >> +#define TT_RAW_PAGE		3
> >> +#define TT_BBM			4
> >> +#define TT_MAIN_OOB_AREA_EXT	5
> >> +
> >> +/* prepare size of data to transfer */
> >> +static int
> >> +cadence_nand_prepare_data_size(struct nand_chip *chip,
> >> +			       int transfer_type)
> >> +{
> >> +	struct cdns_nand_ctrl *cdns_ctrl = to_cdns_nand_ctrl(chip->controller);
> >> +	struct cdns_nand_chip *cdns_chip = to_cdns_nand_chip(chip);
> >> +	u32 sec_size = 0, last_sec_size, offset = 0, sec_cnt = 1;
> >> +	u32 ecc_size = chip->ecc.bytes;
> >> +	u32 data_ctrl_size = 0;
> >> +	u32 reg = 0;
> >> +
> >> +	if (cdns_ctrl->curr_trans_type == transfer_type)
> >> +		return 0;
> >> +
> >> +	switch (transfer_type) {  
> >
> >Please turn the controller driver as dumb as possible. You should not
> >care which part of the OOB area you are accessing.  
> It is a bit confusing for me how accessing OOB should be implemented.
> I know that read_oob function is called to check BBM value when BBT is
> initialized. It is also a bit confusing for me why the raw version is
> not used for that purpose.    In current implementation if you write oob by write_page function next
> read oob by read_oob function then data will be the same.
> If I implement dump functions read_oob and write_oob then
> 1. ECC must be disabled for these functions
> 2. oob data accessing by write_page/read_page will be different
>    (different offsets) that the data accessing by read_oob/write_oob
>    functions

No, I fear this is not acceptable.

> If  above described "functionalities" are acceptable I will change implementation of write_oob and read_oob functions.
> The write_page and read_page must be implemented in that way as it is now.    Let me know which solution is preffered.

If this is too complicated to just write the oob, why not fallback on
read/write_page (with oob_required and a dummy data buffer)?

> 
> >> +	case TT_OOB_AREA:
> >> +		offset = cdns_chip->main_size - cdns_chip->sector_size;
> >> +		ecc_size = ecc_size * (offset / cdns_chip->sector_size);
> >> +		offset = offset + ecc_size;
> >> +		sec_cnt = 1;
> >> +		last_sec_size = cdns_chip->sector_size
> >> +			+ cdns_chip->avail_oob_size;
> >> +		break;
> >> +	case TT_MAIN_OOB_AREA_EXT:
> >> +		sec_cnt = cdns_chip->sector_count;
> >> +		last_sec_size = cdns_chip->sector_size;
> >> +		sec_size = cdns_chip->sector_size;
> >> +		data_ctrl_size = cdns_chip->avail_oob_size;
> >> +		break;
> >> +	case TT_MAIN_OOB_AREAS:
> >> +		sec_cnt = cdns_chip->sector_count;
> >> +		last_sec_size = cdns_chip->sector_size
> >> +			+ cdns_chip->avail_oob_size;
> >> +		sec_size = cdns_chip->sector_size;
> >> +		break;
> >> +	case TT_RAW_PAGE:
> >> +		last_sec_size = cdns_chip->main_size + cdns_chip->oob_size;
> >> +		break;
> >> +	case TT_BBM:
> >> +		offset = cdns_chip->main_size + cdns_chip->bbm_offs;
> >> +		last_sec_size = 8;
> >> +		break;
> >> +	default:
> >> +		dev_err(cdns_ctrl->dev, "Data size preparation failed\n");
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	reg = 0;
> >> +	reg |= FIELD_PREP(TRAN_CFG_0_OFFSET, offset);
> >> +	reg |= FIELD_PREP(TRAN_CFG_0_SEC_CNT, sec_cnt);
> >> +	writel(reg, cdns_ctrl->reg + TRAN_CFG_0);
> >> +
> >> +	reg = 0;
> >> +	reg |= FIELD_PREP(TRAN_CFG_1_LAST_SEC_SIZE, last_sec_size);
> >> +	reg |= FIELD_PREP(TRAN_CFG_1_SECTOR_SIZE, sec_size);
> >> +	writel(reg, cdns_ctrl->reg + TRAN_CFG_1);
> >> +
> >> +	reg = readl(cdns_ctrl->reg + CONTROL_DATA_CTRL);
> >> +	reg &= ~CONTROL_DATA_CTRL_SIZE;
> >> +	reg |= FIELD_PREP(CONTROL_DATA_CTRL_SIZE, data_ctrl_size);
> >> +	writel(reg, cdns_ctrl->reg + CONTROL_DATA_CTRL);
> >> +
> >> +	cdns_ctrl->curr_trans_type = transfer_type;
> >> +
> >> +	return 0;
> >> +}
> >> +  
> >
> >[...]
> >  
> >> +
> >> +static int cadence_nand_read_page_raw(struct nand_chip *chip,
> >> +				      u8 *buf, int oob_required, int page)
> >> +{
> >> +	struct cdns_nand_ctrl *cdns_ctrl = to_cdns_nand_ctrl(chip->controller);
> >> +	struct cdns_nand_chip *cdns_chip = to_cdns_nand_chip(chip);
> >> +	int oob_skip = cdns_chip->bbm_len;  
> >
> >Why do you skip the BBM?
> >
> >In any of the read_page/oob helpers I don't think this is relevant at
> >all.  
> I described the problem at the beginnig. ECC are interleaved with data.
> So real possition of BBM is somewehre in last data sector. We use skip
> byte feature to skip this BBM. Once used need to handle in each
> function. Skip BBM is also used in denali-nand
>      >  
> >> +	int writesize = cdns_chip->main_size;
> >> +	int ecc_steps = chip->ecc.steps;
> >> +	int ecc_size = chip->ecc.size;
> >> +	int ecc_bytes = chip->ecc.bytes;
> >> +	void *tmp_buf = cdns_ctrl->buf;
> >> +	int i, pos, len;
> >> +	int status = 0;
> >> +
> >> +	status = cadence_nand_select_target(chip);
> >> +	if (status)
> >> +		return status;
> >> +
> >> +	cadence_nand_set_skip_bytes_conf(cdns_ctrl, 0, 0, 0);
> >> +
> >> +	cadence_nand_prepare_data_size(chip, TT_RAW_PAGE);
> >> +	status = cadence_nand_cdma_transfer(cdns_ctrl,
> >> +					    cdns_chip->cs[chip->cur_cs],
> >> +					    page, cdns_ctrl->buf,
> >> +					    NULL,
> >> +					    cdns_chip->main_size
> >> +					    + cdns_chip->oob_size,
> >> +					    0, DMA_FROM_DEVICE, false);
> >> +
> >> +	switch (status) {
> >> +	case STAT_ERASED:
> >> +	case STAT_OK:
> >> +		break;
> >> +	default:
> >> +		dev_err(cdns_ctrl->dev, "read raw page failed\n");
> >> +		return -EIO;
> >> +	}
> >> +
> >> +	/* Arrange the buffer for syndrome payload/ecc layout */
> >> +	if (buf) {
> >> +		for (i = 0; i < ecc_steps; i++) {
> >> +			pos = i * (ecc_size + ecc_bytes);
> >> +			len = ecc_size;
> >> +
> >> +			if (pos >= writesize)
> >> +				pos += oob_skip;
> >> +			else if (pos + len > writesize)
> >> +				len = writesize - pos;
> >> +
> >> +			memcpy(buf, tmp_buf + pos, len);
> >> +			buf += len;
> >> +			if (len < ecc_size) {
> >> +				len = ecc_size - len;
> >> +				memcpy(buf, tmp_buf + writesize + oob_skip,
> >> +				       len);
> >> +				buf += len;
> >> +			}
> >> +		}
> >> +	}
> >> +
> >> +	if (oob_required) {
> >> +		u8 *oob = chip->oob_poi;
> >> +		u32 oob_data_offset = (cdns_chip->sector_count - 1) *
> >> +			(cdns_chip->sector_size + chip->ecc.bytes)
> >> +			+ cdns_chip->sector_size + oob_skip;
> >> +
> >> +		/* OOB free */
> >> +		memcpy(oob, tmp_buf + oob_data_offset,
> >> +		       cdns_chip->avail_oob_size);
> >> +
> >> +		/* BBM at the beginning of the OOB area */
> >> +		memcpy(oob, tmp_buf + writesize, oob_skip);
> >> +
> >> +		oob += cdns_chip->avail_oob_size;
> >> +
> >> +		/* OOB ECC */
> >> +		for (i = 0; i < ecc_steps; i++) {
> >> +			pos = ecc_size + i * (ecc_size + ecc_bytes);
> >> +			len = ecc_bytes;
> >> +
> >> +			if (i == (ecc_steps - 1))
> >> +				pos += cdns_chip->avail_oob_size;
> >> +
> >> +			if (pos >= writesize)
> >> +				pos += oob_skip;
> >> +			else if (pos + len > writesize)
> >> +				len = writesize - pos;
> >> +
> >> +			memcpy(oob, tmp_buf + pos, len);
> >> +			oob += len;
> >> +			if (len < ecc_bytes) {
> >> +				len = ecc_bytes - len;
> >> +				memcpy(oob, tmp_buf + writesize + oob_skip,
> >> +				       len);
> >> +				oob += len;
> >> +			}
> >> +		}
> >> +	}
> >> +
> >> +	return 0;
> >> +}  
> [ ...]
>   >> +}
> >> +
> >> +static int cadence_nand_read_buf(struct cdns_nand_ctrl *cdns_ctrl,
> >> +static int cadence_nand_write_buf(struct cdns_nand_ctrl *cdns_ctrl,
> >> +static int cadence_nand_cmd_opcode(struct nand_chip *chip,
> >> +static int cadence_nand_cmd_address(struct nand_chip *chip,
> >> +static int cadence_nand_cmd_erase(struct nand_chip *chip,
> >> +static int cadence_nand_cmd_data(struct nand_chip *chip,  
> >
> >This looks pretty familiar with the legacy approach, I think you just
> >renamed some functions instead of trying to fit the ->exec_op interface
> >and there is probably a lot to do on this side that would reduce the
> >driver size. There are plenty of operations done by each of the above
> >helpers that should probably factored out.
> >  
> No I have never used legacy approach for that part.
> In previous patch I have one function to hanlde it but Boris point
> that one function containing switch is not a good solution so I splited
> to few functions.   

ok

>> +
> >> +static const struct nand_op_parser cadence_nand_op_parser = NAND_OP_PARSER(
> >> +	NAND_OP_PARSER_PATTERN(
> >> +		cadence_nand_cmd_erase,
> >> +		NAND_OP_PARSER_PAT_CMD_ELEM(false),
> >> +		NAND_OP_PARSER_PAT_ADDR_ELEM(false, MAX_ERASE_ADDRESS_CYC),
> >> +		NAND_OP_PARSER_PAT_CMD_ELEM(false),
> >> +		NAND_OP_PARSER_PAT_WAITRDY_ELEM(false)),
> >> +	NAND_OP_PARSER_PATTERN(
> >> +		cadence_nand_cmd_opcode,
> >> +		NAND_OP_PARSER_PAT_CMD_ELEM(false)),
> >> +	NAND_OP_PARSER_PATTERN(
> >> +		cadence_nand_cmd_address,
> >> +		NAND_OP_PARSER_PAT_ADDR_ELEM(false, MAX_ADDRESS_CYC)),
> >> +	NAND_OP_PARSER_PATTERN(
> >> +		cadence_nand_cmd_data,
> >> +		NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, MAX_DATA_SIZE)),
> >> +	NAND_OP_PARSER_PATTERN(
> >> +		cadence_nand_cmd_data,
> >> +		NAND_OP_PARSER_PAT_DATA_OUT_ELEM(false, MAX_DATA_SIZE)),
> >> +	NAND_OP_PARSER_PATTERN(
> >> +		cadence_nand_cmd_waitrdy,
> >> +		NAND_OP_PARSER_PAT_WAITRDY_ELEM(false))
> >> +	);
> >> +
> >> +static int cadence_nand_exec_op(struct nand_chip *chip,
> >> +				const struct nand_operation *op,
> >> +				bool check_only)
> >> +{
> >> +	int status = cadence_nand_select_target(chip);
> >> +
> >> +	if (status)
> >> +		return status;
> >> +
> >> +	return nand_op_parser_exec_op(chip, &cadence_nand_op_parser, op,
> >> +				      check_only);
> >> +}
> >> +
> >> +static int cadence_nand_ooblayout_free(struct mtd_info *mtd, int section,
> >> +				       struct mtd_oob_region *oobregion)
> >> +{
> >> +	struct nand_chip *chip = mtd_to_nand(mtd);
> >> +	struct cdns_nand_chip *cdns_chip = to_cdns_nand_chip(chip);
> >> +
> >> +	if (section)
> >> +		return -ERANGE;
> >> +
> >> +	oobregion->offset = cdns_chip->bbm_len;
> >> +	oobregion->length = cdns_chip->avail_oob_size
> >> +		- cdns_chip->bbm_len;
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int cadence_nand_ooblayout_ecc(struct mtd_info *mtd, int section,
> >> +				      struct mtd_oob_region *oobregion)
> >> +{
> >> +	struct nand_chip *chip = mtd_to_nand(mtd);
> >> +	struct cdns_nand_chip *cdns_chip = to_cdns_nand_chip(chip);
> >> +
> >> +	if (section)
> >> +		return -ERANGE;
> >> +
> >> +	oobregion->offset = cdns_chip->avail_oob_size;
> >> +	oobregion->length = chip->ecc.total;
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static const struct mtd_ooblayout_ops cadence_nand_ooblayout_ops = {
> >> +	.free = cadence_nand_ooblayout_free,
> >> +	.ecc = cadence_nand_ooblayout_ecc,
> >> +};
> >> +
> >> +static int calc_cycl(u32 timing, u32 clock)
> >> +{
> >> +	if (timing == 0 || clock == 0)
> >> +		return 0;
> >> +
> >> +	if ((timing % clock) > 0)
> >> +		return timing / clock;
> >> +	else
> >> +		return timing / clock - 1;
> >> +}
> >> +  
> [...] >> +	/*
> >> +	 * the idea of those calculation is to get the optimum value
> >> +	 * for tRP and tRH timings if it is NOT possible to sample data
> >> +	 * with optimal tRP/tRH settings the parameters will be extended
> >> +	 */
> >> +	if (sdr->tRC_min <= clk_period &&
> >> +	    sdr->tRP_min <= (clk_period / 2) &&
> >> +	    sdr->tREH_min <= (clk_period / 2)) {  
> >
> >Will this situation really happen?  
> I think yes for follwing values trc_min  20000 ps
> trp_min  10000 ps
> treh_min 7000  ps
> clk_period 20000 ps

Ok, you may add a comment stating that this may be the case in EDO mode
5.

> [...]
> >> +	}
> >> +
> >> +	if (cdns_ctrl->caps2.is_phy_type_dll) {  
> >
> >Is the else part allowed?
> >  
> following register does not exist if caps2.is_phy_type_dll is 0 >> +		u32 tpre_cnt = calc_cycl(tpre, clk_period);
> >> +		u32 tcdqss_cnt = calc_cycl(tcdqss + if_skew, clk_period);
> >> +		u32 tpsth_cnt = calc_cycl(tpsth + if_skew, clk_period);
> >> +
> >> +		u32 trpst_cnt = calc_cycl(trpst + if_skew, clk_period) + 1;
> >> +		u32 twpst_cnt = calc_cycl(twpst + if_skew, clk_period) + 1;
> >> +		u32 tcres_cnt = calc_cycl(tcres + if_skew, clk_period) + 1;
> >> +		u32 tcdqsh_cnt = calc_cycl(tcdqsh + if_skew, clk_period) + 5;
> >> +
> >> +		tcr_cnt = calc_cycl(tcr + if_skew, clk_period);
> >> +		/*
> >> +		 * skew not included because this timing defines duration of
> >> +		 * RE or DQS before data transfer
> >> +		 */
> >> +		tpsth_cnt = tpsth_cnt + 1;
> >> +		reg = FIELD_PREP(TOGGLE_TIMINGS0_TPSTH, tpsth_cnt);
> >> +		reg |= FIELD_PREP(TOGGLE_TIMINGS0_TCDQSS, tcdqss_cnt);
> >> +		reg |= FIELD_PREP(TOGGLE_TIMINGS0_TPRE, tpre_cnt);
> >> +		reg |= FIELD_PREP(TOGGLE_TIMINGS0_TCR, tcr_cnt);
> >> +		t->toggle_timings_0 = reg;
> >> +		dev_dbg(cdns_ctrl->dev, "TOGGLE_TIMINGS_0_SDR\t%x\n", reg);
> >> +
> >> +		//toggle_timings_1 - tRPST,tWPST
> >> +		reg = FIELD_PREP(TOGGLE_TIMINGS1_TCDQSH, tcdqsh_cnt);
> >> +		reg |= FIELD_PREP(TOGGLE_TIMINGS1_TCRES, tcres_cnt);
> >> +		reg |= FIELD_PREP(TOGGLE_TIMINGS1_TRPST, trpst_cnt);
> >> +		reg |= FIELD_PREP(TOGGLE_TIMINGS1_TWPST, twpst_cnt);
> >> +		t->toggle_timings_1 = reg;
> >> +		dev_dbg(cdns_ctrl->dev, "TOGGLE_TIMINGS_1_SDR\t%x\n", reg);
> >> +	}  
> [...] >
> >This function is so complicated !!! How can this even work? Really, it
> >is hard to get into the code and follow, I am sure you can do
> >something.  
> Yes it is complicated but works, I will try to simplify it...   [...]

Yes please!

> >> +				"CS %d already assigned\n", cs);
> >> +			return -EINVAL;
> >> +		}
> >> +
> >> +		cdns_chip->cs[i] = cs;
> >> +	}
> >> +
> >> +	chip = &cdns_chip->chip;
> >> +	chip->controller = &cdns_ctrl->controller;
> >> +	nand_set_flash_node(chip, np);
> >> +
> >> +	mtd = nand_to_mtd(chip);
> >> +	mtd->dev.parent = cdns_ctrl->dev;
> >> +
> >> +	/*
> >> +	 * Default to HW ECC engine mode. If the nand-ecc-mode property is given
> >> +	 * in the DT node, this entry will be overwritten in nand_scan_ident().
> >> +	 */
> >> +	chip->ecc.mode = NAND_ECC_HW;
> >> +
> >> +	/*
> >> +	 * Save a reference value for timing registers before
> >> +	 * ->setup_data_interface() is called.
> >> +	 */
> >> +	cadence_nand_get_timings(cdns_ctrl, &cdns_chip->timings);  
> >
> >You cannot rely on the Bootloader's configuration. This driver should
> >derive it.  
> I do not relay on the Bootloader's configuration in any part. I just
> init timings structure base on current values of registers to do not
>   have rubish in timing structure. Values will be calculated by driver when
> setup_data_interface is called. In case set_timings is called before
> setup_data_interface

Does this really happens? I am pretty sure it is taken care of by the
core. I don't think you should rely on what's in the registers at boot
time.

> then we write the same valus to timing registers
> which are preset in registres. To be shorter timing registers will stay
> unchanged.  >> +	ret = nand_scan(chip, cdns_chip->nsels);
> >> +	if (ret) {
> >> +		dev_err(cdns_ctrl->dev, "could not scan the nand chip\n");
> >> +		return ret;
> >> +	}
> >> +
> >> +	ret = mtd_device_register(mtd, NULL, 0);
> >> +	if (ret) {
> >> +		dev_err(cdns_ctrl->dev,
> >> +			"failed to register mtd device: %d\n", ret);
> >> +		nand_release(chip);  
> >
> >I think you should call nand_cleanup instead of nand_release here has
> >the mtd device is not registered yet.
> >  
> >> +		return ret;
> >> +	}
> >> +
> >> +	list_add_tail(&cdns_chip->node, &cdns_ctrl->chips);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int cadence_nand_chips_init(struct cdns_nand_ctrl *cdns_ctrl)
> >> +{
> >> +	struct device_node *np = cdns_ctrl->dev->of_node;
> >> +	struct device_node *nand_np;
> >> +	int max_cs = cdns_ctrl->caps2.max_banks;
> >> +	int nchips;
> >> +	int ret;
> >> +
> >> +	nchips = of_get_child_count(np);
> >> +
> >> +	if (nchips > max_cs) {
> >> +		dev_err(cdns_ctrl->dev,
> >> +			"too many NAND chips: %d (max = %d CS)\n",
> >> +			nchips, max_cs);
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	for_each_child_of_node(np, nand_np) {
> >> +		ret = cadence_nand_chip_init(cdns_ctrl, nand_np);
> >> +		if (ret) {
> >> +			of_node_put(nand_np);
> >> +			return ret;
> >> +		}  
> >
> >If nand_chip_init() fails on another chip than the first one, there is
> >some garbage collection to do.
> >  
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int cadence_nand_init(struct cdns_nand_ctrl *cdns_ctrl)
> >> +{
> >> +	dma_cap_mask_t mask;
> >> +	int ret = 0;
> >> +
> >> +	cdns_ctrl->cdma_desc = dma_alloc_coherent(cdns_ctrl->dev,
> >> +						  sizeof(*cdns_ctrl->cdma_desc),
> >> +						  &cdns_ctrl->dma_cdma_desc,
> >> +						  GFP_KERNEL);
> >> +	if (!cdns_ctrl->dma_cdma_desc)
> >> +		return -ENOMEM;
> >> +
> >> +	cdns_ctrl->buf_size = 16 * 1024;  
> >
> >s/1024/SZ_1K/
> >  
> >> +	cdns_ctrl->buf = kmalloc(cdns_ctrl->buf_size, GFP_KERNEL);  
> >
> >If you use kmalloc here then this buffer will always be DMA-able,
> >right?  
> Right I have seen such solution in another driver.
> 
> 
> Thanks for revieving this patch. Please answer on my question how write_oob
> and read_oob functions should be implemented.
> 
> >
> >
> >Thanks,
> >Miquèl  
> 
>   Thanks
> Piotr Sroka

Thanks,
Miquèl
