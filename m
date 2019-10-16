Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3798ECE588
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0EE820872
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388290AbfJPIsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 04:48:22 -0400
Received: from mga14.intel.com ([192.55.52.115]:6542 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388188AbfJPIsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 04:48:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2019 01:48:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,303,1566889200"; 
   d="scan'208";a="208368132"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 16 Oct 2019 01:48:20 -0700
Received: from [10.226.38.27] (unknown [10.226.38.27])
        by linux.intel.com (Postfix) with ESMTP id 791205803C5;
        Wed, 16 Oct 2019 01:48:16 -0700 (PDT)
Subject: Re: [PATCH v3 2/3] mtd: spi-nor: cadence-quadspi: Disable the DAC for
 Intel LGM SoC
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dwmw2@infradead.org, computersforpeace@gmail.com, richard@nod.at,
        jwboyer@gmail.com, boris.brezillon@free-electrons.com,
        cyrille.pitchen@atmel.com, david.oberhollenzer@sigma-star.at,
        miquel.raynal@bootlin.com, tudor.ambarus@gmail.com,
        andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com
References: <20190909104733.14273-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20190909104733.14273-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <85355c80-1344-db22-ae31-0f20f30b9754@ti.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <9b91e39e-a1ab-d99d-50b1-483d6acf5357@linux.intel.com>
Date:   Wed, 16 Oct 2019 16:48:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <85355c80-1344-db22-ae31-0f20f30b9754@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vignesh,

       Thank you for the review comments.

On 16/10/2019 4:32 PM, Vignesh Raghavendra wrote:
>
> On 09/09/19 4:17 PM, Ramuthevar,Vadivel MuruganX wrote:
>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>
>> on Intel's Lightning Mountain(LGM) SoCs QSPI controller do not use
> s/on/On
Agreed, will update.
>> Direct Access Controller(DAC).
>>
>> This patch introduces to properly disable the Direct Access Controller
> "This patch adds a quirk to disable..." or something something similar
okay, will update.
>> for data transfer instead it uses indirect data transfer.
>>
>> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>> ---
>>   drivers/mtd/spi-nor/Kconfig           |  2 +-
>>   drivers/mtd/spi-nor/cadence-quadspi.c | 21 +++++++++++++++++++++
>>   2 files changed, 22 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mtd/spi-nor/Kconfig b/drivers/mtd/spi-nor/Kconfig
>> index 6de83277ce8b..ba2e372ae514 100644
>> --- a/drivers/mtd/spi-nor/Kconfig
>> +++ b/drivers/mtd/spi-nor/Kconfig
>> @@ -34,7 +34,7 @@ config SPI_ASPEED_SMC
>>   
>>   config SPI_CADENCE_QUADSPI
>>   	tristate "Cadence Quad SPI controller"
>> -	depends on OF && (ARM || ARM64 || COMPILE_TEST)
>> +	depends on OF && (ARM || ARM64 || COMPILE_TEST || X86)
>>   	help
>>   	  Enable support for the Cadence Quad SPI Flash controller.
>>   
>> diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
>> index 67f15a1f16fd..73b9fbd1508a 100644
>> --- a/drivers/mtd/spi-nor/cadence-quadspi.c
>> +++ b/drivers/mtd/spi-nor/cadence-quadspi.c
>> @@ -33,6 +33,7 @@
>>   
>>   /* Quirks */
>>   #define CQSPI_NEEDS_WR_DELAY		BIT(0)
>> +#define CQSPI_DISABLE_DAC_MODE		BIT(1)
>>   
>>   /* Capabilities mask */
>>   #define CQSPI_BASE_HWCAPS_MASK					\
>> @@ -609,6 +610,13 @@ static int cqspi_write_setup(struct spi_nor *nor)
>>   	struct cqspi_st *cqspi = f_pdata->cqspi;
>>   	void __iomem *reg_base = cqspi->iobase;
>>   
>> +	/* Disable direct access controller */
>> +	if (!f_pdata->use_direct_mode) {
>> +		reg = readl(reg_base + CQSPI_REG_CONFIG);
>> +		reg &= ~CQSPI_REG_CONFIG_ENB_DIR_ACC_CTRL;
>> +		writel(reg, reg_base + CQSPI_REG_CONFIG);
>> +	}
>> +
>>   	/* Set opcode. */
>>   	reg = nor->program_opcode << CQSPI_REG_WR_INSTR_OPCODE_LSB;
>>   	writel(reg, reg_base + CQSPI_REG_WR_INSTR);
>> @@ -1328,6 +1336,7 @@ static int cqspi_probe(struct platform_device *pdev)
>>   	struct resource *res_ahb;
>>   	struct reset_control *rstc, *rstc_ocp;
>>   	const struct cqspi_driver_platdata *ddata;
>> +	struct cqspi_flash_pdata *f_pdata;
>>   	int ret;
>>   	int irq;
>>   
>> @@ -1436,6 +1445,9 @@ static int cqspi_probe(struct platform_device *pdev)
>>   		goto probe_setup_failed;
>>   	}
>>   
>> +	if (ddata && (ddata->quirks & CQSPI_DISABLE_DAC_MODE))
>> +		f_pdata->use_direct_mode = false;
>> +
> If you do this here, you will still end up acquiring a DMA channel in
> cqspi_request_mmap_dma() (called from cqspi_setup_flash()). So, please
> move the check to cqspi_setup_flash().

will fix it.

---
Regards
Vadivel
>>   	return ret;
>>   probe_setup_failed:
>>   	cqspi_controller_enable(cqspi, 0);
>> @@ -1510,6 +1522,11 @@ static const struct cqspi_driver_platdata am654_ospi = {
>>   	.quirks = CQSPI_NEEDS_WR_DELAY,
>>   };
>>   
>> +static const struct cqspi_driver_platdata intel_lgm_qspi = {
>> +	.hwcaps_mask = CQSPI_BASE_HWCAPS_MASK,
>> +	.quirks = CQSPI_DISABLE_DAC_MODE,
>> +};
>> +
>>   static const struct of_device_id cqspi_dt_ids[] = {
>>   	{
>>   		.compatible = "cdns,qspi-nor",
>> @@ -1523,6 +1540,10 @@ static const struct of_device_id cqspi_dt_ids[] = {
>>   		.compatible = "ti,am654-ospi",
>>   		.data = &am654_ospi,
>>   	},
>> +	{
>> +		.compatible = "intel,lgm-qspi",
>> +		.data = &intel_lgm_qspi,
>> +	},
>>   	{ /* end of table */ }
>>   };
>>   
>>
