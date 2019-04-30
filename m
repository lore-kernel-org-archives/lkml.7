Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FE9C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 07:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E374B21670
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 07:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfD3HzM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 03:55:12 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:49545 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbfD3HzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 03:55:12 -0400
X-Originating-IP: 90.88.147.33
Received: from xps13 (aaubervilliers-681-1-27-33.w90-88.abo.wanadoo.fr [90.88.147.33])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 7D7A41C0015;
        Tue, 30 Apr 2019 07:55:09 +0000 (UTC)
Date:   Tue, 30 Apr 2019 09:55:08 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        "Marek Vasut" <marek.vasut@gmail.com>,
        Frieder Schrempf <frieder.schrempf@exceet.de>
Subject: Re: [PATCH 3/4] mtd: spinand: Enabled support to detect parameter
 page
Message-ID: <20190430095508.706fa125@xps13>
In-Reply-To: <MN2PR08MB5951E8D99AA1FBD972131388B85F0@MN2PR08MB5951.namprd08.prod.outlook.com>
References: <MN2PR08MB5951E8D99AA1FBD972131388B85F0@MN2PR08MB5951.namprd08.prod.outlook.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shivamurthy,

"Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com> wrote on
Tue, 26 Mar 2019 10:52:00 +0000:

> Some of the SPI NAND devices has parameter page which is similar to ONFI
> table.
> 
> But, it may not be self sufficient to propagate all the required
> parameters. Fixup function has been added in struct manufacturer to
> accommodate this.
> 
> Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
> ---
>  drivers/mtd/nand/spi/core.c | 113 +++++++++++++++++++++++++++++++++++-
>  include/linux/mtd/spinand.h |   5 ++
>  2 files changed, 117 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index 985ad52cdaa7..40882a1d2bc1 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -574,6 +574,108 @@ static int spinand_lock_block(struct spinand_device *spinand, u8 lock)
>  	return spinand_write_reg_op(spinand, REG_BLOCK_LOCK, lock);
>  }
>  
> +/**
> + * spinand_read_param_page_op - Read parameter page operation
> + * @spinand: the spinand device
> + * @page: page number where parameter page tables can be found
> + * @parameters: buffer used to store the parameter page

Does not match the prototype

> + * @len: length of the buffer
> + *
> + * Read parameter page
> + *
> + * Returns 0 on success, a negative error code otherwise.
> + */
> +static int spinand_parameter_page_read(struct nand_device *base,

Please use a spinand structure as parameter, you don't need a
nand_device here (same for other spinand functions).

> +				       u8 page, void *buf, unsigned int len)
> +{
> +	struct spinand_device *spinand = nand_to_spinand(base);
> +	struct spi_mem_op pread_op = SPINAND_PAGE_READ_OP(page);
> +	struct spi_mem_op pread_cache_op =
> +				SPINAND_PAGE_READ_FROM_CACHE_OP(false,
> +								0,
> +								1,
> +								buf,
> +								len);
> +	u8 feature;
> +	u8 status;
> +	int ret;
> +
> +	if (len && !buf)
> +		return -EINVAL;
> +
> +	ret = spinand_read_reg_op(spinand, REG_CFG,
> +				  &feature);
> +	if (ret)
> +		return ret;
> +
> +	/* CFG_OTP_ENABLE is used to enable parameter page access */
> +	feature |= CFG_OTP_ENABLE;
> +
> +	spinand_write_reg_op(spinand, REG_CFG, feature);
> +
> +	ret = spi_mem_exec_op(spinand->spimem, &pread_op);
> +	if (ret)
> +		return ret;
> +
> +	ret = spinand_wait(spinand, &status);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = spi_mem_exec_op(spinand->spimem, &pread_cache_op);
> +	if (ret)
> +		return ret;
> +
> +	ret = spinand_read_reg_op(spinand, REG_CFG,
> +				  &feature);
> +	if (ret)
> +		return ret;
> +
> +	feature &= ~CFG_OTP_ENABLE;
> +
> +	spinand_write_reg_op(spinand, REG_CFG, feature);
> +
> +	return 1;

Should return 0

> +}
> +
> +static int check_version(struct nand_device *base,
> +			 struct nand_onfi_params *p, int *onfi_version)
> +{
> +	/**

I don't think you need these /** here, just use /*

> +	 * SPI NAND do not support ONFI standard

What about:

        /*
         * SPI NANDs do not necessarily support ONFI standard, but
         * parameter page looks the same as an ONFI table.
         */

> +	 * But, parameter page looks same as ONFI table
> +	 */
> +	if (!le16_to_cpu(p->revision))
> +		*onfi_version = 0;
> +
> +	return 1;

Functions should return 0 in normal state, not 1.

> +}
> +
> +static int spinand_intf_data(struct nand_device *base,
> +			     struct nand_onfi_params *p)
> +{
> +	struct spinand_device *spinand = nand_to_spinand(base);
> +
> +	/**
> +	 *	Manufacturers may interpret the parameter page differently

           ^^^^^ extra spaces

> +	 */

One-line comment should be in the form /* <comment> */

> +	if (spinand->manufacturer->ops->fixup_param_page)
> +		spinand->manufacturer->ops->fixup_param_page(spinand, p);
> +
> +	return 1;

        return 0;

> +}
> +
> +static int spinand_param_page_detect(struct spinand_device *spinand)
> +{
> +	struct nand_device *base = spinand_to_nand(spinand);
> +
> +	base->helper.page = 0x01;
> +	base->helper.check_revision = check_version;
> +	base->helper.parameter_page_read = spinand_parameter_page_read;
> +	base->helper.init_intf_data = spinand_intf_data;
> +
> +	return nand_onfi_detect(base);
> +}
> +
>  static int spinand_read_page(struct spinand_device *spinand,
>  			     const struct nand_page_io_req *req)
>  {
> @@ -896,7 +998,7 @@ static void spinand_manufacturer_cleanup(struct spinand_device *spinand)
>  		return spinand->manufacturer->ops->cleanup(spinand);
>  }
>  
> -static const struct spi_mem_op *
> +const struct spi_mem_op *
>  spinand_select_op_variant(struct spinand_device *spinand,
>  			  const struct spinand_op_variants *variants)
>  {
> @@ -1012,6 +1114,15 @@ static int spinand_detect(struct spinand_device *spinand)
>  		return ret;
>  	}
>  
> +	if (!spinand->base.memorg.pagesize) {
> +		ret = spinand_param_page_detect(spinand);
> +		if (ret < 0) {
> +			dev_err(dev, "no parameter page for %*phN\n",
> +				SPINAND_MAX_ID_LEN, spinand->id.data);
> +			return ret;
> +		}
> +	}
> +

