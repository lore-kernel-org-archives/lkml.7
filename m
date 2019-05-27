Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D514C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 12:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23F942075C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 12:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfE0MUQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 08:20:16 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:33475 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbfE0MUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 08:20:16 -0400
X-Originating-IP: 90.88.147.134
Received: from xps13 (aaubervilliers-681-1-27-134.w90-88.abo.wanadoo.fr [90.88.147.134])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 7979BC0011;
        Mon, 27 May 2019 12:20:01 +0000 (UTC)
Date:   Mon, 27 May 2019 14:20:00 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Weitao Hou <houweitaoo@gmail.com>
Cc:     dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: remove unused value for mtdoops
Message-ID: <20190527141939.57c93fb7@xps13>
In-Reply-To: <20190527121440.19271-1-houweitaoo@gmail.com>
References: <20190527121440.19271-1-houweitaoo@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Weitao,

Weitao Hou <houweitaoo@gmail.com> wrote on Mon, 27 May 2019 20:14:40
+0800:

> since hdr was never used, we need not reserve and init it

What about "MTD oops 'hdr' header is never used, drop its
initialization."

Maybe a Fixes tag would be appropriate.

> 
> Signed-off-by: Weitao Hou <houweitaoo@gmail.com>
> ---
>  drivers/mtd/mtdoops.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/mtd/mtdoops.c b/drivers/mtd/mtdoops.c
> index e078fc41aa61..6ae4b70ebdbb 100644
> --- a/drivers/mtd/mtdoops.c
> +++ b/drivers/mtd/mtdoops.c
> @@ -191,14 +191,8 @@ static void mtdoops_write(struct mtdoops_context *cxt, int panic)
>  {
>  	struct mtd_info *mtd = cxt->mtd;
>  	size_t retlen;
> -	u32 *hdr;
>  	int ret;
>  
> -	/* Add mtdoops header to the buffer */
> -	hdr = cxt->oops_buf;
> -	hdr[0] = cxt->nextcount;
> -	hdr[1] = MTDOOPS_KERNMSG_MAGIC;
> -
>  	if (panic) {
>  		ret = mtd_panic_write(mtd, cxt->nextpage * record_size,
>  				      record_size, &retlen, cxt->oops_buf);

Thanks,
Miquèl
