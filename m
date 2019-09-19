Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E930C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 09:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12181218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 09:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388531AbfISJKY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 05:10:24 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:35305 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730506AbfISJKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 05:10:24 -0400
X-Originating-IP: 86.250.200.211
Received: from xps13 (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 4FE741C0016;
        Thu, 19 Sep 2019 09:10:15 +0000 (UTC)
Date:   Thu, 19 Sep 2019 11:10:14 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-mtd@lists.infradead.org,
        Allison Randal <allison@lohutok.net>,
        Armijn Hemel <armijn@tjaldur.nl>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Himanshu Jha <himanshujha199640@gmail.com>
Subject: Re: [PATCH] mtd: st_spi_fsm: Use devm_platform_ioremap_resource()
 in stfsm_probe()
Message-ID: <20190919111014.6c569cf3@xps13>
In-Reply-To: <e1d32aa4-7c82-64e0-b7c4-33c94d9a2769@web.de>
References: <e1d32aa4-7c82-64e0-b7c4-33c94d9a2769@web.de>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markus,

Markus Elfring <Markus.Elfring@web.de> wrote on Wed, 18 Sep 2019
14:50:27 +0200:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 18 Sep 2019 14:37:34 +0200
> 
> Simplify this function implementation by using a known wrapper function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/mtd/devices/st_spi_fsm.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/mtd/devices/st_spi_fsm.c b/drivers/mtd/devices/st_spi_fsm.c
> index f4d1667daaf9..5bd1c44ae529 100644
> --- a/drivers/mtd/devices/st_spi_fsm.c
> +++ b/drivers/mtd/devices/st_spi_fsm.c
> @@ -2034,13 +2034,7 @@ static int stfsm_probe(struct platform_device *pdev)
> 
>  	platform_set_drvdata(pdev, fsm);
> 
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!res) {
> -		dev_err(&pdev->dev, "Resource not found\n");
> -		return -ENODEV;
> -	}
> -
> -	fsm->base = devm_ioremap_resource(&pdev->dev, res);
> +	fsm->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(fsm->base)) {
>  		dev_err(&pdev->dev,
>  			"Failed to reserve memory region %pR\n", res);
> --
> 2.23.0
> 


Is this even compiled tested? 'res' is not initialized anymore so you
can't use it in the error trace. I suppose you should even drop it from
the stack parameters.

Thanks,
Miquèl
