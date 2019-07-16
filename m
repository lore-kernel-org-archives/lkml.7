Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154FAC76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 07:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6B73206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 07:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbfGPHbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 03:31:45 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57742 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfGPHbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 03:31:45 -0400
Received: from pc-375.home (2a01cb0c88d94a005820d607da339aae.ipv6.abo.wanadoo.fr [IPv6:2a01:cb0c:88d9:4a00:5820:d607:da33:9aae])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 4329528B6A4;
        Tue, 16 Jul 2019 08:31:43 +0100 (BST)
Date:   Tue, 16 Jul 2019 09:31:37 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Cc:     miquel.raynal@bootlin.com, bbrezillon@kernel.org, richard@nod.at,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, vigneshr@ti.com,
        yamada.masahiro@socionext.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, michal.simek@xilinx.com,
        svemula@xilinx.com, nagasuresh12@gmail.com
Subject: Re: [LINUX PATCH v18 1/2] mtd: rawnand: nand_micron: Do not over
 write driver's read_page()/write_page()
Message-ID: <20190716093137.3d8e8c1f@pc-375.home>
In-Reply-To: <20190716053051.11282-1-naga.sureshkumar.relli@xilinx.com>
References: <20190716053051.11282-1-naga.sureshkumar.relli@xilinx.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jul 2019 23:30:51 -0600
Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com> wrote:

> Add check before assigning chip->ecc.read_page() and chip->ecc.write_page()
> 
> Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
> ---
> Changes in v18
>  - None
> ---
>  drivers/mtd/nand/raw/nand_micron.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/nand_micron.c b/drivers/mtd/nand/raw/nand_micron.c
> index cbd4f09ac178..565f2696c747 100644
> --- a/drivers/mtd/nand/raw/nand_micron.c
> +++ b/drivers/mtd/nand/raw/nand_micron.c
> @@ -500,8 +500,11 @@ static int micron_nand_init(struct nand_chip *chip)
>  		chip->ecc.size = 512;
>  		chip->ecc.strength = chip->base.eccreq.strength;
>  		chip->ecc.algo = NAND_ECC_BCH;
> -		chip->ecc.read_page = micron_nand_read_page_on_die_ecc;
> -		chip->ecc.write_page = micron_nand_write_page_on_die_ecc;
> +		if (!chip->ecc.read_page)
> +			chip->ecc.read_page = micron_nand_read_page_on_die_ecc;
> +
> +		if (!chip->ecc.write_page)
> +			chip->ecc.write_page = micron_nand_write_page_on_die_ecc;
>  

Seriously?! I told you this was inappropriate and you keep sending this
patch. So let's make it clear:

Nacked-by: Boris Brezillon <boris.brezillon@collabora.com>

Fix your controller driver instead of adding hacks to the Micron logic!

>  		if (ondie == MICRON_ON_DIE_MANDATORY) {
>  			chip->ecc.read_page_raw = nand_read_page_raw_notsupp;

