Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F0CC433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC31821873
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="bFdj3xvt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731355AbfHOJZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 05:25:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49361 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730939AbfHOJZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 05:25:55 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7F9PSpn2273469
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 15 Aug 2019 02:25:28 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7F9PSpn2273469
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565861129;
        bh=LDl1z16vncmPXWZDTxe3P8S/Jo8I8UhNKIyAe3oBczQ=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=bFdj3xvtZgeXKBX0u6vcmGvXTsxhQsI5wTN7nw8ppUTxIF1D4MyIku8ABds5Gifjt
         +kYo6whtLsi4/7A3BZ07sKTd2sZ0RIUnuAjJKJczURxPPBRnJw9/oNp9RpYovd9Z+I
         sCPeYWxmkJ87s2+/I4ZOjLfXVmpUtc3YX1y6XosaKNbK1IUMqFyxTBmpbrrzVGnThn
         uFGinTgaYH37M2yp6uBOoyGOlSxBXg4BY3kXKO4hys5G9fr7hYqwOOuY4ymBjX5g5S
         gCziUz11z7gBEJngxgKycPukiJKr7kHei8a1KPVhVVUU5zeNEWR2vsRWAWbGiA1Dx5
         OvJvNRr7/mivg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7F9PRbR2273466;
        Thu, 15 Aug 2019 02:25:27 -0700
Date:   Thu, 15 Aug 2019 02:25:27 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Igor Lubashev <tipbot@zytor.com>
Message-ID: <tip-c22e150e3afa6f8db2300bd510e4ac26bbee1bf3@git.kernel.org>
Cc:     alexander.shishkin@linux.intel.com, tglx@linutronix.de,
        hpa@zytor.com, jolsa@kernel.org, mathieu.poirier@linaro.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        alexey.budankov@linux.intel.com, jmorris@namei.org,
        mingo@kernel.org, namhyung@kernel.org, ilubashe@akamai.com,
        suzuki.poulose@arm.com, acme@redhat.com
Reply-To: mingo@kernel.org, namhyung@kernel.org, jmorris@namei.org,
          acme@redhat.com, ilubashe@akamai.com, suzuki.poulose@arm.com,
          alexander.shishkin@linux.intel.com, tglx@linutronix.de,
          alexey.budankov@linux.intel.com, jolsa@kernel.org,
          mathieu.poirier@linaro.org, hpa@zytor.com, peterz@infradead.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <8a1e76cf5c7c9796d0d4d240fbaa85305298aafa.1565188228.git.ilubashe@akamai.com>
References: <8a1e76cf5c7c9796d0d4d240fbaa85305298aafa.1565188228.git.ilubashe@akamai.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Add helpers to use capabilities if
 present
Git-Commit-ID: c22e150e3afa6f8db2300bd510e4ac26bbee1bf3
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

Commit-ID:  c22e150e3afa6f8db2300bd510e4ac26bbee1bf3
Gitweb:     https://git.kernel.org/tip/c22e150e3afa6f8db2300bd510e4ac26bbee1bf3
Author:     Igor Lubashev <ilubashe@akamai.com>
AuthorDate: Wed, 7 Aug 2019 10:44:14 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 14 Aug 2019 10:48:39 -0300

perf tools: Add helpers to use capabilities if present

Add utilities to help checking capabilities of the running procss.  Make
perf link with libcap, if it is available. If no libcap-dev[el],
fallback to the geteuid() == 0 test used before.

Committer notes:

  $ perf test python
  18: 'import perf' in python                               : FAILED!
  $ perf test -v python
  Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF maps, etc
  18: 'import perf' in python                               :
  --- start ---
  test child forked, pid 23288
  Traceback (most recent call last):
    File "<stdin>", line 1, in <module>
  ImportError: /tmp/build/perf/python/perf.so: undefined symbol: cap_get_flag
  test child finished with -1
  ---- end ----
  'import perf' in python: FAILED!
  $

This happens because differently from the perf binary generated with
this patch applied:

  $ ldd /tmp/build/perf/perf | grep libcap
  	libcap.so.2 => /lib64/libcap.so.2 (0x00007f724a4ef000)
  $

The python binding isn't linking with libcap:

  $ ldd /tmp/build/perf/python/perf.so | grep libcap
  $

So add 'cap' to the 'extra_libraries' variable in
tools/perf/util/setup.py, and rebuild:

  $ perf test python
  18: 'import perf' in python                               : Ok
  $

If we explicitely disable libcap it also continues to work:

  $ make NO_LIBCAP=1 -C tools/perf O=/tmp/build/perf install-bin
    $ ldd /tmp/build/perf/perf | grep libcap
  $ ldd /tmp/build/perf/python/perf.so | grep libcap
  $ perf test python
  18: 'import perf' in python                               : Ok
  $

