Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFCFC10F03
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27CB02080F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730533AbfCYWje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:39:34 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:47042 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729664AbfCYWje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 18:39:34 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h8YFN-0000MH-1O; Mon, 25 Mar 2019 23:39:13 +0100
Date:   Mon, 25 Mar 2019 23:39:07 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     lantianyu1986@gmail.com
cc:     Ingo Molnar <mingo@kernel.org>, konrad.wilk@oracle.com,
        jpoimboe@redhat.com, mojha@codeaurora.org,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Kosina <jkosina@suse.cz>, riel@surriel.com,
        Andy Lutomirski <luto@kernel.org>, Tianyu.Lan@microsoft.com,
        michael.h.kelley@microsoft.com, kys@microsoft.com,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [Fix PATCH] cpu/hotplug: Fix bug report when add "nosmt" parameter
 with CONFIG_HOTPLUG_CPU=N
In-Reply-To: <alpine.DEB.2.21.1903251455160.1656@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1903252020160.1789@nanos.tec.linutronix.de>
References: <1553521883-20868-1-git-send-email-Tianyu.Lan@microsoft.com> <alpine.DEB.2.21.1903251455160.1656@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Mar 2019, Thomas Gleixner wrote:
> That has nothing to do with 'nosmt'. It's a general bug in the rollback
> code when HOTPLUG_CPU=n. 'nosmt' is using the rollback mechanism and is
> just a reliable way to trigger the problem. This happens in the same way
> when the bringup of a CPU fails for any other reason. That bug was there
> way before 0cc3cd21657b.
> 
> I'll have a look, but I fear that needs some surgery to fix.

This is SMP=y HOTPLUG_CPU=n case is broken and was broken forever.

Of course that tglx moron did not notice this particular wreckage when
cleaning up the hotplug code. So we just kept the historical brainfart
around.

The problem is that a failure in the bringup path triggers the rollback
down to the point where the CPU is dead and resources are cleaned up.

But the interesting part of the rollback, i.e. takedown_cpu(), is not
available when CONFIG_HOTPLUG_CPU=n.

As a consequence the former CPU_DYING callbacks are invoked on the control
CPU with interrupts disabled. That rightfully explodes and even if
interrupts were disabled then it's still violating the fundamental
requirements of CPU unplug which include stop machine and various
synchronizations in facilities like RCU which are all unavailable with
HOTPLUG_CPU=n.

The pre state machine code has a different failure mode, but the end result
is a straight forward crash as well. Just less obvious to decode.

So the SMP=y HOTPLUG_CPU=n onlining is just working by chance as long as
none of the bringup callbacks fails.

'nosmt' exposes this flaw nicely because the wonderful MCE design of x86
forces us to bringup the sibling thread and then tear it down right
away. That's equivalent to a callback failure and triggers the same
rollback code which is broken...

But this is not a x86 only problem. Any architecture which supports the
SMP=y HOTPLUG_CPU=n combination suffers from the same issue. It's just less
likely to be triggered because in 99.99999% of the cases all bringup
callbacks succeed.

Now making HOTPLUG_CPU mandatory for SMP is not working on all
architectures as the following architectures have either no hotplug support
at all or not all subarchitectures support it:

alpha, arc, hexagon, openrisc, riscv, sparc (32bit), mips (partial).

So I looked into a 'minimal rollback' for the HOTPLUG=n case which prevents
at least the full crash. That would mean:

 - the CPU is brought down to the point where the stop_machine takedown
   would happen.

 - the CPU stays there forever and is idle

 - The CPU is cleared in the CPU active mask, but not in the CPU online
   mask which is a legit state.

 - Interrupts are not forced away from the CPU

 - All facilities which only look at online mask would still see it, but
   that is the case on normal hotplug/unplug operations as well. It's just
   a longer time frame.

There might be some subtle stuff broken, but that's something we should
figure out anyway as it's then also broken during unplug to the point where
it is actually taken down. Letting it stay there just increases the time
window. Same applies for the onlining path.

And indeed with that minimal rollback workaround in place this makes the
vmstat code trigger an preemtible warning because it schedules work on a
CPU which is online but inactive. The workqueue for that CPU is not bound
yet and that triggers a preemptible warning of some sort over and over.

And that's not a problem of the workaround. Just onlining the CPU to the
same point makes that problem visible as well.

A simple test which delayed the full onlining of a CPU and a test module
scheduling work on this already marked online CPU triggers the same issue
when the worker callback uses e.g. this_cpu_read(). So there is some nasty
crap lurking all over the place.

We surely want to fix the fallout of this, but I think the sane short term
solution for x86 is to enforce HOTPLUG_CPU when SMP is enabled which is
also the sane and simple fix for backporting. That 'nosmt' stuff is popular
nowadays for some reasons.

Minimal rollback patch to prevent crashing below.

Thoughts?

	tglx

8<----------------
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -564,6 +564,20 @@ static void undo_cpu_up(unsigned int cpu
 		cpuhp_invoke_callback(cpu, st->state, false, NULL, NULL);
 }
 
+static inline bool can_rollback_cpu(struct cpuhp_cpu_state *st)
+{
+	if (IS_ENABLED(CONFIG_HOTPLUG_CPU))
+		return true;
+	/*
+	 * When CPU hotplug is disabled, then taking the CPU down is not
+	 * possible because takedown_cpu() and the architecture and
+	 * subsystem specific mechanisms are not available. So the CPU
+	 * which would be completely unplugged again needs to stay around
+	 * in the current state, i.e. <= CPUHP_AP_ONLINE_IDLE.
+	 */
+	return st->state <= CPUHP_BRINGUP_CPU;
+}
+
 static int cpuhp_up_callbacks(unsigned int cpu, struct cpuhp_cpu_state *st,
 			      enum cpuhp_state target)
 {
@@ -574,8 +588,10 @@ static int cpuhp_up_callbacks(unsigned i
 		st->state++;
 		ret = cpuhp_invoke_callback(cpu, st->state, true, NULL, NULL);
 		if (ret) {
-			st->target = prev_state;
-			undo_cpu_up(cpu, st);
+			if (can_rollback_cpu(st)) {
+				st->target = prev_state;
+				undo_cpu_up(cpu, st);
+			}
 			break;
 		}
 	}

