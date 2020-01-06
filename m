Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA78C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 16:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D6D9222D9
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 16:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578326861;
	bh=jJV2uD7kYbULFzozE1Gua3/nlb8lQ4avX1NtSw5aDMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E6YHLle3G3qaNEHPzS+Wwk+lxk2WQTl8oXYwNKh4Odw/JwDrrxi1HPgh1Syyq5H1O
	 TbnPxL50mEMo7uIomWeDo6ydzOgwRHHgOpS5dWdF15uvk3jN1vKDdAt2V/X/XQkZaz
	 cY88G7f9ArulLvFenxEeESlkjic/GyUFkq/fij90=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgAFQHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 11:07:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:45286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726793AbgAFQHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 11:07:38 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2349B208C4;
        Mon,  6 Jan 2020 16:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578326856;
        bh=jJV2uD7kYbULFzozE1Gua3/nlb8lQ4avX1NtSw5aDMM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=inapmfjViM5ZXztysTWDRJWhSADoys83MS53P1NI1v14QSlMWMia815n7FNZcJsvO
         Mq5Jb1vKSxlpPSKUlqhZksfePzwNi2O7aBUwfGiggx2NY+Eg2OnY9M6JyULpwmvhKJ
         p1s39utkXLL1UhXaRI28PNQacGynuJ5kBQqAT7Ho=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 06/20] libperf: Move to tools/lib/perf
Date:   Mon,  6 Jan 2020 13:06:51 -0300
Message-Id: <20200106160705.10899-7-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200106160705.10899-1-acme@kernel.org>
References: <20200106160705.10899-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move libperf from its current location under tools/perf to a separate
directory under tools/lib/.

