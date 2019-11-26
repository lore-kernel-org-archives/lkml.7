Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0878C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 23:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5BB72064A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 23:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TxxE/T4J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfKZX7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 18:59:20 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:47318 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbfKZX7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 18:59:20 -0500
Received: by mail-pf1-f201.google.com with SMTP id w16so12877687pfq.14
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 15:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=t3y0ParnqjS12Zc5G+hJwx8XjnN+voVZwR5fnWpar50=;
        b=TxxE/T4Jvb85hFXtiKfurQwkOL0eBkywjzDeghrE3w+GpTW8NSNCCwo4r8cNP/gb93
         nj8WnuLndF6S8VGa/cCH3/0DzpBlx4FTqMMbv2vm5I4MUWjhsXJKSgrQmfWsz/vnGTTC
         kkyxG0NsAjYhGVWCepAW94dReKwFQ4GYBHsLG04TJ5QsHQWl2PGtte/qfL6kMQTlUma+
         CExqDwcwNdWUlHmNx18yAnDgpS6XjcjFjNtKrOePO6c2FUbSDj4xf+XP9Lbs4zevrQ8o
         c2EcSseEV0sxWPcO7t3zXEtL99uKCpiamsZ0KFlVvhRNs4ESHpjGx6KAt4L5elTVtAPS
         rjuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=t3y0ParnqjS12Zc5G+hJwx8XjnN+voVZwR5fnWpar50=;
        b=pXZBvChfi0o/Yy6o5r1McXIOR2Ef/w22SyLEOBxMkIZJy5kfAZ8hVKSE2CBRm+ou03
         GSUeCA44YmXAeJDrxMsgnb2qFB77g6sTPqiG+36ye1o609F7oIL3ym9GYphcAQm3Zt9D
         uUcMglpn+iZ+8apjAGvohdIgUk1xpdx+jA2o+c/hQi+9hHEUhWDFf7G05/x7yigbHQBT
         cxivHUjnIBbkYL8I8JpzsGOD0ip5eXywexmZa+acjIbrEkPAiGVBTf+cMT3/iRfqHVr/
         9L13tadT/tpzFXMDbb8jkB5zBNezE9IYey0iKai8Dj9M/Nf3lIt5YsZm3hgZMTmEvcMK
         g88w==
X-Gm-Message-State: APjAAAXG494onmWs/dnjo2RyLLfsXlWbt4JttbA8oTJys4753o0UI97Z
        1f9DehNT5KGqx4rWWOEt55Z5LyzHtsfP
X-Google-Smtp-Source: APXvYqylJyQ+JT4DSbS2i8gGwBaqTvDBdjzC8mpEKBM/yHOgjbpG384/HdXTJ7yOEEX3cp08OS4UMn1yFsN8
X-Received: by 2002:a63:4b03:: with SMTP id y3mr1298378pga.155.1574812758994;
 Tue, 26 Nov 2019 15:59:18 -0800 (PST)
Date:   Tue, 26 Nov 2019 15:59:13 -0800
Message-Id: <20191126235913.41855-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH] perf jit: move test functionality in to a test
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Song Liu <songliubraving@fb.com>, Leo Yan <leo.yan@linaro.org>,
        Michael Petlan <mpetlan@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a test for minimal jit_write_elf functionality.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/Build          |  1 +
 tools/perf/tests/builtin-test.c |  4 +++
 tools/perf/tests/genelf.c       | 53 +++++++++++++++++++++++++++++++++
 tools/perf/tests/tests.h        |  1 +
 tools/perf/util/genelf.c        | 46 ----------------------------
 5 files changed, 59 insertions(+), 46 deletions(-)
 create mode 100644 tools/perf/tests/genelf.c

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index e72accefd669..a738e4a5b301 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -54,6 +54,7 @@ perf-y += unit_number__scnprintf.o
 perf-y += mem2node.o
 perf-y += map_groups.o
 perf-y += time-utils-test.o
+perf-y += genelf.o
 
 $(OUTPUT)tests/llvm-src-base.c: tests/bpf-script-example.c tests/Build
 	$(call rule_mkdir)
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 8b286e9b7549..6ab2e2346aab 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -300,6 +300,10 @@ static struct test generic_tests[] = {
 		.desc = "map_groups__merge_in",
 		.func = test__map_groups__merge_in,
 	},
+	{
+		.desc = "Test jit_write_elf",
+		.func = test__jit_write_elf,
+	},
 	{
 		.func = NULL,
 	},
diff --git a/tools/perf/tests/genelf.c b/tools/perf/tests/genelf.c
new file mode 100644
index 000000000000..d392e9300881
--- /dev/null
+++ b/tools/perf/tests/genelf.c
@@ -0,0 +1,53 @@
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
+
+#ifdef HAVE_LIBELF_SUPPORT
+#include <libelf.h>
+#include "../util/genelf.h"
+#endif
+
+#define TEMPL "/tmp/perf-test-XXXXXX"
+
+static unsigned char x86_code[] = {
+	0xBB, 0x2A, 0x00, 0x00, 0x00, /* movl $42, %ebx */
+	0xB8, 0x01, 0x00, 0x00, 0x00, /* movl $1, %eax */
+	0xCD, 0x80            /* int $0x80 */
+};
+
+int test__jit_write_elf(struct test *test __maybe_unused,
+			int subtest __maybe_unused)
+{
+#ifdef HAVE_JITDUMP
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
+	return TEST_SKIPPED;
+#endif
+}
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 9837b6e93023..5a53ab7294e9 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -109,6 +109,7 @@ int test__unit_number__scnprint(struct test *test, int subtest);
 int test__mem2node(struct test *t, int subtest);
 int test__map_groups__merge_in(struct test *t, int subtest);
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
2.24.0.432.g9d3f5f5b63-goog

