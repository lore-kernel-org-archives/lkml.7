Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86A4C5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 07:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97414208C4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 07:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbfGAHOG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 03:14:06 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:48267 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727723AbfGAHOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 03:14:04 -0400
X-Originating-IP: 86.250.200.211
Received: from xps13 (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 929212000C;
        Mon,  1 Jul 2019 07:14:01 +0000 (UTC)
Date:   Mon, 1 Jul 2019 09:14:00 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>, Han Xu <han.xu@nxp.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] mtd: rawnand: gpmi: remove double assignment to
 block_size
Message-ID: <20190701091352.3e3caf11@xps13>
In-Reply-To: <20190604105859.16627-1-colin.king@canonical.com>
References: <20190604105859.16627-1-colin.king@canonical.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20190701071400.u9y2YPzkvJYlqWmnqT2mBbQ3gOWGF9uVZOhjEUBKQJI@z>

Hi Colin,

Colin King <colin.king@canonical.com> wrote on Tue,  4 Jun 2019
11:58:59 +0100:

> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable block_size is being assigned to itself and to
> geo->ecc_chunk_size.  Clean up the double assignment by removing
> the assignment to itself.
> 
> Addresses-Coverity: ("Evaluation order violation")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
> index 5db84178edff..334fe3130285 100644
> --- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
> +++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
> @@ -1428,7 +1428,7 @@ static void gpmi_bch_layout_std(struct gpmi_nand_data *this)
>  	struct bch_geometry *geo = &this->bch_geometry;
>  	unsigned int ecc_strength = geo->ecc_strength >> 1;
>  	unsigned int gf_len = geo->gf_len;
> -	unsigned int block_size = block_size = geo->ecc_chunk_size;
> +	unsigned int block_size = geo->ecc_chunk_size;
>  
>  	this->bch_flashlayout0 =
>  		BF_BCH_FLASH0LAYOUT0_NBLOCKS(geo->ecc_chunk_count - 1) |



Applied to nand/next, thanks.

Miquèl
