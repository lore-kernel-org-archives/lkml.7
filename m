Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C254C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 16:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DDDE20700
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 16:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="x+nuKIaz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbfC0QEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 12:04:06 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:35594 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbfC0QEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 12:04:05 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2RG3aLv040085;
        Wed, 27 Mar 2019 11:03:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553702616;
        bh=bY6i+Gb3B1LRhSlCo7jad+rnNzPpomSDjT2EHAj2YhE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=x+nuKIazGsJ/LII5BL7C3FgtqpX7YV+Jc2OFMgPiwV7Wb4emj1kxo8is156QhYvXb
         QkB6E+CyBeIK+sv0cs9yMDMO9fE4qslVOCIDr5V6VMO5Dkl/J07LavJ78TM948hNGr
         T0by+ykhjGwCqRU+HpuB7fLnxwYSdplo2TdGZAcI=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2RG3ZXh126512
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Mar 2019 11:03:35 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 27
 Mar 2019 11:03:35 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 27 Mar 2019 11:03:35 -0500
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x2RG3V3k102496;
        Wed, 27 Mar 2019 11:03:32 -0500
Subject: Re: [PATCH v2] mtd: spi-nor: Return error when nor->addr_width does
 not match the device size
To:     Liu Xiang <liuxiang_1999@126.com>
CC:     Liu Xiang <liu.xiang6@zte.com.cn>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "richard@nod.at" <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>
References: <1552484753-3393-1-git-send-email-liu.xiang6@zte.com.cn>
 <823dcd3f-8b9f-15c5-a072-06625120766e@ti.com>
 <209ad144.9c0a.169ba96e2ad.Coremail.liuxiang_1999@126.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <c718ab17-1c0a-a75f-c43a-4e2558a67d0f@ti.com>
Date:   Wed, 27 Mar 2019 21:34:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <209ad144.9c0a.169ba96e2ad.Coremail.liuxiang_1999@126.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/19 8:50 PM, Liu Xiang wrote:
> At 2019-03-19 13:22:15, "Vignesh Raghavendra" <vigneshr@ti.com> wrote:
>> Hi,
>>
>> On 13/03/19 7:15 PM, Liu Xiang wrote:
>>> In some is25lp256, the DWORD1 of JEDEC Basic Flash Parameter Header
>>> is 0xfff920e5. So the DWORD1[18:17] Address Bytes bits are 0b00,
>>> means that 3-Byte only addressing. But the device size is larger
>>> than 16MB, nor->addr_width must be 4 to access the whole address.
>>> An error should be returned when nor->addr_width does not match
>>> the device size in spi_nor_parse_bfpt(). Then it can go back to
>>> use spi_nor_ids[] for setting the right addr_width.
>>>
>>> Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
>>> Signed-off-by: Liu Xiang <liu.xiang6@zte.com.cn>
>>> ---
>>>  drivers/mtd/spi-nor/spi-nor.c | 8 ++++++++
>>>  1 file changed, 8 insertions(+)
>>>
>>> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
>>> index 6e13bbd..63933c7 100644
>>> --- a/drivers/mtd/spi-nor/spi-nor.c
>>> +++ b/drivers/mtd/spi-nor/spi-nor.c
>>> @@ -2811,6 +2811,14 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
>>>  	}
>>>  	params->size >>= 3; /* Convert to bytes. */
>>>  
>>> +	/*
>>> +	 * If the device exceeds 16MiB, addr_width must be 4.
>>> +	 * addr_width == 3 means the Address Bytes we are
>>> +	 * reading from BFPT is wrong.
>>> +	 */
>>
>> JESD216 standard does not mandate flash devices >16MiB to always support
>> 4 byte addressing opcode. So, its okay for flash vendor to support
>>> 16MiB flash with 3 byte addressing and Bank/extended address register.
>>
>>> +	if (params->size > 0x1000000 && nor->addr_width == 3)
>>> +		return -EINVAL;
>>> +
>>
>> Assuming only DWORD1[18:17] bits are wrong, then returning from here
>> would mean we miss parsing Sector Erase settings, Quad Enable
>> Requirements etc from BFPT which is kind of bad.
>> I suggest to move the fix to[1], addr_width indicated in flash_info
>> struct of the device can take precedence over SFDP.
>>
>> [1]https://elixir.bootlin.com/linux/latest/source/drivers/mtd/spi-nor/spi-nor.c#L4106
> 
> Boris has added a fixup function, do you think this is more better:
> 
> static int
> is25lp256_post_bfpt_fixups(struct spi_nor *nor,
> 			    const struct sfdp_parameter_header *bfpt_header,
> 			    const struct sfdp_bfpt *bfpt,
> 			    struct spi_nor_flash_parameter *params)
> {
> 	/*
> 	 * IS25LP256 supports 4B opcodes.
> 	 * Unfortunately, some devices get BFPT_DWORD1_ADDRESS_BYTES_3_ONLY  
> 	 * from BFPT table for address width. We should fix it.
> 	 */
> 	if (bfpt.dwords[BFPT_DWORD(1)] & BFPT_DWORD1_ADDRESS_BYTES_MASK == 
> 		BFPT_DWORD1_ADDRESS_BYTES_3_ONLY)
> 		nor->addr_width = 4;
> 
> 	return 0;
> }
> 
> static struct spi_nor_fixups is25lp256_fixups = {
> 	.post_bfpt = is25lp256_post_bfpt_fixups,
> };
> 
> 

Sounds fine to me as is25lp256 is the only part that needs this quirk at
the moment.


-- 
Regards
Vignesh
