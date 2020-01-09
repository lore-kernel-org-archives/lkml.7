Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644FAC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4469F20721
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387916AbgAIQxZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:53:25 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:53723 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729572AbgAIQxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:53:24 -0500
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 00206100014;
        Thu,  9 Jan 2020 16:53:19 +0000 (UTC)
Date:   Thu, 9 Jan 2020 17:53:18 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mason Yang <masonccyang@mxic.com.tw>
Cc:     richard@nod.at, marek.vasut@gmail.com, dwmw2@infradead.org,
        bbrezillon@kernel.org, computersforpeace@gmail.com,
        vigneshr@ti.com, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 3/4] mtd: rawnand: Add support manufacturer specific
 suspend/resume operation
Message-ID: <20200109175318.73ab8bd7@xps13>
In-Reply-To: <1572256527-5074-4-git-send-email-masonccyang@mxic.com.tw>
References: <1572256527-5074-1-git-send-email-masonccyang@mxic.com.tw>
        <1572256527-5074-4-git-send-email-masonccyang@mxic.com.tw>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mason,

Mason Yang <masonccyang@mxic.com.tw> wrote on Mon, 28 Oct 2019 17:55:26
+0800:

> Patch nand_suspend() & nand_resume() for manufacturer specific
> suspend/resume operation.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> ---
>  drivers/mtd/nand/raw/nand_base.c | 9 +++++++--
>  include/linux/mtd/rawnand.h      | 2 ++
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> index 5e318ff..2a9c5bb 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -4323,6 +4323,8 @@ static int nand_suspend(struct mtd_info *mtd)
>  	struct nand_chip *chip = mtd_to_nand(mtd);
>  
>  	mutex_lock(&chip->lock);
> +	if (chip->_suspend)
> +		chip->_suspend(chip);

Return value should be checked!

>  	chip->suspended = 1;
>  	mutex_unlock(&chip->lock);
>  
> @@ -4338,11 +4340,14 @@ static void nand_resume(struct mtd_info *mtd)
>  	struct nand_chip *chip = mtd_to_nand(mtd);
>  
>  	mutex_lock(&chip->lock);
> -	if (chip->suspended)
> +	if (chip->suspended) {
> +		if (chip->_resume)
> +			chip->_resume(chip);
>  		chip->suspended = 0;
> -	else
> +	} else {
>  		pr_err("%s called for a chip which is not in suspended state\n",
>  			__func__);
> +	}
>  	mutex_unlock(&chip->lock);
>  }
>  
> diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
> index 2430ecd..6b14041 100644
> --- a/include/linux/mtd/rawnand.h
> +++ b/include/linux/mtd/rawnand.h
> @@ -1117,6 +1117,8 @@ struct nand_chip {
>  
>  	struct mutex lock;
>  	unsigned int suspended : 1;
> +	int (*_suspend)(struct nand_chip *chip);
> +	void (*_resume)(struct nand_chip *chip);

Please don't forget the kdoc!

>  
>  	uint8_t *oob_poi;
>  	struct nand_controller *controller;

With this fixed,
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>


Thanks,
Miquèl
