Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFEEC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2F5622393
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gVOoZmgF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729411AbfDPNzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 09:55:04 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:51132 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfDPNzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 09:55:03 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3GDsWqn082375;
        Tue, 16 Apr 2019 08:54:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1555422872;
        bh=OVn2l1RAq0nscPf2/v8qU1e2OCiqS3+lm+yX9cKr2+U=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=gVOoZmgFSGH9B0ZtrKAYpuSJa4U1g2UMX3Ry8Gwwh8dj/pjs1q3k+7TMsKmeKBYKw
         iWzQA05QL9bo2iQFYEjKegvprxFzIxSnN9V2UfddiEa8Ugzo/i73n5LrF9XNv88PHr
         8DdyxvOZQVftDKLTcJDQd8zreeoQ2DnIPBYrBoAw=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3GDsWfP119675
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 Apr 2019 08:54:32 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 16
 Apr 2019 08:54:31 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 16 Apr 2019 08:54:31 -0500
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3GDsS6H083602;
        Tue, 16 Apr 2019 08:54:29 -0500
Subject: Re: [PATCH 1/2] mtd: spi-nor: Move m25p80 code in spi-nor.c
To:     <Tudor.Ambarus@microchip.com>, <bbrezillon@kernel.org>,
        <marek.vasut@gmail.com>, <richard@nod.at>,
        <miquel.raynal@bootlin.com>, <andrew.smirnov@gmail.com>
CC:     <frieder.schrempf@exceet.de>, <yogeshnarayan.gaur@nxp.com>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
References: <20190409162651.24593-1-vigneshr@ti.com>
 <20190409162651.24593-2-vigneshr@ti.com>
 <a81fd591-0894-727e-a99d-331f8e7d82b1@microchip.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <43552572-fea7-5b99-29eb-54121d82a429@ti.com>
Date:   Tue, 16 Apr 2019 19:25:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <a81fd591-0894-727e-a99d-331f8e7d82b1@microchip.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tudor,

On 15/04/19 1:43 PM, Tudor.Ambarus@microchip.com wrote:
> Hi,
> 
> The general approach looks good, few comments below.
> 
> On 04/09/2019 07:26 PM, Vignesh Raghavendra wrote:
>> External E-Mail
>>
>>
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
>> [vigneshr@ti.com: use devm_kmalloc() for bounce buffer allocation]
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>> ---
>> Changes from RFC:
>> * Use devm_kmalloc() for bounce buffer allocation as it supports cache
>>   line aligned buffers now
> 
> then spi-nand has to be updated too.
> 

Yes, but as a separate patch I presume.

[...]

>> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
>> index 73172d7f512b..03c8c346c9ae 100644
>> --- a/drivers/mtd/spi-nor/spi-nor.c
>> +++ b/drivers/mtd/spi-nor/spi-nor.c
>> @@ -19,6 +19,7 @@
>>  
>>  #include <linux/mtd/mtd.h>
>>  #include <linux/of_platform.h>
>> +#include <linux/sched/task_stack.h>
>>  #include <linux/spi/flash.h>
>>  #include <linux/mtd/spi-nor.h>
>>  
>> @@ -288,6 +289,174 @@ struct flash_info {
>>  
>>  #define JEDEC_MFR(info)	((info)->id[0])
>>  
>> +static int spi_nor_exec_op(struct spi_nor *nor, struct spi_mem_op *op,
>> +			   u64 *addr, void *buf, unsigned int len)
> 
> size_t for len?
> 

Right will fix throughout.
I am also thinking of updating op.data.nbytes to size_t type in
spi-mem.h (and also spi_mem_dirmap_info->length) as part of a separate
patch.

>> +{
>> +	int ret;
>> +	bool usebouncebuf;
>> +
>> +	if (!op || (len && !buf))
>> +		return -EINVAL;
>> +
>> +	if (op->addr.nbytes && addr)
>> +		op->addr.val = *addr;
>> +
>> +	op->data.nbytes = len;
>> +
>> +	if (object_is_on_stack(buf) || !virt_addr_valid(buf))
>> +		usebouncebuf = true;
>> +	if (len && usebouncebuf) {
>> +		if (len > nor->bouncebuf_size)
>> +			return -ENOTSUPP;
>> +
>> +		if (op->data.dir == SPI_MEM_DATA_IN) {
>> +			op->data.buf.in = nor->bouncebuf;
>> +		} else {
>> +			op->data.buf.out = nor->bouncebuf;
>> +			memcpy(nor->bouncebuf, buf, len);
>> +		}
>> +	} else {
>> +		op->data.buf.out = buf;
>> +	}
>> +
>> +	ret = spi_mem_exec_op(nor->spimem, op);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (usebouncebuf && len && op->data.dir == SPI_MEM_DATA_IN)
>> +		memcpy(buf, nor->bouncebuf, len);
>> +
>> +	return 0;
>> +}
>> +
>> +static int spi_nor_data_op(struct spi_nor *nor, struct spi_mem_op *op,
>> +			   void *buf, unsigned int len)
> 
> size_t for len?
> 

Ok

>> +{
>> +	return spi_nor_exec_op(nor, op, NULL, buf, len);
>> +}
>> +
>> +static int spi_nor_nodata_op(struct spi_nor *nor, struct spi_mem_op *op)
>> +{
>> +	return spi_nor_exec_op(nor, op, NULL, NULL, 0);
>> +}
>> +
>> +static ssize_t spi_nor_spimem_read_data(struct spi_nor *nor, loff_t ofs,
>> +					size_t len, u8 *buf)
>> +{
>> +	struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(nor->read_opcode, 1),
>> +					  SPI_MEM_OP_ADDR(nor->addr_width, ofs,
>> +							  1),
>> +					  SPI_MEM_OP_DUMMY(nor->read_dummy, 1),
>> +					  SPI_MEM_OP_DATA_IN(len, buf, 1));
>> +	bool usebouncebuf = false;
>> +	size_t remaining = len;
>> +	int ret;
>> +
>> +	if (object_is_on_stack(buf) || !virt_addr_valid(buf)) {
>> +		usebouncebuf = true;
>> +		op.data.buf.in = nor->bouncebuf;
>> +	}
>> +
>> +	/* get transfer protocols. */
>> +	op.cmd.buswidth = spi_nor_get_protocol_inst_nbits(nor->read_proto);
>> +	op.addr.buswidth = spi_nor_get_protocol_addr_nbits(nor->read_proto);
>> +	op.dummy.buswidth = op.addr.buswidth;
>> +	op.data.buswidth = spi_nor_get_protocol_data_nbits(nor->read_proto);
>> +
>> +	/* convert the dummy cycles to the number of bytes */
>> +	op.dummy.nbytes = (nor->read_dummy * op.dummy.buswidth) / 8;
>> +
>> +	while (remaining) {
> 
> Can't we get rid of this while? See Andrey's patch at
> https://lkml.org/lkml/2019/4/1/32. Andrey's patches are not included in this
> patch. We should consider integrating his work first, or squash his work in this
> patch, or ask him to rework the series after this patch gets accepted. I'll let
> you decide.
> 

I think its better to squash that series into this patch. Will take care
of that

>> +		op.data.nbytes = remaining < UINT_MAX ? remaining : UINT_MAX;
>> +		if (!usebouncebuf)
>> +			op.data.buf.out = buf;
>> +		else if (op.data.nbytes > nor->bouncebuf_size)
>> +			op.data.nbytes = nor->bouncebuf_size;
>> +
>> +		ret = spi_mem_adjust_op_size(nor->spimem, &op);
>> +		if (ret)
>> +			return ret;
>> +
>> +		ret = spi_mem_exec_op(nor->spimem, &op);
>> +		if (ret)
>> +			return ret;
>> +
>> +		if (usebouncebuf)
>> +			memcpy(buf, nor->bouncebuf, op.data.nbytes);
>> +
>> +		op.addr.val += op.data.nbytes;
>> +		remaining -= op.data.nbytes;
>> +		buf += op.data.nbytes;
>> +	}
>> +
>> +	return len;
>> +}
>> +
>> +static ssize_t spi_nor_read_data(struct spi_nor *nor, loff_t ofs, size_t len,
>> +				 u8 *buf)
>> +{
>> +	if (nor->spimem)
>> +		return spi_nor_spimem_read_data(nor, ofs, len, buf);
>> +
>> +	return nor->read(nor, ofs, len, buf);
>> +}
>> +
>> +static ssize_t spi_nor_spimem_write_data(struct spi_nor *nor, loff_t ofs,
>> +					 size_t len, const u8 *buf)
>> +{
>> +	struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(nor->program_opcode,
> 
> how about moving SPI_MEM_OP() to the next line to avoid breaking lines below?
> General comment.
> 

Agreed, will fix.

>> +							 1),
>> +					  SPI_MEM_OP_ADDR(nor->addr_width, ofs,
>> +							  1),
>> +					  SPI_MEM_OP_NO_DUMMY,
>> +					  SPI_MEM_OP_DATA_OUT(len, NULL, 1));
>> +	bool usebouncebuf = false;
>> +	int ret;
>> +
>> +	if (object_is_on_stack(buf) || !virt_addr_valid(buf)) {
>> +		usebouncebuf = true;
>> +		op.data.buf.out = nor->bouncebuf;
>> +	}
>> +
>> +	/* get transfer protocols. */
>> +	op.cmd.buswidth = spi_nor_get_protocol_inst_nbits(nor->write_proto);
>> +	op.addr.buswidth = spi_nor_get_protocol_addr_nbits(nor->write_proto);
>> +	op.data.buswidth = spi_nor_get_protocol_data_nbits(nor->write_proto);
>> +
>> +	if (nor->program_opcode == SPINOR_OP_AAI_WP && nor->sst_write_second)
>> +		op.addr.nbytes = 0;
>> +
>> +	op.data.nbytes = len < UINT_MAX ? len : UINT_MAX;
>> +
>> +	if (!usebouncebuf) {
>> +		op.data.buf.out = buf;
>> +	} else {
>> +		if (op.data.nbytes > nor->bouncebuf_size)
>> +			op.data.nbytes = nor->bouncebuf_size;
>> +
>> +		memcpy(nor->bouncebuf, buf, op.data.nbytes);
>> +	}
>> +
>> +	ret = spi_mem_adjust_op_size(nor->spimem, &op);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = spi_mem_exec_op(nor->spimem, &op);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return op.data.nbytes;
>> +}
>> +
[...]
>>  /* Enable/disable 4-byte addressing mode. */
>>  static int set_4byte(struct spi_nor *nor, bool enable)
>>  {
>>  	int status;
>>  	bool need_wren = false;
>> -	u8 cmd;
>>  
>>  	switch (JEDEC_MFR(nor->info)) {
>>  	case SNOR_MFR_ST:
>> @@ -486,8 +752,7 @@ static int set_4byte(struct spi_nor *nor, bool enable)
>>  		if (need_wren)
>>  			write_enable(nor);
>>  
>> -		cmd = enable ? SPINOR_OP_EN4B : SPINOR_OP_EX4B;
>> -		status = nor->write_reg(nor, cmd, NULL, 0);
>> +		status = macronix_set_4byte(nor, enable);
>>  		if (need_wren)
>>  			write_disable(nor);
>>  
>> @@ -500,8 +765,7 @@ static int set_4byte(struct spi_nor *nor, bool enable)
>>  			 * We must clear the register to enable normal behavior.
>>  			 */
>>  			write_enable(nor);
>> -			nor->cmd_buf[0] = 0;
>> -			nor->write_reg(nor, SPINOR_OP_WREAR, nor->cmd_buf, 1);
>> +			write_ear(nor, 0);
>>  			write_disable(nor);
>>  		}
>>  
>> @@ -509,16 +773,42 @@ static int set_4byte(struct spi_nor *nor, bool enable)
>>  	default:
>>  		/* Spansion style */
> 
> how about introducing a spansion_set_4byte() and return it directly?

Will do.

> 
>>  		nor->cmd_buf[0] = enable << 7;
>> +
>> +		if (nor->spimem) {
>> +			struct spi_mem_op op = SPI_MEM_OP(
>> +					SPI_MEM_OP_CMD(SPINOR_OP_BRWR, 1),
>> +					SPI_MEM_OP_NO_ADDR,
>> +					SPI_MEM_OP_NO_DUMMY,
>> +					SPI_MEM_OP_DATA_OUT(1, NULL, 1));
>> +
>> +			return spi_nor_data_op(nor, &op, nor->cmd_buf, 1);
>> +	}
>> +
>>  		return nor->write_reg(nor, SPINOR_OP_BRWR, nor->cmd_buf, 1);
>>  	}
>>  }
>>  
>> +static int xread_sr(struct spi_nor *nor, u8 *sr)
> 
> spi_nor_xread_sr?
> 

