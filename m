Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23918C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 13:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA40E217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 13:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730828AbfHZNF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 09:05:58 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46912 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730241AbfHZNF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 09:05:58 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id B0F8428BD6A;
        Mon, 26 Aug 2019 14:05:56 +0100 (BST)
Date:   Mon, 26 Aug 2019 15:05:53 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-mtd@lists.infradead.org (open list:NAND FLASH SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v2] mtd: rawnand: Fix a memory leak bug
Message-ID: <20190826150553.3f758c84@collabora.com>
In-Reply-To: <1566182765-7150-1-git-send-email-wenwen@cs.uga.edu>
References: <1566182765-7150-1-git-send-email-wenwen@cs.uga.edu>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Aug 2019 21:46:04 -0500
Wenwen Wang <wenwen@cs.uga.edu> wrote:

> In nand_scan_bbt(), a temporary buffer 'buf' is allocated through
> vmalloc(). However, if check_create() fails, 'buf' is not deallocated,
> leading to a memory leak bug. To fix this issue, free 'buf' before
> returning the error.
> 
> Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
> ---
>  drivers/mtd/nand/raw/nand_bbt.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/nand_bbt.c b/drivers/mtd/nand/raw/nand_bbt.c
> index 2ef15ef..96045d6 100644
> --- a/drivers/mtd/nand/raw/nand_bbt.c
> +++ b/drivers/mtd/nand/raw/nand_bbt.c
> @@ -1232,7 +1232,7 @@ static int nand_scan_bbt(struct nand_chip *this, struct nand_bbt_descr *bd)
>  	if (!td) {
>  		if ((res = nand_memory_bbt(this, bd))) {
>  			pr_err("nand_bbt: can't scan flash and build the RAM-based BBT\n");
> -			goto err;
> +			goto err_free_bbt;
>  		}
>  		return 0;
>  	}
> @@ -1245,7 +1245,7 @@ static int nand_scan_bbt(struct nand_chip *this, struct nand_bbt_descr *bd)
>  	buf = vmalloc(len);
>  	if (!buf) {
>  		res = -ENOMEM;
> -		goto err;
> +		goto err_free_bbt;
>  	}
>  
>  	/* Is the bbt at a given page? */
> @@ -1258,7 +1258,7 @@ static int nand_scan_bbt(struct nand_chip *this, struct nand_bbt_descr *bd)
>  
>  	res = check_create(this, buf, bd);

I know it's too late, but calling

	vfree(buf);

here

>  	if (res)
> -		goto err;
> +		goto err_free_buf;
>  
>  	/* Prevent the bbt regions from erasing / writing */
>  	mark_bbt_region(this, td);
> @@ -1268,7 +1268,9 @@ static int nand_scan_bbt(struct nand_chip *this, struct nand_bbt_descr *bd)
>  	vfree(buf);

instead of here would have fixed the leak without the need for an extra
err label.

>  	return 0;
>  
> -err:
> +err_free_buf:
> +	vfree(buf);
> +err_free_bbt:
>  	kfree(this->bbt);
>  	this->bbt = NULL;
>  	return res;

