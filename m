Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C1AC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 07:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75B0E2084F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 07:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbfLDHyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 02:54:16 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56133 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbfLDHyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 02:54:05 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1icPTs-0004Qq-UN; Wed, 04 Dec 2019 08:53:53 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8B40C1C2644;
        Wed,  4 Dec 2019 08:53:52 +0100 (CET)
Date:   Wed, 04 Dec 2019 07:53:52 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] tools headers UAPI: Sync sched.h with the kernel
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Adrian Reber <areber@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <tip-nprqsvvzbhzoy64cbvos6c5b@git.kernel.org>
References: <tip-nprqsvvzbhzoy64cbvos6c5b@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157544603240.21853.7387317330852684748.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     2603a4903bf96d2fe15b7d9e2d03b7efdffbd99a
Gitweb:        https://git.kernel.org/tip/2603a4903bf96d2fe15b7d9e2d03b7efdffbd99a
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 02 Dec 2019 12:56:39 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 02 Dec 2019 12:56:39 -03:00

tools headers UAPI: Sync sched.h with the kernel

To get the changes in:

  0acefef58451 ("Merge tag 'threads-v5.5' of git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux")
  49cb2fc42ce4 ("fork: extend clone3() to support setting a PID")
  fa729c4df558 ("clone3: validate stack arguments")
  b612e5df4587 ("clone3: add CLONE_CLEAR_SIGHAND")

This file gets rebuilt, but no changes ensues:

   CC       /tmp/build/perf/trace/beauty/clone.o

This addresses this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/sched.h' differs from latest version at 'include/uapi/linux/sched.h'
  diff -u tools/include/uapi/linux/sched.h include/uapi/linux/sched.

The CLONE_CLEAR_SIGHAND one will be used in tools/perf/trace/beauty/clone.c
in a followup patch to show that string when this bit is set in the
syscall arg. Keeping a copy of this file allows us to build this in
older systems and have the binary support printing that flag whenever
that system gets its kernel updated to one where this feature is
present.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Adrian Reber <areber@redhat.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-nprqsvvzbhzoy64cbvos6c5b@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/sched.h | 60 +++++++++++++++++++++----------
 1 file changed, 42 insertions(+), 18 deletions(-)

diff --git a/tools/include/uapi/linux/sched.h b/tools/include/uapi/linux/sched.h
index 99335e1..4a02178 100644
--- a/tools/include/uapi/linux/sched.h
+++ b/tools/include/uapi/linux/sched.h
@@ -33,27 +33,48 @@
 #define CLONE_NEWNET		0x40000000	/* New network namespace */
 #define CLONE_IO		0x80000000	/* Clone io context */
 
+/* Flags for the clone3() syscall. */
+#define CLONE_CLEAR_SIGHAND 0x100000000ULL /* Clear any signal handler and reset to SIG_DFL. */
+
 #ifndef __ASSEMBLY__
 /**
  * struct clone_args - arguments for the clone3 syscall
- * @flags:       Flags for the new process as listed above.
- *               All flags are valid except for CSIGNAL and
- *               CLONE_DETACHED.
- * @pidfd:       If CLONE_PIDFD is set, a pidfd will be
- *               returned in this argument.
- * @child_tid:   If CLONE_CHILD_SETTID is set, the TID of the
- *               child process will be returned in the child's
- *               memory.
- * @parent_tid:  If CLONE_PARENT_SETTID is set, the TID of
- *               the child process will be returned in the
- *               parent's memory.
- * @exit_signal: The exit_signal the parent process will be
- *               sent when the child exits.
- * @stack:       Specify the location of the stack for the
- *               child process.
- * @stack_size:  The size of the stack for the child process.
- * @tls:         If CLONE_SETTLS is set, the tls descriptor
- *               is set to tls.
+ * @flags:        Flags for the new process as listed above.
+ *                All flags are valid except for CSIGNAL and
+ *                CLONE_DETACHED.
+ * @pidfd:        If CLONE_PIDFD is set, a pidfd will be
+ *                returned in this argument.
+ * @child_tid:    If CLONE_CHILD_SETTID is set, the TID of the
+ *                child process will be returned in the child's
+ *                memory.
+ * @parent_tid:   If CLONE_PARENT_SETTID is set, the TID of
+ *                the child process will be returned in the
+ *                parent's memory.
+ * @exit_signal:  The exit_signal the parent process will be
+ *                sent when the child exits.
+ * @stack:        Specify the location of the stack for the
+ *                child process.
+ *                Note, @stack is expected to point to the
+ *                lowest address. The stack direction will be
+ *                determined by the kernel and set up
+ *                appropriately based on @stack_size.
+ * @stack_size:   The size of the stack for the child process.
+ * @tls:          If CLONE_SETTLS is set, the tls descriptor
+ *                is set to tls.
+ * @set_tid:      Pointer to an array of type *pid_t. The size
+ *                of the array is defined using @set_tid_size.
+ *                This array is used to select PIDs/TIDs for
+ *                newly created processes. The first element in
+ *                this defines the PID in the most nested PID
+ *                namespace. Each additional element in the array
+ *                defines the PID in the parent PID namespace of
+ *                the original PID namespace. If the array has
+ *                less entries than the number of currently
+ *                nested PID namespaces only the PIDs in the
+ *                corresponding namespaces are set.
+ * @set_tid_size: This defines the size of the array referenced
+ *                in @set_tid. This cannot be larger than the
+ *                kernel's limit of nested PID namespaces.
  *
  * The structure is versioned by size and thus extensible.
  * New struct members must go at the end of the struct and
@@ -68,10 +89,13 @@ struct clone_args {
 	__aligned_u64 stack;
 	__aligned_u64 stack_size;
 	__aligned_u64 tls;
+	__aligned_u64 set_tid;
+	__aligned_u64 set_tid_size;
 };
 #endif
 
 #define CLONE_ARGS_SIZE_VER0 64 /* sizeof first published struct */
+#define CLONE_ARGS_SIZE_VER1 80 /* sizeof second published struct */
 
 /*
  * Scheduling policies
