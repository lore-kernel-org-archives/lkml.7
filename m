Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E98C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B8DD2192C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138692;
	bh=Wdtsrp7GyHArUVybB8ZWvGDFp1wPcSaCOPxD+U+dYWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iMVwYbP5CTpQ7YIkiDR8DsqTbrvobDBr+FHMGr0A+pGCghsmZWW/YKzPUEUoBv9DM
	 vvuxoXp8BQEHYZdkkPPJUYS/IXLURyDgKgg+SRMWKFFvXOqp6PTqpfsyTag94YFpGS
	 IiFktCJgYxAxR4Q306zMzFkkTaLcnWPadaTyTUag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbfDARLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:11:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:60148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729158AbfDARL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:11:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEA0021929;
        Mon,  1 Apr 2019 17:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138687;
        bh=Wdtsrp7GyHArUVybB8ZWvGDFp1wPcSaCOPxD+U+dYWE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OH6iBRC+B8cm6gA2HFxv2KL4cVm/qg6patfBKi13o/5RyWWq6h8Bw9RZnk4JC1woD
         SsQyhM6idkMNwJz1vCocuq9ojUZX45UNV7BbAddZ78UnHG5/8v+ZWzHoSOcLeiznFh
         KWyBGbVbYfoTuHfeTRCG9+mke+2cC2IXxJg73LiM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Kosina <jkosina@suse.cz>, Rik van Riel <riel@surriel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Micheal Kelley <michael.h.kelley@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>
Subject: [PATCH 5.0 140/146] cpu/hotplug: Prevent crash when CPU bringup fails on CONFIG_HOTPLUG_CPU=n
Date:   Mon,  1 Apr 2019 19:02:32 +0200
Message-Id: <20190401170059.909396079@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 206b92353c839c0b27a0b9bec24195f93fd6cf7a upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/cpu.c |   20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -555,6 +555,20 @@ static void undo_cpu_up(unsigned int cpu
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
@@ -565,8 +579,10 @@ static int cpuhp_up_callbacks(unsigned i
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


