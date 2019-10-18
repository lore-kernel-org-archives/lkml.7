Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133CFCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 12:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E105721D7C
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 12:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407830AbfJRMDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 08:03:43 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4689 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392487AbfJRMDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 08:03:43 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 48475E0CF41259E163D3;
        Fri, 18 Oct 2019 20:03:40 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Fri, 18 Oct 2019
 20:03:31 +0800
Subject: Re: [PATCH V3] arm64: psci: Reduce waiting time for
 cpu_psci_cpu_kill()
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <kstewart@linuxfoundation.org>, <gregkh@linuxfoundation.org>,
        <lorenzo.pieralisi@arm.com>, <tglx@linutronix.de>,
        <David.Laight@ACULAB.COM>, <ard.biesheuvel@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "hushiyuan@huawei.com" <hushiyuan@huawei.com>,
        <wuyun.wu@huawei.com>,
        "linfeilong@huawei.com" <linfeilong@huawei.com>
References: <433980c7-f246-f741-f00c-fce103a60af7@huawei.com>
 <20191018114529.GA15116@bogus>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Message-ID: <0baccab6-9804-7b59-0ad6-765af7980714@huawei.com>
Date:   Fri, 18 Oct 2019 20:03:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191018114529.GA15116@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.251.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/10/18 19:45, Sudeep Holla wrote:
> On Fri, Oct 18, 2019 at 07:24:14PM +0800, Yunfeng Ye wrote:
>> In a case like suspend-to-disk, a large number of CPU cores need to be
> 
> Add suspend-to-ram also to list, i.e.
> "In case like suspend-to-disk and suspend-to-ram, a large number..."
> 
ok, thanks.

>> shut down. At present, the CPU hotplug operation is serialised, and the
>> CPU cores can only be shut down one by one. In this process, if PSCI
>> affinity_info() does not return LEVEL_OFF quickly, cpu_psci_cpu_kill()
>> needs to wait for 10ms. If hundreds of CPU cores need to be shut down,
>> it will take a long time.
>>
>> Normally, it is no need to wait 10ms in cpu_psci_cpu_kill(). So change
> 
> s/it is/there is/
> 
ok, thanks.

>> the wait interval from 10 ms to max 1 ms and use usleep_range() instead
>> of msleep() for more accurate schedule.
>>
> 
> s/for more accurate schedule/for more accurate timer/
> 
ok, thanks.

>> In addition, reduce the time interval will increase the messages output,
> 
> s/reduce/reducing/
> 
ok, thanks.

>> so remove the "Retry ..." message, instead, put the number of waiting
>> times to the sucessful message.
>>
>> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
>> ---
>> v2 -> v3:
>>  - update the comment
>>  - remove the busy-wait logic, modify the loop logic and output message
>>
>> v1 -> v2:
>>  - use usleep_range() instead of udelay() after waiting for a while
>>
>>  arch/arm64/kernel/psci.c | 7 +++----
>>  1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
>> index c9f72b2665f1..00b8c0825a08 100644
>> --- a/arch/arm64/kernel/psci.c
>> +++ b/arch/arm64/kernel/psci.c
>> @@ -91,15 +91,14 @@ static int cpu_psci_cpu_kill(unsigned int cpu)
>>  	 * while it is dying. So, try again a few times.
>>  	 */
>>
>> -	for (i = 0; i < 10; i++) {
>> +	for (i = 0; i < 100; i++) {
>>  		err = psci_ops.affinity_info(cpu_logical_map(cpu), 0);
>>  		if (err == PSCI_0_2_AFFINITY_LEVEL_OFF) {
>> -			pr_info("CPU%d killed.\n", cpu);
>> +			pr_info("CPU%d killed by waiting %d loops.\n", cpu, i);
>>  			return 0;
>>  		}
>>
>> -		msleep(10);
>> -		pr_info("Retrying again to check for CPU kill\n");
>> +		usleep_range(100, 1000);
> 
> Since usleep_range can return anytime between 100us to 1ms, does it make
> sense to check for (time_before(jiffies, timeout)) you had in v2 ?
> 
ok, if using (time_before(jiffies, timeout)), the output message change to print
waiting xxx jiffies ? or still print the number of loops?

> --
> Regards,
> Sudeep
> 
> .
> 

