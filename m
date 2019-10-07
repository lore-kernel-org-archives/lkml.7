Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04DCC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 06:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71168206C2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 06:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfJGGGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 02:06:54 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3261 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726889AbfJGGGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 02:06:54 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7C42D154F83C0FCB6C57;
        Mon,  7 Oct 2019 14:06:52 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Mon, 7 Oct 2019
 14:06:48 +0800
Subject: Re: [PATCH] arm64: armv8_deprecated: Checking return value for memory
 allocation
To:     Will Deacon <will@kernel.org>
CC:     <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <kstewart@linuxfoundation.org>, <gregkh@linuxfoundation.org>,
        <tglx@linutronix.de>, <info@metux.net>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <ea235720-5bbd-27b7-a9b1-34aa8a344e3a@huawei.com>
 <20190930132209.jyyemkck7orji64i@willie-the-truck>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Message-ID: <0763a3af-16ed-d450-4980-0e6b69b06bee@huawei.com>
Date:   Mon, 7 Oct 2019 14:06:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190930132209.jyyemkck7orji64i@willie-the-truck>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.251.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/9/30 21:22, Will Deacon wrote:
> On Sun, Sep 29, 2019 at 12:44:17PM +0800, Yunfeng Ye wrote:
>> There are no return value checking when using kzalloc() and kcalloc() for
>> memory allocation. so add it.
>>
>> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
>> ---
>>  arch/arm64/kernel/armv8_deprecated.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
>> index 2ec09de..ca158be 100644
>> --- a/arch/arm64/kernel/armv8_deprecated.c
>> +++ b/arch/arm64/kernel/armv8_deprecated.c
>> @@ -174,6 +174,9 @@ static void __init register_insn_emulation(struct insn_emulation_ops *ops)
>>  	struct insn_emulation *insn;
>>
>>  	insn = kzalloc(sizeof(*insn), GFP_KERNEL);
>> +	if (!insn)
>> +		return;
>> +
>>  	insn->ops = ops;
>>  	insn->min = INSN_UNDEF;
>>
>> @@ -233,6 +236,8 @@ static void __init register_insn_emulation_sysctl(void)
>>
>>  	insns_sysctl = kcalloc(nr_insn_emulated + 1, sizeof(*sysctl),
>>  			       GFP_KERNEL);
>> +	if (!insns_sysctl)
>> +		return;
> 
> Since both of these failure paths are fatal to the instruction emulation,
> can you please return an error code when the allocation fails and use that
> to fail the calling initcall() appropriately?
> 
ok, I will modify as your suggest, thanks.

> Will
> 
> .
> 

