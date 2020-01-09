Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0621C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A175206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387822AbgAIQra convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:47:30 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:48001 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730602AbgAIQra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:47:30 -0500
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 58A56E000F;
        Thu,  9 Jan 2020 16:47:14 +0000 (UTC)
Date:   Thu, 9 Jan 2020 17:47:13 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mason Yang <masonccyang@mxic.com.tw>
Cc:     richard@nod.at, marek.vasut@gmail.com, dwmw2@infradead.org,
        bbrezillon@kernel.org, computersforpeace@gmail.com,
        vigneshr@ti.com, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 2/4] mtd: rawnand: Add support Macronix Block
 Protection function
Message-ID: <20200109174713.71ea377b@xps13>
In-Reply-To: <1572256527-5074-3-git-send-email-masonccyang@mxic.com.tw>
References: <1572256527-5074-1-git-send-email-masonccyang@mxic.com.tw>
        <1572256527-5074-3-git-send-email-masonccyang@mxic.com.tw>
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

Mason Yang <masonccyang@mxic.com.tw> wrote on Mon, 28 Oct 2019 17:55:25
+0800:

> Macronix AC series support using SET_FEATURES to change
> Block Protection and Unprotection.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> ---
>  drivers/mtd/nand/raw/nand_macronix.c | 69 +++++++++++++++++++++++++++++++++---
>  1 file changed, 65 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/nand_macronix.c b/drivers/mtd/nand/raw/nand_macronix.c
> index 58511ae..13929bf 100644
> --- a/drivers/mtd/nand/raw/nand_macronix.c
> +++ b/drivers/mtd/nand/raw/nand_macronix.c
> @@ -11,6 +11,10 @@
>  #define MACRONIX_READ_RETRY_BIT BIT(0)
>  #define MACRONIX_NUM_READ_RETRY_MODES 6
>  
> +#define ONFI_FEATURE_ADDR_MXIC_PROTECTION 0xA0
> +#define MXIC_BLOCK_PROTECTION_ALL_LOCK 0x38
> +#define MXIC_BLOCK_PROTECTION_ALL_UNLOCK 0x0
> +
>  struct nand_onfi_vendor_macronix {
>  	u8 reserved;
>  	u8 reliability_func;
> @@ -57,7 +61,7 @@ static void macronix_nand_onfi_init(struct nand_chip *chip)
>   * the timings unlike what is declared in the parameter page. Unflag
>   * this feature to avoid unnecessary downturns.
>   */
> -static void macronix_nand_fix_broken_get_timings(struct nand_chip *chip)
> +static int macronix_nand_fix_broken_get_timings(struct nand_chip *chip)
>  {
>  	unsigned int i;
>  	static const char * const broken_get_timings[] = {
> @@ -78,7 +82,7 @@ static void macronix_nand_fix_broken_get_timings(struct nand_chip *chip)
>  	};
>  
>  	if (!chip->parameters.supports_set_get_features)
> -		return;
> +		return 0;
>  
>  	for (i = 0; i < ARRAY_SIZE(broken_get_timings); i++) {
>  		if (!strcmp(broken_get_timings[i], chip->parameters.model))
> @@ -86,22 +90,79 @@ static void macronix_nand_fix_broken_get_timings(struct nand_chip *chip)
>  	}
>  
>  	if (i == ARRAY_SIZE(broken_get_timings))
> -		return;
> +		return 0;
>  
>  	bitmap_clear(chip->parameters.get_feature_list,
>  		     ONFI_FEATURE_ADDR_TIMING_MODE, 1);
>  	bitmap_clear(chip->parameters.set_feature_list,
>  		     ONFI_FEATURE_ADDR_TIMING_MODE, 1);
> +	return 1;
> +}
> +
> +/*
> + * Macronix NAND supports Block Protection by Protectoin(PT) pin;
> + * active high at power-on which protects the entire chip even the #WP is
> + * disabled. Lock/unlock protection area can be partition according to
> + * protection bits, i.e. upper 1/2 locked, upper 1/4 locked and so on.
> + */
> +static int mxic_nand_lock(struct nand_chip *chip, loff_t ofs, uint64_t len)
> +{
> +	u8 feature[ONFI_SUBFEATURE_PARAM_LEN];
> +	int ret;
> +
> +	feature[0] = MXIC_BLOCK_PROTECTION_ALL_LOCK;
> +	nand_select_target(chip, 0);
> +	ret = nand_set_features(chip, ONFI_FEATURE_ADDR_MXIC_PROTECTION,
> +				feature);
> +	nand_deselect_target(chip);
> +	if (ret)
> +		pr_err("%s all blocks failed\n", __func__);
> +
> +	return ret;
> +}
> +
> +static int mxic_nand_unlock(struct nand_chip *chip, loff_t ofs, uint64_t len)
> +{
> +	u8 feature[ONFI_SUBFEATURE_PARAM_LEN];
> +	int ret;
> +
> +	feature[0] = MXIC_BLOCK_PROTECTION_ALL_UNLOCK;
> +	nand_select_target(chip, 0);
> +	ret = nand_set_features(chip, ONFI_FEATURE_ADDR_MXIC_PROTECTION,
> +				feature);
> +	nand_deselect_target(chip);
> +	if (ret)
> +		pr_err("%s all blocks failed\n", __func__);
> +
> +	return ret;
>  }
>  
> +/*
> + * Macronix NAND AC series support Block Protection by SET_FEATURES
> + * to lock/unlock blocks.
> + */
>  static int macronix_nand_init(struct nand_chip *chip)
>  {
> +	bool blockprotected = false;
> +
>  	if (nand_is_slc(chip))
>  		chip->options |= NAND_BBM_FIRSTPAGE | NAND_BBM_SECONDPAGE;
>  
> -	macronix_nand_fix_broken_get_timings(chip);
> +	if (macronix_nand_fix_broken_get_timings(chip))
> +		blockprotected = true;

I don't like this at all :)

Please create a helper which detects which part is broken/protected
then create helpers to act in this case.

If the list is absolutely identical, you can share the detection
helper. Otherwise, if you think the list can diverge, please only share
the list for now and create two detection helpers.

> +
>  	macronix_nand_onfi_init(chip);
>  
> +	if (blockprotected) {
> +		bitmap_set(chip->parameters.set_feature_list,
> +			   ONFI_FEATURE_ADDR_MXIC_PROTECTION, 1);
> +		bitmap_set(chip->parameters.get_feature_list,
> +			   ONFI_FEATURE_ADDR_MXIC_PROTECTION, 1);
> +
> +		chip->_lock = mxic_nand_lock;
> +		chip->_unlock = mxic_nand_unlock;
> +	}
> +
>  	return 0;
>  }
>  


Thanks,
Miquèl
