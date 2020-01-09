Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270CAC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E906A206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733296AbgAIQmD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:42:03 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:60463 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgAIQmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:42:03 -0500
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 523B920002;
        Thu,  9 Jan 2020 16:42:00 +0000 (UTC)
Date:   Thu, 9 Jan 2020 17:41:59 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mason Yang <masonccyang@mxic.com.tw>
Cc:     richard@nod.at, marek.vasut@gmail.com, dwmw2@infradead.org,
        bbrezillon@kernel.org, computersforpeace@gmail.com,
        vigneshr@ti.com, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 1/4] mtd: rawnand: Add support manufacturer specific
 lock/unlock operatoin
Message-ID: <20200109174159.1737067f@xps13>
In-Reply-To: <1572256527-5074-2-git-send-email-masonccyang@mxic.com.tw>
References: <1572256527-5074-1-git-send-email-masonccyang@mxic.com.tw>
        <1572256527-5074-2-git-send-email-masonccyang@mxic.com.tw>
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

Mason Yang <masonccyang@mxic.com.tw> wrote on Mon, 28 Oct 2019 17:55:24
+0800:

> Add nand_lock() & nand_unlock() for manufacturer specific lock & unlock
> operation while the device supports Block Protection function.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> ---
>  drivers/mtd/nand/raw/nand_base.c | 32 ++++++++++++++++++++++++++++++--
>  include/linux/mtd/rawnand.h      |  3 +++
>  2 files changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> index 5c2c30a..5e318ff 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -4356,6 +4356,34 @@ static void nand_shutdown(struct mtd_info *mtd)
>  	nand_suspend(mtd);
>  }
>  
> +/**
> + * nand_lock - [MTD Interface] Lock the NAND flash
> + * @mtd: MTD device structure
> + */
> +static int nand_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +
> +	if (!chip->_lock)
> +		return -ENOTSUPP;
> +
> +	return chip->_lock(chip, ofs, len);
> +}
> +
> +/**
> + * nand_unlock - [MTD Interface] Unlock the NAND flash
> + * @mtd: MTD device structure
> + */
> +static int nand_unlock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +
> +	if (!chip->_unlock)
> +		return -ENOTSUPP;
> +
> +	return chip->_unlock(chip, ofs, len);
> +}
> +
>  /* Set default functions */
>  static void nand_set_defaults(struct nand_chip *chip)
>  {
> @@ -5782,8 +5810,8 @@ static int nand_scan_tail(struct nand_chip *chip)
>  	mtd->_read_oob = nand_read_oob;
>  	mtd->_write_oob = nand_write_oob;
>  	mtd->_sync = nand_sync;
> -	mtd->_lock = NULL;
> -	mtd->_unlock = NULL;
> +	mtd->_lock = nand_lock;
> +	mtd->_unlock = nand_unlock;
>  	mtd->_suspend = nand_suspend;
>  	mtd->_resume = nand_resume;
>  	mtd->_reboot = nand_shutdown;
> diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
> index 4ab9bcc..2430ecd 100644
> --- a/include/linux/mtd/rawnand.h
> +++ b/include/linux/mtd/rawnand.h
> @@ -1136,6 +1136,9 @@ struct nand_chip {
>  		const struct nand_manufacturer *desc;
>  		void *priv;
>  	} manufacturer;
> +
> +	int (*_lock)(struct nand_chip *chip, loff_t ofs, uint64_t len);
> +	int (*_unlock)(struct nand_chip *chip, loff_t ofs, uint64_t len);

Kernel documentation is missing here.

Also please fix kbuildtest robot warnings.

With all this done, please add my:
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miquèl