Ok

>> +{
>> +	if (nor->spimem) {
>> +		struct spi_mem_op op = SPI_MEM_OP(
>> +					SPI_MEM_OP_CMD(SPINOR_OP_XRDSR, 1),
>> +					SPI_MEM_OP_NO_ADDR,
>> +					SPI_MEM_OP_NO_DUMMY,
>> +					SPI_MEM_OP_DATA_IN(0, NULL, 1));
>> +
>> +		return spi_nor_data_op(nor, &op, sr, 1);
>> +	}
>> +
>> +	return nor->read_reg(nor, SPINOR_OP_XRDSR, sr, 1);
>> +}
>> +
>>  static int s3an_sr_ready(struct spi_nor *nor)
>>  {
>>  	int ret;
>>  	u8 val;
>>  
>> -	ret = nor->read_reg(nor, SPINOR_OP_XRDSR, &val, 1);
>> +	ret = xread_sr(nor, &val);
>>  	if (ret < 0) {
>>  		dev_err(nor->dev, "error %d reading XRDSR\n", (int) ret);
>>  		return ret;
>> @@ -527,6 +817,21 @@ static int s3an_sr_ready(struct spi_nor *nor)
>>  	return !!(val & XSR_RDY);
>>  }
>>  
>> +static int clear_sr(struct spi_nor *nor)
> 
> spi_nor_clear_sr?
> 

Ok

>> +{
>> +	if (nor->spimem) {
>> +		struct spi_mem_op op = SPI_MEM_OP(
>> +					SPI_MEM_OP_CMD(SPINOR_OP_CLSR, 1),
>> +					SPI_MEM_OP_NO_ADDR,
>> +					SPI_MEM_OP_NO_DUMMY,
>> +					SPI_MEM_OP_NO_DATA);
>> +
>> +		return spi_nor_nodata_op(nor, &op);
>> +	}
>> +
>> +	return nor->write_reg(nor, SPINOR_OP_CLSR, NULL, 0);
>> +}
>> +
>>  static int spi_nor_sr_ready(struct spi_nor *nor)
>>  {
>>  	int sr = read_sr(nor);
>> @@ -539,13 +844,28 @@ static int spi_nor_sr_ready(struct spi_nor *nor)
>>  		else
>>  			dev_err(nor->dev, "Programming Error occurred\n");
>>  
>> -		nor->write_reg(nor, SPINOR_OP_CLSR, NULL, 0);
>> +		clear_sr(nor);
>>  		return -EIO;
>>  	}
>>  
>>  	return !(sr & SR_WIP);
>>  }
>>  
>> +static int clear_fsr(struct spi_nor *nor)
> 
> spi_nor_clear_fsr?
> 

