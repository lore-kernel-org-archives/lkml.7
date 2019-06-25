Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDA5C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 05:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7DD120659
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 05:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Rc2IdmhP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbfFYFv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 01:51:56 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:51490 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727648AbfFYFv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 01:51:56 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5P5phWh124656;
        Tue, 25 Jun 2019 00:51:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1561441903;
        bh=4ydtyfEhKGGW/Ym8YTJs7/FZVjb1PULXWMT5pJO9Yu4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Rc2IdmhPIIDtTjoavCEXOQ4rVB8Q//lJVmRKI622FOEg3yDnk6ulQcnscaukByUN8
         2wgw2+zQDPKhC60Dmwfuk4I0D1SlC1zZYR+vmMTeMwulMYyQJGlqpbHUnEP2GYpa7q
         9XHBYSigMEXUHRQPRiDTG5HBw3HOTGZEJLiElPH8=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5P5phq8066012
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Jun 2019 00:51:43 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 25
 Jun 2019 00:51:43 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 25 Jun 2019 00:51:42 -0500
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5P5pcQR064859;
        Tue, 25 Jun 2019 00:51:39 -0500
Subject: Re: [PATCH v7 1/5] mtd: cfi_cmdset_0002: Add support for polling
 status register
To:     Tokunori Ikegami <ikegami.t@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Mason Yang <masonccyang@mxic.com.tw>,
        <linux-arm-kernel@lists.infradead.org>
References: <20190620172250.9102-1-vigneshr@ti.com>
 <20190620172250.9102-2-vigneshr@ti.com>
 <571484c7-0cf4-6a7d-6d7f-375cfb13ce8b@gmail.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <c35bf193-02e2-6fe4-3db3-5be757616239@ti.com>
