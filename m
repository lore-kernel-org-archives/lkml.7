Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4FEC47404
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 02:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F86720867
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 02:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729833AbfJHCeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 22:34:37 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3266 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729212AbfJHCeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 22:34:37 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6D5EA265082CC7F488AD;
        Tue,  8 Oct 2019 10:34:35 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Tue, 8 Oct 2019
 10:34:31 +0800
Subject: Re: [PATCH v2] arm64: armv8_deprecated: Checking return value for
 memory allocation
To:     Will Deacon <will@kernel.org>
CC:     <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <kstewart@linuxfoundation.org>, <gregkh@linuxfoundation.org>,
        <tglx@linutronix.de>, <info@metux.net>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <bd558d56-18a9-3607-3db0-ad203ab12aa8@huawei.com>
 <20191007153710.7xpx27kgeewz75kt@willie-the-truck>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Message-ID: <e58c36f6-23e3-12b2-bd9c-1ef731b5f8fd@huawei.com>
Date:   Tue, 8 Oct 2019 10:33:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191007153710.7xpx27kgeewz75kt@willie-the-truck>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.251.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/10/7 23:37, Will Deacon wrote:
> On Mon, Oct 07, 2019 at 06:06:35PM +0800, Yunfeng Ye wrote:
>> There are no return value checking when using kzalloc() and kcalloc() for
>> memory allocation. so add it.
>>
>> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
>> ---
>> v1 -> v2:
>>  - return error code when memory allocation failure
>>
>>  arch/arm64/kernel/armv8_deprecated.c | 57 +++++++++++++++++++++++++++---------
>>  1 file changed, 43 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
>> index 2ec09de..2284fcb 100644
>> --- a/arch/arm64/kernel/armv8_deprecated.c
>> +++ b/arch/arm64/kernel/armv8_deprecated.c
>> @@ -168,12 +168,15 @@ static int update_insn_emulation_mode(struct insn_emulation *insn,
>>  	return ret;
>>  }
>>
>> -static void __init register_insn_emulation(struct insn_emulation_ops *ops)
>> +static int __init register_insn_emulation(struct insn_emulation_ops *ops)
>>  {
>>  	unsigned long flags;
>>  	struct insn_emulation *insn;
>>
>>  	insn = kzalloc(sizeof(*insn), GFP_KERNEL);
>> +	if (!insn)
>> +		return -ENOMEM;
>> +
>>  	insn->ops = ops;
>>  	insn->min = INSN_UNDEF;
>>
>> @@ -197,6 +200,7 @@ static void __init register_insn_emulation(struct insn_emulation_ops *ops)
>>
>>  	/* Register any handlers if required */
>>  	update_insn_emulation_mode(insn, INSN_UNDEF);
>> +	return 0;
>>  }
>>
>>  static int emulation_proc_handler(struct ctl_table *table, int write,
>> @@ -224,7 +228,7 @@ static int emulation_proc_handler(struct ctl_table *table, int write,
>>  	return ret;
>>  }
>>
>> -static void __init register_insn_emulation_sysctl(void)
>> +static int __init register_insn_emulation_sysctl(void)
>>  {
>>  	unsigned long flags;
>>  	int i = 0;
>> @@ -233,6 +237,8 @@ static void __init register_insn_emulation_sysctl(void)
>>
>>  	insns_sysctl = kcalloc(nr_insn_emulated + 1, sizeof(*sysctl),
>>  			       GFP_KERNEL);
>> +	if (!insns_sysctl)
>> +		return -ENOMEM;
>>
>>  	raw_spin_lock_irqsave(&insn_emulation_lock, flags);
>>  	list_for_each_entry(insn, &insn_emulation, node) {
>> @@ -251,6 +257,7 @@ static void __init register_insn_emulation_sysctl(void)
>>  	raw_spin_unlock_irqrestore(&insn_emulation_lock, flags);
>>
>>  	register_sysctl("abi", insns_sysctl);
>> +	return 0;
>>  }
>>
>>  /*
>> @@ -617,25 +624,47 @@ static int t16_setend_handler(struct pt_regs *regs, u32 instr)
>>   */
>>  static int __init armv8_deprecated_init(void)
>>  {
>> -	if (IS_ENABLED(CONFIG_SWP_EMULATION))
>> -		register_insn_emulation(&swp_ops);
>> +	int ret = 0;
>> +	int err = 0;
>> +
>> +	if (IS_ENABLED(CONFIG_SWP_EMULATION)) {
>> +		ret = register_insn_emulation(&swp_ops);
>> +		if (ret) {
>> +			pr_err("register insn emulation swp: fail\n");
>> +			err = ret;
>> +		}
>> +	}
> 
> Is there much point in continuing here? May as well just return ret, I
> think. I also don't think you need to print anything, since kmalloc
> should already have shouted.
> 
The registration of each instruction simulation is independent. I think
that one failure does not affect the registration of other instructions.
In addition, if return directly, is it need to unregister? Of course,
the first instruction registration can be directly returned, If the
following instruction registration fails, is it need unregister operation?
currently the unregistration of instruction simulation is not be implemented
yet.

The purpose of printing information is to replace the direct return, which
can distinguish which instruction failed to register. There is no need to print
information if it returns directly.

thanks.

>> -	if (IS_ENABLED(CONFIG_CP15_BARRIER_EMULATION))
>> -		register_insn_emulation(&cp15_barrier_ops);
>> +	if (IS_ENABLED(CONFIG_CP15_BARRIER_EMULATION)) {
>> +		ret = register_insn_emulation(&cp15_barrier_ops);
>> +		if (ret) {
>> +			pr_err("register insn emulation cpu15_barrier: fail\n");
>> +			err = ret;
>> +		}
>> +	}
>>
>>  	if (IS_ENABLED(CONFIG_SETEND_EMULATION)) {
>> -		if(system_supports_mixed_endian_el0())
>> -			register_insn_emulation(&setend_ops);
>> -		else
>> +		if (system_supports_mixed_endian_el0()) {
>> +			ret = register_insn_emulation(&setend_ops);
>> +			if (ret) {
>> +				pr_err("register insn emulation setend: fail\n");
>> +				err = ret;
>> +			}
>> +		} else {
>>  			pr_info("setend instruction emulation is not supported on this system\n");
>> +		}
>>  	}
>>
>> -	cpuhp_setup_state_nocalls(CPUHP_AP_ARM64_ISNDEP_STARTING,
>> -				  "arm64/isndep:starting",
>> -				  run_all_insn_set_hw_mode, NULL);
>> -	register_insn_emulation_sysctl();
>> +	if (nr_insn_emulated) {
>> +		cpuhp_setup_state_nocalls(CPUHP_AP_ARM64_ISNDEP_STARTING,
>> +					  "arm64/isndep:starting",
>> +					  run_all_insn_set_hw_mode, NULL);
>> +		ret = register_insn_emulation_sysctl();
>> +		if (ret)
>> +			err = ret;
>> +	}
> 
> I'm dubious about leaving the cpuhp notifier registered if we fail here.
> Can we simply reorder the logic so that the notifier is registered after
> successfully calling register_insn_emulation_sysctl()? thanks.
> 
ok, I will reorder the logic.
And the same question: is it need to unregister the instruction emulation
if register_insn_emulation_sysctl() invoked fail?

> Will
> 
> .
> 

