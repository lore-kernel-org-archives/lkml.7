Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1ABC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D63F92171F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139717;
	bh=NyVSjghFeXh5/0JxhMerh7jOw6eFFnOZjbrWklNtVvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Xqk2IBzv5FkpN64b3K2Z8sVwBr665BSX+2s7Iyx8UYQ8hABeFDcFkK6lSSgOAOKe5
	 PanhXgzO2qmDejsClK0YZ2jimnL/5/O3T0X9kgmfdZegY2MO/YUNGd64j0P5AeyKSZ
	 kSfStWAMZlD+2lgrydJmt4l7z6M6pTjblIaQqNiw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732805AbfDAR2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:28:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:34468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732305AbfDAR2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:28:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CBD120830;
        Mon,  1 Apr 2019 17:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139712;
        bh=NyVSjghFeXh5/0JxhMerh7jOw6eFFnOZjbrWklNtVvA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mcgvP6mMHtNoWyaM8WAIBB7UrYXLs4DmFs/rB62FI/nABy9gI6zBdHEr0Kk5KbOKZ
         +8ltrciHBnF4ao5BAEJMoZzGaR82IHjHXCjf5YOY3xxPS//izGUU5WkDyUp/E9bU4F
         1xtcN5PfbzzuGRRLFxjCvy/xE/j7ih9w4M7yAybc=
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
Subject: [PATCH 4.9 49/56] cpu/hotplug: Prevent crash when CPU bringup fails on CONFIG_HOTPLUG_CPU=n
Date:   Mon,  1 Apr 2019 19:03:05 +0200
Message-Id: <20190401170106.565033962@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170103.398401360@linuxfoundation.org>
References: <20190401170103.398401360@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -591,6 +591,20 @@ static void undo_cpu_up(unsigned int cpu
 	}
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
@@ -601,8 +615,10 @@ static int cpuhp_up_callbacks(unsigned i
 		st->state++;
 		ret = cpuhp_invoke_callback(cpu, st->state, true, NULL);
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


