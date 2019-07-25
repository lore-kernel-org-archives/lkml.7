Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BABC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09FD622C97
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Zt4+JZ+q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388159AbfGYOYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:24:41 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52009 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388090AbfGYOYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:24:40 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PEORg11039566
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 07:24:27 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PEORg11039566
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564064668;
        bh=2qBHxeD5wLUTVxwWFqCWlcQD88ubx2LdeEQ/2rXngTk=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Zt4+JZ+q/3m5AVURvAobhoU1y5LucJvY1m/eHZbQFQxzArMjpfmYauahwCI4PpA73
         J3z2cHGtNmdTpycojm3UVqSiDMO4Y1MMwENmOLkH6ysfkR8Mn/SvAIUtjoz08vbVei
         fi2eaFjPq2UHHL9ZCkr/JSDI3JUG3kw2Jbna6c9w9o0dyQ/gYmMlhHuZGNB924GBVW
         4Ymn5E2b9jbBZ0D2zhpq2g53QgeaDdgPVBGnoKZUYYYF73eaebDYql4W6a1WSK3LQ8
         3H+QAQEZBpVWt8BvGY8vk4uvTt3zjkYe+LRXDQoiC0WtirESV+7ckUqqgcpoKEHWwi
         4OBY9AQWdFdbg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PEOQMe1039563;
        Thu, 25 Jul 2019 07:24:26 -0700
Date:   Thu, 25 Jul 2019 07:24:26 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-521b82fee98c1e334ba3a2459ba3739d459e9e4e@git.kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, hpa@zytor.com,
        mingo@kernel.org, peterz@infradead.org
Reply-To: mingo@kernel.org, hpa@zytor.com, peterz@infradead.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de
In-Reply-To: <20190722105219.342631201@linutronix.de>
References: <20190722105219.342631201@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/apic] x86/apic: Cleanup the include maze
Git-Commit-ID: 521b82fee98c1e334ba3a2459ba3739d459e9e4e
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

Commit-ID:  521b82fee98c1e334ba3a2459ba3739d459e9e4e
Gitweb:     https://git.kernel.org/tip/521b82fee98c1e334ba3a2459ba3739d459e9e4e
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 22 Jul 2019 20:47:11 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 25 Jul 2019 16:11:57 +0200

x86/apic: Cleanup the include maze

All of these APIC files include the world and some more. Remove the
unneeded cruft.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190722105219.342631201@linutronix.de

---
 arch/x86/kernel/apic/apic_flat_64.c   | 15 ++++-----------
 arch/x86/kernel/apic/apic_noop.c      | 18 +-----------------
 arch/x86/kernel/apic/apic_numachip.c  |  6 +++---
 arch/x86/kernel/apic/ipi.c            | 17 ++---------------
 arch/x86/kernel/apic/probe_32.c       | 18 ++----------------
 arch/x86/kernel/apic/probe_64.c       | 11 -----------
 arch/x86/kernel/apic/x2apic_cluster.c | 16 +++++++---------
 arch/x86/kernel/apic/x2apic_phys.c    |  9 +++------
 arch/x86/kernel/apic/x2apic_uv_x.c    | 28 ++++------------------------
 9 files changed, 26 insertions(+), 112 deletions(-)

diff --git a/arch/x86/kernel/apic/apic_flat_64.c b/arch/x86/kernel/apic/apic_flat_64.c
index bbdca603f94a..8d7242df1fd6 100644
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -8,21 +8,14 @@
  * Martin Bligh, Andi Kleen, James Bottomley, John Stultz, and
  * James Cleverdon.
  */
-#include <linux/acpi.h>
-#include <linux/errno.h>
-#include <linux/threads.h>
 #include <linux/cpumask.h>
-#include <linux/string.h>
-#include <linux/kernel.h>
-#include <linux/ctype.h>
-#include <linux/hardirq.h>
 #include <linux/export.h>
+#include <linux/acpi.h>
 
