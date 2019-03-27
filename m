Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A743C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64E462070B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553712051;
	bh=W39xZzmcFxMZ9P9UBwxhB92m4IFDSiF9na2MX6BvXnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i0AHNzuz7OkNuOPUgUDekkZrsk93xNl59LtzQZpnpS/0M4gQeQb6JAC3uQeMy2XXv
	 hgH4yHqmOImhtFjVrZ2gW49Q6qEWnYhzmTa2Q4BOhKF6CqWjphqE3WyaTJ8QX9GbIu
	 CeYr/UmfS89refiL3Um0F+4UMNrYbTuEvgWafyac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404098AbfC0Sku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:40:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:40870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391338AbfC0SWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:22:42 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E523120449;
        Wed, 27 Mar 2019 18:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710961;
        bh=W39xZzmcFxMZ9P9UBwxhB92m4IFDSiF9na2MX6BvXnM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iwrXCdNm3luzJXL4TRfRWerAgdXVpFgDzXtraZ+4hXELwvSY+Wd1k79bhxhEINo4i
         D/qZMMvxrDo0YE7+WsPziZsPkjYdG5U2ms0mgXkA0UY5JnG1qyO3VYM4Jx8Z4lvqff
         v30m7WZUDkUQDiQKhkhpZMi64p+Pj2/KNo11BBuE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 66/87] ARM: avoid Cortex-A9 livelock on tight dmb loops
Date:   Wed, 27 Mar 2019 14:20:19 -0400
Message-Id: <20190327182040.17444-66-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327182040.17444-1-sashal@kernel.org>
References: <20190327182040.17444-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+kernel@armlinux.org.uk>

[ Upstream commit 5388a5b82199facacd3d7ac0d05aca6e8f902fed ]

machine_crash_nonpanic_core() does this:

	while (1)
		cpu_relax();

because the kernel has crashed, and we have no known safe way to deal
with the CPU.  So, we place the CPU into an infinite loop which we
expect it to never exit - at least not until the system as a whole is
reset by some method.

In the absence of erratum 754327, this code assembles to:

	b	.

In other words, an infinite loop.  When erratum 754327 is enabled,
this becomes:

1:	dmb
	b	1b

It has been observed that on some systems (eg, OMAP4) where, if a
crash is triggered, the system tries to kexec into the panic kernel,
but fails after taking the secondary CPU down - placing it into one
of these loops.  This causes the system to livelock, and the most
noticable effect is the system stops after issuing:

	Loading crashdump kernel...

to the system console.

The tested as working solution I came up with was to add wfe() to
these infinite loops thusly:

	while (1) {
		cpu_relax();
		wfe();
	}

which, without 754327 builds to:

1:	wfe
	b	1b

or with 754327 is enabled:

1:	dmb
	wfe
	b	1b

Adding "wfe" does two things depending on the environment we're running
under:
- where we're running on bare metal, and the processor implements
  "wfe", it stops us spinning endlessly in a loop where we're never
  going to do any useful work.
- if we're running in a VM, it allows the CPU to be given back to the
  hypervisor and rescheduled for other purposes (maybe a different VM)
  rather than wasting CPU cycles inside a crashed VM.

However, in light of erratum 794072, Will Deacon wanted to see 10 nops
as well - which is reasonable to cover the case where we have erratum
754327 enabled _and_ we have a processor that doesn't implement the
wfe hint.

So, we now end up with:

1:      wfe
        b       1b

when erratum 754327 is disabled, or:

1:      dmb
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        wfe
        b       1b

when erratum 754327 is enabled.  We also get the dmb + 10 nop
sequence elsewhere in the kernel, in terminating loops.

This is reasonable - it means we get the workaround for erratum
794072 when erratum 754327 is enabled, but still relinquish the dead
processor - either by placing it in a lower power mode when wfe is
implemented as such or by returning it to the hypervisior, or in the
case where wfe is a no-op, we use the workaround specified in erratum
794072 to avoid the problem.

These as two entirely orthogonal problems - the 10 nops addresses
erratum 794072, and the wfe is an optimisation that makes the system
more efficient when crashed either in terms of power consumption or
by allowing the host/other VMs to make use of the CPU.

I don't see any reason not to use kexec() inside a VM - it has the
potential to provide automated recovery from a failure of the VMs
kernel with the opportunity for saving a crashdump of the failure.
A panic() with a reboot timeout won't do that, and reading the
libvirt documentation, setting on_reboot to "preserve" won't either
(the documentation states "The preserve action for an on_reboot event
is treated as a destroy".)  Surely it has to be a good thing to
avoiding having CPUs spinning inside a VM that is doing no useful
work.

Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/include/asm/barrier.h   | 2 ++
 arch/arm/include/asm/processor.h | 6 +++++-
 arch/arm/kernel/machine_kexec.c  | 5 ++++-
 arch/arm/kernel/smp.c            | 4 +++-
 arch/arm/mach-omap2/prm_common.c | 4 +++-
 5 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/barrier.h b/arch/arm/include/asm/barrier.h
index 513e03d138ea..8331cb0d3461 100644
--- a/arch/arm/include/asm/barrier.h
+++ b/arch/arm/include/asm/barrier.h
@@ -10,6 +10,8 @@
 #define sev()	__asm__ __volatile__ ("sev" : : : "memory")
 #define wfe()	__asm__ __volatile__ ("wfe" : : : "memory")
 #define wfi()	__asm__ __volatile__ ("wfi" : : : "memory")
+#else
+#define wfe()	do { } while (0)
 #endif
 
 #if __LINUX_ARM_ARCH__ >= 7
diff --git a/arch/arm/include/asm/processor.h b/arch/arm/include/asm/processor.h
index 8a1e8e995dae..08509183c7df 100644
--- a/arch/arm/include/asm/processor.h
+++ b/arch/arm/include/asm/processor.h
@@ -77,7 +77,11 @@ extern void release_thread(struct task_struct *);
 unsigned long get_wchan(struct task_struct *p);
 
 #if __LINUX_ARM_ARCH__ == 6 || defined(CONFIG_ARM_ERRATA_754327)
-#define cpu_relax()			smp_mb()
+#define cpu_relax()						\
+	do {							\
+		smp_mb();					\
+		__asm__ __volatile__("nop; nop; nop; nop; nop; nop; nop; nop; nop; nop;");	\
+	} while (0)
 #else
 #define cpu_relax()			barrier()
 #endif
diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index b18c1ea56bed..ef6b27fe1d2e 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -87,8 +87,11 @@ void machine_crash_nonpanic_core(void *unused)
 
 	set_cpu_online(smp_processor_id(), false);
 	atomic_dec(&waiting_for_crash_ipi);
-	while (1)
+
+	while (1) {
 		cpu_relax();
+		wfe();
+	}
 }
 
 static void machine_kexec_mask_interrupts(void)
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index bc83ec7ed53f..7a5dc011c523 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -602,8 +602,10 @@ static void ipi_cpu_stop(unsigned int cpu)
 	local_fiq_disable();
 	local_irq_disable();
 
-	while (1)
+	while (1) {
 		cpu_relax();
+		wfe();
+	}
 }
 
 static DEFINE_PER_CPU(struct completion *, cpu_completion);
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index f1ca9479491b..9e14604b9642 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -533,8 +533,10 @@ void omap_prm_reset_system(void)
 
 	prm_ll_data->reset_system();
 
-	while (1)
+	while (1) {
 		cpu_relax();
+		wfe();
+	}
 }
 
 /**
-- 
2.19.1

