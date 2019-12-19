Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C445C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 14:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30A7A24672
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 14:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfLSObZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 09:31:25 -0500
Received: from relay.sw.ru ([185.231.240.75]:54454 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726757AbfLSObY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 09:31:24 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1ihwpc-0006gx-Ov; Thu, 19 Dec 2019 17:31:12 +0300
Subject: Re: [PATCH RFC] sched: Micro optimization in pick_next_task() and in
 check_preempt_curr()
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org
References: <157675913272.349305.8936736338884044103.stgit@localhost.localdomain>
 <20191219131242.GK2827@hirez.programming.kicks-ass.net>
 <20191219140252.GS2871@hirez.programming.kicks-ass.net>
 <bfaa72ca-8bc6-f93c-30d7-5d62f2600f53@virtuozzo.com>
Message-ID: <423860b3-b35a-ff25-6abf-845ef4be6e8e@virtuozzo.com>
Date:   Thu, 19 Dec 2019 17:31:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <bfaa72ca-8bc6-f93c-30d7-5d62f2600f53@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.12.2019 17:25, Kirill Tkhai wrote:
> On 19.12.2019 17:02, Peter Zijlstra wrote:
>> On Thu, Dec 19, 2019 at 02:12:42PM +0100, Peter Zijlstra wrote:
>>> On Thu, Dec 19, 2019 at 03:39:14PM +0300, Kirill Tkhai wrote:
>>>> In kernel/sched/Makefile files, describing different sched classes, already
>>>> go in the order from the lowest priority class to the highest priority class:
>>>>
>>>> idle.o fair.o rt.o deadline.o stop_task.o
>>>>
>>>> The documentation of GNU linker says, that section appears in the order
>>>> they are seen during link time (see [1]):
>>>>
>>>>> Normally, the linker will place files and sections matched by wildcards
>>>>> in the order in which they are seen during the link. You can change this
>>>>> by using the SORT keyword, which appears before a wildcard pattern
>>>>> in parentheses (e.g., SORT(.text*)).
>>>>
>>>> So, we may expect const variables from idle.o will go before ro variables
>>>> from fair.o in RO_DATA section, while ro variables from fair.o will go
>>>> before ro variables from rt.o, etc.
>>>>
>>>> (Also, it looks like the linking order is already used in kernel, e.g.
>>>>  in drivers/md/Makefile)
>>>>
>>>> Thus, we may introduce an optimization based on xxx_sched_class addresses
>>>> in these two hot scheduler functions: pick_next_task() and check_preempt_curr().
>>>>
>>>> One more result of the patch is that size of object file becomes a little
>>>> less (excluding added BUG_ON(), which goes in __init section):
>>>>
>>>> $size kernel/sched/core.o
>>>>          text     data      bss	    dec	    hex	filename
>>>> before:  66446    18957	    676	  86079	  1503f	kernel/sched/core.o
>>>> after:   66398    18957	    676	  86031	  1500f	kernel/sched/core.o
>>>
>>> Does LTO preserve this behaviour? I've never quite dared do this exact
>>> optimization.
>>
>> Also, ld.lld seems a popular option.
> 
> I asked on their IRC. Oh, it looks like no way is for this.
> 
> About the link: https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/4/html/Using_ld_the_GNU_Linker/sections.html
> 
> (17:19:25) nbjoerg: but it is not guarenteed behavior
> (17:19:50) nbjoerg: if for some strange reason you really need to enforce relative orders of global objects, put them in consecutively named sections

Introduction of sched_class::id instead of this patch's approach does not have a big sense,
since this will help in check_preempt_curr() only. And this requires too many new lines of code.
