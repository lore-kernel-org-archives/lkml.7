Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742D6C04AB2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 09:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F56821479
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 09:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbfEJJPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 05:15:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:53908 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727281AbfEJJPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 05:15:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 491E3AE84;
        Fri, 10 May 2019 09:15:38 +0000 (UTC)
Date:   Fri, 10 May 2019 11:15:37 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RFC: console: hack up console_lock more v3
Message-ID: <20190510091537.44e3aeb7gcrcob76@pathway.suse.cz>
References: <20190509120903.28939-1-daniel.vetter@ffwll.ch>
 <20190509145620.2pjqko7copbxuzth@pathway.suse.cz>
 <CAKMK7uFTsr1F8nFExTvC7nWFQMcZ7ejh+k_X6E8EcMUaP3e29A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uFTsr1F8nFExTvC7nWFQMcZ7ejh+k_X6E8EcMUaP3e29A@mail.gmail.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2019-05-09 18:43:12, Daniel Vetter wrote:
> One thing to keep in mind is that the kernel is already dying, and
> things will come crashing down later on

This is important information. I havn't seen it mentioned earlier.

> (I've seen this only in dmesg
> tails capture in pstore in our CI, i.e. the box died for good). I just
> want to make sure that the useful information isn't overwritten by
> more dmesg splats that happen as a consequence of us somehow trying to
> run things on an offline cpu. Once console_unlock has completed in
> your above backtrace and the important stuff has gone out I'm totally
> fine with the kernel just dying. Pulling the wake_up_process out from
> under the semaphore.lock is enough to prevent lockdep from dumping
> more stuff while we're trying to print the important things,

With the more stuff you mean the lockdep splat? If yes, it might
make sense to call debug_locks_off() earlier in panic().


> and I think the untangling of the locking hiararchy is useful irrespective
> of this lockdep splat. Plus Peter doesn't sound like he likes to roll
> out more printk_deferred kind of things.
>
> But if you think I should do the printk_deferred thing too I can look
> into that. Just not quite sure what that's supposed to look like now.

Your patch might remove the particular lockdep splat. It might be
worth it (Peter mentioned also an optimization effect). Anyway
it will not prevent the deadlock.

The only way to avoid the deadlock is to use printk_deferred()
with the current printk() code.


Finally, I have recently worked on similar problem with dying system.
I sent the following patch for testing. I wonder if it might be
acceptable upstream:


From: Petr Mladek <pmladek@suse.com>
Subject: sched/x86: Do not warn about offline CPUs when all are being stopped
Patch-mainline: No, just for testing
References: bsc#1104406

The warning about rescheduling offline CPUs cause dealock when
the CPUs need to get stopped using NMI. It might happen with
logbuf_lock, locks used by console drivers, especially tty.
But it might also be caused by a registered kernel message
dumper, for example, pstore.

The warning is pretty common when there is a high load and
CPUs are being stopped by native_stop_other_cpus(). But
they are not really useful in this context. And they scrolls
the really important messages off the screen.

We need to fix printk() in the long term. But disabling
the message looks reasonable at least in the meantime.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 arch/x86/kernel/smp.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -124,7 +124,8 @@ static bool smp_no_nmi_ipi = false;
  */
 static void native_smp_send_reschedule(int cpu)
 {
-	if (unlikely(cpu_is_offline(cpu))) {
+	if (unlikely(cpu_is_offline(cpu) &&
+		     atomic_read(&stopping_cpu) < 0)) {
 		WARN(1, "sched: Unexpected reschedule of offline CPU#%d!\n", cpu);
 		return;
 	}
