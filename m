Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4DEC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 12:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0255204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 12:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729930AbfFXMKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 08:10:04 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:53011 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726351AbfFXMKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 08:10:04 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08198884|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.238094-0.0170177-0.744888;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03311;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.EpQVE7o_1561378197;
Received: from 172.16.10.102(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.EpQVE7o_1561378197)
          by smtp.aliyun-inc.com(10.147.41.158);
          Mon, 24 Jun 2019 20:09:58 +0800
Subject: Re: [PATCH v2] mtd: spinand: read return badly if the last page has
 bitflips
To:     Schrempf Frieder <frieder.schrempf@kontron.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Frieder Schrempf <frieder.schrempf@exceet.de>,
        Peter Pan <peterpandong@micron.com>,
        Jeff Kletsky <git-commits@allycomm.com>
Cc:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1560992416-5753-1-git-send-email-liaoweixiong@allwinnertech.com>
 <d406a968-a489-f457-2bde-1912618879fa@kontron.de>
From:   liaoweixiong <liaoweixiong@allwinnertech.com>
Message-ID: <6e0a848a-9b26-d9ef-d3bc-6df9efa666a9@allwinnertech.com>
Date:   Mon, 24 Jun 2019 20:10:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <d406a968-a489-f457-2bde-1912618879fa@kontron.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OK, thanks for your reviewing. I will resend right now.

On 2019/6/24 PM3:37, Schrempf Frieder wrote:
> On 20.06.19 03:00, liaoweixiong wrote:
>> In case of the last page containing bitflips (ret > 0),
>> spinand_mtd_read() will return that number of bitflips for the last
>> page. But to me it looks like it should instead return max_bitflips like
>> it does when the last page read returns with 0.
>>
>> Signed-off-by: liaoweixiong <liaoweixiong@allwinnertech.com>
> 
> Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> This should probably be resent with the following tags:
> 
> Cc: stable@vger.kernel.org
> Fixes: 7529df465248 ("mtd: nand: Add core infrastructure to support SPI 
> NANDs")
> 
>> ---
>>   drivers/mtd/nand/spi/core.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
>> index 556bfdb..6b9388d 100644
>> --- a/drivers/mtd/nand/spi/core.c
>> +++ b/drivers/mtd/nand/spi/core.c
>> @@ -511,12 +511,12 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
>>   		if (ret == -EBADMSG) {
>>   			ecc_failed = true;
>>   			mtd->ecc_stats.failed++;
>> -			ret = 0;
>>   		} else {
>>   			mtd->ecc_stats.corrected += ret;
>>   			max_bitflips = max_t(unsigned int, max_bitflips, ret);
>>   		}
>>   
>> +		ret = 0;
>>   		ops->retlen += iter.req.datalen;
>>   		ops->oobretlen += iter.req.ooblen;
>>   	}

-- 
liaoweixiong
