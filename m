Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9242C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AC8C2053B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbfLPKJv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 05:09:51 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:43373 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbfLPKJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 05:09:51 -0500
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id D9EAE20001D;
        Mon, 16 Dec 2019 10:09:48 +0000 (UTC)
Date:   Mon, 16 Dec 2019 11:09:47 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Vasyl Gomonovych <gomonovych@gmail.com>
Cc:     piotrs@cadence.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] git commit --signoff -m "mtd: cadence: Fix cast to
 pointer from integer of different size warning
Message-ID: <20191216110947.6fb2423a@xps13>
In-Reply-To: <20191214210946.29922-1-gomonovych@gmail.com>
References: <20191214210946.29922-1-gomonovych@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vasyl,

Vasyl Gomonovych <gomonovych@gmail.com> wrote on Sat, 14 Dec 2019
22:09:45 +0100:

> Use a cast to uintptr_t and next to a pointer
> In the final assignment the same casting in place
> memory_pointer = (uintptr_t)mem_ptr;
> Fix warning: cast to pointer from integer of different size

It seems like you're 'git send' script is messy :) (see the title).

> 
> Signed-off-by: Vasyl Gomonovych <gomonovych@gmail.com>
> ---
> This commit fixes a minor issue with a warning
> Not sure if we will have problem here in case of
> dma_addr_t which can be 64-bit wide on 32-bit arch

Why not manipulating dma_addr_t everywhere instead?

> 
> ---
>  drivers/mtd/nand/raw/cadence-nand-controller.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/cadence-nand-controller.c b/drivers/mtd/nand/raw/cadence-nand-controller.c
> index 3a36285a8d8a..960c3a0be69c 100644
> --- a/drivers/mtd/nand/raw/cadence-nand-controller.c
> +++ b/drivers/mtd/nand/raw/cadence-nand-controller.c
> @@ -1280,8 +1280,8 @@ cadence_nand_cdma_transfer(struct cdns_nand_ctrl *cdns_ctrl, u8 chip_nr,
>  	}
>  
>  	cadence_nand_cdma_desc_prepare(cdns_ctrl, chip_nr, page,
> -				       (void *)dma_buf, (void *)dma_ctrl_dat,
> -				       ctype);
> +				       (void *)(uintptr_t)dma_buf,
> +				       (void *)(uintptr_t)dma_ctrl_dat, ctype);
>  
>  	status = cadence_nand_cdma_send_and_wait(cdns_ctrl, thread_nr);
>  

Thanks,
Miquèl
