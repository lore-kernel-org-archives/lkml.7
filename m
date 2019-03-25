Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B50C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F087820848
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730113AbfCYSc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 14:32:26 -0400
Received: from foss.arm.com ([217.140.101.70]:53526 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729072AbfCYScY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 14:32:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 557901596;
        Mon, 25 Mar 2019 11:32:23 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B2493F575;
        Mon, 25 Mar 2019 11:32:20 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] EDAC: add EDAC driver for DMC520
To:     Rui Zhao <ruizhao@outlook.com>
Cc:     "bp@alien8.de" <bp@alien8.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "okaya@kernel.org" <okaya@kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "hangl@microsoft.com" <hangl@microsoft.com>,
        "lewan@microsoft.com" <lewan@microsoft.com>,
        Rui Zhao <ruizhao@microsoft.com>
References: <BN7PR08MB5572D3A5217C4749AC4E7DC4AE4C0@BN7PR08MB5572.namprd08.prod.outlook.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <95fe6765-ef70-99df-5fa3-703cb0c1af0f@arm.com>
Date:   Mon, 25 Mar 2019 18:32:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <BN7PR08MB5572D3A5217C4749AC4E7DC4AE4C0@BN7PR08MB5572.namprd08.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rui,

On 07/03/2019 01:24, Rui Zhao wrote:
> From: Rui Zhao <ruizhao@microsoft.com>
> New driver supports error detection and correction on
> the devices with ARM DMC-520 memory controller.


> diff --git a/drivers/edac/dmc520_edac.c b/drivers/edac/dmc520_edac.c
> new file mode 100644
> index 0000000..c70ce4e
> --- /dev/null
> +++ b/drivers/edac/dmc520_edac.c
> @@ -0,0 +1,619 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +// EDAC driver for DMC-520

[..]

> +// DMC-520 types, masks and bitfields
> +#define MEMORY_TYPE_LPDDR3			0
> +#define MEMORY_TYPE_DDR3			1
> +#define MEMORY_TYPE_DDR4			2
> +#define MEMORY_TYPE_LPDDR4			3

(this might be better as an enum as it hints to the compiler that only these
values can ever happen. An example of where this is handy further down...)


> +#define MEMORY_DEV_WIDTH_X4			0
> +#define MEMORY_DEV_WIDTH_X8			1
> +#define MEMORY_DEV_WIDTH_X16			2
> +#define MEMORY_DEV_WIDTH_X32			3

(this might be better as an enum)


> +struct dmc520_edac {
> +	void __iomem *reg_base;

> +	char message[EDAC_MSG_BUF_SIZE];

Does there need to be an irq-safe lock for this mesage buffer?
Your snprintf() into it in dmc520_handle_dram_ecc_errors(), which is called from both
dmc520_edac_dram_ue_isr() and dmc520_edac_dram_ce_isr()... if these are wired up as
different irqs, they could happen on different CPUs concurrently...


> +};


> +static bool dmc520_get_dram_ecc_error_info(struct dmc520_edac *edac,
> +					   bool is_ce,
> +					   struct ecc_error_info *info)
> +{
> +	u32 reg_offset_low, reg_offset_high;
> +	u32 reg_val_low, reg_val_high;
> +	bool valid;
> +
> +	reg_offset_low = is_ce ? REG_OFFSET_DRAM_ECC_ERRC_INT_INFO_31_00 :
> +				 REG_OFFSET_DRAM_ECC_ERRD_INT_INFO_31_00;
> +	reg_offset_high = is_ce ? REG_OFFSET_DRAM_ECC_ERRC_INT_INFO_63_32 :
> +				  REG_OFFSET_DRAM_ECC_ERRD_INT_INFO_63_32;
> +
> +	reg_val_low = dmc520_read_reg(edac, reg_offset_low);
> +	reg_val_high = dmc520_read_reg(edac, reg_offset_high);
> +
> +	valid = (FIELD_GET(REG_FIELD_ERR_INFO_LOW_VALID, reg_val_low) != 0) &&
> +		(FIELD_GET(REG_FIELD_ERR_INFO_HIGH_VALID, reg_val_high) != 0);
> +
> +	if (info) {

I see one caller, dmc520_handle_dram_ecc_errors(), which has info on the stack... is it
possible for info to be NULL here?


> +		if (valid) {
> +			info->col = FIELD_GET(REG_FIELD_ERR_INFO_LOW_COL,
> +					      reg_val_low);
> +			info->row = FIELD_GET(REG_FIELD_ERR_INFO_LOW_ROW,
> +					      reg_val_low);
> +			info->rank = FIELD_GET(REG_FIELD_ERR_INFO_LOW_RANK,
> +					       reg_val_low);
> +			info->bank = FIELD_GET(REG_FIELD_ERR_INFO_HIGH_BANK,
> +					       reg_val_high);
> +		} else {
> +			memset(info, 0, sizeof(struct ecc_error_info));
> +		}
> +	}
> +
> +	return valid;
> +}

