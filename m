Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CEBC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 12:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 228652086D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 12:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GhaIpYzX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbfHEMbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 08:31:21 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:37484 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbfHEMbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 08:31:20 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x75CV3jb045947;
        Mon, 5 Aug 2019 07:31:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1565008263;
        bh=lWzTXhSrr0cAVNRCkLsMsMLThhETZUSnx3FezDaatlw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=GhaIpYzXsLYKaVOrYN7dAF+9q5ShfJUjPlj4pOLVhZvnhWQkW4iol5jESWWhxgZFC
         v3tjk72s+Xi0o0vDKye1BVlrsslYart7+o6Xg1Zwj5kxYZRiiRmF6NcLQdj8cOIdgs
         yDob0Mvwd3HLqxQQugDPBbOPPyRM/6Vj7NxP7VEM=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x75CV2Q3039836
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 5 Aug 2019 07:31:02 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 5 Aug
 2019 07:31:02 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 5 Aug 2019 07:31:02 -0500
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x75CUx4v054735;
        Mon, 5 Aug 2019 07:30:59 -0500
Subject: Re: [PATCH v4 2/3] mtd: spi-nor: Move m25p80 code in spi-nor.c
To:     <Tudor.Ambarus@microchip.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>
CC:     <marek.vasut@gmail.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <tmaimon77@gmail.com>,
        <bbrezillon@kernel.org>
References: <20190801162229.28897-1-vigneshr@ti.com>
 <20190801162229.28897-3-vigneshr@ti.com>
 <852ffdd1-a546-03db-3b60-47d60bd8d7cf@microchip.com>
 <c4aa9ee0-9deb-9432-5ae6-0c807092ef35@ti.com>
 <50066b1c-6c4c-4aa7-c03d-1d2876afa2c2@microchip.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <cdc6268d-16c7-82ad-53e0-9ec9352d0400@ti.com>
Date:   Mon, 5 Aug 2019 18:01:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <50066b1c-6c4c-4aa7-c03d-1d2876afa2c2@microchip.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/08/19 5:21 PM, Tudor.Ambarus@microchip.com wrote:
> 
> 
> On 08/05/2019 02:10 PM, Vignesh Raghavendra wrote:
>> External E-Mail
>>
>>
>>
>> On 05/08/19 3:55 PM, Tudor.Ambarus@microchip.com wrote:
>>>
>>>
>>> On 08/01/2019 07:22 PM, Vignesh Raghavendra wrote:
>>>
>>>> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
>>>> index e02376e1127b..866962c715b4 100644
>>>> --- a/drivers/mtd/spi-nor/spi-nor.c
>>>> +++ b/drivers/mtd/spi-nor/spi-nor.c
>>>> @@ -19,6 +19,7 @@
>>>
> 
>>>>  
>>>> @@ -688,6 +1003,16 @@ static int spi_nor_erase_sector(struct spi_nor *nor, u32 addr)
>>>>  	if (nor->erase)
>>>>  		return nor->erase(nor, addr);
>>>>  
>>>> +	if (nor->spimem) {
>>>> +		struct spi_mem_op op =
>>>> +			SPI_MEM_OP(SPI_MEM_OP_CMD(nor->erase_opcode, 1),
>>>> +				   SPI_MEM_OP_ADDR(nor->addr_width, addr, 1),
>>>> +				   SPI_MEM_OP_NO_DUMMY,
>>>> +				   SPI_MEM_OP_NO_DATA);
>>>> +
>>>> +		return spi_mem_exec_op(nor->spimem, &op);
>>>> +	}
>>>> +
>>>
>>> this should be done below in the function, after masking the address.
>>
>> Nope. It would have been true if addr been sent as part of op.data.buf.out. 
>> But since addr is being send as part of op.addr.val, spi-mem.c takes care of this for spi_transfer(s)
>>
> 
> Is this valid also for the controllers that implement the ctlr->mem_ops?

Nope, address conversion logic is not required if ctlr->mem_ops is
implemented. spi-mem drivers should be able to handle address field as
is and there is no need to be converted to SPI bus order.

Regards
Vignesh

> 
>>>
>>> You add a double space after return in:
>>>> +	return  nor->read_reg(nor, SPINOR_OP_RDSR2, sr2, 1);
>>>
>>
>> Ah, Will fix
>>
>>> There are some checkpatch warnings that we can fix now.
>>>
>>
>> I did see warnings like:
>>>
>>> WARNING: line over 80 characters
>>> #1023: FILE: drivers/mtd/spi-nor/spi-nor.c:2554:
>>> +				   SPI_MEM_OP_DATA_IN(SPI_NOR_MAX_ID_LEN, id, 1));
>>
>> I think its okay to overshoot 80 char limit for better readability. 
> 
> ok
> 
>> Let me know if you think otherwise> 
>>> ERROR: space required after that ',' (ctx:VxV)
>>> #1270: FILE: drivers/mtd/spi-nor/spi-nor.c:4846:
>>> +	{"mx25l25635e"},{"mx66l51235l"},
>>> 	               ^
>>
>> This and similar warnings can be fixed, but will throw off alignment wrt previous lines.
>> Therefore I let them be as is.
> 
> ok
> 
> Cheers,ta
> 

-- 
Regards
Vignesh
