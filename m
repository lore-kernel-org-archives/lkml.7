Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106ACC31E40
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4326208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="IlzVwDhY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731344AbfHOJZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 05:25:13 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34801 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731007AbfHOJZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 05:25:13 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7F9OgrZ2273378
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 15 Aug 2019 02:24:42 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7F9OgrZ2273378
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565861083;
        bh=O3R7u84xVzFZVaiTftKDe3Pi7Etc7l4VbOZN8IAgmHI=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=IlzVwDhYF/etgBd78ObNWS3eGeChnwEKIgcU8reZRlWQGgLyinCuIlhMsvB0dwv2p
         QJ7yEJNDyATXcF7St/kf9Xb2ynQ+1u4iLuiRA9eYaeJK+ssSsBzzQJVrwDlLiiwd2/
         u1dP28HPCw8CDVQjUP1ItK7tRTjTyrntmUkzZQlDCXbzfkej3/EdYJdZKIgToN3FJQ
         7wuUW8IwOSSHEXHv1239eEjr6mX/KybFIfWhHUHoshAdbXS99GPnQikwxVyKGRQjhm
         FtFQ4tgvCf9OY7tLh4/wqiWI0zNIDBgU9vn9Pic7SFLvI/8tcRBnsHSq20FJ/Wwubl
         f532i1rmihW2A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7F9Oe472273368;
        Thu, 15 Aug 2019 02:24:40 -0700
Date:   Thu, 15 Aug 2019 02:24:40 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Igor Lubashev <tipbot@zytor.com>
Message-ID: <tip-74d5f3d06f707eb5f7e1908ad88954bde02000ce@git.kernel.org>
Cc:     ilubashe@akamai.com, mathieu.poirier@linaro.org,
        tglx@linutronix.de, suzuki.poulose@arm.com, peterz@infradead.org,
        mingo@kernel.org, alexey.budankov@linux.intel.com,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, jolsa@kernel.org, namhyung@kernel.org,
        jmorris@namei.org, acme@redhat.com
Reply-To: alexey.budankov@linux.intel.com,
          alexander.shishkin@linux.intel.com, mingo@kernel.org,
          acme@redhat.com, linux-kernel@vger.kernel.org, jolsa@kernel.org,
          hpa@zytor.com, namhyung@kernel.org, jmorris@namei.org,
          tglx@linutronix.de, ilubashe@akamai.com,
          mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
          peterz@infradead.org
In-Reply-To: <8a1e76cf5c7c9796d0d4d240fbaa85305298aafa.1565188228.git.ilubashe@akamai.com>
References: <8a1e76cf5c7c9796d0d4d240fbaa85305298aafa.1565188228.git.ilubashe@akamai.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools build: Add capability-related feature
 detection
Git-Commit-ID: 74d5f3d06f707eb5f7e1908ad88954bde02000ce
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  74d5f3d06f707eb5f7e1908ad88954bde02000ce
Gitweb:     https://git.kernel.org/tip/74d5f3d06f707eb5f7e1908ad88954bde02000ce
Author:     Igor Lubashev <ilubashe@akamai.com>
AuthorDate: Wed, 7 Aug 2019 10:44:14 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 12 Aug 2019 17:14:14 -0300

tools build: Add capability-related feature detection

Add utilities to help checking capabilities of the running procss.  Make
perf link with libcap, if it is available. If no libcap-dev[el], assume
no capabilities.

Committer testing:

  $ make O=/tmp/build/perf -C tools/perf install-bin
  make: Entering directory '/home/acme/git/perf/tools/perf'
    BUILD:   Doing 'make -j8' parallel build

  Auto-detecting system features:
  <SNIP>
  ...                        libbfd: [ on  ]
  ...                        libcap: [ OFF ]
  ...                        libelf: [ on  ]
  <SNIP>
  Makefile.config:833: No libcap found, disables capability support, please install libcap-devel/libcap-dev
  <SNIP>
  $ grep libcap /tmp/build/perf/FEATURE-DUMP
  feature-libcap=0
  $ cat /tmp/build/perf/feature/test-libcap.make.output
  test-libcap.c:2:10: fatal error: sys/capability.h: No such file or directory
      2 | #include <sys/capability.h>
        |          ^~~~~~~~~~~~~~~~~~
  compilation terminated.
  $

