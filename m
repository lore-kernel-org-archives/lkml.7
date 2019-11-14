Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3433CC43215
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 165A420871
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbfKNSSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:18:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:35598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727420AbfKNSSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:18:25 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97DE920729;
        Thu, 14 Nov 2019 18:18:24 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1iVJhH-0000yI-M6; Thu, 14 Nov 2019 13:18:23 -0500
Message-Id: <20191114181823.564906442@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 14 Nov 2019 13:17:35 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [for-next][PATCH 01/33] ftrace: Introduce PERMANENT ftrace_ops flag
References: <20191114181734.067922168@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miroslav Benes <mbenes@suse.cz>

Livepatch uses ftrace for redirection to new patched functions. It means
that if ftrace is disabled, all live patched functions are disabled as
well. Toggling global 'ftrace_enabled' sysctl thus affect it directly.
It is not a problem per se, because only administrator can set sysctl
values, but it still may be surprising.

Introduce PERMANENT ftrace_ops flag to amend this. If the
FTRACE_OPS_FL_PERMANENT is set on any ftrace ops, the tracing cannot be
disabled by disabling ftrace_enabled. Equally, a callback with the flag
set cannot be registered if ftrace_enabled is disabled.

Link: http://lkml.kernel.org/r/20191016113316.13415-2-mbenes@suse.cz

Reviewed-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Signed-off-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/trace/ftrace-uses.rst |  8 ++++++++
 Documentation/trace/ftrace.rst      |  4 +++-
 include/linux/ftrace.h              |  3 +++
 kernel/livepatch/patch.c            |  3 ++-
 kernel/trace/ftrace.c               | 23 +++++++++++++++++++++--
 5 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/Documentation/trace/ftrace-uses.rst b/Documentation/trace/ftrace-uses.rst
index 1fbc69894eed..740bd0224d35 100644
--- a/Documentation/trace/ftrace-uses.rst
+++ b/Documentation/trace/ftrace-uses.rst
@@ -170,6 +170,14 @@ FTRACE_OPS_FL_RCU
 	a callback may be executed and RCU synchronization will not protect
 	it.
 
+FTRACE_OPS_FL_PERMANENT
+        If this is set on any ftrace ops, then the tracing cannot disabled by
+        writing 0 to the proc sysctl ftrace_enabled. Equally, a callback with
+        the flag set cannot be registered if ftrace_enabled is 0.
+
+        Livepatch uses it not to lose the function redirection, so the system
+        stays protected.
+
 
 Filtering which functions to trace
 ==================================
diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index e3060eedb22d..d2b5657ed33e 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -2976,7 +2976,9 @@ Note, the proc sysctl ftrace_enable is a big on/off switch for the
 function tracer. By default it is enabled (when function tracing is
 enabled in the kernel). If it is disabled, all function tracing is
 disabled. This includes not only the function tracers for ftrace, but
-also for any other uses (perf, kprobes, stack tracing, profiling, etc).
+also for any other uses (perf, kprobes, stack tracing, profiling, etc). It
+cannot be disabled if there is a callback with FTRACE_OPS_FL_PERMANENT set
+registered.
 
 Please disable this with care.
 
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 8a8cb3c401b2..8385cafe4f9f 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -142,6 +142,8 @@ ftrace_func_t ftrace_ops_get_func(struct ftrace_ops *ops);
  * PID     - Is affected by set_ftrace_pid (allows filtering on those pids)
  * RCU     - Set when the ops can only be called when RCU is watching.
  * TRACE_ARRAY - The ops->private points to a trace_array descriptor.
+ * PERMANENT - Set when the ops is permanent and should not be affected by
+ *             ftrace_enabled.
  */
 enum {
 	FTRACE_OPS_FL_ENABLED			= 1 << 0,
@@ -160,6 +162,7 @@ enum {
 	FTRACE_OPS_FL_PID			= 1 << 13,
 	FTRACE_OPS_FL_RCU			= 1 << 14,
 	FTRACE_OPS_FL_TRACE_ARRAY		= 1 << 15,
+	FTRACE_OPS_FL_PERMANENT                 = 1 << 16,
 };
 
 #ifdef CONFIG_DYNAMIC_FTRACE
diff --git a/kernel/livepatch/patch.c b/kernel/livepatch/patch.c
index bd43537702bd..b552cf2d85f8 100644
--- a/kernel/livepatch/patch.c
+++ b/kernel/livepatch/patch.c
@@ -196,7 +196,8 @@ static int klp_patch_func(struct klp_func *func)
 		ops->fops.func = klp_ftrace_handler;
 		ops->fops.flags = FTRACE_OPS_FL_SAVE_REGS |
 				  FTRACE_OPS_FL_DYNAMIC |
-				  FTRACE_OPS_FL_IPMODIFY;
+				  FTRACE_OPS_FL_IPMODIFY |
+				  FTRACE_OPS_FL_PERMANENT;
 
 		list_add(&ops->node, &klp_ops);
 
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index f296d89be757..89e9128652ef 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -326,6 +326,8 @@ int __register_ftrace_function(struct ftrace_ops *ops)
 	if (ops->flags & FTRACE_OPS_FL_SAVE_REGS_IF_SUPPORTED)
 		ops->flags |= FTRACE_OPS_FL_SAVE_REGS;
 #endif
+	if (!ftrace_enabled && (ops->flags & FTRACE_OPS_FL_PERMANENT))
+		return -EBUSY;
 
 	if (!core_kernel_data((unsigned long)ops))
 		ops->flags |= FTRACE_OPS_FL_DYNAMIC;
@@ -6754,6 +6756,18 @@ int unregister_ftrace_function(struct ftrace_ops *ops)
 }
 EXPORT_SYMBOL_GPL(unregister_ftrace_function);
 
+static bool is_permanent_ops_registered(void)
+{
+	struct ftrace_ops *op;
+
+	do_for_each_ftrace_op(op, ftrace_ops_list) {
+		if (op->flags & FTRACE_OPS_FL_PERMANENT)
+			return true;
+	} while_for_each_ftrace_op(op);
+
+	return false;
+}
+
 int
 ftrace_enable_sysctl(struct ctl_table *table, int write,
 		     void __user *buffer, size_t *lenp,
@@ -6771,8 +6785,6 @@ ftrace_enable_sysctl(struct ctl_table *table, int write,
 	if (ret || !write || (last_ftrace_enabled == !!ftrace_enabled))
 		goto out;
 
-	last_ftrace_enabled = !!ftrace_enabled;
-
 	if (ftrace_enabled) {
 
 		/* we are starting ftrace again */
@@ -6783,12 +6795,19 @@ ftrace_enable_sysctl(struct ctl_table *table, int write,
 		ftrace_startup_sysctl();
 
 	} else {
+		if (is_permanent_ops_registered()) {
+			ftrace_enabled = true;
+			ret = -EBUSY;
+			goto out;
+		}
+
 		/* stopping ftrace calls (just send to ftrace_stub) */
 		ftrace_trace_function = ftrace_stub;
 
 		ftrace_shutdown_sysctl();
 	}
 
+	last_ftrace_enabled = !!ftrace_enabled;
  out:
 	mutex_unlock(&ftrace_lock);
 	return ret;
-- 
2.23.0


