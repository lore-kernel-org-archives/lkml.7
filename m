Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4948BC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55F3920717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfDYOd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 10:33:29 -0400
Received: from mga17.intel.com ([192.55.52.151]:50006 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbfDYOd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 10:33:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Apr 2019 07:33:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,394,1549958400"; 
   d="scan'208";a="134317349"
Received: from aubrey-skl.sh.intel.com ([10.239.53.6])
  by orsmga007.jf.intel.com with ESMTP; 25 Apr 2019 07:33:25 -0700
From:   Aubrey Li <aubrey.li@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, peterz@infradead.org,
        hpa@zytor.com
Cc:     ak@linux.intel.com, tim.c.chen@linux.intel.com,
        dave.hansen@intel.com, arjan@linux.intel.com, adobriyan@gmail.com,
        akpm@linux-foundation.org, aubrey.li@intel.com,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v18 1/3] proc: add /proc/<pid>/arch_status
Date:   Thu, 25 Apr 2019 22:32:17 +0800
Message-Id: <20190425143219.102258-1-aubrey.li@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The architecture specific information of the running processes
could be useful to the userland. Add /proc/<pid>/arch_status
interface support to examine process architecture specific
information externally.

Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Linux API <linux-api@vger.kernel.org>
---
 fs/proc/Kconfig         | 4 ++++
 fs/proc/base.c          | 6 ++++++
 include/linux/proc_fs.h | 9 +++++++++
 3 files changed, 19 insertions(+)

diff --git a/fs/proc/Kconfig b/fs/proc/Kconfig
index 817c02b13b1d..d80ebf19d5f1 100644
--- a/fs/proc/Kconfig
+++ b/fs/proc/Kconfig
@@ -97,3 +97,7 @@ config PROC_CHILDREN
 
 	  Say Y if you are running any user-space software which takes benefit from
 	  this interface. For example, rkt is such a piece of software.
+
+config PROC_PID_ARCH_STATUS
+	def_bool n
+	depends on PROC_FS
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 6a803a0b75df..8c71eba47031 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3061,6 +3061,9 @@ static const struct pid_entry tgid_base_stuff[] = {
 #ifdef CONFIG_STACKLEAK_METRICS
 	ONE("stack_depth", S_IRUGO, proc_stack_depth),
 #endif
+#ifdef CONFIG_PROC_PID_ARCH_STATUS
+	ONE("arch_status", S_IRUGO, proc_pid_arch_status),
+#endif
 };
 
 static int proc_tgid_base_readdir(struct file *file, struct dir_context *ctx)
@@ -3449,6 +3452,9 @@ static const struct pid_entry tid_base_stuff[] = {
 #ifdef CONFIG_LIVEPATCH
 	ONE("patch_state",  S_IRUSR, proc_pid_patch_state),
 #endif
+#ifdef CONFIG_PROC_PID_ARCH_STATUS
+	ONE("arch_status", S_IRUGO, proc_pid_arch_status),
+#endif
 };
 
 static int proc_tid_base_readdir(struct file *file, struct dir_context *ctx)
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index 52a283ba0465..a705aa2d03f9 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -75,6 +75,15 @@ struct proc_dir_entry *proc_create_net_single_write(const char *name, umode_t mo
 						    void *data);
 extern struct pid *tgid_pidfd_to_pid(const struct file *file);
 
+#ifdef CONFIG_PROC_PID_ARCH_STATUS
+/*
+ * The architecture which selects CONFIG_PROC_PID_ARCH_STATUS must
+ * provide proc_pid_arch_status() definition.
+ */
+int proc_pid_arch_status(struct seq_file *m, struct pid_namespace *ns,
+			struct pid *pid, struct task_struct *task);
+#endif /* CONFIG_PROC_PID_ARCH_STATUS */
+
 #else /* CONFIG_PROC_FS */
 
 static inline void proc_root_init(void)
-- 
2.17.1

