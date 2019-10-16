Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9C9C4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6294D20872
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391460AbfJPIxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 04:53:25 -0400
Received: from mga02.intel.com ([134.134.136.20]:5536 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726640AbfJPIxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 04:53:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2019 01:53:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,303,1566889200"; 
   d="scan'208";a="202015647"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Oct 2019 01:53:22 -0700
Received: from [10.226.38.27] (unknown [10.226.38.27])
        by linux.intel.com (Postfix) with ESMTP id 8C3135803C5;
        Wed, 16 Oct 2019 01:53:18 -0700 (PDT)
Subject: Re: [PATCH v3 3/3] mtd: spi-nor: cadence-quadspi: disable the
 auto-poll for Intel LGM
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
 <20190909104733.14273-4-vadivel.muruganx.ramuthevar@linux.intel.com>
 <a4d45efe-907f-6c87-c650-5ad19942f0e4@ti.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <888a5cfa-7ded-938a-cdd6-cc11068117e4@linux.intel.com>
Date:   Wed, 16 Oct 2019 16:53:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <a4d45efe-907f-6c87-c650-5ad19942f0e4@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vignesh,

      Thank you for the review comments.

On 16/10/2019 4:40 PM, Vignesh Raghavendra wrote:
>
> On 09/09/19 4:17 PM, Ramuthevar,Vadivel MuruganX wrote:
>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>
>> On Intel's Lightning Mountain(LGM) SoC QSPI controller do not auto-poll.
>> This patch introduces to properly disable the auto-polling feature to
> This patch disables auto polling when direct access mode is disabled
> which should be noted in the commit message.
will add it.
>> improve the performance of cadence-quadspi.
> How does this improve performance of cadence-quadspi? I would expect HW
> auto-polling to be faster than SW polling.
During the bring-up time observed this, once again verify it on my setup.
Agreed, you are correct HW auto-polling is faster than SW polling.
>> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>> ---
>>   drivers/mtd/spi-nor/cadence-quadspi.c | 24 ++++++++++++++++++++++++
>>   1 file changed, 24 insertions(+)
>>
>> diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
>> index 73b9fbd1508a..60998eaad1cc 100644
>> --- a/drivers/mtd/spi-nor/cadence-quadspi.c
>> +++ b/drivers/mtd/spi-nor/cadence-quadspi.c
>> @@ -135,6 +135,8 @@ struct cqspi_driver_platdata {
>>   #define CQSPI_REG_RD_INSTR_TYPE_DATA_MASK	0x3
>>   #define CQSPI_REG_RD_INSTR_DUMMY_MASK		0x1F
>>   
>> +#define CQSPI_REG_WR_COMPLETION_CTRL		0x38
>> +#define CQSPI_REG_WR_COMPLETION_DISABLE_AUTO_POLL	BIT(14)
>>   #define CQSPI_REG_WR_INSTR			0x08
>>   #define CQSPI_REG_WR_INSTR_OPCODE_LSB		0
>>   #define CQSPI_REG_WR_INSTR_TYPE_ADDR_LSB	12
>> @@ -471,6 +473,18 @@ static int cqspi_command_write_addr(struct spi_nor *nor,
>>   	return cqspi_exec_flash_cmd(cqspi, reg);
>>   }
>>   
>> +static int cqspi_disable_auto_poll(struct cqspi_st *cqspi)
>> +{
>> +	void __iomem *reg_base = cqspi->iobase;
>> +	unsigned int reg;
>> +
>> +	reg = readl(reg_base + CQSPI_REG_WR_COMPLETION_CTRL);
>> +	reg |= CQSPI_REG_WR_COMPLETION_DISABLE_AUTO_POLL;
>> +	writel(reg, reg_base + CQSPI_REG_WR_COMPLETION_CTRL);
>> +
>> +	return 0;
>> +}
>> +
>>   static int cqspi_read_setup(struct spi_nor *nor)
>>   {
>>   	struct cqspi_flash_pdata *f_pdata = nor->priv;
>> @@ -508,6 +522,11 @@ static int cqspi_read_setup(struct spi_nor *nor)
>>   	reg &= ~CQSPI_REG_SIZE_ADDRESS_MASK;
>>   	reg |= (nor->addr_width - 1);
>>   	writel(reg, reg_base + CQSPI_REG_SIZE);
>> +
>> +	/* Disable auto-polling */
>> +	if (!f_pdata->use_direct_mode)
>> +		cqspi_disable_auto_poll(cqspi);
>> +
>>   	return 0;
>>   }
>>   
> Hmmm.. There is no need to disable polling for every read/write
> operation. It should be enough to do it once in cqspi_controller_init()
sure, move to cqspi_controller_init() .
---
Regards
Vadivel
>
>
>> @@ -627,6 +646,11 @@ static int cqspi_write_setup(struct spi_nor *nor)
>>   	reg &= ~CQSPI_REG_SIZE_ADDRESS_MASK;
>>   	reg |= (nor->addr_width - 1);
>>   	writel(reg, reg_base + CQSPI_REG_SIZE);
>> +
>> +	/* Disable auto-polling */
>> +	if (!f_pdata->use_direct_mode)
>> +		cqspi_disable_auto_poll(cqspi);
>> +
>>   	return 0;
>>   }
>>   
>>
