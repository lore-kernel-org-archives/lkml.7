Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC21ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B86C42089C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395218AbfJQOZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 10:25:03 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4217 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727671AbfJQOZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 10:25:03 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A4744BDAD13C9CDF3576;
        Thu, 17 Oct 2019 22:24:59 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Thu, 17 Oct 2019
 22:24:51 +0800
Subject: Re: [PATCH V2] arm64: psci: Reduce waiting time of
 cpu_psci_cpu_kill()
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     David Laight <David.Laight@ACULAB.COM>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "wuyun.wu@huawei.com" <wuyun.wu@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, <hushiyuan@huawei.com>,
        <linfeilong@huawei.com>
References: <18068756-0f39-6388-3290-cf03746e767d@huawei.com>
 <9df267db-e647-a81d-16bb-b8bfb06c2624@huawei.com>
 <20191016153221.GA8978@bogus>
 <0f550044-9ed2-5f72-1335-73417678ba45@huawei.com>
 <20191017135416.GA26312@bogus>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Message-ID: <0b3b8684-e840-ba32-6e42-d23fcadf7e65@huawei.com>
Date:   Thu, 17 Oct 2019 22:24:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191017135416.GA26312@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.251.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/10/17 21:54, Sudeep Holla wrote:
> On Thu, Oct 17, 2019 at 09:26:15PM +0800, Yunfeng Ye wrote:
>>
>>
>> On 2019/10/16 23:32, Sudeep Holla wrote:
>>> On Wed, Oct 09, 2019 at 12:45:16PM +0800, Yunfeng Ye wrote:
>>>> If psci_ops.affinity_info() fails, it will sleep 10ms, which will not
>>>> take so long in the right case. Use usleep_range() instead of msleep(),
>>>> reduce the waiting time, and give a chance to busy wait before sleep.
>>>>
>>>> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
>>>> ---
>>>> V1->V2:
>>>> - use usleep_range() instead of udelay() after waiting for a while
>>>>
>>>>  arch/arm64/kernel/psci.c | 17 +++++++++++++----
>>>>  1 file changed, 13 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
>>>> index c9f72b2..99b3122 100644
>>>> --- a/arch/arm64/kernel/psci.c
>>>> +++ b/arch/arm64/kernel/psci.c
>>>> @@ -82,6 +82,7 @@ static void cpu_psci_cpu_die(unsigned int cpu)
>>>>  static int cpu_psci_cpu_kill(unsigned int cpu)
>>>>  {
>>>>  	int err, i;
>>>> +	unsigned long timeout;
>>>>
>>>>  	if (!psci_ops.affinity_info)
>>>>  		return 0;
>>>> @@ -91,16 +92,24 @@ static int cpu_psci_cpu_kill(unsigned int cpu)
>>>>  	 * while it is dying. So, try again a few times.
>>>>  	 */
>>>>
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
>> When reduce the time interval to 1ms, the print message maybe increase 10
>> times. on the other hand, cpu_psci_cpu_kill() will print message on success
>> or failure, which this retry log is not very necessary. of cource, I think
>> use pr_info_once() instead of pr_info() is better.
>>
> 
> Yes changing it to pr_info_once is better than dropping it as it gives
> some indication to the firmware if there's scope for improvement.
> 
>>>> -	}
>>>> +		/* busy-wait max 1ms */
>>>> +		if (i++ < 100) {
>>>> +			cond_resched();
>>>> +			udelay(10);
>>>> +			continue;
>>>
>>> Why can't it be simple like loop of 100 * msleep(1) instead of loop of
>>> 10 * msleep(10). The above initial busy wait for 1 ms looks too much
>>> optimised for your setup where it takes 50-500us, what if it take just
>>> over 1 ms ?
>>>
>> msleep() is implemented by jiffies. when HZ=100 or HZ=250, msleep(1) is not
>> accurate. so I think usleep_range() is better. 1 ms looks simple and good, but how
>> about 100us is better? I refer a function sunxi_mc_smp_cpu_kill(), it use
>> usleep_range(50, 100).
>>
> 
> Again that's specific to sunxi platforms and may work well. While I agree
> msleep(1) may not be accurate, I am still inclined to have a max value
> of 1000(i.e. 1ms) for usleep_range.
> 
ok, I will send a new version patch that waiting max 1ms.
thanks.

> --
> Regards,
> Sudeep
> 
> .
> 

