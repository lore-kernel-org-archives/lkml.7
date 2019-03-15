Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2DAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 08:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BCF721872
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 08:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbfCOIkO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 04:40:14 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:45571 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbfCOIkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 04:40:14 -0400
X-Originating-IP: 90.88.22.102
Received: from xps13 (aaubervilliers-681-1-80-102.w90-88.abo.wanadoo.fr [90.88.22.102])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 6D05F60020;
        Fri, 15 Mar 2019 08:40:10 +0000 (UTC)
Date:   Fri, 15 Mar 2019 09:40:09 +0100
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
Message-ID: <20190315094009.66b91ad5@xps13>
In-Reply-To: <20190313222259.28704-9-paul@crapouillou.net>
References: <20190313222259.28704-1-paul@crapouillou.net>
        <20190313222259.28704-9-paul@crapouillou.net>
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

Paul Cercueil <paul@crapouillou.net> wrote on Wed, 13 Mar 2019 23:22:56
+0100:

> Use the 'ecc-engine' standard property instead of the custom
> 'ingenic,bch-controller' custom property, which is now deprecated.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> Notes:
>     v5: New patch
> 
>  drivers/mtd/nand/raw/ingenic/ingenic_ecc.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/ingenic/ingenic_ecc.c b/drivers/mtd/nand/raw/ingenic/ingenic_ecc.c
> index d7f3a8c3abea..30436ca6628a 100644
> --- a/drivers/mtd/nand/raw/ingenic/ingenic_ecc.c
> +++ b/drivers/mtd/nand/raw/ingenic/ingenic_ecc.c
> @@ -82,9 +82,9 @@ static struct ingenic_ecc *ingenic_ecc_get(struct device_node *np)
>  
>  /**
>   * of_ingenic_ecc_get() - get the ECC controller from a DT node
> - * @of_node: the node that contains a bch-controller property.
> + * @of_node: the node that contains a ecc-engine property.

Would "contains an ecc-engine property" be better English?

I am not sure what is the rule when it comes to plain English with
variable names. However if you agree, no need to re-send the series, I
can fix it when applying.

BTW, I added hw ECC engines support to my generic ECC engine
implementation, but migrating the whole raw NAND subsystem (using I/O
requests like in the SPI-NAND core, adding prepare/finish_io_req hooks)
is going to be much more invasive than initially expected, so I am not
sure I will finish the migration any time soon.


Thanks,
Miquèl
