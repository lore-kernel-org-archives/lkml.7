Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBAFCA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 11:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB1D02184C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 11:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbfKDLla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 06:41:30 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:56996 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726441AbfKDLla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 06:41:30 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=36;SR=0;TI=SMTPD_---0ThBi2ca_1572867681;
Received: from C02XQCBJJG5H.local(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0ThBi2ca_1572867681)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 04 Nov 2019 19:41:22 +0800
Subject: Re: [PATCH V2 7/7] x86,rcu: use percpu rcu_preempt_depth
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
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
 <20191104092519.nukaz5qmgiskzafi@linutronix.de>
From:   Lai Jiangshan <laijs@linux.alibaba.com>
Message-ID: <4878ccfd-7a4e-4f84-9bc3-1d477e077587@linux.alibaba.com>
Date:   Mon, 4 Nov 2019 19:41:20 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191104092519.nukaz5qmgiskzafi@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/11/4 5:25 下午, Sebastian Andrzej Siewior wrote:
> On 2019-11-02 12:45:59 [+0000], Lai Jiangshan wrote:
>> Convert x86 to use a per-cpu rcu_preempt_depth. The reason for doing so
>> is that accessing per-cpu variables is a lot cheaper than accessing
>> task_struct or thread_info variables.
> 
> Is there a benchmark saying how much we gain from this?

Hello

Maybe I can write a tight loop for testing, but I don't
think anyone will be interesting in it.

I'm also trying to find some good real tests. I need
some suggestions here.

> 
>> We need to save/restore the actual rcu_preempt_depth when switch.
>> We also place the per-cpu rcu_preempt_depth close to __preempt_count
>> and current_task variable.
>>
>> Using the idea of per-cpu __preempt_count.
>>
>> No function call when using rcu_read_[un]lock().
>> Single instruction for rcu_read_lock().
>> 2 instructions for fast path of rcu_read_unlock().
> 
> I think these were not inlined due to the header requirements.

objdump -D -S kernel/workqueue.o shows (selected fractions):


         raw_cpu_add_4(__rcu_preempt_depth, 1);
      d8f:       65 ff 05 00 00 00 00    incl   %gs:0x0(%rip)        # 
d96 <work_busy+0x16>

......


         return GEN_UNARY_RMWcc("decl", __rcu_preempt_depth, e, 
__percpu_arg([var]));
      dd8:       65 ff 0d 00 00 00 00    decl   %gs:0x0(%rip)        # 
ddf <work_busy+0x5f>
         if (unlikely(rcu_preempt_depth_dec_and_test()))
      ddf:       74 26                   je     e07 <work_busy+0x87>

......

                 rcu_read_unlock_special();
      e07:       e8 00 00 00 00          callq  e0c <work_busy+0x8c>

> 
> Boris pointed one thing, there is also DEFINE_PERCPU_RCU_PREEMP_DEPTH.
> 

Thanks for pointing out.

Best regards
Lai

