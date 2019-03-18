Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1898C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 21:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83929213F2
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 21:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfCRVjP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 17:39:15 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:38261 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbfCRVjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 17:39:15 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id CD94AFF806;
        Mon, 18 Mar 2019 21:39:06 +0000 (UTC)
Date:   Mon, 18 Mar 2019 22:39:05 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>, od@zcrc.me,
        Mathieu Malaterre <malat@debian.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 09/12] mtd: rawnand: ingenic: Make use of ecc-engine
 property
Message-ID: <20190318223905.18f020f2@xps13>
In-Reply-To: <1552941429.1495.0@crapouillou.net>
References: <20190313222259.28704-1-paul@crapouillou.net>
        <20190313222259.28704-9-paul@crapouillou.net>
        <20190315094009.66b91ad5@xps13>
        <1552660654.1727.0@crapouillou.net>
        <1552941429.1495.0@crapouillou.net>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Paul Cercueil <paul@crapouillou.net> wrote on Mon, 18 Mar 2019 21:37:09
+0100:

> Hi,
> 
> Le ven. 15 mars 2019 à 15:37, Paul Cercueil <paul@crapouillou.net> a écrit :
> > Hi,
> > 
> > Le ven. 15 mars 2019 à 9:40, Miquel Raynal > <miquel.raynal@bootlin.com> a écrit :  
> >> Hi Paul,  
> >> >> Paul Cercueil <paul@crapouillou.net> wrote on Wed, 13 Mar 2019 >> 23:22:56  
> >> +0100:  
> >> >>>  Use the 'ecc-engine' standard property instead of the custom  
> >>>  'ingenic,bch-controller' custom property, which is now deprecated.  
> >>> >>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>  
> >>>  ---  
> >>> >>>  Notes:  
> >>>      v5: New patch  
> >>> >>>   drivers/mtd/nand/raw/ingenic/ingenic_ecc.c | 13 ++++++++++---  
> >>>   1 file changed, 10 insertions(+), 3 deletions(-)  
> >>> >>>  diff --git a/drivers/mtd/nand/raw/ingenic/ingenic_ecc.c >>> b/drivers/mtd/nand/raw/ingenic/ingenic_ecc.c  
> >>>  index d7f3a8c3abea..30436ca6628a 100644
> >>>  --- a/drivers/mtd/nand/raw/ingenic/ingenic_ecc.c
> >>>  +++ b/drivers/mtd/nand/raw/ingenic/ingenic_ecc.c
> >>>  @@ -82,9 +82,9 @@ static struct ingenic_ecc >>> *ingenic_ecc_get(struct device_node *np)  
> >>> >>>   /**  
> >>>    * of_ingenic_ecc_get() - get the ECC controller from a DT node
> >>>  - * @of_node: the node that contains a bch-controller property.
> >>>  + * @of_node: the node that contains a ecc-engine property.  
> >> >> Would "contains an ecc-engine property" be better English?
> >> >> I am not sure what is the rule when it comes to plain English with  
> >> variable names. However if you agree, no need to re-send the series, >> I
> >> can fix it when applying.  
> > 
> > Yes, that's better.
> >   
> >> BTW, I added hw ECC engines support to my generic ECC engine
> >> implementation, but migrating the whole raw NAND subsystem (using I/O
> >> requests like in the SPI-NAND core, adding prepare/finish_io_req >> hooks)
> >> is going to be much more invasive than initially expected, so I am >> not
> >> sure I will finish the migration any time soon.  
> > 
> > Ok, I will follow the development then.
> >   
> >> Thanks,
> >> Miquèl  
> > 
> > One thing I notice with my patchset: it works perfectly on top of > 4.20,
> > but on top of 5.0 I am unable to erase any eraseblock with > flash_erase.
> > I get -EIO every time. I'm trying to debug it but didn't go very far,
> > it looks like nand_status_op() gives me a status of 0xff. Do you know
> > what could have changed between 4.20 and 5.0 that could trigger this > bug?  
> 
> Nevermind. It works now.

Great!

> 
> > Second thing, everytime I reboot it fails to find the BBT. That's > because
> > the BBT marker is overwritten by the ECC data as they occupy the same > area
> > in the OOB space. Is there a way to move the BBT marker? Or should I > use
> > NAND_BBT_NO_OOB then? Since the eraseblocks where the BBTs are located
> > is used in my system partition, won't that conflict with the data?  
> 
> Response to myself: It's possible to move the BBT marker. But in my case I
> have to deal with three possible layouts, so it's simpler to just use
> NAND_BBT_NO_OOB then. The BBT pages are marked so that they're not used
> for data in the partitions.

Maybe you should check Frieder's series:

mtd: rawnand: Support bad block markers in first, second or last page


Thanks,
Miquèl
