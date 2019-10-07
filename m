Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00381C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 08:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B6721655
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 08:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbfJGIyN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 04:54:13 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:50335 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbfJGIyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 04:54:13 -0400
X-Originating-IP: 86.250.200.211
Received: from xps13 (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 14FEA240013;
        Mon,  7 Oct 2019 08:54:08 +0000 (UTC)
Date:   Mon, 7 Oct 2019 10:54:08 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: onenand: prevent memory leak in onenand_scan
Message-ID: <20191007105408.2b4b9fd6@xps13>
In-Reply-To: <20191004171909.6378-1-navid.emamdoost@gmail.com>
References: <20191004175740.5dd84c38@xps13>
        <20191004171909.6378-1-navid.emamdoost@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Navid,

Navid Emamdoost <navid.emamdoost@gmail.com> wrote on Fri,  4 Oct 2019
12:19:05 -0500:

> In onenand_scan if scan_bbt fails the allocated buffers for oob_buf,
> verify_buf, and page_buf should be released.
> 
> Fixes: 5988af231978 ("mtd: Flex-OneNAND support")

Missing Cc: stable@vger.kernel.org

> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
> Changes in v2:
> 	-- added release for this->verify_buf (thanks to Miquel Raynal
> for the hint).
> ---

These three dashes are not needed.

>  drivers/mtd/nand/onenand/onenand_base.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/onenand/onenand_base.c b/drivers/mtd/nand/onenand/onenand_base.c
> index 77bd32a683e1..6329ada3f15c 100644
> --- a/drivers/mtd/nand/onenand/onenand_base.c
> +++ b/drivers/mtd/nand/onenand/onenand_base.c
> @@ -3977,8 +3977,14 @@ int onenand_scan(struct mtd_info *mtd, int maxchips)
>  	this->badblockpos = ONENAND_BADBLOCK_POS;
>  
>  	ret = this->scan_bbt(mtd);
> -	if ((!FLEXONENAND(this)) || ret)
> +	if ((!FLEXONENAND(this)) || ret) {
> +		kfree(this->oob_buf);
> +#ifdef CONFIG_MTD_ONENAND_VERIFY_WRITE
> +		kfree(this->verify_buf);
> +#endif

Sorry for the ping-pong but actually, only the oob_buf and page_buf
have been introduced by the commit 5988af you point in the Fixes tag.

To help stable kernels maintainers I suggest you free the verify_buf
in a second patch which fixes:

4a8ce0b03071 mtd: onenand: allocate verify buffer in the core

> +		kfree(this->page_buf);
>  		return ret;
> +	}
>  
>  	/* Change Flex-OneNAND boundaries if required */
>  	for (i = 0; i < MAX_DIES; i++)

Thanks,
Miquèl
