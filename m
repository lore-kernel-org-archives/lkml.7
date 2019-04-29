Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AE6C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 12:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8C4520673
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 12:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbfD2MXi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 08:23:38 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:36761 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbfD2MXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 08:23:38 -0400
X-Originating-IP: 90.88.147.33
Received: from xps13 (aaubervilliers-681-1-27-33.w90-88.abo.wanadoo.fr [90.88.147.33])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 07C55FF810;
        Mon, 29 Apr 2019 12:23:33 +0000 (UTC)
Date:   Mon, 29 Apr 2019 14:23:32 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Naga Sureshkumar Relli <nagasure@xilinx.com>
Cc:     Helmut Grohne <helmut.grohne@intenta.de>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "richard@nod.at" <richard@nod.at>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "nagasureshkumarrelli@gmail.com" <nagasureshkumarrelli@gmail.com>
Subject: Re: [LINUX PATCH v14] mtd: rawnand: pl353: Add basic driver for arm
 pl353 smc nand interface
Message-ID: <20190429142332.27a2cba5@xps13>
In-Reply-To: <DM6PR02MB4779EE37978EC0E6475C55D7AF390@DM6PR02MB4779.namprd02.prod.outlook.com>
References: <1555326613-26739-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <20190425112338.dipgmqqfuj45gx6s@laureti-dev>
        <DM6PR02MB4779EE37978EC0E6475C55D7AF390@DM6PR02MB4779.namprd02.prod.outlook.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naga,

> > > +	u32 addrs;
> > > +	u32 naddrs;
> > > +	u32 addr5;
> > > +	u32 addr6;  
> > 
> > Why are addr5 and addr6 u32? You only ever store u8 values in here. How about merging
> > them into an u16 addr56? Doing so would make the access in pl353_nand_exec_op_cmd
> > simpler and move a little complexity into pl353_nfc_parse_instructions.  
> Will try this. But I don't see any complex logic involved using addr5 and addr6.

This is a relic of a too quick copy from marvell_nand.c. Please match
the structure with your controller memory layout instead.

