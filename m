Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5698BC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 07:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24E11217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 07:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfEJHpi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 03:45:38 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:46039 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbfEJHph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 03:45:37 -0400
X-Originating-IP: 90.88.28.253
Received: from xps13 (aaubervilliers-681-1-86-253.w90-88.abo.wanadoo.fr [90.88.28.253])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 300EF2000F;
        Fri, 10 May 2019 07:45:29 +0000 (UTC)
Date:   Fri, 10 May 2019 09:45:28 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mason Yang <masonccyang@mxic.com.tw>
Cc:     bbrezillon@kernel.org, marek.vasut@gmail.com,
        linux-kernel@vger.kernel.org, richard@nod.at, dwmw2@infradead.org,
        computersforpeace@gmail.com, linux-mtd@lists.infradead.org,
        juliensu@mxic.com.tw
Subject: Re: [PATCH v1] mtd: rawnand: Add Macronix NAND read retry support
Message-ID: <20190510094528.6008e8da@xps13>
In-Reply-To: <1557474062-4949-1-git-send-email-masonccyang@mxic.com.tw>
References: <1557474062-4949-1-git-send-email-masonccyang@mxic.com.tw>
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

Mason Yang <masonccyang@mxic.com.tw> wrote on Fri, 10 May 2019 15:41:02
+0800:

> Add a driver for Macronix NAND read retry.

"Add support for Macronix NAND read retry."? This is not a "new driver".

> 
> Macronix NAND supports specfical read for data recovery and enabled


Macronix NANDs support specific read operation for data recovery,
which can be enabled with a SET_FEATURE.

> Driver check byte 167 of Vendor Blocks in ONFI parameter page table

         checks

> to see if this high reliability function is support or not.

                 high-reliability function? not sure it is English
                 anyway.

                                              supported

> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> ---
>  drivers/mtd/nand/raw/nand_macronix.c | 52 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/drivers/mtd/nand/raw/nand_macronix.c b/drivers/mtd/nand/raw/nand_macronix.c
> index 47d8cda..5cd1e5f 100644
> --- a/drivers/mtd/nand/raw/nand_macronix.c
> +++ b/drivers/mtd/nand/raw/nand_macronix.c
> @@ -17,6 +17,57 @@
>  
>  #include "internals.h"
>  
> +#define MACRONIX_READ_RETRY_BIT BIT(0)
> +#define MACRONIX_READ_RETRY_MODE 5
> +
> +struct nand_onfi_vendor_macronix {
> +	u8 reserved[1];
> +	u8 reliability_func;
> +} __packed;
> +
> +static int macronix_nand_setup_read_retry(struct nand_chip *chip, int mode)
> +{
> +	u8 feature[ONFI_SUBFEATURE_PARAM_LEN] = {0};

                                                 0 is not needed here

> +	int ret;
> +
> +	if (mode > MACRONIX_READ_RETRY_MODE)
> +		mode = MACRONIX_READ_RETRY_MODE;
> +
> +	feature[0] = mode;
> +	ret =  nand_set_features(chip, ONFI_FEATURE_ADDR_READ_RETRY, feature);

Don't you miss to select/deselect the target?

> +	if (ret)
> +		pr_err("set feature failed to read retry moded:%d\n", mode);

                       "Failed to set read retry mode: %d\n"

I think you can abort the operation with a negative return code in this
case.

> +
> +	ret =  nand_get_features(chip, ONFI_FEATURE_ADDR_READ_RETRY, feature);

If the operation succeeded but the controller cannot get the feature
you don't want to abort the operation. You should check if get_features
is supported, if yes you can rely on the below test.

> +	if (ret || feature[0] != mode)
> +		pr_err("get feature failed to read retry moded:%d(%d)\n",
> +		       mode, feature[0]);

                       "Failed to verify read retry mode..."

                Also return something negative here.

> +
> +	return ret;

And if all went right, return 0 at the end.

> +}
> +
> +static void macronix_nand_onfi_init(struct nand_chip *chip)
> +{
> +	struct nand_parameters *p = &chip->parameters;
> +
> +	if (p->onfi) {
> +		struct nand_onfi_vendor_macronix *mxic =
> +				(void *)p->onfi->vendor;

Please put everything on the same line

> +
> +		if (mxic->reliability_func & MACRONIX_READ_RETRY_BIT) {
> +			chip->read_retries = MACRONIX_READ_RETRY_MODE + 1;

Why +1 here, I am missing something?

> +			chip->setup_read_retry =
> +				 macronix_nand_setup_read_retry;
> +			if (p->supports_set_get_features) {
> +				set_bit(ONFI_FEATURE_ADDR_READ_RETRY,
> +					p->set_feature_list);
> +				set_bit(ONFI_FEATURE_ADDR_READ_RETRY,
> +					p->get_feature_list);

Please use bitmap_set()

> +			}
> +		}
> +	}
> +}
> +
>  /*
>   * Macronix AC series does not support using SET/GET_FEATURES to change
>   * the timings unlike what is declared in the parameter page. Unflag
> @@ -65,6 +116,7 @@ static int macronix_nand_init(struct nand_chip *chip)
>  		chip->bbt_options |= NAND_BBT_SCAN2NDPAGE;
>  
>  	macronix_nand_fix_broken_get_timings(chip);
> +	macronix_nand_onfi_init(chip);
>  
>  	return 0;
>  }


Thanks,
Miquèl
