Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E20C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 08:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1460220867
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 08:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfJGIpH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 04:45:07 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:42833 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbfJGIpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 04:45:06 -0400
X-Originating-IP: 86.250.200.211
Received: from xps13 (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id B1759E0011;
        Mon,  7 Oct 2019 08:45:02 +0000 (UTC)
Date:   Mon, 7 Oct 2019 10:45:01 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mason Yang <masonccyang@mxic.com.tw>
Cc:     richard@nod.at, marek.vasut@gmail.com, dwmw2@infradead.org,
        bbrezillon@kernel.org, computersforpeace@gmail.com,
        vigneshr@ti.com, marcel.ziswiler@toradex.com, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, frieder.schrempf@kontron.de,
        gregkh@linuxfoundation.org, linux-mtd@lists.infradead.org,
        tglx@linutronix.de
Subject: Re: [PATCH RFC 3/3] mtd: rawnand: Add support Macronix power down
 mode
Message-ID: <20191007104501.1b4ed8ed@xps13>
In-Reply-To: <1568793387-25199-3-git-send-email-masonccyang@mxic.com.tw>
References: <1568793387-25199-1-git-send-email-masonccyang@mxic.com.tw>
        <1568793387-25199-3-git-send-email-masonccyang@mxic.com.tw>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mason,

Mason Yang <masonccyang@mxic.com.tw> wrote on Wed, 18 Sep 2019 15:56:26
+0800:

> Macronix AD series support using power down command to
> enter a minimum power consumption state.
> 
> MTD default _suspend/_resume function replacement by
> manufacturer postponed initialization.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> ---
>  drivers/mtd/nand/raw/nand_macronix.c | 78 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 77 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/nand_macronix.c b/drivers/mtd/nand/raw/nand_macronix.c
> index 991c636..99a7b2e 100644
> --- a/drivers/mtd/nand/raw/nand_macronix.c
> +++ b/drivers/mtd/nand/raw/nand_macronix.c
> @@ -15,6 +15,8 @@
>  #define MXIC_BLOCK_PROTECTION_ALL_LOCK 0x38
>  #define MXIC_BLOCK_PROTECTION_ALL_UNLOCK 0x0
>  
> +#define NAND_CMD_POWER_DOWN 0xB9
> +
>  struct nand_onfi_vendor_macronix {
>  	u8 reserved;
>  	u8 reliability_func;
> @@ -78,6 +80,12 @@ static void macronix_nand_onfi_init(struct nand_chip *chip)
>  		"MX30UF4G28AC",
>  };
>  
> +static const char * const nand_power_down[] = {
> +		"MX30LF1G28AD",
> +		"MX30LF2G28AD",
> +		"MX30LF4G28AD",
> +};
> +
>  static void macronix_nand_fix_broken_get_timings(struct nand_chip *chip)
>  {
>  	unsigned int i;
> @@ -144,8 +152,64 @@ static int mxic_nand_unlock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
>  	return ret;
>  }
>  
> +int nand_power_down_op(struct nand_chip *chip)
> +{
> +	int ret;
> +
> +	if (nand_has_exec_op(chip)) {
> +		struct nand_op_instr instrs[] = {
> +			NAND_OP_CMD(NAND_CMD_POWER_DOWN, 0),
> +		};
> +
> +		struct nand_operation op = NAND_OPERATION(chip->cur_cs, instrs);
> +
> +		ret = nand_exec_op(chip, &op);
> +		if (ret)
> +			return ret;
> +
> +	} else {
> +		chip->legacy.cmdfunc(chip, NAND_CMD_POWER_DOWN, -1, -1);
> +	}
> +
> +	return 0;
> +}
> +
> +static int mxic_nand_suspend(struct mtd_info *mtd)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +
> +	mutex_lock(&chip->lock);
> +
> +	nand_select_target(chip, 0);
> +	nand_power_down_op(chip);
> +	nand_deselect_target(chip);
> +
> +	chip->suspend = 1;
> +	mutex_unlock(&chip->lock);
> +
> +	return 0;
> +}
> +
> +static void mxic_nand_resume(struct mtd_info *mtd)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +
> +	mutex_lock(&chip->lock);
> +	// toggle #CS pin to resume NAND device

C++ style comments are forbidden in code.

> +	nand_select_target(chip, 0);

On several NAND controllers there is no way to act on the CS line
without actually writing bytes to the NAND chip. So basically this
is very likely to not work.

> +	ndelay(20);

Is this delay known somewhere? Is this purely experimental?

> +	nand_deselect_target(chip);
> +
> +	if (chip->suspend)
> +		chip->suspended = 0;
> +	else
> +		pr_err("%s call for a chip which is not in suspended state\n",
> +		       __func__);
> +	mutex_unlock(&chip->lock);
> +}
> +
>  /*
> - * Macronix AC series support using SET/GET_FEATURES to change
> + * Macronix AC and AD series support using SET/GET_FEATURES to change
>   * Block Protection and Unprotection.
>   *
>   * MTD call-back function replacement by manufacturer postponed
> @@ -163,6 +227,18 @@ static void macronix_nand_post_init(struct nand_chip *chip)
>  		}
>  	}
>  
> +	for (i = 0; i < ARRAY_SIZE(nand_power_down); i++) {
> +		if (!strcmp(nand_power_down[i], chip->parameters.model)) {
> +			blockprotected = 1;
> +			break;
> +		}
> +	}
> +
> +	if (i < ARRAY_SIZE(nand_power_down)) {
> +		mtd->_suspend = mxic_nand_suspend;
> +		mtd->_resume = mxic_nand_resume;
> +	}
> +
>  	if (blockprotected && chip->parameters.supports_set_get_features) {
>  		bitmap_set(chip->parameters.set_feature_list,
>  			   ONFI_FEATURE_ADDR_MXIC_PROTECTION, 1);

Thanks,
Miquèl
