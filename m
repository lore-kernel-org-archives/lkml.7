Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E208C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8FF120818
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QfosMyAG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389177AbfCAQsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 11:48:43 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:47820 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728285AbfCAQsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 11:48:42 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x21Gm2dA087945;
        Fri, 1 Mar 2019 10:48:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1551458882;
        bh=+Yz0uiTf07O3FtCAB7jVc9+niTq+LKff5BwRnHvkvdw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=QfosMyAG9oj0+25rtvwPdPXW+EH277e79rHnQuRwkTiX/8dNRhlyYex4x/molZpyg
         xEQS2ZQZOlA0lnLmHgQInsi/wO+nuSQ0ShNruZLZx3sQf7XTS9jKuA9hmLkA3pz7QQ
         gqhAlDKHYSj7wAn9ypABuUJuSeQCyEGcQoaJkJpM=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x21Gm2S7052275
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 Mar 2019 10:48:02 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 1
 Mar 2019 10:48:01 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 1 Mar 2019 10:48:01 -0600
Received: from [172.22.218.108] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x21Glt8a007743;
        Fri, 1 Mar 2019 10:47:56 -0600
Subject: Re: [PATCH v3] cfi: fix deadloop in cfi_cmdset_0002.c do_write_buffer
To:     Tokunori Ikegami <ikegami_to@yahoo.co.jp>,
        "'Boris Brezillon'" <boris.brezillon@collabora.com>,
        "'liujian (CE)'" <liujian56@huawei.com>
CC:     "'Tokunori Ikegami'" <ikegami.t@gmail.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "ikegami@allied-telesis.co.jp" <ikegami@allied-telesis.co.jp>,
        "richard@nod.at" <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>
References: <1551189648-58073-1-git-send-email-liujian56@huawei.com>
 <016001d4cf71$865e7b60$931b7220$@gmail.com>
 <4F88C5DDA1E80143B232E89585ACE27D0264F137@DGGEMM528-MBX.china.huawei.com>
 <20190228164228.734ede80@collabora.com>
 <005a01d4d03e$39b0e0f0$ad12a2d0$@yahoo.co.jp>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <4b3bc01a-3632-5dde-f683-94744ee7179d@ti.com>
Date:   Fri, 1 Mar 2019 22:17:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <005a01d4d03e$39b0e0f0$ad12a2d0$@yahoo.co.jp>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]
>>>>> In function do_write_buffer(), in the for loop, there is a case
>>>>> chip_ready() returns 1 while chip_good() returns 0, so it never break
>>>>> the loop.
>>>>> To fix this, chip_good() is enough and it should timeout if it stay
>>>>> bad for a while.
>>>>>
>>>>> Fixes: dfeae1073583("mtd: cfi_cmdset_0002: Change write buffer to
>>>>> check correct value")
>>>>> Signed-off-by: Yi Huaijie <yihuaijie@huawei.com>
>>>>> Signed-off-by: Liu Jian <liujian56@huawei.com>
>>>>> Reviewed-by: Tokunori Ikegami <ikegami_to@yahoo.co.jp>
>>>>> ---
>>>>> v2->v3:
>>>>> Follow Vignesh's advice:
>>>>> add one more check for check_good() even when time_after() returns
>> true.
>>>>>
>>>>>  drivers/mtd/chips/cfi_cmdset_0002.c | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/mtd/chips/cfi_cmdset_0002.c
>>>>> b/drivers/mtd/chips/cfi_cmdset_0002.c
>>>>> index 72428b6..3da2376 100644
>>>>> --- a/drivers/mtd/chips/cfi_cmdset_0002.c
>>>>> +++ b/drivers/mtd/chips/cfi_cmdset_0002.c
>>>>> @@ -1876,7 +1876,7 @@ static int __xipram do_write_buffer(struct
>>>>> map_info *map, struct flchip *chip,
>>>>>  			continue;
>>>>>  		}
>>>>>
>>>>> -		if (time_after(jiffies, timeo) && !chip_ready(map, adr))
>>>>> +		if (time_after(jiffies, timeo) && !chip_good(map, adr,
>>>>> datum))
>>>>
>>>>   Just another idea to understand easily.
>>>>
>>>>     unsigned long now = jiffies;
>>>>
>>>>     if (chip_good(map, adr, datum)) {
>>>>         xip_enable(map, chip, adr);
>>>>         goto op_done;
>>>>     }
>>>>
>>>>     if (time_after(now, timeo) {
>>>>         break;
>>>>     }
>>>>
>>>
>>> Thank you~. It is more easier to understand！
>>> If there are no other comments, I will send new patch again ):
>>
>> Except this version no longer does what Vignesh suggested. See how you
>> no longer test if chip_good() is true if time_after() returns true. So,
>> imagine the thread entering this function is preempted just after the
>> first chip_good() test, and resumed a few ms later. time_after() will
>> return true, but chip_good() might also return true, and you ignore it.
> 
> I think that the following 3 versions will be worked for time_after() as a same result and follow the Vignesh-san suggestion.
> 

As Boris explained above version 3 does not really follow my
suggestion... Please see below

> 1. Original Vignesh-san suggestion
> 
> 	if (chip_good(map, adr, datum)) {
> 		xip_enable(map, chip, adr);
> 		goto op_done;
> 	}
> 
> 	if (time_after(jiffies, timeo)) {
> 		/* Test chip_good() if TRUE incorrectly again so write failure by time_after() can be avoided. */
> 		if (chip_good(map, adr, datum)) {
> 			xip_enable(map, chip, adr);
> 			goto op_done;
> 		}
> 		break;
> 	}
> 


Right, here we check chip_good() once _even when time_after() is true_
to avoid _spurious_ timeout

> 2. Liujian-san v3 patch
> 
> 	/* Test chip_good() if FALSE correctly so write failure by time_after() can be avoided. */
> 	if (time_after(jiffies, timeo) && !chip_good(map, adr))
> 		break;
> 
> 	if (chip_good(map, adr, datum)) {
> 		xip_enable(map, chip, adr);
> 		goto op_done;
> 	}
> 

This is a better version of 1

> 3. My idea
> 
> 	/* Save current jiffies value before chip_good() to avoid write failure by time_after() without testing chip_good() again. */
> 	unsigned long now = jiffies;
> 
> 	if (chip_good(map, adr, datum)) {
> 		xip_enable(map, chip, adr);
> 		goto op_done;
> 	}
> 

What if thread gets pre-empted at this point and is re-scheduled exactly
after timeo jiffies have elapsed? Below check would be true and exit loop

> 	if (time_after(now, timeo))
> 		break;
> 

So, code does not check for check chip_good() after timeoout has
elapsed. But chip_good() might be true at this point. Therefore leading
to spurious timeout.  So this version is still not right.

>           Note: Some brackets have been fixed from the previous mail.
> 
