Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA159ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0D182089C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440087AbfJQOUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 10:20:41 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4216 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2440048AbfJQOUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 10:20:40 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5444352314939BFFAD81;
        Thu, 17 Oct 2019 22:20:29 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Thu, 17 Oct 2019
 22:20:23 +0800
Subject: Re: [PATCH V2] arm64: psci: Reduce waiting time of
 cpu_psci_cpu_kill()
To:     David Laight <David.Laight@ACULAB.COM>,
        Sudeep Holla <sudeep.holla@arm.com>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "wuyun.wu@huawei.com" <wuyun.wu@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "hushiyuan@huawei.com" <hushiyuan@huawei.com>,
        "linfeilong@huawei.com" <linfeilong@huawei.com>
References: <18068756-0f39-6388-3290-cf03746e767d@huawei.com>
 <9df267db-e647-a81d-16bb-b8bfb06c2624@huawei.com>
 <20191016153221.GA8978@bogus>
 <0f550044-9ed2-5f72-1335-73417678ba45@huawei.com>
 <c97c87b52f474463bc30ff8033a57e0c@AcuMS.aculab.com>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Message-ID: <1cd555f0-4074-36b7-8426-6f01130051d2@huawei.com>
Date:   Thu, 17 Oct 2019 22:19:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c97c87b52f474463bc30ff8033a57e0c@AcuMS.aculab.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.251.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/10/17 22:00, David Laight wrote:
> From: Yunfeng Ye
>> Sent: 17 October 2019 14:26
> ...
>>>> -	for (i = 0; i < 10; i++) {
>>>> +	i = 0;
>>>> +	timeout = jiffies + msecs_to_jiffies(100);
>>>> +	do {
>>>>  		err = psci_ops.affinity_info(cpu_logical_map(cpu), 0);
>>>>  		if (err == PSCI_0_2_AFFINITY_LEVEL_OFF) {
>>>>  			pr_info("CPU%d killed.\n", cpu);
>>>>  			return 0;
>>>>  		}
>>>>
>>>> -		msleep(10);
>>>> -		pr_info("Retrying again to check for CPU kill\n");
>>>
>>> You dropped this message, any particular reason ?
>>>
>> When reduce the time interval to 1ms, the print message maybe increase 10 times.
>> on the other hand, cpu_psci_cpu_kill() will print message on success or failure, which
>> this retry log is not very necessary. of cource, I think use pr_info_once() instead of
>> pr_info() is better.
> 
> Maybe you should print in on (say) the 10th time around the loop.
> 
Can it like this:
  pr_info("CPU%d killed with %d loops.\n", cpu, loops);

If put the number of waiting times in the successful printing message, it is
not necessary to print the "Retrying ..." message.

thanks.

> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 

