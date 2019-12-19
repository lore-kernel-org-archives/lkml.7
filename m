Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A877C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 16:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5679B2146E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 16:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfLSQIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 11:08:24 -0500
Received: from relay.sw.ru ([185.231.240.75]:57908 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726778AbfLSQIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 11:08:24 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1ihyLP-0007T1-L5; Thu, 19 Dec 2019 19:08:07 +0300
Subject: Re: [PATCH v2] sched: Micro optimization in pick_next_task() and in
 check_preempt_curr()
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org
References: <157675913272.349305.8936736338884044103.stgit@localhost.localdomain>
 <20191219131242.GK2827@hirez.programming.kicks-ass.net>
 <20191219140252.GS2871@hirez.programming.kicks-ass.net>
 <bfaa72ca-8bc6-f93c-30d7-5d62f2600f53@virtuozzo.com>
 <20191219094330.0e44c748@gandalf.local.home>
 <11d755e9-e4f8-dd9e-30b0-45aebe260b2f@virtuozzo.com>
 <20191219095941.2eebed84@gandalf.local.home>
 <44c95c18-7593-f3e7-f710-a7d424af7442@virtuozzo.com>
 <20191219104018.5f8e50d2@gandalf.local.home>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <af65cbaf-2f8e-0384-03e8-262d35e3790e@virtuozzo.com>
Date:   Thu, 19 Dec 2019 19:08:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191219104018.5f8e50d2@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.12.2019 18:40, Steven Rostedt wrote:
> On Thu, 19 Dec 2019 18:20:58 +0300
> Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> 
>> From: Kirill Tkhai <ktkhai@virtuozzo.com>
>>
>> This introduces an optimization based on xxx_sched_class addresses
>> in two hot scheduler functions: pick_next_task() and check_preempt_curr().
>>
>> After this patch, it will be possible to compare pointers to sched classes
>> to check, which of them has a higher priority, instead of current iterations
>> using for_each_class().
>>
>> One more result of the patch is that size of object file becomes a little
>> less (excluding added BUG_ON(), which goes in __init section):
>>
>> $size kernel/sched/core.o
>>          text     data      bss	    dec	    hex	filename
>> before:  66446    18957	    676	  86079	  1503f	kernel/sched/core.o
>> after:   66398    18957	    676	  86031	  1500f	kernel/sched/core.o
>>
>> SCHED_DATA improvements guaranteeing order of sched classes are made
>> by Steven Rostedt <rostedt@goodmis.org>
> 
> For the above changes, you can add:
> 
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Should I resend this as two patches, with your changes in a separate?

> 
>>
>> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
>>
>> v2: Steven's data sections ordering. Hunk with comment in Makefile is removed.
>> ---
>>  include/asm-generic/vmlinux.lds.h |    8 ++++++++
>>  kernel/sched/core.c               |   24 +++++++++---------------
>>  kernel/sched/deadline.c           |    3 ++-
>>  kernel/sched/fair.c               |    3 ++-
>>  kernel/sched/idle.c               |    3 ++-
>>  kernel/sched/rt.c                 |    3 ++-
>>  kernel/sched/stop_task.c          |    3 ++-
>>  7 files changed, 27 insertions(+), 20 deletions(-)
>>
>> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
>> index e00f41aa8ec4..ff12a422ff19 100644
>> --- a/include/asm-generic/vmlinux.lds.h
>> +++ b/include/asm-generic/vmlinux.lds.h
>> @@ -108,6 +108,13 @@
>>  #define SBSS_MAIN .sbss
>>  #endif
>>  

