Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDA8C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F14F721721
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565808236;
	bh=Z6/E1TwlB3NAM/fUwYfNNLi84vqOrgHSTD0v+UbODM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bKnL5JQAAMc9fQRqo+nAqXsGy4JknEzdtXYpO+UwXIgqFukpD+yNKC77xYYbWDk/P
	 q5ABWYgZOT9JtYKWkT78dYFcKqElYh7fdKlgJg2QF38q1Zdf7F7zLLwGAfIzVOfY2y
	 ISf7+X906ZcHhc3z10ePsHn+DoPdI6LCmF2FOG10=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbfHNSnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:43:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:54120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728334AbfHNSny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:43:54 -0400
Received: from quaco.ghostprotocols.net (unknown [177.195.212.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0222A216F4;
        Wed, 14 Aug 2019 18:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565808233;
        bh=Z6/E1TwlB3NAM/fUwYfNNLi84vqOrgHSTD0v+UbODM4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gwo8Dfz+0ylB9aXoW5Qku+/1p0tpdLmK42nvi3RxTc3tiUDPmVwCXyVIvbDusI7kh
         8kUHosXBGJcC56uLUle8yD3ex9MlRZQa802IslTlgWne92TtEG5kd16t9coi2L+Ekx
         E2EbqfRsYPqV+N+OV9wXaUiwKIbEfZf8BbubCoqM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Igor Lubashev <ilubashe@akamai.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 13/28] perf tools: Add helpers to use capabilities if present
Date:   Wed, 14 Aug 2019 15:40:36 -0300
Message-Id: <20190814184051.3125-14-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190814184051.3125-1-acme@kernel.org>
References: <20190814184051.3125-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Lubashev <ilubashe@akamai.com>

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
 create mode 100644 tools/perf/util/cap.c
 create mode 100644 tools/perf/util/cap.h

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
-- 
2.21.0

