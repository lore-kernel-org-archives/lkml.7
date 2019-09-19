Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790D7C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 12:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 525D321907
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 12:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389733AbfISM6Y convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 08:58:24 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:56931 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387712AbfISM6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 08:58:24 -0400
Received: from xps13 (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 36BFB240005;
        Thu, 19 Sep 2019 12:58:19 +0000 (UTC)
Date:   Thu, 19 Sep 2019 14:58:19 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Piotr Sroka <piotrs@cadence.com>
Cc:     Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] - change calculating of position page containing BBM
Message-ID: <20190919145819.66e74aef@xps13>
In-Reply-To: <20190919124139.10856-1-piotrs@cadence.com>
References: <20190919124139.10856-1-piotrs@cadence.com>
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

Piotr Sroka <piotrs@cadence.com> wrote on Thu, 19 Sep 2019 13:41:35
+0100:

> Change calculating of position page containing BBM
> 
> If none of BBM flags is set then function nand_bbm_get_next_page 
> reports EINVAL. It causes that BBM is not read at all during scanning
> factory bad blocks. The result is that the BBT table is build without 
> checking factory BBM at all. For Micron flash memories none of this 
> flag is set if page size is different than 2048 bytes.

"none of these flags are set"

> 
> This patch changes the nand_bbm_get_next_page function.

"Address this regression by changing the
nand_bbm_get_next_page_function."

> It will return 0 if none of BBM flag is set and page parameter is 0. 

                      no BBM flag is set

> After that modification way of discovering factory bad blocks will work 
> similar as in kernel version 5.1.
> 

Fixes + stable tags would be great!

> Signed-off-by: Piotr Sroka <piotrs@cadence.com>
> ---
>  drivers/mtd/nand/raw/nand_base.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> index 5c2c30a7dffa..f64e3b6605c6 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -292,12 +292,16 @@ int nand_bbm_get_next_page(struct nand_chip *chip, int page)
>  	struct mtd_info *mtd = nand_to_mtd(chip);
>  	int last_page = ((mtd->erasesize - mtd->writesize) >>
>  			 chip->page_shift) & chip->pagemask;
> +	unsigned int bbm_flags = NAND_BBM_FIRSTPAGE | NAND_BBM_SECONDPAGE
> +		| NAND_BBM_LASTPAGE;
>  
> +	if (page == 0 && !(chip->options & bbm_flags))
> +		return 0;
>  	if (page == 0 && chip->options & NAND_BBM_FIRSTPAGE)
>  		return 0;
> -	else if (page <= 1 && chip->options & NAND_BBM_SECONDPAGE)
> +	if (page <= 1 && chip->options & NAND_BBM_SECONDPAGE)
>  		return 1;
> -	else if (page <= last_page && chip->options & NAND_BBM_LASTPAGE)
> +	if (page <= last_page && chip->options & NAND_BBM_LASTPAGE)
>  		return last_page;
>  
>  	return -EINVAL;

Lookgs good otherwise.

Thanks,
Miquèl
