Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8066C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 10:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CA1820856
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 10:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BU3/ano4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbfHEKid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 06:38:33 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59380 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbfHEKic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 06:38:32 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x75AcHhm119448;
        Mon, 5 Aug 2019 05:38:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1565001497;
        bh=1uFoRjo+sqHmQ0i/bby6EbQk0dfwrARVx/RKVjTWgqc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=BU3/ano49QjoY/dMpIY4Y2onskLIxJm+5oZRaag+oTOCH51n8h2WppyP6HK1/BphX
         7BWLVv1XZN4fAwvO6GhdvKpdWh7MioAOORXNRpDIYvARgCno2pTTBkfQt7mpNz/6kl
         qCFCP1NxSKFkSNqGlxYpZyOHzH0FkfIqB76/eWS0=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x75AcHAp085815
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 5 Aug 2019 05:38:17 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 5 Aug
 2019 05:38:16 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 5 Aug 2019 05:38:16 -0500
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x75AcDOV033666;
        Mon, 5 Aug 2019 05:38:14 -0500
Subject: Re: [PATCH v4 1/3] mtd: spi-nor: always use bounce buffer for
 register read/writes
To:     <Tudor.Ambarus@microchip.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>
CC:     <marek.vasut@gmail.com>, <bbrezillon@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <tmaimon77@gmail.com>
References: <20190801162229.28897-1-vigneshr@ti.com>
 <20190801162229.28897-2-vigneshr@ti.com>
 <b125bf29-f1fd-6d33-4a7c-49cb94ef1488@microchip.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <2b10c18a-e955-31b8-b3e0-c3df83508756@ti.com>
Date:   Mon, 5 Aug 2019 16:08:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b125bf29-f1fd-6d33-4a7c-49cb94ef1488@microchip.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/08/19 2:36 PM, Tudor.Ambarus@microchip.com wrote:
> 
> 
> On 08/01/2019 07:22 PM, Vignesh Raghavendra wrote:
>> External E-Mail
>>
>>
>> spi-mem layer expects all buffers passed to it to be DMA'able. But
>> spi-nor layer mostly allocates buffers on stack for reading/writing to
>> registers and therefore are not DMA'able. Introduce bounce buffer to be
>> used to read/write to registers. This ensures that buffer passed to
>> spi-mem layer during register read/writes is DMA'able. With this change
>> nor->cmd-buf is no longer used, so drop it.
>>
>> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>> ---
>>
>> v4:
>> Avoid memcpy during READID
>>
>> v3: new patch
>>
>>  drivers/mtd/spi-nor/spi-nor.c | 70 ++++++++++++++++++++---------------
>>  include/linux/mtd/spi-nor.h   |  7 +++-
>>  2 files changed, 45 insertions(+), 32 deletions(-)
>>
>> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
>> index 03cc788511d5..e02376e1127b 100644
>> --- a/drivers/mtd/spi-nor/spi-nor.c
>> +++ b/drivers/mtd/spi-nor/spi-nor.c
> 
> cut
> 
>>  /**
>> @@ -1404,9 +1401,11 @@ static int write_sr_cr(struct spi_nor *nor, u8 *sr_cr)
>>  {
>>  	int ret;
>>  
>> +	memcpy(nor->bouncebuf, sr_cr, 2);
> 
> I'm thinking out loud. This can be avoided by forcing all the callers to use
> nor->bouncebuf. That would result in a:
> 

I can make this change and make all callers use nor->bouncebuf in next
version.

> static int write_sr(struct spi_nor *nor, size_t len)
> 
> write_sr_cr() can be removed. Memcopying 2 bytes is a small price to pay, we can
> keep things as they are, to not be too invasive. But if you think that this idea
> is worth it, tell.
> 

Sounds good to me. But replacing write_sr_cr() with above defintion of
write_sr() should be a patch IMO>

>> +
>>  	write_enable(nor);
>>  
>> -	ret = nor->write_reg(nor, SPINOR_OP_WRSR, sr_cr, 2);
>> +	ret = nor->write_reg(nor, SPINOR_OP_WRSR, nor->bouncebuf, 2);
>>  	if (ret < 0) {
>>  		dev_err(nor->dev,
>>  			"error while writing configuration register\n");
> 
> cut
> 
>> @@ -2177,9 +2176,10 @@ static const struct flash_info spi_nor_ids[] = {
>>  static const struct flash_info *spi_nor_read_id(struct spi_nor *nor)
>>  {
>>  	int			tmp;
>> -	u8			id[SPI_NOR_MAX_ID_LEN];
>> +	u8			*id;
>>  	const struct flash_info	*info;
>>  
>> +	id = nor->bouncebuf;
> 
> nit: do init at declaration.
> 

Ok.

> Also, you missed a place in which you can use the bouncebuf, search by "read_reg(":
> ret = nor->read_reg(nor, SPINOR_OP_XRDSR, &val, 1);
> 

Indeed, will fix in next version!

> Cheers,
> ta
> 

-- 
Regards
Vignesh
