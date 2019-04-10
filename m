Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE03C10F0E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 03:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77F3B206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 03:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfDJDdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 23:33:31 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6140 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726670AbfDJDdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 23:33:31 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 07A99D2133A587EEC025;
        Wed, 10 Apr 2019 11:33:29 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.408.0; Wed, 10 Apr 2019
 11:33:24 +0800
Subject: Re: [PATCH] spi: spi-mem: Fix build error without CONFIG_SPI_MEM
To:     Vignesh Raghavendra <vigneshr@ti.com>, <broonie@kernel.org>,
        <naga.sureshkumar.relli@xilinx.com>
References: <20190408143949.10688-1-yuehaibing@huawei.com>
 <4c9cb550-e0b6-8f66-979d-ab8237e28166@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <f377a323-c490-1185-e471-d5292ab59291@huawei.com>
Date:   Wed, 10 Apr 2019 11:33:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <4c9cb550-e0b6-8f66-979d-ab8237e28166@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/4/10 0:30, Vignesh Raghavendra wrote:
> On 08/04/19 8:09 PM, Yue Haibing wrote:
>> From: YueHaibing <yuehaibing@huawei.com>
>>
>> When building with CONFIG_SPI_MEM is not set
>> gc warns this:
>>
>> drivers/spi/spi-zynq-qspi.o: In function `zynq_qspi_supports_op':
>> spi-zynq-qspi.c:(.text+0x1da): undefined reference to `spi_mem_default_supports_op'
>>
>> Fixes: 67dca5e580f1 ("spi: spi-mem: Add support for Zynq QSPI controller")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  include/linux/spi/spi-mem.h | 14 +++++++++++---
>>  1 file changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
>> index c845cd6..1941b84 100644
>> --- a/include/linux/spi/spi-mem.h
>> +++ b/include/linux/spi/spi-mem.h
>> @@ -295,6 +295,10 @@ int spi_controller_dma_map_mem_op_data(struct spi_controller *ctlr,
>>  void spi_controller_dma_unmap_mem_op_data(struct spi_controller *ctlr,
>>  					  const struct spi_mem_op *op,
>>  					  struct sg_table *sg);
>> +
>> +bool spi_mem_default_supports_op(struct spi_mem *mem,
>> +				 const struct spi_mem_op *op);
>> +
>>  #else
>>  static inline int
>>  spi_controller_dma_map_mem_op_data(struct spi_controller *ctlr,
>> @@ -310,6 +314,13 @@ spi_controller_dma_unmap_mem_op_data(struct spi_controller *ctlr,
>>  				     struct sg_table *sg)
>>  {
>>  }
>> +
>> +bool spi_mem_default_supports_op(struct spi_mem *mem,
>> +				 const struct spi_mem_op *op)
> 
> This needs to be declared static inline to avoid multiple definitions.
> Right?

Indeed, thanks!

> 
>> +{
>> +	return false;
>> +}
>> +
>>  #endif /* CONFIG_SPI_MEM */
>>  
>>  int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op);
>> @@ -341,9 +352,6 @@ int spi_mem_driver_register_with_owner(struct spi_mem_driver *drv,
>>  
>>  void spi_mem_driver_unregister(struct spi_mem_driver *drv);
>>  
>> -bool spi_mem_default_supports_op(struct spi_mem *mem,
>> -				 const struct spi_mem_op *op);
>> -
>>  #define spi_mem_driver_register(__drv)                                  \
>>  	spi_mem_driver_register_with_owner(__drv, THIS_MODULE)
>>  
>>
> 

