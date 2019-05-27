Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A1B1C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 07:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DA7C2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 07:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbfE0HO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 03:14:59 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17163 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725940AbfE0HO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 03:14:59 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9B8B216F5327146B6375;
        Mon, 27 May 2019 15:14:56 +0800 (CST)
Received: from [127.0.0.1] (10.74.221.148) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Mon, 27 May 2019
 15:14:50 +0800
Subject: Re: [PATCH v3 2/2] arm64: cacheinfo: Update cache_line_size detected
 from DT or PPTT
To:     Greg KH <gregkh@linuxfoundation.org>
References: <1558922768-29155-1-git-send-email-zhangshaokun@hisilicon.com>
 <1558922768-29155-2-git-send-email-zhangshaokun@hisilicon.com>
 <20190527060829.GA8106@kroah.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Zhenfa Qiu <qiuzhenfa@hisilicon.com>
From:   Zhangshaokun <zhangshaokun@hisilicon.com>
Message-ID: <dd27d90c-e712-7aa5-b647-925042bb8669@hisilicon.com>
Date:   Mon, 27 May 2019 15:14:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <20190527060829.GA8106@kroah.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.221.148]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 2019/5/27 14:08, Greg KH wrote:
> On Mon, May 27, 2019 at 10:06:08AM +0800, Shaokun Zhang wrote:
>> cache_line_size is derived from CTR_EL0.CWG field and is called mostly
>> for I/O device drivers. For HiSilicon certain plantform, like the
>> Kunpeng920 server SoC, cache line sizes are different between L1/2
>> cache and L3 cache while L1 cache line size is 64-byte and L3 is 128-byte,
>> but CTR_EL0.CWG is misreporting using L1 cache line size.
>>
>> We shall correct the right value which is important for I/O performance.
>> Let's update the cache line size if it is detected from DT or PPTT
>> information.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>> Cc: Jeremy Linton <jeremy.linton@arm.com>
>> Cc: Zhenfa Qiu <qiuzhenfa@hisilicon.com>
>> Reported-by: Zhenfa Qiu <qiuzhenfa@hisilicon.com>
>> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
>> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
>> ---
>>  arch/arm64/include/asm/cache.h |  6 +-----
>>  arch/arm64/kernel/cacheinfo.c  | 11 +++++++++++
>>  2 files changed, 12 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
>> index 926434f413fa..758af6340314 100644
>> --- a/arch/arm64/include/asm/cache.h
>> +++ b/arch/arm64/include/asm/cache.h
>> @@ -91,11 +91,7 @@ static inline u32 cache_type_cwg(void)
>>  
>>  #define __read_mostly __attribute__((__section__(".data..read_mostly")))
>>  
>> -static inline int cache_line_size(void)
>> -{
>> -	u32 cwg = cache_type_cwg();
>> -	return cwg ? 4 << cwg : ARCH_DMA_MINALIGN;
>> -}
>> +int cache_line_size(void);
>>  
>>  /*
>>   * Read the effective value of CTR_EL0.
>> diff --git a/arch/arm64/kernel/cacheinfo.c b/arch/arm64/kernel/cacheinfo.c
>> index 0bf0a835122f..3d54b0024246 100644
>> --- a/arch/arm64/kernel/cacheinfo.c
>> +++ b/arch/arm64/kernel/cacheinfo.c
>> @@ -28,6 +28,17 @@
>>  #define CLIDR_CTYPE(clidr, level)	\
>>  	(((clidr) & CLIDR_CTYPE_MASK(level)) >> CLIDR_CTYPE_SHIFT(level))
>>  
>> +int cache_line_size(void)
>> +{
>> +	u32 cwg = cache_type_cwg();
>> +
>> +	if (coherency_max_size != 0)
>> +		return coherency_max_size;
> 
> Ah, you use it here.
> 

Yeah, we check it here.

>> +
>> +	return cwg ? 4 << cwg : ARCH_DMA_MINALIGN;
> 
> Shouldn't you set the variable if it is 0 here as well?
> 

As discussed this with Catalin,
https://www.spinics.net/lists/arm-kernel/msg723848.html

I think it is unnecessary, if coherency_max_size is not detected from firmware,
We will return the cpu core reporting value as the cache line size and
coherency_max_size won't be used in other place.

>> +}
>> +EXPORT_SYMBOL(cache_line_size);
> 
> EXPORT_SYMBOL_GPL()?
> 

Ok.

Thanks,
Shaokun

> thanks,
> 
> greg k-h
> 
> .
> 

