Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23850C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 16:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E457E2067B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 16:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ISC8GuM8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbfKFQ0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 11:26:51 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:54930 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbfKFQ0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 11:26:51 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xA6GQNDb117954;
        Wed, 6 Nov 2019 10:26:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573057583;
        bh=X2oBSwJNQPZVsVwxr22Pa+22epqGXv5cpkuKVJLk37w=;
        h=From:Subject:To:CC:References:Date:In-Reply-To;
        b=ISC8GuM88VTWl5REKJnJPa5Uu5p5RrYZ3NzQDKRMyFVbx08bjbhxkVsmRh8eFitnk
         JNOOWtavqblIKvUNmQs//m4KC4nrf0rFaMiTp8+Ys5bb44F6M7rgOHXGYu7RX7B6rU
         FXQhcAKPnaN5OuaqCWiZ7M/4pObIJR+ttoMuVmvk=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xA6GQNsi046367
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Nov 2019 10:26:23 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 6 Nov
 2019 10:26:22 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 6 Nov 2019 10:26:07 -0600
Received: from [10.250.133.248] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xA6GQKaH056886;
        Wed, 6 Nov 2019 10:26:20 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v4 13/20] mtd: spi-nor: Fix clearing of QE bit on
 lock()/unlock()
To:     <Tudor.Ambarus@microchip.com>, <boris.brezillon@collabora.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20191102112316.20715-1-tudor.ambarus@microchip.com>
 <20191102112316.20715-14-tudor.ambarus@microchip.com>
 <14e9c474-1a92-b8be-12cf-56c7f6d0d696@ti.com>
 <af6fa950-495f-9e49-bcfe-09188e454b6d@microchip.com>
Message-ID: <36967b16-a52d-667f-cd61-cef9b87a83cf@ti.com>
Date:   Wed, 6 Nov 2019 21:56:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <af6fa950-495f-9e49-bcfe-09188e454b6d@microchip.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06/11/19 2:03 PM, Tudor.Ambarus@microchip.com wrote:
> 
> 
> On 11/05/2019 07:07 PM, Vignesh Raghavendra wrote:
>> On 02-Nov-19 4:53 PM, Tudor.Ambarus@microchip.com wrote:
>>> From: Tudor Ambarus <tudor.ambarus@microchip.com>
>>>
>>> Make sure that when doing a lock() or an unlock() operation we don't clear
>>> the QE bit from Status Register 2.
>>>
>>> JESD216 revB or later offers information about the *default* Status
>>> Register commands to use (see BFPT DWORDS[15], bits 22:20). In this
>>> standard, Status Register 1 refers to the first data byte transferred on a
>>> Read Status (05h) or Write Status (01h) command. Status register 2 refers
>>> to the byte read using instruction 35h. Status register 2 is the second
>>> byte transferred in a Write Status (01h) command.
>>>
>>> Industry naming and definitions of these Status Registers may differ.
>>> The definitions are described in JESD216B, BFPT DWORDS[15], bits 22:20.
>>> There are cases in which writing only one byte to the Status Register 1
>>> has the side-effect of clearing Status Register 2 and implicitly the Quad
>>> Enable bit. This side-effect is hit just by the
>>> BFPT_DWORD15_QER_SR2_BIT1_BUGGY and BFPT_DWORD15_QER_SR2_BIT1 cases.
>>>
>> But I see that 1 byte SR1 write still happens as part of
>> spi_nor_clear_sr_bp() until patch 20/20. So is this only a partial fix?
> 
> Fixing spi_nor_clear_sr_bp() would mean to add dead code that will be removed
> anyway with patch 20/20. This patch fixes the clearing of the QE bit, while in
> 20/20 the QE bit is already zero when the one byte SR1 write is used, so the
> quad mode is not affected. 20/20 fixes indirectly the clearing of all the bits
> from SR2 but QE bit, because it's already zero. I would say it's not a partial
> fix, but a different bug.
> 

I was not suggesting on fixing up spi_nor_clear_sr_bp(), but pointing
out that single byte writes SR1 can happen until patch 20/20.

But now I see that these patches are fixing related but different bugs.

> There are different angles to look at this, I chose the modifying of the quad
> mode angle. Given the two arguments from above (avoid adding dead code and
> changing of quad mode approach), I would prefer to keep things as they are. 

Ok, sounds fine, no need to change...

> But I get your approach too, so if you still want yours, I can do it. Please let me
> know.
> 
>> Should this patch be rearranged to appear along with 20/20?
> 
> Not necessarily (different bugs) but I can bring 20/20 immediately after this
> one if you want.
> >>
>>
>>> Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
>>> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
>>> ---
>>>  drivers/mtd/spi-nor/spi-nor.c | 120 ++++++++++++++++++++++++++++++++++++++++--
>>>  include/linux/mtd/spi-nor.h   |   3 ++
>>>  2 files changed, 118 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
>>> index 725dab241271..f96bc80c0ed1 100644
>>> --- a/drivers/mtd/spi-nor/spi-nor.c
>>> +++ b/drivers/mtd/spi-nor/spi-nor.c
>>> @@ -959,12 +959,19 @@ static int spi_nor_write_sr(struct spi_nor *nor, const u8 *sr, size_t len)
>>>  	return spi_nor_wait_till_ready(nor);
>>>  }
>>>  
>> [...]
>>> +/**
>>>   * spi_nor_write_sr2() - Write the Status Register 2 using the
>>>   * SPINOR_OP_WRSR2 (3eh) command.
>>>   * @nor:	pointer to 'struct spi_nor'.
>>> @@ -3634,19 +3723,38 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
>>>  		break;
>>>  
>>>  	case BFPT_DWORD15_QER_SR2_BIT1_BUGGY:
>>> +		/*
>>> +		 * Writing only one byte to the Status Register has the
>>> +		 * side-effect of clearing Status Register 2.
>>> +		 */
>>>  	case BFPT_DWORD15_QER_SR2_BIT1_NO_RD:
>>> +		/*
>>> +		 * Read Configuration Register (35h) instruction is not
>>> +		 * supported.
>>> +		 */
>>> +		nor->flags |= SNOR_F_HAS_16BIT_SR | SNOR_F_NO_READ_CR;
>> Since SNOR_F_HAS_16BIT_SR is set by default in
>> spi_nor_info_init_params(), no need to set the flag here again
>>
> 
> I did this on purpose. I set SNOR_F_HAS_16BIT_SR here based on SFDP standard, I
> want to indicate where the standard requires the 16 bit SR write .
> spi_nor_info_init_params() initializes data based on info, but that data can be
> overwritten (even with the same data) when parsing SFDP.
> 

Alright.

Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>

Regards
Vignesh
