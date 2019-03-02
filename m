Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFABC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 08:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3A8B20836
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 08:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="syUDuGcB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfCBI6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 03:58:36 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33866 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbfCBI6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 03:58:36 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x228w1sD055297;
        Sat, 2 Mar 2019 02:58:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1551517081;
        bh=ALOW7bCh93XjxU4oUJJzLplSu9kQFhCcZ+h+IJKVzZA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=syUDuGcBspn0SGICKUshWIDlOF5uccGUpbT48VY7tZM/w3y+MGvtR50jf9DppbP0P
         jlQEraEJMntF8rGPlGup7Zu0FbH2hVmMq7nfTeRvJ02N7HTdGqZfKLU+SeIQD1RI4t
         o7MVmtfVkrvt688ZV+iYElzZocAq61fmdA8uAAHY=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x228w1p4015309
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 2 Mar 2019 02:58:01 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Sat, 2
 Mar 2019 02:58:00 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Sat, 2 Mar 2019 02:58:00 -0600
Received: from [172.22.217.208] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x228vtIn009809;
        Sat, 2 Mar 2019 02:57:56 -0600
Subject: Re: [PATCH v3] cfi: fix deadloop in cfi_cmdset_0002.c do_write_buffer
To:     Tokunori Ikegami <ikegami_to@yahoo.co.jp>,
        "'liujian (CE)'" <liujian56@huawei.com>
CC:     "'Boris Brezillon'" <boris.brezillon@collabora.com>,
        "'Tokunori Ikegami'" <ikegami.t@gmail.com>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "ikegami@allied-telesis.co.jp" <ikegami@allied-telesis.co.jp>,
        "richard@nod.at" <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>
References: <1551189648-58073-1-git-send-email-liujian56@huawei.com>
 <016001d4cf71$865e7b60$931b7220$@gmail.com>
 <4F88C5DDA1E80143B232E89585ACE27D0264F137@DGGEMM528-MBX.china.huawei.com>
 <20190228164228.734ede80@collabora.com>
 <005a01d4d03e$39b0e0f0$ad12a2d0$@yahoo.co.jp>
 <4b3bc01a-3632-5dde-f683-94744ee7179d@ti.com>
 <000501d4d050$38eca160$aac5e420$@gmail.com>
 <20190301184317.6bad546f@collabora.com>
 <001c01d4d057$f68572e0$e39058a0$@yahoo.co.jp>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <de75d4f6-dfff-26e0-e191-6240ffc20223@ti.com>
