Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D58CA9EC0
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 01:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 024FC20873
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 01:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbfJ2BCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 21:02:50 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47294 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726365AbfJ2BCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 21:02:49 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CCEF221C64DBA44192B8;
        Tue, 29 Oct 2019 09:02:46 +0800 (CST)
Received: from [127.0.0.1] (10.133.224.57) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Tue, 29 Oct 2019
 09:02:38 +0800
Subject: Re: [PATCH] arm64: print additional fault message when executing
 non-exec memory
To:     Will Deacon <will@kernel.org>
CC:     <catalin.marinas@arm.com>, <james.morse@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wanghaibin.wang@huawei.com>
References: <20191028090837.39652-1-zhengxiang9@huawei.com>
 <20191028164150.GG5576@willie-the-truck>
From:   Xiang Zheng <zhengxiang9@huawei.com>
Message-ID: <922ff695-62c4-5142-5efa-daeebd73459e@huawei.com>
Date:   Tue, 29 Oct 2019 09:02:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191028164150.GG5576@willie-the-truck>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.224.57]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/10/29 0:41, Will Deacon wrote:
> On Mon, Oct 28, 2019 at 05:08:37PM +0800, Xiang Zheng wrote:
>> When attempting to executing non-executable memory, the fault message
>> shows:
>>
>>   Unable to handle kernel read from unreadable memory at virtual address
>>   ffff802dac469000
>>
>> This may confuse someone, so add a new fault message for instruction
>> abort.
>>
>> Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
>> ---
>>  arch/arm64/mm/fault.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
>> index 9fc6db0bcbad..68bf4ec376d0 100644
>> --- a/arch/arm64/mm/fault.c
>> +++ b/arch/arm64/mm/fault.c
>> @@ -318,6 +318,8 @@ static void __do_kernel_fault(unsigned long addr, unsigned int esr,
>>  	if (is_el1_permission_fault(addr, esr, regs)) {
>>  		if (esr & ESR_ELx_WNR)
>>  			msg = "write to read-only memory";
>> +		else if (is_el1_instruction_abort(esr))
>> +			msg = "execute non-executable memory";
> 
> nit, please make this "execute from non-executable memory".

Thanks, I will make this in the next version of patch.

> 
> With that:
> 
> Acked-by: Will Deacon <will@kernel.org>
> 
> Will
> 
> .
> 

-- 

Thanks,
Xiang

