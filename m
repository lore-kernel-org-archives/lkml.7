Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBD3C33CA1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B8482067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387630AbgAIQ2X convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:28:23 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:45169 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728840AbgAIQ2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:28:21 -0500
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 3718220011;
        Thu,  9 Jan 2020 16:28:17 +0000 (UTC)
Date:   Thu, 9 Jan 2020 17:28:16 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mason Yang <masonccyang@mxic.com.tw>
Cc:     richard@nod.at, marek.vasut@gmail.com, dwmw2@infradead.org,
        bbrezillon@kernel.org, computersforpeace@gmail.com,
        vigneshr@ti.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH v4 1/2] mtd: rawnand: Add support for Macronix NAND
 randomizer
Message-ID: <20200109172816.6c1d7be7@xps13>
In-Reply-To: <1571902807-10388-2-git-send-email-masonccyang@mxic.com.tw>
References: <1571902807-10388-1-git-send-email-masonccyang@mxic.com.tw>
        <1571902807-10388-2-git-send-email-masonccyang@mxic.com.tw>
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

Mason Yang <masonccyang@mxic.com.tw> wrote on Thu, 24 Oct 2019 15:40:06
+0800:

> Macronix NANDs support randomizer operation for user data scrambled,
> which can be enabled with a SET_FEATURE.
> 
> User data written to the NAND device without randomizer is still readable
> after randomizer function enabled.
> The penalty of randomizer are subpage accesses prohibited and more time
> period is needed in program operation and entering deep power-down mode.
> i.e., tPROG 300us to 340us(randomizer enabled)
> 
> For more high-reliability concern, if subpage write not available with
> hardware ECC and then to enable randomizer is recommended by default.
> Driver checks byte 167 of Vendor Blocks in ONFI parameter page table
> to see if this high-reliability function is supported. By adding a new
> specific DT property in children nodes to enable randomizer function.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> ---
>  drivers/mtd/nand/raw/nand_macronix.c | 69 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
> 
> diff --git a/drivers/mtd/nand/raw/nand_macronix.c b/drivers/mtd/nand/raw/nand_macronix.c
> index 58511ae..89101fa 100644
> --- a/drivers/mtd/nand/raw/nand_macronix.c
> +++ b/drivers/mtd/nand/raw/nand_macronix.c
> @@ -11,6 +11,14 @@
>  #define MACRONIX_READ_RETRY_BIT BIT(0)
>  #define MACRONIX_NUM_READ_RETRY_MODES 6
>  
> +#define MACRONIX_RANDOMIZER_BIT BIT(1)
> +#define ONFI_FEATURE_ADDR_MXIC_RANDOMIZER 0xB0
> +#define ENPGM BIT(0)
> +#define RANDEN BIT(1)
> +#define RANDOPT BIT(2)
> +#define MACRONIX_RANDOMIZER_MODE_ENTER (ENPGM | RANDEN | RANDOPT)
> +#define MACRONIX_RANDOMIZER_MODE_EXIT (RANDEN | RANDOPT)
> +
>  struct nand_onfi_vendor_macronix {
>  	u8 reserved;
>  	u8 reliability_func;
> @@ -29,15 +37,76 @@ static int macronix_nand_setup_read_retry(struct nand_chip *chip, int mode)
>  	return nand_set_features(chip, ONFI_FEATURE_ADDR_READ_RETRY, feature);
>  }
>  
> +static int macronix_nand_randomizer_check_enable(struct nand_chip *chip)
> +{
> +	u8 feature[ONFI_SUBFEATURE_PARAM_LEN];
> +	int ret;
> +
> +	ret = nand_get_features(chip, ONFI_FEATURE_ADDR_MXIC_RANDOMIZER,
> +				feature);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (feature[0])
> +		return feature[0];
> +
> +	feature[0] = MACRONIX_RANDOMIZER_MODE_ENTER;
> +	ret = nand_set_features(chip, ONFI_FEATURE_ADDR_MXIC_RANDOMIZER,
> +				feature);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* RANDEN and RANDOPT OTP bits are programmed */
> +	feature[0] = 0x0;
> +	ret = nand_prog_page_op(chip, 0, 0, feature, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = nand_get_features(chip, ONFI_FEATURE_ADDR_MXIC_RANDOMIZER,
> +				feature);
> +	if (ret < 0)
> +		return ret;
> +
> +	feature[0] &= MACRONIX_RANDOMIZER_MODE_EXIT;
> +	ret = nand_set_features(chip, ONFI_FEATURE_ADDR_MXIC_RANDOMIZER,
> +				feature);
> +	if (ret < 0)
> +		return ret;
> +
> +	return feature[0];

Can feature[0] be != 0 ? I don't think so, in this case I prefer a:
return 0;

> +}
> +
>  static void macronix_nand_onfi_init(struct nand_chip *chip)
>  {
>  	struct nand_parameters *p = &chip->parameters;
>  	struct nand_onfi_vendor_macronix *mxic;
> +	struct device_node *dn = nand_get_flash_node(chip);
> +	int rand_otp = 0;
> +	int ret;
>  
>  	if (!p->onfi)
>  		return;
>  
> +	if (of_find_property(dn, "mxic,enable-randomizer-otp", NULL))
> +		rand_otp = 1;
> +
>  	mxic = (struct nand_onfi_vendor_macronix *)p->onfi->vendor;
> +	/* Subpage write is prohibited in randomizer operatoin */

                                       with          operation

> +	if (rand_otp && chip->options & NAND_NO_SUBPAGE_WRITE &&
> +	    mxic->reliability_func & MACRONIX_RANDOMIZER_BIT) {
> +		if (p->supports_set_get_features) {
> +			bitmap_set(p->set_feature_list,
> +				   ONFI_FEATURE_ADDR_MXIC_RANDOMIZER, 1);
> +			bitmap_set(p->get_feature_list,
> +				   ONFI_FEATURE_ADDR_MXIC_RANDOMIZER, 1);
> +			ret = macronix_nand_randomizer_check_enable(chip);
> +			if (ret < 0)
> +				pr_info("Macronix NAND randomizer failed\n");
> +			else
> +				pr_info("Macronix NAND randomizer enabled\n");

Maybe we should update the bitmaps only if it succeeds?

> +		}
> +	}
> +
>  	if ((mxic->reliability_func & MACRONIX_READ_RETRY_BIT) == 0)
>  		return;
>  

With the above fixed,
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miquèl
