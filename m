Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B83C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 11:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 953AF215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 11:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730809AbfJDLbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 07:31:19 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3245 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727254AbfJDLbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 07:31:19 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0627EB35D572C712DE9E;
        Fri,  4 Oct 2019 19:31:17 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.179) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Fri, 4 Oct 2019
 19:31:15 +0800
Subject: Re: [PATCH] mtd: spi-nor: Fix direction of the write_sr() transfer
To:     <Tudor.Ambarus@microchip.com>, <vigneshr@ti.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <c703dec2-dd11-5898-83ad-fb06127b6575@huawei.com>
 <20191004104746.23537-1-tudor.ambarus@microchip.com>
 <9156860e-d257-bee6-fac8-a1821e4b5bf2@microchip.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <60f0c52f-1301-57eb-59ba-b2893107d5d6@huawei.com>
Date:   Fri, 4 Oct 2019 12:31:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <9156860e-d257-bee6-fac8-a1821e4b5bf2@microchip.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2019 11:48, Tudor.Ambarus@microchip.com wrote:
> John, does this fix your problem?

It fixes the problem in the flash_lock -u command no longer errors like 
this:
root@ubuntu:/home/john# sudo flash_lock -u /dev/mtd0
flash_lock: error!: could not unlock device: /dev/mtd0

However, with this change, even when the flash is unlocked I cannot 
write, so there is something else wrong. It's probably a bug in my 
under-development driver. I'm looking at it now.

Thanks,
John

>
> On 10/04/2019 01:47 PM, Tudor Ambarus - M18064 wrote:
>> From: Tudor Ambarus <tudor.ambarus@microchip.com>
>>
>> write_sr() sends data to the SPI memory, fix the direction.
>>
>> Fixes: b35b9a10362d ("mtd: spi-nor: Move m25p80 code in spi-nor.c")
>> Reported-by: John Garry <john.garry@huawei.com>
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
>> ---
>>  drivers/mtd/spi-nor/spi-nor.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
>> index 1d8621d43160..7acf4a93b592 100644
>> --- a/drivers/mtd/spi-nor/spi-nor.c
>> +++ b/drivers/mtd/spi-nor/spi-nor.c
>> @@ -487,7 +487,7 @@ static int write_sr(struct spi_nor *nor, u8 val)
>>  			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRSR, 1),
>>  				   SPI_MEM_OP_NO_ADDR,
>>  				   SPI_MEM_OP_NO_DUMMY,
>> -				   SPI_MEM_OP_DATA_IN(1, nor->bouncebuf, 1));
>> +				   SPI_MEM_OP_DATA_OUT(1, nor->bouncebuf, 1));
>>
>>  		return spi_mem_exec_op(nor->spimem, &op);
>>  	}
>>


