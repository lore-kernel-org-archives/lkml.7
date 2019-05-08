Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BDDC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 17:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BDFF21530
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 17:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbfEHREW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 13:04:22 -0400
Received: from mga03.intel.com ([134.134.136.65]:5321 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728953AbfEHRDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 13:03:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 May 2019 10:03:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,446,1549958400"; 
   d="scan'208";a="169697546"
Received: from chang-linux-3.sc.intel.com ([172.25.66.171])
  by fmsmga002.fm.intel.com with ESMTP; 08 May 2019 10:03:02 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>
Cc:     Ravi Shankar <ravi.v.shankar@intel.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 01/18] x86/fsgsbase/64: Fix ARCH_SET_FS/GS behaviors for a remote task
Date:   Wed,  8 May 2019 03:02:16 -0700
Message-Id: <1557309753-24073-2-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557309753-24073-1-git-send-email-chang.seok.bae@intel.com>
References: <1557309753-24073-1-git-send-email-chang.seok.bae@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a ptracer writes to a ptracee's FS/GSBASE with a different value,
the selector is also cleared. This behavior is not straightforward.

The change will make the behavior simple and sensible, as it will
(only) update the base when requested. Also, the condition check for
comparing the base is removed to make more simple. It might save a few
cycles, but this path is not performance critical.

The only recognizable downside of this change is when writing the base
if the selector is already nonzero. The base will be reloaded according
to the selector. But the case is highly unexpected in real usages.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/kernel/process_64.c | 21 +++++++++------------
 arch/x86/kernel/ptrace.c     | 14 ++------------
 2 files changed, 11 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index f8e1af3..32d12c6 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -719,13 +719,13 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 			return -EPERM;
 
 		preempt_disable();
-		/*
-		 * ARCH_SET_GS has always overwritten the index
-		 * and the base. Zero is the most sensible value
-		 * to put in the index, and is the only value that
-		 * makes any sense if FSGSBASE is unavailable.
-		 */
 		if (task == current) {
+			/*
+			 * For the request to set the current task's base,
+			 * first to load with zero selector, then write
+			 * the base value to be effective on a non-FSGSBASE
+			 * system.
+			 */
 			loadseg(GS, 0);
 			x86_gsbase_write_cpu_inactive(arg2);
 
@@ -736,7 +736,6 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 			task->thread.gsbase = arg2;
 
 		} else {
-			task->thread.gsindex = 0;
 			x86_gsbase_write_task(task, arg2);
 		}
 		preempt_enable();
@@ -751,11 +750,10 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 			return -EPERM;
 
 		preempt_disable();
-		/*
-		 * Set the selector to 0 for the same reason
-		 * as %gs above.
-		 */
 		if (task == current) {
+			/*
+			 * Same here as %gs handling above
+			 */
 			loadseg(FS, 0);
 			x86_fsbase_write_cpu(arg2);
 
@@ -765,7 +763,6 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 			 */
 			task->thread.fsbase = arg2;
 		} else {
-			task->thread.fsindex = 0;
 			x86_fsbase_write_task(task, arg2);
 		}
 		preempt_enable();
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 4b8ee05..3309cfe 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -396,22 +396,12 @@ static int putreg(struct task_struct *child,
 	case offsetof(struct user_regs_struct,fs_base):
 		if (value >= TASK_SIZE_MAX)
 			return -EIO;
-		/*
-		 * When changing the FS base, use do_arch_prctl_64()
-		 * to set the index to zero and to set the base
-		 * as requested.
-		 */
-		if (child->thread.fsbase != value)
-			return do_arch_prctl_64(child, ARCH_SET_FS, value);
+		x86_fsbase_write_cpu(child, value);
 		return 0;
 	case offsetof(struct user_regs_struct,gs_base):
-		/*
-		 * Exactly the same here as the %fs handling above.
-		 */
 		if (value >= TASK_SIZE_MAX)
 			return -EIO;
-		if (child->thread.gsbase != value)
-			return do_arch_prctl_64(child, ARCH_SET_GS, value);
+		x86_gsbase_write_cpu(child, value);
 		return 0;
 #endif
 	}
-- 
2.7.4

