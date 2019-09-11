Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62953C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 12:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CA352075C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 12:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbfIKM3H convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 08:29:07 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:46477 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727696AbfIKM3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 08:29:07 -0400
X-Originating-IP: 148.69.85.38
Received: from xps13 (unknown [148.69.85.38])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 43624FF812;
        Wed, 11 Sep 2019 12:29:03 +0000 (UTC)
Date:   Wed, 11 Sep 2019 14:29:01 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Piotr Sroka <piotrs@cadence.com>
Cc:     <linux-kernel@vger.kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Paul Burton <paul.burton@mips.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Stefan Agner <stefan@agner.ch>,
        <linux-mtd@lists.infradead.org>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>
Subject: Re: [v5 1/2] mtd: nand: Add new Cadence NAND driver to MTD
 subsystem
Message-ID: <20190911142901.317f8f8e@xps13>
In-Reply-To: <20190911094354.GA14863@global.cadence.com>
References: <20190725145804.8886-1-piotrs@cadence.com>
        <20190725150012.14416-1-piotrs@cadence.com>
        <20190830114645.59898cfe@xps13>
        <20190911094354.GA14863@global.cadence.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Piotr,

Piotr Sroka <piotrs@cadence.com> wrote on Wed, 11 Sep 2019 10:43:56
+0100:

> The 08/30/2019 11:46, Miquel Raynal wrote:
> >EXTERNAL MAIL
> >
> >
> >Hi Piotr,
> >
> >Piotr Sroka <piotrs@cadence.com> wrote on Thu, 25 Jul 2019 16:00:12
> >+0100:
> >
> >Subject should be: mtd: rawnand:
> >
> >Last few nits in your driver which overall looks good (see below).
> >
> >Now I'm waiting for Rob's ack on the bindings. This driver should be a
> >good candidate for 5.5.  
> 
> I think that Rob alredy review it. You can find hist review on
> https://patchwork.ozlabs.org/patch/1136932/
> Let me know if something else should be improved or fixed.

Oh right I missed it. Then just don't forget to carry the tag in your
next iteration and we'll be fine!


[...]

> >> +static irqreturn_t cadence_nand_isr(int irq, void *dev_id)
> >> +{
> >> +	struct cdns_nand_ctrl *cdns_ctrl = dev_id;
> >> +	struct cadence_nand_irq_status irq_status;
> >> +	irqreturn_t result = IRQ_NONE;
> >> +
> >> +	spin_lock(&cdns_ctrl->irq_lock);
> >> +
> >> +	if (irq_detected(cdns_ctrl, &irq_status)) {
> >> +		/* Handle interrupt. */
> >> +		/* First acknowledge it. */
> >> +		cadence_nand_clear_interrupt(cdns_ctrl, &irq_status);
> >> +		/* Status in the device context for someone to read. */
> >> +		cdns_ctrl->irq_status.status |= irq_status.status;
> >> +		cdns_ctrl->irq_status.trd_status |= irq_status.trd_status;
> >> +		cdns_ctrl->irq_status.trd_error |= irq_status.trd_error;
> >> +		/* Notify anyone who cares that it happened. */
> >> +		complete(&cdns_ctrl->complete);
> >> +		/* Tell the OS that we've handled this. */
> >> +		result = IRQ_HANDLED;
> >> +	}
> >> +	spin_unlock(&cdns_ctrl->irq_lock);  
> >
> >Your locking scheme seems wrong (maybe I'm not going deep enough in the
> >code), can you please try with LOCKDEP enabled?
> >  
> I will check it.
> At the time I can see only one problem: the cadence_nand_reset_irq function should use spin_lock_irqsave instead of spin_lock.
> Can you see any other problems?

It just felt bizarre. Just run with LOCKDEP enabled and we'll be fixed.


[...]

> >> +/* Hardware initialization. */
> >> +static int cadence_nand_hw_init(struct cdns_nand_ctrl *cdns_ctrl)
> >> +{
> >> +	int status;
> >> +	u32 reg;
> >> +
> >> +	status = cadence_nand_wait_for_value(cdns_ctrl, CTRL_STATUS,
> >> +					     1000000,
> >> +					     CTRL_STATUS_INIT_COMP, false);
> >> +	if (status)
> >> +		return status;
> >> +
> >> +	reg = readl_relaxed(cdns_ctrl->reg + CTRL_VERSION);
> >> +
> >> +	dev_info(cdns_ctrl->dev,
> >> +		 "%s: cadence nand controller version reg %x\n",
> >> +		 __func__, reg);
> >> +
> >> +	/* Disable cache and multiplane. */
> >> +	writel_relaxed(0, cdns_ctrl->reg + MULTIPLANE_CFG);
> >> +	writel_relaxed(0, cdns_ctrl->reg + CACHE_CFG);  
> >
> >Cache?
> >  
> If  feature is enabled then The NAND Flash Controller will sequence the multi-page read commands as cache read or cache program sequence. Not used by Linux driver because driver has possibility to program/read only a single page.

Indeed, that's fine then.



[...]

> >> +
> >> +	switch (status) {
> >> +	case STAT_ECC_UNCORR:
> >> +		mtd->ecc_stats.failed++;
> >> +		ecc_err_count++;
> >> +		break;
> >> +	case STAT_ECC_CORR:
> >> +		ecc_err_count = FIELD_GET(CDMA_CS_MAXERR,
> >> +					  cdns_ctrl->cdma_desc->status);
> >> +		mtd->ecc_stats.corrected += ecc_err_count;  
> >
> >Is this value the maximum number of bitflips in each chunk of the page?
> >If it returns the total number of bitflips corrected in the entire page
> >we have a problem.
> >  
> It is a maximum number of corrections applied to any ECC sector in the
> transaction.
> it looks like folowing.
> mtd->ecc_stats.corrected += max(bitflips_chunk1, bitflips_chunk2, ....)
> 
> Transaction will be marked uncorrectable if any one of the sectors is
> uncorrectable.
> It looks like following.
> if (is_chunk1_fail || is_chunk2_fail .....)
>      mtd->ecc_stats.failed++;

Fine

> 
> >> +		break;
> >> +	case STAT_ERASED:
> >> +	case STAT_OK:
> >> +		break;
> >> +	default:
> >> +		dev_err(cdns_ctrl->dev, "read page failed\n");
> >> +		return -EIO;
> >> +	}
> >> +
> >> +	if (oob_required)
> >> +		if (cadence_nand_read_bbm(chip, page, chip->oob_poi))
> >> +			return -EIO;  
> >
> >Do we really care about the BBM at this level? If we are requested to
> >read the page, I suppose we must do what is in our hands to return the
> >data? Normally this is handled in userspace directly.  
> It is because when ECC is enabled then position of "logic" spare area is
> moved.

That's sad.

> Lets say we have page size 4096 and sector size is 1024.
> Manufacturer use begining of spare area as BBM. Spare area started at
> 4096.
> In case ECC is enabled. 4096 offset is somewhere in sector 4. Start of spare are is 4096 + 3 * ecc_size. So BBM is taken from bad
> place.
> <page                                   ><spare                 >
> <sec    ><ecc><sec  ><ecc><sec  ><ecc><sec +spare dat  ><ecc>
> Therefore we need to read BBM from proper place.
> There are two "problems" which make us to read BBM separatelly.
> 
> 1. During build BBT the BBM is read by functions which are expected     to use ECC. 2. Controller interleaves the data with ECC.
> 

Thanks,
Miquèl