Ok

>> +{
>> +	if (nor->spimem) {
>> +		struct spi_mem_op op = SPI_MEM_OP(
>> +					SPI_MEM_OP_CMD(SPINOR_OP_CLFSR, 1),
>> +					SPI_MEM_OP_NO_ADDR,
>> +					SPI_MEM_OP_NO_DUMMY,
>> +					SPI_MEM_OP_NO_DATA);
>> +
>> +		return spi_nor_nodata_op(nor, &op);
>> +	}
>> +
>> +	return nor->write_reg(nor, SPINOR_OP_CLFSR, NULL, 0);
>> +}
>> +
>>  static int spi_nor_fsr_ready(struct spi_nor *nor)
>>  {
>>  	int fsr = read_fsr(nor);
>> @@ -562,7 +882,7 @@ static int spi_nor_fsr_ready(struct spi_nor *nor)
>>  			dev_err(nor->dev,
>>  			"Attempted to modify a protected sector.\n");
>>  
>> -		nor->write_reg(nor, SPINOR_OP_CLFSR, NULL, 0);
>> +		clear_fsr(nor);
>>  		return -EIO;
>>  	}
>>  
>> @@ -630,6 +950,16 @@ static int erase_chip(struct spi_nor *nor)
>>  {
>>  	dev_dbg(nor->dev, " %lldKiB\n", (long long)(nor->mtd.size >> 10));
>>  
>> +	if (nor->spimem) {
>> +		struct spi_mem_op op = SPI_MEM_OP(
>> +					SPI_MEM_OP_CMD(SPINOR_OP_CHIP_ERASE, 1),
>> +					SPI_MEM_OP_NO_ADDR,
>> +					SPI_MEM_OP_NO_DUMMY,
>> +					SPI_MEM_OP_NO_DATA);
>> +
>> +		return spi_nor_nodata_op(nor, &op);
>> +	}
>> +
>>  	return nor->write_reg(nor, SPINOR_OP_CHIP_ERASE, NULL, 0);
>>  }
>>  
>> @@ -692,6 +1022,17 @@ static int spi_nor_erase_sector(struct spi_nor *nor, u32 addr)
>>  	if (nor->erase)
>>  		return nor->erase(nor, addr);
>>  
>> +	if (nor->spimem) {
>> +		struct spi_mem_op op = SPI_MEM_OP(
>> +					SPI_MEM_OP_CMD(nor->erase_opcode, 1),
>> +					SPI_MEM_OP_ADDR(nor->addr_width, addr,
>> +							1),
>> +					SPI_MEM_OP_NO_DUMMY,
>> +					SPI_MEM_OP_NO_DATA);
>> +
>> +		return spi_nor_nodata_op(nor, &op);
>> +	}
>> +
>>  	/*
>>  	 * Default implementation, if driver doesn't have a specialized HW
>>  	 * control
>> @@ -1406,7 +1747,18 @@ static int write_sr_cr(struct spi_nor *nor, u8 *sr_cr)
>>  
>>  	write_enable(nor);
>>  
>> -	ret = nor->write_reg(nor, SPINOR_OP_WRSR, sr_cr, 2);
>> +	if (nor->spimem) {
>> +		struct spi_mem_op op = SPI_MEM_OP(
>> +					SPI_MEM_OP_CMD(SPINOR_OP_WRSR, 1),
>> +					SPI_MEM_OP_NO_ADDR,
>> +					SPI_MEM_OP_NO_DUMMY,
>> +					SPI_MEM_OP_DATA_OUT(0, NULL, 1));
>> +
>> +		ret = spi_nor_data_op(nor, &op, sr_cr, 2);
>> +	} else {
>> +		ret = nor->write_reg(nor, SPINOR_OP_WRSR, sr_cr, 2);
>> +	}
>> +
>>  	if (ret < 0) {
>>  		dev_err(nor->dev,
>>  			"error while writing configuration register\n");
>> @@ -1585,6 +1937,36 @@ static int spansion_read_cr_quad_enable(struct spi_nor *nor)
>>  	return 0;
>>  }
>>  
>> +static int write_sr2(struct spi_nor *nor, u8 sr2)
> 
> spi_nor_write_sr2?
> 

Ok

>> +{
>> +	if (nor->spimem) {
>> +		struct spi_mem_op op = SPI_MEM_OP(
>> +					SPI_MEM_OP_CMD(SPINOR_OP_WRSR2, 1),
>> +					SPI_MEM_OP_NO_ADDR,
>> +					SPI_MEM_OP_NO_DUMMY,
>> +					SPI_MEM_OP_DATA_OUT(0, NULL, 1));
>> +
>> +		return spi_nor_data_op(nor, &op, &sr2, 1);
>> +	}
>> +
>> +	return nor->write_reg(nor, SPINOR_OP_WRSR2, &sr2, 1);
>> +}
>> +
>> +static int read_sr2(struct spi_nor *nor, u8 *sr2)
> 
> spi_nor_read_sr2?
> 

Ok

>> +{
>> +	if (nor->spimem) {
>> +		struct spi_mem_op op = SPI_MEM_OP(
>> +					SPI_MEM_OP_CMD(SPINOR_OP_RDSR2, 1),
>> +					SPI_MEM_OP_NO_ADDR,
>> +					SPI_MEM_OP_NO_DUMMY,
>> +					SPI_MEM_OP_DATA_IN(0, NULL, 1));
>> +
>> +		return spi_nor_data_op(nor, &op, sr2, 1);
>> +	}
>> +
>> +	return nor->read_reg(nor, SPINOR_OP_RDSR2, sr2, 1);
>> +}
>> +
>>  /**
>>   * sr2_bit7_quad_enable() - set QE bit in Status Register 2.
>>   * @nor:	pointer to a 'struct spi_nor'
>> @@ -1603,7 +1985,7 @@ static int sr2_bit7_quad_enable(struct spi_nor *nor)
>>  	int ret;
>>  
>>  	/* Check current Quad Enable bit value. */
>> -	ret = nor->read_reg(nor, SPINOR_OP_RDSR2, &sr2, 1);
>> +	ret = read_sr2(nor, &sr2);
>>  	if (ret)
>>  		return ret;
>>  	if (sr2 & SR2_QUAD_EN_BIT7)
>> @@ -1614,7 +1996,7 @@ static int sr2_bit7_quad_enable(struct spi_nor *nor)
>>  
>>  	write_enable(nor);
>>  
>> -	ret = nor->write_reg(nor, SPINOR_OP_WRSR2, &sr2, 1);
>> +	ret = write_sr2(nor, sr2);
>>  	if (ret < 0) {
>>  		dev_err(nor->dev, "error while writing status register 2\n");
>>  		return -EINVAL;
>> @@ -1626,8 +2008,7 @@ static int sr2_bit7_quad_enable(struct spi_nor *nor)
>>  		return ret;
>>  	}
>>  
>> -	/* Read back and check it. */
>> -	ret = nor->read_reg(nor, SPINOR_OP_RDSR2, &sr2, 1);
>> +	ret = read_sr2(nor, &sr2);
>>  	if (!(ret > 0 && (sr2 & SR2_QUAD_EN_BIT7))) {
>>  		dev_err(nor->dev, "SR2 Quad bit not set\n");
>>  		return -EINVAL;
>> @@ -2054,13 +2435,28 @@ static const struct flash_info spi_nor_ids[] = {
>>  	{ },
>>  };
>>  
>> +static int read_id(struct spi_nor *nor, u8 *id)
> 
> this function is called just from spi_nor_read_id(). How about incorporating
> this code into spi_nor_read_id() so that we use functions that are prepended
> with "spi_nor" to not pollute the namespace?

I agree, but inlining this code would break 80 char limit due to extra
indentation required for nor->read_reg() call below.

So how about renaming this function to spi_nor_read_id() and current
spi_nor_read_id() function to spi_nor_get_flash_info()?

>> +{
>> +	if (nor->spimem) {
>> +		struct spi_mem_op op = SPI_MEM_OP(
>> +					SPI_MEM_OP_CMD(SPINOR_OP_RDID, 1),
>> +					SPI_MEM_OP_NO_ADDR,
>> +					SPI_MEM_OP_NO_DUMMY,
>> +					SPI_MEM_OP_DATA_IN(0, NULL, 1));
>> +
>> +		return spi_nor_data_op(nor, &op, id, SPI_NOR_MAX_ID_LEN);
>> +	}
>> +
>> +	return nor->read_reg(nor, SPINOR_OP_RDID, id, SPI_NOR_MAX_ID_LEN);
>> +}
>> +
>>  static const struct flash_info *spi_nor_read_id(struct spi_nor *nor)
>>  {
>>  	int			tmp;
>>  	u8			id[SPI_NOR_MAX_ID_LEN];
>>  	const struct flash_info	*info;
>>  
>> -	tmp = nor->read_reg(nor, SPINOR_OP_RDID, id, SPI_NOR_MAX_ID_LEN);
>> +	tmp = read_id(nor, id);
>>  	if (tmp < 0) {
>>  		dev_dbg(nor->dev, "error %d reading JEDEC ID\n", tmp);
>>  		return ERR_PTR(tmp);
>> @@ -2096,7 +2492,7 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
>>  		if (nor->flags & SNOR_F_S3AN_ADDR_DEFAULT)
>>  			addr = spi_nor_s3an_addr_convert(nor, addr);
>>  
>> -		ret = nor->read(nor, addr, len, buf);
>> +		ret = spi_nor_read_data(nor, addr, len, buf);
>>  		if (ret == 0) {
>>  			/* We shouldn't see 0-length reads */
>>  			ret = -EIO;
>> @@ -2141,7 +2537,7 @@ static int sst_write(struct mtd_info *mtd, loff_t to, size_t len,
>>  		nor->program_opcode = SPINOR_OP_BP;
>>  
>>  		/* write one byte. */
>> -		ret = nor->write(nor, to, 1, buf);
>> +		ret = spi_nor_write_data(nor, to, 1, buf);
>>  		if (ret < 0)
>>  			goto sst_write_err;
>>  		WARN(ret != 1, "While writing 1 byte written %i bytes\n",
>> @@ -2157,7 +2553,7 @@ static int sst_write(struct mtd_info *mtd, loff_t to, size_t len,
>>  		nor->program_opcode = SPINOR_OP_AAI_WP;
>>  
>>  		/* write two bytes. */
>> -		ret = nor->write(nor, to, 2, buf + actual);
>> +		ret = spi_nor_write_data(nor, to, 2, buf + actual);
>>  		if (ret < 0)
>>  			goto sst_write_err;
>>  		WARN(ret != 2, "While writing 2 bytes written %i bytes\n",
>> @@ -2180,7 +2576,7 @@ static int sst_write(struct mtd_info *mtd, loff_t to, size_t len,
>>  		write_enable(nor);
>>  
>>  		nor->program_opcode = SPINOR_OP_BP;
>> -		ret = nor->write(nor, to, 1, buf + actual);
>> +		ret = spi_nor_write_data(nor, to, 1, buf + actual);
>>  		if (ret < 0)
>>  			goto sst_write_err;
>>  		WARN(ret != 1, "While writing 1 byte written %i bytes\n",
>> @@ -2242,7 +2638,7 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
>>  			addr = spi_nor_s3an_addr_convert(nor, addr);
>>  
>>  		write_enable(nor);
>> -		ret = nor->write(nor, addr, page_remain, buf + i);
>> +		ret = spi_nor_write_data(nor, addr, page_remain, buf + i);
>>  		if (ret < 0)
>>  			goto write_err;
>>  		written = ret;
>> @@ -2261,8 +2657,10 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
>>  
>>  static int spi_nor_check(struct spi_nor *nor)
>>  {
>> -	if (!nor->dev || !nor->read || !nor->write ||
>> -		!nor->read_reg || !nor->write_reg) {
>> +	if (!nor->dev ||
>> +	    (!nor->spimem &&
>> +	    (!nor->read || !nor->write || !nor->read_reg ||
>> +	      !nor->write_reg))) {
>>  		pr_err("spi-nor: please fill all the necessary fields!\n");
>>  		return -EINVAL;
>>  	}
>> @@ -2275,7 +2673,7 @@ static int s3an_nor_scan(struct spi_nor *nor)
>>  	int ret;
>>  	u8 val;
>>  
>> -	ret = nor->read_reg(nor, SPINOR_OP_XRDSR, &val, 1);
>> +	ret = xread_sr(nor, &val);
>>  	if (ret < 0) {
>>  		dev_err(nor->dev, "error %d reading XRDSR\n", (int) ret);
>>  		return ret;
>> @@ -2405,7 +2803,7 @@ static int spi_nor_read_raw(struct spi_nor *nor, u32 addr, size_t len, u8 *buf)
>>  	int ret;
>>  
>>  	while (len) {
>> -		ret = nor->read(nor, addr, len, buf);
>> +		ret = spi_nor_read_data(nor, addr, len, buf);
>>  		if (!ret || ret > len)
>>  			return -EIO;
>>  		if (ret < 0)
>> @@ -4188,6 +4586,215 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
>>  }
>>  EXPORT_SYMBOL_GPL(spi_nor_scan);
>>  
>> +static int spi_nor_probe(struct spi_mem *spimem)
>> +{
>> +	struct spi_device *spi = spimem->spi;
>> +	struct flash_platform_data *data;
>> +	struct spi_nor *nor;
>> +	struct spi_nor_hwcaps hwcaps = {
>> +		.mask = SNOR_HWCAPS_READ |
>> +			SNOR_HWCAPS_READ_FAST |
>> +			SNOR_HWCAPS_PP,
>> +	};
>> +	char *flash_name;
>> +	int ret;
>> +
>> +	data = dev_get_platdata(&spi->dev);
> 
> you can do the initialization at declaration
> 
will update..

>> +
>> +	nor = devm_kzalloc(&spi->dev, sizeof(*nor), GFP_KERNEL);
>> +	if (!nor)
>> +		return -ENOMEM;
>> +
>> +	/*
>> +	 * We need the bounce buffer early to read/write registers when going
>> +	 * through the spi-mem layer (buffers have to be DMA-able).
>> +	 * We'll reallocate a new buffer if nor->page_size turns out to be
>> +	 * greater than PAGE_SIZE (which shouldn't happen before long since NOR
>> +	 * pages are usually less than 1KB) after spi_nor_scan() returns.
>> +	 */
>> +	nor->bouncebuf_size = PAGE_SIZE;
>> +	nor->bouncebuf = devm_kmalloc(&spi->dev, nor->bouncebuf_size,
>> +				      GFP_KERNEL);
>> +	if (!nor->bouncebuf)
>> +		return -ENOMEM;
>> +
>> +	nor->spimem = spimem;
>> +	nor->dev = &spi->dev;
>> +	spi_nor_set_flash_node(nor, spi->dev.of_node);
>> +
>> +	spi_mem_set_drvdata(spimem, nor);
>> +
>> +	if (spi->mode & SPI_RX_OCTAL) {
>> +		hwcaps.mask |= SNOR_HWCAPS_READ_1_1_8;
>> +
>> +		if (spi->mode & SPI_TX_OCTAL)
>> +			hwcaps.mask |= (SNOR_HWCAPS_READ_1_8_8 |
>> +					SNOR_HWCAPS_PP_1_1_8 |
>> +					SNOR_HWCAPS_PP_1_8_8);
>> +	} else if (spi->mode & SPI_RX_QUAD) {
>> +		hwcaps.mask |= SNOR_HWCAPS_READ_1_1_4;
>> +
>> +		if (spi->mode & SPI_TX_QUAD)
>> +			hwcaps.mask |= (SNOR_HWCAPS_READ_1_4_4 |
>> +					SNOR_HWCAPS_PP_1_1_4 |
>> +					SNOR_HWCAPS_PP_1_4_4);
>> +	} else if (spi->mode & SPI_RX_DUAL) {
>> +		hwcaps.mask |= SNOR_HWCAPS_READ_1_1_2;
>> +
>> +		if (spi->mode & SPI_TX_DUAL)
>> +			hwcaps.mask |= SNOR_HWCAPS_READ_1_2_2;
>> +	}
>> +
>> +	if (data && data->name)
>> +		nor->mtd.name = data->name;
>> +
>> +	if (!nor->mtd.name)
>> +		nor->mtd.name = spi_mem_get_name(spimem);
>> +
>> +	/*
>> +	 * For some (historical?) reason many platforms provide two different
>> +	 * names in flash_platform_data: "name" and "type". Quite often name is
>> +	 * set to "m25p80" and then "type" provides a real chip name.
>> +	 * If that's the case, respect "type" and ignore a "name".
>> +	 */
>> +	if (data && data->type)
>> +		flash_name = data->type;
>> +	else if (!strcmp(spi->modalias, "spi-nor"))
>> +		flash_name = NULL; /* auto-detect */
>> +	else
>> +		flash_name = spi->modalias;
>> +
>> +	ret = spi_nor_scan(nor, flash_name, &hwcaps);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/*
>> +	 * None of the existing parts have > 512B pages, but let's play safe
>> +	 * and add this logic so that if anyone ever adds support for such
>> +	 * a NOR we don't end up with buffer overflows.
>> +	 */
>> +	if (nor->page_size > PAGE_SIZE) {
>> +		nor->bouncebuf_size = nor->page_size;
>> +		devm_kfree(nor->dev, nor->bouncebuf);
>> +		nor->bouncebuf = devm_kmalloc(nor->dev,
>> +					      nor->bouncebuf_size,
>> +					      GFP_KERNEL);
>> +		if (!nor->bouncebuf)
>> +			return -ENOMEM;
>> +	}
>> +
>> +	return mtd_device_register(&nor->mtd, data ? data->parts : NULL,
>> +				   data ? data->nr_parts : 0);
>> +}
>> +
>> +static int spi_nor_remove(struct spi_mem *spimem)
>> +{
>> +	struct spi_nor *nor = spi_mem_get_drvdata(spimem);
>> +	int ret;
>> +
>> +	spi_nor_restore(nor);
>> +
>> +	/* Clean up MTD stuff. */
>> +	ret = mtd_device_unregister(&nor->mtd);
>> +	if (ret)
>> +		return ret;> +
>> +	return 0;
> 
> return mtd_device_unregister(&nor->mtd); directly

Ok

> 
>> +}
>> +
>> +static void spi_nor_shutdown(struct spi_mem *spimem)
>> +{
>> +	struct spi_nor *nor = spi_mem_get_drvdata(spimem);
>> +
>> +	spi_nor_restore(nor);
>> +}
>> +
>> +/*
>> + * Do NOT add to this array without reading the following:
>> + *
>> + * Historically, many flash devices are bound to this driver by their name. But
>> + * since most of these flash are compatible to some extent, and their
>> + * differences can often be differentiated by the JEDEC read-ID command, we
>> + * encourage new users to add support to the spi-nor library, and simply bind
>> + * against a generic string here (e.g., "jedec,spi-nor").
>> + *
>> + * Many flash names are kept here in this list (as well as in spi-nor.c) to
>> + * keep them available as module aliases for existing platforms.
>> + */
>> +static const struct spi_device_id spi_nor_dev_ids[] = {
>> +	/*
>> +	 * Allow non-DT platform devices to bind to the "spi-nor" modalias, and
>> +	 * hack around the fact that the SPI core does not provide uevent
>> +	 * matching for .of_match_table
>> +	 */
>> +	{"spi-nor"},
>> +
>> +	/*
>> +	 * Entries not used in DTs that should be safe to drop after replacing
>> +	 * them with "spi-nor" in platform data.
>> +	 */
>> +	{"s25sl064a"},	{"w25x16"},	{"m25p10"},	{"m25px64"},
>> +
>> +	/*
>> +	 * Entries that were used in DTs without "jedec,spi-nor" fallback and
>> +	 * should be kept for backward compatibility.
>> +	 */
>> +	{"at25df321a"},	{"at25df641"},	{"at26df081a"},
>> +	{"mx25l4005a"},	{"mx25l1606e"},	{"mx25l6405d"},	{"mx25l12805d"},
>> +	{"mx25l25635e"},{"mx66l51235l"},
>> +	{"n25q064"},	{"n25q128a11"},	{"n25q128a13"},	{"n25q512a"},
>> +	{"s25fl256s1"},	{"s25fl512s"},	{"s25sl12801"},	{"s25fl008k"},
>> +	{"s25fl064k"},
>> +	{"sst25vf040b"},{"sst25vf016b"},{"sst25vf032b"},{"sst25wf040"},
>> +	{"m25p40"},	{"m25p80"},	{"m25p16"},	{"m25p32"},
>> +	{"m25p64"},	{"m25p128"},
>> +	{"w25x80"},	{"w25x32"},	{"w25q32"},	{"w25q32dw"},
>> +	{"w25q80bl"},	{"w25q128"},	{"w25q256"},
>> +
>> +	/* Flashes that can't be detected using JEDEC */
>> +	{"m25p05-nonjedec"},	{"m25p10-nonjedec"},	{"m25p20-nonjedec"},
>> +	{"m25p40-nonjedec"},	{"m25p80-nonjedec"},	{"m25p16-nonjedec"},
>> +	{"m25p32-nonjedec"},	{"m25p64-nonjedec"},	{"m25p128-nonjedec"},
>> +
>> +	/* Everspin MRAMs (non-JEDEC) */
>> +	{ "mr25h128" }, /* 128 Kib, 40 MHz */
>> +	{ "mr25h256" }, /* 256 Kib, 40 MHz */
>> +	{ "mr25h10" },  /*   1 Mib, 40 MHz */
>> +	{ "mr25h40" },  /*   4 Mib, 40 MHz */
>> +
>> +	{ },
>> +};
>> +MODULE_DEVICE_TABLE(spi, spi_nor_dev_ids);
>> +
>> +static const struct of_device_id spi_nor_of_table[] = {
>> +	/*
>> +	 * Generic compatibility for SPI NOR that can be identified by the
>> +	 * JEDEC READ ID opcode (0x9F). Use this, if possible.
>> +	 */
>> +	{ .compatible = "jedec,spi-nor" },
>> +	{ /* sentinel */ },
>> +};
>> +MODULE_DEVICE_TABLE(of, spi_nor_of_table);
>> +
>> +/*
>> + * REVISIT: many of these chips have deep power-down modes, which
>> + * should clearly be entered on suspend() to minimize power use.
>> + * And also when they're otherwise idle...
>> + */
>> +static struct spi_mem_driver spi_nor_driver = {
>> +	.spidrv = {
>> +		.driver = {
>> +			.name = "spi-nor",
>> +			.of_match_table = spi_nor_of_table,
>> +		},
>> +		.id_table = spi_nor_dev_ids,
>> +	},
>> +	.probe = spi_nor_probe,
>> +	.remove = spi_nor_remove,
>> +	.shutdown = spi_nor_shutdown,
>> +};
>> +module_spi_mem_driver(spi_nor_driver);
>> +
>>  MODULE_LICENSE("GPL v2");
>>  MODULE_AUTHOR("Huang Shijie <shijie8@gmail.com>");
>>  MODULE_AUTHOR("Mike Lavender");
>> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
>> index b3d360b0ee3d..ac16745f5ef8 100644
>> --- a/include/linux/mtd/spi-nor.h
>> +++ b/include/linux/mtd/spi-nor.h
>> @@ -9,6 +9,7 @@
>>  #include <linux/bitops.h>
>>  #include <linux/mtd/cfi.h>
>>  #include <linux/mtd/mtd.h>
>> +#include <linux/spi/spi-mem.h>
>>  
>>  /*
>>   * Manufacturer IDs
>> @@ -344,6 +345,10 @@ struct flash_info;
>>   * @mtd:		point to a mtd_info structure
>>   * @lock:		the lock for the read/write/erase/lock/unlock operations
>>   * @dev:		point to a spi device, or a spi nor controller device.
>> + * @spimem:		point to the spi mem device
>> + * @bouncebuf:		bounce buffer used when the buffer passed by the MTD
>> + *                      layer is not DMA-able
>> + * @bouncebuf_size:	size of the bounce buffe
>                                            ^buffer
> 
>>   * @info:		spi-nor part JDEC MFR id and other info
>>   * @page_size:		the page size of the SPI NOR
>>   * @addr_width:		number of address bytes
>> @@ -380,6 +385,9 @@ struct spi_nor {
>>  	struct mtd_info		mtd;
>>  	struct mutex		lock;
>>  	struct device		*dev;
>> +	struct spi_mem		*spimem;
>> +	void			*bouncebuf;
>> +	unsigned int		bouncebuf_size;
> 
> size_t?
> 
> Please run checkpatch --strict over the patch, there are few things to fix.
> 

I will address all except for the ones reported for spi_nor_dev_ids[] as
they existed before so that alignment looks good.

> Do you think it is worth documenting the new functions?
> 

Will add at places where functions are not trivial.

Thanks for the review!


-- 
Regards
Vignesh
