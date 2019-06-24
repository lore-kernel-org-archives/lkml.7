Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2232AC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 11:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE9642089F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 11:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="y8arNI92"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729724AbfFXLIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 07:08:09 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33402 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727732AbfFXLIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 07:08:02 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5OAxFgd066809;
        Mon, 24 Jun 2019 05:59:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1561373955;
        bh=xj6qPp/mhLO8O/bD0ogOLiG7+uM+u74/DU37aW5o1M4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=y8arNI920qA2FKw6lZyuxo6SNGGd/H26cY8TI4eWFeTba/3B3cQr9GiCAbIzNc87J
         olZsV+bILard07rOsP64e2IbDPEUBPA3qrJyGOl4Wsf5RPXSDQbhpYqomrQJByWfiL
         a2iU0rWNgvYJrLv7Qb9aFVUhYbSFRfgTEm9ZKVYk=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5OAxFHW008896
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Jun 2019 05:59:15 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 24
 Jun 2019 05:59:14 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 24 Jun 2019 05:59:14 -0500
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5OAxBkM108281;
        Mon, 24 Jun 2019 05:59:11 -0500
Subject: Re: [PATCH v3] mtd: spi-nor: fix nor->addr_width when its value
 configured from SFDP does not match the actual width
To:     <Tudor.Ambarus@microchip.com>, <liu.xiang6@zte.com.cn>,
        <linux-mtd@lists.infradead.org>
CC:     <bbrezillon@kernel.org>, <richard@nod.at>,
        <linux-kernel@vger.kernel.org>, <marek.vasut@gmail.com>,
        <liuxiang_1999@126.com>, <computersforpeace@gmail.com>,
        <dwmw2@infradead.org>, <nagasure@xilinx.com>
References: <1554018157-10860-1-git-send-email-liu.xiang6@zte.com.cn>
 <5ffc9e32-ff69-9819-7bfd-ad9f793bb629@microchip.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <aea913e6-d168-32dd-1913-f1796905f98e@ti.com>
Date:   Mon, 24 Jun 2019 16:29:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <5ffc9e32-ff69-9819-7bfd-ad9f793bb629@microchip.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/06/19 5:19 PM, Tudor.Ambarus@microchip.com wrote:
> Hi, Liu,
> 
> On 03/31/2019 10:42 AM, Liu Xiang wrote:
> 
>> Some is25lp256 get BFPT_DWORD1_ADDRESS_BYTES_3_ONLY from BFPT table for
>> address width. But in actual fact the flash can support 4-byte address.
>> So we should fix it.
> 
> It's better to be imperative. Substitute "So we should fix it" with something
> like "Use a post bfpt fixup hook to overwrite the address width advertised by
> the BFPT".
> 
>>
> 
> We'll need a fixes tag here.> Suggested-by: Boris Brezillon <bbrezillon@kernel.org>
>> Suggested-by: Vignesh Raghavendra <vigneshr@ti.com>
> 
> When? If they didn't explicitly suggested this approach, lets drop the S-b tags.
> 

IIRC, this was actually Boris's patch. No need for my S-b tag me :)

Regards
Vignesh

>> Signed-off-by: Liu Xiang <liu.xiang6@zte.com.cn>
>> ---
>>
>> Changes in v3:
>>  add a fixup for is25lp256 to solve the address width problem.
>>
>>  drivers/mtd/spi-nor/spi-nor.c | 25 ++++++++++++++++++++++++-
>>  1 file changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
>> index 6e13bbd..d252a66 100644
>> --- a/drivers/mtd/spi-nor/spi-nor.c
>> +++ b/drivers/mtd/spi-nor/spi-nor.c
>> @@ -1682,6 +1682,28 @@ static int sr2_bit7_quad_enable(struct spi_nor *nor)
>>  		.flags = SPI_NOR_NO_FR | SPI_S3AN,
>>  
>>  static int
>> +is25lp256_post_bfpt_fixups(struct spi_nor *nor,
>> +			   const struct sfdp_parameter_header *bfpt_header,
>> +			   const struct sfdp_bfpt *bfpt,
>> +			   struct spi_nor_flash_parameter *params)
>> +{
>> +	/*
>> +	 * IS25LP256 supports 4B opcodes.
>> +	 * Unfortunately, some devices get BFPT_DWORD1_ADDRESS_BYTES_3_ONLY
>                             ^ which devices, did you get a list from issi?
> 
>> +	 * from BFPT table for address width. We should fix it.
> 
> How about "IS25LP256 supports 4B opcodes, but the BFPT advertises a
> BFPT_DWORD1_ADDRESS_BYTES_3_ONLY address width. Overwrite the address width
> advertised by the BFPT."
> 
>> +	 */
>> +	if ((bfpt->dwords[BFPT_DWORD(1)] & BFPT_DWORD1_ADDRESS_BYTES_MASK) ==
>> +		BFPT_DWORD1_ADDRESS_BYTES_3_ONLY)
>> +		nor->addr_width = 4;
>> +
>> +	return 0;
>> +}
>> +
>> +static struct spi_nor_fixups is25lp256_fixups = {
> 
> Naga will use "is25lp256_fixups" for the is25wp256 too, but it's not the case to
> change the name yet. All good here.
> 
> I really want to have this in next, can I have an update in the next few days?
> 
> Cheers,
> ta
> 

-- 
Regards
Vignesh
