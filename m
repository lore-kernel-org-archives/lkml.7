Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF3EC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 10:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB62621E6C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 10:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729567AbfHGKIa convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 06:08:30 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:54159 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729407AbfHGKIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 06:08:30 -0400
X-Originating-IP: 86.250.200.211
Received: from xps13 (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 9E20A240002;
        Wed,  7 Aug 2019 10:08:27 +0000 (UTC)
Date:   Wed, 7 Aug 2019 12:08:26 +0200
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
Subject: Re: [PATCH 8/8] mtd: spinand: micron: Enable micron flashes with
 multi-die
Message-ID: <20190807120826.3b9e43d6@xps13>
In-Reply-To: <20190722055621.23526-9-sshivamurthy@micron.com>
References: <20190722055621.23526-1-sshivamurthy@micron.com>
        <20190722055621.23526-9-sshivamurthy@micron.com>
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

shiva.linuxworks@gmail.com wrote on Mon, 22 Jul 2019 07:56:21 +0200:

"with multiple dies" in the title

> From: Shivamurthy Shastri <sshivamurthy@micron.com>
> 
> Some of the Micron flashes has multi-die, and need to select the die
                             have multiple dies and
> each time while accessing it.
> 
> Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
> ---
>  drivers/mtd/nand/spi/micron.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
> index 1e28ea3d1362..fa2b43caf39d 100644
> --- a/drivers/mtd/nand/spi/micron.c
> +++ b/drivers/mtd/nand/spi/micron.c
> @@ -90,6 +90,19 @@ static int micron_ecc_get_status(struct spinand_device *spinand,
>  	return -EINVAL;
>  }
>  

Please explain in a comment what you do here, like in the commit title.

> +static int micron_select_target(struct spinand_device *spinand,
> +				unsigned int target)
> +{
> +	struct spi_mem_op op = SPINAND_SET_FEATURE_OP(0xd0,
> +						      spinand->scratchbuf);
> +
> +	if (target == 1)
> +		target = 0x40;
> +
> +	*spinand->scratchbuf = target;

if (target == 1)
        *spinand->scratchbuf = 0x40

space

> +	return spi_mem_exec_op(spinand->spimem, &op);
> +}
> +
>  static int micron_spinand_detect(struct spinand_device *spinand)
>  {
>  	const struct spi_mem_op *op;
> @@ -105,6 +118,7 @@ static int micron_spinand_detect(struct spinand_device *spinand)
>  	spinand->flags = 0;
>  	spinand->eccinfo.get_status = micron_ecc_get_status;
>  	spinand->eccinfo.ooblayout = &micron_ooblayout_ops;
> +	spinand->select_target = micron_select_target;
>  
>  	op = spinand_select_op_variant(spinand,
>  				       &read_cache_variants);




Thanks,
Miquèl
