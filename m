Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37921C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E7EB208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561138891;
	bh=NP/NYZEnEprewmSVTtyT+Nksu73Id+S5luyzTRk68Z4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Qf7Gb9mtvKIkH2YO/9beXf+FLHw9zEU2O6+WV5Qb3Ed+C5C5YvwNDvwYOV6sNyubi
	 C0ixRcG4g69/sG4upvHeEF1oprysQj7+KbdDMmyiutyFwdOkAbwVxwNLz3JHVP6xSF
	 /hsMaFDLtawnTQQB8/UIWeodYkUW4OKTKi7diwms=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfFURl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 13:41:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:60554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbfFURl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 13:41:28 -0400
Received: from quaco.ghostprotocols.net (187-26-104-93.3g.claro.net.br [187.26.104.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C57692083B;
        Fri, 21 Jun 2019 17:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561138887;
        bh=NP/NYZEnEprewmSVTtyT+Nksu73Id+S5luyzTRk68Z4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h7Zo3X10v8x3clhaLYnIHDYtLqYIB/yqwoQxravHJEEhV3nmiiHa+z+hIxGjd1wvL
         4SKSI+xm7Y4tG1txgkHaEUdpE8oojRPej9hhOVOqfs3qJ14HDrt8VrHF2IFUiW2zeW
         43CD0flkQfUxNv3PqJSj7BqigYz6vR61ehYgd+84=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 23/25] tools build: Add test to check if slang.h is in /usr/include/slang/
Date:   Fri, 21 Jun 2019 14:38:29 -0300
Message-Id: <20190621173831.13780-24-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190621173831.13780-1-acme@kernel.org>
References: <20190621173831.13780-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

A few odd old distros (rhel5, 6, yeah, lots of those out in use, in many
cases we want to use upstream perf on it) have the slang header files in
/usr/include/slang/, so add a test that will be performed only when
test-all.c (the one with the most common sane settings) fails, either
because we're in one of these odd distros with slang/slang.h or because
something else failed (say libelf is not present).

So for the common case nothing changes, no additional test is performed.

Next step is to check in perf the result of these tests.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Fixes: 1955c8cf5e26 ("perf tools: Don't hardcode host include path for libslang")
Link: https://lkml.kernel.org/n/tip-2sy7hbwkx68jr6n97qxgg0c6@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/Makefile.feature                       | 2 +-
 tools/build/feature/Makefile                       | 4 ++++
 tools/build/feature/test-libslang-include-subdir.c | 7 +++++++
 3 files changed, 12 insertions(+), 1 deletion(-)
 create mode 100644 tools/build/feature/test-libslang-include-subdir.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 50377cc2f5f9..86b793dffbc4 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -53,6 +53,7 @@ FEATURE_TESTS_BASIC :=                  \
         libpython                       \
         libpython-version               \
         libslang                        \
+        libslang-include-subdir         \
         libcrypto                       \
         libunwind                       \
         pthread-attr-setaffinity-np     \
@@ -114,7 +115,6 @@ FEATURE_DISPLAY ?=              \
          numa_num_possible_cpus \
          libperl                \
          libpython              \
-         libslang               \
          libcrypto              \
          libunwind              \
          libdw-dwarf-unwind     \
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 7ef7cf04a292..0658b8cd0e53 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -31,6 +31,7 @@ FILES=                                          \
          test-libpython.bin                     \
          test-libpython-version.bin             \
          test-libslang.bin                      \
+         test-libslang-include-subdir.bin       \
          test-libcrypto.bin                     \
          test-libunwind.bin                     \
          test-libunwind-debug-frame.bin         \
@@ -184,6 +185,9 @@ $(OUTPUT)test-libaudit.bin:
 $(OUTPUT)test-libslang.bin:
 	$(BUILD) -lslang
 
+$(OUTPUT)test-libslang-include-subdir.bin:
+	$(BUILD) -lslang
+
 $(OUTPUT)test-libcrypto.bin:
 	$(BUILD) -lcrypto
 
diff --git a/tools/build/feature/test-libslang-include-subdir.c b/tools/build/feature/test-libslang-include-subdir.c
new file mode 100644
index 000000000000..3ea47ec7590e
--- /dev/null
+++ b/tools/build/feature/test-libslang-include-subdir.c
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <slang/slang.h>
+
+int main(void)
+{
+	return SLsmg_init_smg();
+}
-- 
2.20.1

