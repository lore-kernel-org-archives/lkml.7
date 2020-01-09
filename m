Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C655BC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 17:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2D01206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 17:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387987AbgAIRWr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 12:22:47 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:43235 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731563AbgAIRWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 12:22:47 -0500
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 20A53C0006;
        Thu,  9 Jan 2020 17:22:43 +0000 (UTC)
Date:   Thu, 9 Jan 2020 18:22:42 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Martin DEVERA <devik@eaxlabs.cz>
Cc:     linux-kernel@vger.kernel.org, jan.pohanka@merz.cz,
        Christophe Kerello <christophe.kerello@st.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH] mtd: rawnand: Fix unexpected timeouts in waitrdy
Message-ID: <20200109182242.03743cf7@xps13>
In-Reply-To: <73164aea-d889-21e4-4e7d-345ebd4e5197@eaxlabs.cz>
References: <20191210150319.3125-1-devik@eaxlabs.cz>
        <20200109163752.621c6248@xps13>
        <73164aea-d889-21e4-4e7d-345ebd4e5197@eaxlabs.cz>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

Martin DEVERA <devik@eaxlabs.cz> wrote on Thu, 9 Jan 2020 17:17:30
+0100:

> On 1/9/20 4:37 PM, Miquel Raynal wrote:
> > Hi Martin,
> >
> > Martin Devera <devik@eaxlabs.cz> wrote on Tue, 10 Dec 2019 16:03:18
> > +0100:
> >  
> >> The used way to compute jiffies timeout brokes when
> >> jiffie difference is 1. Simply add 1 - it has no other
> >> side effects.
> >> Fixes STM32MP1 FMC2 NAND controller which sometimes failed
> >> exactly in this way.
> >>
> >> Signed-off-by: Martin Devera <devik@eaxlabs.cz>
> >> ---
> >>   drivers/mtd/nand/raw/nand_base.c | 6 +++++-
> >>   1 file changed, 5 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> >> index d527e448ce19..beab3a775cc7 100644
> >> --- a/drivers/mtd/nand/raw/nand_base.c
> >> +++ b/drivers/mtd/nand/raw/nand_base.c
> >> @@ -721,7 +721,11 @@ int nand_soft_waitrdy(struct nand_chip *chip, unsigned long timeout_ms)
> >>   	if (ret)
> >>   		return ret;  
> >>   >> -	timeout_ms = jiffies + msecs_to_jiffies(timeout_ms);  
> >> +	/* +1 below is necessary because if we are now in the last fraction
> >> +	 * of jiffy and msecs_to_jiffies is 1 then we will wait only that
> >> +	 * small jiffy fraction - possibly leading to false timeout
> >> +	 */
> >> +	timeout_ms = jiffies + msecs_to_jiffies(timeout_ms) + 1;
> >>   	do {
> >>   		ret = nand_read_data_op(chip, &status, sizeof(status), true);
> >>   		if (ret)  
> > I don't really what you are fixing here, I suspect the root cause to be
> > a wrongly calculated timeout_ms in the calling driver.
> >
> > It is the responsibility of the caller to use this function with a
> > relevant timeout_ms parameter. Maybe Christophe can help you here?
> >  
> Hi Miquel,
> 
> assume that nand_soft_waitrdy is called with timeout_ms==1. I suppose it is
> valid case. Jiffies are 1000 for example (assume something more like 1000.99 -
> just before incrementing to 1001).
> We compute timeout_ms = 1000+msecs_to_jiffies(1) = 1001 (at least for my jiffies rate).
> nand_read_data_op is called for the first time and returns 0. During the call jiffies changes
> to 1001 thus "while loop" ends here (wrongly).
> Notice that routine was called with expected timeout 1ms but actual timeout used was something
> between 0...1ms (which I also measured by tracing & scope on the bus).
> Or is my analysis flawed somewhere ?

I agree with your analysis. Even if nand_soft_waitrdy will no longer be
used by the stm32 driver (Christophe sent a patch for that) I am fine
applying this change.

Could you add a comment to explain the '+1' and resend?

Thanks,
Miquèl
