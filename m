Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3614C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CFC120663
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfCDTKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 14:10:11 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:37169 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbfCDTKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 14:10:10 -0500
Received: from xps13 (76.15.136.77.rev.sfr.net [77.136.15.76])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id AAA7824000A;
        Mon,  4 Mar 2019 19:10:02 +0000 (UTC)
Date:   Mon, 4 Mar 2019 20:09:47 +0100
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
Subject: Re: [PATCH v4 8/9] mtd: rawnand: ingenic: Add support for the
 JZ4725B
Message-ID: <20190304200947.69237b05@xps13>
In-Reply-To: <1551724204.4932.6@crapouillou.net>
References: <20190209192305.4434-1-paul@crapouillou.net>
        <20190209192305.4434-8-paul@crapouillou.net>
        <20190304113519.2e102b25@xps13>
        <1551724204.4932.6@crapouillou.net>
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

Paul Cercueil <paul@crapouillou.net> wrote on Mon, 04 Mar 2019 19:30:04
+0100:

> On Mon, Mar 4, 2019 at 11:35 AM, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > Hi Paul,
> > 
> > Paul Cercueil <paul@crapouillou.net <mailto:paul@crapouillou.net>> > wrote on Sat,  9 Feb 2019 16:23:04
> > -0300:
> >   
> >>  The boot ROM of the JZ4725B SoC expects a specific OOB layout on the
> >>  NAND, so we use it unconditionally in the ingenic-nand driver.  
> >> >>  Also add the jz4725b-bch driver to support the JZ4725B-specific BCH  
> >>  hardware.  
> >> >>  Signed-off-by: Paul Cercueil <paul@crapouillou.net >> <mailto:paul@crapouillou.net>>  
> >>  ---  
> >> >>  Changes:
> >> >>  v2: Instead of forcing the OOB layout, leave it to the board code or  
> >>      devicetree to decide if the jz4725b-specific layout should be >> used
> >>      or not.  
> >> >>  v3: - Revert the change in v2, as the previous behaviour was >> correct.  
> >>      - Also add support for the hardware BCH of the JZ4725B in this
> >>        patch.  
> >> >>  v4: - Add MODULE_* macros  
> >>      - Add tweaks suggested by upstream feedback  
> >> >>   drivers/mtd/nand/raw/ingenic/Kconfig        |  10 +  
> >>   drivers/mtd/nand/raw/ingenic/Makefile       |   1 +
> >>   drivers/mtd/nand/raw/ingenic/ingenic_nand.c |  48 ++++-
> >>   drivers/mtd/nand/raw/ingenic/jz4725b_bch.c  | 292 >> ++++++++++++++++++++++++++++
> >>   4 files changed, 350 insertions(+), 1 deletion(-)
> >>   create mode 100644 drivers/mtd/nand/raw/ingenic/jz4725b_bch.c  
> >> >   
> > [...]
> >   
> >>  +static int jz4725b_calculate(struct ingenic_ecc *bch,
> >>  +			     struct ingenic_ecc_params *params,
> >>  +			     const u8 *buf, u8 *ecc_code)
> >>  +{
> >>  +	int ret;
> >>  +
> >>  +	mutex_lock(&bch->lock);
> >>  +	ret = jz4725b_bch_init(bch, params, true);  
> > 
> > I really don't like this bch_init name. A BCH initialization is what > is
> > supposed to be done only once (probably at boot time), can you find a
> > better name or a better organization of the correct/calculate path?  
> 
> jz4725b_bch_setup() maybe?

Unless I am not understanding what this does, I don't get why you would
need to do this setup everytime you want to use the ECC engine. Are you
sure this is needed?