-#include <asm/smp.h>
-#include <asm/ipi.h>
-#include <asm/apic.h>
-#include <asm/apic_flat_64.h>
 #include <asm/jailhouse_para.h>
+#include <asm/apic_flat_64.h>
+#include <asm/apic.h>
+#include <asm/ipi.h>
 
 static struct apic apic_physflat;
 static struct apic apic_flat;
diff --git a/arch/x86/kernel/apic/apic_noop.c b/arch/x86/kernel/apic/apic_noop.c
index 5078b5ce63a7..98c9bb75d185 100644
--- a/arch/x86/kernel/apic/apic_noop.c
+++ b/arch/x86/kernel/apic/apic_noop.c
@@ -9,25 +9,9 @@
  * to not uglify the caller's code and allow to call (some) apic routines
  * like self-ipi, etc...
  */
-
-#include <linux/threads.h>
 #include <linux/cpumask.h>
-#include <linux/string.h>
-#include <linux/kernel.h>
-#include <linux/ctype.h>
-#include <linux/errno.h>
-#include <asm/fixmap.h>
-#include <asm/mpspec.h>
-#include <asm/apicdef.h>
-#include <asm/apic.h>
-#include <asm/setup.h>
 
-#include <linux/smp.h>
-#include <asm/ipi.h>
-
-#include <linux/interrupt.h>
-#include <asm/acpi.h>
-#include <asm/e820/api.h>
+#include <asm/apic.h>
 
 static void noop_init_apic_ldr(void) { }
 static void noop_send_IPI(int cpu, int vector) { }
diff --git a/arch/x86/kernel/apic/apic_numachip.c b/arch/x86/kernel/apic/apic_numachip.c
index a5464b8b6c46..e071e8dcb097 100644
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -10,15 +10,15 @@
  * Send feedback to <support@numascale.com>
  *
  */
-
+#include <linux/types.h>
 #include <linux/init.h>
 
 #include <asm/numachip/numachip.h>
 #include <asm/numachip/numachip_csr.h>
-#include <asm/ipi.h>
+
 #include <asm/apic_flat_64.h>
 #include <asm/pgtable.h>
-#include <asm/pci_x86.h>
+#include <asm/ipi.h>
 
 u8 numachip_system __read_mostly;
 static const struct apic apic_numachip1;
diff --git a/arch/x86/kernel/apic/ipi.c b/arch/x86/kernel/apic/ipi.c
index de9764605d31..dad523bbe701 100644
--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -1,21 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
+
 #include <linux/cpumask.h>
-#include <linux/interrupt.h>
-
-#include <linux/mm.h>
-#include <linux/delay.h>
-#include <linux/spinlock.h>
-#include <linux/kernel_stat.h>
-#include <linux/mc146818rtc.h>
-#include <linux/cache.h>
-#include <linux/cpu.h>
-
-#include <asm/smp.h>
-#include <asm/mtrr.h>
-#include <asm/tlbflush.h>
-#include <asm/mmu_context.h>
+
 #include <asm/apic.h>
-#include <asm/proto.h>
 #include <asm/ipi.h>
 
 void __default_send_IPI_shortcut(unsigned int shortcut, int vector, unsigned int dest)
diff --git a/arch/x86/kernel/apic/probe_32.c b/arch/x86/kernel/apic/probe_32.c
index 1492799b8f43..8f3c7f50b0a9 100644
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -6,26 +6,12 @@
  *
  * Generic x86 APIC driver probe layer.
  */
-#include <linux/threads.h>
-#include <linux/cpumask.h>
 #include <linux/export.h>
-#include <linux/string.h>
-#include <linux/kernel.h>
-#include <linux/ctype.h>
-#include <linux/init.h>
 #include <linux/errno.h>
-#include <asm/fixmap.h>
-#include <asm/mpspec.h>
-#include <asm/apicdef.h>
-#include <asm/apic.h>
-#include <asm/setup.h>
-
-#include <linux/smp.h>
-#include <asm/ipi.h>
 
-#include <linux/interrupt.h>
+#include <asm/apic.h>
 #include <asm/acpi.h>
