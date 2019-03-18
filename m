Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA99CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7352C2133D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W78XOpAz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbfCRTTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 15:19:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41244 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfCRTTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 15:19:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=O6nE1VspMZ4U/O7OdnEMW1Yxf3ecyS2wU4tVgRueU4E=; b=W78XOpAzyJ9attRhh5cxgoEdR
        LUJ8PmB3ywhFEgESz0Q7qtrDPu3erKUJOIiEUOBG1tXow96eLAFL95PwDollijqcvUBRBpiGZH4XU
        G6SWynjI1n5lM5T8g8qhMox0V55MtVfVOwG9HknRpqczpnXcx+QardDfbgjlLxiRAGpU3BGTYHgUD
        mIxQaTHutStfj7Ocp27azZBKetmUYsSX956UqtZlfwz4DBPQERi+v+LUOZYGha8NMh4NXhE+588w0
        FZLpuey1B6nOKpaQsSfzc21KXJb4gaqu0hhmfiUTNRdpOv6RamPrfb41Oe1E+gSIOaC3ojknY0VbO
        olq2S4L0A==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h5xmr-0004Cd-Cu; Mon, 18 Mar 2019 19:19:05 +0000
Subject: Re: [PATCH v2] EDAC, mellanox: Add ECC support for BlueField DDR4
To:     Junhan Zhou <Junhan@mellanox.com>, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Liming Sun <lsun@mellanox.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <e59276b6f3dc165703ddcb47a8a006d8a62d9c95.1551216637.git.Junhan@mellanox.com>
 <1552934340-10103-1-git-send-email-Junhan@mellanox.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6a56e799-b5fd-8437-6339-9c88acb3bbe5@infradead.org>
Date:   Mon, 18 Mar 2019 12:19:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1552934340-10103-1-git-send-email-Junhan@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/18/19 11:39 AM, Junhan Zhou wrote:
> Add ECC support for Mellanox BlueField SoC DDR controller.
> This requires SMC to the running Arm Trusted Firmware to report
> what is the current memory configuration.
> 
> Signed-off-by: Junhan Zhou <Junhan@mellanox.com>
> ---
>  MAINTAINERS                   |   5 +
>  drivers/edac/Kconfig          |   7 +
>  drivers/edac/Makefile         |   1 +
>  drivers/edac/bluefield_edac.c | 396 ++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 409 insertions(+)
>  create mode 100644 drivers/edac/bluefield_edac.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e17ebf7..394d6c9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5539,6 +5539,11 @@ S:	Supported
>  F:	drivers/edac/aspeed_edac.c
>  F:	Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt
>  
> +EDAC-BLUEFIELD
> +M:	Junhan Zhou <Junhan@mellanox.com>
> +S:	Supported
> +F:	drivers/edac/bluefield_edac.c
> +
>  EDAC-CALXEDA
>  M:	Robert Richter <rric@kernel.org>
>  L:	linux-edac@vger.kernel.org
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 47eb4d1..dfb36f2 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -504,4 +504,11 @@ config EDAC_ASPEED
>  	  First, ECC must be configured in the bootloader. Then, this driver
>  	  will expose error counters via the EDAC kernel framework.
>  
> +config EDAC_BLUEFIELD
> +	tristate "Mellanox BlueField Memory ECC"
> +	depends on (MELLANOX_PLATFORM && ARM64 && ACPI) || COMPILE_TEST

Hi,

While I am in favor of using COMPILE_TEST whenever possible, I don't see
how that is possible here if:

# MELLANOX_PLATFORM is not set
# ARM64 is not set
# ACPI is not set
COMPILE_TEST=y

Can you please explain?

Thanks.