Date:   Tue, 25 Jun 2019 11:22:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <571484c7-0cf4-6a7d-6d7f-375cfb13ce8b@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 24/06/19 10:16 PM, Tokunori Ikegami wrote:
> 
[...]
>>   +/*
>> + * Use status register to poll for Erase/write completion when DQ is not
>> + * supported. This is indicated by Bit[1:0] of SoftwareFeatures field in
>> + * CFI Primary Vendor-Specific Extended Query table 1.5
>> + */
>> +static int cfi_use_status_reg(struct cfi_private *cfi)
>> +{
>> +    struct cfi_pri_amdstd *extp = cfi->cmdset_priv;
>> +
>> +    return extp->MinorVersion >= '5' &&
>> +        (extp->SoftwareFeatures & 0x3) == 0x1;
> 
> Seems to be better to use defined values instead of 0x3 and 0x1 hard
> coded values.
> 

Ok

>> +}
>> +
>> +static void cfi_check_err_status(struct map_info *map, unsigned long
>> adr)
>> +{
>> +    struct cfi_private *cfi = map->fldrv_priv;
>> +    map_word status;
>> +
>> +    if (!cfi_use_status_reg(cfi))
>> +        return;
>> +
>> +    cfi_send_gen_cmd(0x70, cfi->addr_unlock1, 0, map, cfi,
> 
> Is it not necessary to set chip->start as the base parameter for
> cfi_send_gen_cmd()?
> 

Right now, I am not aware of any flash that supports status registers
and are banked (that's when  chip->start can be non zero). Therefore I
did not think of using chip->start.
But anyways, I will fix this up to use chip->start here and elsewhere
for next version, assuming there will be such chips in the future.

>> +             cfi->device_type, NULL);
>> +    status = map_read(map, adr);
>> +
>> +    if (map_word_bitsset(map, status, CMD(0x3a))) {
>> +        unsigned long chipstatus = MERGESTATUS(status);
>> +
>> +        if (chipstatus & CFI_SR_ESB)
>> +            pr_err("%s erase operation failed, status %lx\n",
>> +                   map->name, chipstatus);
>> +        if (chipstatus & CFI_SR_PSB)
>> +            pr_err("%s program operation failed, status %lx\n",
>> +                   map->name, chipstatus);
>> +        if (chipstatus & CFI_SR_WBASB)
>> +            pr_err("%s buffer program command aborted, status %lx\n",
>> +                   map->name, chipstatus);
>> +        if (chipstatus & CFI_SR_SLSB)
>> +            pr_err("%s sector write protected, status %lx\n",
>> +                   map->name, chipstatus);
>> +    }
>> +}
>>     /* #define DEBUG_CFI_FEATURES */
>>   @@ -744,8 +796,22 @@ static struct mtd_info *cfi_amdstd_setup(struct
>> mtd_info *mtd)
>>    */
>>   static int __xipram chip_ready(struct map_info *map, unsigned long
>> addr)
>>   {
>> +    struct cfi_private *cfi = map->fldrv_priv;
>>       map_word d, t;
>>   +    if (cfi_use_status_reg(cfi)) {
>> +        map_word ready = CMD(CFI_SR_DRB);
>> +        /*
>> +         * For chips that support status register, check device
>> +         * ready bit
>> +         */
>> +        cfi_send_gen_cmd(0x70, cfi->addr_unlock1, 0, map, cfi,
> 
> Same comment as cfi_check_err_status() about the base address.
> 
>> +                 cfi->device_type, NULL);
>> +        d = map_read(map, addr);
>> +
>> +        return map_word_andequal(map, d, ready, ready);
>> +    }
>> +
>>       d = map_read(map, addr);
>>       t = map_read(map, addr);
>>   @@ -769,8 +835,27 @@ static int __xipram chip_ready(struct map_info
>> *map, unsigned long addr)
>>    */
>>   static int __xipram chip_good(struct map_info *map, unsigned long
>> addr, map_word expected)
>>   {
>> +    struct cfi_private *cfi = map->fldrv_priv;
>>       map_word oldd, curd;
>>   +    if (cfi_use_status_reg(cfi)) {
>> +        map_word ready = CMD(CFI_SR_DRB);
>> +        map_word err = CMD(CFI_SR_PSB | CFI_SR_ESB);
> 
> Is it not necessary to check CFI_SR_WBASB and CFI_SR_SLSB that are
> checked by cfi_check_err_status()?
> 

chip_good() is used to verify whether write or erase operation really
succeeded. Looking at Cypress HyperFlash datasheets and app notes on
status register polling, its enough to see if CFI_SR_PSB or CFI_SR_PSB
is set to know if write or erase failed. Now, the reason for program or
erase failure can be known by looking at CFI_SR_WBASB and CFI_SR_SLSB
which is done for cfi_check_err_status().
Therefore, I feel, its enough to look for CFI_SR_PSB or CFI_SR_ESB here.

Thanks for the review!

Regards
Vignesh

>> +        /*
>> +         * For chips that support status register, check device
>> +         * ready bit and Erase/Program status bit to know if
>> +         * operation succeeded.
>> +         */
>> +        cfi_send_gen_cmd(0x70, cfi->addr_unlock1, 0, map, cfi,
> 
> Same as cfi_check_err_status() and chip_ready() about the base address.
> 
>> +                 cfi->device_type, NULL);
>> +        curd = map_read(map, addr);
>> +
>> +        if (map_word_andequal(map, curd, ready, ready))
>> +            return !map_word_bitsset(map, curd, err);
>> +
>> +        return 0;
>> +    }
>> +
>>       oldd = map_read(map, addr);
>>       curd = map_read(map, addr);
>>   @@ -1644,6 +1729,7 @@ static int __xipram do_write_oneword(struct
>> map_info *map, struct flchip *chip,
>>       /* Did we succeed? */
>>       if (!chip_good(map, adr, datum)) {
>>           /* reset on all failures. */
>> +        cfi_check_err_status(map, adr);
>>           map_write(map, CMD(0xF0), chip->start);
>>           /* FIXME - should have reset delay before continuing */
>>   @@ -1901,6 +1987,7 @@ static int __xipram do_write_buffer(struct
>> map_info *map, struct flchip *chip,
>>        * See e.g.
>>        *
>> http://www.spansion.com/Support/Application%20Notes/MirrorBit_Write_Buffer_Prog_Page_Buffer_Read_AN.pdf
>>
>>        */
>> +    cfi_check_err_status(map, adr);
>>       cfi_send_gen_cmd(0xAA, cfi->addr_unlock1, chip->start, map, cfi,
>>                cfi->device_type, NULL);
>>       cfi_send_gen_cmd(0x55, cfi->addr_unlock2, chip->start, map, cfi,
>> @@ -2107,6 +2194,7 @@ static int do_panic_write_oneword(struct
>> map_info *map, struct flchip *chip,
>>         if (!chip_good(map, adr, datum)) {
>>           /* reset on all failures. */
>> +        cfi_check_err_status(map, adr);
>>           map_write(map, CMD(0xF0), chip->start);
>>           /* FIXME - should have reset delay before continuing */
>>   @@ -2316,6 +2404,7 @@ static int __xipram do_erase_chip(struct
>> map_info *map, struct flchip *chip)
>>       /* Did we succeed? */
>>       if (ret) {
>>           /* reset on all failures. */
>> +        cfi_check_err_status(map, adr);
>>           map_write(map, CMD(0xF0), chip->start);
>>           /* FIXME - should have reset delay before continuing */
>>   @@ -2412,6 +2501,7 @@ static int __xipram do_erase_oneblock(struct
>> map_info *map, struct flchip *chip,
>>       /* Did we succeed? */
>>       if (ret) {
>>           /* reset on all failures. */
>> +        cfi_check_err_status(map, adr);
>>           map_write(map, CMD(0xF0), chip->start);
>>           /* FIXME - should have reset delay before continuing */
>>   diff --git a/include/linux/mtd/cfi.h b/include/linux/mtd/cfi.h
>> index 208c87cf2e3e..b50416169049 100644
>> --- a/include/linux/mtd/cfi.h
>> +++ b/include/linux/mtd/cfi.h
>> @@ -219,6 +219,11 @@ struct cfi_pri_amdstd {
>>       uint8_t  VppMin;
>>       uint8_t  VppMax;
>>       uint8_t  TopBottom;
>> +    /* Below field are added from version 1.5 */
>> +    uint8_t  ProgramSuspend;
>> +    uint8_t  UnlockBypass;
>> +    uint8_t  SecureSiliconSector;
>> +    uint8_t  SoftwareFeatures;
>>   } __packed;
>>     /* Vendor-Specific PRI for Atmel chips (command set 0x0002) */

-- 
Regards
Vignesh
