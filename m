Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0528CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 07:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8612320830
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 07:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbfJUHr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 03:47:29 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4693 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726480AbfJUHr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 03:47:29 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 855B6BB6E5538F4C3F30;
        Mon, 21 Oct 2019 15:47:26 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Mon, 21 Oct 2019
 15:47:20 +0800
Subject: Re: [PATCH v4] arm64: psci: Reduce the waiting time for
 cpu_psci_cpu_kill()
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <kstewart@linuxfoundation.org>, <gregkh@linuxfoundation.org>,
        <lorenzo.pieralisi@arm.com>, <tglx@linutronix.de>,
        <David.Laight@ACULAB.COM>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <hushiyuan@huawei.com>,
        <wuyun.wu@huawei.com>, <linfeilong@huawei.com>
References: <04ab51e4-bc08-8250-4e70-4c87c58c8ad0@huawei.com>
 <20191018152052.GA10312@bogus>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Message-ID: <e5304bb1-e031-7c40-37f8-605b0ae2f869@huawei.com>
Date:   Mon, 21 Oct 2019 15:47:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191018152052.GA10312@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.251.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/10/18 23:20, Sudeep Holla wrote:
> On Fri, Oct 18, 2019 at 08:46:37PM +0800, Yunfeng Ye wrote:
>> In case like suspend-to-disk and uspend-to-ram, a large number of CPU
> 
> s/case/cases/
> s/uspend-to-ram/suspend-to-ram/
> 
ok, thanks.

>> cores need to be shut down. At present, the CPU hotplug operation is
>> serialised, and the CPU cores can only be shut down one by one. In this
>> process, if PSCI affinity_info() does not return LEVEL_OFF quickly,
>> cpu_psci_cpu_kill() needs to wait for 10ms. If hundreds of CPU cores
>> need to be shut down, it will take a long time.
>>
>> Normally, there is no need to wait 10ms in cpu_psci_cpu_kill(). So
>> change the wait interval from 10 ms to max 1 ms and use usleep_range()
>> instead of msleep() for more accurate timer.
>>
>> In addition, reducing the time interval will increase the messages
>> output, so remove the "Retry ..." message, instead, put the number of
>> waiting times to the sucessful message.
>>
>> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
>> ---
>> v3 -> v4:
>>  - using time_before(jiffies, timeout) to check
>>  - update the comment as review suggest
>>
>> v2 -> v3:
>>  - update the comment
>>  - remove the busy-wait logic, modify the loop logic and output message
>>
>> v1 -> v2:
>>  - use usleep_range() instead of udelay() after waiting for a while
>>  arch/arm64/kernel/psci.c | 14 ++++++++------
>>  1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
>> index c9f72b2665f1..77965c3ba477 100644
>> --- a/arch/arm64/kernel/psci.c
>> +++ b/arch/arm64/kernel/psci.c
>> @@ -81,7 +81,8 @@ static void cpu_psci_cpu_die(unsigned int cpu)
>>
>>  static int cpu_psci_cpu_kill(unsigned int cpu)
>>  {
>> -	int err, i;
>> +	int err, i = 0;
>> +	unsigned long timeout;
>>
>>  	if (!psci_ops.affinity_info)
>>  		return 0;
>> @@ -91,16 +92,17 @@ static int cpu_psci_cpu_kill(unsigned int cpu)
>>  	 * while it is dying. So, try again a few times.
>>  	 */
>>
>> -	for (i = 0; i < 10; i++) {
>> +	timeout = jiffies + msecs_to_jiffies(100);
>> +	do {
>> +		i++;
>>  		err = psci_ops.affinity_info(cpu_logical_map(cpu), 0);
>>  		if (err == PSCI_0_2_AFFINITY_LEVEL_OFF) {
>> -			pr_info("CPU%d killed.\n", cpu);
>> +			pr_info("CPU%d killed (polled %d times)\n", cpu, i);
> 
> We can even drop loop counter completely, track time and log that
> instead of loop counter that doesn't give any indication without looking
> into the code.
> 
ok, I will modify as your suggest. thanks.

> 	start = jiffies, end = start + msecs_to_jiffies(100);
> 	do {
> 			....
> 			pr_info("CPU%d killed (polled %u ms)\n", cpu,
> 				jiffies_to_msecs(jiffies - start));
> 			....
> 	} while (time_before(jiffies, end));
> 
> Just my preference. Looks good otherwise.
> 
> --
> Regards,
> Sudeep
> 
> 
> .
> 

