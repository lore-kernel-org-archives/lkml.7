Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82549C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 17:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41D932053B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 17:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="vM5slE5R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392007AbfISRih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 13:38:37 -0400
Received: from mail.efficios.com ([167.114.142.138]:33720 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403932AbfISRif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 13:38:35 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id A27593318B6;
        Thu, 19 Sep 2019 13:38:33 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id JObZJuOIfB0D; Thu, 19 Sep 2019 13:38:33 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id D24EE331893;
        Thu, 19 Sep 2019 13:38:31 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com D24EE331893
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1568914711;
        bh=t+q0e+wYFlLRwYWddr45Uz8nIrdXJbKHkdZDCG3vUJQ=;
        h=From:To:Date:Message-Id;
        b=vM5slE5Re7o04HC+Weob1jSbos/DrB49Vd8obSVIB2LmsYoK+97uK53V27n6Wfpx2
         7x8Gk1WpGCeZnTRbEPljqCcHtbXgB9pK8CFjw0kuJOzBb1ITBF8R6yxK7JBjVLlR0m
         eFcOSGSIgaBZJJMA+2Wx1ipUGg1CZUmKeP4gN2Agq/IzavchVi5xWTxHS/vc65HgfA
         jzMWLqbfN/bj3QfOdEBG2vpquHVGDqlGqTi9D6bWrw4XSMkl6GrZ+a+LjXdpjGX0Gc
         5eWYVIcHhaJVa+inIa8u/l77eq43fhtN9gJb3wvDfztIHikwPguBaEK+oD2TUvDA05
         /w4u+5yGFju8Q==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 3Buaq8zwCv5z; Thu, 19 Sep 2019 13:38:31 -0400 (EDT)
Received: from localhost.localdomain (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id 7DA5833186B;
        Thu, 19 Sep 2019 13:38:31 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Shuah Khan <shuahkh@osg.samsung.com>
Subject: [RFC PATCH for 5.4 5/7] selftests: sched/membarrier: Add multi-threaded test
Date:   Thu, 19 Sep 2019 13:37:03 -0400
Message-Id: <20190919173705.2181-6-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190919173705.2181-1-mathieu.desnoyers@efficios.com>
References: <20190919173705.2181-1-mathieu.desnoyers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

membarrier commands cover very different code paths if they are in
a single-threaded vs multi-threaded process. Therefore, exercise both
scenarios in the kernel selftests to increase coverage of this selftest.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Shuah Khan <shuahkh@osg.samsung.com>
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc: Chris Metcalf <cmetcalf@ezchip.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Kirill Tkhai <tkhai@yandex.ru>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
---
 tools/testing/selftests/membarrier/.gitignore |  3 +-
 tools/testing/selftests/membarrier/Makefile   |  5 +-
 ...mbarrier_test.c => membarrier_test_impl.h} | 40 +++++-----
 .../membarrier/membarrier_test_multi_thread.c | 73 +++++++++++++++++++
 .../membarrier_test_single_thread.c           | 24 ++++++
 5 files changed, 124 insertions(+), 21 deletions(-)
 rename tools/testing/selftests/membarrier/{membarrier_test.c => membarrier_test_impl.h} (95%)
 create mode 100644 tools/testing/selftests/membarrier/membarrier_test_multi_thread.c
 create mode 100644 tools/testing/selftests/membarrier/membarrier_test_single_thread.c

diff --git a/tools/testing/selftests/membarrier/.gitignore b/tools/testing/selftests/membarrier/.gitignore
index 020c44f49a9e..f2f7ec0a99b4 100644
--- a/tools/testing/selftests/membarrier/.gitignore
+++ b/tools/testing/selftests/membarrier/.gitignore
@@ -1 +1,2 @@
-membarrier_test
+membarrier_test_multi_thread
+membarrier_test_single_thread
diff --git a/tools/testing/selftests/membarrier/Makefile b/tools/testing/selftests/membarrier/Makefile
index 97e3bdf3d1e9..34d1c81a2324 100644
--- a/tools/testing/selftests/membarrier/Makefile
+++ b/tools/testing/selftests/membarrier/Makefile
@@ -1,7 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
 CFLAGS += -g -I../../../../usr/include/
+LDLIBS += -lpthread
 
-TEST_GEN_PROGS := membarrier_test
+TEST_GEN_PROGS := membarrier_test_single_thread \
+		membarrier_test_multi_thread
 
 include ../lib.mk
-
diff --git a/tools/testing/selftests/membarrier/membarrier_test.c b/tools/testing/selftests/membarrier/membarrier_test_impl.h
similarity index 95%
rename from tools/testing/selftests/membarrier/membarrier_test.c
rename to tools/testing/selftests/membarrier/membarrier_test_impl.h
index 70b4ddbf126b..186be69f0a59 100644
--- a/tools/testing/selftests/membarrier/membarrier_test.c
+++ b/tools/testing/selftests/membarrier/membarrier_test_impl.h
@@ -1,10 +1,11 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 #define _GNU_SOURCE
 #include <linux/membarrier.h>
 #include <syscall.h>
 #include <stdio.h>
 #include <errno.h>
 #include <string.h>
+#include <pthread.h>
 
 #include "../kselftest.h"
 
@@ -223,7 +224,7 @@ static int test_membarrier_global_expedited_success(void)
 	return 0;
 }
 
