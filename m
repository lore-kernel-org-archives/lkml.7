Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569B2CA9ED3
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 09:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3776C20842
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 09:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbfKDJ0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 04:26:19 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36766 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfKDJ0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 04:26:18 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iRYbv-0003QI-G0; Mon, 04 Nov 2019 10:25:19 +0100
Date:   Mon, 4 Nov 2019 10:25:19 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
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
Message-ID: <20191104092519.nukaz5qmgiskzafi@linutronix.de>
References: <20191102124559.1135-1-laijs@linux.alibaba.com>
 <20191102124559.1135-8-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191102124559.1135-8-laijs@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-11-02 12:45:59 [+0000], Lai Jiangshan wrote:
> Convert x86 to use a per-cpu rcu_preempt_depth. The reason for doing so
> is that accessing per-cpu variables is a lot cheaper than accessing
> task_struct or thread_info variables.

Is there a benchmark saying how much we gain from this?

> We need to save/restore the actual rcu_preempt_depth when switch.
> We also place the per-cpu rcu_preempt_depth close to __preempt_count
> and current_task variable.
> 
> Using the idea of per-cpu __preempt_count.
> 
> No function call when using rcu_read_[un]lock().
> Single instruction for rcu_read_lock().
> 2 instructions for fast path of rcu_read_unlock().

I think these were not inlined due to the header requirements.

Boris pointed one thing, there is also DEFINE_PERCPU_RCU_PREEMP_DEPTH.

Sebastian
