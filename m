Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA892C4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 03:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98FC82086A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 03:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390892AbfJPDWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 23:22:42 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4161 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726973AbfJPDWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 23:22:42 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 717D118A858FF1708FEE;
        Wed, 16 Oct 2019 11:22:39 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Wed, 16 Oct 2019
 11:22:31 +0800
Subject: Re: [PATCH V2] arm64: psci: Reduce waiting time of
 cpu_psci_cpu_kill()
To:     Will Deacon <will@kernel.org>, <sudeep.holla@arm.com>
CC:     David Laight <David.Laight@ACULAB.COM>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wuyun.wu@huawei.com" <wuyun.wu@huawei.com>,
        <hushiyuan@huawei.com>, <linfeilong@huawei.com>
References: <18068756-0f39-6388-3290-cf03746e767d@huawei.com>
 <20191015162358.bt5rffidkv2j4xqb@willie-the-truck>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Message-ID: <ab42357e-f4f9-9019-e8d9-7e9bfe106e9e@huawei.com>
Date:   Wed, 16 Oct 2019 11:22:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191015162358.bt5rffidkv2j4xqb@willie-the-truck>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.251.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/10/16 0:23, Will Deacon wrote:
> Hi,
> 
> On Sat, Sep 21, 2019 at 07:21:17PM +0800, Yunfeng Ye wrote:
>> If psci_ops.affinity_info() fails, it will sleep 10ms, which will not
>> take so long in the right case. Use usleep_range() instead of msleep(),
>> reduce the waiting time, and give a chance to busy wait before sleep.
> 
> Can you elaborate on "the right case" please? It's not clear to me
> exactly what problem you're solving here.
> 
The situation is that when the power is off, we have a battery to save some
information, but the battery power is limited, so we reduce the power consumption
by turning off the cores, and need fastly to complete the core shutdown. However, the
time of cpu_psci_cpu_kill() will take 10ms. We have tested the time that it does not
need 10ms, and most case is about 50us-500us. if we reduce the time of cpu_psci_cpu_kill(),
we can reduce 10% - 30% of the total time.

So change msleep (10) to usleep_range() to reduce the waiting time. In addition,
we don't want to be scheduled during the sleeping time, some threads may take a
long time and don't give up the CPU, which affects the time of core shutdown,
Therefore, we add a chance to busy-wait max 1ms.

thanks.

> I've also added Sudeep to the thread, since I'd like his ack on the change.
> 
> Will
> 
>>  arch/arm64/kernel/psci.c | 17 +++++++++++++----
>>  1 file changed, 13 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
>> index c9f72b2..99b3122 100644
>> --- a/arch/arm64/kernel/psci.c
>> +++ b/arch/arm64/kernel/psci.c
>> @@ -82,6 +82,7 @@ static void cpu_psci_cpu_die(unsigned int cpu)
>>  static int cpu_psci_cpu_kill(unsigned int cpu)
>>  {
>>  	int err, i;
>> +	unsigned long timeout;
>>
>>  	if (!psci_ops.affinity_info)
>>  		return 0;
>> @@ -91,16 +92,24 @@ static int cpu_psci_cpu_kill(unsigned int cpu)
>>  	 * while it is dying. So, try again a few times.
>>  	 */
>>
>> -	for (i = 0; i < 10; i++) {
>> +	i = 0;
>> +	timeout = jiffies + msecs_to_jiffies(100);
>> +	do {
>>  		err = psci_ops.affinity_info(cpu_logical_map(cpu), 0);
>>  		if (err == PSCI_0_2_AFFINITY_LEVEL_OFF) {
>>  			pr_info("CPU%d killed.\n", cpu);
>>  			return 0;
>>  		}
>>
>> -		msleep(10);
>> -		pr_info("Retrying again to check for CPU kill\n");
>> -	}
>> +		/* busy-wait max 1ms */
>> +		if (i++ < 100) {
>> +			cond_resched();
>> +			udelay(10);
>> +			continue;
>> +		}
>> +
>> +		usleep_range(100, 1000);
>> +	} while (time_before(jiffies, timeout));
>>
>>  	pr_warn("CPU%d may not have shut down cleanly (AFFINITY_INFO reports %d)\n",
>>  			cpu, err);
>> -- 
>> 2.7.4.huawei.3
>>
> 
> .
> 

