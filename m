Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F984C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C1B421726
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbfEPL6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 07:58:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:41254 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727117AbfEPL6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 07:58:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F3E65ACAA;
        Thu, 16 May 2019 11:58:00 +0000 (UTC)
Date:   Thu, 16 May 2019 13:57:58 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Liu Chuansheng <chuansheng.liu@intel.com>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] kernel/hung_task.c: Monitor killed tasks.
Message-ID: <20190516115758.6v7oitg3vbkfhh5j@pathway.suse.cz>
References: <1557745331-10367-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20190515105540.vyzh6n62rqi5imqv@pathway.suse.cz>
 <ee7501c6-d996-1684-1652-f0f838ba69c3@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee7501c6-d996-1684-1652-f0f838ba69c3@i-love.sakura.ne.jp>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CCed Stephen to discuss linux-next related question at the bottom
of the mail.

On Thu 2019-05-16 17:19:12, Tetsuo Handa wrote:
> On 2019/05/15 19:55, Petr Mladek wrote:
> >> +	if (!stamp) {
> >> +		stamp = jiffies;
> >> +		if (!stamp)
> >> +			stamp++;
> >> +		t->killed_time = stamp;
> >> +		return;
> >> +	}
> > 
> > I might be too dumb but the above code looks pretty tricky to me.
> > It would deserve a comment. Or better, I would remove
> > trick to handle overflow. If it happens, we would just
> > lose one check period.
> 
> We can use
> 
>   static inline unsigned long jiffies_nonzero(void)
>   {
>       const unsigned long stamp = jiffies;
> 
>       return stamp ? stamp : -1;
>   }
> 
> or even shortcut "jiffies | 1" because difference by one jiffie
> is an measurement error for multiple HZ of timeout.

I would just ignore the overflow. We would just start measuring
the timeout in the next check_hung_task() call. It is not
a big deal and removes few lines of a tricky code.

> >> +	if (time_is_after_jiffies(stamp + timeout * HZ))
> >> +		return;
> >> +	trace_sched_process_hang(t);
> >> +	if (sysctl_hung_task_panic) {
> >> +		console_verbose();
> >> +		hung_task_call_panic = true;
> > 
> > IMHO, the delayed task exit is much less fatal than sleeping
> > in an uninterruptible state.
> > 
> > Anyway, the check is much less reliable. In case of hung_task,
> > it is enough when the task gets scheduled. In the new check,
> > the task has to do some amount of work until the signal
> > gets handled and do_exit() is called.
> > 
> > The panic should either get enabled separately or we should
> > never panic in this case.
> 
> OK, we should not share existing sysctl settings.
> 
> But in the context of syzbot's testing where there are only 2 CPUs
> in the target VM (which means that only small number of threads and
> not so much memory) and threads get SIGKILL after 5 seconds from fork(),
> being unable to reach do_exit() within 10 seconds is likely a sign of
> something went wrong. For example, 6 out of 7 trials of a reproducer for
> https://syzkaller.appspot.com/bug?id=835a0b9e75b14b55112661cbc61ca8b8f0edf767
> resulted in "no output from test machine" rather than "task hung".
> This patch is revealing that such killed threads are failing to reach
> do_exit() because they are trapped at unkillable retry loop due to a
> race bug.
> 
> Therefore, I would like to try this patch in linux-next.git for feasibility
> testing whether this patch helps finding more bugs and reproducers for such
> bugs, by bringing "unable to terminate threads" reports out of "no output from
> test machine" reports. We can add sysctl settings before sending to linux.git.

In this case, the watchdog should get enabled on with
CONFIG_DEBUG_AID_FOR_SYZBOT

Also we should ask/inform Stephen about this. I am not sure
if he is willing to resolve eventual conflicts for these
syzboot-specific patches that are not upstream candidates.

A solution might be to create sysbot-specific for-next branch
that Stephen might simply ignore when there are conflicts.
And you would be responsible for updating it.

Best Regards,
Petr
