Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB6BCA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 12:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98B9F21D81
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 12:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbfKDMK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 07:10:56 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37212 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfKDMKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 07:10:55 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iRbAx-0005Ym-MN; Mon, 04 Nov 2019 13:09:39 +0100
Date:   Mon, 4 Nov 2019 13:09:39 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Lai Jiangshan <laijs@linux.alibaba.com>
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
Subject: Re: [PATCH V2 7/7] x86,rcu: use percpu rcu_preempt_depth
Message-ID: <20191104120939.5e4hdcoat2v4jxov@linutronix.de>
References: <20191102124559.1135-1-laijs@linux.alibaba.com>
 <20191102124559.1135-8-laijs@linux.alibaba.com>
 <20191104092519.nukaz5qmgiskzafi@linutronix.de>
 <4878ccfd-7a4e-4f84-9bc3-1d477e077587@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4878ccfd-7a4e-4f84-9bc3-1d477e077587@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-11-04 19:41:20 [+0800], Lai Jiangshan wrote:
> > Is there a benchmark saying how much we gain from this?
> 
> Hello
> 
> Maybe I can write a tight loop for testing, but I don't
> think anyone will be interesting in it.
> 
> I'm also trying to find some good real tests. I need
> some suggestions here.

There is rcutorture but I don't know how much of performance test this
is, Paul would know.

A micro benchmark is one thing. Any visible changes in userland to
workloads like building a kernel or hackbench? 

I don't argue that incrementing a per-CPU variable is more efficient
than reading a per-CPU variable, adding an offset and then incrementing
it. I was just curious to see if there are any numbers on it.

> > > No function call when using rcu_read_[un]lock().
> > > Single instruction for rcu_read_lock().
> > > 2 instructions for fast path of rcu_read_unlock().
> > 
> > I think these were not inlined due to the header requirements.
> 
> objdump -D -S kernel/workqueue.o shows (selected fractions):

That was not what I meant. To inline current rcu_read_lock() would mean
to include definition for struct task_struct (and everything down the
road) in the rcu headers which isn't working.

> Best regards
> Lai

Sebastian
