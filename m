Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA48CA9ED0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 04:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB0F5214D8
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 04:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfKCEd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 00:33:26 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:55998 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726236AbfKCEdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 00:33:25 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=36;SR=0;TI=SMTPD_---0Th17ejG_1572755596;
Received: from 192.168.2.229(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0Th17ejG_1572755596)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 03 Nov 2019 12:33:18 +0800
Subject: Re: [PATCH V2 7/7] x86,rcu: use percpu rcu_preempt_depth
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andi Kleen <ak@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Kees Cook <keescook@chromium.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Babu Moger <Babu.Moger@amd.com>,
        Rik van Riel <riel@surriel.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Jann Horn <jannh@google.com>,
        David Windsor <dwindsor@gmail.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Yuyang Du <duyuyang@gmail.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Dmitry V. Levin" <ldv@altlinux.org>, rcu@vger.kernel.org
References: <20191102124559.1135-1-laijs@linux.alibaba.com>
 <20191102124559.1135-8-laijs@linux.alibaba.com>
 <20191102163005.GA11705@nazgul.tnic>
From:   Lai Jiangshan <laijs@linux.alibaba.com>
Message-ID: <4e1922ae-c56a-d1cf-db10-e73f3a62a27b@linux.alibaba.com>
Date:   Sun, 3 Nov 2019 12:33:16 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191102163005.GA11705@nazgul.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/11/3 12:30 上午, Borislav Petkov wrote:
> Resending again because your mail has the craziest header:
> 
> Reply-To: 20191101162109.GN20975@paulmck-ThinkPad-P72
> 
> and hitting Reply-to-all creates only confusion. WTF?


Sorry, I send the emails via git send-email with the wrong
argument "--reply-to", it should have been "--in-reply-to".

> 
> On Sat, Nov 02, 2019 at 12:45:59PM +0000, Lai Jiangshan wrote:
>> Convert x86 to use a per-cpu rcu_preempt_depth. The reason for doing so
>> is that accessing per-cpu variables is a lot cheaper than accessing
>> task_struct or thread_info variables.
>>
>> We need to save/restore the actual rcu_preempt_depth when switch.
>> We also place the per-cpu rcu_preempt_depth close to __preempt_count
>> and current_task variable.
>>
>> Using the idea of per-cpu __preempt_count.
>>
>> No function call when using rcu_read_[un]lock().
>> Single instruction for rcu_read_lock().
>> 2 instructions for fast path of rcu_read_unlock().
>>
>> CC: Peter Zijlstra <peterz@infradead.org>
>> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
>> ---
>>   arch/x86/Kconfig                         |  2 +
>>   arch/x86/include/asm/rcu_preempt_depth.h | 87 ++++++++++++++++++++++++
>>   arch/x86/kernel/cpu/common.c             |  7 ++
>>   arch/x86/kernel/process_32.c             |  2 +
>>   arch/x86/kernel/process_64.c             |  2 +
>>   include/linux/rcupdate.h                 | 24 +++++++
>>   init/init_task.c                         |  2 +-
>>   kernel/fork.c                            |  2 +-
>>   kernel/rcu/Kconfig                       |  3 +
>>   kernel/rcu/tree_exp.h                    |  2 +
>>   kernel/rcu/tree_plugin.h                 | 37 +++++++---
>>   11 files changed, 158 insertions(+), 12 deletions(-)
>>   create mode 100644 arch/x86/include/asm/rcu_preempt_depth.h
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index d6e1faa28c58..af9fedc0fdc4 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -18,6 +18,7 @@ config X86_32
>>   	select MODULES_USE_ELF_REL
>>   	select OLD_SIGACTION
>>   	select GENERIC_VDSO_32
>> +	select ARCH_HAVE_RCU_PREEMPT_DEEPTH
> 
> WTF is a "DEEPTH"?
> 

Sorry, bad English.

