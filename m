Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DACC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 971982080F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575381411;
	bh=/gOffcnTWNYX26wJysWkAw9/25LluE4ud46TrTiv8v0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HQ6UR6Zbxc1Tre8LvUVa7us56za94jtG+TRmsPaGe1ipHPue1KMiu1qsjRo0UlR2Q
	 bX56Br2BwzdgtlCuLjvIFudVSWrmzerZqHIS/Kzb2GywtCSwLlSgaHqe2lcIzhOO2E
	 tSs4uRat8fSif7WAPJngj0djNyC32E6Wpcp8H+cQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfLCN4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 08:56:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:34816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbfLCN4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 08:56:49 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B11F2207DD;
        Tue,  3 Dec 2019 13:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575381407;
        bh=/gOffcnTWNYX26wJysWkAw9/25LluE4ud46TrTiv8v0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y/G9P5sFWlnOsbNkgMdoUmoesBto5c6Tb0nDI14urkSbw02w3KGyFnKNmf0bbfE/2
         JIIPoqAUCUaJbRZtEfUo93UzUu54HnCJ7UAchQ9QSZIbpJHYktFjtIouaxeVyjFoAT
         DCQdf8PZPuMh70MsnTnWp9fMGYD1FYY6QL+kHyTw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 11/23] perf jit: Move test functionality in to a test
Date:   Tue,  3 Dec 2019 10:55:54 -0300
Message-Id: <20191203135606.24902-12-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191203135606.24902-1-acme@kernel.org>
References: <20191203135606.24902-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ian Rogers <irogers@google.com>

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
 tools/perf/tests/Build          |  1 +
 tools/perf/tests/builtin-test.c |  4 +++
 tools/perf/tests/genelf.c       | 51 +++++++++++++++++++++++++++++++++
 tools/perf/tests/tests.h        |  1 +
 tools/perf/util/genelf.c        | 46 -----------------------------
 5 files changed, 57 insertions(+), 46 deletions(-)
 create mode 100644 tools/perf/tests/genelf.c

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index a3c595fba943..1692529639b0 100644
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
index 82d19a8fcac7..5f05db75cdd8 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -301,6 +301,10 @@ static struct test generic_tests[] = {
 		.desc = "time utils",
 		.func = test__time_utils,
 	},
+	{
+		.desc = "Test jit_write_elf",
+		.func = test__jit_write_elf,
+	},
 	{
 		.desc = "maps__merge_in",
 		.func = test__maps__merge_in,
diff --git a/tools/perf/tests/genelf.c b/tools/perf/tests/genelf.c
new file mode 100644
index 000000000000..f797f9823e89
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
index 4f9ae6af78ec..9a160fef47c9 100644
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
index f9f18b8b1df9..aed49806a09b 100644
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
@@ -511,44 +506,3 @@ jit_write_elf(int fd, uint64_t load_addr, const char *sym,
 
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
-- 
2.21.0