> > > +	const struct nand_op_instr *data_instr; };
> > > +
> > > +/**
> > > + * struct pl353_nand_controller - Defines the NAND flash controller driver
> > > + *				  instance
> > > + * @chip:		NAND chip information structure
> > > + * @dev:		Parent device (used to print error messages)
> > > + * @regs:		Virtual address of the NAND flash device
> > > + * @buf_addr:		Virtual address of the NAND flash device for
> > > + *			data read/writes
> > > + * @addr_cycles:	Address cycles
> > > + * @mclk:		Memory controller clock
> > > + * @buswidth:		Bus width 8 or 16
> > > + */
> > > +struct pl353_nand_controller {
> > > +	struct nand_controller controller;
> > > +	struct nand_chip chip;
> > > +	struct device *dev;
> > > +	void __iomem *regs;
> > > +	void __iomem *buf_addr;  
> > 
> > I find the use of buf_addr unfortunate. It is consumed by two functions
> > pl353_nand_read_data_op and pl353_nand_write_data_op. All other functions update its
> > value. Semantically, its value is regs + some flags. For the updaters that means a complex logic
> > where they first have to subtract reg, then change flags and add reg again. To make matters
> > worse, this computation involves __force casts between long and __iomem (which yielded
> > complaints in earlier reviews).  I think it would simplify the code if you replaced buf_addr with
> > something like addr_flags and then compute buf_addr as regs + addr_flags in those two
> > consumers. What do you think?  
> This definitely simplifies the driver logic, we have to do that.
> I tried it previously, regarding __force and __iomem casting changes, but the driver functionality was broken
> With this update.
> Let me update it and check it again.
> But just wanted to know, do you see issues with these __force and __iomem castings?
> >   
> > > +	u8 addr_cycles;
> > > +	struct clk *mclk;  
> > 
> > All you need here is the memory clock frequency. Wouldn't it be easier to extract that
> > frequency once during probe and store it here? That assumes a constant frequency, but if the
> > frequency isn't constant, you have a race condition.  
> That is what we are doing in the probe.
> In the probe, we are getting mclk using of_clk_get() and then we are getting the actual frequency
> Using clk_get_rate().
> And this is constant frequency only(getting from dts)

What Helmut proposes is, I think, saving the clock frequency to avoid
requesting it everytime you want to use it (if this is done many times).

[...]

> > > +
> > > +	oobregion->offset = (section * chip->ecc.bytes) + 2;
> > > +	oobregion->length = 50;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static const struct mtd_ooblayout_ops pl353_ecc_ooblayout64_ops = {
> > > +	.ecc = pl353_ecc_ooblayout64_ecc,
> > > +	.free = pl353_ecc_ooblayout64_free,
> > > +};
> > > +
> > > +/* Generic flash bbt decriptors */
> > > +static u8 bbt_pattern[] = { 'B', 'b', 't', '0' }; static u8
> > > +mirror_pattern[] = { '1', 't', 'b', 'B' };
> > > +
> > > +static struct nand_bbt_descr bbt_main_descr = {
> > > +	.options = NAND_BBT_LASTBLOCK | NAND_BBT_CREATE |  
> > NAND_BBT_WRITE  
> > > +		| NAND_BBT_2BIT | NAND_BBT_VERSION | NAND_BBT_PERCHIP,
> > > +	.offs = 4,
> > > +	.len = 4,
> > > +	.veroffs = 20,
> > > +	.maxblocks = 4,
> > > +	.pattern = bbt_pattern  
> > 
> > I have a general question concerning the nand framework here. The pattern member in struct
> > nand_bbt_descr is not declared const.
> > Therefore, bbt_pattern cannot be const here. As far as I looked, all accesses of pattern use it
> > with memcmp or as source for memcpy. Also the diskonchip.c driver assigns a string constant
> > here. This suggests, that pattern should be declared const or that diskonchip.c is doing it
> > wrong.  
> May be Miquel can comment on this.

I did not check diskonchip.c's implementation but turning it into const
seems reasonable to me. However in the scope of this driver, Naga, you
can keep it as it is right now.

> >   
> > > +};
> > > +
> > > +static struct nand_bbt_descr bbt_mirror_descr = {
> > > +	.options = NAND_BBT_LASTBLOCK | NAND_BBT_CREATE |  
> > NAND_BBT_WRITE  
> > > +		| NAND_BBT_2BIT | NAND_BBT_VERSION | NAND_BBT_PERCHIP,
> > > +	.offs = 4,
> > > +	.len = 4,
> > > +	.veroffs = 20,
> > > +	.maxblocks = 4,
> > > +	.pattern = mirror_pattern
> > > +};
> > > +
> > > +static void pl353_nfc_force_byte_access(struct nand_chip *chip,
> > > +					bool force_8bit)
> > > +{
> > > +	int ret;
> > > +	struct pl353_nand_controller *xnfc =
> > > +		container_of(chip, struct pl353_nand_controller, chip);
> > > +
> > > +	if (xnfc->buswidth == 8)  
> > 
> > This buswidth member is never assigned anywhere. Thus the value is always 0 and this
> > comparison always fails.  
> No, in the probe we should update this, by reading it from dts.
> Unfortunately, the assignment was removed, during checkpatch clean up(its my editor issue).
> I will update it. 

This answer is scary, there are probably many other places where you
deleted useful code then?



[...]

> > > +/* NAND framework ->exec_op() hooks and related helpers */
static
> > > +void pl353_nfc_parse_instructions(struct nand_chip *chip,
> > > +					 const struct nand_subop *subop,
> > > +					 struct pl353_nfc_op *nfc_op)
> > > +{
> > > +	const struct nand_op_instr *instr = NULL;
> > > +	unsigned int op_id, offset, naddrs;
> > > +	int i;
> > > +	const u8 *addrs;
> > > +
> > > +	memset(nfc_op, 0, sizeof(struct pl353_nfc_op));
> > > +	for (op_id = 0; op_id < subop->ninstrs; op_id++) {
> > > +		instr = &subop->instrs[op_id];
> > > +
> > > +		switch (instr->type) {
> > > +		case NAND_OP_CMD_INSTR:
> > > +			if (op_id)
> > > +				nfc_op->cmnds[1] = instr->ctx.cmd.opcode;
> > > +			else
> > > +				nfc_op->cmnds[0] = instr->ctx.cmd.opcode;
> > > +			nfc_op->cle_ale_delay_ns = instr->delay_ns;
> > > +			break;
> > > +
> > > +		case NAND_OP_ADDR_INSTR:
> > > +			offset = nand_subop_get_addr_start_off(subop, op_id);
> > > +			naddrs = nand_subop_get_num_addr_cyc(subop, op_id);
> > > +			addrs = &instr->ctx.addr.addrs[offset];
> > > +			nfc_op->addrs = instr->ctx.addr.addrs[offset];
> > > +			for (i = 0; i < min_t(unsigned int, 4, naddrs); i++) {
> > > +				nfc_op->addrs |= instr->ctx.addr.addrs[i] <<  
> > 
> > I don't quite understand what this code does, but it looks strange to me. I compared it to other
> > drivers. The code here is quite similar to marvell_nand.c. It seems like we are copying a
> > varying number (0 to 6) of addresses from the buffer instr->ctx.addr.addrs. However their
> > indices are special: 0, 1, 2, 3, offset + 4, offset + 5. This is non-consecutive and different from
> > marvell_nand.c in this regard. Could it be that you really meant index offset+i here?  
> I didn't get, what you are saying here.
> It is about updating page and column addresses.
> Are you asking me to remove nfc_op->addrs = instr->ctx.addr.addrs[offset]; before for loop?
> 
> >   
> > > +						 (8 * i);
> > > +			}
> > > +
> > > +			if (naddrs >= 5)
> > > +				nfc_op->addr5 = addrs[4];
> > > +			if (naddrs >= 6)
> > > +				nfc_op->addr6 = addrs[5];

Also, you probably don't need addr5 and addr6 here, they were needed in
marvell_nand.c because addresses are stored in three different
registers and are limited to 6 cycles, but this is probably not the
case in your driver.

> > > +			nfc_op->naddrs = nand_subop_get_num_addr_cyc(subop,
> > > +								     op_id);
> > > +			nfc_op->cle_ale_delay_ns = instr->delay_ns;
> > > +			break;
> > > +
> > > +		case NAND_OP_DATA_IN_INSTR:
> > > +			nfc_op->data_instr = instr;
> > > +			nfc_op->data_instr_idx = op_id;
> > > +			break;
> > > +
> > > +		case NAND_OP_DATA_OUT_INSTR:
> > > +			nfc_op->data_instr = instr;
> > > +			nfc_op->data_instr_idx = op_id;
> > > +			break;
> > > +
> > > +		case NAND_OP_WAITRDY_INSTR:
> > > +			nfc_op->rdy_timeout_ms = instr->ctx.waitrdy.timeout_ms;
> > > +			nfc_op->rdy_delay_ns = instr->delay_ns;
> > > +			break;
> > > +		}
> > > +	}
> > > +}
> > > +
> > > +static void cond_delay(unsigned int ns) {
> > > +	if (!ns)
> > > +		return;
> > > +
> > > +	if (ns < 10000)
> > > +		ndelay(ns);
> > > +	else
> > > +		udelay(DIV_ROUND_UP(ns, 1000));
> > > +}  
> > 

[...]

> > > +
> > > +	writel_relaxed(cmd_phase_data, (void __iomem * __force)cmd_phase_addr);
> > > +	if (!nfc_op.data_instr) {
> > > +		if (nfc_op.rdy_timeout_ms) {
> > > +			if (pl353_wait_for_dev_ready(chip))
> > > +				return -ETIMEDOUT;
> > > +		}
> > > +
> > > +		return 0;
> > > +	}
> > > +
> > > +	reading = (nfc_op.data_instr->type == NAND_OP_DATA_IN_INSTR);
> > > +	if (!reading) {
> > > +		len = nand_subop_get_data_len(subop, op_id);
> > > +		pl353_nand_write_data_op(chip, instr->ctx.data.buf.out,
> > > +					 len, instr->ctx.data.force_8bit);
> > > +		if (nfc_op.rdy_timeout_ms) {
> > > +			if (pl353_wait_for_dev_ready(chip))
> > > +				return -ETIMEDOUT;
> > > +		}
> > > +
> > > +		cond_delay(nfc_op.rdy_delay_ns);
> > > +	}
> > > +
> > > +	if (reading) {  
> > 
> > You could use an else branch instead of inverting the condition here.
> > When Miquel complained about this in v13, you said you'd change it, but you didn't.  
> Sorry for that. I will change it.

Yes please, be careful and not in a hurry when re-posting, it already
takes quite some time to review the entire driver.

Thanks,
Miquèl
