Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CAEC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 06:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E0C2084E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 06:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gCdtSYmD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbfFUGEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 02:04:00 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44904 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfFUGD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 02:03:59 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5L63e1g052776;
        Fri, 21 Jun 2019 01:03:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1561097020;
        bh=knqPMcLBSbI4UYjJA4Jgm6wkFZPBA7qaJCNQVhq+O70=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=gCdtSYmDm4ZMnVIobxAtOLMTCGHTDfqFxUgNSjDZy585rz1he7q0BtY4Hdyx0pOUS
         9kMlwROgfH0I9C78iynctb1A8yA47yI0dGFpKjnCUjF4s/uSLUtqVAymLAQdbv7e7B
         DYa3yL1HxnusHwKeW9YiQPuSvYLuLFESWu+mpmLI=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5L63eQK115551
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 Jun 2019 01:03:40 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 21
 Jun 2019 01:03:40 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 21 Jun 2019 01:03:40 -0500
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5L63ZjE121278;
        Fri, 21 Jun 2019 01:03:36 -0500
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
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <93b9c5fd-8f59-96d7-5e40-2b9d540965dd@ti.com>
Date:   Fri, 21 Jun 2019 11:34:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAARK3H=O=h1VDgOMxs_0ThcisrH=2tzpW5pQqt0O9oYs=MFFVw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 17/06/19 8:48 PM, Sagar Kadam wrote:
> Hello Vignesh,
> 
> Thanks for your review comments.
> 
> On Sun, Jun 16, 2019 at 6:14 PM Vignesh Raghavendra <vigneshr@ti.com> wrote:
>>
>> Hi,
>>
>> On 12-Jun-19 4:17 PM, Sagar Shrikant Kadam wrote:
>> [...]
>>
>>> @@ -4129,7 +4137,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
>>>       if (ret)
>>>               return ret;
>>>
>>> -     if (nor->addr_width) {
>>> +     if (nor->addr_width && JEDEC_MFR(info) != SNOR_MFR_ISSI) {
>>>               /* already configured from SFDP */
>>
>> Hmm, why would you want to ignore addr_width that's read from SFDP table?
> 
> The SFDP table for ISSI device considered here, has addr_width set to
> 3 byte, and the flash considered
> here is 32MB. With 3 byte address width we won't be able to access
> flash memories higher address range.

Is it specific to a particular ISSI part as indicated here[1]? If so,
please submit solution agreed there i.e. use spi_nor_fixups callback

[1]https://patchwork.ozlabs.org/patch/1056049/

> Hence I have ignored the addr width from SFDP.  I have verified that
> with 3 byte address width, the
> flascp util fails while verifying the written data.  Please let me
> know your views on this?
> 
If this affects multiple ISSI parts then:
Instead of checking for mfr code, look for SNOR_F_4B_OPCODES flag in
flash_info struct of the device and let it take precedence over SFDP in
case size is over 16MB

Regards
Vignesh

> BR,
> Sagar Kadam
> 
>> Regards
>> Vignesh
>>
>>
>>>       } else if (info->addr_width) {
>>>               nor->addr_width = info->addr_width;
>>> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
>>> index b3d360b..ff13297 100644
>>> --- a/include/linux/mtd/spi-nor.h
>>> +++ b/include/linux/mtd/spi-nor.h
>>> @@ -19,6 +19,7 @@
>>>  #define SNOR_MFR_ATMEL               CFI_MFR_ATMEL
>>>  #define SNOR_MFR_GIGADEVICE  0xc8
>>>  #define SNOR_MFR_INTEL               CFI_MFR_INTEL
>>> +#define SNOR_MFR_ISSI                0x9d            /* ISSI */
>>>  #define SNOR_MFR_ST          CFI_MFR_ST      /* ST Micro */
>>>  #define SNOR_MFR_MICRON              CFI_MFR_MICRON  /* Micron */
>>>  #define SNOR_MFR_MACRONIX    CFI_MFR_MACRONIX
>>>

-- 
Regards
Vignesh
