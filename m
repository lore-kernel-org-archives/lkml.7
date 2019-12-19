Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CF3C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 13:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13AA6218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 13:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfLSNyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 08:54:00 -0500
Received: from relay.sw.ru ([185.231.240.75]:53048 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726813AbfLSNx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 08:53:59 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1ihwFB-0006Nq-Q5; Thu, 19 Dec 2019 16:53:34 +0300
Subject: Re: [PATCH RFC] sched: Micro optimization in pick_next_task() and in
 check_preempt_curr()
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, linux-kernel@vger.kernel.org
References: <157675913272.349305.8936736338884044103.stgit@localhost.localdomain>
 <20191219085042.0a29437b@gandalf.local.home>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <edf63e92-dd04-f795-7bba-d5d3c65acaff@virtuozzo.com>
Date:   Thu, 19 Dec 2019 16:53:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191219085042.0a29437b@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.12.2019 16:50, Steven Rostedt wrote:
> On Thu, 19 Dec 2019 15:39:14 +0300
> Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> 
>> @@ -6569,6 +6558,11 @@ void __init sched_init(void)
>>  	unsigned long ptr = 0;
>>  	int i;
>>  
>> +	BUG_ON(&idle_sched_class > &fair_sched_class ||
>> +		&fair_sched_class > &rt_sched_class ||
>> +		&rt_sched_class > &dl_sched_class ||
>> +		&dl_sched_class > &stop_sched_class);
>> +
> 
> Can this be a BUILD_BUG_ON? These address should all be constants.

BUILD_BUG_ON() is compile-time check, while address is assigned
at link time, isn't it?!

Anyway, plain BUILD_BUG_ON() fails here with the following:

In file included from ./arch/x86/include/asm/current.h:5,
                 from ./include/linux/sched.h:12,
                 from kernel/sched/sched.h:5,
                 from kernel/sched/core.c:9:
kernel/sched/core.c: In function ‘sched_init’:
./include/linux/compiler.h:394:38: error: call to ‘__compiletime_assert_6561’ declared with attribute error: BUILD_BUG_ON failed: &idle_sched_class > &fair_sched_class || &fair_sched_class > &rt_sched_class || &rt_sched_class > &dl_sched_class || &dl_sched_class > &stop_sched_class
  394 |  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
      |                                      ^
./include/linux/compiler.h:375:4: note: in definition of macro ‘__compiletime_assert’
  375 |    prefix ## suffix();    \
      |    ^~~~~~
./include/linux/compiler.h:394:2: note: in expansion of macro ‘_compiletime_assert’
  394 |  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
      |  ^~~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:50:2: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
   50 |  BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
      |  ^~~~~~~~~~~~~~~~
kernel/sched/core.c:6561:2: note: in expansion of macro ‘BUILD_BUG_ON’
 6561 |  BUILD_BUG_ON(&idle_sched_class > &fair_sched_class ||
      |  ^~~~~~~~~~~~


> -- Steve
> 
> 
> 
>>  	wait_bit_init();
>>  