I think this could be added in a separate patch. Is this the only
condition where we want to read the param page ?

>  	if (nand->memorg.ntargets > 1 && !spinand->select_target) {
>  		dev_err(dev,
>  			"SPI NANDs with more than one die must implement ->select_target()\n");
> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
> index d093d237fba8..57b3b5b075f2 100644
> --- a/include/linux/mtd/spinand.h
> +++ b/include/linux/mtd/spinand.h
> @@ -179,6 +179,8 @@ struct spinand_manufacturer_ops {
>  	int (*detect)(struct spinand_device *spinand);
>  	int (*init)(struct spinand_device *spinand);
>  	void (*cleanup)(struct spinand_device *spinand);
> +	void (*fixup_param_page)(struct spinand_device *spinand,
> +				 struct nand_onfi_params *p);

You could probably add this hook in a separate patch.

>  };
>  
>  /**
> @@ -429,4 +431,7 @@ int spinand_match_and_init(struct spinand_device *dev,
>  int spinand_upd_cfg(struct spinand_device *spinand, u8 mask, u8 val);
>  int spinand_select_target(struct spinand_device *spinand, unsigned int target);
>  
> +const struct spi_mem_op *spinand_select_op_variant(struct spinand_device *spinand,
> +	   const struct spinand_op_variants *variants);

What is it for?

> +
>  #endif /* __LINUX_MTD_SPINAND_H */




Thanks,
Miquèl
