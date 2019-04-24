Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20249C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6D3521901
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="R1sqUIpJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731295AbfDXPZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:25:45 -0400
Received: from mail.efficios.com ([167.114.142.138]:57938 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731147AbfDXPZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 11:25:39 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 67AAE1D9187;
        Wed, 24 Apr 2019 11:25:37 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id n8vos7CosmwW; Wed, 24 Apr 2019 11:25:36 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id A4C2D1D9176;
        Wed, 24 Apr 2019 11:25:36 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com A4C2D1D9176
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1556119536;
        bh=CUoFbCvjdu5aTIEDIFoQGhpcp1T3MBcIhWXnIMH56Qg=;
        h=From:To:Date:Message-Id;
        b=R1sqUIpJ7+JGZ1QXp1UN/cYtKLUJXMfEpaMpgWhnVZRGahrlSAa/ibfoCc3DR7C9F
         OZsLlZCYza35hnc/i4+LHQhEYIFCLvYxm4ab2efTLf8RPNSk52JicGHhaQIuggyPw7
         CDRm3syOsWiqgkLeZXvPcUj5mN6YeWLiBfTm98q512HGDVLwVZnBw5axgWLABm0/8S
         n9n3vgC8r4aflcYxpz5GZAJknUGX0kxJu7LTKwvc6yE5hdmBGNJuOw/Iq0HCtG9OyC
         T8swY9E1qbCdOQAt4Hsy/f7+F2Z7aryRJdufHnLKhceKW8ask+I/yuf3JsRcbErgjk
         OBcFWwbFZwxLg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id JuT1lGuHm6bW; Wed, 24 Apr 2019 11:25:36 -0400 (EDT)
Received: from thinkos.internal.efficios.com (192-222-157-41.qc.cable.ebox.net [192.222.157.41])
        by mail.efficios.com (Postfix) with ESMTPSA id 8CC561D9154;
        Wed, 24 Apr 2019 11:25:35 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Carlos O'Donell <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>
Subject: [RFC PATCH for 5.2 03/10] rseq/selftests: Use __rseq_handled symbol to coexist with glibc
Date:   Wed, 24 Apr 2019 11:24:55 -0400
Message-Id: <20190424152502.14246-4-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190424152502.14246-1-mathieu.desnoyers@efficios.com>
References: <20190424152502.14246-1-mathieu.desnoyers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to integrate rseq into user-space applications, expose a
__rseq_handled symbol so many rseq users can be linked into the same
application (e.g. librseq and glibc).

The __rseq_refcount TLS variable is static to the librseq library. It
ensures that rseq syscall registration/unregistration happens only for
the most early/late caller to rseq_{,un}register_current_thread for each
thread, thus ensuring that rseq is registered across the lifetime of all
rseq users for a given thread.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Shuah Khan <shuah@kernel.org>
CC: Carlos O'Donell <carlos@redhat.com>
CC: Florian Weimer <fweimer@redhat.com>
CC: Joseph Myers <joseph@codesourcery.com>
CC: Szabolcs Nagy <szabolcs.nagy@arm.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ben Maurer <bmaurer@fb.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
CC: Boqun Feng <boqun.feng@gmail.com>
CC: Will Deacon <will.deacon@arm.com>
CC: Dave Watson <davejwatson@fb.com>
CC: Paul Turner <pjt@google.com>
CC: linux-api@vger.kernel.org
---
 tools/testing/selftests/rseq/rseq.c | 55 +++++++++++++++++++++++++++++++------
 tools/testing/selftests/rseq/rseq.h |  1 +
 2 files changed, 48 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
index 4847e97ed049..d44cc17ad929 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -25,18 +25,27 @@
 #include <syscall.h>
 #include <assert.h>
 #include <signal.h>
+#include <limits.h>
 
 #include "rseq.h"
 
 #define ARRAY_SIZE(arr)	(sizeof(arr) / sizeof((arr)[0]))
 
-__attribute__((tls_model("initial-exec"))) __thread
-volatile struct rseq __rseq_abi = {
+__thread volatile struct rseq __rseq_abi = {
 	.cpu_id = RSEQ_CPU_ID_UNINITIALIZED,
 };
 
-static __attribute__((tls_model("initial-exec"))) __thread
-volatile int refcount;
+/*
+ * Shared with other libraries. This library may take rseq ownership if it is
+ * still 0 when executing the library constructor. Set to 1 by library
+ * constructor when handling rseq. Set to 0 in destructor if handling rseq.
+ */
+int __rseq_handled;
+
+/* Whether this library have ownership of rseq registration. */
+static int rseq_ownership;
+
+static __thread volatile uint32_t __rseq_refcount;
 
 static void signal_off_save(sigset_t *oldset)
 {
@@ -69,8 +78,14 @@ int rseq_register_current_thread(void)
 	int rc, ret = 0;
 	sigset_t oldset;
 
+	if (!rseq_ownership)
+		return 0;
 	signal_off_save(&oldset);
-	if (refcount++)
+	if (__rseq_refcount == UINT_MAX) {
+		ret = -1;
+		goto end;
+	}
+	if (__rseq_refcount++)
 		goto end;
 	rc = sys_rseq(&__rseq_abi, sizeof(struct rseq), 0, RSEQ_SIG);
 	if (!rc) {
@@ -78,9 +93,9 @@ int rseq_register_current_thread(void)
 		goto end;
 	}
 	if (errno != EBUSY)
-		__rseq_abi.cpu_id = -2;
+		__rseq_abi.cpu_id = RSEQ_CPU_ID_REGISTRATION_FAILED;
 	ret = -1;
-	refcount--;
+	__rseq_lib_abi.refcount--;
 end:
 	signal_restore(oldset);
 	return ret;
@@ -91,13 +106,20 @@ int rseq_unregister_current_thread(void)
 	int rc, ret = 0;
 	sigset_t oldset;
 
+	if (!rseq_ownership)
+		return 0;
 	signal_off_save(&oldset);
-	if (--refcount)
+	if (!__rseq_refcount) {
+		ret = -1;
+		goto end;
+	}
+	if (--__rseq_refcount)
 		goto end;
 	rc = sys_rseq(&__rseq_abi, sizeof(struct rseq),
 		      RSEQ_FLAG_UNREGISTER, RSEQ_SIG);
 	if (!rc)
 		goto end;
+	__rseq_refcount = 1;
 	ret = -1;
 end:
 	signal_restore(oldset);
@@ -115,3 +137,20 @@ int32_t rseq_fallback_current_cpu(void)
 	}
 	return cpu;
 }
+
+void __attribute__((constructor)) rseq_init(void)
+{
+	/* Check whether rseq is handled by another library. */
+	if (__rseq_handled)
+		return;
+	__rseq_handled = 1;
+	rseq_ownership = 1;
+}
+
+void __attribute__((destructor)) rseq_fini(void)
+{
+	if (!rseq_ownership)
+		return;
+	__rseq_handled = 0;
+	rseq_ownership = 0;
+}
diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
index c72eb70f9b52..26348e2c44f3 100644
--- a/tools/testing/selftests/rseq/rseq.h
+++ b/tools/testing/selftests/rseq/rseq.h
@@ -45,6 +45,7 @@
 #endif
 
 extern __thread volatile struct rseq __rseq_abi;
+extern int __rseq_handled;
 
 #define rseq_likely(x)		__builtin_expect(!!(x), 1)
 #define rseq_unlikely(x)	__builtin_expect(!!(x), 0)
-- 
2.11.0

