Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710CFC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 449BA20823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfCDTHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 14:07:38 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:57731 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbfCDTHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 14:07:37 -0500
Received: from xps13 (76.15.136.77.rev.sfr.net [77.136.15.76])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id E86A724000A;
        Mon,  4 Mar 2019 19:07:27 +0000 (UTC)
Date:   Mon, 4 Mar 2019 20:07:25 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 7/9] mtd: rawnand: ingenic: Add support for the
 JZ4740
Message-ID: <20190304200725.28b072a8@xps13>
In-Reply-To: <1551724129.4932.5@crapouillou.net>
References: <20190209192305.4434-1-paul@crapouillou.net>
        <20190209192305.4434-7-paul@crapouillou.net>
        <20190304113412.24b64e3d@xps13>
        <1551724129.4932.5@crapouillou.net>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Paul Cercueil <paul@crapouillou.net> wrote on Mon, 04 Mar 2019 19:28:49
+0100:

> On Mon, Mar 4, 2019 at 11:34 AM, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > Hi Paul,
> > 
> > Paul Cercueil <paul@crapouillou.net <mailto:paul@crapouillou.net>> > wrote on Sat,  9 Feb 2019 16:23:03
> > -0300:
> >   
> >>  Add support for probing the ingenic-nand driver on the JZ4740 SoC >> from
> >>  Ingenic, and the jz4740-ecc driver to support the JZ4740-specific
> >>  ECC hardware.  
> >> >>  Signed-off-by: Paul Cercueil <paul@crapouillou.net >> <mailto:paul@crapouillou.net>>  
> >>  ---  
> >> >>  Changes:
> >> >>  v2: New patch
> >> >>  v3: Also add support for the hardware ECC of the JZ4740 in this >> patch
> >> >>  v4: - Fix formatting issues  
> >>      - Add MODULE_* macros  
> >> >>   drivers/mtd/nand/raw/ingenic/Kconfig        |  10 ++  
> >>   drivers/mtd/nand/raw/ingenic/Makefile       |   1 +
> >>   drivers/mtd/nand/raw/ingenic/ingenic_nand.c |  48 +++++--
> >>   drivers/mtd/nand/raw/ingenic/jz4740_ecc.c   | 196 >> ++++++++++++++++++++++++++++
> >>   4 files changed, 244 insertions(+), 11 deletions(-)
> >>   create mode 100644 drivers/mtd/nand/raw/ingenic/jz4740_ecc.c  
> >> >   
> > [...]
> >   
> >>   	switch (chip->ecc.mode) {
> >>   	case NAND_ECC_HW:
> >>  @@ -270,8 +279,8 @@ static int ingenic_nand_init_chip(struct >> platform_device *pdev,
> >>   		return -ENOMEM;
> >>   	mtd->dev.parent = dev;  
> >> >>  -	chip->legacy.IO_ADDR_R = cs->base + OFFSET_DATA;  
> >>  -	chip->legacy.IO_ADDR_W = cs->base + OFFSET_DATA;
> >>  +	chip->legacy.IO_ADDR_R = cs->base + nfc->soc_info->data_offset;
> >>  +	chip->legacy.IO_ADDR_W = cs->base + nfc->soc_info->data_offset;
> >>   	chip->legacy.chip_delay = RB_DELAY_US;
> >>   	chip->options = NAND_NO_SUBPAGE_WRITE;
> >>   	chip->legacy.select_chip = ingenic_nand_select_chip;  
> > 
> > I think Boris already asked for it, but it would be really great that
> > you update this driver to not use any legacy interface anymore.  
> 
> I thought I'd send a patch later. But I don't mind doing the update in
> this patchset.

Great! No it's okay, don't delay this patch set, doing it in another
thread is fine.

