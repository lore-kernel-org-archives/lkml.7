Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A89AC4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 08:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FA2F21655
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 08:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbfJGISx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 04:18:53 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:56637 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbfJGISx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 04:18:53 -0400
Received: from xps13 (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 6BD9C100010;
        Mon,  7 Oct 2019 08:18:48 +0000 (UTC)
Date:   Mon, 7 Oct 2019 10:18:47 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mason Yang <masonccyang@mxic.com.tw>
Cc:     richard@nod.at, marek.vasut@gmail.com, dwmw2@infradead.org,
        bbrezillon@kernel.org, computersforpeace@gmail.com,
        vigneshr@ti.com, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, frieder.schrempf@kontron.de,
        linux-mtd@lists.infradead.org, tglx@linutronix.de
Subject: Re: [PATCH v3] mtd: rawnand: Add support for Macronix NAND
 randomizer
Message-ID: <20191007101847.7fcfcfc7@xps13>
In-Reply-To: <1567676229-23414-1-git-send-email-masonccyang@mxic.com.tw>
References: <1567676229-23414-1-git-send-email-masonccyang@mxic.com.tw>
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

Mason Yang <masonccyang@mxic.com.tw> wrote on Thu,  5 Sep 2019 17:37:09
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
> i.e.,
> 
> 	nand: nand-controller@unit-address {
> 
> 		nand@0 {
> 			reg = <0>;
> 			mxic,enable-randomizer-otp;
> 		};
> 	};
> 
> --
> changelog
> v3:
> To enable randomizer by specific DT property in children nodes,
> mxic,enable-randomizer-otp;
> 
> v2:
> To enable randomizer by checking chip options NAND_NO_SUBPAGE_WRITE
> 
> v1:
> To enable randomizer by sys-fs
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> ---
>  drivers/mtd/nand/raw/nand_macronix.c | 64 ++++++++++++++++++++++++++++++++++++

As long as you modify bindings, you should write a separate patch to
update the documentation and get it acked by Rob Herring.

>  1 file changed, 64 insertions(+)
> 
> diff --git a/drivers/mtd/nand/raw/nand_macronix.c b/drivers/mtd/nand/raw/nand_macronix.c
> index 58511ae..d5df09a 100644
> --- a/drivers/mtd/nand/raw/nand_macronix.c
> +++ b/drivers/mtd/nand/raw/nand_macronix.c
> @@ -11,6 +11,13 @@
>  #define MACRONIX_READ_RETRY_BIT BIT(0)
>  #define MACRONIX_NUM_READ_RETRY_MODES 6
>  
> +#define MACRONIX_RANDOMIZER_BIT BIT(1)
> +#define ONFI_FEATURE_ADDR_MXIC_RANDOMIZER 0xB0
> +#define MACRONIX_RANDOMIZER_ENPGM BIT(0)
> +#define MACRONIX_RANDOMIZER_RANDEN BIT(1)
> +#define MACRONIX_RANDOMIZER_RANDOPT BIT(2)
> +#define MACRONIX_RANDOMIZER_MODE_EXIT ~MACRONIX_RANDOMIZER_ENPGM

I would rather prefer a 

#define ...RANDOMISER_MODE_ENTER (ENGPM | RANDEN | RANDOPT)
#define ...RANDOMISER_MODE_EXIT (RANDEN | RANDOPT)

> +
>  struct nand_onfi_vendor_macronix {
>  	u8 reserved;
>  	u8 reliability_func;
> @@ -29,15 +36,72 @@ static int macronix_nand_setup_read_retry(struct nand_chip *chip, int mode)
>  	return nand_set_features(chip, ONFI_FEATURE_ADDR_READ_RETRY, feature);
>  }
>  
> +static void macronix_nand_randomizer_check_enable(struct nand_chip *chip)

You should return something and check it from the calling function.

> +{
> +	u8 feature[ONFI_SUBFEATURE_PARAM_LEN];
> +	int ret;
> +
> +	ret = nand_get_features(chip, ONFI_FEATURE_ADDR_MXIC_RANDOMIZER,
> +				feature);
> +	if (feature[0]) {
> +		pr_info("Macronix NAND randomizer enabled:0x%x\n", feature[0]);
> +		return;
> +	}
> +
> +	feature[0] = MACRONIX_RANDOMIZER_ENPGM | MACRONIX_RANDOMIZER_RANDEN |
> +		     MACRONIX_RANDOMIZER_RANDOPT;
> +	ret = nand_set_features(chip, ONFI_FEATURE_ADDR_MXIC_RANDOMIZER,
> +				feature);
> +	if (ret)
> +		goto err;
> +
> +	feature[0] = 0x0;
> +	ret = nand_prog_page_op(chip, 0, 0, feature, 1);

What is this? A comment is needed.

> +	if (ret)
> +		goto err;
> +
> +	ret = nand_get_features(chip, ONFI_FEATURE_ADDR_MXIC_RANDOMIZER,
> +				feature);
> +	if (ret)
> +		goto err;
> +
> +	feature[0] &= MACRONIX_RANDOMIZER_MODE_EXIT;
> +	ret = nand_set_features(chip, ONFI_FEATURE_ADDR_MXIC_RANDOMIZER,
> +				feature);
> +	if (ret)
> +		goto err;
> +
> +	pr_info("Macronix NAND randomizer enable ok\n");

The pr_info "ok" could be dropped, the "failed" one would go in
nand_onfi_init() after a check on the return code.

Then, no more goto's.

> +	return;
> +err:
> +	pr_err("Macronix NAND randomizer enable failed\n");
> +}
> +
>  static void macronix_nand_onfi_init(struct nand_chip *chip)
>  {
>  	struct nand_parameters *p = &chip->parameters;
>  	struct nand_onfi_vendor_macronix *mxic;
> +	struct device_node *dn = nand_get_flash_node(chip);
> +	int rand_otp = 0;
>  
>  	if (!p->onfi)
>  		return;
>  
> +	if (of_find_property(dn, "mxic,enable-randomizer-otp", NULL))
> +		rand_otp = 1;
> +
>  	mxic = (struct nand_onfi_vendor_macronix *)p->onfi->vendor;
> +	if (rand_otp && chip->options & NAND_NO_SUBPAGE_WRITE &&
> +	    mxic->reliability_func & MACRONIX_RANDOMIZER_BIT) {
> +		if (p->supports_set_get_features) {
> +			bitmap_set(p->set_feature_list,
> +				   ONFI_FEATURE_ADDR_MXIC_RANDOMIZER, 1);
> +			bitmap_set(p->get_feature_list,
> +				   ONFI_FEATURE_ADDR_MXIC_RANDOMIZER, 1);
> +			macronix_nand_randomizer_check_enable(chip);
> +		}
> +	}
> +
>  	if ((mxic->reliability_func & MACRONIX_READ_RETRY_BIT) == 0)
>  		return;
>  

Thanks,
Miquèl