-#include <asm/e820/api.h>
+#include <asm/ipi.h>
 
 #ifdef CONFIG_HOTPLUG_CPU
 #define DEFAULT_SEND_IPI	(1)
diff --git a/arch/x86/kernel/apic/probe_64.c b/arch/x86/kernel/apic/probe_64.c
index e6560a02eb46..f7bd3f48deb2 100644
--- a/arch/x86/kernel/apic/probe_64.c
+++ b/arch/x86/kernel/apic/probe_64.c
@@ -8,19 +8,8 @@
  * Martin Bligh, Andi Kleen, James Bottomley, John Stultz, and
  * James Cleverdon.
  */
-#include <linux/threads.h>
-#include <linux/cpumask.h>
-#include <linux/string.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/ctype.h>
-#include <linux/hardirq.h>
-#include <linux/dmar.h>
-
-#include <asm/smp.h>
 #include <asm/apic.h>
 #include <asm/ipi.h>
-#include <asm/setup.h>
 
 /*
  * Check the APIC IDs in bios_cpu_apicid and choose the APIC mode.
diff --git a/arch/x86/kernel/apic/x2apic_cluster.c b/arch/x86/kernel/apic/x2apic_cluster.c
index 609e499387a1..ebde731dc4cf 100644
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -1,14 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/threads.h>
+
+#include <linux/cpuhotplug.h>
 #include <linux/cpumask.h>
-#include <linux/string.h>
-#include <linux/kernel.h>
-#include <linux/ctype.h>
-#include <linux/dmar.h>
-#include <linux/irq.h>
-#include <linux/cpu.h>
-
-#include <asm/smp.h>
+#include <linux/slab.h>
+#include <linux/mm.h>
+
+#include <asm/apic.h>
+
 #include "x2apic.h"
 
 struct cluster_mask {
diff --git a/arch/x86/kernel/apic/x2apic_phys.c b/arch/x86/kernel/apic/x2apic_phys.c
index b5cf9e7b3830..e5289a0c595b 100644
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -1,13 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/threads.h>
+
 #include <linux/cpumask.h>
-#include <linux/string.h>
-#include <linux/kernel.h>
-#include <linux/ctype.h>
-#include <linux/dmar.h>
+#include <linux/acpi.h>
 
-#include <asm/smp.h>
 #include <asm/ipi.h>
+
 #include "x2apic.h"
 
 int x2apic_phys;
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 1e225528f0d7..73a652093820 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -7,40 +7,20 @@
  *
  * Copyright (C) 2007-2014 Silicon Graphics, Inc. All rights reserved.
  */
+#include <linux/crash_dump.h>
+#include <linux/cpuhotplug.h>
 #include <linux/cpumask.h>
-#include <linux/hardirq.h>
 #include <linux/proc_fs.h>
-#include <linux/threads.h>
-#include <linux/kernel.h>
+#include <linux/memory.h>
 #include <linux/export.h>
-#include <linux/string.h>
-#include <linux/ctype.h>
-#include <linux/sched.h>
-#include <linux/timer.h>
-#include <linux/slab.h>
-#include <linux/cpu.h>
-#include <linux/init.h>
-#include <linux/io.h>
 #include <linux/pci.h>
-#include <linux/kdebug.h>
-#include <linux/delay.h>
-#include <linux/crash_dump.h>
-#include <linux/reboot.h>
-#include <linux/memory.h>
-#include <linux/numa.h>
 
+#include <asm/e820/api.h>
 #include <asm/uv/uv_mmrs.h>
 #include <asm/uv/uv_hub.h>
-#include <asm/current.h>
-#include <asm/pgtable.h>
 #include <asm/uv/bios.h>
 #include <asm/uv/uv.h>
 #include <asm/apic.h>
-#include <asm/e820/api.h>
-#include <asm/ipi.h>
-#include <asm/smp.h>
-#include <asm/x86_init.h>
-#include <asm/nmi.h>
 
 DEFINE_PER_CPU(int, x2apic_extra_bits);
 
