Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2125DC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 15:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F091D2067B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 15:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389117AbfIPP0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 11:26:38 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51998 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726389AbfIPP0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 11:26:37 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A8D59719CC43F681D61C;
        Mon, 16 Sep 2019 23:26:32 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Mon, 16 Sep 2019
 23:26:25 +0800
Subject: Re: [PATCH] arm64: psci: Use udelay() instead of msleep() to reduce
 waiting time
To:     David Laight <David.Laight@ACULAB.COM>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>
CC:     "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wuyun.wu@huawei.com" <wuyun.wu@huawei.com>
References: <e4d42bda-72f2-4002-f319-1cbe2bff74d2@huawei.com>
 <18c9fd22d72d4ea1a11e800e8873dd8d@AcuMS.aculab.com>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Message-ID: <bf4ab998-00af-1638-0ab4-64f3ea02568c@huawei.com>
Date:   Mon, 16 Sep 2019 23:26:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <18c9fd22d72d4ea1a11e800e8873dd8d@AcuMS.aculab.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.251.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/9/12 16:48, David Laight wrote:
> From: Yunfeng Ye
>> Sent: 11 September 2019 09:50
>> We want to reduce the time of cpu_down() for saving power, found that
>> cpu_psci_cpu_kill() cost 10ms after psci_ops.affinity_info() fail.
>>
>> Normally the time cpu dead is very short, it is no need to wait 10ms.
>> so use udelay 10us to instead msleep 10ms in every waiting loop, and add
>> cond_resched() to give a chance to run a higher-priority process.
>>
>> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
>> ---
>>  arch/arm64/kernel/psci.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
>> index 85ee7d0..9e9d8a6 100644
>> --- a/arch/arm64/kernel/psci.c
>> +++ b/arch/arm64/kernel/psci.c
>> @@ -86,15 +86,15 @@ static int cpu_psci_cpu_kill(unsigned int cpu)
>>  	 * while it is dying. So, try again a few times.
>>  	 */
>>
>> -	for (i = 0; i < 10; i++) {
>> +	for (i = 0; i < 10000; i++) {
>>  		err = psci_ops.affinity_info(cpu_logical_map(cpu), 0);
>>  		if (err == PSCI_0_2_AFFINITY_LEVEL_OFF) {
>>  			pr_info("CPU%d killed.\n", cpu);
>>  			return 0;
>>  		}
>>
>> -		msleep(10);
>> -		pr_info("Retrying again to check for CPU kill\n");
>> +		cond_resched();
>> +		udelay(10);
> 
> You really don't want to be doing 10000 udelay(10) before giving up.
> 
> If udelay(10) is long enough for the normal case, then do that once.
> After that use usleep_range().
> > 	David
> 
Thanks for your advice. the delay depend on the num of cores, range
from 50us to 500us, I have test the time on the 140+ cores cpu：

  (10us every time)
  [ 1177.979642] psci: CPU1 killed. total wait 4 times
  [ 1178.011369] psci: CPU2 killed. total wait 6 times
  [ 1178.035247] psci: CPU3 killed. total wait 3 times
  [ 1178.071134] psci: CPU4 killed. total wait 8 times
  ......
  [ 1190.128202] psci: CPU139 killed. total wait 50 times
  [ 1190.156266] psci: CPU140 killed. total wait 48 times
  [ 1190.192082] psci: CPU141 killed. total wait 46 times
  [ 1190.224104] psci: CPU142 killed. total wait 46 times

Can I bust-wait 1ms，which is 100 tiems udelay(10), after that, use
usleep_range(1000, 10000) ?  I don't want other process occupy cpu
for a long time when I let out the cpu. thanks.

> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 

