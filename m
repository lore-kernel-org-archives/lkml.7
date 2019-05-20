Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F65DC04E87
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3E8D20645
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391420AbfETMip convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:38:45 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:33753 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390971AbfETMen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:34:43 -0400
X-Originating-IP: 90.88.22.185
Received: from xps13 (aaubervilliers-681-1-80-185.w90-88.abo.wanadoo.fr [90.88.22.185])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 3C106FF811;
        Mon, 20 May 2019 12:34:38 +0000 (UTC)
Date:   Mon, 20 May 2019 14:34:38 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mason Yang <masonccyang@mxic.com.tw>
Cc:     bbrezillon@kernel.org, marek.vasut@gmail.com,
        linux-kernel@vger.kernel.org, richard@nod.at, dwmw2@infradead.org,
        computersforpeace@gmail.com, linux-mtd@lists.infradead.org,
        vigneshr@ti.com, frieder.schrempf@kontron.de, juliensu@mxic.com.tw,
        zhengxunli@mxic.com.tw
Subject: Re: [PATCH v2] mtd: rawnand: Add Macronix NAND read retry support
Message-ID: <20190520143438.46248bfc@xps13>
In-Reply-To: <1558076001-29579-1-git-send-email-masonccyang@mxic.com.tw>
References: <1558076001-29579-1-git-send-email-masonccyang@mxic.com.tw>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mason,

Mason Yang <masonccyang@mxic.com.tw> wrote on Fri, 17 May 2019 14:53:21
+0800:

> Add support for Macronix NAND read retry.
> 
> Macronix NANDs support specific read operation for data recovery,
> which can be enabled/disabled with a SET/GET_FEATURE.
> Driver checks byte 167 of Vendor Blocks in ONFI parameter page table
> to see if this high-reliability function is supported.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> ---
>  drivers/mtd/nand/raw/nand_macronix.c | 57 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
> 
> diff --git a/drivers/mtd/nand/raw/nand_macronix.c b/drivers/mtd/nand/raw/nand_macronix.c
> index e287e71..1a4dc92 100644
> --- a/drivers/mtd/nand/raw/nand_macronix.c
> +++ b/drivers/mtd/nand/raw/nand_macronix.c
> @@ -17,6 +17,62 @@
>  
>  #include "internals.h"
>  
> +#define MACRONIX_READ_RETRY_BIT BIT(0)
> +#define MACRONIX_READ_RETRY_MODE 6

Can you name this define MACRONIX_NUM_READ_RETRY_MODES?

> +
> +struct nand_onfi_vendor_macronix {
> +	u8 reserved[1];

Do you need this "[1]" ?

> +	u8 reliability_func;
> +} __packed;
> +
> +/*
> + * Macronix NANDs support using SET/GET_FEATURES to enter/exit read retry mode
> + */
> +static int macronix_nand_setup_read_retry(struct nand_chip *chip, int mode)
> +{
> +	u8 feature[ONFI_SUBFEATURE_PARAM_LEN];
> +	int ret, feature_addr = ONFI_FEATURE_ADDR_READ_RETRY;
> +
> +	if (chip->parameters.supports_set_get_features &&
> +	    test_bit(feature_addr, chip->parameters.set_feature_list) &&
> +	    test_bit(feature_addr, chip->parameters.get_feature_list)) {
> +		feature[0] = mode;
> +		ret =  nand_set_features(chip, feature_addr, feature);
> +		if (ret)
> +			pr_err("Failed to set read retry moded:%d\n", mode);

Do you have to call nand_get_features() on error?

> +
> +		ret =  nand_get_features(chip, feature_addr, feature);
> +		if (ret || feature[0] != mode)
> +			pr_err("Failed to verify read retry moded:%d(%d)\n",
> +			       mode, feature[0]);

if ret == 0 but feature[0] != mode, shouldn't you return an error?

> +	}
> +
> +	return ret;

This will produce a Warning at compile time (ret may be used
uninitialized). Have you tested it?

> +}
> +
> +static void macronix_nand_onfi_init(struct nand_chip *chip)
> +{
> +	struct nand_parameters *p = &chip->parameters;
> +	struct nand_onfi_vendor_macronix *mxic;
> +
> +	if (!p->onfi)
> +		return;
> +
> +	mxic = (struct nand_onfi_vendor_macronix *)p->onfi->vendor;
> +	if ((mxic->reliability_func & MACRONIX_READ_RETRY_BIT) == 0)
> +		return;
> +
> +	chip->read_retries = MACRONIX_READ_RETRY_MODE;
> +	chip->setup_read_retry = macronix_nand_setup_read_retry;
> +
> +	if (p->supports_set_get_features) {
> +		bitmap_set(p->set_feature_list,
> +			   ONFI_FEATURE_ADDR_READ_RETRY, 1);
> +		bitmap_set(p->get_feature_list,
> +			   ONFI_FEATURE_ADDR_READ_RETRY, 1);
> +	}
> +}
> +
>  /*
>   * Macronix AC series does not support using SET/GET_FEATURES to change
>   * the timings unlike what is declared in the parameter page. Unflag
> @@ -65,6 +121,7 @@ static int macronix_nand_init(struct nand_chip *chip)
>  		chip->options |= NAND_BBM_FIRSTPAGE | NAND_BBM_SECONDPAGE;
>  
>  	macronix_nand_fix_broken_get_timings(chip);
> +	macronix_nand_onfi_init(chip);
>  
>  	return 0;
>  }


Thanks,
Miquèl