Now install libcap-devel and try again:

  $ make O=/tmp/build/perf -C tools/perf install-bin
  make: Entering directory '/home/acme/git/perf/tools/perf'
    BUILD:   Doing 'make -j8' parallel build
  Warning: Kernel ABI header at 'tools/include/linux/bits.h' differs from latest version at 'include/linux/bits.h'
  diff -u tools/include/linux/bits.h include/linux/bits.h
  Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h'
  diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.h

  Auto-detecting system features:
  <SNIP>
  ...                        libbfd: [ on  ]
  ...                        libcap: [ on  ]
  ...                        libelf: [ on  ]
  <SNIP>>
    CC       /tmp/build/perf/jvmti/libjvmti.o
  <SNIP>>
  $ grep libcap /tmp/build/perf/FEATURE-DUMP
  feature-libcap=1
  $ cat /tmp/build/perf/feature/test-libcap.make.output
  $ ldd /tmp/build/perf/feature/test-libcap.make.bin
  ldd: /tmp/build/perf/feature/test-libcap.make.bin: No such file or directory
  $ ldd /tmp/build/perf/feature/test-libcap.bin
  	linux-vdso.so.1 (0x00007ffc35bfe000)
  	libcap.so.2 => /lib64/libcap.so.2 (0x00007ff9c62ff000)
  	libc.so.6 => /lib64/libc.so.6 (0x00007ff9c6139000)
  	/lib64/ld-linux-x86-64.so.2 (0x00007ff9c6326000)
  $

Signed-off-by: Igor Lubashev <ilubashe@akamai.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: James Morris <jmorris@namei.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
[ split from a larger patch ]
Link: http://lkml.kernel.org/r/8a1e76cf5c7c9796d0d4d240fbaa85305298aafa.1565188228.git.ilubashe@akamai.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/Makefile.feature      |  2 ++
 tools/build/feature/Makefile      |  4 ++++
 tools/build/feature/test-libcap.c | 20 ++++++++++++++++++++
 tools/perf/Makefile.config        | 11 +++++++++++
 tools/perf/Makefile.perf          |  2 ++
 5 files changed, 39 insertions(+)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 86b793dffbc4..8a19753cc26a 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -42,6 +42,7 @@ FEATURE_TESTS_BASIC :=                  \
         gtk2-infobar                    \
         libaudit                        \
         libbfd                          \
+        libcap                          \
         libelf                          \
         libelf-getphdrnum               \
         libelf-gelf_getnote             \
@@ -110,6 +111,7 @@ FEATURE_DISPLAY ?=              \
          gtk2                   \
          libaudit               \
          libbfd                 \
+         libcap                 \
          libelf                 \
          libnuma                \
          numa_num_possible_cpus \
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 0658b8cd0e53..8499385365c0 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -20,6 +20,7 @@ FILES=                                          \
          test-libbfd-liberty.bin                \
          test-libbfd-liberty-z.bin              \
          test-cplus-demangle.bin                \
+         test-libcap.bin			\
          test-libelf.bin                        \
          test-libelf-getphdrnum.bin             \
          test-libelf-gelf_getnote.bin           \
@@ -105,6 +106,9 @@ $(OUTPUT)test-fortify-source.bin:
 $(OUTPUT)test-bionic.bin:
 	$(BUILD)
 
+$(OUTPUT)test-libcap.bin:
+	$(BUILD) -lcap
+
 $(OUTPUT)test-libelf.bin:
 	$(BUILD) -lelf
 
diff --git a/tools/build/feature/test-libcap.c b/tools/build/feature/test-libcap.c
new file mode 100644
index 000000000000..d2a2e152195f
--- /dev/null
+++ b/tools/build/feature/test-libcap.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <sys/capability.h>
+#include <linux/capability.h>
+
+int main(void)
+{
+	cap_flag_value_t val;
+	cap_t caps = cap_get_proc();
+
+	if (!caps)
+		return 1;
+
+	if (cap_get_flag(caps, CAP_SYS_ADMIN, CAP_EFFECTIVE, &val) != 0)
+		return 1;
+
+	if (cap_free(caps) != 0)
+		return 1;
+
+	return 0;
+}
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index e4988f49ea79..9a06787fedc6 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -824,6 +824,17 @@ ifndef NO_LIBZSTD
   endif
 endif
 
+ifndef NO_LIBCAP
+  ifeq ($(feature-libcap), 1)
+    CFLAGS += -DHAVE_LIBCAP_SUPPORT
+    EXTLIBS += -lcap
+    $(call detected,CONFIG_LIBCAP)
+  else
+    msg := $(warning No libcap found, disables capability support, please install libcap-devel/libcap-dev);
+    NO_LIBCAP := 1
+  endif
+endif
+
 ifndef NO_BACKTRACE
   ifeq ($(feature-backtrace), 1)
     CFLAGS += -DHAVE_BACKTRACE_SUPPORT
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 67512a12276b..f9807d8c005b 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -88,6 +88,8 @@ include ../scripts/utilities.mak
 #
 # Define NO_LIBBPF if you do not want BPF support
 #
+# Define NO_LIBCAP if you do not want process capabilities considered by perf
+#
 # Define NO_SDT if you do not want to define SDT event in perf tools,
 # note that it doesn't disable SDT scanning support.
 #
