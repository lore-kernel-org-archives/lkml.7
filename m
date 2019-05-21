Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD35C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B5720863
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfEUIxH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 04:53:07 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:40947 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbfEUIxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 04:53:06 -0400
X-Originating-IP: 90.88.22.185
Received: from xps13 (aaubervilliers-681-1-80-185.w90-88.abo.wanadoo.fr [90.88.22.185])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id AD52520003;
        Tue, 21 May 2019 08:53:02 +0000 (UTC)
Date:   Tue, 21 May 2019 10:53:01 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Kamal Dasu <kdasu.kdev@gmail.com>, linux-mtd@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org,
        Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v2 2/2] mtd: nand: raw: brcmnand: fallback to detected
 ecc-strength, ecc-step-size
Message-ID: <20190521105301.26e049b5@xps13>
In-Reply-To: <63bbd3eb-60c1-042c-633c-cfa6fbef528c@gmail.com>
References: <1558379144-28283-1-git-send-email-kdasu.kdev@gmail.com>
        <1558379144-28283-2-git-send-email-kdasu.kdev@gmail.com>
        <63bbd3eb-60c1-042c-633c-cfa6fbef528c@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

Florian Fainelli <f.fainelli@gmail.com> wrote on Mon, 20 May 2019
12:11:42 -0700:

> On 5/20/19 12:05 PM, Kamal Dasu wrote:
> > This change supports nand-ecc-step-size and nand-ecc-strength fields in
> > brcmnand DT node to be optional.
> > see: Documentation/devicetree/bindings/mtd/brcm,brcmnand.txt
> > 
> > If both nand-ecc-strength and nand-ecc-step-size are not specified in
> > device tree node for NAND, raw NAND layer does detect ECC information by
> > reading ONFI extended parameter page for parts using ONFI >= 2.1.
> > In case of non-ONFI NAND parts there could be a nand_id table entry with
> > ECC information. If there is valid device tree entry for nand-ecc-strength
> > and nand-ecc-step-size fields it still shall override the detected values.
> > 
> > Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
> > ---
> >  drivers/mtd/nand/raw/brcmnand/brcmnand.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> > index ce0b8ff..a4d2057 100644
> > --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> > +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> > @@ -2144,6 +2144,17 @@ static int brcmnand_setup_dev(struct brcmnand_host *host)
> >  		return -EINVAL;
> >  	}
> >  
> > +	if (chip->ecc.mode != NAND_ECC_NONE &&
> > +	    (!chip->ecc.size || !chip->ecc.strength)) {
> > +		if (chip->base.eccreq.step_size && chip->base.eccreq.strength) {
> > +			/* use detected ECC parameters */
> > +			chip->ecc.size = chip->base.eccreq.step_size;
> > +			chip->ecc.strength = chip->base.eccreq.strength;
> > +			pr_info("Using ECC step-size %d, strength %d\n",
> > +				chip->ecc.size, chip->ecc.strength);  
> 
> Nit: should not we use dev_info(&host->pdev->dev) for printing the
> message in case we have multiple NAND controllers on chip, that way we
> can still differentiate them from the prints?

Yes, that would fit what the rest of the driver does. After that I
think the patchset will be ready.

Thanks,
Miquèl