Signed-off-by: Igor Lubashev <ilubashe@akamai.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: James Morris <jmorris@namei.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
[ split from a larger patch ]
Link: http://lkml.kernel.org/r/8a1e76cf5c7c9796d0d4d240fbaa85305298aafa.1565188228.git.ilubashe@akamai.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/Build              |  2 ++
 tools/perf/util/cap.c              | 29 +++++++++++++++++++++++++++++
 tools/perf/util/cap.h              | 27 +++++++++++++++++++++++++++
 tools/perf/util/event.h            |  1 +
 tools/perf/util/python-ext-sources |  1 +
 tools/perf/util/setup.py           |  2 ++
 tools/perf/util/util.c             |  9 +++++++++
 7 files changed, 71 insertions(+)

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 7abf05131889..7cda749059a9 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -148,6 +148,8 @@ perf-$(CONFIG_ZLIB) += zlib.o
 perf-$(CONFIG_LZMA) += lzma.o
 perf-$(CONFIG_ZSTD) += zstd.o
 
+perf-$(CONFIG_LIBCAP) += cap.o
+
 perf-y += demangle-java.o
 perf-y += demangle-rust.o
 
diff --git a/tools/perf/util/cap.c b/tools/perf/util/cap.c
new file mode 100644
index 000000000000..c3ba841bbf37
--- /dev/null
+++ b/tools/perf/util/cap.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Capability utilities
+ */
+
+#ifdef HAVE_LIBCAP_SUPPORT
+
+#include "cap.h"
+#include <stdbool.h>
+#include <sys/capability.h>
+
+bool perf_cap__capable(cap_value_t cap)
+{
+	cap_flag_value_t val;
+	cap_t caps = cap_get_proc();
+
+	if (!caps)
+		return false;
+
+	if (cap_get_flag(caps, cap, CAP_EFFECTIVE, &val) != 0)
+		val = CAP_CLEAR;
+
+	if (cap_free(caps) != 0)
+		return false;
+
+	return val == CAP_SET;
+}
+
+#endif  /* HAVE_LIBCAP_SUPPORT */
diff --git a/tools/perf/util/cap.h b/tools/perf/util/cap.h
new file mode 100644
index 000000000000..10af94e473da
--- /dev/null
+++ b/tools/perf/util/cap.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PERF_CAP_H
+#define __PERF_CAP_H
+
+#include <stdbool.h>
+#include <linux/capability.h>
+#include <linux/compiler.h>
+
+#ifdef HAVE_LIBCAP_SUPPORT
+
+#include <sys/capability.h>
+
+bool perf_cap__capable(cap_value_t cap);
+
+#else
+
+#include <unistd.h>
+#include <sys/types.h>
+
+static inline bool perf_cap__capable(int cap __maybe_unused)
+{
+	return geteuid() == 0;
+}
+
+#endif /* HAVE_LIBCAP_SUPPORT */
+
+#endif /* __PERF_CAP_H */
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 70841d115349..0e164e8ae28d 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -851,6 +851,7 @@ void  cpu_map_data__synthesize(struct cpu_map_data *data, struct perf_cpu_map *m
 void event_attr_init(struct perf_event_attr *attr);
 
 int perf_event_paranoid(void);
+bool perf_event_paranoid_check(int max_level);
 
 extern int sysctl_perf_event_max_stack;
 extern int sysctl_perf_event_max_contexts_per_stack;
diff --git a/tools/perf/util/python-ext-sources b/tools/perf/util/python-ext-sources
index 235bd9803390..c6dd478956f1 100644
--- a/tools/perf/util/python-ext-sources
+++ b/tools/perf/util/python-ext-sources
@@ -7,6 +7,7 @@
 
 util/python.c
 ../lib/ctype.c
+util/cap.c
 util/evlist.c
 util/evsel.c
 util/cpumap.c
diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index d48f9cd58964..aa344a163eaf 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -59,6 +59,8 @@ ext_sources = list(map(lambda x: '%s/%s' % (src_perf, x) , ext_sources))
 extra_libraries = []
 if '-DHAVE_LIBNUMA_SUPPORT' in cflags:
     extra_libraries = [ 'numa' ]
+if '-DHAVE_LIBCAP_SUPPORT' in cflags:
+    extra_libraries += [ 'cap' ]
 
 perf = Extension('perf',
 		  sources = ext_sources,
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 9c3c97697387..6fd130a5d8f2 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -16,10 +16,12 @@
 #include <string.h>
 #include <errno.h>
 #include <limits.h>
+#include <linux/capability.h>
 #include <linux/kernel.h>
 #include <linux/log2.h>
 #include <linux/time64.h>
 #include <unistd.h>
+#include "cap.h"
 #include "strlist.h"
 #include "string2.h"
 
@@ -403,6 +405,13 @@ int perf_event_paranoid(void)
 
 	return value;
 }
+
+bool perf_event_paranoid_check(int max_level)
+{
+	return perf_cap__capable(CAP_SYS_ADMIN) ||
+			perf_event_paranoid() <= max_level;
+}
+
 static int
 fetch_ubuntu_kernel_version(unsigned int *puint)
 {
