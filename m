Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC513C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 11:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93C7020679
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 11:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NZvXalp1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbfHEL3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 07:29:49 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:52626 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbfHEL3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 07:29:48 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x75BTKSW115484;
        Mon, 5 Aug 2019 06:29:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1565004560;
        bh=wzH7hcXLRSIRnTJuQkwQcED4ubUkDKVStLmHk0wTm2k=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=NZvXalp1tJcUv51D21uZysaUCYnHegn7+Ojxec0KEL3DB+gCkivle4pJstRKG/AGU
         s/0zQNgS317EQ45YTYIYEfR43K6S2x09KD5jiQ+BCC+p4i4F4CfmfiEourvfAzj3iA
         +6QhoYX1VgQyQXb/5KDlLZEXUZy6/FO/9S4bFPuQ=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x75BTKMR011027
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 5 Aug 2019 06:29:20 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 5 Aug
 2019 06:29:19 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 5 Aug 2019 06:29:19 -0500
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x75BTGqI029588;
        Mon, 5 Aug 2019 06:29:16 -0500
Subject: Re: [PATCH 6/7] mtd: spi-nor: Rework the SPI NOR lock/unlock logic
To:     <Tudor.Ambarus@microchip.com>, <boris.brezillon@collabora.com>,
        <marek.vasut@gmail.com>
CC:     <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <boris.brezillon@bootlin.com>
References: <20190731090315.26798-1-tudor.ambarus@microchip.com>
 <20190731090315.26798-7-tudor.ambarus@microchip.com>
 <21112f0c-abf0-2b86-5847-2ad7676a29be@ti.com>
 <d02fc366-55b6-f698-2419-f277e88dfe02@microchip.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <2da7cf7f-db59-2d0f-e7cb-fcda974031ca@ti.com>
Date:   Mon, 5 Aug 2019 16:59:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d02fc366-55b6-f698-2419-f277e88dfe02@microchip.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 05/08/19 1:30 PM, Tudor.Ambarus@microchip.com wrote:
>>
>> On 31-Jul-19 2:33 PM, Tudor.Ambarus@microchip.com wrote:
>>> From: Boris Brezillon <boris.brezillon@bootlin.com>
>>>
>>> Move the locking hooks in a separate struct so that we have just
>>> one field to update when we change the locking implementation.
>>>
>>> stm_locking_ops, the legacy locking operations, can be overwritten
>>> later on by implementing manufacturer specific default_init() hooks.
>>>
>>> Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
>>> [tudor.ambarus@microchip.com: use ->default_init() hook]
>>> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
>>
>> [...]
[...]
>>>  
>>> +/**
>>> + * struct spi_nor_locking_ops - SPI NOR locking methods
>>> + * @lock: lock a region of the SPI NOR
>>> + * @unlock: unlock a region of the SPI NOR
>>> + * @is_locked: check if a region of the SPI NOR is completely locked
>>> + */
>>> +struct spi_nor_locking_ops {
>>> +	int (*lock)(struct spi_nor *nor, loff_t ofs, uint64_t len);
>>> +	int (*unlock)(struct spi_nor *nor, loff_t ofs, uint64_t len);
>>> +	int (*is_locked)(struct spi_nor *nor, loff_t ofs, uint64_t len);
>>
>> checkpatch does not like uint64_t. Please changes these to size_t
> 
> This respects what struct mtd_info is expecting:
> 
>         int (*_lock) (struct mtd_info *mtd, loff_t ofs, uint64_t len);
>         int (*_unlock) (struct mtd_info *mtd, loff_t ofs, uint64_t len);
>         int (*_is_locked) (struct mtd_info *mtd, loff_t ofs, uint64_t len);
> 
> I haven't seen the warnings, would you mind pasting them?
> ./scripts/checkpatch.pl --strict 6-7-mtd-spi-nor-Rework-the-SPI-NOR-lock-unlock-logic.patch
> total: 0 errors, 0 warnings, 0 checks, 102 lines checked
> 
> 6-7-mtd-spi-nor-Rework-the-SPI-NOR-lock-unlock-logic.patch has no obvious style problems and is ready for submission.
> 

Hmm, seems to be emitted only for certain type of declarations. Not sure 
whats the pattern here. Warning is something like:

CHECK: Prefer kernel type 'u64' over 'uint64_t'

from: https://elixir.bootlin.com/linux/latest/source/scripts/checkpatch.pl#L5906


-- 
Regards
Vignesh
