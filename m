Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98118C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 667C82082F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbfC1Mj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 08:39:26 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57259 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727581AbfC1MjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 08:39:24 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2SCcb4A3318555
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 28 Mar 2019 05:38:37 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2SCcblE3318552;
        Thu, 28 Mar 2019 05:38:37 -0700
Date:   Thu, 28 Mar 2019 05:38:37 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-206b92353c839c0b27a0b9bec24195f93fd6cf7a@git.kernel.org>
Cc:     peterz@infradead.org, hpa@zytor.com, gregkh@linuxfoundation.org,
        tglx@linutronix.de, bp@alien8.de, michael.h.kelley@microsoft.com,
        linux-kernel@vger.kernel.org, jkosina@suse.cz,
        Tianyu.Lan@microsoft.com, mingo@kernel.org,
        torvalds@linux-foundation.org, konrad.wilk@oracle.com,
        mojha@codeaurora.org, luto@kernel.org, riel@surriel.com,
        kys@microsoft.com, jpoimboe@redhat.com
Reply-To: riel@surriel.com, luto@kernel.org, mojha@codeaurora.org,
          jpoimboe@redhat.com, kys@microsoft.com, bp@alien8.de,
          tglx@linutronix.de, hpa@zytor.com, gregkh@linuxfoundation.org,
          peterz@infradead.org, konrad.wilk@oracle.com,
          torvalds@linux-foundation.org, Tianyu.Lan@microsoft.com,
          jkosina@suse.cz, mingo@kernel.org, linux-kernel@vger.kernel.org,
          michael.h.kelley@microsoft.com
In-Reply-To: <20190326163811.503390616@linutronix.de>
References: <20190326163811.503390616@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:smp/urgent] cpu/hotplug: Prevent crash when CPU bringup fails
 on CONFIG_HOTPLUG_CPU=n
Git-Commit-ID: 206b92353c839c0b27a0b9bec24195f93fd6cf7a
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  206b92353c839c0b27a0b9bec24195f93fd6cf7a
Gitweb:     https://git.kernel.org/tip/206b92353c839c0b27a0b9bec24195f93fd6cf7a
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Tue, 26 Mar 2019 17:36:05 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 28 Mar 2019 13:34:58 +0100

cpu/hotplug: Prevent crash when CPU bringup fails on CONFIG_HOTPLUG_CPU=n

Tianyu reported a crash in a CPU hotplug teardown callback when booting a
kernel which has CONFIG_HOTPLUG_CPU disabled with the 'nosmt' boot
parameter.

It turns out that the SMP=y CONFIG_HOTPLUG_CPU=n case has been broken
forever in case that a bringup callback fails. Unfortunately this issue was
not recognized when the CPU hotplug code was reworked, so the shortcoming
just stayed in place.

When a bringup callback fails, the CPU hotplug code rolls back the
operation and takes the CPU offline.

The 'nosmt' command line argument uses a bringup failure to abort the
bringup of SMT sibling CPUs. This partial bringup is required due to the
MCE misdesign on Intel CPUs.

With CONFIG_HOTPLUG_CPU=y the rollback works perfectly fine, but
CONFIG_HOTPLUG_CPU=n lacks essential mechanisms to exercise the low level
teardown of a CPU including the synchronizations in various facilities like
RCU, NOHZ and others.

As a consequence the teardown callbacks which must be executed on the
outgoing CPU within stop machine with interrupts disabled are executed on
the control CPU in interrupt enabled and preemptible context causing the
kernel to crash and burn. The pre state machine code has a different
failure mode which is more subtle and resulting in a less obvious use after
free crash because the control side frees resources which are still in use
by the undead CPU.

But this is not a x86 only problem. Any architecture which supports the
SMP=y HOTPLUG_CPU=n combination suffers from the same issue. It's just less
likely to be triggered because in 99.99999% of the cases all bringup
callbacks succeed.

The easy solution of making HOTPLUG_CPU mandatory for SMP is not working on
all architectures as the following architectures have either no hotplug
support at all or not all subarchitectures support it:

 alpha, arc, hexagon, openrisc, riscv, sparc (32bit), mips (partial).

Crashing the kernel in such a situation is not an acceptable state
either.

Implement a minimal rollback variant by limiting the teardown to the point
where all regular teardown callbacks have been invoked and leave the CPU in
the 'dead' idle state. This has the following consequences:

 - the CPU is brought down to the point where the stop_machine takedown
   would happen.

 - the CPU stays there forever and is idle

 - The CPU is cleared in the CPU active mask, but not in the CPU online
   mask which is a legit state.

 - Interrupts are not forced away from the CPU

 - All facilities which only look at online mask would still see it, but
   that is the case during normal hotplug/unplug operations as well. It's
   just a (way) longer time frame.

This will expose issues, which haven't been exposed before or only seldom,
because now the normally transient state of being non active but online is
a permanent state. In testing this exposed already an issue vs. work queues
where the vmstat code schedules work on the almost dead CPU which ends up
in an unbound workqueue and triggers 'preemtible context' warnings. This is
not a problem of this change, it merily exposes an already existing issue.
Still this is better than crashing fully without a chance to debug it.

This is mainly thought as workaround for those architectures which do not
support HOTPLUG_CPU. All others should enforce HOTPLUG_CPU for SMP.

Fixes: 2e1a3483ce74 ("cpu/hotplug: Split out the state walk into functions")
Reported-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Konrad Wilk <konrad.wilk@oracle.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Mukesh Ojha <mojha@codeaurora.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Rik van Riel <riel@surriel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Micheal Kelley <michael.h.kelley@microsoft.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20190326163811.503390616@linutronix.de

---
 kernel/cpu.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 025f419d16f6..6754f3ecfd94 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -564,6 +564,20 @@ static void undo_cpu_up(unsigned int cpu, struct cpuhp_cpu_state *st)
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
+	 * in the current state.
+	 */
+	return st->state <= CPUHP_BRINGUP_CPU;
+}
+
 static int cpuhp_up_callbacks(unsigned int cpu, struct cpuhp_cpu_state *st,
 			      enum cpuhp_state target)
 {
@@ -574,8 +588,10 @@ static int cpuhp_up_callbacks(unsigned int cpu, struct cpuhp_cpu_state *st,
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
