Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B44C43141
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 18:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD4C52071B
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 18:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfKWSMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 13:12:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:40192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726774AbfKWSMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 13:12:44 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E947D20748;
        Sat, 23 Nov 2019 18:12:42 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.3)
        (envelope-from <rostedt@goodmis.org>)
        id 1iYZti-000F1F-34; Sat, 23 Nov 2019 13:12:42 -0500
Message-Id: <20191123181241.969300509@goodmis.org>
User-Agent: quilt/0.65
Date:   Sat, 23 Nov 2019 13:12:06 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hassan Naveed <hnaveed@wavecomp.com>,
        Paul Burton <paulburton@kernel.org>
Subject: [for-next][PATCH 09/10] tracing: Use xarray for syscall trace events
References: <20191123181157.851427201@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hassan Naveed <hnaveed@wavecomp.com>

Currently, a lot of memory is wasted for architectures like MIPS when
init_ftrace_syscalls() allocates the array for syscalls using kcalloc.
This is because syscalls numbers start from 4000, 5000 or 6000 and
array elements up to that point are unused.
Fix this by using a data structure more suited to storing sparsely
populated arrays. The XARRAY data structure, implemented using radix
trees, is much more memory efficient for storing the syscalls in
question.

Link: http://lkml.kernel.org/r/20191115234314.21599-1-hnaveed@wavecomp.com

Signed-off-by: Hassan Naveed <hnaveed@wavecomp.com>
Reviewed-by: Paul Burton <paulburton@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/Kconfig                  |  8 ++++++++
 kernel/trace/trace_syscalls.c | 32 +++++++++++++++++++++++++-------
 2 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 5f8a5d84dbbe..69c87e8608d8 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -960,6 +960,14 @@ config RELR
 config ARCH_HAS_MEM_ENCRYPT
 	bool
 
+config HAVE_SPARSE_SYSCALL_NR
+       bool
+       help
+          An architecture should select this if its syscall numbering is sparse
+	  to save space. For example, MIPS architecture has a syscall array with
+	  entries at 4000, 5000 and 6000 locations. This option turns on syscall
+	  related optimizations for a given architecture.
+
 source "kernel/gcov/Kconfig"
 
 source "scripts/gcc-plugins/Kconfig"
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index fa8fbff736d6..16fa218556fa 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -7,6 +7,7 @@
 #include <linux/module.h>	/* for MODULE_NAME_LEN via KSYM_SYMBOL_LEN */
 #include <linux/ftrace.h>
 #include <linux/perf_event.h>
+#include <linux/xarray.h>
 #include <asm/syscall.h>
 
 #include "trace_output.h"
@@ -30,6 +31,7 @@ syscall_get_enter_fields(struct trace_event_call *call)
 extern struct syscall_metadata *__start_syscalls_metadata[];
 extern struct syscall_metadata *__stop_syscalls_metadata[];
 
+static DEFINE_XARRAY(syscalls_metadata_sparse);
 static struct syscall_metadata **syscalls_metadata;
 
 #ifndef ARCH_HAS_SYSCALL_MATCH_SYM_NAME
@@ -101,6 +103,9 @@ find_syscall_meta(unsigned long syscall)
 
 static struct syscall_metadata *syscall_nr_to_meta(int nr)
 {
+	if (IS_ENABLED(CONFIG_HAVE_SPARSE_SYSCALL_NR))
+		return xa_load(&syscalls_metadata_sparse, (unsigned long)nr);
+
 	if (!syscalls_metadata || nr >= NR_syscalls || nr < 0)
 		return NULL;
 
@@ -536,12 +541,16 @@ void __init init_ftrace_syscalls(void)
 	struct syscall_metadata *meta;
 	unsigned long addr;
 	int i;
-
-	syscalls_metadata = kcalloc(NR_syscalls, sizeof(*syscalls_metadata),
-				    GFP_KERNEL);
-	if (!syscalls_metadata) {
-		WARN_ON(1);
-		return;
+	void *ret;
+
+	if (!IS_ENABLED(CONFIG_HAVE_SPARSE_SYSCALL_NR)) {
+		syscalls_metadata = kcalloc(NR_syscalls,
+					sizeof(*syscalls_metadata),
+					GFP_KERNEL);
+		if (!syscalls_metadata) {
+			WARN_ON(1);
+			return;
+		}
 	}
 
 	for (i = 0; i < NR_syscalls; i++) {
@@ -551,7 +560,16 @@ void __init init_ftrace_syscalls(void)
 			continue;
 
 		meta->syscall_nr = i;
-		syscalls_metadata[i] = meta;
+
+		if (!IS_ENABLED(CONFIG_HAVE_SPARSE_SYSCALL_NR)) {
+			syscalls_metadata[i] = meta;
+		} else {
+			ret = xa_store(&syscalls_metadata_sparse, i, meta,
+					GFP_KERNEL);
+			WARN(xa_is_err(ret),
+				"Syscall memory allocation failed\n");
+		}
+
 	}
 }
 
-- 
2.24.0


