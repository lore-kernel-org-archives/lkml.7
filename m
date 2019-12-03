Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B154EC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 00:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE7220833
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 00:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfLCA4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 19:56:05 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:55226 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725853AbfLCA4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 19:56:05 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4CB75DCF05BEBA1F926F;
        Tue,  3 Dec 2019 08:56:00 +0800 (CST)
Received: from [127.0.0.1] (10.133.216.73) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Tue, 3 Dec 2019
 08:55:54 +0800
Subject: Re: [PATCH] arm64/kernel/entry: refine comment of stack overflow
 check
To:     Mark Rutland <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wanghaibin.wang@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>
References: <20191202113702.34158-1-guoheyi@huawei.com>
 <20191202123319.GA25809@lakrids.cambridge.arm.com>
From:   Guoheyi <guoheyi@huawei.com>
Message-ID: <0aee0354-5153-940c-bf72-7bd6bccce490@huawei.com>
Date:   Tue, 3 Dec 2019 08:55:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191202123319.GA25809@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.133.216.73]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2019/12/2 20:33, Mark Rutland Ð´µÀ:
> On Mon, Dec 02, 2019 at 07:37:02PM +0800, Heyi Guo wrote:
>> Stack overflow checking can be done by testing
>> sp & (1 << THREAD_SHIFT)
>> only for the stacks are aligned to (2 << THREAD_SHIFT) with size of
>> (1 << THREAD_SIZE), and this is the case when CONFIG_VMAP_STACK is
>> set.
> Good point, I was sloppy with this comment.
>
>> Fix the code comment to avoid confusion.
>>
>> Signed-off-by: Heyi Guo <guoheyi@huawei.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> ---
>>   arch/arm64/kernel/entry.S | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
>> index cf3bd2976e57..9e8ba507090f 100644
>> --- a/arch/arm64/kernel/entry.S
>> +++ b/arch/arm64/kernel/entry.S
>> @@ -76,7 +76,8 @@ alternative_else_nop_endif
>>   #ifdef CONFIG_VMAP_STACK
>>   	/*
>>   	 * Test whether the SP has overflowed, without corrupting a GPR.
>> -	 * Task and IRQ stacks are aligned to (1 << THREAD_SHIFT).
>> +	 * Task and IRQ stacks are aligned to (2 << THREAD_SHIFT) with size of
>> +	 * (1 << THREAD_SHIFT).
>>   	 */
> Can we make that:
>
> 	Task and IRQ stacks are aligned so that SP & (1 << THREAD_SHIFT)
> 	should always be zero.
>
> ... which I think is a bit clearer.

Sure :)

Thanks,

Heyi

>
> With that wording:
>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
>
> Mark.
>
>>   	add	sp, sp, x0			// sp' = sp + x0
>>   	sub	x0, sp, x0			// x0' = sp' - x0 = (sp + x0) - x0 = sp
>> -- 
>> 2.19.1
>>
> .

