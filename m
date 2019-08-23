Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5EEC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 18:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FB1D21874
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 18:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405125AbfHWSnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 14:43:50 -0400
Received: from barracuda.ghs.com ([209.234.187.110]:47353 "EHLO fang.ghs.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389333AbfHWSnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 14:43:50 -0400
X-Greylist: delayed 1006 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Aug 2019 14:43:49 EDT
X-ASG-Debug-ID: 1566584822-05da2076ee0d370001-xx1T2L
Received: from allegro.ghs.com (allegro.ghs.com [192.168.64.231]) by fang.ghs.com with ESMTP id PEb5IasevopoHzR4; Fri, 23 Aug 2019 11:27:02 -0700 (PDT)
X-Barracuda-Envelope-From: tmontague@ghs.com
X-Barracuda-RBL-Trusted-Forwarder: 192.168.64.231
Received: from cat.ghs.com (cat.eastvic.ghs.com [10.21.2.15])
        by allegro.ghs.com (Postfix) with ESMTP id 3E5CE70A19D;
        Fri, 23 Aug 2019 11:27:02 -0700 (PDT)
Received: by cat.ghs.com (Postfix, from userid 4841)
        id 3AAF4320D01; Fri, 23 Aug 2019 11:27:02 -0700 (PDT)
X-Barracuda-RBL-IP: 10.21.2.15
From:   Tim Montague <tmontague@ghs.com>
To:     chad.page@ghs.com
Cc:     rtos-code-review@ghs.com,
        Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
        Mike Galbraith <efault@gmx.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Tim Montague <tmontague@ghs.com>
Subject: VIRT-6865: Merge PARAVIRT_TIME_ACCOUNTING support
Date:   Fri, 23 Aug 2019 11:27:02 -0700
X-ASG-Orig-Subj: VIRT-6865: Merge PARAVIRT_TIME_ACCOUNTING support
Message-Id: <20190823182702.24518-1-tmontague@ghs.com>
X-Mailer: git-send-email 2.17.1
X-Barracuda-Connect: allegro.ghs.com[192.168.64.231]
X-Barracuda-Start-Time: 1566584822
X-Barracuda-URL: https://192.168.64.230:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at ghs.com
X-Barracuda-Scan-Msg-Size: 6212
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.51
X-Barracuda-Spam-Status: No, SCORE=0.51 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=5.0 tests=BSF_RULE7568M, BSF_SC0_SA_TO_FROM_DOMAIN_MATCH
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.75649
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.50 BSF_RULE7568M          Custom Rule 7568M
        0.01 BSF_SC0_SA_TO_FROM_DOMAIN_MATCH Sender Domain Matches Recipient
                                   Domain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

This is for the qualcomm-bsp-ghs_8x96autogvmquin44_d7 branch.

My checkout with this change is here:
/home/cat/tmontague/linux-kernels/qualcomm-bsp-ghs
Feel free to poke around.


Commit message:

This is a combination of 2 commits:

commit 3f8f3fcd92d4c9fdcbf27eab39329c067521cf6a
 Author: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
 Date:   Mon Nov 23 10:33:49 2015 +0000
---
arm64: introduce CONFIG_PARAVIRT, PARAVIRT_TIME_ACCOUNTING and pv_time_ops

Introduce CONFIG_PARAVIRT and PARAVIRT_TIME_ACCOUNTING on ARM64.
Necessary duplication of paravirt.h and paravirt.c with ARM.

The only paravirt interface supported is pv_time_ops.steal_clock, so no
runtime pvops patching needed.

This allows us to make use of steal_account_process_tick for stolen
ticks accounting.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
---

commit 692afb7fe6c312bcfb3e77913d1efa0cdedec5be
 Author: Ingo Molnar <mingo@kernel.org>
 Date:   Thu Feb 2 14:47:27 2017 +0100
---
sched/headers: Prepare header dependency changes, move the <asm/paravirt.h> include to kernel/sched/sched.h

Recent header reorganizations unearthed this hidden dependency:

  kernel/sched/core.c:199:25: error: 'paravirt_steal_rq_enabled' undeclared (first use in this function)
  kernel/sched/core.c:200:11: error: implicit declaration of function 'paravirt_steal_clock' [-Werror=implicit-function-declaration]

So move the asm/paravirt.h include from kernel/sched/cpuclock.c to kernel/sched/sched.h.

( NOTE: We do this change before doing the changes that introduce the build failure,
        so the series remains fully bisectable. )

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---

Signed-off-by: Tim Montague <tmontague@ghs.com>
---
 arch/arm64/Kconfig                | 20 ++++++++++++++++++++
 arch/arm64/include/asm/paravirt.h | 20 ++++++++++++++++++++
 arch/arm64/kernel/paravirt.c      | 25 +++++++++++++++++++++++++
 kernel/sched/cputime.c            |  1 -
 kernel/sched/sched.h              |  4 ++++
 5 files changed, 69 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/include/asm/paravirt.h
 create mode 100644 arch/arm64/kernel/paravirt.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 0567e2121bc9..3984fbb10b9b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -774,6 +774,25 @@ config SECCOMP
 	  and the task is only allowed to execute a few safe syscalls
 	  defined by each seccomp mode.
 
+config PARAVIRT
+	bool "Enable paravirtualization code"
+	help
+	  This changes the kernel so it can modify itself when it is run
+	  under a hypervisor, potentially improving performance significantly
+	  over full virtualization.
+
+config PARAVIRT_TIME_ACCOUNTING
+	bool "Paravirtual steal time accounting"
+	select PARAVIRT
+	default n
+	help
+	  Select this option to enable fine granularity task steal time
+	  accounting. Time spent executing other tasks in parallel with
+	  the current vCPU is discounted from the vCPU power. To account for
+	  that, there can be a small performance impact.
+
+	  If in doubt, say N here.
+
 config XEN_DOM0
 	def_bool y
 	depends on XEN
@@ -782,6 +801,7 @@ config XEN
 	bool "Xen guest support on ARM64"
 	depends on ARM64 && OF
 	select SWIOTLB_XEN
+	select PARAVIRT
 	help
 	  Say Y if you want to run Linux in a Virtual Machine on Xen on ARM64.
 
diff --git a/arch/arm64/include/asm/paravirt.h b/arch/arm64/include/asm/paravirt.h
new file mode 100644
index 000000000000..fd5f42886251
--- /dev/null
+++ b/arch/arm64/include/asm/paravirt.h
@@ -0,0 +1,20 @@
+#ifndef _ASM_ARM64_PARAVIRT_H
+#define _ASM_ARM64_PARAVIRT_H
+
+#ifdef CONFIG_PARAVIRT
+struct static_key;
+extern struct static_key paravirt_steal_enabled;
+extern struct static_key paravirt_steal_rq_enabled;
+
+struct pv_time_ops {
+	unsigned long long (*steal_clock)(int cpu);
+};
+extern struct pv_time_ops pv_time_ops;
+
+static inline u64 paravirt_steal_clock(int cpu)
+{
+	return pv_time_ops.steal_clock(cpu);
+}
+#endif
+
+#endif
diff --git a/arch/arm64/kernel/paravirt.c b/arch/arm64/kernel/paravirt.c
new file mode 100644
index 000000000000..53f371ed4568
--- /dev/null
+++ b/arch/arm64/kernel/paravirt.c
@@ -0,0 +1,25 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * Copyright (C) 2013 Citrix Systems
+ *
+ * Author: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
+ */
+
+#include <linux/export.h>
+#include <linux/jump_label.h>
+#include <linux/types.h>
+#include <asm/paravirt.h>
+
+struct static_key paravirt_steal_enabled;
+struct static_key paravirt_steal_rq_enabled;
+
+struct pv_time_ops pv_time_ops;
+EXPORT_SYMBOL_GPL(pv_time_ops);
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index bd4ef2bb551e..01c2f225d0b0 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -7,7 +7,6 @@
 #include <linux/cpufreq_times.h>
 #include "sched.h"
 
-
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b6cd12998f16..b2843f584029 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -10,6 +10,10 @@
 #include <linux/tick.h>
 #include <linux/slab.h>
 
+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt.h>
+#endif
+
 #include "cpupri.h"
 #include "cpudeadline.h"
 #include "cpuacct.h"
-- 
2.17.1