> +static enum mem_type dmc520_get_mtype(struct dmc520_edac *edac)
> +{
> +	enum mem_type mt;
> +	u32 reg_val, type;
> +
> +	reg_val = dmc520_read_reg(edac, REG_OFFSET_MEMORY_TYPE_NOW);
> +	type = FIELD_GET(REG_FIELD_MEMORY_TYPE, reg_val);
> +
> +	switch (type) {
> +	case MEMORY_TYPE_LPDDR3:
> +	case MEMORY_TYPE_DDR3:
> +		mt = MEM_DDR3;
> +		break;
> +
> +	case MEMORY_TYPE_DDR4:
> +	case MEMORY_TYPE_LPDDR4:
> +	default:

Is this default just to shut the compiler warning up?
If so, you could use an enum and the compiler won't warn for a switch() that has all the
cases covered.


> +		mt = MEM_DDR4;
> +		break;
> +	}
> +	return mt;
> +}


> +static irqreturn_t dmc520_edac_dram_ce_isr(int irq, void *data)
> +{
> +	return dmc520_edac_dram_ecc_isr(irq, data, true);
> +}
> +
> +static irqreturn_t dmc520_edac_dram_ue_isr(int irq, void *data)
> +{
> +	return dmc520_edac_dram_ecc_isr(irq, data, false);
> +}

How come these calls aren't folded into the one-size fits all irq handler below?
If the hardware always sets the status register, does the irqchip driver need to call a
different helper?


> +static irqreturn_t dmc520_edac_all_isr(int irq, void *data)
> +{
> +	struct mem_ctl_info *mci;
> +	struct dmc520_edac *edac;
> +	u32 status;
> +
> +	mci = data;
> +	edac = mci->pvt_info;
> +
> +	status = dmc520_read_reg(edac, REG_OFFSET_INTERRUPT_STATUS);
> +
> +	if (status & DRAM_ECC_INT_CE_MASK)
> +		dmc520_edac_dram_ce_isr(irq, data);
> +
> +	if (status & DRAM_ECC_INT_UE_MASK)
> +		dmc520_edac_dram_ue_isr(irq, data);
> +
> +	// Other interrupt handlers can be added
> +
> +	return IRQ_HANDLED;


Shouldn't there be a way of getting IRQ_NONE out of this?


> +}

[...]


> +static int count_set_bits(u32 n)
> +{
> +	int count;
> +
> +	for (count = 0; n != 0; n &= (n - 1))
> +		count++;
> +
> +	return count;
> +}

Isn't this what hweight() does?



