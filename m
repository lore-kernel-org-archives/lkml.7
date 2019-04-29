Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DC2C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 08:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BC812075E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 08:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbfD2IWX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 04:22:23 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:36095 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbfD2IWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 04:22:22 -0400
X-Originating-IP: 90.88.147.33
Received: from xps13 (aaubervilliers-681-1-27-33.w90-88.abo.wanadoo.fr [90.88.147.33])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 4BCAEFF81D;
        Mon, 29 Apr 2019 08:22:17 +0000 (UTC)
Date:   Mon, 29 Apr 2019 10:22:16 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     =?UTF-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     kyungmin.park@samsung.com, bbrezillon@kernel.org, richard@nod.at,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH 5/5] mtd: onenand/samsung: Set name field of mtd_info
 struct
Message-ID: <20190429102216.3235c48c@xps13>
In-Reply-To: <20190426164224.11327-6-pawel.mikolaj.chmiel@gmail.com>
References: <20190426164224.11327-1-pawel.mikolaj.chmiel@gmail.com>
        <20190426164224.11327-6-pawel.mikolaj.chmiel@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paweł,

Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com> wrote on Fri, 26 Apr 2019
18:42:24 +0200:

> From: Tomasz Figa <tomasz.figa@gmail.com>
> 
> This patch adds initialization of .name field of mtd_info struct to
> avoid printing "(null)" in kernel log messages, such as:
> 
> [    1.942519] 1 ofpart partitions found on MTD device (null)
> [    1.949708] Creating 1 MTD partitions on "(null)":
> 
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  drivers/mtd/nand/onenand/samsung.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mtd/nand/onenand/samsung.c b/drivers/mtd/nand/onenand/samsung.c
> index 0f450604412f..1fda1f324cc6 100644
> --- a/drivers/mtd/nand/onenand/samsung.c
> +++ b/drivers/mtd/nand/onenand/samsung.c
> @@ -886,6 +886,7 @@ static int s3c_onenand_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	this = (struct onenand_chip *) &mtd[1];
> +	mtd->name = dev_name(&pdev->dev);
>  	mtd->priv = this;
>  	mtd->dev.of_node = np;
>  	mtd->dev.parent = &pdev->dev;


Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>


Thanks,
Miquèl
