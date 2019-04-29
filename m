Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D12C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 12:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 534DE20578
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 12:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intenta.de header.i=@intenta.de header.b="ALeTwT0e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbfD2MSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 08:18:13 -0400
Received: from mail.intenta.de ([178.249.25.132]:42048 "EHLO mail.intenta.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727913AbfD2MSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 08:18:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=intenta.de; s=dkim1;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:CC:To:From:Date; bh=GsgfomPI48frMwHsrKwfP6EpSKbwk1M7gVzGRCF4Huo=;
        b=ALeTwT0eDipZWZtaQ2IwQ+kfhchGFxK8it0sC6oWybVJuhNWFdoNJGGa7pjOkIhA6xbpsEbCOihPJqqabpizPwmwe1QshL0PDb7YK2j5cnisRbgoLoN1GafLZXBjLqEqsNvj6J4JbVY/jkJiwYr2NRzXC8lifYY4TEgxO1lYf73V5dA8VEI6pUq/mhMS7RvcGwKSG7FqGFqOGKdIUeXvr7sj5JwUI6aM1Mxh5LXfI9enM04h5AZMxGze2t22+5HuvOhF8tz1BUYWYTNZbGYjbUfle6HXsvJULWN9lFaqopHwxMNLTxbMICjZUS+fVxM/xqfO1sDf24Ry4APSZq/+AA==;
X-CTCH-RefID: str=0001.0A0C0212.5CC6EB80.0008,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Date:   Mon, 29 Apr 2019 14:18:06 +0200
From:   Helmut Grohne <helmut.grohne@intenta.de>
To:     Naga Sureshkumar Relli <nagasure@xilinx.com>
CC:     "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
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
Message-ID: <20190429121804.4jzspv4goehwdpez@laureti-dev>
References: <1555326613-26739-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <20190425112338.dipgmqqfuj45gx6s@laureti-dev>
 <DM6PR02MB4779EE37978EC0E6475C55D7AF390@DM6PR02MB4779.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DM6PR02MB4779EE37978EC0E6475C55D7AF390@DM6PR02MB4779.namprd02.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: ICSMA002.intenta.de (10.10.16.48) To ICSMA002.intenta.de
 (10.10.16.48)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 11:31:14AM +0000, Naga Sureshkumar Relli wrote:
> But just wanted to know, do you see issues with these __force and __iomem castings?

I only see a minor issue: They're (deliberately) lengthy. Using many of
them diverts attention of the reader. Therefore, my proposal attempted
to reduce their frequency. The only issue I see here is readability.

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

Not quite. You're getting a clock reference in probe and then repeatedly
access the frequency elswhere. I am suggesting that you get the clock
frequency during probe and never save the clock reference to a struct.

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

I compared this code to marvell_nand.c and noticed a subtle difference.
Both snippets read 6 address bytes and consume them in a driver-specific
way. Now which address bytes are consumed differs.

marvell_nand.c consumes instr->ctx.addr.addrs at indices offset,
offset+1, offset+2, offset+3, offset+4, offset+5. pl353_nand.c consumes
instr->ctx.addr.addrs at indices 0, 1, 2, 3, offset, offset+4, offset+5.
(In my previous mail, I didn't notice that it was also consuming the
offset index.)

I would have expected this behaviour to be consistent between different
drivers. If I assume marvell_nand.c to do the right thing and
pl353_nand.c to be wrong (which is not necessarily a correct
assumption), then the code woule likely becom:

	addrs = &instr->ctx.addr.addrs[offset];
	for (i = 0; i < min_t(unsigned int, 4, naddrs); i++) {
		nfc_op->addrs |= addrs[i] << (8 * i);
		              // ^^^^^
	}

Hope this helps.

Helmut
