Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFD6C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E62F120716
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbfLQMb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 07:31:28 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7697 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727807AbfLQMb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 07:31:27 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 09230FE37AC8A720409F;
        Tue, 17 Dec 2019 20:31:26 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Tue, 17 Dec 2019
 20:31:20 +0800
Subject: Re: [PATCH] x86/process: remove unused variable in __switch_to_xtra()
To:     Borislav Petkov <bp@alien8.de>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <x86@kernel.org>, <luto@kernel.org>, <riel@surriel.com>,
        <dave.hansen@intel.com>, <longman@redhat.com>,
        <mtosatti@redhat.com>, <linux-kernel@vger.kernel.org>,
        "hushiyuan@huawei.com" <hushiyuan@huawei.com>,
        "linfeilong@huawei.com" <linfeilong@huawei.com>
References: <0efac42a-1631-d93d-d8a2-e6cf65cdf16b@huawei.com>
 <20191217122922.GD28788@zn.tnic>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Message-ID: <b6d29107-473e-15d2-4eab-3b081dadf6cd@huawei.com>
Date:   Tue, 17 Dec 2019 20:30:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191217122922.GD28788@zn.tnic>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.251.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/12/17 20:29, Borislav Petkov wrote:
> On Tue, Dec 17, 2019 at 08:09:08PM +0800, Yunfeng Ye wrote:
>> After the commit ecc7e37d4dad ("x86/io: Speedup schedule out of I/O
>> bitmap user") and commit 22fe5b0439dd ("x86/ioperm: Move TSS bitmap
>> update to exit to user work"), warning is found:
>>
>> arch/x86/kernel/process.c: In function ‘__switch_to_xtra’:
>> arch/x86/kernel/process.c:618:31: warning: variable ‘next’ set but not
>> used [-Wunused-but-set-variable]
>>   struct thread_struct *prev, *next;
>>                                ^~~~
>> arch/x86/kernel/process.c:618:24: warning: variable ‘prev’ set but not
>> used [-Wunused-but-set-variable]
>>   struct thread_struct *prev, *next;
>>                         ^~~~
>> Fix this by removing the unused variable @prev and @next;
>>
>> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
>> ---
>>  arch/x86/kernel/process.c | 4 ----
>>  1 file changed, 4 deletions(-)
>>
>> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
>> index 61e93a318983..839b5244e3b7 100644
>> --- a/arch/x86/kernel/process.c
>> +++ b/arch/x86/kernel/process.c
>> @@ -615,12 +615,8 @@ void speculation_ctrl_update_current(void)
>>
>>  void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p)
>>  {
>> -	struct thread_struct *prev, *next;
>>  	unsigned long tifp, tifn;
>>
>> -	prev = &prev_p->thread;
>> -	next = &next_p->thread;
>> -
>>  	tifn = READ_ONCE(task_thread_info(next_p)->flags);
>>  	tifp = READ_ONCE(task_thread_info(prev_p)->flags);
>>
>> -- 
> 
> Let me introduce you to your colleague yu kuai:
> 
ok, thanks.

> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/cleanups&id=27353d5785bca61bb49cfd7c78e14f1d21e66ec5
> 
> :-)
> 