-static int test_membarrier(void)
+static int test_membarrier_fail(void)
 {
 	int status;
 
@@ -233,10 +234,27 @@ static int test_membarrier(void)
 	status = test_membarrier_flags_fail();
 	if (status)
 		return status;
-	status = test_membarrier_global_success();
+	status = test_membarrier_private_expedited_fail();
 	if (status)
 		return status;
-	status = test_membarrier_private_expedited_fail();
+	status = sys_membarrier(MEMBARRIER_CMD_QUERY, 0);
+	if (status < 0) {
+		ksft_test_result_fail("sys_membarrier() failed\n");
+		return status;
+	}
+	if (status & MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE) {
+		status = test_membarrier_private_expedited_sync_core_fail();
+		if (status)
+			return status;
+	}
+	return 0;
+}
+
+static int test_membarrier_success(void)
+{
+	int status;
+
+	status = test_membarrier_global_success();
 	if (status)
 		return status;
 	status = test_membarrier_register_private_expedited_success();
@@ -251,9 +269,6 @@ static int test_membarrier(void)
 		return status;
 	}
 	if (status & MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE) {
-		status = test_membarrier_private_expedited_sync_core_fail();
-		if (status)
-			return status;
 		status = test_membarrier_register_private_expedited_sync_core_success();
 		if (status)
 			return status;
@@ -300,14 +315,3 @@ static int test_membarrier_query(void)
 	ksft_test_result_pass("sys_membarrier available\n");
 	return 0;
 }
-
-int main(int argc, char **argv)
-{
-	ksft_print_header();
-	ksft_set_plan(13);
-
-	test_membarrier_query();
-	test_membarrier();
-
-	return ksft_exit_pass();
-}
diff --git a/tools/testing/selftests/membarrier/membarrier_test_multi_thread.c b/tools/testing/selftests/membarrier/membarrier_test_multi_thread.c
new file mode 100644
index 000000000000..ac5613e5b0eb
--- /dev/null
+++ b/tools/testing/selftests/membarrier/membarrier_test_multi_thread.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <linux/membarrier.h>
+#include <syscall.h>
+#include <stdio.h>
+#include <errno.h>
+#include <string.h>
+#include <pthread.h>
+
+#include "membarrier_test_impl.h"
+
+static int thread_ready, thread_quit;
+static pthread_mutex_t test_membarrier_thread_mutex =
+	PTHREAD_MUTEX_INITIALIZER;
+static pthread_cond_t test_membarrier_thread_cond =
+	PTHREAD_COND_INITIALIZER;
+
+void *test_membarrier_thread(void *arg)
+{
+	pthread_mutex_lock(&test_membarrier_thread_mutex);
+	thread_ready = 1;
+	pthread_cond_broadcast(&test_membarrier_thread_cond);
+	pthread_mutex_unlock(&test_membarrier_thread_mutex);
+
+	pthread_mutex_lock(&test_membarrier_thread_mutex);
+	while (!thread_quit)
+		pthread_cond_wait(&test_membarrier_thread_cond,
+				  &test_membarrier_thread_mutex);
+	pthread_mutex_unlock(&test_membarrier_thread_mutex);
+
+	return NULL;
+}
+
+static int test_mt_membarrier(void)
+{
+	int i;
+	pthread_t test_thread;
+
+	pthread_create(&test_thread, NULL,
+		       test_membarrier_thread, NULL);
+
+	pthread_mutex_lock(&test_membarrier_thread_mutex);
+	while (!thread_ready)
+		pthread_cond_wait(&test_membarrier_thread_cond,
+				  &test_membarrier_thread_mutex);
+	pthread_mutex_unlock(&test_membarrier_thread_mutex);
+
+	test_membarrier_fail();
+
+	test_membarrier_success();
+
+	pthread_mutex_lock(&test_membarrier_thread_mutex);
+	thread_quit = 1;
+	pthread_cond_broadcast(&test_membarrier_thread_cond);
+	pthread_mutex_unlock(&test_membarrier_thread_mutex);
+
+	pthread_join(test_thread, NULL);
+
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	ksft_print_header();
+	ksft_set_plan(13);
+
+	test_membarrier_query();
+
+	/* Multi-threaded */
+	test_mt_membarrier();
+
+	return ksft_exit_pass();
+}
diff --git a/tools/testing/selftests/membarrier/membarrier_test_single_thread.c b/tools/testing/selftests/membarrier/membarrier_test_single_thread.c
new file mode 100644
index 000000000000..c1c963902854
--- /dev/null
+++ b/tools/testing/selftests/membarrier/membarrier_test_single_thread.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <linux/membarrier.h>
+#include <syscall.h>
+#include <stdio.h>
+#include <errno.h>
+#include <string.h>
+#include <pthread.h>
+
+#include "membarrier_test_impl.h"
+
+int main(int argc, char **argv)
+{
+	ksft_print_header();
+	ksft_set_plan(13);
+
+	test_membarrier_query();
+
+	test_membarrier_fail();
+
+	test_membarrier_success();
+
+	return ksft_exit_pass();
+}
-- 
2.17.1