> +	help
> +	  Support for error detection and correction on the
> +	  Mellanox BlueField SoCs.
> +
>  endif # EDAC
> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
> index 89ad4a84..0294a67 100644
> --- a/drivers/edac/Makefile
> +++ b/drivers/edac/Makefile
> @@ -84,3 +84,4 @@ obj-$(CONFIG_EDAC_XGENE)		+= xgene_edac.o
>  obj-$(CONFIG_EDAC_TI)			+= ti_edac.o
>  obj-$(CONFIG_EDAC_QCOM)			+= qcom_edac.o
>  obj-$(CONFIG_EDAC_ASPEED)		+= aspeed_edac.o
> +obj-$(CONFIG_EDAC_BLUEFIELD)		+= bluefield_edac.o
> diff --git a/drivers/edac/bluefield_edac.c b/drivers/edac/bluefield_edac.c
> new file mode 100644
> index 0000000..981f419
> --- /dev/null
> +++ b/drivers/edac/bluefield_edac.c
> @@ -0,0 +1,396 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Bluefield-specific EDAC driver.
> + *
> + * Copyright (c) 2019 Mellanox Technologies.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/arm-smccc.h>
> +#include <linux/edac.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +#include "edac_module.h"
> +
> +#define DRIVER_NAME		"bluefield-edac"
> +
> +/*
> + * Mellanox BlueField EMI (External Memory Interface) register definitions.
> + * Registers which have individual bitfields have a union defining the
> + * bitfields following the address define.
> + */
> +
> +#define MLXBF_EMI_DRAM_ECC_COUNT 0x340
> +
> +union mlxbf_emi_dram_ecc_count {
> +	struct {
> +		u32 single_error_count : 16;
> +		u32 double_error_count : 16;
> +	};
> +
> +	u32 word;
> +};
> +
> +#define MLXBF_EMI_DRAM_ECC_ERROR 0x348
> +
> +union mlxbf_emi_dram_ecc_error {
> +	struct {
> +		u32 dram_ecc_single : 1;
> +		u32 __reserved_0    : 15;
> +		u32 dram_ecc_double : 1;
> +		u32 __reserved_1    : 15;
> +	};
> +
> +	u32 word;
> +};
> +
> +#define MLXBF_EMI_DRAM_ECC_LATCH_SELECT 0x354
> +
> +union mlxbf_emi_dram_ecc_latch_select {
> +	struct {
> +		u32 dram_ecc_first : 1;
> +		u32 __reserved_0   : 15;
> +		u32 edge_sel       : 4;
> +		u32 __reserved_1   : 4;
> +		u32 start          : 1;
> +		u32 __reserved_2   : 7;
> +	};
> +
> +	u32 word;
> +};
> +
> +#define MLXBF_EMI_DRAM_ERR_ADDR_0 0x358
> +
> +#define MLXBF_EMI_DRAM_ERR_ADDR_1 0x37c
> +
> +#define MLXBF_EMI_DRAM_SYNDROM 0x35c
> +
> +union mlxbf_emi_dram_syndrom {
> +	struct {
> +		u32 derr         : 1;
> +		u32 serr         : 1;
> +		u32 __reserved_0 : 14;
> +		/* ECC syndrome (error bit according to the Hamming code). */
> +		u32 syndrom      : 10;
> +		u32 __reserved_1 : 6;
> +	};
> +
> +	u32 word;
> +};
> +
> +#define MLXBF_EMI_DRAM_ADDITIONAL_INFO_0 0x364
> +
> +union mlxbf_emi_dram_additional_info_0 {
> +	struct {
> +		u32 err_bank     : 4;
> +		u32 err_lrank    : 2;
> +		u32 __reserved_0 : 2;
> +		u32 err_prank    : 2;
> +		u32 __reserved_1 : 6;
> +		u32 err_edge     : 8;
> +		u32 __reserved_2 : 8;
> +	};
> +
> +	u32 word;
> +};
> +
> +#define MLXBF_EDAC_DIMM_PER_MC		2
> +#define MLXBF_EDAC_ERROR_GRAIN		8
> +
> +/*
> + * Request MLNX_SIP_GET_DIMM_INFO
> + *
> + * Retrieve information about DIMM on a certain slot.
> + *
> + * Call register usage:
> + * a0: MLNX_SIP_GET_DIMM_INFO
> + * a1: (Memory controller index) << 16 | (Dimm index in memory controller)
> + * a2-7: not used.
> + *
> + * Return status:
> + * a0: dimm_info_smc union defined below describing the DIMM.
> + * a1-3: not used.
> + */
> +#define MLNX_SIP_GET_DIMM_INFO		0x82000008
> +
> +/* Format for the SMC response about the memory information */
> +union dimm_info_smc {
> +	struct {
> +		unsigned long size_GB : 16;
> +		unsigned long is_rdimm : 1;
> +		unsigned long is_lrdimm : 1;
> +		unsigned long is_nvdimm : 1;
> +		unsigned long __reserved0 : 2;
> +		unsigned long ranks : 3;
> +		unsigned long package_X : 8;	/* Bits per memory package */
> +		unsigned long __reserved1 : 32;
> +	};
> +	unsigned long val;
> +};
> +
> +struct bluefield_edac_priv {
> +	int dimm_ranks[MLXBF_EDAC_DIMM_PER_MC];
> +	void __iomem *emi_base;
> +};
> +
> +static unsigned long smc_call1(unsigned long smc_op, unsigned long smc_arg)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_smc(smc_op, smc_arg, 0, 0, 0, 0, 0, 0, &res);
> +
> +	return res.a0;
> +}
> +
> +/*
> + * Gather the ECC information from the External Memory Interface registers
> + * and report it to the edac handler.
> + */
> +static void bluefield_gather_report_ecc(struct mem_ctl_info *mci,
> +					int error_cnt,
> +					int is_single_ecc)
> +{
> +	struct bluefield_edac_priv *priv = mci->pvt_info;
> +	union mlxbf_emi_dram_additional_info_0 edai0;
> +	union mlxbf_emi_dram_ecc_latch_select edels;
> +	union mlxbf_emi_dram_syndrom eds;
> +	enum hw_event_mc_err_type ecc_type;
> +	unsigned long ecc_dimm_addr;
> +	int ecc_dimm;
> +	u32 edea0;
> +	u32 edea1;
> +
> +	ecc_type = is_single_ecc ? HW_EVENT_ERR_CORRECTED :
> +				   HW_EVENT_ERR_UNCORRECTED;
> +
> +	/*
> +	 * Tell the External Memory Interface to populate the relevant
> +	 * registers with information about the last ECC error occurrence.
> +	 */
> +	edels.word = 0;
> +	edels.start = 1;
> +	writel(edels.word, priv->emi_base + MLXBF_EMI_DRAM_ECC_LATCH_SELECT);
> +
> +	/*
> +	 * Verify that the ECC reported info in the registers is of the
> +	 * same type as the one asked to report. If not, just report the
> +	 * error without the detailed information.
> +	 */
> +	eds.word = readl(priv->emi_base + MLXBF_EMI_DRAM_SYNDROM);
> +
> +	if ((is_single_ecc && !eds.serr) || (!is_single_ecc && !eds.derr)) {
> +		edac_mc_handle_error(ecc_type, mci, error_cnt, 0, 0, 0,
> +				     0, 0, -1, mci->ctl_name, "");
> +		return;
> +	}
> +
> +	edai0.word = readl(priv->emi_base + MLXBF_EMI_DRAM_ADDITIONAL_INFO_0);
> +
> +	ecc_dimm = edai0.err_prank >= 2 && priv->dimm_ranks[0] <= 2;
> +
> +	edea0 = readl(priv->emi_base + MLXBF_EMI_DRAM_ERR_ADDR_0);
> +	edea1 = readl(priv->emi_base + MLXBF_EMI_DRAM_ERR_ADDR_1);
> +
> +	ecc_dimm_addr = ((unsigned long)edea1 << 32) | edea0;
> +
> +	edac_mc_handle_error(ecc_type, mci, error_cnt,
> +			     ecc_dimm_addr / 0x1000, ecc_dimm_addr & 0xfff,
> +			     eds.syndrom, ecc_dimm, 0, 0, mci->ctl_name, "");
> +}
> +
> +static void bluefield_edac_check(struct mem_ctl_info *mci)
> +{
> +	union mlxbf_emi_dram_ecc_error edee = { .word = 0 };
> +	struct bluefield_edac_priv *priv = mci->pvt_info;
> +	union mlxbf_emi_dram_ecc_count edec;
> +
> +	/*
> +	 * The memory controller might not be initialized by the firmware
> +	 * when there isn't memory, which may lead to bad register readings.
> +	 */
> +	if (mci->edac_cap == EDAC_FLAG_NONE)
> +		return;
> +
> +	edec.word = readl(priv->emi_base + MLXBF_EMI_DRAM_ECC_COUNT);
> +
> +	if (edec.single_error_count) {
> +		edee.dram_ecc_single = 1;
> +
> +		bluefield_gather_report_ecc(mci, edec.single_error_count, 1);
> +	}
> +
> +	if (edec.double_error_count) {
> +		edee.dram_ecc_double = 1;
> +
> +		bluefield_gather_report_ecc(mci, edec.double_error_count, 0);
> +	}
> +
> +	/* Write to clear reported errors. */
> +	if (edec.word)
> +		writel(edee.word, priv->emi_base + MLXBF_EMI_DRAM_ECC_ERROR);
> +}
> +
> +/* Initialize the DIMMs information for the given memory controller. */
> +static void bluefield_edac_init_dimms(struct mem_ctl_info *mci)
> +{
> +	struct bluefield_edac_priv *priv = mci->pvt_info;
> +	int mem_ctrl_idx = mci->mc_idx;
> +	union dimm_info_smc smc_info;
> +	struct dimm_info *dimm;
> +	unsigned long smc_arg;
> +	int is_empty = 1;
> +	int i;
> +
> +	for (i = 0; i < MLXBF_EDAC_DIMM_PER_MC; i++) {
> +		dimm = mci->dimms[i];
> +
> +		smc_arg = mem_ctrl_idx << 16 | i;
> +		smc_info = (union dimm_info_smc) {
> +			.val = smc_call1(MLNX_SIP_GET_DIMM_INFO, smc_arg),
> +		};
> +
> +		if (!smc_info.size_GB) {
> +			dimm->mtype = MEM_EMPTY;
> +			continue;
> +		}
> +
> +		is_empty = 0;
> +
> +		dimm->edac_mode = EDAC_SECDED;
> +
> +		if (smc_info.is_nvdimm)
> +			dimm->mtype = MEM_NVDIMM;
> +		else if (smc_info.is_lrdimm)
> +			dimm->mtype = MEM_LRDDR4;
> +		else if (smc_info.is_rdimm)
> +			dimm->mtype = MEM_RDDR4;
> +		else
> +			dimm->mtype = MEM_DDR4;
> +
> +		dimm->nr_pages = smc_info.size_GB * 256 * 1024;
> +		dimm->grain = MLXBF_EDAC_ERROR_GRAIN;
> +
> +		/* Mem controller for BlueField only supports x4, x8 and x16 */
> +		if (smc_info.package_X == 4)
> +			dimm->dtype = DEV_X4;
> +		else if (smc_info.package_X == 8)
> +			dimm->dtype = DEV_X8;
> +		else if (smc_info.package_X == 16)
> +			dimm->dtype = DEV_X16;
> +		else
> +			dimm->dtype = DEV_UNKNOWN;
> +
> +		priv->dimm_ranks[i] = smc_info.ranks;
> +	}
> +
> +	if (is_empty)
> +		mci->edac_cap = EDAC_FLAG_NONE;
> +	else
> +		mci->edac_cap = EDAC_FLAG_SECDED;
> +}
> +
> +static int bluefield_edac_mc_probe(struct platform_device *pdev)
> +{
> +	struct bluefield_edac_priv *priv;
> +	struct device *dev = &pdev->dev;
> +	struct edac_mc_layer layers[1];
> +	struct mem_ctl_info *mci;
> +	struct resource *emi_res;
> +	unsigned int mc_idx;
> +	int rc, ret;
> +
> +	/* Read the MSS (Memory SubSystem) index from ACPI table. */
> +	if (device_property_read_u32(dev, "mss_number", &mc_idx)) {
> +		dev_warn(dev, "bf_edac: MSS number unknown\n");
> +		return -EINVAL;
> +	}
> +
> +	emi_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!emi_res)
> +		return -EINVAL;
> +
> +	layers[0].type = EDAC_MC_LAYER_SLOT;
> +	layers[0].size = MLXBF_EDAC_DIMM_PER_MC;
> +	layers[0].is_virt_csrow = true;
> +
> +	mci = edac_mc_alloc(mc_idx, ARRAY_SIZE(layers), layers, sizeof(*priv));
> +	if (!mci)
> +		return -ENOMEM;
> +
> +	priv = mci->pvt_info;
> +
> +	priv->emi_base = devm_ioremap_resource(dev, emi_res);
> +	if (IS_ERR(priv->emi_base)) {
> +		dev_err(dev, "failed to map EMI IO resource\n");
> +		ret = PTR_ERR(priv->emi_base);
> +		goto err;
> +	}
> +
> +	mci->pdev = dev;
> +	mci->mtype_cap = MEM_FLAG_DDR4 | MEM_FLAG_RDDR4 |
> +			 MEM_FLAG_LRDDR4 | MEM_FLAG_NVDIMM;
> +	mci->edac_ctl_cap = EDAC_FLAG_SECDED;
> +
> +	mci->mod_name = DRIVER_NAME;
> +	mci->ctl_name = "BlueField_Memory_Controller";
> +	mci->dev_name = dev_name(dev);
> +	mci->edac_check = bluefield_edac_check;
> +
> +	/* Initialize mci with the actual populated DIMM information. */
> +	bluefield_edac_init_dimms(mci);
> +
> +	platform_set_drvdata(pdev, mci);
> +
> +	/* Register with EDAC core */
> +	rc = edac_mc_add_mc(mci);
> +	if (rc) {
> +		dev_err(dev, "failed to register with EDAC core\n");
> +		ret = rc;
> +		goto err;
> +	}
> +
> +	/* Only POLL mode supported so far. */
> +	edac_op_state = EDAC_OPSTATE_POLL;
> +
> +	return 0;
> +
> +err:
> +	edac_mc_free(mci);
> +
> +	return ret;
> +
> +}
> +
> +static int bluefield_edac_mc_remove(struct platform_device *pdev)
> +{
> +	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
> +
> +	edac_mc_del_mc(&pdev->dev);
> +	edac_mc_free(mci);
> +
> +	return 0;
> +}
> +
> +static const struct acpi_device_id bluefield_mc_acpi_ids[] = {
> +	{"MLNXBF08", 0},
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(acpi, bluefield_mc_acpi_ids);
> +
> +static struct platform_driver bluefield_edac_mc_driver = {
> +	.driver = {
> +		.name = DRIVER_NAME,
> +		.acpi_match_table = bluefield_mc_acpi_ids,
> +	},
> +	.probe = bluefield_edac_mc_probe,
> +	.remove = bluefield_edac_mc_remove,
> +};
> +
> +module_platform_driver(bluefield_edac_mc_driver);
> +
> +MODULE_DESCRIPTION("Mellanox BlueField memory edac driver");
> +MODULE_AUTHOR("Mellanox Technologies");
> +MODULE_LICENSE("GPL v2");
> 


-- 
~Randy
