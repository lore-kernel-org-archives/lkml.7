Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5D7C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 07:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04A462084E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 07:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CLau/Foc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725827AbfFNHjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 03:39:35 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:48180 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfFNHjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 03:39:35 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5E7cn5Y055852;
        Fri, 14 Jun 2019 02:38:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1560497929;
        bh=XUtGv9i9kBDE+ZCJi30XsOqMTXyvYkwzq8DviMjz+zI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=CLau/FocdtepnaKW7TOtwKJtse9EitcdCONvaaKRRuneRloxuF2e3/SFS+fdbb1yc
         z0+xhXgitHRenRN6XhAFyJ5RyCO41grD2xZmIlnjWzp2hv12oO9AYbmq5jnha83gGd
         ISkeVwj0GBS0vcCPzcClrx3bdMFu8x8cMpi3dcTw=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5E7cnMo086540
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Jun 2019 02:38:49 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 14
 Jun 2019 02:38:49 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 14 Jun 2019 02:38:49 -0500
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5E7citB062587;
        Fri, 14 Jun 2019 02:38:45 -0500
Subject: Re: [PATCH] mtd: cfi_cmdset_0002: dynamically determine the max
 sectors
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>
CC:     "sr@denx.de" <sr@denx.de>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190522000628.13073-1-chris.packham@alliedtelesis.co.nz>
 <8e80d911f0dd4759b3edc72fb76530d6@svr-chch-ex1.atlnz.lc>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <8039faae-0ea3-fe85-ae2d-3e7853410a7d@ti.com>
Date:   Fri, 14 Jun 2019 13:09:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <8e80d911f0dd4759b3edc72fb76530d6@svr-chch-ex1.atlnz.lc>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/06/19 8:53 AM, Chris Packham wrote:
> Hi All,
> 
> I think this may have got lost in the change of maintainer for mtd.
> 

I do have this in my queue of patches for mtd/next and will forward to
Miquel once he is back.


> On 22/05/19 12:06 PM, Chris Packham wrote:
>> Because PPB unlocking unlocks the whole chip cfi_ppb_unlock() needs to
>> remember the locked status for each sector so it can re-lock the
>> unaddressed sectors. Dynamically calculate the maximum number of sectors
>> rather than using a hardcoded value that is too small for larger chips.
>>
>> Tested with Spansion S29GL01GS11TFI flash device.
>>
>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Acked-by: Vignesh Raghavendra <vigneshr@ti.com>

Regards
Vignesh

>> ---
>>   drivers/mtd/chips/cfi_cmdset_0002.c | 13 ++++++++-----
>>   1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/mtd/chips/cfi_cmdset_0002.c b/drivers/mtd/chips/cfi_cmdset_0002.c
>> index c8fa5906bdf9..a1a7d334aa82 100644
>> --- a/drivers/mtd/chips/cfi_cmdset_0002.c
>> +++ b/drivers/mtd/chips/cfi_cmdset_0002.c
>> @@ -2533,8 +2533,6 @@ struct ppb_lock {
>>   	int locked;
>>   };
>>   
>> -#define MAX_SECTORS			512
>> -
>>   #define DO_XXLOCK_ONEBLOCK_LOCK		((void *)1)
>>   #define DO_XXLOCK_ONEBLOCK_UNLOCK	((void *)2)
>>   #define DO_XXLOCK_ONEBLOCK_GETLOCK	((void *)3)
>> @@ -2633,6 +2631,7 @@ static int __maybe_unused cfi_ppb_unlock(struct mtd_info *mtd, loff_t ofs,
>>   	int i;
>>   	int sectors;
>>   	int ret;
>> +	int max_sectors;
>>   
>>   	/*
>>   	 * PPB unlocking always unlocks all sectors of the flash chip.
>> @@ -2640,7 +2639,11 @@ static int __maybe_unused cfi_ppb_unlock(struct mtd_info *mtd, loff_t ofs,
>>   	 * first check the locking status of all sectors and save
>>   	 * it for future use.
>>   	 */
>> -	sect = kcalloc(MAX_SECTORS, sizeof(struct ppb_lock), GFP_KERNEL);
>> +	max_sectors = 0;
>> +	for (i = 0; i < mtd->numeraseregions; i++)
>> +		max_sectors += regions[i].numblocks;
>> +
>> +	sect = kcalloc(max_sectors, sizeof(struct ppb_lock), GFP_KERNEL);
>>   	if (!sect)
>>   		return -ENOMEM;
>>   
>> @@ -2689,9 +2692,9 @@ static int __maybe_unused cfi_ppb_unlock(struct mtd_info *mtd, loff_t ofs,
>>   		}
>>   
>>   		sectors++;
>> -		if (sectors >= MAX_SECTORS) {
>> +		if (sectors >= max_sectors) {
>>   			printk(KERN_ERR "Only %d sectors for PPB locking supported!\n",
>> -			       MAX_SECTORS);
>> +			       max_sectors);
>>   			kfree(sect);
>>   			return -EINVAL;
>>   		}
>>
> 

-- 
Regards
Vignesh
