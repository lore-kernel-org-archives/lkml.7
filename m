Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75277C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B79C20644
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbfF0Rq5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:46:57 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:50743 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727438AbfF0Rqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:46:54 -0400
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 5B41B20000A;
        Thu, 27 Jun 2019 17:46:47 +0000 (UTC)
Date:   Thu, 27 Jun 2019 19:46:45 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 35/87] mtd: nand: replace kmalloc and memset with
 kzalloc in nand_bch.c
Message-ID: <20190627194645.3d0af6b8@xps13>
In-Reply-To: <20190627173906.3675-1-huangfq.daxian@gmail.com>
References: <20190627173906.3675-1-huangfq.daxian@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fuqian,

Fuqian Huang <huangfq.daxian@gmail.com> wrote on Fri, 28 Jun 2019
01:39:05 +0800:

> kmalloc + memset(0) -> kzalloc
> 
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
> ---
>  drivers/mtd/nand/raw/nand_bch.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/nand_bch.c b/drivers/mtd/nand/raw/nand_bch.c
> index 55aa4c1cd414..17527310c3a1 100644
> --- a/drivers/mtd/nand/raw/nand_bch.c
> +++ b/drivers/mtd/nand/raw/nand_bch.c
> @@ -170,7 +170,7 @@ struct nand_bch_control *nand_bch_init(struct mtd_info *mtd)
>  		goto fail;
>  	}
>  
> -	nbc->eccmask = kmalloc(eccbytes, GFP_KERNEL);
> +	nbc->eccmask = kzalloc(eccbytes, GFP_KERNEL);
>  	nbc->errloc = kmalloc_array(t, sizeof(*nbc->errloc), GFP_KERNEL);
>  	if (!nbc->eccmask || !nbc->errloc)
>  		goto fail;
> @@ -182,7 +182,6 @@ struct nand_bch_control *nand_bch_init(struct mtd_info *mtd)
>  		goto fail;
>  
>  	memset(erased_page, 0xff, eccsize);
> -	memset(nbc->eccmask, 0, eccbytes);
>  	encode_bch(nbc->bch, erased_page, eccsize, nbc->eccmask);
>  	kfree(erased_page);
>  

Are there any guidelines on this topic that I missed? Otherwise I don't
think this is important to change.


Thanks,
Miquèl
