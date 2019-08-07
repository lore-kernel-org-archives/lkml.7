Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C05C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 10:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B58021E6C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 10:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbfHGKFm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 06:05:42 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:41917 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728202AbfHGKFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 06:05:41 -0400
X-Originating-IP: 86.250.200.211
Received: from xps13 (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 689B1240002;
        Wed,  7 Aug 2019 10:05:38 +0000 (UTC)
Date:   Wed, 7 Aug 2019 12:05:37 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     shiva.linuxworks@gmail.com
Cc:     Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Shivamurthy Shastri <sshivamurthy@micron.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jeff Kletsky <git-commits@allycomm.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        liaoweixiong <liaoweixiong@allwinnertech.com>
Subject: Re: [PATCH 7/8] mtd: spinand: micron: Fix read failure in Micron
 M70A flashes
Message-ID: <20190807120537.733b6e6d@xps13>
In-Reply-To: <20190722055621.23526-8-sshivamurthy@micron.com>
References: <20190722055621.23526-1-sshivamurthy@micron.com>
        <20190722055621.23526-8-sshivamurthy@micron.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shiva,

shiva.linuxworks@gmail.com wrote on Mon, 22 Jul 2019 07:56:20 +0200:

> From: Shivamurthy Shastri <sshivamurthy@micron.com>
> 
> M70A series flashes by default enable continuous read feature (BIT0 in
> configuration register). This feature will not expose the ECC to host
> and causing read failure.

This is not readable enough, can you rephrase? Besides that you can add
my 

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

> 
> Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
> ---
>  drivers/mtd/nand/spi/micron.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
> index 6fde93ec23a1..1e28ea3d1362 100644
> --- a/drivers/mtd/nand/spi/micron.c
> +++ b/drivers/mtd/nand/spi/micron.c
> @@ -127,6 +127,15 @@ static int micron_spinand_detect(struct spinand_device *spinand)
>  	return 1;
>  }
>  
> +static int micron_spinand_init(struct spinand_device *spinand)
> +{
> +	/*
> +	 * Some of the Micron flashes enable this BIT by default,
> +	 * and there is a chance of read failure due to this.
> +	 */
> +	return spinand_upd_cfg(spinand, CFG_QUAD_ENABLE, 0);
> +}
> +
>  static void micron_fixup_param_page(struct spinand_device *spinand,
>  				    struct nand_onfi_params *p)
>  {
> @@ -150,6 +159,7 @@ static void micron_fixup_param_page(struct spinand_device *spinand,
>  
>  static const struct spinand_manufacturer_ops micron_spinand_manuf_ops = {
>  	.detect = micron_spinand_detect,
> +	.init = micron_spinand_init,
>  	.fixup_param_page = micron_fixup_param_page,
>  };
>  


Thanks,
Miquèl
