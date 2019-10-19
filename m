Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CFDCA9EAB
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 09:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4DF8222C2
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 09:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfJSJjO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 05:39:14 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:57969 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfJSJjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 05:39:13 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 43C3A20002;
        Sat, 19 Oct 2019 09:39:01 +0000 (UTC)
Date:   Sat, 19 Oct 2019 11:39:00 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Brian Norris <computersforpeace@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org (open list:BROADCOM STB NAND FLASH DRIVER),
        bcm-kernel-feedback-list@broadcom.com (open list:BROADCOM STB NAND
        FLASH DRIVER), linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH] mtd: rawnand: brcmnand: Fix sparse warning in
 has_flash_dma()
Message-ID: <20191019113824.15fa4f52@xps13>
In-Reply-To: <20191018233844.23838-1-f.fainelli@gmail.com>
References: <20191018233844.23838-1-f.fainelli@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

Florian Fainelli <f.fainelli@gmail.com> wrote on Fri, 18 Oct 2019
16:38:44 -0700:

> Sparse rightfully complained about has_flash_dma():
> +drivers/mtd/nand/brcmnand/brcmnand.c:951:40: warning: Using plain integer as NULL pointer [sparse]

I don't get why would sparse complain about this... Anyway I prefer
the !!(<pointer>) alternative if you don't mind. Otherwise the "!=
NULL" comparison feels wrong.

> 
> Fixes: 27c5b17cd1b1 ("mtd: nand: add NAND driver "library" for Broadcom STB NAND controller")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> index 15ef30b368a5..73f7a0945399 100644
> --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> @@ -909,7 +909,7 @@ static inline void brcmnand_set_wp(struct brcmnand_controller *ctrl, bool en)
>  
>  static inline bool has_flash_dma(struct brcmnand_controller *ctrl)
>  {
> -	return ctrl->flash_dma_base;
> +	return ctrl->flash_dma_base != NULL;
>  }
>  
>  static inline void disable_ctrl_irqs(struct brcmnand_controller *ctrl)


Thanks,
Miquèl
