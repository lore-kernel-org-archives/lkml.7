Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1783DC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDFE7205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XKTJZNkz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730656AbfFXNHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 09:07:52 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:39582 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbfFXNHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 09:07:51 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5OD7R5P017486;
        Mon, 24 Jun 2019 08:07:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1561381647;
        bh=H46VUliW+A0t7K83Z0CbWl1N3ks6sZT+q0tMS4MbV9M=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=XKTJZNkziTZ7+Rqw5Ei+zTfc5yDQtwt+BM8x6utpQOZEmHmghXrjgy4V2mRm7KWP3
         OZ+0E+Utnhmm4VIrtkQPu9MFZF9Di+HGvChR0/E3Kp6f73pZgajPBVrncnXdTL68d9
         KVUcYyRwe4uGQsIkKXe+ZY7x+qT2OxUSydZIYHac=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5OD7RDZ061359
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Jun 2019 08:07:27 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 24
 Jun 2019 08:07:26 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 24 Jun 2019 08:07:26 -0500
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5OD7Mfp029217;
        Mon, 24 Jun 2019 08:07:23 -0500
Subject: Re: [PATCH v5 1/3] mtd: spi-nor: add support for is25wp256
To:     Sagar Kadam <sagar.kadam@sifive.com>
CC:     <marek.vasut@gmail.com>, <tudor.ambarus@microchip.com>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@sifive.com>, <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Wesley Terpstra <wesley@sifive.com>
References: <1560336476-31763-1-git-send-email-sagar.kadam@sifive.com>
 <1560336476-31763-2-git-send-email-sagar.kadam@sifive.com>
 <325855d0-00f9-df8a-ea57-c140d39dd6ef@ti.com>
 <CAARK3H=O=h1VDgOMxs_0ThcisrH=2tzpW5pQqt0O9oYs=MFFVw@mail.gmail.com>
 <93b9c5fd-8f59-96d7-5e40-2b9d540965dd@ti.com>
 <CAARK3H=CmxSG2srUaoxN1HF6W7CVKtpATrf89n6kuht2Paqp8A@mail.gmail.com>
 <3fe68154-5d1e-a395-4c53-d8e806b2cc6d@ti.com>
 <CAARK3HmNSOqhv_+Y2dMTRTyg=Jtry7J-j419CS5GTAiPiPLLdw@mail.gmail.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <8edce82b-5b3e-fccd-4748-457fe86f36be@ti.com>
Date:   Mon, 24 Jun 2019 18:38:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <CAARK3HmNSOqhv_+Y2dMTRTyg=Jtry7J-j419CS5GTAiPiPLLdw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/06/19 6:10 PM, Sagar Kadam wrote:
> Hello Vignesh,
> 
> On Mon, Jun 24, 2019 at 3:04 PM Vignesh Raghavendra <vigneshr@ti.com> wrote:
>>
>> Hi,
>>
>> On 21/06/19 3:58 PM, Sagar Kadam wrote:
>>> Hello Vignesh,
>>>
>>> On Fri, Jun 21, 2019 at 11:33 AM Vignesh Raghavendra <vigneshr@ti.com> wrote:
>>>>
>>>> Hi,
>>>>
>>>> On 17/06/19 8:48 PM, Sagar Kadam wrote:
>>>>> Hello Vignesh,
>>>>>
>>>>> Thanks for your review comments.
>>>>>
>>>>> On Sun, Jun 16, 2019 at 6:14 PM Vignesh Raghavendra <vigneshr@ti.com> wrote:
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> On 12-Jun-19 4:17 PM, Sagar Shrikant Kadam wrote:
>>>>>> [...]
>>>>>>
>>>>>>> @@ -4129,7 +4137,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
>>>>>>>       if (ret)
>>>>>>>               return ret;
>>>>>>>
>>>>>>> -     if (nor->addr_width) {
>>>>>>> +     if (nor->addr_width && JEDEC_MFR(info) != SNOR_MFR_ISSI) {
>>>>>>>               /* already configured from SFDP */
>>>>>>
>>>>>> Hmm, why would you want to ignore addr_width that's read from SFDP table?
>>>>>
>>>>> The SFDP table for ISSI device considered here, has addr_width set to
>>>>> 3 byte, and the flash considered
>>>>> here is 32MB. With 3 byte address width we won't be able to access
>>>>> flash memories higher address range.
>>>>
>>>> Is it specific to a particular ISSI part as indicated here[1]? If so,
>>>> please submit solution agreed there i.e. use spi_nor_fixups callback
>>>>
>>>> [1]https://patchwork.ozlabs.org/patch/1056049/
>>>>
>>>
>>> Thanks for sharing the link.
>>> From what I understand here, it seems that "Address Bytes" of SFDP
>>> table for the device under
>>> consideration (is25lp256) supports 3 byte only Addressing mode
>>> (DWORD1[18:17] = 0b00.
>>> where as that of ISSI device (is25LP/WP 256Mb/512/Mb/1Gb) support 3 or
>>> 4 byte Addressing mode DWORD1[18:17] = 0b01.
>>>
>>
>> Okay, so that SFDP table entry is correct. SPI NOR framework should
>> using 4 byte addressing if WORD1[18:17] = 0b01. Could you see if below
>> diff helps:
>>
> Thank-you for the suggestion.
> I applied it, and observed, that data in SFDP table mentioned in
> document received
> from ISSI support doesn't match with what is actually present on the
> device (I have raised a query with issi support for the same)
> The WP device also has the same SFDP entry as the LP device (the one
> which you shared).
> So, will submit V7 with the solution agreed in the link you shared above.
>      https://patchwork.ozlabs.org/patch/1056049/
> Apologies for the confusion, so please excuse the v6 which I submitted earlier.
> 

There is an updated version of the patch:
https://patchwork.ozlabs.org/patch/1071453/

You may want to align with Liu Xiang to avoid duplication of effort

> Thanks & BR,
> Sagar Kadam
> 
>> --->8---
>> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
>> index c0a8837c0575..ebf32aebe5e9 100644
>> --- a/drivers/mtd/spi-nor/spi-nor.c
>> +++ b/drivers/mtd/spi-nor/spi-nor.c
>> @@ -2808,6 +2808,7 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
>>                 break;
>>
>>         case BFPT_DWORD1_ADDRESS_BYTES_4_ONLY:
>> +       case BFPT_DWORD1_ADDRESS_BYTES_3_OR_4:
>>                 nor->addr_width = 4;
>>                 break;
> 
> 
>>
>>
>>
>>
>> --
>> Regards
>> Vignesh

-- 
Regards
Vignesh
