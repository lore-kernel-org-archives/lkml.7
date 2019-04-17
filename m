Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFCFC10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 10:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A299E21773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 10:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731784AbfDQKUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 06:20:53 -0400
Received: from mga09.intel.com ([134.134.136.24]:32514 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728237AbfDQKUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 06:20:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Apr 2019 03:20:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,361,1549958400"; 
   d="scan'208";a="338401463"
Received: from aubrey-lkp.sh.intel.com ([10.239.97.113])
  by fmsmga005.fm.intel.com with ESMTP; 17 Apr 2019 03:20:48 -0700
From:   Aubrey Li <aubrey.li@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, peterz@infradead.org,
        hpa@zytor.com
Cc:     ak@linux.intel.com, tim.c.chen@linux.intel.com,
        dave.hansen@intel.com, arjan@linux.intel.com, adobriyan@gmail.com,
        akpm@linux-foundation.org, aubrey.li@intel.com,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aubrey Li <aubrey.li@linux.intel.com>
Subject: [PATCH v16 2/3] x86,/proc/pid/status: Add AVX-512 usage elapsed time
Date:   Wed, 17 Apr 2019 18:18:39 +0800
Message-Id: <20190417101840.2926-2-aubrey.li@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190417101840.2926-1-aubrey.li@linux.intel.com>
References: <20190417101840.2926-1-aubrey.li@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AVX-512 components use could cause core turbo frequency drop. So
it's useful to expose AVX-512 usage elapsed time as a heuristic hint
for the user space job scheduler to cluster the AVX-512 using tasks
together.

Tensorflow example:
$ while [ 1 ]; do cat /proc/tid/status | grep AVX; sleep 1; done
AVX512_elapsed_ms:      4
AVX512_elapsed_ms:      8
AVX512_elapsed_ms:      4

This means that 4 milliseconds have elapsed since the AVX512 usage
of tensorflow task was detected when the task was scheduled out.

Or:
$ cat /proc/tid/status | grep AVX512_elapsed_ms
AVX512_elapsed_ms:      -1

The number '-1' indicates that no AVX512 usage recorded before
thus the task unlikely has frequency drop issue.

User space tools may want to further check by:

$ perf stat --pid <pid> -e core_power.lvl2_turbo_license -- sleep 1

 Performance counter stats for process id '3558':

     3,251,565,961      core_power.lvl2_turbo_license

       1.004031387 seconds time elapsed

Non-zero counter value confirms that the task causes frequency drop.

Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Linux API <linux-api@vger.kernel.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 arch/x86/include/asm/processor.h |  4 +++
 arch/x86/kernel/fpu/xstate.c     | 42 ++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 2bb3a648fc12..5a7271ab78d8 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -991,4 +991,8 @@ enum l1tf_mitigations {
 
 extern enum l1tf_mitigations l1tf_mitigation;
 
+/* Add support for architecture specific output in /proc/pid/status */
+void arch_proc_pid_status(struct seq_file *m, struct task_struct *task);
+#define arch_proc_pid_status arch_proc_pid_status
+
 #endif /* _ASM_X86_PROCESSOR_H */
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index d7432c2b1051..5e55ed9584ab 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -7,6 +7,8 @@
 #include <linux/cpu.h>
 #include <linux/mman.h>
 #include <linux/pkeys.h>
+#include <linux/seq_file.h>
+#include <linux/proc_fs.h>
 
 #include <asm/fpu/api.h>
 #include <asm/fpu/internal.h>
@@ -1243,3 +1245,43 @@ int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf)
 
 	return 0;
 }
+
+/*
+ * Report the amount of time elapsed in millisecond since last AVX512
+ * use in the task.
+ */
+static void avx512_status(struct seq_file *m, struct task_struct *task)
+{
+	unsigned long timestamp = READ_ONCE(task->thread.fpu.avx512_timestamp);
+	long delta;
+
+	if (!timestamp) {
+		/*
+		 * Report -1 if no AVX512 usage
+		 */
+		delta = -1;
+	} else {
+		delta = (long)(jiffies - timestamp);
+		/*
+		 * Cap to LONG_MAX if time difference > LONG_MAX
+		 */
+		if (delta < 0)
+			delta = LONG_MAX;
+		delta = jiffies_to_msecs(delta);
+	}
+
+	seq_put_decimal_ll(m, "AVX512_elapsed_ms:\t", delta);
+	seq_putc(m, '\n');
+}
+
+/*
+ * Report architecture specific information
+ */
+void arch_proc_pid_status(struct seq_file *m, struct task_struct *task)
+{
+	/*
+	 * Report AVX512 state if the processor and build option supported.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_AVX512F))
+		avx512_status(m, task);
+}
-- 
2.21.0

