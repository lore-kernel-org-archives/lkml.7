Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC369C32754
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 06:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D3D3206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 06:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LHrBPEQz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730213AbfHAGqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 02:46:11 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:53634 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfHAGqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 02:46:11 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x716jkhw016651;
        Thu, 1 Aug 2019 01:45:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1564641947;
        bh=8TKbs94HSZ1JGcGrZEMzUr93I/PwTVTscVdXayg7r1A=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=LHrBPEQzzIGrbXU/BiEmrkH1RjpEUvJk6k7cLqJGY2vgs2Kt6mv6F2+ZuSNEdg7vO
         lQUkx74KWBnlNJgI+Yp0oRaWZpWMStEX7V5GeGZMBHOmgluDnUIrMxb3hvfFpo493S
         E9NOua5vEvQdTMZfXJjX5MgyXeFPflWzzJkkDfAI=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x716jkk4047146
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Aug 2019 01:45:46 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 1 Aug
 2019 01:45:46 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 1 Aug 2019 01:45:46 -0500
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x716jhco016047;
        Thu, 1 Aug 2019 01:45:44 -0500
Subject: Re: [PATCH v3 2/3] mtd: spi-nor: Move m25p80 code in spi-nor.c
To:     Boris Brezillon <boris.brezillon@collabora.com>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
References: <20190801043052.30192-1-vigneshr@ti.com>
 <20190801043052.30192-3-vigneshr@ti.com>
 <20190801075205.3336693b@collabora.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <2b3ff784-01dc-ce18-2e3c-183f9bee1d09@ti.com>
Date:   Thu, 1 Aug 2019 12:16:20 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190801075205.3336693b@collabora.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/08/19 11:22 AM, Boris Brezillon wrote:
> On Thu, 1 Aug 2019 10:00:51 +0530
> Vignesh Raghavendra <vigneshr@ti.com> wrote:
> 
>> From: Boris Brezillon <boris.brezillon@bootlin.com>
>>
>> The m25p80 driver is actually a generic wrapper around the spi-mem
>> layer. Not only the driver name is misleading, but we'd expect such a
>> common logic to be directly available in the core. Another reason for
>> moving this code is that SPI NOR controller drivers should
>> progressively be replaced by SPI controller drivers implementing the
>> spi_mem_ops interface, and when the conversion is done, we should have
>> a single spi-nor driver directly interfacing with the spi-mem layer.
>>
>> While moving the code we also fix a longstanding issue when
>> non-DMA-able buffers are passed by the MTD layer.
>>
>> Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>> ---
>> v3:
>> Simplify register read/write by dropping spi_nor_exec_op() and using
>> spi_mem_exec_op() directly
>> Modify spi_nor_spimem_xfer_data() to drop "enum spi_nor_protocol proto"
>> Fix misc coding style comments by Tudor
>>
>> v2:
>> Add docs for new functions added
>> Add spi_nor_ prefix to new functions
>> Incorporate Andrey's patches https://lkml.org/lkml/2019/4/1/32
>> to avoid looping spi_nor_spimem_* APIs
>>
>>  drivers/mtd/devices/Kconfig   |  18 -
>>  drivers/mtd/devices/Makefile  |   1 -
>>  drivers/mtd/devices/m25p80.c  | 347 -------------------
>>  drivers/mtd/spi-nor/Kconfig   |   2 +
>>  drivers/mtd/spi-nor/spi-nor.c | 632 ++++++++++++++++++++++++++++++++--
>>  include/linux/mtd/spi-nor.h   |   3 +
>>  6 files changed, 604 insertions(+), 399 deletions(-)
>>  delete mode 100644 drivers/mtd/devices/m25p80.c
>>
> 
> [...]
> 
> 
>> @@ -348,6 +530,16 @@ static int read_cr(struct spi_nor *nor)
>>   */
>>  static int write_sr(struct spi_nor *nor, u8 val)
>>  {
>> +	if (nor->spimem) {
>> +		struct spi_mem_op op =
>> +			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRSR, 1),
>> +				   SPI_MEM_OP_NO_ADDR,
>> +				   SPI_MEM_OP_NO_DUMMY,
>> +				   SPI_MEM_OP_DATA_IN(1, nor->bouncebuf, 1));
>> +
>> +		return spi_mem_exec_op(nor->spimem, &op);
>> +	}
>> +
>>  	nor->bouncebuf[0] = val;
> 
> The above line should be moved at the beginning of the function if you
> want the spimem path to work correctly.


Good catch! will send v4 with this fixed


-- 
Regards
Vignesh
