Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56711C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 06:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0141E214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 06:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IUKC5jCn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730160AbfHAGpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 02:45:10 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:60256 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfHAGpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 02:45:10 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x716ivrT070548;
        Thu, 1 Aug 2019 01:44:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1564641897;
        bh=7klj/oxvN3FoRHz8lsnRzWDOpkLfDASFSU6JxyhjCzE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=IUKC5jCnFKMk9KcJ79PKFMHteVNz7xUBnHAf/imbfaGqTPCcPS4SG5QvIUuDp96A3
         r3WjjpT3+BrxAkOxIPSJvC22zmIr0bts9TTSsmoKamzJQCRGH8aultvp0KzjgtvI22
         P9CZKFzpLdaY5DsE2bnuUl8xwf7L7B3fLpsx9bzc=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x716iulm106677
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Aug 2019 01:44:57 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 1 Aug
 2019 01:44:56 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 1 Aug 2019 01:44:56 -0500
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x716irJi115628;
        Thu, 1 Aug 2019 01:44:54 -0500
Subject: Re: [PATCH v3 1/3] mtd: spi-nor: always use bounce buffer for
 register read/writes
To:     Boris Brezillon <boris.brezillon@collabora.com>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
References: <20190801043052.30192-1-vigneshr@ti.com>
 <20190801043052.30192-2-vigneshr@ti.com>
 <20190801074647.792479c1@collabora.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <d057db47-64a6-01ca-2ccb-d57c532213d4@ti.com>
Date:   Thu, 1 Aug 2019 12:15:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190801074647.792479c1@collabora.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris

On 01/08/19 11:16 AM, Boris Brezillon wrote:
> On Thu, 1 Aug 2019 10:00:50 +0530
> Vignesh Raghavendra <vigneshr@ti.com> wrote:
> 
>> spi-mem layer expects all buffers passed to it to be DMA'able. But
>> spi-nor layer mostly allocates buffers on stack for reading/writing to
>> registers and therefore are not DMA'able. Introduce bounce buffer to be
>> used to read/write to registers. This ensures that buffer passed to
>> spi-mem layer during register read/writes is DMA'able. With this change
>> nor->cmd-buf is no longer used, so drop it.
>>
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>> ---
>> v3: new patch
>>

[...]

>> @@ -2180,11 +2179,13 @@ static const struct flash_info *spi_nor_read_id(struct spi_nor *nor)
>>  	u8			id[SPI_NOR_MAX_ID_LEN];
>>  	const struct flash_info	*info;
>>  
>> -	tmp = nor->read_reg(nor, SPINOR_OP_RDID, id, SPI_NOR_MAX_ID_LEN);
>> +	tmp = nor->read_reg(nor, SPINOR_OP_RDID, nor->bouncebuf,
>> +			    SPI_NOR_MAX_ID_LEN);
>>  	if (tmp < 0) {
>>  		dev_err(nor->dev, "error %d reading JEDEC ID\n", tmp);
>>  		return ERR_PTR(tmp);
>>  	}
>> +	memcpy(id, nor->bouncebuf, SPI_NOR_MAX_ID_LEN);
> 
> Why not directly including the change you have in patch 2 (id is a
> pointer that points directly to ->bouncebuf) so you can get rid of this
> memcpy() here?
>

Ok will do that in next version.


>>  
>>  	for (tmp = 0; tmp < ARRAY_SIZE(spi_nor_ids) - 1; tmp++) {
>>  		info = &spi_nor_ids[tmp];
>> @@ -4121,6 +4122,16 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
>>  	nor->read_proto = SNOR_PROTO_1_1_1;
>>  	nor->write_proto = SNOR_PROTO_1_1_1;
>>  
>> +	/*
>> +	 * We need the bounce buffer early to read/write registers when going
>> +	 * through the spi-mem layer (buffers have to be DMA-able).
> 
> You should probably extend this comment in patch 2 to explain why 4k
> should be enough for regular read/write operations.
> 

Will update

> The patch looks good otherwise.
> 
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> 

Thanks for the review!

-- 
Regards
Vignesh