Also change various paths (mainly includes) to reflect the libperf move
to a separate directory and add a new directory under MANIFEST.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191206210612.8676-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/{perf/lib => lib/perf}/Build                              | 0
 tools/{perf/lib => lib/perf}/Documentation/Makefile             | 0
 tools/{perf/lib => lib/perf}/Documentation/man/libperf.rst      | 0
 .../{perf/lib => lib/perf}/Documentation/tutorial/tutorial.rst  | 0
 tools/{perf/lib => lib/perf}/Makefile                           | 2 +-
 tools/{perf/lib => lib/perf}/core.c                             | 0
 tools/{perf/lib => lib/perf}/cpumap.c                           | 0
 tools/{perf/lib => lib/perf}/evlist.c                           | 0
 tools/{perf/lib => lib/perf}/evsel.c                            | 0
 tools/{perf/lib => lib/perf}/include/internal/cpumap.h          | 0
 tools/{perf/lib => lib/perf}/include/internal/evlist.h          | 0
 tools/{perf/lib => lib/perf}/include/internal/evsel.h           | 0
 tools/{perf/lib => lib/perf}/include/internal/lib.h             | 0
 tools/{perf/lib => lib/perf}/include/internal/mmap.h            | 0
 tools/{perf/lib => lib/perf}/include/internal/tests.h           | 0
 tools/{perf/lib => lib/perf}/include/internal/threadmap.h       | 0
 tools/{perf/lib => lib/perf}/include/internal/xyarray.h         | 0
 tools/{perf/lib => lib/perf}/include/perf/core.h                | 0
 tools/{perf/lib => lib/perf}/include/perf/cpumap.h              | 0
 tools/{perf/lib => lib/perf}/include/perf/event.h               | 0
 tools/{perf/lib => lib/perf}/include/perf/evlist.h              | 0
 tools/{perf/lib => lib/perf}/include/perf/evsel.h               | 0
 tools/{perf/lib => lib/perf}/include/perf/mmap.h                | 0
 tools/{perf/lib => lib/perf}/include/perf/threadmap.h           | 0
 tools/{perf/lib => lib/perf}/internal.h                         | 0
 tools/{perf/lib => lib/perf}/lib.c                              | 0
 tools/{perf/lib => lib/perf}/libperf.map                        | 0
 tools/{perf/lib => lib/perf}/libperf.pc.template                | 0
 tools/{perf/lib => lib/perf}/mmap.c                             | 0
 tools/{perf/lib => lib/perf}/tests/Makefile                     | 2 +-
 tools/{perf/lib => lib/perf}/tests/test-cpumap.c                | 0
 tools/{perf/lib => lib/perf}/tests/test-evlist.c                | 0
 tools/{perf/lib => lib/perf}/tests/test-evsel.c                 | 0
 tools/{perf/lib => lib/perf}/tests/test-threadmap.c             | 0
 tools/{perf/lib => lib/perf}/threadmap.c                        | 0
 tools/{perf/lib => lib/perf}/xyarray.c                          | 0
 tools/perf/MANIFEST                                             | 1 +
 tools/perf/Makefile.config                                      | 2 +-
 tools/perf/Makefile.perf                                        | 2 +-
 39 files changed, 5 insertions(+), 4 deletions(-)
 rename tools/{perf/lib => lib/perf}/Build (100%)
 rename tools/{perf/lib => lib/perf}/Documentation/Makefile (100%)
 rename tools/{perf/lib => lib/perf}/Documentation/man/libperf.rst (100%)
 rename tools/{perf/lib => lib/perf}/Documentation/tutorial/tutorial.rst (100%)
 rename tools/{perf/lib => lib/perf}/Makefile (99%)
 rename tools/{perf/lib => lib/perf}/core.c (100%)
 rename tools/{perf/lib => lib/perf}/cpumap.c (100%)
 rename tools/{perf/lib => lib/perf}/evlist.c (100%)
 rename tools/{perf/lib => lib/perf}/evsel.c (100%)
 rename tools/{perf/lib => lib/perf}/include/internal/cpumap.h (100%)
 rename tools/{perf/lib => lib/perf}/include/internal/evlist.h (100%)
 rename tools/{perf/lib => lib/perf}/include/internal/evsel.h (100%)
 rename tools/{perf/lib => lib/perf}/include/internal/lib.h (100%)
 rename tools/{perf/lib => lib/perf}/include/internal/mmap.h (100%)
 rename tools/{perf/lib => lib/perf}/include/internal/tests.h (100%)
 rename tools/{perf/lib => lib/perf}/include/internal/threadmap.h (100%)
 rename tools/{perf/lib => lib/perf}/include/internal/xyarray.h (100%)
 rename tools/{perf/lib => lib/perf}/include/perf/core.h (100%)
 rename tools/{perf/lib => lib/perf}/include/perf/cpumap.h (100%)
 rename tools/{perf/lib => lib/perf}/include/perf/event.h (100%)
 rename tools/{perf/lib => lib/perf}/include/perf/evlist.h (100%)
 rename tools/{perf/lib => lib/perf}/include/perf/evsel.h (100%)
 rename tools/{perf/lib => lib/perf}/include/perf/mmap.h (100%)
 rename tools/{perf/lib => lib/perf}/include/perf/threadmap.h (100%)
 rename tools/{perf/lib => lib/perf}/internal.h (100%)
 rename tools/{perf/lib => lib/perf}/lib.c (100%)
 rename tools/{perf/lib => lib/perf}/libperf.map (100%)
 rename tools/{perf/lib => lib/perf}/libperf.pc.template (100%)
 rename tools/{perf/lib => lib/perf}/mmap.c (100%)
 rename tools/{perf/lib => lib/perf}/tests/Makefile (93%)
 rename tools/{perf/lib => lib/perf}/tests/test-cpumap.c (100%)
 rename tools/{perf/lib => lib/perf}/tests/test-evlist.c (100%)
 rename tools/{perf/lib => lib/perf}/tests/test-evsel.c (100%)
 rename tools/{perf/lib => lib/perf}/tests/test-threadmap.c (100%)
 rename tools/{perf/lib => lib/perf}/threadmap.c (100%)
 rename tools/{perf/lib => lib/perf}/xyarray.c (100%)

