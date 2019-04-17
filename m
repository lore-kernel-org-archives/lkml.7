Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD67DC10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 10:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E3B620835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 10:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbfDQKIJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 06:08:09 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:38637 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbfDQKII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 06:08:08 -0400
X-Originating-IP: 90.88.160.238
Received: from xps13 (aaubervilliers-681-1-42-238.w90-88.abo.wanadoo.fr [90.88.160.238])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 69223C0007;
        Wed, 17 Apr 2019 10:08:06 +0000 (UTC)
Date:   Wed, 17 Apr 2019 12:08:05 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "richard@nod.at" <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH v4 6/7] mtd: rawnand: ESMT: Also use the last page for
 bad block markers
Message-ID: <20190417120805.6727d78f@xps13>
In-Reply-To: <20190218104122.18788-7-frieder.schrempf@kontron.de>
References: <20190218104122.18788-1-frieder.schrempf@kontron.de>
        <20190218104122.18788-7-frieder.schrempf@kontron.de>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frieder,

Schrempf Frieder <frieder.schrempf@kontron.de> wrote on Mon, 18 Feb
2019 10:42:45 +0000:

> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> It is known that some ESMT SLC NANDs have been shipped
> with the factory bad block markers in the first or last page
> of the block, instead of the first or second page. To be on
> the safe side, let's check all three locations.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>
> ---
>  drivers/mtd/nand/raw/nand_esmt.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/nand_esmt.c b/drivers/mtd/nand/raw/nand_esmt.c
> index 99a8092969a7..b37e0b5af5ae 100644
> --- a/drivers/mtd/nand/raw/nand_esmt.c
> +++ b/drivers/mtd/nand/raw/nand_esmt.c
> @@ -36,7 +36,14 @@ static void esmt_nand_decode_id(struct nand_chip *chip)
>  static int esmt_nand_init(struct nand_chip *chip)
>  {
>  	if (nand_is_slc(chip))
> -		chip->options |= NAND_BBM_FIRSTPAGE | NAND_BBM_SECONDPAGE;
> +		/*
> +		 * It is known that some ESMT SLC NANDs have been shipped
> +		 * with the factory bad block markers in the first or last page
> +		 * of the block, instead of the first or second page. To be on
> +		 * the safe side, let's check all three locations.
> +		 */
> +		chip->options |= NAND_BBM_FIRSTPAGE | NAND_BBM_SECONDPAGE |
> +				 NAND_BBM_LASTPAGE;
>  
>  	return 0;
>  }


Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>


Thanks,
Miquèl
