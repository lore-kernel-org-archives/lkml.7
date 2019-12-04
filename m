Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97907C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 07:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68E492084F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 07:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfLDHy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 02:54:26 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56191 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbfLDHyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 02:54:23 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1icPTw-0004U8-3M; Wed, 04 Dec 2019 08:53:56 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id EEE221C2649;
        Wed,  4 Dec 2019 08:53:53 +0100 (CET)
Date:   Wed, 04 Dec 2019 07:53:53 -0000
From:   "tip-bot2 for Ian Rogers" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf jit: Move test functionality in to a test
Cc:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191126235913.41855-1-irogers@google.com>
References: <20191126235913.41855-1-irogers@google.com>
MIME-Version: 1.0
Message-ID: <157544603385.21853.1456783418905644512.tip-bot2@tip-bot2>
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

Commit-ID:     fa7f7e7354957422b43ea950b672d3e731f27e68
Gitweb:        https://git.kernel.org/tip/fa7f7e7354957422b43ea950b672d3e731f27e68
Author:        Ian Rogers <irogers@google.com>
AuthorDate:    Tue, 26 Nov 2019 15:59:13 -08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 29 Nov 2019 12:20:45 -03:00

perf jit: Move test functionality in to a test

Adds a test for minimal jit_write_elf functionality.

Committer testing:

  # perf test jit
  61: Test jit_write_elf                                    : Ok
  #

  # perf test -v jit
  61: Test jit_write_elf                                    :
  --- start ---
  test child forked, pid 10460
  Writing jit code to: /tmp/perf-test-KqxURR
  test child finished with 0
  ---- end ----
  Test jit_write_elf: Ok
  #

Committer notes:

Fix up the case where HAVE_JITDUMP is no defined.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexios Zavras <alexios.zavras@intel.com>
Cc: Allison Randal <allison@lohutok.net>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lore.kernel.org/lkml/20191126235913.41855-1-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/Build          |  1 +-
 tools/perf/tests/builtin-test.c |  4 +++-
 tools/perf/tests/genelf.c       | 51 ++++++++++++++++++++++++++++++++-
 tools/perf/tests/tests.h        |  1 +-
 tools/perf/util/genelf.c        | 46 +-----------------------------
 5 files changed, 57 insertions(+), 46 deletions(-)
 create mode 100644 tools/perf/tests/genelf.c

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index a3c595f..1692529 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -54,6 +54,7 @@ perf-y += unit_number__scnprintf.o
 perf-y += mem2node.o
 perf-y += maps.o
 perf-y += time-utils-test.o
+perf-y += genelf.o
 
 $(OUTPUT)tests/llvm-src-base.c: tests/bpf-script-example.c tests/Build
 	$(call rule_mkdir)
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 82d19a8..5f05db7 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -302,6 +302,10 @@ static struct test generic_tests[] = {
 		.func = test__time_utils,
 	},
 	{
+		.desc = "Test jit_write_elf",
+		.func = test__jit_write_elf,
+	},
+	{
 		.desc = "maps__merge_in",
 		.func = test__maps__merge_in,
 	},
diff --git a/tools/perf/tests/genelf.c b/tools/perf/tests/genelf.c
new file mode 100644
index 0000000..f797f98
--- /dev/null
+++ b/tools/perf/tests/genelf.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <limits.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <linux/compiler.h>
+
+#include "debug.h"
+#include "tests.h"
+
+#ifdef HAVE_JITDUMP
+#include <libelf.h>
+#include "../util/genelf.h"
+#endif
+
+#define TEMPL "/tmp/perf-test-XXXXXX"
+
+int test__jit_write_elf(struct test *test __maybe_unused,
+			int subtest __maybe_unused)
+{
+#ifdef HAVE_JITDUMP
+	static unsigned char x86_code[] = {
+		0xBB, 0x2A, 0x00, 0x00, 0x00, /* movl $42, %ebx */
+		0xB8, 0x01, 0x00, 0x00, 0x00, /* movl $1, %eax */
+		0xCD, 0x80            /* int $0x80 */
+	};
+	char path[PATH_MAX];
+	int fd, ret;
+
+	strcpy(path, TEMPL);
+
+	fd = mkstemp(path);
+	if (fd < 0) {
+		perror("mkstemp failed");
+		return TEST_FAIL;
+	}
+
+	pr_info("Writing jit code to: %s\n", path);
+
+	ret = jit_write_elf(fd, 0, "main", x86_code, sizeof(x86_code),
+			NULL, 0, NULL, 0, 0);
+	close(fd);
+
+	unlink(path);
+
+	return ret ? TEST_FAIL : 0;
+#else
+	return TEST_SKIP;
+#endif
+}
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 4f9ae6a..9a160fe 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -110,6 +110,7 @@ int test__unit_number__scnprint(struct test *test, int subtest);
 int test__mem2node(struct test *t, int subtest);
 int test__maps__merge_in(struct test *t, int subtest);
 int test__time_utils(struct test *t, int subtest);
+int test__jit_write_elf(struct test *test, int subtest);
 
 bool test__bp_signal_is_supported(void);
 bool test__bp_account_is_supported(void);
diff --git a/tools/perf/util/genelf.c b/tools/perf/util/genelf.c
index f9f18b8..aed4980 100644
--- a/tools/perf/util/genelf.c
+++ b/tools/perf/util/genelf.c
@@ -8,15 +8,12 @@
  */
 
 #include <sys/types.h>
-#include <stdio.h>
-#include <getopt.h>
 #include <stddef.h>
 #include <libelf.h>
 #include <string.h>
 #include <stdlib.h>
 #include <unistd.h>
 #include <inttypes.h>
-#include <limits.h>
 #include <fcntl.h>
 #include <err.h>
 #ifdef HAVE_DWARF_SUPPORT
@@ -31,8 +28,6 @@
 #define NT_GNU_BUILD_ID 3
 #endif
 
-#define JVMTI
-
 #define BUILD_ID_URANDOM /* different uuid for each run */
 
 #ifdef HAVE_LIBCRYPTO
@@ -511,44 +506,3 @@ error:
 
 	return retval;
 }
-
-#ifndef JVMTI
-
-static unsigned char x86_code[] = {
-    0xBB, 0x2A, 0x00, 0x00, 0x00, /* movl $42, %ebx */
-    0xB8, 0x01, 0x00, 0x00, 0x00, /* movl $1, %eax */
-    0xCD, 0x80            /* int $0x80 */
-};
-
-static struct options options;
-
-int main(int argc, char **argv)
-{
-	int c, fd, ret;
-
-	while ((c = getopt(argc, argv, "o:h")) != -1) {
-		switch (c) {
-		case 'o':
-			options.output = optarg;
-			break;
-		case 'h':
-			printf("Usage: genelf -o output_file [-h]\n");
-			return 0;
-		default:
-			errx(1, "unknown option");
-		}
-	}
-
-	fd = open(options.output, O_CREAT|O_TRUNC|O_RDWR, 0666);
-	if (fd == -1)
-		err(1, "cannot create file %s", options.output);
-
-	ret = jit_write_elf(fd, "main", x86_code, sizeof(x86_code));
-	close(fd);
-
-	if (ret != 0)
-		unlink(options.output);
-
-	return ret;
-}
-#endif