> +static int dmc520_edac_probe(struct platform_device *pdev)
> +{
> +	struct device *dev;
> +	struct dmc520_edac *edac;
> +	struct mem_ctl_info *mci;
> +	struct edac_mc_layer layers[1];
> +	int ret, irq, nintr;
> +	struct resource *res;
> +	void __iomem *reg_base;
> +	u32 status, current_bit, interrupt_mask;
> +	bool interrupt_shared;
> +
> +	dev = &pdev->dev;
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	reg_base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(reg_base))
> +		return PTR_ERR(reg_base);
> +
> +	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
> +	layers[0].size = dmc520_get_rank_count(reg_base);
> +	layers[0].is_virt_csrow = true;
> +
> +	mci = edac_mc_alloc(dmc520_mc_idx++, ARRAY_SIZE(layers), layers,
> +			    sizeof(struct dmc520_edac));
> +	if (!mci) {
> +		edac_printk(KERN_ERR, EDAC_MOD_NAME,
> +			    "Failed to allocate memory for mc instance\n");
> +		return -ENOMEM;
> +	}
> +
> +	edac = mci->pvt_info;
> +	edac->reg_base = reg_base;
> +
> +	if (!dmc520_is_ecc_enabled(edac)) {
> +		edac_printk(KERN_ERR, EDAC_MOD_NAME, "ECC not enabled\n");
> +		ret = -ENXIO;
> +		goto err;
> +	}
> +
> +	platform_set_drvdata(pdev, mci);
> +
> +	mci->pdev = dev;
> +	mci->mtype_cap = MEM_FLAG_DDR3 | MEM_FLAG_DDR4;
> +	mci->edac_ctl_cap = EDAC_FLAG_NONE | EDAC_FLAG_SECDED;
> +	mci->edac_cap = EDAC_FLAG_SECDED;
> +	mci->scrub_cap = SCRUB_FLAG_HW_SRC;
> +	mci->scrub_mode = dmc520_is_scrub_configured(edac) ?
> +			  SCRUB_HW_SRC : SCRUB_NONE;
> +	mci->ctl_name = EDAC_CTL_NAME;
> +	mci->dev_name = dev_name(mci->pdev);
> +	mci->mod_name = EDAC_MOD_NAME;
> +	mci->ctl_page_to_phys = NULL;
> +
> +	edac_op_state = EDAC_OPSTATE_INT;
> +
> +	dmc520_init_csrow(mci);
> +
> +	ret = edac_mc_add_mc(mci);
> +	if (ret) {
> +		edac_printk(KERN_ERR, EDAC_MOD_NAME,
> +			    "Failed to register with EDAC core\n");
> +		goto err;
> +	}
> +
> +	interrupt_shared = false;
> +	interrupt_mask = DRAM_ECC_INT_CE_MASK | DRAM_ECC_INT_UE_MASK;
> +
> +	if (dev->of_node) {
> +		if (of_find_property(dev->of_node, "interrupt-shared", NULL))
> +			interrupt_shared = true;
> +
> +		if (of_property_read_u32(dev->of_node,
> +					 "interrupt-mask",
> +					 &interrupt_mask)) {
> +			edac_printk(KERN_INFO, EDAC_MOD_NAME,
> +				    "Use default interrupt mask 0x%X\n",
> +				    interrupt_mask);
> +		}
> +
> +		interrupt_mask &= ALL_INT_MASK;
> +	}
> +
> +	// Clear interrupts
> +	status = dmc520_read_reg(edac, REG_OFFSET_INTERRUPT_STATUS);
> +	dmc520_write_reg(edac, 0, REG_OFFSET_INTERRUPT_CONTROL);
> +	dmc520_write_reg(edac, ALL_INT_MASK, REG_OFFSET_INTERRUPT_CLR);
> +
> +	// Reset DRAM CE/UE counters
> +	if (interrupt_mask & DRAM_ECC_INT_CE_MASK)
> +		dmc520_get_dram_ecc_error_count(edac, true);
> +
> +	if (interrupt_mask & DRAM_ECC_INT_UE_MASK)
> +		dmc520_get_dram_ecc_error_count(edac, false);
> +
> +	nintr = count_set_bits(interrupt_mask);
> +	if (nintr == 0) {
> +		edac_printk(KERN_ERR, EDAC_MC,
> +			    "Invalid interrupt mask 0x%X\n",
> +			    interrupt_mask);
> +		ret = -EINVAL;
> +		goto err;

This is after edac_mc_add_mc(), and on your remove path you have a edac_mc_del_mc(). Is
that necessary here? Do you need an err_del_mc?



> +	}
> +
> +	current_bit = BIT(0);
> +	for (irq = 0; irq < nintr; ++irq) {
> +		irq_handler_t edac_isr;
> +		int irq_id = platform_get_irq(pdev, irq);
> +
> +		if (irq_id < 0) {
> +			edac_printk(KERN_ERR, EDAC_MC,
> +				    "Failed to get %s irq\n",
> +				    irq == 0 ? "CE" : "UE");
> +			ret = -ENODEV;
> +			goto err;

err_del_mc?


> +		}
> +
> +		if (interrupt_shared) {
> +			edac_isr = dmc520_edac_all_isr;
> +		} else {
> +			while (current_bit & ALL_INT_MASK) {
> +				if (current_bit & interrupt_mask)
> +					break;
> +
> +				current_bit <<= 1;
> +			}
> +
> +			if (current_bit & DRAM_ECC_INT_CE_MASK) {
> +				edac_isr = dmc520_edac_dram_ce_isr;
> +			} else if (current_bit & DRAM_ECC_INT_UE_MASK) {
> +				edac_isr = dmc520_edac_dram_ue_isr;
> +			} else {
> +				edac_printk(KERN_ERR, EDAC_MC,
> +					    "Invalid interrupt bit 0x%X\n",
> +					    current_bit);
> +				ret = -EINVAL;
> +				goto err;

err_del_mc?

> +			}
> +
> +			current_bit <<= 1;
> +		}
> +
> +		ret = devm_request_irq(&pdev->dev,
> +				       irq_id,
> +				       edac_isr,
> +				       0,
> +				       dev_name(&pdev->dev),
> +				       mci);
> +		if (ret < 0) {
> +			edac_printk(KERN_ERR, EDAC_MC,
> +				    "Failed to request irq %d\n", irq_id);
> +			goto err;

err_del_mc?

> +		}
> +
> +		// Only one irq for all interrupts
> +		if (interrupt_shared)
> +			break;
> +	}
> +
> +	// Enable interrupts
> +	dmc520_write_reg(edac, interrupt_mask, REG_OFFSET_INTERRUPT_CONTROL);
> +
> +	return 0;
> +
> +err:
> +	edac_mc_free(mci);
> +
> +	return ret;
> +}


[...]

> +MODULE_AUTHOR("Rui Zhao <ruizhao@microsoft.com>");
> +MODULE_DESCRIPTION("DMC-520 ECC driver");

> +MODULE_LICENSE("GPL v2");

This doesn't match your SPDX tag above:
| // SPDX-License-Identifier: GPL-2.0+

Can I use a later version?



Thanks,

James