diff --git a/tools/perf/lib/Build b/tools/lib/perf/Build
similarity index 100%
rename from tools/perf/lib/Build
rename to tools/lib/perf/Build
diff --git a/tools/perf/lib/Documentation/Makefile b/tools/lib/perf/Documentation/Makefile
similarity index 100%
rename from tools/perf/lib/Documentation/Makefile
rename to tools/lib/perf/Documentation/Makefile
diff --git a/tools/perf/lib/Documentation/man/libperf.rst b/tools/lib/perf/Documentation/man/libperf.rst
similarity index 100%
rename from tools/perf/lib/Documentation/man/libperf.rst
rename to tools/lib/perf/Documentation/man/libperf.rst
diff --git a/tools/perf/lib/Documentation/tutorial/tutorial.rst b/tools/lib/perf/Documentation/tutorial/tutorial.rst
similarity index 100%
rename from tools/perf/lib/Documentation/tutorial/tutorial.rst
rename to tools/lib/perf/Documentation/tutorial/tutorial.rst
diff --git a/tools/perf/lib/Makefile b/tools/lib/perf/Makefile
similarity index 99%
rename from tools/perf/lib/Makefile
rename to tools/lib/perf/Makefile
index 0f233638ef1f..768dd423730b 100644
--- a/tools/perf/lib/Makefile
+++ b/tools/lib/perf/Makefile
@@ -60,7 +60,7 @@ else
 endif
 
 INCLUDES = \
--I$(srctree)/tools/perf/lib/include \
+-I$(srctree)/tools/lib/perf/include \
 -I$(srctree)/tools/lib/ \
 -I$(srctree)/tools/include \
 -I$(srctree)/tools/arch/$(SRCARCH)/include/ \
