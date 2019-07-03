Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5C5C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 11:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6074D21882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 11:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfGCLHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 07:07:04 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37924 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfGCLHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 07:07:03 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 9BFB128A8B7;
        Wed,  3 Jul 2019 12:07:01 +0100 (BST)
Date:   Wed, 3 Jul 2019 13:06:58 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Naga Sureshkumar Relli <nagasure@xilinx.com>
Cc:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "helmut.grohne@intenta.de" <helmut.grohne@intenta.de>,
        "richard@nod.at" <richard@nod.at>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <michals@xilinx.com>
Subject: Re: [LINUX PATCH v17 2/2] mtd: rawnand: pl353: Add basic driver for
 arm  pl353 smc nand interface
Message-ID: <20190703130658.2abe5096@collabora.com>
In-Reply-To: <DM6PR02MB47792A7E700248348DAD9F78AFFB0@DM6PR02MB4779.namprd02.prod.outlook.com>
References: <20190625044630.31717-1-naga.sureshkumar.relli@xilinx.com>
        <20190625044630.31717-2-naga.sureshkumar.relli@xilinx.com>
        <20190703082544.5b0ea566@collabora.com>
        <DM6PR02MB47792A7E700248348DAD9F78AFFB0@DM6PR02MB4779.namprd02.prod.outlook.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jul 2019 08:57:57 +0000
Naga Sureshkumar Relli <nagasure@xilinx.com> wrote:

> Hi Boris,
> 
> Thanks for the review.
> 
> > -----Original Message-----
> > From: Boris Brezillon <boris.brezillon@collabora.com>
> > Sent: Wednesday, July 3, 2019 11:56 AM
> > To: Naga Sureshkumar Relli <nagasure@xilinx.com>
> > Cc: miquel.raynal@bootlin.com; helmut.grohne@intenta.de; richard@nod.at;
> > dwmw2@infradead.org; computersforpeace@gmail.com; marek.vasut@gmail.com;
> > vigneshr@ti.com; bbrezillon@kernel.org; yamada.masahiro@socionext.com; linux-
> > mtd@lists.infradead.org; linux-kernel@vger.kernel.org
> > Subject: Re: [LINUX PATCH v17 2/2] mtd: rawnand: pl353: Add basic driver for arm pl353
> > smc nand interface
> > 
> > On Mon, 24 Jun 2019 22:46:30 -0600
> > Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com> wrote:
> > 
> >   
> > > +
> > > +/**
> > > + * pl353_nand_exec_op_cmd - Send command to NAND device
> > > + * @chip:	Pointer to the NAND chip info structure
> > > + * @subop:	Pointer to array of instructions
> > > + * Return:	Always return zero
> > > + */
> > > +static int pl353_nand_exec_op_cmd(struct nand_chip *chip,
> > > +				  const struct nand_subop *subop) {
> > > +	struct mtd_info *mtd = nand_to_mtd(chip);
> > > +	const struct nand_op_instr *instr;
> > > +	struct pl353_nfc_op nfc_op = {};
> > > +	struct pl353_nand_controller *xnfc = to_pl353_nand(chip);
> > > +	unsigned long cmd_phase_data = 0, end_cmd_valid = 0;
> > > +	unsigned long end_cmd;
> > > +	unsigned int op_id, len;
> > > +	bool reading;
> > > +	u32 cmdphase_addrflags;
> > > +
> > > +	pl353_nfc_parse_instructions(chip, subop, &nfc_op);
> > > +	instr = nfc_op.data_instr;
> > > +	op_id = nfc_op.data_instr_idx;
> > > +	pl353_smc_clr_nand_int();
> > > +
> > > +	/* Get the command phase address */
> > > +	if (nfc_op.cmnds[1] != 0) {
> > > +		if (nfc_op.cmnds[0] == NAND_CMD_SEQIN)
> > > +			end_cmd_valid = 0;
> > > +		else
> > > +			end_cmd_valid = 1;  
> > 
> > You're testing the opcode, again. As I said several times, the  
> > ->exec_op() implementation should be opcode agnostic, it should just try  
> > to match sequences of <CMD>-<ADDR>-<DATA> cycles.
> >   
> This driver uses common function for all patterns.
> There was some discussion happened on v8 series 
> https://lore.kernel.org/patchwork/patch/933639/
> There the comments from Miquel was to use an optional property In the pattern
> Matching, so with this approach, based on the command need to update the 
> end_cmd_valid bit in command phase cycle.
> So in order to follow that approach, we defined a common pattern matching function
> And there we are checking the commands.
> It significantly reduces the code repetition.

That's not what I'm talking about. I'm talking about the explicit
'nfc_op.cmnds[0] == NAND_CMD_SEQIN' check, which AFAICT, is wrong, or at
the very least, not future-proof at all.

Let me see if I understand what end_cmd_valid means: it's supposed to
be set when the ADDR cycles are followed by a CMD cycle. You don't need
to check if the first CMD cycle is !SEQIN (AKA start programming a page)
to know that: just go through the flow of instructions in the subop,
and check what's coming just after the ADDR instruction.

> 
> I understand your concern about not to check any NAND command in the drivers
> under ->exec_op() implementation.
> But do you see any issues/impact with this?

Yes, I do. Sorry to say that, but the whole driver is coded with
specific use-cases (read/write page, read param page, etc) in mind,
which is exactly what we were trying to avoid when designing
exec_op(). The goal was to have something that's easily maintainable and
does not break every time one tests a previously untested chip <->
controller combination.

> Functionality wise Helmut tested each series and we addressed all the comments in v17 series.

Just because it's been tested does not mean it's ready to be merged,
sorry.

> 
> Could you please let me know what do you say?
> 
> > > +	}
> > > +
> > > +	end_cmd = nfc_op.cmnds[1];
> > > +
> > > +	/*
> > > +	 * The SMC defines two phases of commands when transferring data to or
> > > +	 * from NAND flash.
> > > +	 * Command phase: Commands and optional address information are written
> > > +	 * to the NAND flash.The command and address can be associated with
> > > +	 * either a data phase operation to write to or read from the array,
> > > +	 * or a status/ID register transfer.
> > > +	 * Data phase: Data is either written to or read from the NAND flash.
> > > +	 * This data can be either data transferred to or from the array,
> > > +	 * or status/ID register information.
> > > +	 */
> > > +	cmdphase_addrflags = ((nfc_op.naddrs << ADDR_CYCLES_SHIFT) |
> > > +			 (end_cmd_valid << END_CMD_VALID_SHIFT) |
> > > +			 (COMMAND_PHASE) |
> > > +			 (end_cmd << END_CMD_SHIFT) |
> > > +			 (nfc_op.cmnds[0] << START_CMD_SHIFT));
> > > +
> > > +	/* Get the data phase address */
> > > +	end_cmd_valid = 0;
> > > +
> > > +	xnfc->dataphase_addrflags = ((0x0 << CLEAR_CS_SHIFT) |
> > > +			  (end_cmd_valid << END_CMD_VALID_SHIFT) |
> > > +			  (DATA_PHASE) |
> > > +			  (end_cmd << END_CMD_SHIFT) |
> > > +			  (0x0 << ECC_LAST_SHIFT));
> > > +
> > > +	/* Command phase AXI Read & Write */
> > > +	if (nfc_op.naddrs >= 5) {
> > > +		if (mtd->writesize > PL353_NAND_ECC_SIZE) {
> > > +			cmd_phase_data = nfc_op.addrs;
> > > +
> > > +			/* Another address cycle for devices > 128MiB */
> > > +			if (chip->options & NAND_ROW_ADDR_3) {  
> > 
> > Clearly, none of this belongs in the ->exec_op() implementation. Looks like something related
> > to page read...  
> As I mentioned above in comments of pl353_exec_op(), the PL353 SMC
> Controller uses command phase and data phase.
> And in the Command phase, command and optional addresses are written to NAND flash.
> And it is correct as you said, it looks like page reads but it is actually a command phase address
> update.

You have the exact number of ADDR cycles to issue in the ADDR
instruction, why do you need to check NAND_ROW_ADDR_3 at all?
