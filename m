Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49337C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 11:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A1C7218A5
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 11:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbfGCLkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 07:40:43 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38240 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfGCLkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 07:40:43 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 2AD2B28A8AB;
        Wed,  3 Jul 2019 12:40:41 +0100 (BST)
Date:   Wed, 3 Jul 2019 13:40:38 +0200
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
Message-ID: <20190703134038.4256bb43@collabora.com>
In-Reply-To: <DM6PR02MB47793413E233EE8ECB54BC66AFFB0@DM6PR02MB4779.namprd02.prod.outlook.com>
References: <20190625044630.31717-1-naga.sureshkumar.relli@xilinx.com>
        <20190625044630.31717-2-naga.sureshkumar.relli@xilinx.com>
        <20190703082544.5b0ea566@collabora.com>
        <DM6PR02MB47792A7E700248348DAD9F78AFFB0@DM6PR02MB4779.namprd02.prod.outlook.com>
        <20190703130658.2abe5096@collabora.com>
        <DM6PR02MB47793413E233EE8ECB54BC66AFFB0@DM6PR02MB4779.namprd02.prod.outlook.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jul 2019 11:29:49 +0000
Naga Sureshkumar Relli <nagasure@xilinx.com> wrote:

> Hi Boris,
> 
> > -----Original Message-----
> > From: Boris Brezillon <boris.brezillon@collabora.com>
> > Sent: Wednesday, July 3, 2019 4:37 PM
> > To: Naga Sureshkumar Relli <nagasure@xilinx.com>
> > Cc: miquel.raynal@bootlin.com; helmut.grohne@intenta.de; richard@nod.at;
> > dwmw2@infradead.org; computersforpeace@gmail.com; marek.vasut@gmail.com;
> > bbrezillon@kernel.org; yamada.masahiro@socionext.com; linux-mtd@lists.infradead.org; linux-
> > kernel@vger.kernel.org; Michal Simek <michals@xilinx.com>
> > Subject: Re: [LINUX PATCH v17 2/2] mtd: rawnand: pl353: Add basic driver for arm pl353
> > smc nand interface
> > 
> > On Wed, 3 Jul 2019 08:57:57 +0000
> > Naga Sureshkumar Relli <nagasure@xilinx.com> wrote:
> >   
> > > Hi Boris,
> > >
> > > Thanks for the review.
> > >  
> > > > -----Original Message-----
> > > > From: Boris Brezillon <boris.brezillon@collabora.com>
> > > > Sent: Wednesday, July 3, 2019 11:56 AM
> > > > To: Naga Sureshkumar Relli <nagasure@xilinx.com>
> > > > Cc: miquel.raynal@bootlin.com; helmut.grohne@intenta.de;
> > > > richard@nod.at; dwmw2@infradead.org; computersforpeace@gmail.com;
> > > > marek.vasut@gmail.com; vigneshr@ti.com; bbrezillon@kernel.org;
> > > > yamada.masahiro@socionext.com; linux- mtd@lists.infradead.org;
> > > > linux-kernel@vger.kernel.org
> > > > Subject: Re: [LINUX PATCH v17 2/2] mtd: rawnand: pl353: Add basic
> > > > driver for arm pl353 smc nand interface
> > > >
> > > > On Mon, 24 Jun 2019 22:46:30 -0600
> > > > Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com> wrote:
> > > >
> > > >  
> > > > > +
> > > > > +/**
> > > > > + * pl353_nand_exec_op_cmd - Send command to NAND device
> > > > > + * @chip:	Pointer to the NAND chip info structure
> > > > > + * @subop:	Pointer to array of instructions
> > > > > + * Return:	Always return zero
> > > > > + */
> > > > > +static int pl353_nand_exec_op_cmd(struct nand_chip *chip,
> > > > > +				  const struct nand_subop *subop) {
> > > > > +	struct mtd_info *mtd = nand_to_mtd(chip);
> > > > > +	const struct nand_op_instr *instr;
> > > > > +	struct pl353_nfc_op nfc_op = {};
> > > > > +	struct pl353_nand_controller *xnfc = to_pl353_nand(chip);
> > > > > +	unsigned long cmd_phase_data = 0, end_cmd_valid = 0;
> > > > > +	unsigned long end_cmd;
> > > > > +	unsigned int op_id, len;
> > > > > +	bool reading;
> > > > > +	u32 cmdphase_addrflags;
> > > > > +
> > > > > +	pl353_nfc_parse_instructions(chip, subop, &nfc_op);
> > > > > +	instr = nfc_op.data_instr;
> > > > > +	op_id = nfc_op.data_instr_idx;
> > > > > +	pl353_smc_clr_nand_int();
> > > > > +
> > > > > +	/* Get the command phase address */
> > > > > +	if (nfc_op.cmnds[1] != 0) {
> > > > > +		if (nfc_op.cmnds[0] == NAND_CMD_SEQIN)
> > > > > +			end_cmd_valid = 0;
> > > > > +		else
> > > > > +			end_cmd_valid = 1;  
> > > >
> > > > You're testing the opcode, again. As I said several times, the  
> > > > ->exec_op() implementation should be opcode agnostic, it should just
> > > > ->try  
> > > > to match sequences of <CMD>-<ADDR>-<DATA> cycles.
> > > >  
> > > This driver uses common function for all patterns.
> > > There was some discussion happened on v8 series
> > > https://lore.kernel.org/patchwork/patch/933639/
> > > There the comments from Miquel was to use an optional property In the
> > > pattern Matching, so with this approach, based on the command need to
> > > update the end_cmd_valid bit in command phase cycle.
> > > So in order to follow that approach, we defined a common pattern
> > > matching function And there we are checking the commands.
> > > It significantly reduces the code repetition.  
> > 
> > That's not what I'm talking about. I'm talking about the explicit 'nfc_op.cmnds[0] ==
> > NAND_CMD_SEQIN' check, which AFAICT, is wrong, or at the very least, not future-proof
> > at all.  
> Ok.
> > 
> > Let me see if I understand what end_cmd_valid means: it's supposed to be set when the ADDR
> > cycles are followed by a CMD cycle. You don't need to check if the first CMD cycle is !SEQIN
> > (AKA start programming a page) to know that: just go through the flow of instructions in the
> > subop, and check what's coming just after the ADDR instruction.  
> Ok. then let me update as per the flow of instructions.
> >   
> > >
> > > I understand your concern about not to check any NAND command in the
> > > drivers under ->exec_op() implementation.
> > > But do you see any issues/impact with this?  
> > 
> > Yes, I do. Sorry to say that, but the whole driver is coded with specific use-cases (read/write
> > page, read param page, etc) in mind, which is exactly what we were trying to avoid when
> > designing exec_op(). The goal was to have something that's easily maintainable and does not
> > break every time one tests a previously untested chip <-> controller combination.
> >   
> Ok. I understand.
> 
> > > Functionality wise Helmut tested each series and we addressed all the comments in v17  
> > series.
> > 
> > Just because it's been tested does not mean it's ready to be merged, sorry.
> >   
> Ok. I will submit next version with the above changes.

Note that I didn't bother reading the whole driver, just focused on the
exec_op() implementation. Please look at what other drivers are doing
before posting a new version and don't hesitate to ask questions if
there's something you don't understand. We are already at v17, and
unfortunately, the driver is IMO not ready to be merged :-/.