diff --git a/tools/perf/lib/core.c b/tools/lib/perf/core.c
similarity index 100%
rename from tools/perf/lib/core.c
rename to tools/lib/perf/core.c
diff --git a/tools/perf/lib/cpumap.c b/tools/lib/perf/cpumap.c
similarity index 100%
rename from tools/perf/lib/cpumap.c
rename to tools/lib/perf/cpumap.c
diff --git a/tools/perf/lib/evlist.c b/tools/lib/perf/evlist.c
similarity index 100%
rename from tools/perf/lib/evlist.c
rename to tools/lib/perf/evlist.c
diff --git a/tools/perf/lib/evsel.c b/tools/lib/perf/evsel.c
similarity index 100%
rename from tools/perf/lib/evsel.c
rename to tools/lib/perf/evsel.c
diff --git a/tools/perf/lib/include/internal/cpumap.h b/tools/lib/perf/include/internal/cpumap.h
similarity index 100%
rename from tools/perf/lib/include/internal/cpumap.h
rename to tools/lib/perf/include/internal/cpumap.h
diff --git a/tools/perf/lib/include/internal/evlist.h b/tools/lib/perf/include/internal/evlist.h
similarity index 100%
rename from tools/perf/lib/include/internal/evlist.h
rename to tools/lib/perf/include/internal/evlist.h
diff --git a/tools/perf/lib/include/internal/evsel.h b/tools/lib/perf/include/internal/evsel.h
similarity index 100%
rename from tools/perf/lib/include/internal/evsel.h
rename to tools/lib/perf/include/internal/evsel.h
diff --git a/tools/perf/lib/include/internal/lib.h b/tools/lib/perf/include/internal/lib.h
similarity index 100%
rename from tools/perf/lib/include/internal/lib.h
rename to tools/lib/perf/include/internal/lib.h
diff --git a/tools/perf/lib/include/internal/mmap.h b/tools/lib/perf/include/internal/mmap.h
similarity index 100%
rename from tools/perf/lib/include/internal/mmap.h
rename to tools/lib/perf/include/internal/mmap.h
diff --git a/tools/perf/lib/include/internal/tests.h b/tools/lib/perf/include/internal/tests.h
similarity index 100%
rename from tools/perf/lib/include/internal/tests.h
rename to tools/lib/perf/include/internal/tests.h
diff --git a/tools/perf/lib/include/internal/threadmap.h b/tools/lib/perf/include/internal/threadmap.h
similarity index 100%
rename from tools/perf/lib/include/internal/threadmap.h
rename to tools/lib/perf/include/internal/threadmap.h
diff --git a/tools/perf/lib/include/internal/xyarray.h b/tools/lib/perf/include/internal/xyarray.h
similarity index 100%
rename from tools/perf/lib/include/internal/xyarray.h
rename to tools/lib/perf/include/internal/xyarray.h
diff --git a/tools/perf/lib/include/perf/core.h b/tools/lib/perf/include/perf/core.h
similarity index 100%
rename from tools/perf/lib/include/perf/core.h
rename to tools/lib/perf/include/perf/core.h
diff --git a/tools/perf/lib/include/perf/cpumap.h b/tools/lib/perf/include/perf/cpumap.h
similarity index 100%
rename from tools/perf/lib/include/perf/cpumap.h
rename to tools/lib/perf/include/perf/cpumap.h
diff --git a/tools/perf/lib/include/perf/event.h b/tools/lib/perf/include/perf/event.h
similarity index 100%
rename from tools/perf/lib/include/perf/event.h
rename to tools/lib/perf/include/perf/event.h
diff --git a/tools/perf/lib/include/perf/evlist.h b/tools/lib/perf/include/perf/evlist.h
similarity index 100%
rename from tools/perf/lib/include/perf/evlist.h
rename to tools/lib/perf/include/perf/evlist.h
diff --git a/tools/perf/lib/include/perf/evsel.h b/tools/lib/perf/include/perf/evsel.h
similarity index 100%
rename from tools/perf/lib/include/perf/evsel.h
rename to tools/lib/perf/include/perf/evsel.h
diff --git a/tools/perf/lib/include/perf/mmap.h b/tools/lib/perf/include/perf/mmap.h
similarity index 100%
rename from tools/perf/lib/include/perf/mmap.h
rename to tools/lib/perf/include/perf/mmap.h
diff --git a/tools/perf/lib/include/perf/threadmap.h b/tools/lib/perf/include/perf/threadmap.h
similarity index 100%
rename from tools/perf/lib/include/perf/threadmap.h
rename to tools/lib/perf/include/perf/threadmap.h
diff --git a/tools/perf/lib/internal.h b/tools/lib/perf/internal.h
similarity index 100%
rename from tools/perf/lib/internal.h
rename to tools/lib/perf/internal.h
diff --git a/tools/perf/lib/lib.c b/tools/lib/perf/lib.c
similarity index 100%
rename from tools/perf/lib/lib.c
rename to tools/lib/perf/lib.c
diff --git a/tools/perf/lib/libperf.map b/tools/lib/perf/libperf.map
similarity index 100%
rename from tools/perf/lib/libperf.map
rename to tools/lib/perf/libperf.map
diff --git a/tools/perf/lib/libperf.pc.template b/tools/lib/perf/libperf.pc.template
similarity index 100%
rename from tools/perf/lib/libperf.pc.template
rename to tools/lib/perf/libperf.pc.template
diff --git a/tools/perf/lib/mmap.c b/tools/lib/perf/mmap.c
similarity index 100%
rename from tools/perf/lib/mmap.c
rename to tools/lib/perf/mmap.c
diff --git a/tools/perf/lib/tests/Makefile b/tools/lib/perf/tests/Makefile
similarity index 93%
rename from tools/perf/lib/tests/Makefile
rename to tools/lib/perf/tests/Makefile
index a43cd08c5c03..96841775feaf 100644
--- a/tools/perf/lib/tests/Makefile
+++ b/tools/lib/perf/tests/Makefile
@@ -16,7 +16,7 @@ all:
 
 include $(srctree)/tools/scripts/Makefile.include
 