Date:   Sat, 2 Mar 2019 14:27:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <001c01d4d057$f68572e0$e39058a0$@yahoo.co.jp>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01-Mar-19 11:25 PM, Tokunori Ikegami wrote:
>>>> [...]
>>>>>>>>> In function do_write_buffer(), in the for loop, there is a
>>>>>>>>> case chip_ready() returns 1 while chip_good() returns 0, so
>>>>>>>>> it never break the loop.
>>>>>>>>> To fix this, chip_good() is enough and it should timeout if
>>>>>>>>> it stay bad for a while.
>>>>>>>>>
>>>>>>>>> Fixes: dfeae1073583("mtd: cfi_cmdset_0002: Change write
>>>>>>>>> buffer to check correct value")
>>>>>>>>> Signed-off-by: Yi Huaijie <yihuaijie@huawei.com>
>>>>>>>>> Signed-off-by: Liu Jian <liujian56@huawei.com>
>>>>>>>>> Reviewed-by: Tokunori Ikegami <ikegami_to@yahoo.co.jp>
>>>>>>>>> ---
>>>>>>>>> v2->v3:
>>>>>>>>> Follow Vignesh's advice:
>>>>>>>>> add one more check for check_good() even when time_after()
>>>>>>>>> returns
>>>>>> true.
>>>>>>>>>
>>>>>>>>>  drivers/mtd/chips/cfi_cmdset_0002.c | 2 +-
>>>>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/mtd/chips/cfi_cmdset_0002.c
>>>>>>>>> b/drivers/mtd/chips/cfi_cmdset_0002.c
>>>>>>>>> index 72428b6..3da2376 100644
>>>>>>>>> --- a/drivers/mtd/chips/cfi_cmdset_0002.c
>>>>>>>>> +++ b/drivers/mtd/chips/cfi_cmdset_0002.c
>>>>>>>>> @@ -1876,7 +1876,7 @@ static int __xipram
>>>>>>>>> do_write_buffer(struct map_info *map, struct flchip *chip,
>>>>>>>>>  			continue;
>>>>>>>>>  		}
>>>>>>>>>
>>>>>>>>> -		if (time_after(jiffies, timeo)
>>>>>>>>> && !chip_ready(map, adr))
>>>>>>>>> +		if (time_after(jiffies, timeo)
>>>>>>>>> && !chip_good(map, adr, datum))
>>>>>>>>
>>>>>>>>   Just another idea to understand easily.
>>>>>>>>
>>>>>>>>     unsigned long now = jiffies;
>>>>>>>>
>>>>>>>>     if (chip_good(map, adr, datum)) {
>>>>>>>>         xip_enable(map, chip, adr);
>>>>>>>>         goto op_done;
>>>>>>>>     }
>>>>>>>>
>>>>>>>>     if (time_after(now, timeo) {
>>>>>>>>         break;
>>>>>>>>     }
>>>>>>>>
>>>>>>>
>>>>>>> Thank you~. It is more easier to understand！
>>>>>>> If there are no other comments, I will send new patch again ):
>>>>>>
>>>>>> Except this version no longer does what Vignesh suggested. See
>>>>>> how you no longer test if chip_good() is true if time_after()
>>>>>> returns true. So, imagine the thread entering this function is
>>>>>> preempted just after the first chip_good() test, and resumed a
>>>>>> few ms later. time_after() will return true, but chip_good()
>>>>>> might also return true, and you ignore it.
>>>>>
>>>>> I think that the following 3 versions will be worked for
>>>>> time_after()
>>>> as a same result and follow the Vignesh-san suggestion.
>>>>>
>>>>
>>>> As Boris explained above version 3 does not really follow my
>>>> suggestion... Please see below
>>>>
>>>>> 1. Original Vignesh-san suggestion
>>>>>
>>>>> 	if (chip_good(map, adr, datum)) {
>>>>> 		xip_enable(map, chip, adr);
>>>>> 		goto op_done;
>>>>> 	}
>>>>>
>>>>> 	if (time_after(jiffies, timeo)) {
>>>>> 		/* Test chip_good() if TRUE incorrectly again so
>>>>> write
>>>> failure by time_after() can be avoided. */
>>>>> 		if (chip_good(map, adr, datum)) {
>>>>> 			xip_enable(map, chip, adr);
>>>>> 			goto op_done;
>>>>> 		}
>>>>> 		break;
>>>>> 	}
>>>>>
>>>>
>>>>
>>>> Right, here we check chip_good() once _even when time_after() is
>>>> true_ to avoid _spurious_ timeout
>>>>
>>>>> 2. Liujian-san v3 patch
>>>>>
>>>>> 	/* Test chip_good() if FALSE correctly so write failure
>>>>> by
>>>> time_after() can be avoided. */
>>>>> 	if (time_after(jiffies, timeo) && !chip_good(map, adr))
>>>>> 		break;
>>>>>
>>>>> 	if (chip_good(map, adr, datum)) {
>>>>> 		xip_enable(map, chip, adr);
>>>>> 		goto op_done;
>>>>> 	}
>>>>>
>>>>
>>>> This is a better version of 1
>>>>
>>>>> 3. My idea
>>>>>
>>>>> 	/* Save current jiffies value before chip_good() to avoid
>>>>> write
>>>> failure by time_after() without testing chip_good() again. */
>>>>> 	unsigned long now = jiffies;
>>>>>
>>>>> 	if (chip_good(map, adr, datum)) {
>>>>> 		xip_enable(map, chip, adr);
>>>>> 		goto op_done;
>>>>> 	}
>>>>>
>>>>
>>>> What if thread gets pre-empted at this point and is re-scheduled
>>>> exactly after timeo jiffies have elapsed? Below check would be true
>>>> and exit loop
>>>
>>>   I think that the jiffies value now is save before chip_good() so
>>> below check would be false and not exit loop.
>>

Ok, I get it now.

>> True, I overlooked that part, and so Vignesh did. This proves one
>> thing: code is not easier to follow with your version. IMO, if we want
>> to make things clear, we should add a comment to Liujian's explaining
>> why the extra test after time_after(jiffies, timeo) is needed.
> 
> I see so I am okay with the change of Liujian-san v3 patch.
> Also agree with the comment to be added.
> 

Right, I like the current patch from Liujian, because its more
consistent with the existing code in this file.

Liujian, Could you re-post with a comment added as suggested above?

Regards
Vignesh
