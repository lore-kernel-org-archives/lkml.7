Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52325C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 00:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26CFE2147A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 00:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730626AbfFTAkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 20:40:32 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:56056 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726072AbfFTAkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 20:40:32 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07499032|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.0487576-0.000955636-0.950287;FP=0|0|0|0|0|-1|-1|-1;HT=e01l07391;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.Enf4VU1_1560991224;
Received: from 172.16.10.102(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.Enf4VU1_1560991224)
          by smtp.aliyun-inc.com(10.147.40.26);
          Thu, 20 Jun 2019 08:40:25 +0800
Subject: Re: [PATCH] mtd: spinand: fix error read return value
To:     Boris Brezillon <boris.brezillon@collabora.com>,
        Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chuanhong Guo <gch981213@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Frieder Schrempf <frieder.schrempf@exceet.de>,
        =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Peter Pan <peterpandong@micron.com>
References: <1560950005-8868-1-git-send-email-liaoweixiong@allwinnertech.com>
 <20190619154611.3bfc007b@collabora.com>
 <99279437-54a6-c81d-aad2-231009f18cfc@kontron.de>
 <20190619181832.6f467279@collabora.com>
From:   liaoweixiong <liaoweixiong@allwinnertech.com>
Message-ID: <4e8296fb-ff61-9319-99b5-aaa80025ccc6@allwinnertech.com>
Date:   Thu, 20 Jun 2019 08:40:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190619181832.6f467279@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Boris Brezillon,

Sure, i will adjust the commit message and send again right now.

On 2019/6/20 AM12:18, Boris Brezillon wrote:
> On Wed, 19 Jun 2019 14:02:14 +0000
> Schrempf Frieder <frieder.schrempf@kontron.de> wrote:
> 
>> On 19.06.19 15:46, Boris Brezillon wrote:
>>> Hi liaoweixiong,
>>>
>>> On Wed, 19 Jun 2019 21:13:24 +0800
>>> liaoweixiong <liaoweixiong@allwinnertech.com> wrote:
>>>   
>>>> In function spinand_mtd_read, if the last page to read occurs bitflip,
>>>> this function will return error value because veriable ret not equal to 0.  
>>>
>>> Actually, that's exactly what the MTD core expects (see [1]), so you're
>>> the one introducing a regression here.  
>>
>> To me it looks like the patch description is somewhat incorrect, but the 
>> fix itself looks okay, unless I'm getting it wrong.
>>
>> In case of the last page containing bitflips (ret > 0), 
>> spinand_mtd_read() will return that number of bitflips for the last 
>> page. But to me it looks like it should instead return max_bitflips like 
>> it does when the last page read returns with 0.
> 
> Oh, you're right. liaoweixiong, can you adjust the commit message
> accordingly?
> 
>>
>>>>
>>>> Signed-off-by: liaoweixiong <liaoweixiong@allwinnertech.com>
>>>> ---
>>>>   drivers/mtd/nand/spi/core.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
>>>> index 556bfdb..6b9388d 100644
>>>> --- a/drivers/mtd/nand/spi/core.c
>>>> +++ b/drivers/mtd/nand/spi/core.c
>>>> @@ -511,12 +511,12 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
>>>>   		if (ret == -EBADMSG) {
>>>>   			ecc_failed = true;
>>>>   			mtd->ecc_stats.failed++;
>>>> -			ret = 0;
>>>>   		} else {
>>>>   			mtd->ecc_stats.corrected += ret;
>>>>   			max_bitflips = max_t(unsigned int, max_bitflips, ret);
>>>>   		}
>>>>   
>>>> +		ret = 0;
>>>>   		ops->retlen += iter.req.datalen;
>>>>   		ops->oobretlen += iter.req.ooblen;
>>>>   	}  
>>>
>>> [1]https://elixir.bootlin.com/linux/latest/source/drivers/mtd/mtdcore.c#L1209
>>>
>>> ______________________________________________________
>>> Linux MTD discussion mailing list
>>> http://lists.infradead.org/mailman/listinfo/linux-mtd/
>>>  

-- 
liaoweixiong