-INCLUDE = -I$(srctree)/tools/perf/lib/include -I$(srctree)/tools/include -I$(srctree)/tools/lib
+INCLUDE = -I$(srctree)/tools/lib/perf/include -I$(srctree)/tools/include -I$(srctree)/tools/lib
 
 $(TESTS_A): FORCE
 	$(QUIET_LINK)$(CC) $(INCLUDE) $(CFLAGS) -o $@ $(subst -a,.c,$@) ../libperf.a $(LIBAPI)
diff --git a/tools/perf/lib/tests/test-cpumap.c b/tools/lib/perf/tests/test-cpumap.c
similarity index 100%
rename from tools/perf/lib/tests/test-cpumap.c
rename to tools/lib/perf/tests/test-cpumap.c
diff --git a/tools/perf/lib/tests/test-evlist.c b/tools/lib/perf/tests/test-evlist.c
similarity index 100%
rename from tools/perf/lib/tests/test-evlist.c
rename to tools/lib/perf/tests/test-evlist.c
diff --git a/tools/perf/lib/tests/test-evsel.c b/tools/lib/perf/tests/test-evsel.c
similarity index 100%
rename from tools/perf/lib/tests/test-evsel.c
rename to tools/lib/perf/tests/test-evsel.c
diff --git a/tools/perf/lib/tests/test-threadmap.c b/tools/lib/perf/tests/test-threadmap.c
similarity index 100%
rename from tools/perf/lib/tests/test-threadmap.c
rename to tools/lib/perf/tests/test-threadmap.c
diff --git a/tools/perf/lib/threadmap.c b/tools/lib/perf/threadmap.c
similarity index 100%
rename from tools/perf/lib/threadmap.c
rename to tools/lib/perf/threadmap.c
diff --git a/tools/perf/lib/xyarray.c b/tools/lib/perf/xyarray.c
similarity index 100%
rename from tools/perf/lib/xyarray.c
rename to tools/lib/perf/xyarray.c
diff --git a/tools/perf/MANIFEST b/tools/perf/MANIFEST
index 4934edb5adfd..5d7b947320fb 100644
--- a/tools/perf/MANIFEST
+++ b/tools/perf/MANIFEST
@@ -7,6 +7,7 @@ tools/lib/traceevent
 tools/lib/api
 tools/lib/bpf
 tools/lib/subcmd
+tools/lib/perf
 tools/lib/argv_split.c
 tools/lib/ctype.c
 tools/lib/hweight.c
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index c90f4146e5a2..80e55e796be9 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -286,7 +286,7 @@ ifeq ($(DEBUG),0)
   endif
 endif
 
-INC_FLAGS += -I$(src-perf)/lib/include
+INC_FLAGS += -I$(srctree)/tools/lib/perf/include
 INC_FLAGS += -I$(src-perf)/util/include
 INC_FLAGS += -I$(src-perf)/arch/$(SRCARCH)/include
 INC_FLAGS += -I$(srctree)/tools/include/
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index eae5d5e95952..3eda9d4b88e7 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -230,7 +230,7 @@ LIB_DIR         = $(srctree)/tools/lib/api/
 TRACE_EVENT_DIR = $(srctree)/tools/lib/traceevent/
 BPF_DIR         = $(srctree)/tools/lib/bpf/
 SUBCMD_DIR      = $(srctree)/tools/lib/subcmd/
-LIBPERF_DIR     = $(srctree)/tools/perf/lib/
+LIBPERF_DIR     = $(srctree)/tools/lib/perf/
 
 # Set FEATURE_TESTS to 'all' so all possible feature checkers are executed.
 # Without this setting the output feature dump file misses some features, for
-- 
2.21.1

