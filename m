Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546DAC10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 11:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B952070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 11:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730407AbfJHLBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 07:01:35 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3221 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729790AbfJHLBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 07:01:35 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 03AEDD409179B17EE88B;
        Tue,  8 Oct 2019 19:01:31 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Tue, 8 Oct 2019
 19:01:30 +0800
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
 <e58c36f6-23e3-12b2-bd9c-1ef731b5f8fd@huawei.com>
 <20191008102511.pmkqcpf7spkogarp@willie-the-truck>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Message-ID: <7b70fec7-e232-0d09-fd51-1fdd205823b8@huawei.com>
Date:   Tue, 8 Oct 2019 19:01:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191008102511.pmkqcpf7spkogarp@willie-the-truck>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.251.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/10/8 18:25, Will Deacon wrote:
> On Tue, Oct 08, 2019 at 10:33:17AM +0800, Yunfeng Ye wrote:
>> On 2019/10/7 23:37, Will Deacon wrote:
>>> On Mon, Oct 07, 2019 at 06:06:35PM +0800, Yunfeng Ye wrote:
>>>> @@ -617,25 +624,47 @@ static int t16_setend_handler(struct pt_regs *regs, u32 instr)
>>>>   */
>>>>  static int __init armv8_deprecated_init(void)
>>>>  {
>>>> -	if (IS_ENABLED(CONFIG_SWP_EMULATION))
>>>> -		register_insn_emulation(&swp_ops);
>>>> +	int ret = 0;
>>>> +	int err = 0;
>>>> +
>>>> +	if (IS_ENABLED(CONFIG_SWP_EMULATION)) {
>>>> +		ret = register_insn_emulation(&swp_ops);
>>>> +		if (ret) {
>>>> +			pr_err("register insn emulation swp: fail\n");
>>>> +			err = ret;
>>>> +		}
>>>> +	}
>>>
>>> Is there much point in continuing here? May as well just return ret, I
>>> think. I also don't think you need to print anything, since kmalloc
>>> should already have shouted.
>>>
>> The registration of each instruction simulation is independent. I think
>> that one failure does not affect the registration of other instructions.
> 
> Dunno, I think that if kmalloc() starts failing then it's time to give up!
> 
>> In addition, if return directly, is it need to unregister? Of course,
>> the first instruction registration can be directly returned, If the
>> following instruction registration fails, is it need unregister operation?
>> currently the unregistration of instruction simulation is not be implemented
>> yet.
> 
> That's an interesting one -- currently there isn't a way to unregister
> an emulation hook afaict. We could add unregister_insn_emulation() to
> remove the emulation hook from the insn_emulation list and free it, but
> I'm actually now starting to prefer your initial patch after all. The only
> way these failures will happen are either because the system is doomed
> or kmalloc fault injection is being used; so keeping things simple rather
> than add rarely executed complexity is probably best.
> 
>> The purpose of printing information is to replace the direct return, which
>> can distinguish which instruction failed to register. There is no need to print
>> information if it returns directly.
> 
> What do you expect people to do with that information?
> 
> Are you ok with me applying your original patch?
> 
I agree, it is simple. thanks.

> Will
> 
> .
> 

