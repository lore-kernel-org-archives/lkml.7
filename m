Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEA9C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 11:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1328B20856
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 11:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="zKqroS2p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbfHELKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 07:10:02 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54962 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfHELKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 07:10:01 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x75B9ha0087336;
        Mon, 5 Aug 2019 06:09:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1565003384;
        bh=phcC27d39oZnXcLzFdJxH6ZDHLmxx0V6skoP0iFbOJg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=zKqroS2pKrjvvvCSJ6M4rgBW8O8g9e878yOC9rwcDgZVxWBSX6YbQ+50wPcZ88BMd
         x8N6S3l/lQGjAyio/q+nz5A15qHHciPqxAD6LLLchBlotdi82pcStxi7TgcoTTEkVF
         ecd+GRLFlTp4QqaSdpmd0aEynXJKw0jT8/E0BO8c=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x75B9ha8085119
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 5 Aug 2019 06:09:43 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 5 Aug
 2019 06:09:43 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 5 Aug 2019 06:09:43 -0500
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x75B9eMd079870;
        Mon, 5 Aug 2019 06:09:41 -0500
Subject: Re: [PATCH v4 2/3] mtd: spi-nor: Move m25p80 code in spi-nor.c
To:     <Tudor.Ambarus@microchip.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>
CC:     <marek.vasut@gmail.com>, <bbrezillon@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <tmaimon77@gmail.com>
References: <20190801162229.28897-1-vigneshr@ti.com>
 <20190801162229.28897-3-vigneshr@ti.com>
 <852ffdd1-a546-03db-3b60-47d60bd8d7cf@microchip.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <c4aa9ee0-9deb-9432-5ae6-0c807092ef35@ti.com>
Date:   Mon, 5 Aug 2019 16:40:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <852ffdd1-a546-03db-3b60-47d60bd8d7cf@microchip.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/08/19 3:55 PM, Tudor.Ambarus@microchip.com wrote:
> 
> 
> On 08/01/2019 07:22 PM, Vignesh Raghavendra wrote:
> 
>> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
>> index e02376e1127b..866962c715b4 100644
>> --- a/drivers/mtd/spi-nor/spi-nor.c
>> +++ b/drivers/mtd/spi-nor/spi-nor.c
>> @@ -19,6 +19,7 @@
> 
> cut
> 
>> +static ssize_t spi_nor_spimem_read_data(struct spi_nor *nor, loff_t from,
>> +					size_t len, u8 *buf)
>> +{
>> +	struct spi_mem_op op =
>> +		SPI_MEM_OP(SPI_MEM_OP_CMD(nor->read_opcode, 1),
>> +			   SPI_MEM_OP_ADDR(nor->addr_width, from, 1),
>> +			   SPI_MEM_OP_DUMMY(nor->read_dummy, 1),
>> +			   SPI_MEM_OP_DATA_IN(len, buf, 1));
>> +
>> +	/* get transfer protocols. */
>> +	op.cmd.buswidth = spi_nor_get_protocol_inst_nbits(nor->read_proto);
>> +	op.addr.buswidth = spi_nor_get_protocol_addr_nbits(nor->read_proto);
> 
> nit: op.dummy.buswidth = op.addr.buswidth;
> 

Sure, will change.

> cut
> 
>>  
>> @@ -688,6 +1003,16 @@ static int spi_nor_erase_sector(struct spi_nor *nor, u32 addr)
>>  	if (nor->erase)
>>  		return nor->erase(nor, addr);
>>  
>> +	if (nor->spimem) {
>> +		struct spi_mem_op op =
>> +			SPI_MEM_OP(SPI_MEM_OP_CMD(nor->erase_opcode, 1),
>> +				   SPI_MEM_OP_ADDR(nor->addr_width, addr, 1),
>> +				   SPI_MEM_OP_NO_DUMMY,
>> +				   SPI_MEM_OP_NO_DATA);
>> +
>> +		return spi_mem_exec_op(nor->spimem, &op);
>> +	}
>> +
> 
> this should be done below in the function, after masking the address.

Nope. It would have been true if addr been sent as part of op.data.buf.out. 
But since addr is being send as part of op.addr.val, spi-mem.c takes care of this for spi_transfer(s)

> 
> You add a double space after return in:
>> +	return  nor->read_reg(nor, SPINOR_OP_RDSR2, sr2, 1);
> 

Ah, Will fix

> There are some checkpatch warnings that we can fix now.
> 

I did see warnings like:
>
>WARNING: line over 80 characters
>#1023: FILE: drivers/mtd/spi-nor/spi-nor.c:2554:
>+				   SPI_MEM_OP_DATA_IN(SPI_NOR_MAX_ID_LEN, id, 1));

I think its okay to overshoot 80 char limit for better readability. 
Let me know if you think otherwise

> ERROR: space required after that ',' (ctx:VxV)
>#1270: FILE: drivers/mtd/spi-nor/spi-nor.c:4846:
>+	{"mx25l25635e"},{"mx66l51235l"},
> 	               ^

This and similar warnings can be fixed, but will throw off alignment wrt previous lines.
Therefore I let them be as is.



> Looks good!
> ta
> 

-- 
Regards
Vignesh
