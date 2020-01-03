Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96313C00523
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 09:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 737E8222C4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 09:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbgACJHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 04:07:18 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:49341 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgACJHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 04:07:18 -0500
X-Originating-IP: 90.65.102.129
Received: from localhost (lfbn-lyo-1-1670-129.w90-65.abo.wanadoo.fr [90.65.102.129])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 89633E000C;
        Fri,  3 Jan 2020 09:07:04 +0000 (UTC)
Date:   Fri, 3 Jan 2020 10:07:04 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: atmel: switch to using
 devm_fwnode_gpiod_get()
Message-ID: <20200103090704.GG3040@piout.net>
References: <20200103012238.GA3648@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200103012238.GA3648@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 02/01/2020 17:22:38-0800, Dmitry Torokhov wrote:
> devm_fwnode_get_index_gpiod_from_child() is going away as the name is
> too unwieldy, let's switch to using the new devm_fwnode_gpiod_get().
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/mtd/nand/raw/atmel/nand-controller.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
> index 8d6be90a6fe8a..849bd5f16492d 100644
> --- a/drivers/mtd/nand/raw/atmel/nand-controller.c
> +++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
> @@ -1578,9 +1578,8 @@ static struct atmel_nand *atmel_nand_create(struct atmel_nand_controller *nc,
>  
>  	nand->numcs = numcs;
>  
> -	gpio = devm_fwnode_get_index_gpiod_from_child(nc->dev, "det", 0,
> -						      &np->fwnode, GPIOD_IN,
> -						      "nand-det");
> +	gpio = devm_fwnode_gpiod_get(nc->dev, of_fwnode_hanlde(np),

Shouldn't that be of_fwnode_handle(np)?

> +				     "det", GPIOD_IN, "nand-det");
>  	if (IS_ERR(gpio) && PTR_ERR(gpio) != -ENOENT) {
>  		dev_err(nc->dev,
>  			"Failed to get detect gpio (err = %ld)\n",
> @@ -1624,9 +1623,10 @@ static struct atmel_nand *atmel_nand_create(struct atmel_nand_controller *nc,
>  			nand->cs[i].rb.type = ATMEL_NAND_NATIVE_RB;
>  			nand->cs[i].rb.id = val;
>  		} else {
> -			gpio = devm_fwnode_get_index_gpiod_from_child(nc->dev,
> -							"rb", i, &np->fwnode,
> -							GPIOD_IN, "nand-rb");
> +			gpio = devm_fwnode_gpiod_get_index(nc->dev,
> +							   of_fwnode_handle(np),
> +							   "rb", i, GPIOD_IN,
> +							   "nand-rb");
>  			if (IS_ERR(gpio) && PTR_ERR(gpio) != -ENOENT) {
>  				dev_err(nc->dev,
>  					"Failed to get R/B gpio (err = %ld)\n",
> @@ -1640,10 +1640,10 @@ static struct atmel_nand *atmel_nand_create(struct atmel_nand_controller *nc,
>  			}
>  		}
>  
> -		gpio = devm_fwnode_get_index_gpiod_from_child(nc->dev, "cs",
> -							      i, &np->fwnode,
> -							      GPIOD_OUT_HIGH,
> -							      "nand-cs");
> +		gpio = devm_fwnode_gpiod_get_index(nc->dev,
> +						   of_fwnode_handle(np),
> +						   "cs", i, GPIOD_OUT_HIGH,
> +						   "nand-cs");
>  		if (IS_ERR(gpio) && PTR_ERR(gpio) != -ENOENT) {
>  			dev_err(nc->dev,
>  				"Failed to get CS gpio (err = %ld)\n",
> -- 
> 2.24.1.735.g03f4e72817-goog
> 
> 
> -- 
> Dmitry

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
