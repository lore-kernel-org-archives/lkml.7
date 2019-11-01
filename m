Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C961CA9ED1
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 15:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E9F421734
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 15:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbfKAPr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 11:47:27 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:53778 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726720AbfKAPr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 11:47:26 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=37;SR=0;TI=SMTPD_---0TgwtlFB_1572623238;
Received: from 192.168.2.229(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0TgwtlFB_1572623238)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 01 Nov 2019 23:47:20 +0800
Subject: Re: [PATCH 11/11] x86,rcu: use percpu rcu_preempt_depth
To:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andy Lutomirski <luto@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
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
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Yuyang Du <duyuyang@gmail.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Dmitry V. Levin" <ldv@altlinux.org>, rcu@vger.kernel.org
References: <20191031100806.1326-1-laijs@linux.alibaba.com>
 <20191031100806.1326-12-laijs@linux.alibaba.com>
 <20191101125816.GD17910@paulmck-ThinkPad-P72>
 <20191101131315.GY4131@hirez.programming.kicks-ass.net>
From:   Lai Jiangshan <laijs@linux.alibaba.com>
Message-ID: <75f29fff-d8f1-d7be-88b5-fdfcc09c48c7@linux.alibaba.com>
Date:   Fri, 1 Nov 2019 23:47:18 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191101131315.GY4131@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/11/1 9:13 下午, Peter Zijlstra wrote:
> On Fri, Nov 01, 2019 at 05:58:16AM -0700, Paul E. McKenney wrote:
>> On Thu, Oct 31, 2019 at 10:08:06AM +0000, Lai Jiangshan wrote:
>>> +/* We mask the RCU_NEED_SPECIAL bit so that it return real depth */
>>> +static __always_inline int rcu_preempt_depth(void)
>>> +{
>>> +	return raw_cpu_read_4(__rcu_preempt_depth) & ~RCU_NEED_SPECIAL;
>>
>> Why not raw_cpu_generic_read()?
>>
>> OK, OK, I get that raw_cpu_read_4() translates directly into an "mov"
>> instruction on x86, but given that x86 percpu_from_op() is able to
>> adjust based on operand size, why doesn't something like raw_cpu_read()
>> also have an x86-specific definition that adjusts based on operand size?
> 
> The reason for preempt.h was header recursion hell.

Oh, I didn't notice. May we can use raw_cpu_generic_read
for rcu here, I will have a try.

Thanks
Lai.

> 
>>> +}
>>> +
>>> +static __always_inline void rcu_preempt_depth_set(int pc)
>>> +{
>>> +	int old, new;
>>> +
>>> +	do {
>>> +		old = raw_cpu_read_4(__rcu_preempt_depth);
>>> +		new = (old & RCU_NEED_SPECIAL) |
>>> +			(pc & ~RCU_NEED_SPECIAL);
>>> +	} while (raw_cpu_cmpxchg_4(__rcu_preempt_depth, old, new) != old);
>>
>> Ummm...
>>
>> OK, as you know, I have long wanted _rcu_read_lock() to be inlineable.
>> But are you -sure- that an x86 cmpxchg is faster than a function call
>> and return?  I have strong doubts on that score.
> 
> This is a regular CMPXCHG instruction, not a LOCK prefixed one, and that
> should make all the difference
> 
>> Plus multiplying the x86-specific code by 26 doesn't look good.
>>
>> And the RCU read-side nesting depth really is a per-task thing.  Copying
>> it to and from the task at context-switch time might make sense if we
>> had a serious optimization, but it does not appear that we do.
>>
>> You original patch some years back, ill-received though it was at the
>> time, is looking rather good by comparison.  Plus it did not require
>> architecture-specific code!
> 
> Right, so the per-cpu preempt_count code relies on the preempt_count
> being invariant over context switches. That means we never have to
> save/restore the thing.
> 
> For (preemptible) rcu, this is 'obviously' not the case.
> 
> That said, I've not looked over this patch series, I only got 1 actual
> patch, not the whole series, and I've not had time to go dig out the
> rest..
> 
