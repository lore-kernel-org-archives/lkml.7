Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018CCC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 04:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE994206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 04:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729936AbfHBEEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 00:04:22 -0400
Received: from mail1.windriver.com ([147.11.146.13]:54431 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729150AbfHBEEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 00:04:22 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id x722h7or006793
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Thu, 1 Aug 2019 19:43:07 -0700 (PDT)
Received: from [128.224.162.237] (128.224.162.237) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server id 14.3.468.0; Thu, 1 Aug 2019
 19:43:06 -0700
Subject: Re: [PATCH v2] tracing: Function stack size and its name mismatch in
 arm64
To:     Will Deacon <will@kernel.org>
CC:     <rostedt@goodmis.org>, <mingo@redhat.com>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <joel@joelfernandes.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20190801083340.57075-1-jiping.ma2@windriver.com>
 <20190801094156.emo36ekvrm74nndl@willie-the-truck>
From:   Jiping Ma <Jiping.Ma2@windriver.com>
Message-ID: <47e90170-e971-c2f5-b6c9-d3c6a694a4a7@windriver.com>
Date:   Fri, 2 Aug 2019 10:43:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20190801094156.emo36ekvrm74nndl@willie-the-truck>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019年08月01日 17:41, Will Deacon wrote:
> On Thu, Aug 01, 2019 at 04:33:40PM +0800, Jiping Ma wrote:
>> In arm64, the PC of the frame is matched to the last frame function,
>> rather than the function of his frame. For the following example, the
>> stack size of occupy_stack_init function should be 3376, rather than 176.
>>
>> Wrong info:
>> Depth Size Location (16 entries)
>> ----- ---- --------
>> 0) 5400 16 __update_load_avg_se.isra.2+0x28/0x220
>> 1) 5384 96 put_prev_entity+0x250/0x338
>> 2) 5288 80 pick_next_task_fair+0x4c4/0x508
>> 3) 5208 72 __schedule+0x100/0x600
>> 4) 5136 184 preempt_schedule_common+0x28/0x48
>> 5) 4952 32 preempt_schedule+0x28/0x30
>> 6) 4920 16 vprintk_emit+0x170/0x1f8
>> 7) 4904 128 vprintk_default+0x48/0x58
>> 8) 4776 64 vprintk_func+0xf8/0x1c8
>> 9) 4712 112 printk+0x70/0x90
>> 10) 4600 176 occupy_stack_init+0x64/0xc0 [kernel_stack]
>> 11) 4424 3376 do_one_initcall+0x68/0x248
>> 12) 1048 144 do_init_module+0x60/0x1f0
>> 13) 904 48 load_module+0x1d50/0x2340
>> 14) 856 352 sys_finit_module+0xd0/0xe8
>> 15) 504 504 el0_svc_naked+0x30/0x34
>>
>> Correct info:
>> Depth Size Location (18 entries)
>> ----- ---- --------
>> 0) 5464 48 cgroup_rstat_updated+0x20/0x100
>> 1) 5416 32 cgroup_base_stat_cputime_account_end.isra.0+0x30/0x60
>> 2) 5384 32 __cgroup_account_cputime+0x3c/0x48
>> 3) 5352 64 update_curr+0xc4/0x1d0
>> 4) 5288 72 pick_next_task_fair+0x444/0x508
>> 5) 5216 184 __schedule+0x100/0x600
>> 6) 5032 32 preempt_schedule_common+0x28/0x48
>> 7) 5000 16 preempt_schedule+0x28/0x30
>> 8) 4984 128 vprintk_emit+0x170/0x1f8
>> 9) 4856 64 vprintk_default+0x48/0x58
>> 10) 4792 112 vprintk_func+0xf8/0x1c8
>> 11) 4680 176 printk+0x70/0x90
>> 12) 4504 80 func_test+0x7c/0xb8 [kernel_stack]
>> 13) 4424 3376 occupy_stack_init+0x7c/0xc0 [kernel_stack]
>> 14) 1048 144 do_one_initcall+0x68/0x248
>> 15) 904 48 do_init_module+0x60/0x1f0
>> 16) 856 352 load_module+0x1d50/0x2340
>> 17) 504 504 sys_finit_module+0xd0/0xe8
>>
>> Signed-off-by: Jiping Ma <jiping.ma2@windriver.com>
>> ---
>>   kernel/trace/trace_stack.c | 28 ++++++++++++++++++++++++++--
>>   1 file changed, 26 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
>> index 5d16f73898db..ed80b95abf06 100644
>> --- a/kernel/trace/trace_stack.c
>> +++ b/kernel/trace/trace_stack.c
>> @@ -40,16 +40,28 @@ static void print_max_stack(void)
>>   
>>   	pr_emerg("        Depth    Size   Location    (%d entries)\n"
>>   			   "        -----    ----   --------\n",
>> +#ifdef CONFIG_ARM64
>> +			   stack_trace_nr_entries - 1);
>> +#else
>>   			   stack_trace_nr_entries);
> Sorry, but I have no idea what the problem is here. All I know is that the
> solution looks highly dubious and I find it very hard to believe that the
> arm64 backtracing code is uniquely special as to deserve being called out
> like this. I suspect there's a bug lurking somewhere, but you really need
> to do a better job of explaining the issue rather than simply providing a
> couple of backtraces with no context.
>
> *Why* does the frame appear to be off-by-one?
Because the PC is LR in ARM64 stack actually.  Following is ARM64 stack 
layout. Please refer to the figure 3 in 
http://infocenter.arm.com/help/topic/com.arm.doc.ihi0055b/IHI0055B_aapcs64.pdf
             LR
             FP
             ......
             LR
             FP
Jiping
>
> Will

