Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE67C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 21:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F42320659
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 21:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575666401;
	bh=v75QbM08WPUPXnGLO0w7ctDLFyVq67+n8wMq8JQC2vo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FZ88L20zFX/Kis2lWVktFXxAoXFNqWB9Gz3cFwN7YAg4Px76sAzx9DQI8qxac6fe4
	 8b5D6ooIOLxGXS4vkzhuMMfWXX0yav9rF5Q4cy+3TJy35dq8m3zAuoVA+zG9FxEfBX
	 KO/YG4oABpaIMvpMb1Q8lbc49Hi4HBA6pnXwaJm4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfLFVGj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 16:06:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41626 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726325AbfLFVGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 16:06:39 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-ZjJr-aGzNCuXgUAiw7mMQA-1; Fri, 06 Dec 2019 16:06:21 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BCE8F1005514;
        Fri,  6 Dec 2019 21:06:19 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-89.brq.redhat.com [10.40.204.89])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 93448600C6;
        Fri,  6 Dec 2019 21:06:16 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 1/2] libperf: Move libperf under tools/lib/perf
Date:   Fri,  6 Dec 2019 22:06:11 +0100
Message-Id: <20191206210612.8676-2-jolsa@kernel.org>
In-Reply-To: <20191206210612.8676-1-jolsa@kernel.org>
References: <20191206210612.8676-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: ZjJr-aGzNCuXgUAiw7mMQA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving libperf from its current location under perf
to separate directory under tools/lib.

Also changing various paths (mainly include) to reflect
the libperf move under separate directory and adding
new directory under MANIFEST.

Link: https://lkml.kernel.org/n/tip-78qoi1s5iitrfmsj67j2evzd@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/perf/Build                          |  13 +
 tools/lib/perf/Documentation/Makefile         |   7 +
 tools/lib/perf/Documentation/man/libperf.rst  | 100 +++
 .../perf/Documentation/tutorial/tutorial.rst  | 123 ++++
 tools/lib/perf/Makefile                       | 188 +++++
 tools/lib/perf/core.c                         |  38 ++
 tools/lib/perf/cpumap.c                       | 345 ++++++++++
 tools/lib/perf/evlist.c                       | 641 ++++++++++++++++++
 tools/lib/perf/evsel.c                        | 301 ++++++++
 tools/lib/perf/include/internal/cpumap.h      |  19 +
 tools/lib/perf/include/internal/evlist.h      | 127 ++++
 tools/lib/perf/include/internal/evsel.h       |  63 ++
 tools/lib/perf/include/internal/lib.h         |  12 +
 tools/lib/perf/include/internal/mmap.h        |  55 ++
 tools/lib/perf/include/internal/tests.h       |  33 +
 tools/lib/perf/include/internal/threadmap.h   |  23 +
 tools/lib/perf/include/internal/xyarray.h     |  36 +
 tools/lib/perf/include/perf/core.h            |  25 +
 tools/lib/perf/include/perf/cpumap.h          |  28 +
 tools/lib/perf/include/perf/event.h           | 385 +++++++++++
 tools/lib/perf/include/perf/evlist.h          |  49 ++
 tools/lib/perf/include/perf/evsel.h           |  40 ++
 tools/lib/perf/include/perf/mmap.h            |  15 +
 tools/lib/perf/include/perf/threadmap.h       |  20 +
 tools/lib/perf/internal.h                     |  23 +
 tools/lib/perf/lib.c                          |  48 ++
 tools/lib/perf/libperf.map                    |  51 ++
 tools/lib/perf/libperf.pc.template            |  11 +
 tools/lib/perf/mmap.c                         | 275 ++++++++
 tools/lib/perf/tests/Makefile                 |  38 ++
 tools/lib/perf/tests/test-cpumap.c            |  31 +
 tools/lib/perf/tests/test-evlist.c            | 413 +++++++++++
 tools/lib/perf/tests/test-evsel.c             | 135 ++++
 tools/lib/perf/tests/test-threadmap.c         |  31 +
 tools/lib/perf/threadmap.c                    |  91 +++
 tools/lib/perf/xyarray.c                      |  33 +
 tools/perf/MANIFEST                           |   1 +
 tools/perf/Makefile.config                    |   2 +-
 tools/perf/Makefile.perf                      |   2 +-
 tools/perf/lib/Build                          |  13 -
 tools/perf/lib/Documentation/Makefile         |   7 -
 tools/perf/lib/Documentation/man/libperf.rst  | 100 ---
 .../lib/Documentation/tutorial/tutorial.rst   | 123 ----
 tools/perf/lib/Makefile                       | 188 -----
 tools/perf/lib/core.c                         |  38 --
 tools/perf/lib/cpumap.c                       | 345 ----------
 tools/perf/lib/evlist.c                       | 641 ------------------
 tools/perf/lib/evsel.c                        | 301 --------
 tools/perf/lib/include/internal/cpumap.h      |  19 -
 tools/perf/lib/include/internal/evlist.h      | 127 ----
 tools/perf/lib/include/internal/evsel.h       |  63 --
 tools/perf/lib/include/internal/lib.h         |  12 -
 tools/perf/lib/include/internal/mmap.h        |  55 --
 tools/perf/lib/include/internal/tests.h       |  33 -
 tools/perf/lib/include/internal/threadmap.h   |  23 -
 tools/perf/lib/include/internal/xyarray.h     |  36 -
 tools/perf/lib/include/perf/core.h            |  25 -
 tools/perf/lib/include/perf/cpumap.h          |  28 -
 tools/perf/lib/include/perf/event.h           | 385 -----------
 tools/perf/lib/include/perf/evlist.h          |  49 --
 tools/perf/lib/include/perf/evsel.h           |  40 --
 tools/perf/lib/include/perf/mmap.h            |  15 -
 tools/perf/lib/include/perf/threadmap.h       |  20 -
 tools/perf/lib/internal.h                     |  23 -
 tools/perf/lib/lib.c                          |  48 --
 tools/perf/lib/libperf.map                    |  51 --
 tools/perf/lib/libperf.pc.template            |  11 -
 tools/perf/lib/mmap.c                         | 275 --------
 tools/perf/lib/tests/Makefile                 |  38 --
 tools/perf/lib/tests/test-cpumap.c            |  31 -
 tools/perf/lib/tests/test-evlist.c            | 413 -----------
 tools/perf/lib/tests/test-evsel.c             | 135 ----
 tools/perf/lib/tests/test-threadmap.c         |  31 -
 tools/perf/lib/threadmap.c                    |  91 ---
 tools/perf/lib/xyarray.c                      |  33 -
 75 files changed, 3869 insertions(+), 3868 deletions(-)
 create mode 100644 tools/lib/perf/Build
 create mode 100644 tools/lib/perf/Documentation/Makefile
 create mode 100644 tools/lib/perf/Documentation/man/libperf.rst
 create mode 100644 tools/lib/perf/Documentation/tutorial/tutorial.rst
 create mode 100644 tools/lib/perf/Makefile
 create mode 100644 tools/lib/perf/core.c
 create mode 100644 tools/lib/perf/cpumap.c
 create mode 100644 tools/lib/perf/evlist.c
 create mode 100644 tools/lib/perf/evsel.c
 create mode 100644 tools/lib/perf/include/internal/cpumap.h
 create mode 100644 tools/lib/perf/include/internal/evlist.h
 create mode 100644 tools/lib/perf/include/internal/evsel.h
 create mode 100644 tools/lib/perf/include/internal/lib.h
 create mode 100644 tools/lib/perf/include/internal/mmap.h
 create mode 100644 tools/lib/perf/include/internal/tests.h
 create mode 100644 tools/lib/perf/include/internal/threadmap.h
 create mode 100644 tools/lib/perf/include/internal/xyarray.h
 create mode 100644 tools/lib/perf/include/perf/core.h
 create mode 100644 tools/lib/perf/include/perf/cpumap.h
 create mode 100644 tools/lib/perf/include/perf/event.h
 create mode 100644 tools/lib/perf/include/perf/evlist.h
 create mode 100644 tools/lib/perf/include/perf/evsel.h
 create mode 100644 tools/lib/perf/include/perf/mmap.h
 create mode 100644 tools/lib/perf/include/perf/threadmap.h
 create mode 100644 tools/lib/perf/internal.h
 create mode 100644 tools/lib/perf/lib.c
 create mode 100644 tools/lib/perf/libperf.map
 create mode 100644 tools/lib/perf/libperf.pc.template
 create mode 100644 tools/lib/perf/mmap.c
 create mode 100644 tools/lib/perf/tests/Makefile
 create mode 100644 tools/lib/perf/tests/test-cpumap.c
 create mode 100644 tools/lib/perf/tests/test-evlist.c
 create mode 100644 tools/lib/perf/tests/test-evsel.c
 create mode 100644 tools/lib/perf/tests/test-threadmap.c
 create mode 100644 tools/lib/perf/threadmap.c
 create mode 100644 tools/lib/perf/xyarray.c
 delete mode 100644 tools/perf/lib/Build
 delete mode 100644 tools/perf/lib/Documentation/Makefile
 delete mode 100644 tools/perf/lib/Documentation/man/libperf.rst
 delete mode 100644 tools/perf/lib/Documentation/tutorial/tutorial.rst
 delete mode 100644 tools/perf/lib/Makefile
 delete mode 100644 tools/perf/lib/core.c
 delete mode 100644 tools/perf/lib/cpumap.c
 delete mode 100644 tools/perf/lib/evlist.c
 delete mode 100644 tools/perf/lib/evsel.c
 delete mode 100644 tools/perf/lib/include/internal/cpumap.h
 delete mode 100644 tools/perf/lib/include/internal/evlist.h
 delete mode 100644 tools/perf/lib/include/internal/evsel.h
 delete mode 100644 tools/perf/lib/include/internal/lib.h
 delete mode 100644 tools/perf/lib/include/internal/mmap.h
 delete mode 100644 tools/perf/lib/include/internal/tests.h
 delete mode 100644 tools/perf/lib/include/internal/threadmap.h
 delete mode 100644 tools/perf/lib/include/internal/xyarray.h
 delete mode 100644 tools/perf/lib/include/perf/core.h
 delete mode 100644 tools/perf/lib/include/perf/cpumap.h
 delete mode 100644 tools/perf/lib/include/perf/event.h
 delete mode 100644 tools/perf/lib/include/perf/evlist.h
 delete mode 100644 tools/perf/lib/include/perf/evsel.h
 delete mode 100644 tools/perf/lib/include/perf/mmap.h
 delete mode 100644 tools/perf/lib/include/perf/threadmap.h
 delete mode 100644 tools/perf/lib/internal.h
 delete mode 100644 tools/perf/lib/lib.c
 delete mode 100644 tools/perf/lib/libperf.map
 delete mode 100644 tools/perf/lib/libperf.pc.template
 delete mode 100644 tools/perf/lib/mmap.c
 delete mode 100644 tools/perf/lib/tests/Makefile
 delete mode 100644 tools/perf/lib/tests/test-cpumap.c
 delete mode 100644 tools/perf/lib/tests/test-evlist.c
 delete mode 100644 tools/perf/lib/tests/test-evsel.c
 delete mode 100644 tools/perf/lib/tests/test-threadmap.c
 delete mode 100644 tools/perf/lib/threadmap.c
 delete mode 100644 tools/perf/lib/xyarray.c

diff --git a/tools/lib/perf/Build b/tools/lib/perf/Build
new file mode 100644
index 000000000000..2ef9a4ec6d99
--- /dev/null
+++ b/tools/lib/perf/Build
@@ -0,0 +1,13 @@
+libperf-y += core.o
+libperf-y += cpumap.o
+libperf-y += threadmap.o
+libperf-y += evsel.o
+libperf-y += evlist.o
+libperf-y += mmap.o
+libperf-y += zalloc.o
+libperf-y += xyarray.o
+libperf-y += lib.o
+
+$(OUTPUT)zalloc.o: ../../lib/zalloc.c FORCE
+	$(call rule_mkdir)
+	$(call if_changed_dep,cc_o_c)
diff --git a/tools/lib/perf/Documentation/Makefile b/tools/lib/perf/Documentation/Makefile
new file mode 100644
index 000000000000..586425a88795
--- /dev/null
+++ b/tools/lib/perf/Documentation/Makefile
@@ -0,0 +1,7 @@
+all:
+	rst2man man/libperf.rst > man/libperf.7
+	rst2pdf tutorial/tutorial.rst
+
+clean:
+	rm -f man/libperf.7
+	rm -f tutorial/tutorial.pdf
diff --git a/tools/lib/perf/Documentation/man/libperf.rst b/tools/lib/perf/Documentation/man/libperf.rst
new file mode 100644
index 000000000000..09a270fccb9c
--- /dev/null
+++ b/tools/lib/perf/Documentation/man/libperf.rst
@@ -0,0 +1,100 @@
+.. SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+
+libperf
+
+The libperf library provides an API to access the linux kernel perf
+events subsystem. It provides the following high level objects:
+
+  - struct perf_cpu_map
+  - struct perf_thread_map
+  - struct perf_evlist
+  - struct perf_evsel
+
+reference
+=========
+Function reference by header files:
+
+perf/core.h
+-----------
+.. code-block:: c
+
+  typedef int (\*libperf_print_fn_t)(enum libperf_print_level level,
+                                     const char \*, va_list ap);
+
+  void libperf_set_print(libperf_print_fn_t fn);
+
+perf/cpumap.h
+-------------
+.. code-block:: c
+
+  struct perf_cpu_map \*perf_cpu_map__dummy_new(void);
+  struct perf_cpu_map \*perf_cpu_map__new(const char \*cpu_list);
+  struct perf_cpu_map \*perf_cpu_map__read(FILE \*file);
+  struct perf_cpu_map \*perf_cpu_map__get(struct perf_cpu_map \*map);
+  void perf_cpu_map__put(struct perf_cpu_map \*map);
+  int perf_cpu_map__cpu(const struct perf_cpu_map \*cpus, int idx);
+  int perf_cpu_map__nr(const struct perf_cpu_map \*cpus);
+  perf_cpu_map__for_each_cpu(cpu, idx, cpus)
+
+perf/threadmap.h
+----------------
+.. code-block:: c
+
+  struct perf_thread_map \*perf_thread_map__new_dummy(void);
+  void perf_thread_map__set_pid(struct perf_thread_map \*map, int thread, pid_t pid);
+  char \*perf_thread_map__comm(struct perf_thread_map \*map, int thread);
+  struct perf_thread_map \*perf_thread_map__get(struct perf_thread_map \*map);
+  void perf_thread_map__put(struct perf_thread_map \*map);
+
+perf/evlist.h
+-------------
+.. code-block::
+
+  void perf_evlist__init(struct perf_evlist \*evlist);
+  void perf_evlist__add(struct perf_evlist \*evlist,
+                      struct perf_evsel \*evsel);
+  void perf_evlist__remove(struct perf_evlist \*evlist,
+                         struct perf_evsel \*evsel);
+  struct perf_evlist \*perf_evlist__new(void);
+  void perf_evlist__delete(struct perf_evlist \*evlist);
+  struct perf_evsel\* perf_evlist__next(struct perf_evlist \*evlist,
+                                     struct perf_evsel \*evsel);
+  int perf_evlist__open(struct perf_evlist \*evlist);
+  void perf_evlist__close(struct perf_evlist \*evlist);
+  void perf_evlist__enable(struct perf_evlist \*evlist);
+  void perf_evlist__disable(struct perf_evlist \*evlist);
+  perf_evlist__for_each_evsel(evlist, pos)
+  void perf_evlist__set_maps(struct perf_evlist \*evlist,
+                           struct perf_cpu_map \*cpus,
+                           struct perf_thread_map \*threads);
+
+perf/evsel.h
+------------
+.. code-block:: c
+
+  struct perf_counts_values {
+        union {
+                struct {
+                        uint64_t val;
+                        uint64_t ena;
+                        uint64_t run;
+                };
+                uint64_t values[3];
+        };
+  };
+
+  void perf_evsel__init(struct perf_evsel \*evsel,
+                      struct perf_event_attr \*attr);
+  struct perf_evsel \*perf_evsel__new(struct perf_event_attr \*attr);
+  void perf_evsel__delete(struct perf_evsel \*evsel);
+  int perf_evsel__open(struct perf_evsel \*evsel, struct perf_cpu_map \*cpus,
+                     struct perf_thread_map \*threads);
+  void perf_evsel__close(struct perf_evsel \*evsel);
+  int perf_evsel__read(struct perf_evsel \*evsel, int cpu, int thread,
+                     struct perf_counts_values \*count);
+  int perf_evsel__enable(struct perf_evsel \*evsel);
+  int perf_evsel__disable(struct perf_evsel \*evsel);
+  int perf_evsel__apply_filter(struct perf_evsel \*evsel, const char \*filter);
+  struct perf_cpu_map \*perf_evsel__cpus(struct perf_evsel \*evsel);
+  struct perf_thread_map \*perf_evsel__threads(struct perf_evsel \*evsel);
+  struct perf_event_attr \*perf_evsel__attr(struct perf_evsel \*evsel);
diff --git a/tools/lib/perf/Documentation/tutorial/tutorial.rst b/tools/lib/perf/Documentation/tutorial/tutorial.rst
new file mode 100644
index 000000000000..7be7bc27b385
--- /dev/null
+++ b/tools/lib/perf/Documentation/tutorial/tutorial.rst
@@ -0,0 +1,123 @@
+.. SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+
+libperf tutorial
+================
+
+Compile and install libperf from kernel sources
+===============================================
+.. code-block:: bash
+
+  git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
+  cd linux/tools/perf/lib
+  make
+  sudo make install prefix=/usr
+
+Libperf object
+==============
+The libperf library provides several high level objects:
+
+struct perf_cpu_map
+  Provides a cpu list abstraction.
+
+struct perf_thread_map
+  Provides a thread list abstraction.
+
+struct perf_evsel
+  Provides an abstraction for single a perf event.
+
+struct perf_evlist
+  Gathers several struct perf_evsel object and performs functions on all of them.
+
+The exported API binds these objects together,
+for full reference see the libperf.7 man page.
+
+Examples
+========
+Examples aim to explain libperf functionality on simple use cases.
+They are based in on a checked out linux kernel git tree:
+
+.. code-block:: bash
+
+  $ cd tools/perf/lib/Documentation/tutorial/
+  $ ls -d  ex-*
+  ex-1-compile  ex-2-evsel-stat  ex-3-evlist-stat
+
+ex-1-compile example
+====================
+This example shows the basic usage of *struct perf_cpu_map*,
+how to create it and display its cpus:
+
+.. code-block:: bash
+
+  $ cd ex-1-compile/
+  $ make
+  gcc -o test test.c -lperf
+  $ ./test
+  0 1 2 3 4 5 6 7
+
+
+The full code listing is here:
+
+.. code-block:: c
+
+   1 #include <perf/cpumap.h>
+   2
+   3 int main(int argc, char **Argv)
+   4 {
+   5         struct perf_cpu_map *cpus;
+   6         int cpu, tmp;
+   7
+   8         cpus = perf_cpu_map__new(NULL);
+   9
+  10         perf_cpu_map__for_each_cpu(cpu, tmp, cpus)
+  11                 fprintf(stdout, "%d ", cpu);
+  12
+  13         fprintf(stdout, "\n");
+  14
+  15         perf_cpu_map__put(cpus);
+  16         return 0;
+  17 }
+
+
+First you need to include the proper header to have *struct perf_cpumap*
+declaration and functions:
+
+.. code-block:: c
+
+   1 #include <perf/cpumap.h>
+
+
+The *struct perf_cpumap* object is created by *perf_cpu_map__new* call.
+The *NULL* argument asks it to populate the object with the current online CPUs list:
+
+.. code-block:: c
+
+   8         cpus = perf_cpu_map__new(NULL);
+
+This is paired with a *perf_cpu_map__put*, that drops its reference at the end, possibly deleting it.
+
+.. code-block:: c
+
+  15         perf_cpu_map__put(cpus);
+
+The iteration through the *struct perf_cpumap* CPUs is done using the *perf_cpu_map__for_each_cpu*
+macro which requires 3 arguments:
+
+- cpu  - the cpu numer
+- tmp  - iteration helper variable
+- cpus - the *struct perf_cpumap* object
+
+.. code-block:: c
+
+  10         perf_cpu_map__for_each_cpu(cpu, tmp, cpus)
+  11                 fprintf(stdout, "%d ", cpu);
+
+ex-2-evsel-stat example
+=======================
+
+TBD
+
+ex-3-evlist-stat example
+========================
+
+TBD
diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
new file mode 100644
index 000000000000..768dd423730b
--- /dev/null
+++ b/tools/lib/perf/Makefile
@@ -0,0 +1,188 @@
+# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+# Most of this file is copied from tools/lib/bpf/Makefile
+
+LIBPERF_VERSION = 0
+LIBPERF_PATCHLEVEL = 0
+LIBPERF_EXTRAVERSION = 1
+
+MAKEFLAGS += --no-print-directory
+
+ifeq ($(srctree),)
+srctree := $(patsubst %/,%,$(dir $(CURDIR)))
+srctree := $(patsubst %/,%,$(dir $(srctree)))
+srctree := $(patsubst %/,%,$(dir $(srctree)))
+#$(info Determined 'srctree' to be $(srctree))
+endif
+
+INSTALL = install
+
+# Use DESTDIR for installing into a different root directory.
+# This is useful for building a package. The program will be
+# installed in this directory as if it was the root directory.
+# Then the build tool can move it later.
+DESTDIR ?=
+DESTDIR_SQ = '$(subst ','\'',$(DESTDIR))'
+
+include $(srctree)/tools/scripts/Makefile.include
+include $(srctree)/tools/scripts/Makefile.arch
+
+ifeq ($(LP64), 1)
+  libdir_relative = lib64
+else
+  libdir_relative = lib
+endif
+
+prefix ?=
+libdir = $(prefix)/$(libdir_relative)
+
+# Shell quotes
+libdir_SQ = $(subst ','\'',$(libdir))
+libdir_relative_SQ = $(subst ','\'',$(libdir_relative))
+
+ifeq ("$(origin V)", "command line")
+  VERBOSE = $(V)
+endif
+ifndef VERBOSE
+  VERBOSE = 0
+endif
+
+ifeq ($(VERBOSE),1)
+  Q =
+else
+  Q = @
+endif
+
+# Set compile option CFLAGS
+ifdef EXTRA_CFLAGS
+  CFLAGS := $(EXTRA_CFLAGS)
+else
+  CFLAGS := -g -Wall
+endif
+
+INCLUDES = \
+-I$(srctree)/tools/lib/perf/include \
+-I$(srctree)/tools/lib/ \
+-I$(srctree)/tools/include \
+-I$(srctree)/tools/arch/$(SRCARCH)/include/ \
+-I$(srctree)/tools/arch/$(SRCARCH)/include/uapi \
+-I$(srctree)/tools/include/uapi
+
+# Append required CFLAGS
+override CFLAGS += $(EXTRA_WARNINGS)
+override CFLAGS += -Werror -Wall
+override CFLAGS += -fPIC
+override CFLAGS += $(INCLUDES)
+override CFLAGS += -fvisibility=hidden
+
+all:
+
+export srctree OUTPUT CC LD CFLAGS V
+export DESTDIR DESTDIR_SQ
+
+include $(srctree)/tools/build/Makefile.include
+
+VERSION_SCRIPT := libperf.map
+
+PATCHLEVEL    = $(LIBPERF_PATCHLEVEL)
+EXTRAVERSION  = $(LIBPERF_EXTRAVERSION)
+VERSION       = $(LIBPERF_VERSION).$(LIBPERF_PATCHLEVEL).$(LIBPERF_EXTRAVERSION)
+
+LIBPERF_SO := $(OUTPUT)libperf.so.$(VERSION)
+LIBPERF_A  := $(OUTPUT)libperf.a
+LIBPERF_IN := $(OUTPUT)libperf-in.o
+LIBPERF_PC := $(OUTPUT)libperf.pc
+
+LIBPERF_ALL := $(LIBPERF_A) $(OUTPUT)libperf.so*
+
+LIB_DIR := $(srctree)/tools/lib/api/
+
+ifneq ($(OUTPUT),)
+ifneq ($(subdir),)
+  API_PATH=$(OUTPUT)/../lib/api/
+else
+  API_PATH=$(OUTPUT)
+endif
+else
+  API_PATH=$(LIB_DIR)
+endif
+
+LIBAPI = $(API_PATH)libapi.a
+export LIBAPI
+
+$(LIBAPI): FORCE
+	$(Q)$(MAKE) -C $(LIB_DIR) O=$(OUTPUT) $(OUTPUT)libapi.a
+
+$(LIBAPI)-clean:
+	$(call QUIET_CLEAN, libapi)
+	$(Q)$(MAKE) -C $(LIB_DIR) O=$(OUTPUT) clean >/dev/null
+
+$(LIBPERF_IN): FORCE
+	$(Q)$(MAKE) $(build)=libperf
+
+$(LIBPERF_A): $(LIBPERF_IN)
+	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(LIBPERF_IN)
+
+$(LIBPERF_SO): $(LIBPERF_IN) $(LIBAPI)
+	$(QUIET_LINK)$(CC) --shared -Wl,-soname,libperf.so \
+                                    -Wl,--version-script=$(VERSION_SCRIPT) $^ -o $@
+	@ln -sf $(@F) $(OUTPUT)libperf.so
+	@ln -sf $(@F) $(OUTPUT)libperf.so.$(LIBPERF_VERSION)
+
+
+libs: $(LIBPERF_A) $(LIBPERF_SO) $(LIBPERF_PC)
+
+all: fixdep
+	$(Q)$(MAKE) libs
+
+clean: $(LIBAPI)-clean
+	$(call QUIET_CLEAN, libperf) $(RM) $(LIBPERF_A) \
+                *.o *~ *.a *.so *.so.$(VERSION) *.so.$(LIBPERF_VERSION) .*.d .*.cmd LIBPERF-CFLAGS $(LIBPERF_PC)
+	$(Q)$(MAKE) -C tests clean
+
+tests: libs
+	$(Q)$(MAKE) -C tests
+	$(Q)$(MAKE) -C tests run
+
+$(LIBPERF_PC):
+	$(QUIET_GEN)sed -e "s|@PREFIX@|$(prefix)|" \
+		-e "s|@LIBDIR@|$(libdir_SQ)|" \
+		-e "s|@VERSION@|$(VERSION)|" \
+		< libperf.pc.template > $@
+
+define do_install_mkdir
+	if [ ! -d '$(DESTDIR_SQ)$1' ]; then             \
+		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$1'; \
+	fi
+endef
+
+define do_install
+	if [ ! -d '$(DESTDIR_SQ)$2' ]; then             \
+		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$2'; \
+	fi;                                             \
+	$(INSTALL) $1 $(if $3,-m $3,) '$(DESTDIR_SQ)$2'
+endef
+
+install_lib: libs
+	$(call QUIET_INSTALL, $(LIBPERF_ALL)) \
+		$(call do_install_mkdir,$(libdir_SQ)); \
+		cp -fpR $(LIBPERF_ALL) $(DESTDIR)$(libdir_SQ)
+
+install_headers:
+	$(call QUIET_INSTALL, headers) \
+		$(call do_install,include/perf/core.h,$(prefix)/include/perf,644); \
+		$(call do_install,include/perf/cpumap.h,$(prefix)/include/perf,644); \
+		$(call do_install,include/perf/threadmap.h,$(prefix)/include/perf,644); \
+		$(call do_install,include/perf/evlist.h,$(prefix)/include/perf,644); \
+		$(call do_install,include/perf/evsel.h,$(prefix)/include/perf,644); \
+		$(call do_install,include/perf/event.h,$(prefix)/include/perf,644); \
+		$(call do_install,include/perf/mmap.h,$(prefix)/include/perf,644);
+
+install_pkgconfig: $(LIBPERF_PC)
+	$(call QUIET_INSTALL, $(LIBPERF_PC)) \
+		$(call do_install,$(LIBPERF_PC),$(libdir_SQ)/pkgconfig,644)
+
+install: install_lib install_headers install_pkgconfig
+
+FORCE:
+
+.PHONY: all install clean tests FORCE
diff --git a/tools/lib/perf/core.c b/tools/lib/perf/core.c
new file mode 100644
index 000000000000..58fc894b76c5
--- /dev/null
+++ b/tools/lib/perf/core.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#define __printf(a, b)  __attribute__((format(printf, a, b)))
+
+#include <stdio.h>
+#include <stdarg.h>
+#include <unistd.h>
+#include <linux/compiler.h>
+#include <perf/core.h>
+#include <internal/lib.h>
+#include "internal.h"
+
+static int __base_pr(enum libperf_print_level level __maybe_unused, const char *format,
+		     va_list args)
+{
+	return vfprintf(stderr, format, args);
+}
+
+static libperf_print_fn_t __libperf_pr = __base_pr;
+
+__printf(2, 3)
+void libperf_print(enum libperf_print_level level, const char *format, ...)
+{
+	va_list args;
+
+	if (!__libperf_pr)
+		return;
+
+	va_start(args, format);
+	__libperf_pr(level, format, args);
+	va_end(args);
+}
+
+void libperf_init(libperf_print_fn_t fn)
+{
+	page_size = sysconf(_SC_PAGE_SIZE);
+	__libperf_pr = fn;
+}
diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
new file mode 100644
index 000000000000..f93f4e703e4c
--- /dev/null
+++ b/tools/lib/perf/cpumap.c
@@ -0,0 +1,345 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <perf/cpumap.h>
+#include <stdlib.h>
+#include <linux/refcount.h>
+#include <internal/cpumap.h>
+#include <asm/bug.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+#include <ctype.h>
+#include <limits.h>
+
+struct perf_cpu_map *perf_cpu_map__dummy_new(void)
+{
+	struct perf_cpu_map *cpus = malloc(sizeof(*cpus) + sizeof(int));
+
+	if (cpus != NULL) {
+		cpus->nr = 1;
+		cpus->map[0] = -1;
+		refcount_set(&cpus->refcnt, 1);
+	}
+
+	return cpus;
+}
+
+static void cpu_map__delete(struct perf_cpu_map *map)
+{
+	if (map) {
+		WARN_ONCE(refcount_read(&map->refcnt) != 0,
+			  "cpu_map refcnt unbalanced\n");
+		free(map);
+	}
+}
+
+struct perf_cpu_map *perf_cpu_map__get(struct perf_cpu_map *map)
+{
+	if (map)
+		refcount_inc(&map->refcnt);
+	return map;
+}
+
+void perf_cpu_map__put(struct perf_cpu_map *map)
+{
+	if (map && refcount_dec_and_test(&map->refcnt))
+		cpu_map__delete(map);
+}
+
+static struct perf_cpu_map *cpu_map__default_new(void)
+{
+	struct perf_cpu_map *cpus;
+	int nr_cpus;
+
+	nr_cpus = sysconf(_SC_NPROCESSORS_ONLN);
+	if (nr_cpus < 0)
+		return NULL;
+
+	cpus = malloc(sizeof(*cpus) + nr_cpus * sizeof(int));
+	if (cpus != NULL) {
+		int i;
+
+		for (i = 0; i < nr_cpus; ++i)
+			cpus->map[i] = i;
+
+		cpus->nr = nr_cpus;
+		refcount_set(&cpus->refcnt, 1);
+	}
+
+	return cpus;
+}
+
+static int cmp_int(const void *a, const void *b)
+{
+	return *(const int *)a - *(const int*)b;
+}
+
+static struct perf_cpu_map *cpu_map__trim_new(int nr_cpus, int *tmp_cpus)
+{
+	size_t payload_size = nr_cpus * sizeof(int);
+	struct perf_cpu_map *cpus = malloc(sizeof(*cpus) + payload_size);
+	int i, j;
+
+	if (cpus != NULL) {
+		memcpy(cpus->map, tmp_cpus, payload_size);
+		qsort(cpus->map, nr_cpus, sizeof(int), cmp_int);
+		/* Remove dups */
+		j = 0;
+		for (i = 0; i < nr_cpus; i++) {
+			if (i == 0 || cpus->map[i] != cpus->map[i - 1])
+				cpus->map[j++] = cpus->map[i];
+		}
+		cpus->nr = j;
+		assert(j <= nr_cpus);
+		refcount_set(&cpus->refcnt, 1);
+	}
+
+	return cpus;
+}
+
+struct perf_cpu_map *perf_cpu_map__read(FILE *file)
+{
+	struct perf_cpu_map *cpus = NULL;
+	int nr_cpus = 0;
+	int *tmp_cpus = NULL, *tmp;
+	int max_entries = 0;
+	int n, cpu, prev;
+	char sep;
+
+	sep = 0;
+	prev = -1;
+	for (;;) {
+		n = fscanf(file, "%u%c", &cpu, &sep);
+		if (n <= 0)
+			break;
+		if (prev >= 0) {
+			int new_max = nr_cpus + cpu - prev - 1;
+
+			WARN_ONCE(new_max >= MAX_NR_CPUS, "Perf can support %d CPUs. "
+							  "Consider raising MAX_NR_CPUS\n", MAX_NR_CPUS);
+
+			if (new_max >= max_entries) {
+				max_entries = new_max + MAX_NR_CPUS / 2;
+				tmp = realloc(tmp_cpus, max_entries * sizeof(int));
+				if (tmp == NULL)
+					goto out_free_tmp;
+				tmp_cpus = tmp;
+			}
+
+			while (++prev < cpu)
+				tmp_cpus[nr_cpus++] = prev;
+		}
+		if (nr_cpus == max_entries) {
+			max_entries += MAX_NR_CPUS;
+			tmp = realloc(tmp_cpus, max_entries * sizeof(int));
+			if (tmp == NULL)
+				goto out_free_tmp;
+			tmp_cpus = tmp;
+		}
+
+		tmp_cpus[nr_cpus++] = cpu;
+		if (n == 2 && sep == '-')
+			prev = cpu;
+		else
+			prev = -1;
+		if (n == 1 || sep == '\n')
+			break;
+	}
+
+	if (nr_cpus > 0)
+		cpus = cpu_map__trim_new(nr_cpus, tmp_cpus);
+	else
+		cpus = cpu_map__default_new();
+out_free_tmp:
+	free(tmp_cpus);
+	return cpus;
+}
+
+static struct perf_cpu_map *cpu_map__read_all_cpu_map(void)
+{
+	struct perf_cpu_map *cpus = NULL;
+	FILE *onlnf;
+
+	onlnf = fopen("/sys/devices/system/cpu/online", "r");
+	if (!onlnf)
+		return cpu_map__default_new();
+
+	cpus = perf_cpu_map__read(onlnf);
+	fclose(onlnf);
+	return cpus;
+}
+
+struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list)
+{
+	struct perf_cpu_map *cpus = NULL;
+	unsigned long start_cpu, end_cpu = 0;
+	char *p = NULL;
+	int i, nr_cpus = 0;
+	int *tmp_cpus = NULL, *tmp;
+	int max_entries = 0;
+
+	if (!cpu_list)
+		return cpu_map__read_all_cpu_map();
+
+	/*
+	 * must handle the case of empty cpumap to cover
+	 * TOPOLOGY header for NUMA nodes with no CPU
+	 * ( e.g., because of CPU hotplug)
+	 */
+	if (!isdigit(*cpu_list) && *cpu_list != '\0')
+		goto out;
+
+	while (isdigit(*cpu_list)) {
+		p = NULL;
+		start_cpu = strtoul(cpu_list, &p, 0);
+		if (start_cpu >= INT_MAX
+		    || (*p != '\0' && *p != ',' && *p != '-'))
+			goto invalid;
+
+		if (*p == '-') {
+			cpu_list = ++p;
+			p = NULL;
+			end_cpu = strtoul(cpu_list, &p, 0);
+
+			if (end_cpu >= INT_MAX || (*p != '\0' && *p != ','))
+				goto invalid;
+
+			if (end_cpu < start_cpu)
+				goto invalid;
+		} else {
+			end_cpu = start_cpu;
+		}
+
+		WARN_ONCE(end_cpu >= MAX_NR_CPUS, "Perf can support %d CPUs. "
+						  "Consider raising MAX_NR_CPUS\n", MAX_NR_CPUS);
+
+		for (; start_cpu <= end_cpu; start_cpu++) {
+			/* check for duplicates */
+			for (i = 0; i < nr_cpus; i++)
+				if (tmp_cpus[i] == (int)start_cpu)
+					goto invalid;
+
+			if (nr_cpus == max_entries) {
+				max_entries += MAX_NR_CPUS;
+				tmp = realloc(tmp_cpus, max_entries * sizeof(int));
+				if (tmp == NULL)
+					goto invalid;
+				tmp_cpus = tmp;
+			}
+			tmp_cpus[nr_cpus++] = (int)start_cpu;
+		}
+		if (*p)
+			++p;
+
+		cpu_list = p;
+	}
+
+	if (nr_cpus > 0)
+		cpus = cpu_map__trim_new(nr_cpus, tmp_cpus);
+	else if (*cpu_list != '\0')
+		cpus = cpu_map__default_new();
+	else
+		cpus = perf_cpu_map__dummy_new();
+invalid:
+	free(tmp_cpus);
+out:
+	return cpus;
+}
+
+int perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int idx)
+{
+	if (idx < cpus->nr)
+		return cpus->map[idx];
+
+	return -1;
+}
+
+int perf_cpu_map__nr(const struct perf_cpu_map *cpus)
+{
+	return cpus ? cpus->nr : 1;
+}
+
+bool perf_cpu_map__empty(const struct perf_cpu_map *map)
+{
+	return map ? map->map[0] == -1 : true;
+}
+
+int perf_cpu_map__idx(struct perf_cpu_map *cpus, int cpu)
+{
+	int i;
+
+	for (i = 0; i < cpus->nr; ++i) {
+		if (cpus->map[i] == cpu)
+			return i;
+	}
+
+	return -1;
+}
+
+int perf_cpu_map__max(struct perf_cpu_map *map)
+{
+	int i, max = -1;
+
+	for (i = 0; i < map->nr; i++) {
+		if (map->map[i] > max)
+			max = map->map[i];
+	}
+
+	return max;
+}
+
+/*
+ * Merge two cpumaps
+ *
+ * orig either gets freed and replaced with a new map, or reused
+ * with no reference count change (similar to "realloc")
+ * other has its reference count increased.
+ */
+
+struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
+					 struct perf_cpu_map *other)
+{
+	int *tmp_cpus;
+	int tmp_len;
+	int i, j, k;
+	struct perf_cpu_map *merged;
+
+	if (!orig && !other)
+		return NULL;
+	if (!orig) {
+		perf_cpu_map__get(other);
+		return other;
+	}
+	if (!other)
+		return orig;
+	if (orig->nr == other->nr &&
+	    !memcmp(orig->map, other->map, orig->nr * sizeof(int)))
+		return orig;
+
+	tmp_len = orig->nr + other->nr;
+	tmp_cpus = malloc(tmp_len * sizeof(int));
+	if (!tmp_cpus)
+		return NULL;
+
+	/* Standard merge algorithm from wikipedia */
+	i = j = k = 0;
+	while (i < orig->nr && j < other->nr) {
+		if (orig->map[i] <= other->map[j]) {
+			if (orig->map[i] == other->map[j])
+				j++;
+			tmp_cpus[k++] = orig->map[i++];
+		} else
+			tmp_cpus[k++] = other->map[j++];
+	}
+
+	while (i < orig->nr)
+		tmp_cpus[k++] = orig->map[i++];
+
+	while (j < other->nr)
+		tmp_cpus[k++] = other->map[j++];
+	assert(k <= tmp_len);
+
+	merged = cpu_map__trim_new(k, tmp_cpus);
+	free(tmp_cpus);
+	perf_cpu_map__put(orig);
+	return merged;
+}
diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
new file mode 100644
index 000000000000..ae9e65aa2491
--- /dev/null
+++ b/tools/lib/perf/evlist.c
@@ -0,0 +1,641 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <perf/evlist.h>
+#include <perf/evsel.h>
+#include <linux/bitops.h>
+#include <linux/list.h>
+#include <linux/hash.h>
+#include <sys/ioctl.h>
+#include <internal/evlist.h>
+#include <internal/evsel.h>
+#include <internal/xyarray.h>
+#include <internal/mmap.h>
+#include <internal/cpumap.h>
+#include <internal/threadmap.h>
+#include <internal/xyarray.h>
+#include <internal/lib.h>
+#include <linux/zalloc.h>
+#include <sys/ioctl.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <signal.h>
+#include <poll.h>
+#include <sys/mman.h>
+#include <perf/cpumap.h>
+#include <perf/threadmap.h>
+#include <api/fd/array.h>
+
+void perf_evlist__init(struct perf_evlist *evlist)
+{
+	int i;
+
+	for (i = 0; i < PERF_EVLIST__HLIST_SIZE; ++i)
+		INIT_HLIST_HEAD(&evlist->heads[i]);
+	INIT_LIST_HEAD(&evlist->entries);
+	evlist->nr_entries = 0;
+	fdarray__init(&evlist->pollfd, 64);
+}
+
+static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
+					  struct perf_evsel *evsel)
+{
+	/*
+	 * We already have cpus for evsel (via PMU sysfs) so
+	 * keep it, if there's no target cpu list defined.
+	 */
+	if (!evsel->own_cpus || evlist->has_user_cpus) {
+		perf_cpu_map__put(evsel->cpus);
+		evsel->cpus = perf_cpu_map__get(evlist->cpus);
+	} else if (evsel->cpus != evsel->own_cpus) {
+		perf_cpu_map__put(evsel->cpus);
+		evsel->cpus = perf_cpu_map__get(evsel->own_cpus);
+	}
+
+	perf_thread_map__put(evsel->threads);
+	evsel->threads = perf_thread_map__get(evlist->threads);
+	evlist->all_cpus = perf_cpu_map__merge(evlist->all_cpus, evsel->cpus);
+}
+
+static void perf_evlist__propagate_maps(struct perf_evlist *evlist)
+{
+	struct perf_evsel *evsel;
+
+	perf_evlist__for_each_evsel(evlist, evsel)
+		__perf_evlist__propagate_maps(evlist, evsel);
+}
+
+void perf_evlist__add(struct perf_evlist *evlist,
+		      struct perf_evsel *evsel)
+{
+	list_add_tail(&evsel->node, &evlist->entries);
+	evlist->nr_entries += 1;
+	__perf_evlist__propagate_maps(evlist, evsel);
+}
+
+void perf_evlist__remove(struct perf_evlist *evlist,
+			 struct perf_evsel *evsel)
+{
+	list_del_init(&evsel->node);
+	evlist->nr_entries -= 1;
+}
+
+struct perf_evlist *perf_evlist__new(void)
+{
+	struct perf_evlist *evlist = zalloc(sizeof(*evlist));
+
+	if (evlist != NULL)
+		perf_evlist__init(evlist);
+
+	return evlist;
+}
+
+struct perf_evsel *
+perf_evlist__next(struct perf_evlist *evlist, struct perf_evsel *prev)
+{
+	struct perf_evsel *next;
+
+	if (!prev) {
+		next = list_first_entry(&evlist->entries,
+					struct perf_evsel,
+					node);
+	} else {
+		next = list_next_entry(prev, node);
+	}
+
+	/* Empty list is noticed here so don't need checking on entry. */
+	if (&next->node == &evlist->entries)
+		return NULL;
+
+	return next;
+}
+
+static void perf_evlist__purge(struct perf_evlist *evlist)
+{
+	struct perf_evsel *pos, *n;
+
+	perf_evlist__for_each_entry_safe(evlist, n, pos) {
+		list_del_init(&pos->node);
+		perf_evsel__delete(pos);
+	}
+
+	evlist->nr_entries = 0;
+}
+
+void perf_evlist__exit(struct perf_evlist *evlist)
+{
+	perf_cpu_map__put(evlist->cpus);
+	perf_thread_map__put(evlist->threads);
+	evlist->cpus = NULL;
+	evlist->threads = NULL;
+	fdarray__exit(&evlist->pollfd);
+}
+
+void perf_evlist__delete(struct perf_evlist *evlist)
+{
+	if (evlist == NULL)
+		return;
+
+	perf_evlist__munmap(evlist);
+	perf_evlist__close(evlist);
+	perf_evlist__purge(evlist);
+	perf_evlist__exit(evlist);
+	free(evlist);
+}
+
+void perf_evlist__set_maps(struct perf_evlist *evlist,
+			   struct perf_cpu_map *cpus,
+			   struct perf_thread_map *threads)
+{
+	/*
+	 * Allow for the possibility that one or another of the maps isn't being
+	 * changed i.e. don't put it.  Note we are assuming the maps that are
+	 * being applied are brand new and evlist is taking ownership of the
+	 * original reference count of 1.  If that is not the case it is up to
+	 * the caller to increase the reference count.
+	 */
+	if (cpus != evlist->cpus) {
+		perf_cpu_map__put(evlist->cpus);
+		evlist->cpus = perf_cpu_map__get(cpus);
+	}
+
+	if (threads != evlist->threads) {
+		perf_thread_map__put(evlist->threads);
+		evlist->threads = perf_thread_map__get(threads);
+	}
+
+	perf_evlist__propagate_maps(evlist);
+}
+
+int perf_evlist__open(struct perf_evlist *evlist)
+{
+	struct perf_evsel *evsel;
+	int err;
+
+	perf_evlist__for_each_entry(evlist, evsel) {
+		err = perf_evsel__open(evsel, evsel->cpus, evsel->threads);
+		if (err < 0)
+			goto out_err;
+	}
+
+	return 0;
+
+out_err:
+	perf_evlist__close(evlist);
+	return err;
+}
+
+void perf_evlist__close(struct perf_evlist *evlist)
+{
+	struct perf_evsel *evsel;
+
+	perf_evlist__for_each_entry_reverse(evlist, evsel)
+		perf_evsel__close(evsel);
+}
+
+void perf_evlist__enable(struct perf_evlist *evlist)
+{
+	struct perf_evsel *evsel;
+
+	perf_evlist__for_each_entry(evlist, evsel)
+		perf_evsel__enable(evsel);
+}
+
+void perf_evlist__disable(struct perf_evlist *evlist)
+{
+	struct perf_evsel *evsel;
+
+	perf_evlist__for_each_entry(evlist, evsel)
+		perf_evsel__disable(evsel);
+}
+
+u64 perf_evlist__read_format(struct perf_evlist *evlist)
+{
+	struct perf_evsel *first = perf_evlist__first(evlist);
+
+	return first->attr.read_format;
+}
+
+#define SID(e, x, y) xyarray__entry(e->sample_id, x, y)
+
+static void perf_evlist__id_hash(struct perf_evlist *evlist,
+				 struct perf_evsel *evsel,
+				 int cpu, int thread, u64 id)
+{
+	int hash;
+	struct perf_sample_id *sid = SID(evsel, cpu, thread);
+
+	sid->id = id;
+	sid->evsel = evsel;
+	hash = hash_64(sid->id, PERF_EVLIST__HLIST_BITS);
+	hlist_add_head(&sid->node, &evlist->heads[hash]);
+}
+
+void perf_evlist__id_add(struct perf_evlist *evlist,
+			 struct perf_evsel *evsel,
+			 int cpu, int thread, u64 id)
+{
+	perf_evlist__id_hash(evlist, evsel, cpu, thread, id);
+	evsel->id[evsel->ids++] = id;
+}
+
+int perf_evlist__id_add_fd(struct perf_evlist *evlist,
+			   struct perf_evsel *evsel,
+			   int cpu, int thread, int fd)
+{
+	u64 read_data[4] = { 0, };
+	int id_idx = 1; /* The first entry is the counter value */
+	u64 id;
+	int ret;
+
+	ret = ioctl(fd, PERF_EVENT_IOC_ID, &id);
+	if (!ret)
+		goto add;
+
+	if (errno != ENOTTY)
+		return -1;
+
+	/* Legacy way to get event id.. All hail to old kernels! */
+
+	/*
+	 * This way does not work with group format read, so bail
+	 * out in that case.
+	 */
+	if (perf_evlist__read_format(evlist) & PERF_FORMAT_GROUP)
+		return -1;
+
+	if (!(evsel->attr.read_format & PERF_FORMAT_ID) ||
+	    read(fd, &read_data, sizeof(read_data)) == -1)
+		return -1;
+
+	if (evsel->attr.read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
+		++id_idx;
+	if (evsel->attr.read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
+		++id_idx;
+
+	id = read_data[id_idx];
+
+add:
+	perf_evlist__id_add(evlist, evsel, cpu, thread, id);
+	return 0;
+}
+
+int perf_evlist__alloc_pollfd(struct perf_evlist *evlist)
+{
+	int nr_cpus = perf_cpu_map__nr(evlist->cpus);
+	int nr_threads = perf_thread_map__nr(evlist->threads);
+	int nfds = 0;
+	struct perf_evsel *evsel;
+
+	perf_evlist__for_each_entry(evlist, evsel) {
+		if (evsel->system_wide)
+			nfds += nr_cpus;
+		else
+			nfds += nr_cpus * nr_threads;
+	}
+
+	if (fdarray__available_entries(&evlist->pollfd) < nfds &&
+	    fdarray__grow(&evlist->pollfd, nfds) < 0)
+		return -ENOMEM;
+
+	return 0;
+}
+
+int perf_evlist__add_pollfd(struct perf_evlist *evlist, int fd,
+			    void *ptr, short revent)
+{
+	int pos = fdarray__add(&evlist->pollfd, fd, revent | POLLERR | POLLHUP);
+
+	if (pos >= 0) {
+		evlist->pollfd.priv[pos].ptr = ptr;
+		fcntl(fd, F_SETFL, O_NONBLOCK);
+	}
+
+	return pos;
+}
+
+static void perf_evlist__munmap_filtered(struct fdarray *fda, int fd,
+					 void *arg __maybe_unused)
+{
+	struct perf_mmap *map = fda->priv[fd].ptr;
+
+	if (map)
+		perf_mmap__put(map);
+}
+
+int perf_evlist__filter_pollfd(struct perf_evlist *evlist, short revents_and_mask)
+{
+	return fdarray__filter(&evlist->pollfd, revents_and_mask,
+			       perf_evlist__munmap_filtered, NULL);
+}
+
+int perf_evlist__poll(struct perf_evlist *evlist, int timeout)
+{
+	return fdarray__poll(&evlist->pollfd, timeout);
+}
+
+static struct perf_mmap* perf_evlist__alloc_mmap(struct perf_evlist *evlist, bool overwrite)
+{
+	int i;
+	struct perf_mmap *map;
+
+	map = zalloc(evlist->nr_mmaps * sizeof(struct perf_mmap));
+	if (!map)
+		return NULL;
+
+	for (i = 0; i < evlist->nr_mmaps; i++) {
+		struct perf_mmap *prev = i ? &map[i - 1] : NULL;
+
+		/*
+		 * When the perf_mmap() call is made we grab one refcount, plus
+		 * one extra to let perf_mmap__consume() get the last
+		 * events after all real references (perf_mmap__get()) are
+		 * dropped.
+		 *
+		 * Each PERF_EVENT_IOC_SET_OUTPUT points to this mmap and
+		 * thus does perf_mmap__get() on it.
+		 */
+		perf_mmap__init(&map[i], prev, overwrite, NULL);
+	}
+
+	return map;
+}
+
+static void perf_evlist__set_sid_idx(struct perf_evlist *evlist,
+				     struct perf_evsel *evsel, int idx, int cpu,
+				     int thread)
+{
+	struct perf_sample_id *sid = SID(evsel, cpu, thread);
+
+	sid->idx = idx;
+	if (evlist->cpus && cpu >= 0)
+		sid->cpu = evlist->cpus->map[cpu];
+	else
+		sid->cpu = -1;
+	if (!evsel->system_wide && evlist->threads && thread >= 0)
+		sid->tid = perf_thread_map__pid(evlist->threads, thread);
+	else
+		sid->tid = -1;
+}
+
+static struct perf_mmap*
+perf_evlist__mmap_cb_get(struct perf_evlist *evlist, bool overwrite, int idx)
+{
+	struct perf_mmap *maps;
+
+	maps = overwrite ? evlist->mmap_ovw : evlist->mmap;
+
+	if (!maps) {
+		maps = perf_evlist__alloc_mmap(evlist, overwrite);
+		if (!maps)
+			return NULL;
+
+		if (overwrite)
+			evlist->mmap_ovw = maps;
+		else
+			evlist->mmap = maps;
+	}
+
+	return &maps[idx];
+}
+
+#define FD(e, x, y) (*(int *) xyarray__entry(e->fd, x, y))
+
+static int
+perf_evlist__mmap_cb_mmap(struct perf_mmap *map, struct perf_mmap_param *mp,
+			  int output, int cpu)
+{
+	return perf_mmap__mmap(map, mp, output, cpu);
+}
+
+static void perf_evlist__set_mmap_first(struct perf_evlist *evlist, struct perf_mmap *map,
+					bool overwrite)
+{
+	if (overwrite)
+		evlist->mmap_ovw_first = map;
+	else
+		evlist->mmap_first = map;
+}
+
+static int
+mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
+	       int idx, struct perf_mmap_param *mp, int cpu_idx,
+	       int thread, int *_output, int *_output_overwrite)
+{
+	int evlist_cpu = perf_cpu_map__cpu(evlist->cpus, cpu_idx);
+	struct perf_evsel *evsel;
+	int revent;
+
+	perf_evlist__for_each_entry(evlist, evsel) {
+		bool overwrite = evsel->attr.write_backward;
+		struct perf_mmap *map;
+		int *output, fd, cpu;
+
+		if (evsel->system_wide && thread)
+			continue;
+
+		cpu = perf_cpu_map__idx(evsel->cpus, evlist_cpu);
+		if (cpu == -1)
+			continue;
+
+		map = ops->get(evlist, overwrite, idx);
+		if (map == NULL)
+			return -ENOMEM;
+
+		if (overwrite) {
+			mp->prot = PROT_READ;
+			output   = _output_overwrite;
+		} else {
+			mp->prot = PROT_READ | PROT_WRITE;
+			output   = _output;
+		}
+
+		fd = FD(evsel, cpu, thread);
+
+		if (*output == -1) {
+			*output = fd;
+
+			/*
+			 * The last one will be done at perf_mmap__consume(), so that we
+			 * make sure we don't prevent tools from consuming every last event in
+			 * the ring buffer.
+			 *
+			 * I.e. we can get the POLLHUP meaning that the fd doesn't exist
+			 * anymore, but the last events for it are still in the ring buffer,
+			 * waiting to be consumed.
+			 *
+			 * Tools can chose to ignore this at their own discretion, but the
+			 * evlist layer can't just drop it when filtering events in
+			 * perf_evlist__filter_pollfd().
+			 */
+			refcount_set(&map->refcnt, 2);
+
+			if (ops->mmap(map, mp, *output, evlist_cpu) < 0)
+				return -1;
+
+			if (!idx)
+				perf_evlist__set_mmap_first(evlist, map, overwrite);
+		} else {
+			if (ioctl(fd, PERF_EVENT_IOC_SET_OUTPUT, *output) != 0)
+				return -1;
+
+			perf_mmap__get(map);
+		}
+
+		revent = !overwrite ? POLLIN : 0;
+
+		if (!evsel->system_wide &&
+		    perf_evlist__add_pollfd(evlist, fd, map, revent) < 0) {
+			perf_mmap__put(map);
+			return -1;
+		}
+
+		if (evsel->attr.read_format & PERF_FORMAT_ID) {
+			if (perf_evlist__id_add_fd(evlist, evsel, cpu, thread,
+						   fd) < 0)
+				return -1;
+			perf_evlist__set_sid_idx(evlist, evsel, idx, cpu,
+						 thread);
+		}
+	}
+
+	return 0;
+}
+
+static int
+mmap_per_thread(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
+		struct perf_mmap_param *mp)
+{
+	int thread;
+	int nr_threads = perf_thread_map__nr(evlist->threads);
+
+	for (thread = 0; thread < nr_threads; thread++) {
+		int output = -1;
+		int output_overwrite = -1;
+
+		if (ops->idx)
+			ops->idx(evlist, mp, thread, false);
+
+		if (mmap_per_evsel(evlist, ops, thread, mp, 0, thread,
+				   &output, &output_overwrite))
+			goto out_unmap;
+	}
+
+	return 0;
+
+out_unmap:
+	perf_evlist__munmap(evlist);
+	return -1;
+}
+
+static int
+mmap_per_cpu(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
+	     struct perf_mmap_param *mp)
+{
+	int nr_threads = perf_thread_map__nr(evlist->threads);
+	int nr_cpus    = perf_cpu_map__nr(evlist->cpus);
+	int cpu, thread;
+
+	for (cpu = 0; cpu < nr_cpus; cpu++) {
+		int output = -1;
+		int output_overwrite = -1;
+
+		if (ops->idx)
+			ops->idx(evlist, mp, cpu, true);
+
+		for (thread = 0; thread < nr_threads; thread++) {
+			if (mmap_per_evsel(evlist, ops, cpu, mp, cpu,
+					   thread, &output, &output_overwrite))
+				goto out_unmap;
+		}
+	}
+
+	return 0;
+
+out_unmap:
+	perf_evlist__munmap(evlist);
+	return -1;
+}
+
+static int perf_evlist__nr_mmaps(struct perf_evlist *evlist)
+{
+	int nr_mmaps;
+
+	nr_mmaps = perf_cpu_map__nr(evlist->cpus);
+	if (perf_cpu_map__empty(evlist->cpus))
+		nr_mmaps = perf_thread_map__nr(evlist->threads);
+
+	return nr_mmaps;
+}
+
+int perf_evlist__mmap_ops(struct perf_evlist *evlist,
+			  struct perf_evlist_mmap_ops *ops,
+			  struct perf_mmap_param *mp)
+{
+	struct perf_evsel *evsel;
+	const struct perf_cpu_map *cpus = evlist->cpus;
+	const struct perf_thread_map *threads = evlist->threads;
+
+	if (!ops || !ops->get || !ops->mmap)
+		return -EINVAL;
+
+	mp->mask = evlist->mmap_len - page_size - 1;
+
+	evlist->nr_mmaps = perf_evlist__nr_mmaps(evlist);
+
+	perf_evlist__for_each_entry(evlist, evsel) {
+		if ((evsel->attr.read_format & PERF_FORMAT_ID) &&
+		    evsel->sample_id == NULL &&
+		    perf_evsel__alloc_id(evsel, perf_cpu_map__nr(cpus), threads->nr) < 0)
+			return -ENOMEM;
+	}
+
+	if (evlist->pollfd.entries == NULL && perf_evlist__alloc_pollfd(evlist) < 0)
+		return -ENOMEM;
+
+	if (perf_cpu_map__empty(cpus))
+		return mmap_per_thread(evlist, ops, mp);
+
+	return mmap_per_cpu(evlist, ops, mp);
+}
+
+int perf_evlist__mmap(struct perf_evlist *evlist, int pages)
+{
+	struct perf_mmap_param mp;
+	struct perf_evlist_mmap_ops ops = {
+		.get  = perf_evlist__mmap_cb_get,
+		.mmap = perf_evlist__mmap_cb_mmap,
+	};
+
+	evlist->mmap_len = (pages + 1) * page_size;
+
+	return perf_evlist__mmap_ops(evlist, &ops, &mp);
+}
+
+void perf_evlist__munmap(struct perf_evlist *evlist)
+{
+	int i;
+
+	if (evlist->mmap) {
+		for (i = 0; i < evlist->nr_mmaps; i++)
+			perf_mmap__munmap(&evlist->mmap[i]);
+	}
+
+	if (evlist->mmap_ovw) {
+		for (i = 0; i < evlist->nr_mmaps; i++)
+			perf_mmap__munmap(&evlist->mmap_ovw[i]);
+	}
+
+	zfree(&evlist->mmap);
+	zfree(&evlist->mmap_ovw);
+}
+
+struct perf_mmap*
+perf_evlist__next_mmap(struct perf_evlist *evlist, struct perf_mmap *map,
+		       bool overwrite)
+{
+	if (map)
+		return map->next;
+
+	return overwrite ? evlist->mmap_ovw_first : evlist->mmap_first;
+}
diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
new file mode 100644
index 000000000000..4dc06289f4c7
--- /dev/null
+++ b/tools/lib/perf/evsel.c
@@ -0,0 +1,301 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <errno.h>
+#include <unistd.h>
+#include <sys/syscall.h>
+#include <perf/evsel.h>
+#include <perf/cpumap.h>
+#include <perf/threadmap.h>
+#include <linux/list.h>
+#include <internal/evsel.h>
+#include <linux/zalloc.h>
+#include <stdlib.h>
+#include <internal/xyarray.h>
+#include <internal/cpumap.h>
+#include <internal/threadmap.h>
+#include <internal/lib.h>
+#include <linux/string.h>
+#include <sys/ioctl.h>
+
+void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr)
+{
+	INIT_LIST_HEAD(&evsel->node);
+	evsel->attr = *attr;
+}
+
+struct perf_evsel *perf_evsel__new(struct perf_event_attr *attr)
+{
+	struct perf_evsel *evsel = zalloc(sizeof(*evsel));
+
+	if (evsel != NULL)
+		perf_evsel__init(evsel, attr);
+
+	return evsel;
+}
+
+void perf_evsel__delete(struct perf_evsel *evsel)
+{
+	free(evsel);
+}
+
+#define FD(e, x, y) (*(int *) xyarray__entry(e->fd, x, y))
+
+int perf_evsel__alloc_fd(struct perf_evsel *evsel, int ncpus, int nthreads)
+{
+	evsel->fd = xyarray__new(ncpus, nthreads, sizeof(int));
+
+	if (evsel->fd) {
+		int cpu, thread;
+		for (cpu = 0; cpu < ncpus; cpu++) {
+			for (thread = 0; thread < nthreads; thread++) {
+				FD(evsel, cpu, thread) = -1;
+			}
+		}
+	}
+
+	return evsel->fd != NULL ? 0 : -ENOMEM;
+}
+
+static int
+sys_perf_event_open(struct perf_event_attr *attr,
+		    pid_t pid, int cpu, int group_fd,
+		    unsigned long flags)
+{
+	return syscall(__NR_perf_event_open, attr, pid, cpu, group_fd, flags);
+}
+
+int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
+		     struct perf_thread_map *threads)
+{
+	int cpu, thread, err = 0;
+
+	if (cpus == NULL) {
+		static struct perf_cpu_map *empty_cpu_map;
+
+		if (empty_cpu_map == NULL) {
+			empty_cpu_map = perf_cpu_map__dummy_new();
+			if (empty_cpu_map == NULL)
+				return -ENOMEM;
+		}
+
+		cpus = empty_cpu_map;
+	}
+
+	if (threads == NULL) {
+		static struct perf_thread_map *empty_thread_map;
+
+		if (empty_thread_map == NULL) {
+			empty_thread_map = perf_thread_map__new_dummy();
+			if (empty_thread_map == NULL)
+				return -ENOMEM;
+		}
+
+		threads = empty_thread_map;
+	}
+
+	if (evsel->fd == NULL &&
+	    perf_evsel__alloc_fd(evsel, cpus->nr, threads->nr) < 0)
+		return -ENOMEM;
+
+	for (cpu = 0; cpu < cpus->nr; cpu++) {
+		for (thread = 0; thread < threads->nr; thread++) {
+			int fd;
+
+			fd = sys_perf_event_open(&evsel->attr,
+						 threads->map[thread].pid,
+						 cpus->map[cpu], -1, 0);
+
+			if (fd < 0)
+				return -errno;
+
+			FD(evsel, cpu, thread) = fd;
+		}
+	}
+
+	return err;
+}
+
+static void perf_evsel__close_fd_cpu(struct perf_evsel *evsel, int cpu)
+{
+	int thread;
+
+	for (thread = 0; thread < xyarray__max_y(evsel->fd); ++thread) {
+		if (FD(evsel, cpu, thread) >= 0)
+			close(FD(evsel, cpu, thread));
+		FD(evsel, cpu, thread) = -1;
+	}
+}
+
+void perf_evsel__close_fd(struct perf_evsel *evsel)
+{
+	int cpu;
+
+	for (cpu = 0; cpu < xyarray__max_x(evsel->fd); cpu++)
+		perf_evsel__close_fd_cpu(evsel, cpu);
+}
+
+void perf_evsel__free_fd(struct perf_evsel *evsel)
+{
+	xyarray__delete(evsel->fd);
+	evsel->fd = NULL;
+}
+
+void perf_evsel__close(struct perf_evsel *evsel)
+{
+	if (evsel->fd == NULL)
+		return;
+
+	perf_evsel__close_fd(evsel);
+	perf_evsel__free_fd(evsel);
+}
+
+void perf_evsel__close_cpu(struct perf_evsel *evsel, int cpu)
+{
+	if (evsel->fd == NULL)
+		return;
+
+	perf_evsel__close_fd_cpu(evsel, cpu);
+}
+
+int perf_evsel__read_size(struct perf_evsel *evsel)
+{
+	u64 read_format = evsel->attr.read_format;
+	int entry = sizeof(u64); /* value */
+	int size = 0;
+	int nr = 1;
+
+	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
+		size += sizeof(u64);
+
+	if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
+		size += sizeof(u64);
+
+	if (read_format & PERF_FORMAT_ID)
+		entry += sizeof(u64);
+
+	if (read_format & PERF_FORMAT_GROUP) {
+		nr = evsel->nr_members;
+		size += sizeof(u64);
+	}
+
+	size += entry * nr;
+	return size;
+}
+
+int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
+		     struct perf_counts_values *count)
+{
+	size_t size = perf_evsel__read_size(evsel);
+
+	memset(count, 0, sizeof(*count));
+
+	if (FD(evsel, cpu, thread) < 0)
+		return -EINVAL;
+
+	if (readn(FD(evsel, cpu, thread), count->values, size) <= 0)
+		return -errno;
+
+	return 0;
+}
+
+static int perf_evsel__run_ioctl(struct perf_evsel *evsel,
+				 int ioc,  void *arg,
+				 int cpu)
+{
+	int thread;
+
+	for (thread = 0; thread < xyarray__max_y(evsel->fd); thread++) {
+		int fd = FD(evsel, cpu, thread),
+		    err = ioctl(fd, ioc, arg);
+
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu)
+{
+	return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, NULL, cpu);
+}
+
+int perf_evsel__enable(struct perf_evsel *evsel)
+{
+	int i;
+	int err = 0;
+
+	for (i = 0; i < xyarray__max_x(evsel->fd) && !err; i++)
+		err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, NULL, i);
+	return err;
+}
+
+int perf_evsel__disable_cpu(struct perf_evsel *evsel, int cpu)
+{
+	return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_DISABLE, NULL, cpu);
+}
+
+int perf_evsel__disable(struct perf_evsel *evsel)
+{
+	int i;
+	int err = 0;
+
+	for (i = 0; i < xyarray__max_x(evsel->fd) && !err; i++)
+		err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_DISABLE, NULL, i);
+	return err;
+}
+
+int perf_evsel__apply_filter(struct perf_evsel *evsel, const char *filter)
+{
+	int err = 0, i;
+
+	for (i = 0; i < evsel->cpus->nr && !err; i++)
+		err = perf_evsel__run_ioctl(evsel,
+				     PERF_EVENT_IOC_SET_FILTER,
+				     (void *)filter, i);
+	return err;
+}
+
+struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel)
+{
+	return evsel->cpus;
+}
+
+struct perf_thread_map *perf_evsel__threads(struct perf_evsel *evsel)
+{
+	return evsel->threads;
+}
+
+struct perf_event_attr *perf_evsel__attr(struct perf_evsel *evsel)
+{
+	return &evsel->attr;
+}
+
+int perf_evsel__alloc_id(struct perf_evsel *evsel, int ncpus, int nthreads)
+{
+	if (ncpus == 0 || nthreads == 0)
+		return 0;
+
+	if (evsel->system_wide)
+		nthreads = 1;
+
+	evsel->sample_id = xyarray__new(ncpus, nthreads, sizeof(struct perf_sample_id));
+	if (evsel->sample_id == NULL)
+		return -ENOMEM;
+
+	evsel->id = zalloc(ncpus * nthreads * sizeof(u64));
+	if (evsel->id == NULL) {
+		xyarray__delete(evsel->sample_id);
+		evsel->sample_id = NULL;
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+void perf_evsel__free_id(struct perf_evsel *evsel)
+{
+	xyarray__delete(evsel->sample_id);
+	evsel->sample_id = NULL;
+	zfree(&evsel->id);
+	evsel->ids = 0;
+}
diff --git a/tools/lib/perf/include/internal/cpumap.h b/tools/lib/perf/include/internal/cpumap.h
new file mode 100644
index 000000000000..840d4032587b
--- /dev/null
+++ b/tools/lib/perf/include/internal/cpumap.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LIBPERF_INTERNAL_CPUMAP_H
+#define __LIBPERF_INTERNAL_CPUMAP_H
+
+#include <linux/refcount.h>
+
+struct perf_cpu_map {
+	refcount_t	refcnt;
+	int		nr;
+	int		map[];
+};
+
+#ifndef MAX_NR_CPUS
+#define MAX_NR_CPUS	2048
+#endif
+
+int perf_cpu_map__idx(struct perf_cpu_map *cpus, int cpu);
+
+#endif /* __LIBPERF_INTERNAL_CPUMAP_H */
diff --git a/tools/lib/perf/include/internal/evlist.h b/tools/lib/perf/include/internal/evlist.h
new file mode 100644
index 000000000000..74dc8c3f0b66
--- /dev/null
+++ b/tools/lib/perf/include/internal/evlist.h
@@ -0,0 +1,127 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LIBPERF_INTERNAL_EVLIST_H
+#define __LIBPERF_INTERNAL_EVLIST_H
+
+#include <linux/list.h>
+#include <api/fd/array.h>
+#include <internal/evsel.h>
+
+#define PERF_EVLIST__HLIST_BITS 8
+#define PERF_EVLIST__HLIST_SIZE (1 << PERF_EVLIST__HLIST_BITS)
+
+struct perf_cpu_map;
+struct perf_thread_map;
+struct perf_mmap_param;
+
+struct perf_evlist {
+	struct list_head	 entries;
+	int			 nr_entries;
+	bool			 has_user_cpus;
+	struct perf_cpu_map	*cpus;
+	struct perf_cpu_map	*all_cpus;
+	struct perf_thread_map	*threads;
+	int			 nr_mmaps;
+	size_t			 mmap_len;
+	struct fdarray		 pollfd;
+	struct hlist_head	 heads[PERF_EVLIST__HLIST_SIZE];
+	struct perf_mmap	*mmap;
+	struct perf_mmap	*mmap_ovw;
+	struct perf_mmap	*mmap_first;
+	struct perf_mmap	*mmap_ovw_first;
+};
+
+typedef void
+(*perf_evlist_mmap__cb_idx_t)(struct perf_evlist*, struct perf_mmap_param*, int, bool);
+typedef struct perf_mmap*
+(*perf_evlist_mmap__cb_get_t)(struct perf_evlist*, bool, int);
+typedef int
+(*perf_evlist_mmap__cb_mmap_t)(struct perf_mmap*, struct perf_mmap_param*, int, int);
+
+struct perf_evlist_mmap_ops {
+	perf_evlist_mmap__cb_idx_t	idx;
+	perf_evlist_mmap__cb_get_t	get;
+	perf_evlist_mmap__cb_mmap_t	mmap;
+};
+
+int perf_evlist__alloc_pollfd(struct perf_evlist *evlist);
+int perf_evlist__add_pollfd(struct perf_evlist *evlist, int fd,
+			    void *ptr, short revent);
+
+int perf_evlist__mmap_ops(struct perf_evlist *evlist,
+			  struct perf_evlist_mmap_ops *ops,
+			  struct perf_mmap_param *mp);
+
+void perf_evlist__init(struct perf_evlist *evlist);
+void perf_evlist__exit(struct perf_evlist *evlist);
+
+/**
+ * __perf_evlist__for_each_entry - iterate thru all the evsels
+ * @list: list_head instance to iterate
+ * @evsel: struct perf_evsel iterator
+ */
+#define __perf_evlist__for_each_entry(list, evsel) \
+	list_for_each_entry(evsel, list, node)
+
+/**
+ * evlist__for_each_entry - iterate thru all the evsels
+ * @evlist: perf_evlist instance to iterate
+ * @evsel: struct perf_evsel iterator
+ */
+#define perf_evlist__for_each_entry(evlist, evsel) \
+	__perf_evlist__for_each_entry(&(evlist)->entries, evsel)
+
+/**
+ * __perf_evlist__for_each_entry_reverse - iterate thru all the evsels in reverse order
+ * @list: list_head instance to iterate
+ * @evsel: struct evsel iterator
+ */
+#define __perf_evlist__for_each_entry_reverse(list, evsel) \
+	list_for_each_entry_reverse(evsel, list, node)
+
+/**
+ * perf_evlist__for_each_entry_reverse - iterate thru all the evsels in reverse order
+ * @evlist: evlist instance to iterate
+ * @evsel: struct evsel iterator
+ */
+#define perf_evlist__for_each_entry_reverse(evlist, evsel) \
+	__perf_evlist__for_each_entry_reverse(&(evlist)->entries, evsel)
+
+/**
+ * __perf_evlist__for_each_entry_safe - safely iterate thru all the evsels
+ * @list: list_head instance to iterate
+ * @tmp: struct evsel temp iterator
+ * @evsel: struct evsel iterator
+ */
+#define __perf_evlist__for_each_entry_safe(list, tmp, evsel) \
+	list_for_each_entry_safe(evsel, tmp, list, node)
+
+/**
+ * perf_evlist__for_each_entry_safe - safely iterate thru all the evsels
+ * @evlist: evlist instance to iterate
+ * @evsel: struct evsel iterator
+ * @tmp: struct evsel temp iterator
+ */
+#define perf_evlist__for_each_entry_safe(evlist, tmp, evsel) \
+	__perf_evlist__for_each_entry_safe(&(evlist)->entries, tmp, evsel)
+
+static inline struct perf_evsel *perf_evlist__first(struct perf_evlist *evlist)
+{
+	return list_entry(evlist->entries.next, struct perf_evsel, node);
+}
+
+static inline struct perf_evsel *perf_evlist__last(struct perf_evlist *evlist)
+{
+	return list_entry(evlist->entries.prev, struct perf_evsel, node);
+}
+
+u64 perf_evlist__read_format(struct perf_evlist *evlist);
+
+void perf_evlist__id_add(struct perf_evlist *evlist,
+			 struct perf_evsel *evsel,
+			 int cpu, int thread, u64 id);
+
+int perf_evlist__id_add_fd(struct perf_evlist *evlist,
+			   struct perf_evsel *evsel,
+			   int cpu, int thread, int fd);
+
+#endif /* __LIBPERF_INTERNAL_EVLIST_H */
diff --git a/tools/lib/perf/include/internal/evsel.h b/tools/lib/perf/include/internal/evsel.h
new file mode 100644
index 000000000000..1ffd083b235e
--- /dev/null
+++ b/tools/lib/perf/include/internal/evsel.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LIBPERF_INTERNAL_EVSEL_H
+#define __LIBPERF_INTERNAL_EVSEL_H
+
+#include <linux/types.h>
+#include <linux/perf_event.h>
+#include <stdbool.h>
+#include <sys/types.h>
+
+struct perf_cpu_map;
+struct perf_thread_map;
+struct xyarray;
+
+/*
+ * Per fd, to map back from PERF_SAMPLE_ID to evsel, only used when there are
+ * more than one entry in the evlist.
+ */
+struct perf_sample_id {
+	struct hlist_node	 node;
+	u64			 id;
+	struct perf_evsel	*evsel;
+       /*
+	* 'idx' will be used for AUX area sampling. A sample will have AUX area
+	* data that will be queued for decoding, where there are separate
+	* queues for each CPU (per-cpu tracing) or task (per-thread tracing).
+	* The sample ID can be used to lookup 'idx' which is effectively the
+	* queue number.
+	*/
+	int			 idx;
+	int			 cpu;
+	pid_t			 tid;
+
+	/* Holds total ID period value for PERF_SAMPLE_READ processing. */
+	u64			 period;
+};
+
+struct perf_evsel {
+	struct list_head	 node;
+	struct perf_event_attr	 attr;
+	struct perf_cpu_map	*cpus;
+	struct perf_cpu_map	*own_cpus;
+	struct perf_thread_map	*threads;
+	struct xyarray		*fd;
+	struct xyarray		*sample_id;
+	u64			*id;
+	u32			 ids;
+
+	/* parse modifier helper */
+	int			 nr_members;
+	bool			 system_wide;
+};
+
+void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr);
+int perf_evsel__alloc_fd(struct perf_evsel *evsel, int ncpus, int nthreads);
+void perf_evsel__close_fd(struct perf_evsel *evsel);
+void perf_evsel__free_fd(struct perf_evsel *evsel);
+int perf_evsel__read_size(struct perf_evsel *evsel);
+int perf_evsel__apply_filter(struct perf_evsel *evsel, const char *filter);
+
+int perf_evsel__alloc_id(struct perf_evsel *evsel, int ncpus, int nthreads);
+void perf_evsel__free_id(struct perf_evsel *evsel);
+
+#endif /* __LIBPERF_INTERNAL_EVSEL_H */
diff --git a/tools/lib/perf/include/internal/lib.h b/tools/lib/perf/include/internal/lib.h
new file mode 100644
index 000000000000..5175d491b2d4
--- /dev/null
+++ b/tools/lib/perf/include/internal/lib.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LIBPERF_INTERNAL_LIB_H
+#define __LIBPERF_INTERNAL_LIB_H
+
+#include <sys/types.h>
+
+extern unsigned int page_size;
+
+ssize_t readn(int fd, void *buf, size_t n);
+ssize_t writen(int fd, const void *buf, size_t n);
+
+#endif /* __LIBPERF_INTERNAL_CPUMAP_H */
diff --git a/tools/lib/perf/include/internal/mmap.h b/tools/lib/perf/include/internal/mmap.h
new file mode 100644
index 000000000000..be7556e0a2b2
--- /dev/null
+++ b/tools/lib/perf/include/internal/mmap.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LIBPERF_INTERNAL_MMAP_H
+#define __LIBPERF_INTERNAL_MMAP_H
+
+#include <linux/compiler.h>
+#include <linux/refcount.h>
+#include <linux/types.h>
+#include <stdbool.h>
+
+/* perf sample has 16 bits size limit */
+#define PERF_SAMPLE_MAX_SIZE (1 << 16)
+
+struct perf_mmap;
+
+typedef void (*libperf_unmap_cb_t)(struct perf_mmap *map);
+
+/**
+ * struct perf_mmap - perf's ring buffer mmap details
+ *
+ * @refcnt - e.g. code using PERF_EVENT_IOC_SET_OUTPUT to share this
+ */
+struct perf_mmap {
+	void			*base;
+	int			 mask;
+	int			 fd;
+	int			 cpu;
+	refcount_t		 refcnt;
+	u64			 prev;
+	u64			 start;
+	u64			 end;
+	bool			 overwrite;
+	u64			 flush;
+	libperf_unmap_cb_t	 unmap_cb;
+	char			 event_copy[PERF_SAMPLE_MAX_SIZE] __aligned(8);
+	struct perf_mmap	*next;
+};
+
+struct perf_mmap_param {
+	int	prot;
+	int	mask;
+};
+
+size_t perf_mmap__mmap_len(struct perf_mmap *map);
+
+void perf_mmap__init(struct perf_mmap *map, struct perf_mmap *prev,
+		     bool overwrite, libperf_unmap_cb_t unmap_cb);
+int perf_mmap__mmap(struct perf_mmap *map, struct perf_mmap_param *mp,
+		    int fd, int cpu);
+void perf_mmap__munmap(struct perf_mmap *map);
+void perf_mmap__get(struct perf_mmap *map);
+void perf_mmap__put(struct perf_mmap *map);
+
+u64 perf_mmap__read_head(struct perf_mmap *map);
+
+#endif /* __LIBPERF_INTERNAL_MMAP_H */
diff --git a/tools/lib/perf/include/internal/tests.h b/tools/lib/perf/include/internal/tests.h
new file mode 100644
index 000000000000..2093e8868a67
--- /dev/null
+++ b/tools/lib/perf/include/internal/tests.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LIBPERF_INTERNAL_TESTS_H
+#define __LIBPERF_INTERNAL_TESTS_H
+
+#include <stdio.h>
+
+int tests_failed;
+
+#define __T_START					\
+do {							\
+	fprintf(stdout, "- running %s...", __FILE__);	\
+	fflush(NULL);					\
+	tests_failed = 0;				\
+} while (0)
+
+#define __T_END								\
+do {									\
+	if (tests_failed)						\
+		fprintf(stdout, "  FAILED (%d)\n", tests_failed);	\
+	else								\
+		fprintf(stdout, "OK\n");				\
+} while (0)
+
+#define __T(text, cond)                                                          \
+do {                                                                             \
+	if (!(cond)) {                                                           \
+		fprintf(stderr, "FAILED %s:%d %s\n", __FILE__, __LINE__, text);  \
+		tests_failed++;                                                  \
+		return -1;                                                       \
+	}                                                                        \
+} while (0)
+
+#endif /* __LIBPERF_INTERNAL_TESTS_H */
diff --git a/tools/lib/perf/include/internal/threadmap.h b/tools/lib/perf/include/internal/threadmap.h
new file mode 100644
index 000000000000..df748baf9eda
--- /dev/null
+++ b/tools/lib/perf/include/internal/threadmap.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LIBPERF_INTERNAL_THREADMAP_H
+#define __LIBPERF_INTERNAL_THREADMAP_H
+
+#include <linux/refcount.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+struct thread_map_data {
+	pid_t	 pid;
+	char	*comm;
+};
+
+struct perf_thread_map {
+	refcount_t	refcnt;
+	int		nr;
+	int		err_thread;
+	struct thread_map_data map[];
+};
+
+struct perf_thread_map *perf_thread_map__realloc(struct perf_thread_map *map, int nr);
+
+#endif /* __LIBPERF_INTERNAL_THREADMAP_H */
diff --git a/tools/lib/perf/include/internal/xyarray.h b/tools/lib/perf/include/internal/xyarray.h
new file mode 100644
index 000000000000..51e35d6c8ec4
--- /dev/null
+++ b/tools/lib/perf/include/internal/xyarray.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LIBPERF_INTERNAL_XYARRAY_H
+#define __LIBPERF_INTERNAL_XYARRAY_H
+
+#include <linux/compiler.h>
+#include <sys/types.h>
+
+struct xyarray {
+	size_t row_size;
+	size_t entry_size;
+	size_t entries;
+	size_t max_x;
+	size_t max_y;
+	char contents[] __aligned(8);
+};
+
+struct xyarray *xyarray__new(int xlen, int ylen, size_t entry_size);
+void xyarray__delete(struct xyarray *xy);
+void xyarray__reset(struct xyarray *xy);
+
+static inline void *xyarray__entry(struct xyarray *xy, int x, int y)
+{
+	return &xy->contents[x * xy->row_size + y * xy->entry_size];
+}
+
+static inline int xyarray__max_y(struct xyarray *xy)
+{
+	return xy->max_y;
+}
+
+static inline int xyarray__max_x(struct xyarray *xy)
+{
+	return xy->max_x;
+}
+
+#endif /* __LIBPERF_INTERNAL_XYARRAY_H */
diff --git a/tools/lib/perf/include/perf/core.h b/tools/lib/perf/include/perf/core.h
new file mode 100644
index 000000000000..a3f6d68edad7
--- /dev/null
+++ b/tools/lib/perf/include/perf/core.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LIBPERF_CORE_H
+#define __LIBPERF_CORE_H
+
+#include <stdarg.h>
+
+#ifndef LIBPERF_API
+#define LIBPERF_API __attribute__((visibility("default")))
+#endif
+
+enum libperf_print_level {
+	LIBPERF_ERR,
+	LIBPERF_WARN,
+	LIBPERF_INFO,
+	LIBPERF_DEBUG,
+	LIBPERF_DEBUG2,
+	LIBPERF_DEBUG3,
+};
+
+typedef int (*libperf_print_fn_t)(enum libperf_print_level level,
+				  const char *, va_list ap);
+
+LIBPERF_API void libperf_init(libperf_print_fn_t fn);
+
+#endif /* __LIBPERF_CORE_H */
diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/include/perf/cpumap.h
new file mode 100644
index 000000000000..6a17ad730cbc
--- /dev/null
+++ b/tools/lib/perf/include/perf/cpumap.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LIBPERF_CPUMAP_H
+#define __LIBPERF_CPUMAP_H
+
+#include <perf/core.h>
+#include <stdio.h>
+#include <stdbool.h>
+
+struct perf_cpu_map;
+
+LIBPERF_API struct perf_cpu_map *perf_cpu_map__dummy_new(void);
+LIBPERF_API struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list);
+LIBPERF_API struct perf_cpu_map *perf_cpu_map__read(FILE *file);
+LIBPERF_API struct perf_cpu_map *perf_cpu_map__get(struct perf_cpu_map *map);
+LIBPERF_API struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
+						     struct perf_cpu_map *other);
+LIBPERF_API void perf_cpu_map__put(struct perf_cpu_map *map);
+LIBPERF_API int perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int idx);
+LIBPERF_API int perf_cpu_map__nr(const struct perf_cpu_map *cpus);
+LIBPERF_API bool perf_cpu_map__empty(const struct perf_cpu_map *map);
+LIBPERF_API int perf_cpu_map__max(struct perf_cpu_map *map);
+
+#define perf_cpu_map__for_each_cpu(cpu, idx, cpus)		\
+	for ((idx) = 0, (cpu) = perf_cpu_map__cpu(cpus, idx);	\
+	     (idx) < perf_cpu_map__nr(cpus);			\
+	     (idx)++, (cpu) = perf_cpu_map__cpu(cpus, idx))
+
+#endif /* __LIBPERF_CPUMAP_H */
diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
new file mode 100644
index 000000000000..18106899cb4e
--- /dev/null
+++ b/tools/lib/perf/include/perf/event.h
@@ -0,0 +1,385 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LIBPERF_EVENT_H
+#define __LIBPERF_EVENT_H
+
+#include <linux/perf_event.h>
+#include <linux/types.h>
+#include <linux/limits.h>
+#include <linux/bpf.h>
+#include <sys/types.h> /* pid_t */
+
+struct perf_record_mmap {
+	struct perf_event_header header;
+	__u32			 pid, tid;
+	__u64			 start;
+	__u64			 len;
+	__u64			 pgoff;
+	char			 filename[PATH_MAX];
+};
+
+struct perf_record_mmap2 {
+	struct perf_event_header header;
+	__u32			 pid, tid;
+	__u64			 start;
+	__u64			 len;
+	__u64			 pgoff;
+	__u32			 maj;
+	__u32			 min;
+	__u64			 ino;
+	__u64			 ino_generation;
+	__u32			 prot;
+	__u32			 flags;
+	char			 filename[PATH_MAX];
+};
+
+struct perf_record_comm {
+	struct perf_event_header header;
+	__u32			 pid, tid;
+	char			 comm[16];
+};
+
+struct perf_record_namespaces {
+	struct perf_event_header header;
+	__u32			 pid, tid;
+	__u64			 nr_namespaces;
+	struct perf_ns_link_info link_info[];
+};
+
+struct perf_record_fork {
+	struct perf_event_header header;
+	__u32			 pid, ppid;
+	__u32			 tid, ptid;
+	__u64			 time;
+};
+
+struct perf_record_lost {
+	struct perf_event_header header;
+	__u64			 id;
+	__u64			 lost;
+};
+
+struct perf_record_lost_samples {
+	struct perf_event_header header;
+	__u64			 lost;
+};
+
+/*
+ * PERF_FORMAT_ENABLED | PERF_FORMAT_RUNNING | PERF_FORMAT_ID
+ */
+struct perf_record_read {
+	struct perf_event_header header;
+	__u32			 pid, tid;
+	__u64			 value;
+	__u64			 time_enabled;
+	__u64			 time_running;
+	__u64			 id;
+};
+
+struct perf_record_throttle {
+	struct perf_event_header header;
+	__u64			 time;
+	__u64			 id;
+	__u64			 stream_id;
+};
+
+#ifndef KSYM_NAME_LEN
+#define KSYM_NAME_LEN 256
+#endif
+
+struct perf_record_ksymbol {
+	struct perf_event_header header;
+	__u64			 addr;
+	__u32			 len;
+	__u16			 ksym_type;
+	__u16			 flags;
+	char			 name[KSYM_NAME_LEN];
+};
+
+struct perf_record_bpf_event {
+	struct perf_event_header header;
+	__u16			 type;
+	__u16			 flags;
+	__u32			 id;
+
+	/* for bpf_prog types */
+	__u8			 tag[BPF_TAG_SIZE];  // prog tag
+};
+
+struct perf_record_sample {
+	struct perf_event_header header;
+	__u64			 array[];
+};
+
+struct perf_record_switch {
+	struct perf_event_header header;
+	__u32			 next_prev_pid;
+	__u32			 next_prev_tid;
+};
+
+struct perf_record_header_attr {
+	struct perf_event_header header;
+	struct perf_event_attr	 attr;
+	__u64			 id[];
+};
+
+enum {
+	PERF_CPU_MAP__CPUS = 0,
+	PERF_CPU_MAP__MASK = 1,
+};
+
+struct cpu_map_entries {
+	__u16			 nr;
+	__u16			 cpu[];
+};
+
+struct perf_record_record_cpu_map {
+	__u16			 nr;
+	__u16			 long_size;
+	unsigned long		 mask[];
+};
+
+struct perf_record_cpu_map_data {
+	__u16			 type;
+	char			 data[];
+};
+
+struct perf_record_cpu_map {
+	struct perf_event_header	 header;
+	struct perf_record_cpu_map_data	 data;
+};
+
+enum {
+	PERF_EVENT_UPDATE__UNIT  = 0,
+	PERF_EVENT_UPDATE__SCALE = 1,
+	PERF_EVENT_UPDATE__NAME  = 2,
+	PERF_EVENT_UPDATE__CPUS  = 3,
+};
+
+struct perf_record_event_update_cpus {
+	struct perf_record_cpu_map_data	 cpus;
+};
+
+struct perf_record_event_update_scale {
+	double			 scale;
+};
+
+struct perf_record_event_update {
+	struct perf_event_header header;
+	__u64			 type;
+	__u64			 id;
+	char			 data[];
+};
+
+#define MAX_EVENT_NAME 64
+
+struct perf_trace_event_type {
+	__u64			 event_id;
+	char			 name[MAX_EVENT_NAME];
+};
+
+struct perf_record_header_event_type {
+	struct perf_event_header	 header;
+	struct perf_trace_event_type	 event_type;
+};
+
+struct perf_record_header_tracing_data {
+	struct perf_event_header header;
+	__u32			 size;
+};
+
+struct perf_record_header_build_id {
+	struct perf_event_header header;
+	pid_t			 pid;
+	__u8			 build_id[24];
+	char			 filename[];
+};
+
+struct id_index_entry {
+	__u64			 id;
+	__u64			 idx;
+	__u64			 cpu;
+	__u64			 tid;
+};
+
+struct perf_record_id_index {
+	struct perf_event_header header;
+	__u64			 nr;
+	struct id_index_entry	 entries[0];
+};
+
+struct perf_record_auxtrace_info {
+	struct perf_event_header header;
+	__u32			 type;
+	__u32			 reserved__; /* For alignment */
+	__u64			 priv[];
+};
+
+struct perf_record_auxtrace {
+	struct perf_event_header header;
+	__u64			 size;
+	__u64			 offset;
+	__u64			 reference;
+	__u32			 idx;
+	__u32			 tid;
+	__u32			 cpu;
+	__u32			 reserved__; /* For alignment */
+};
+
+#define MAX_AUXTRACE_ERROR_MSG 64
+
+struct perf_record_auxtrace_error {
+	struct perf_event_header header;
+	__u32			 type;
+	__u32			 code;
+	__u32			 cpu;
+	__u32			 pid;
+	__u32			 tid;
+	__u32			 fmt;
+	__u64			 ip;
+	__u64			 time;
+	char			 msg[MAX_AUXTRACE_ERROR_MSG];
+};
+
+struct perf_record_aux {
+	struct perf_event_header header;
+	__u64			 aux_offset;
+	__u64			 aux_size;
+	__u64			 flags;
+};
+
+struct perf_record_itrace_start {
+	struct perf_event_header header;
+	__u32			 pid;
+	__u32			 tid;
+};
+
+struct perf_record_thread_map_entry {
+	__u64			 pid;
+	char			 comm[16];
+};
+
+struct perf_record_thread_map {
+	struct perf_event_header		 header;
+	__u64					 nr;
+	struct perf_record_thread_map_entry	 entries[];
+};
+
+enum {
+	PERF_STAT_CONFIG_TERM__AGGR_MODE	= 0,
+	PERF_STAT_CONFIG_TERM__INTERVAL		= 1,
+	PERF_STAT_CONFIG_TERM__SCALE		= 2,
+	PERF_STAT_CONFIG_TERM__MAX		= 3,
+};
+
+struct perf_record_stat_config_entry {
+	__u64			 tag;
+	__u64			 val;
+};
+
+struct perf_record_stat_config {
+	struct perf_event_header		 header;
+	__u64					 nr;
+	struct perf_record_stat_config_entry	 data[];
+};
+
+struct perf_record_stat {
+	struct perf_event_header header;
+
+	__u64			 id;
+	__u32			 cpu;
+	__u32			 thread;
+
+	union {
+		struct {
+			__u64	 val;
+			__u64	 ena;
+			__u64	 run;
+		};
+		__u64		 values[3];
+	};
+};
+
+struct perf_record_stat_round {
+	struct perf_event_header header;
+	__u64			 type;
+	__u64			 time;
+};
+
+struct perf_record_time_conv {
+	struct perf_event_header header;
+	__u64			 time_shift;
+	__u64			 time_mult;
+	__u64			 time_zero;
+};
+
+struct perf_record_header_feature {
+	struct perf_event_header header;
+	__u64			 feat_id;
+	char			 data[];
+};
+
+struct perf_record_compressed {
+	struct perf_event_header header;
+	char			 data[];
+};
+
+enum perf_user_event_type { /* above any possible kernel type */
+	PERF_RECORD_USER_TYPE_START		= 64,
+	PERF_RECORD_HEADER_ATTR			= 64,
+	PERF_RECORD_HEADER_EVENT_TYPE		= 65, /* deprecated */
+	PERF_RECORD_HEADER_TRACING_DATA		= 66,
+	PERF_RECORD_HEADER_BUILD_ID		= 67,
+	PERF_RECORD_FINISHED_ROUND		= 68,
+	PERF_RECORD_ID_INDEX			= 69,
+	PERF_RECORD_AUXTRACE_INFO		= 70,
+	PERF_RECORD_AUXTRACE			= 71,
+	PERF_RECORD_AUXTRACE_ERROR		= 72,
+	PERF_RECORD_THREAD_MAP			= 73,
+	PERF_RECORD_CPU_MAP			= 74,
+	PERF_RECORD_STAT_CONFIG			= 75,
+	PERF_RECORD_STAT			= 76,
+	PERF_RECORD_STAT_ROUND			= 77,
+	PERF_RECORD_EVENT_UPDATE		= 78,
+	PERF_RECORD_TIME_CONV			= 79,
+	PERF_RECORD_HEADER_FEATURE		= 80,
+	PERF_RECORD_COMPRESSED			= 81,
+	PERF_RECORD_HEADER_MAX
+};
+
+union perf_event {
+	struct perf_event_header		header;
+	struct perf_record_mmap			mmap;
+	struct perf_record_mmap2		mmap2;
+	struct perf_record_comm			comm;
+	struct perf_record_namespaces		namespaces;
+	struct perf_record_fork			fork;
+	struct perf_record_lost			lost;
+	struct perf_record_lost_samples		lost_samples;
+	struct perf_record_read			read;
+	struct perf_record_throttle		throttle;
+	struct perf_record_sample		sample;
+	struct perf_record_bpf_event		bpf;
+	struct perf_record_ksymbol		ksymbol;
+	struct perf_record_header_attr		attr;
+	struct perf_record_event_update		event_update;
+	struct perf_record_header_event_type	event_type;
+	struct perf_record_header_tracing_data	tracing_data;
+	struct perf_record_header_build_id	build_id;
+	struct perf_record_id_index		id_index;
+	struct perf_record_auxtrace_info	auxtrace_info;
+	struct perf_record_auxtrace		auxtrace;
+	struct perf_record_auxtrace_error	auxtrace_error;
+	struct perf_record_aux			aux;
+	struct perf_record_itrace_start		itrace_start;
+	struct perf_record_switch		context_switch;
+	struct perf_record_thread_map		thread_map;
+	struct perf_record_cpu_map		cpu_map;
+	struct perf_record_stat_config		stat_config;
+	struct perf_record_stat			stat;
+	struct perf_record_stat_round		stat_round;
+	struct perf_record_time_conv		time_conv;
+	struct perf_record_header_feature	feat;
+	struct perf_record_compressed		pack;
+};
+
+#endif /* __LIBPERF_EVENT_H */
diff --git a/tools/lib/perf/include/perf/evlist.h b/tools/lib/perf/include/perf/evlist.h
new file mode 100644
index 000000000000..0a7479dc13bf
--- /dev/null
+++ b/tools/lib/perf/include/perf/evlist.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LIBPERF_EVLIST_H
+#define __LIBPERF_EVLIST_H
+
+#include <perf/core.h>
+#include <stdbool.h>
+
+struct perf_evlist;
+struct perf_evsel;
+struct perf_cpu_map;
+struct perf_thread_map;
+
+LIBPERF_API void perf_evlist__add(struct perf_evlist *evlist,
+				  struct perf_evsel *evsel);
+LIBPERF_API void perf_evlist__remove(struct perf_evlist *evlist,
+				     struct perf_evsel *evsel);
+LIBPERF_API struct perf_evlist *perf_evlist__new(void);
+LIBPERF_API void perf_evlist__delete(struct perf_evlist *evlist);
+LIBPERF_API struct perf_evsel* perf_evlist__next(struct perf_evlist *evlist,
+						 struct perf_evsel *evsel);
+LIBPERF_API int perf_evlist__open(struct perf_evlist *evlist);
+LIBPERF_API void perf_evlist__close(struct perf_evlist *evlist);
+LIBPERF_API void perf_evlist__enable(struct perf_evlist *evlist);
+LIBPERF_API void perf_evlist__disable(struct perf_evlist *evlist);
+
+#define perf_evlist__for_each_evsel(evlist, pos)	\
+	for ((pos) = perf_evlist__next((evlist), NULL);	\
+	     (pos) != NULL;				\
+	     (pos) = perf_evlist__next((evlist), (pos)))
+
+LIBPERF_API void perf_evlist__set_maps(struct perf_evlist *evlist,
+				       struct perf_cpu_map *cpus,
+				       struct perf_thread_map *threads);
+LIBPERF_API int perf_evlist__poll(struct perf_evlist *evlist, int timeout);
+LIBPERF_API int perf_evlist__filter_pollfd(struct perf_evlist *evlist,
+					   short revents_and_mask);
+
+LIBPERF_API int perf_evlist__mmap(struct perf_evlist *evlist, int pages);
+LIBPERF_API void perf_evlist__munmap(struct perf_evlist *evlist);
+
+LIBPERF_API struct perf_mmap *perf_evlist__next_mmap(struct perf_evlist *evlist,
+						     struct perf_mmap *map,
+						     bool overwrite);
+#define perf_evlist__for_each_mmap(evlist, pos, overwrite)		\
+	for ((pos) = perf_evlist__next_mmap((evlist), NULL, overwrite);	\
+	     (pos) != NULL;						\
+	     (pos) = perf_evlist__next_mmap((evlist), (pos), overwrite))
+
+#endif /* __LIBPERF_EVLIST_H */
diff --git a/tools/lib/perf/include/perf/evsel.h b/tools/lib/perf/include/perf/evsel.h
new file mode 100644
index 000000000000..c82ec39a4ad0
--- /dev/null
+++ b/tools/lib/perf/include/perf/evsel.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LIBPERF_EVSEL_H
+#define __LIBPERF_EVSEL_H
+
+#include <stdint.h>
+#include <perf/core.h>
+
+struct perf_evsel;
+struct perf_event_attr;
+struct perf_cpu_map;
+struct perf_thread_map;
+
+struct perf_counts_values {
+	union {
+		struct {
+			uint64_t val;
+			uint64_t ena;
+			uint64_t run;
+		};
+		uint64_t values[3];
+	};
+};
+
+LIBPERF_API struct perf_evsel *perf_evsel__new(struct perf_event_attr *attr);
+LIBPERF_API void perf_evsel__delete(struct perf_evsel *evsel);
+LIBPERF_API int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
+				 struct perf_thread_map *threads);
+LIBPERF_API void perf_evsel__close(struct perf_evsel *evsel);
+LIBPERF_API void perf_evsel__close_cpu(struct perf_evsel *evsel, int cpu);
+LIBPERF_API int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
+				 struct perf_counts_values *count);
+LIBPERF_API int perf_evsel__enable(struct perf_evsel *evsel);
+LIBPERF_API int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu);
+LIBPERF_API int perf_evsel__disable(struct perf_evsel *evsel);
+LIBPERF_API int perf_evsel__disable_cpu(struct perf_evsel *evsel, int cpu);
+LIBPERF_API struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel);
+LIBPERF_API struct perf_thread_map *perf_evsel__threads(struct perf_evsel *evsel);
+LIBPERF_API struct perf_event_attr *perf_evsel__attr(struct perf_evsel *evsel);
+
+#endif /* __LIBPERF_EVSEL_H */
diff --git a/tools/lib/perf/include/perf/mmap.h b/tools/lib/perf/include/perf/mmap.h
new file mode 100644
index 000000000000..9508ad90d8b9
--- /dev/null
+++ b/tools/lib/perf/include/perf/mmap.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LIBPERF_MMAP_H
+#define __LIBPERF_MMAP_H
+
+#include <perf/core.h>
+
+struct perf_mmap;
+union perf_event;
+
+LIBPERF_API void perf_mmap__consume(struct perf_mmap *map);
+LIBPERF_API int perf_mmap__read_init(struct perf_mmap *map);
+LIBPERF_API void perf_mmap__read_done(struct perf_mmap *map);
+LIBPERF_API union perf_event *perf_mmap__read_event(struct perf_mmap *map);
+
+#endif /* __LIBPERF_MMAP_H */
diff --git a/tools/lib/perf/include/perf/threadmap.h b/tools/lib/perf/include/perf/threadmap.h
new file mode 100644
index 000000000000..a7c50de8d010
--- /dev/null
+++ b/tools/lib/perf/include/perf/threadmap.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LIBPERF_THREADMAP_H
+#define __LIBPERF_THREADMAP_H
+
+#include <perf/core.h>
+#include <sys/types.h>
+
+struct perf_thread_map;
+
+LIBPERF_API struct perf_thread_map *perf_thread_map__new_dummy(void);
+
+LIBPERF_API void perf_thread_map__set_pid(struct perf_thread_map *map, int thread, pid_t pid);
+LIBPERF_API char *perf_thread_map__comm(struct perf_thread_map *map, int thread);
+LIBPERF_API int perf_thread_map__nr(struct perf_thread_map *threads);
+LIBPERF_API pid_t perf_thread_map__pid(struct perf_thread_map *map, int thread);
+
+LIBPERF_API struct perf_thread_map *perf_thread_map__get(struct perf_thread_map *map);
+LIBPERF_API void perf_thread_map__put(struct perf_thread_map *map);
+
+#endif /* __LIBPERF_THREADMAP_H */
diff --git a/tools/lib/perf/internal.h b/tools/lib/perf/internal.h
new file mode 100644
index 000000000000..2c27e158de6b
--- /dev/null
+++ b/tools/lib/perf/internal.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LIBPERF_INTERNAL_H
+#define __LIBPERF_INTERNAL_H
+
+#include <perf/core.h>
+
+void libperf_print(enum libperf_print_level level,
+		   const char *format, ...)
+	__attribute__((format(printf, 2, 3)));
+
+#define __pr(level, fmt, ...)   \
+do {                            \
+	libperf_print(level, "libperf: " fmt, ##__VA_ARGS__);     \
+} while (0)
+
+#define pr_err(fmt, ...)        __pr(LIBPERF_ERR, fmt, ##__VA_ARGS__)
+#define pr_warning(fmt, ...)    __pr(LIBPERF_WARN, fmt, ##__VA_ARGS__)
+#define pr_info(fmt, ...)       __pr(LIBPERF_INFO, fmt, ##__VA_ARGS__)
+#define pr_debug(fmt, ...)      __pr(LIBPERF_DEBUG, fmt, ##__VA_ARGS__)
+#define pr_debug2(fmt, ...)     __pr(LIBPERF_DEBUG2, fmt, ##__VA_ARGS__)
+#define pr_debug3(fmt, ...)     __pr(LIBPERF_DEBUG3, fmt, ##__VA_ARGS__)
+
+#endif /* __LIBPERF_INTERNAL_H */
diff --git a/tools/lib/perf/lib.c b/tools/lib/perf/lib.c
new file mode 100644
index 000000000000..18658931fc71
--- /dev/null
+++ b/tools/lib/perf/lib.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <unistd.h>
+#include <stdbool.h>
+#include <errno.h>
+#include <linux/kernel.h>
+#include <internal/lib.h>
+
+unsigned int page_size;
+
+static ssize_t ion(bool is_read, int fd, void *buf, size_t n)
+{
+	void *buf_start = buf;
+	size_t left = n;
+
+	while (left) {
+		/* buf must be treated as const if !is_read. */
+		ssize_t ret = is_read ? read(fd, buf, left) :
+					write(fd, buf, left);
+
+		if (ret < 0 && errno == EINTR)
+			continue;
+		if (ret <= 0)
+			return ret;
+
+		left -= ret;
+		buf  += ret;
+	}
+
+	BUG_ON((size_t)(buf - buf_start) != n);
+	return n;
+}
+
+/*
+ * Read exactly 'n' bytes or return an error.
+ */
+ssize_t readn(int fd, void *buf, size_t n)
+{
+	return ion(true, fd, buf, n);
+}
+
+/*
+ * Write exactly 'n' bytes or return an error.
+ */
+ssize_t writen(int fd, const void *buf, size_t n)
+{
+	/* ion does not modify buf. */
+	return ion(false, fd, (void *)buf, n);
+}
diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
new file mode 100644
index 000000000000..7be1af8a546c
--- /dev/null
+++ b/tools/lib/perf/libperf.map
@@ -0,0 +1,51 @@
+LIBPERF_0.0.1 {
+	global:
+		libperf_init;
+		perf_cpu_map__dummy_new;
+		perf_cpu_map__get;
+		perf_cpu_map__put;
+		perf_cpu_map__new;
+		perf_cpu_map__read;
+		perf_cpu_map__nr;
+		perf_cpu_map__cpu;
+		perf_cpu_map__empty;
+		perf_cpu_map__max;
+		perf_thread_map__new_dummy;
+		perf_thread_map__set_pid;
+		perf_thread_map__comm;
+		perf_thread_map__nr;
+		perf_thread_map__pid;
+		perf_thread_map__get;
+		perf_thread_map__put;
+		perf_evsel__new;
+		perf_evsel__delete;
+		perf_evsel__enable;
+		perf_evsel__disable;
+		perf_evsel__open;
+		perf_evsel__close;
+		perf_evsel__read;
+		perf_evsel__cpus;
+		perf_evsel__threads;
+		perf_evsel__attr;
+		perf_evlist__new;
+		perf_evlist__delete;
+		perf_evlist__open;
+		perf_evlist__close;
+		perf_evlist__enable;
+		perf_evlist__disable;
+		perf_evlist__add;
+		perf_evlist__remove;
+		perf_evlist__next;
+		perf_evlist__set_maps;
+		perf_evlist__poll;
+		perf_evlist__mmap;
+		perf_evlist__munmap;
+		perf_evlist__filter_pollfd;
+		perf_evlist__next_mmap;
+		perf_mmap__consume;
+		perf_mmap__read_init;
+		perf_mmap__read_done;
+		perf_mmap__read_event;
+	local:
+		*;
+};
diff --git a/tools/lib/perf/libperf.pc.template b/tools/lib/perf/libperf.pc.template
new file mode 100644
index 000000000000..117e4a237b55
--- /dev/null
+++ b/tools/lib/perf/libperf.pc.template
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+
+prefix=@PREFIX@
+libdir=@LIBDIR@
+includedir=${prefix}/include
+
+Name: libperf
+Description: perf library
+Version: @VERSION@
+Libs: -L${libdir} -lperf
+Cflags: -I${includedir}
diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
new file mode 100644
index 000000000000..79d5ed6c38cc
--- /dev/null
+++ b/tools/lib/perf/mmap.c
@@ -0,0 +1,275 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <sys/mman.h>
+#include <inttypes.h>
+#include <asm/bug.h>
+#include <errno.h>
+#include <string.h>
+#include <linux/ring_buffer.h>
+#include <linux/perf_event.h>
+#include <perf/mmap.h>
+#include <perf/event.h>
+#include <internal/mmap.h>
+#include <internal/lib.h>
+#include <linux/kernel.h>
+#include "internal.h"
+
+void perf_mmap__init(struct perf_mmap *map, struct perf_mmap *prev,
+		     bool overwrite, libperf_unmap_cb_t unmap_cb)
+{
+	map->fd = -1;
+	map->overwrite = overwrite;
+	map->unmap_cb  = unmap_cb;
+	refcount_set(&map->refcnt, 0);
+	if (prev)
+		prev->next = map;
+}
+
+size_t perf_mmap__mmap_len(struct perf_mmap *map)
+{
+	return map->mask + 1 + page_size;
+}
+
+int perf_mmap__mmap(struct perf_mmap *map, struct perf_mmap_param *mp,
+		    int fd, int cpu)
+{
+	map->prev = 0;
+	map->mask = mp->mask;
+	map->base = mmap(NULL, perf_mmap__mmap_len(map), mp->prot,
+			 MAP_SHARED, fd, 0);
+	if (map->base == MAP_FAILED) {
+		map->base = NULL;
+		return -1;
+	}
+
+	map->fd  = fd;
+	map->cpu = cpu;
+	return 0;
+}
+
+void perf_mmap__munmap(struct perf_mmap *map)
+{
+	if (map && map->base != NULL) {
+		munmap(map->base, perf_mmap__mmap_len(map));
+		map->base = NULL;
+		map->fd = -1;
+		refcount_set(&map->refcnt, 0);
+	}
+	if (map && map->unmap_cb)
+		map->unmap_cb(map);
+}
+
+void perf_mmap__get(struct perf_mmap *map)
+{
+	refcount_inc(&map->refcnt);
+}
+
+void perf_mmap__put(struct perf_mmap *map)
+{
+	BUG_ON(map->base && refcount_read(&map->refcnt) == 0);
+
+	if (refcount_dec_and_test(&map->refcnt))
+		perf_mmap__munmap(map);
+}
+
+static inline void perf_mmap__write_tail(struct perf_mmap *md, u64 tail)
+{
+	ring_buffer_write_tail(md->base, tail);
+}
+
+u64 perf_mmap__read_head(struct perf_mmap *map)
+{
+	return ring_buffer_read_head(map->base);
+}
+
+static bool perf_mmap__empty(struct perf_mmap *map)
+{
+	struct perf_event_mmap_page *pc = map->base;
+
+	return perf_mmap__read_head(map) == map->prev && !pc->aux_size;
+}
+
+void perf_mmap__consume(struct perf_mmap *map)
+{
+	if (!map->overwrite) {
+		u64 old = map->prev;
+
+		perf_mmap__write_tail(map, old);
+	}
+
+	if (refcount_read(&map->refcnt) == 1 && perf_mmap__empty(map))
+		perf_mmap__put(map);
+}
+
+static int overwrite_rb_find_range(void *buf, int mask, u64 *start, u64 *end)
+{
+	struct perf_event_header *pheader;
+	u64 evt_head = *start;
+	int size = mask + 1;
+
+	pr_debug2("%s: buf=%p, start=%"PRIx64"\n", __func__, buf, *start);
+	pheader = (struct perf_event_header *)(buf + (*start & mask));
+	while (true) {
+		if (evt_head - *start >= (unsigned int)size) {
+			pr_debug("Finished reading overwrite ring buffer: rewind\n");
+			if (evt_head - *start > (unsigned int)size)
+				evt_head -= pheader->size;
+			*end = evt_head;
+			return 0;
+		}
+
+		pheader = (struct perf_event_header *)(buf + (evt_head & mask));
+
+		if (pheader->size == 0) {
+			pr_debug("Finished reading overwrite ring buffer: get start\n");
+			*end = evt_head;
+			return 0;
+		}
+
+		evt_head += pheader->size;
+		pr_debug3("move evt_head: %"PRIx64"\n", evt_head);
+	}
+	WARN_ONCE(1, "Shouldn't get here\n");
+	return -1;
+}
+
+/*
+ * Report the start and end of the available data in ringbuffer
+ */
+static int __perf_mmap__read_init(struct perf_mmap *md)
+{
+	u64 head = perf_mmap__read_head(md);
+	u64 old = md->prev;
+	unsigned char *data = md->base + page_size;
+	unsigned long size;
+
+	md->start = md->overwrite ? head : old;
+	md->end = md->overwrite ? old : head;
+
+	if ((md->end - md->start) < md->flush)
+		return -EAGAIN;
+
+	size = md->end - md->start;
+	if (size > (unsigned long)(md->mask) + 1) {
+		if (!md->overwrite) {
+			WARN_ONCE(1, "failed to keep up with mmap data. (warn only once)\n");
+
+			md->prev = head;
+			perf_mmap__consume(md);
+			return -EAGAIN;
+		}
+
+		/*
+		 * Backward ring buffer is full. We still have a chance to read
+		 * most of data from it.
+		 */
+		if (overwrite_rb_find_range(data, md->mask, &md->start, &md->end))
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+int perf_mmap__read_init(struct perf_mmap *map)
+{
+	/*
+	 * Check if event was unmapped due to a POLLHUP/POLLERR.
+	 */
+	if (!refcount_read(&map->refcnt))
+		return -ENOENT;
+
+	return __perf_mmap__read_init(map);
+}
+
+/*
+ * Mandatory for overwrite mode
+ * The direction of overwrite mode is backward.
+ * The last perf_mmap__read() will set tail to map->core.prev.
+ * Need to correct the map->core.prev to head which is the end of next read.
+ */
+void perf_mmap__read_done(struct perf_mmap *map)
+{
+	/*
+	 * Check if event was unmapped due to a POLLHUP/POLLERR.
+	 */
+	if (!refcount_read(&map->refcnt))
+		return;
+
+	map->prev = perf_mmap__read_head(map);
+}
+
+/* When check_messup is true, 'end' must points to a good entry */
+static union perf_event *perf_mmap__read(struct perf_mmap *map,
+					 u64 *startp, u64 end)
+{
+	unsigned char *data = map->base + page_size;
+	union perf_event *event = NULL;
+	int diff = end - *startp;
+
+	if (diff >= (int)sizeof(event->header)) {
+		size_t size;
+
+		event = (union perf_event *)&data[*startp & map->mask];
+		size = event->header.size;
+
+		if (size < sizeof(event->header) || diff < (int)size)
+			return NULL;
+
+		/*
+		 * Event straddles the mmap boundary -- header should always
+		 * be inside due to u64 alignment of output.
+		 */
+		if ((*startp & map->mask) + size != ((*startp + size) & map->mask)) {
+			unsigned int offset = *startp;
+			unsigned int len = min(sizeof(*event), size), cpy;
+			void *dst = map->event_copy;
+
+			do {
+				cpy = min(map->mask + 1 - (offset & map->mask), len);
+				memcpy(dst, &data[offset & map->mask], cpy);
+				offset += cpy;
+				dst += cpy;
+				len -= cpy;
+			} while (len);
+
+			event = (union perf_event *)map->event_copy;
+		}
+
+		*startp += size;
+	}
+
+	return event;
+}
+
+/*
+ * Read event from ring buffer one by one.
+ * Return one event for each call.
+ *
+ * Usage:
+ * perf_mmap__read_init()
+ * while(event = perf_mmap__read_event()) {
+ *	//process the event
+ *	perf_mmap__consume()
+ * }
+ * perf_mmap__read_done()
+ */
+union perf_event *perf_mmap__read_event(struct perf_mmap *map)
+{
+	union perf_event *event;
+
+	/*
+	 * Check if event was unmapped due to a POLLHUP/POLLERR.
+	 */
+	if (!refcount_read(&map->refcnt))
+		return NULL;
+
+	/* non-overwirte doesn't pause the ringbuffer */
+	if (!map->overwrite)
+		map->end = perf_mmap__read_head(map);
+
+	event = perf_mmap__read(map, &map->start, map->end);
+
+	if (!map->overwrite)
+		map->prev = map->start;
+
+	return event;
+}
diff --git a/tools/lib/perf/tests/Makefile b/tools/lib/perf/tests/Makefile
new file mode 100644
index 000000000000..96841775feaf
--- /dev/null
+++ b/tools/lib/perf/tests/Makefile
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+
+TESTS = test-cpumap test-threadmap test-evlist test-evsel
+
+TESTS_SO := $(addsuffix -so,$(TESTS))
+TESTS_A  := $(addsuffix -a,$(TESTS))
+
+# Set compile option CFLAGS
+ifdef EXTRA_CFLAGS
+  CFLAGS := $(EXTRA_CFLAGS)
+else
+  CFLAGS := -g -Wall
+endif
+
+all:
+
+include $(srctree)/tools/scripts/Makefile.include
+
+INCLUDE = -I$(srctree)/tools/lib/perf/include -I$(srctree)/tools/include -I$(srctree)/tools/lib
+
+$(TESTS_A): FORCE
+	$(QUIET_LINK)$(CC) $(INCLUDE) $(CFLAGS) -o $@ $(subst -a,.c,$@) ../libperf.a $(LIBAPI)
+
+$(TESTS_SO): FORCE
+	$(QUIET_LINK)$(CC) $(INCLUDE) $(CFLAGS) -L.. -o $@ $(subst -so,.c,$@) $(LIBAPI) -lperf
+
+all: $(TESTS_A) $(TESTS_SO)
+
+run:
+	@echo "running static:"
+	@for i in $(TESTS_A); do ./$$i; done
+	@echo "running dynamic:"
+	@for i in $(TESTS_SO); do LD_LIBRARY_PATH=../ ./$$i; done
+
+clean:
+	$(call QUIET_CLEAN, tests)$(RM) $(TESTS_A) $(TESTS_SO)
+
+.PHONY: all clean FORCE
diff --git a/tools/lib/perf/tests/test-cpumap.c b/tools/lib/perf/tests/test-cpumap.c
new file mode 100644
index 000000000000..c8d45091e7c2
--- /dev/null
+++ b/tools/lib/perf/tests/test-cpumap.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdarg.h>
+#include <stdio.h>
+#include <perf/cpumap.h>
+#include <internal/tests.h>
+
+static int libperf_print(enum libperf_print_level level,
+			 const char *fmt, va_list ap)
+{
+	return vfprintf(stderr, fmt, ap);
+}
+
+int main(int argc, char **argv)
+{
+	struct perf_cpu_map *cpus;
+
+	__T_START;
+
+	libperf_init(libperf_print);
+
+	cpus = perf_cpu_map__dummy_new();
+	if (!cpus)
+		return -1;
+
+	perf_cpu_map__get(cpus);
+	perf_cpu_map__put(cpus);
+	perf_cpu_map__put(cpus);
+
+	__T_END;
+	return 0;
+}
diff --git a/tools/lib/perf/tests/test-evlist.c b/tools/lib/perf/tests/test-evlist.c
new file mode 100644
index 000000000000..6d8ebe0c2504
--- /dev/null
+++ b/tools/lib/perf/tests/test-evlist.c
@@ -0,0 +1,413 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE // needed for sched.h to get sched_[gs]etaffinity and CPU_(ZERO,SET)
+#include <sched.h>
+#include <stdio.h>
+#include <stdarg.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <linux/perf_event.h>
+#include <linux/limits.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <sys/prctl.h>
+#include <perf/cpumap.h>
+#include <perf/threadmap.h>
+#include <perf/evlist.h>
+#include <perf/evsel.h>
+#include <perf/mmap.h>
+#include <perf/event.h>
+#include <internal/tests.h>
+#include <api/fs/fs.h>
+
+static int libperf_print(enum libperf_print_level level,
+			 const char *fmt, va_list ap)
+{
+	return vfprintf(stderr, fmt, ap);
+}
+
+static int test_stat_cpu(void)
+{
+	struct perf_cpu_map *cpus;
+	struct perf_evlist *evlist;
+	struct perf_evsel *evsel;
+	struct perf_event_attr attr1 = {
+		.type	= PERF_TYPE_SOFTWARE,
+		.config	= PERF_COUNT_SW_CPU_CLOCK,
+	};
+	struct perf_event_attr attr2 = {
+		.type	= PERF_TYPE_SOFTWARE,
+		.config	= PERF_COUNT_SW_TASK_CLOCK,
+	};
+	int err, cpu, tmp;
+
+	cpus = perf_cpu_map__new(NULL);
+	__T("failed to create cpus", cpus);
+
+	evlist = perf_evlist__new();
+	__T("failed to create evlist", evlist);
+
+	evsel = perf_evsel__new(&attr1);
+	__T("failed to create evsel1", evsel);
+
+	perf_evlist__add(evlist, evsel);
+
+	evsel = perf_evsel__new(&attr2);
+	__T("failed to create evsel2", evsel);
+
+	perf_evlist__add(evlist, evsel);
+
+	perf_evlist__set_maps(evlist, cpus, NULL);
+
+	err = perf_evlist__open(evlist);
+	__T("failed to open evsel", err == 0);
+
+	perf_evlist__for_each_evsel(evlist, evsel) {
+		cpus = perf_evsel__cpus(evsel);
+
+		perf_cpu_map__for_each_cpu(cpu, tmp, cpus) {
+			struct perf_counts_values counts = { .val = 0 };
+
+			perf_evsel__read(evsel, cpu, 0, &counts);
+			__T("failed to read value for evsel", counts.val != 0);
+		}
+	}
+
+	perf_evlist__close(evlist);
+	perf_evlist__delete(evlist);
+
+	perf_cpu_map__put(cpus);
+	return 0;
+}
+
+static int test_stat_thread(void)
+{
+	struct perf_counts_values counts = { .val = 0 };
+	struct perf_thread_map *threads;
+	struct perf_evlist *evlist;
+	struct perf_evsel *evsel;
+	struct perf_event_attr attr1 = {
+		.type	= PERF_TYPE_SOFTWARE,
+		.config	= PERF_COUNT_SW_CPU_CLOCK,
+	};
+	struct perf_event_attr attr2 = {
+		.type	= PERF_TYPE_SOFTWARE,
+		.config	= PERF_COUNT_SW_TASK_CLOCK,
+	};
+	int err;
+
+	threads = perf_thread_map__new_dummy();
+	__T("failed to create threads", threads);
+
+	perf_thread_map__set_pid(threads, 0, 0);
+
+	evlist = perf_evlist__new();
+	__T("failed to create evlist", evlist);
+
+	evsel = perf_evsel__new(&attr1);
+	__T("failed to create evsel1", evsel);
+
+	perf_evlist__add(evlist, evsel);
+
+	evsel = perf_evsel__new(&attr2);
+	__T("failed to create evsel2", evsel);
+
+	perf_evlist__add(evlist, evsel);
+
+	perf_evlist__set_maps(evlist, NULL, threads);
+
+	err = perf_evlist__open(evlist);
+	__T("failed to open evsel", err == 0);
+
+	perf_evlist__for_each_evsel(evlist, evsel) {
+		perf_evsel__read(evsel, 0, 0, &counts);
+		__T("failed to read value for evsel", counts.val != 0);
+	}
+
+	perf_evlist__close(evlist);
+	perf_evlist__delete(evlist);
+
+	perf_thread_map__put(threads);
+	return 0;
+}
+
+static int test_stat_thread_enable(void)
+{
+	struct perf_counts_values counts = { .val = 0 };
+	struct perf_thread_map *threads;
+	struct perf_evlist *evlist;
+	struct perf_evsel *evsel;
+	struct perf_event_attr attr1 = {
+		.type	  = PERF_TYPE_SOFTWARE,
+		.config	  = PERF_COUNT_SW_CPU_CLOCK,
+		.disabled = 1,
+	};
+	struct perf_event_attr attr2 = {
+		.type	  = PERF_TYPE_SOFTWARE,
+		.config	  = PERF_COUNT_SW_TASK_CLOCK,
+		.disabled = 1,
+	};
+	int err;
+
+	threads = perf_thread_map__new_dummy();
+	__T("failed to create threads", threads);
+
+	perf_thread_map__set_pid(threads, 0, 0);
+
+	evlist = perf_evlist__new();
+	__T("failed to create evlist", evlist);
+
+	evsel = perf_evsel__new(&attr1);
+	__T("failed to create evsel1", evsel);
+
+	perf_evlist__add(evlist, evsel);
+
+	evsel = perf_evsel__new(&attr2);
+	__T("failed to create evsel2", evsel);
+
+	perf_evlist__add(evlist, evsel);
+
+	perf_evlist__set_maps(evlist, NULL, threads);
+
+	err = perf_evlist__open(evlist);
+	__T("failed to open evsel", err == 0);
+
+	perf_evlist__for_each_evsel(evlist, evsel) {
+		perf_evsel__read(evsel, 0, 0, &counts);
+		__T("failed to read value for evsel", counts.val == 0);
+	}
+
+	perf_evlist__enable(evlist);
+
+	perf_evlist__for_each_evsel(evlist, evsel) {
+		perf_evsel__read(evsel, 0, 0, &counts);
+		__T("failed to read value for evsel", counts.val != 0);
+	}
+
+	perf_evlist__disable(evlist);
+
+	perf_evlist__close(evlist);
+	perf_evlist__delete(evlist);
+
+	perf_thread_map__put(threads);
+	return 0;
+}
+
+static int test_mmap_thread(void)
+{
+	struct perf_evlist *evlist;
+	struct perf_evsel *evsel;
+	struct perf_mmap *map;
+	struct perf_cpu_map *cpus;
+	struct perf_thread_map *threads;
+	struct perf_event_attr attr = {
+		.type             = PERF_TYPE_TRACEPOINT,
+		.sample_period    = 1,
+		.wakeup_watermark = 1,
+		.disabled         = 1,
+	};
+	char path[PATH_MAX];
+	int id, err, pid, go_pipe[2];
+	union perf_event *event;
+	char bf;
+	int count = 0;
+
+	snprintf(path, PATH_MAX, "%s/kernel/debug/tracing/events/syscalls/sys_enter_prctl/id",
+		 sysfs__mountpoint());
+
+	if (filename__read_int(path, &id)) {
+		fprintf(stderr, "error: failed to get tracepoint id: %s\n", path);
+		return -1;
+	}
+
+	attr.config = id;
+
+	err = pipe(go_pipe);
+	__T("failed to create pipe", err == 0);
+
+	fflush(NULL);
+
+	pid = fork();
+	if (!pid) {
+		int i;
+
+		read(go_pipe[0], &bf, 1);
+
+		/* Generate 100 prctl calls. */
+		for (i = 0; i < 100; i++)
+			prctl(0, 0, 0, 0, 0);
+
+		exit(0);
+	}
+
+	threads = perf_thread_map__new_dummy();
+	__T("failed to create threads", threads);
+
+	cpus = perf_cpu_map__dummy_new();
+	__T("failed to create cpus", cpus);
+
+	perf_thread_map__set_pid(threads, 0, pid);
+
+	evlist = perf_evlist__new();
+	__T("failed to create evlist", evlist);
+
+	evsel = perf_evsel__new(&attr);
+	__T("failed to create evsel1", evsel);
+
+	perf_evlist__add(evlist, evsel);
+
+	perf_evlist__set_maps(evlist, cpus, threads);
+
+	err = perf_evlist__open(evlist);
+	__T("failed to open evlist", err == 0);
+
+	err = perf_evlist__mmap(evlist, 4);
+	__T("failed to mmap evlist", err == 0);
+
+	perf_evlist__enable(evlist);
+
+	/* kick the child and wait for it to finish */
+	write(go_pipe[1], &bf, 1);
+	waitpid(pid, NULL, 0);
+
+	/*
+	 * There's no need to call perf_evlist__disable,
+	 * monitored process is dead now.
+	 */
+
+	perf_evlist__for_each_mmap(evlist, map, false) {
+		if (perf_mmap__read_init(map) < 0)
+			continue;
+
+		while ((event = perf_mmap__read_event(map)) != NULL) {
+			count++;
+			perf_mmap__consume(map);
+		}
+
+		perf_mmap__read_done(map);
+	}
+
+	/* calls perf_evlist__munmap/perf_evlist__close */
+	perf_evlist__delete(evlist);
+
+	perf_thread_map__put(threads);
+	perf_cpu_map__put(cpus);
+
+	/*
+	 * The generated prctl calls should match the
+	 * number of events in the buffer.
+	 */
+	__T("failed count", count == 100);
+
+	return 0;
+}
+
+static int test_mmap_cpus(void)
+{
+	struct perf_evlist *evlist;
+	struct perf_evsel *evsel;
+	struct perf_mmap *map;
+	struct perf_cpu_map *cpus;
+	struct perf_event_attr attr = {
+		.type             = PERF_TYPE_TRACEPOINT,
+		.sample_period    = 1,
+		.wakeup_watermark = 1,
+		.disabled         = 1,
+	};
+	cpu_set_t saved_mask;
+	char path[PATH_MAX];
+	int id, err, cpu, tmp;
+	union perf_event *event;
+	int count = 0;
+
+	snprintf(path, PATH_MAX, "%s/kernel/debug/tracing/events/syscalls/sys_enter_prctl/id",
+		 sysfs__mountpoint());
+
+	if (filename__read_int(path, &id)) {
+		fprintf(stderr, "error: failed to get tracepoint id: %s\n", path);
+		return -1;
+	}
+
+	attr.config = id;
+
+	cpus = perf_cpu_map__new(NULL);
+	__T("failed to create cpus", cpus);
+
+	evlist = perf_evlist__new();
+	__T("failed to create evlist", evlist);
+
+	evsel = perf_evsel__new(&attr);
+	__T("failed to create evsel1", evsel);
+
+	perf_evlist__add(evlist, evsel);
+
+	perf_evlist__set_maps(evlist, cpus, NULL);
+
+	err = perf_evlist__open(evlist);
+	__T("failed to open evlist", err == 0);
+
+	err = perf_evlist__mmap(evlist, 4);
+	__T("failed to mmap evlist", err == 0);
+
+	perf_evlist__enable(evlist);
+
+	err = sched_getaffinity(0, sizeof(saved_mask), &saved_mask);
+	__T("sched_getaffinity failed", err == 0);
+
+	perf_cpu_map__for_each_cpu(cpu, tmp, cpus) {
+		cpu_set_t mask;
+
+		CPU_ZERO(&mask);
+		CPU_SET(cpu, &mask);
+
+		err = sched_setaffinity(0, sizeof(mask), &mask);
+		__T("sched_setaffinity failed", err == 0);
+
+		prctl(0, 0, 0, 0, 0);
+	}
+
+	err = sched_setaffinity(0, sizeof(saved_mask), &saved_mask);
+	__T("sched_setaffinity failed", err == 0);
+
+	perf_evlist__disable(evlist);
+
+	perf_evlist__for_each_mmap(evlist, map, false) {
+		if (perf_mmap__read_init(map) < 0)
+			continue;
+
+		while ((event = perf_mmap__read_event(map)) != NULL) {
+			count++;
+			perf_mmap__consume(map);
+		}
+
+		perf_mmap__read_done(map);
+	}
+
+	/* calls perf_evlist__munmap/perf_evlist__close */
+	perf_evlist__delete(evlist);
+
+	/*
+	 * The generated prctl events should match the
+	 * number of cpus or be bigger (we are system-wide).
+	 */
+	__T("failed count", count >= perf_cpu_map__nr(cpus));
+
+	perf_cpu_map__put(cpus);
+
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	__T_START;
+
+	libperf_init(libperf_print);
+
+	test_stat_cpu();
+	test_stat_thread();
+	test_stat_thread_enable();
+	test_mmap_thread();
+	test_mmap_cpus();
+
+	__T_END;
+	return 0;
+}
diff --git a/tools/lib/perf/tests/test-evsel.c b/tools/lib/perf/tests/test-evsel.c
new file mode 100644
index 000000000000..135722ac965b
--- /dev/null
+++ b/tools/lib/perf/tests/test-evsel.c
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdarg.h>
+#include <stdio.h>
+#include <linux/perf_event.h>
+#include <perf/cpumap.h>
+#include <perf/threadmap.h>
+#include <perf/evsel.h>
+#include <internal/tests.h>
+
+static int libperf_print(enum libperf_print_level level,
+			 const char *fmt, va_list ap)
+{
+	return vfprintf(stderr, fmt, ap);
+}
+
+static int test_stat_cpu(void)
+{
+	struct perf_cpu_map *cpus;
+	struct perf_evsel *evsel;
+	struct perf_event_attr attr = {
+		.type	= PERF_TYPE_SOFTWARE,
+		.config	= PERF_COUNT_SW_CPU_CLOCK,
+	};
+	int err, cpu, tmp;
+
+	cpus = perf_cpu_map__new(NULL);
+	__T("failed to create cpus", cpus);
+
+	evsel = perf_evsel__new(&attr);
+	__T("failed to create evsel", evsel);
+
+	err = perf_evsel__open(evsel, cpus, NULL);
+	__T("failed to open evsel", err == 0);
+
+	perf_cpu_map__for_each_cpu(cpu, tmp, cpus) {
+		struct perf_counts_values counts = { .val = 0 };
+
+		perf_evsel__read(evsel, cpu, 0, &counts);
+		__T("failed to read value for evsel", counts.val != 0);
+	}
+
+	perf_evsel__close(evsel);
+	perf_evsel__delete(evsel);
+
+	perf_cpu_map__put(cpus);
+	return 0;
+}
+
+static int test_stat_thread(void)
+{
+	struct perf_counts_values counts = { .val = 0 };
+	struct perf_thread_map *threads;
+	struct perf_evsel *evsel;
+	struct perf_event_attr attr = {
+		.type	= PERF_TYPE_SOFTWARE,
+		.config	= PERF_COUNT_SW_TASK_CLOCK,
+	};
+	int err;
+
+	threads = perf_thread_map__new_dummy();
+	__T("failed to create threads", threads);
+
+	perf_thread_map__set_pid(threads, 0, 0);
+
+	evsel = perf_evsel__new(&attr);
+	__T("failed to create evsel", evsel);
+
+	err = perf_evsel__open(evsel, NULL, threads);
+	__T("failed to open evsel", err == 0);
+
+	perf_evsel__read(evsel, 0, 0, &counts);
+	__T("failed to read value for evsel", counts.val != 0);
+
+	perf_evsel__close(evsel);
+	perf_evsel__delete(evsel);
+
+	perf_thread_map__put(threads);
+	return 0;
+}
+
+static int test_stat_thread_enable(void)
+{
+	struct perf_counts_values counts = { .val = 0 };
+	struct perf_thread_map *threads;
+	struct perf_evsel *evsel;
+	struct perf_event_attr attr = {
+		.type	  = PERF_TYPE_SOFTWARE,
+		.config	  = PERF_COUNT_SW_TASK_CLOCK,
+		.disabled = 1,
+	};
+	int err;
+
+	threads = perf_thread_map__new_dummy();
+	__T("failed to create threads", threads);
+
+	perf_thread_map__set_pid(threads, 0, 0);
+
+	evsel = perf_evsel__new(&attr);
+	__T("failed to create evsel", evsel);
+
+	err = perf_evsel__open(evsel, NULL, threads);
+	__T("failed to open evsel", err == 0);
+
+	perf_evsel__read(evsel, 0, 0, &counts);
+	__T("failed to read value for evsel", counts.val == 0);
+
+	err = perf_evsel__enable(evsel);
+	__T("failed to enable evsel", err == 0);
+
+	perf_evsel__read(evsel, 0, 0, &counts);
+	__T("failed to read value for evsel", counts.val != 0);
+
+	err = perf_evsel__disable(evsel);
+	__T("failed to enable evsel", err == 0);
+
+	perf_evsel__close(evsel);
+	perf_evsel__delete(evsel);
+
+	perf_thread_map__put(threads);
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	__T_START;
+
+	libperf_init(libperf_print);
+
+	test_stat_cpu();
+	test_stat_thread();
+	test_stat_thread_enable();
+
+	__T_END;
+	return 0;
+}
diff --git a/tools/lib/perf/tests/test-threadmap.c b/tools/lib/perf/tests/test-threadmap.c
new file mode 100644
index 000000000000..7dc4d6fbedde
--- /dev/null
+++ b/tools/lib/perf/tests/test-threadmap.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdarg.h>
+#include <stdio.h>
+#include <perf/threadmap.h>
+#include <internal/tests.h>
+
+static int libperf_print(enum libperf_print_level level,
+			 const char *fmt, va_list ap)
+{
+	return vfprintf(stderr, fmt, ap);
+}
+
+int main(int argc, char **argv)
+{
+	struct perf_thread_map *threads;
+
+	__T_START;
+
+	libperf_init(libperf_print);
+
+	threads = perf_thread_map__new_dummy();
+	if (!threads)
+		return -1;
+
+	perf_thread_map__get(threads);
+	perf_thread_map__put(threads);
+	perf_thread_map__put(threads);
+
+	__T_END;
+	return 0;
+}
diff --git a/tools/lib/perf/threadmap.c b/tools/lib/perf/threadmap.c
new file mode 100644
index 000000000000..e92c368b0a6c
--- /dev/null
+++ b/tools/lib/perf/threadmap.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <perf/threadmap.h>
+#include <stdlib.h>
+#include <linux/refcount.h>
+#include <internal/threadmap.h>
+#include <string.h>
+#include <asm/bug.h>
+#include <stdio.h>
+
+static void perf_thread_map__reset(struct perf_thread_map *map, int start, int nr)
+{
+	size_t size = (nr - start) * sizeof(map->map[0]);
+
+	memset(&map->map[start], 0, size);
+	map->err_thread = -1;
+}
+
+struct perf_thread_map *perf_thread_map__realloc(struct perf_thread_map *map, int nr)
+{
+	size_t size = sizeof(*map) + sizeof(map->map[0]) * nr;
+	int start = map ? map->nr : 0;
+
+	map = realloc(map, size);
+	/*
+	 * We only realloc to add more items, let's reset new items.
+	 */
+	if (map)
+		perf_thread_map__reset(map, start, nr);
+
+	return map;
+}
+
+#define thread_map__alloc(__nr) perf_thread_map__realloc(NULL, __nr)
+
+void perf_thread_map__set_pid(struct perf_thread_map *map, int thread, pid_t pid)
+{
+	map->map[thread].pid = pid;
+}
+
+char *perf_thread_map__comm(struct perf_thread_map *map, int thread)
+{
+	return map->map[thread].comm;
+}
+
+struct perf_thread_map *perf_thread_map__new_dummy(void)
+{
+	struct perf_thread_map *threads = thread_map__alloc(1);
+
+	if (threads != NULL) {
+		perf_thread_map__set_pid(threads, 0, -1);
+		threads->nr = 1;
+		refcount_set(&threads->refcnt, 1);
+	}
+	return threads;
+}
+
+static void perf_thread_map__delete(struct perf_thread_map *threads)
+{
+	if (threads) {
+		int i;
+
+		WARN_ONCE(refcount_read(&threads->refcnt) != 0,
+			  "thread map refcnt unbalanced\n");
+		for (i = 0; i < threads->nr; i++)
+			free(perf_thread_map__comm(threads, i));
+		free(threads);
+	}
+}
+
+struct perf_thread_map *perf_thread_map__get(struct perf_thread_map *map)
+{
+	if (map)
+		refcount_inc(&map->refcnt);
+	return map;
+}
+
+void perf_thread_map__put(struct perf_thread_map *map)
+{
+	if (map && refcount_dec_and_test(&map->refcnt))
+		perf_thread_map__delete(map);
+}
+
+int perf_thread_map__nr(struct perf_thread_map *threads)
+{
+	return threads ? threads->nr : 1;
+}
+
+pid_t perf_thread_map__pid(struct perf_thread_map *map, int thread)
+{
+	return map->map[thread].pid;
+}
diff --git a/tools/lib/perf/xyarray.c b/tools/lib/perf/xyarray.c
new file mode 100644
index 000000000000..dcd901d154bb
--- /dev/null
+++ b/tools/lib/perf/xyarray.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <internal/xyarray.h>
+#include <linux/zalloc.h>
+#include <stdlib.h>
+#include <string.h>
+
+struct xyarray *xyarray__new(int xlen, int ylen, size_t entry_size)
+{
+	size_t row_size = ylen * entry_size;
+	struct xyarray *xy = zalloc(sizeof(*xy) + xlen * row_size);
+
+	if (xy != NULL) {
+		xy->entry_size = entry_size;
+		xy->row_size   = row_size;
+		xy->entries    = xlen * ylen;
+		xy->max_x      = xlen;
+		xy->max_y      = ylen;
+	}
+
+	return xy;
+}
+
+void xyarray__reset(struct xyarray *xy)
+{
+	size_t n = xy->entries * xy->entry_size;
+
+	memset(xy->contents, 0, n);
+}
+
+void xyarray__delete(struct xyarray *xy)
+{
+	free(xy);
+}
diff --git a/tools/perf/MANIFEST b/tools/perf/MANIFEST
index 70f1ff4e2eb4..ae2aab5b1be0 100644
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
diff --git a/tools/perf/lib/Build b/tools/perf/lib/Build
deleted file mode 100644
index 2ef9a4ec6d99..000000000000
--- a/tools/perf/lib/Build
+++ /dev/null
@@ -1,13 +0,0 @@
-libperf-y += core.o
-libperf-y += cpumap.o
-libperf-y += threadmap.o
-libperf-y += evsel.o
-libperf-y += evlist.o
-libperf-y += mmap.o
-libperf-y += zalloc.o
-libperf-y += xyarray.o
-libperf-y += lib.o
-
-$(OUTPUT)zalloc.o: ../../lib/zalloc.c FORCE
-	$(call rule_mkdir)
-	$(call if_changed_dep,cc_o_c)
diff --git a/tools/perf/lib/Documentation/Makefile b/tools/perf/lib/Documentation/Makefile
deleted file mode 100644
index 586425a88795..000000000000
--- a/tools/perf/lib/Documentation/Makefile
+++ /dev/null
@@ -1,7 +0,0 @@
-all:
-	rst2man man/libperf.rst > man/libperf.7
-	rst2pdf tutorial/tutorial.rst
-
-clean:
-	rm -f man/libperf.7
-	rm -f tutorial/tutorial.pdf
diff --git a/tools/perf/lib/Documentation/man/libperf.rst b/tools/perf/lib/Documentation/man/libperf.rst
deleted file mode 100644
index 09a270fccb9c..000000000000
--- a/tools/perf/lib/Documentation/man/libperf.rst
+++ /dev/null
@@ -1,100 +0,0 @@
-.. SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
-
-libperf
-
-The libperf library provides an API to access the linux kernel perf
-events subsystem. It provides the following high level objects:
-
-  - struct perf_cpu_map
-  - struct perf_thread_map
-  - struct perf_evlist
-  - struct perf_evsel
-
-reference
-=========
-Function reference by header files:
-
-perf/core.h
------------
-.. code-block:: c
-
-  typedef int (\*libperf_print_fn_t)(enum libperf_print_level level,
-                                     const char \*, va_list ap);
-
-  void libperf_set_print(libperf_print_fn_t fn);
-
-perf/cpumap.h
--------------
-.. code-block:: c
-
-  struct perf_cpu_map \*perf_cpu_map__dummy_new(void);
-  struct perf_cpu_map \*perf_cpu_map__new(const char \*cpu_list);
-  struct perf_cpu_map \*perf_cpu_map__read(FILE \*file);
-  struct perf_cpu_map \*perf_cpu_map__get(struct perf_cpu_map \*map);
-  void perf_cpu_map__put(struct perf_cpu_map \*map);
-  int perf_cpu_map__cpu(const struct perf_cpu_map \*cpus, int idx);
-  int perf_cpu_map__nr(const struct perf_cpu_map \*cpus);
-  perf_cpu_map__for_each_cpu(cpu, idx, cpus)
-
-perf/threadmap.h
-----------------
-.. code-block:: c
-
-  struct perf_thread_map \*perf_thread_map__new_dummy(void);
-  void perf_thread_map__set_pid(struct perf_thread_map \*map, int thread, pid_t pid);
-  char \*perf_thread_map__comm(struct perf_thread_map \*map, int thread);
-  struct perf_thread_map \*perf_thread_map__get(struct perf_thread_map \*map);
-  void perf_thread_map__put(struct perf_thread_map \*map);
-
-perf/evlist.h
--------------
-.. code-block::
-
-  void perf_evlist__init(struct perf_evlist \*evlist);
-  void perf_evlist__add(struct perf_evlist \*evlist,
-                      struct perf_evsel \*evsel);
-  void perf_evlist__remove(struct perf_evlist \*evlist,
-                         struct perf_evsel \*evsel);
-  struct perf_evlist \*perf_evlist__new(void);
-  void perf_evlist__delete(struct perf_evlist \*evlist);
-  struct perf_evsel\* perf_evlist__next(struct perf_evlist \*evlist,
-                                     struct perf_evsel \*evsel);
-  int perf_evlist__open(struct perf_evlist \*evlist);
-  void perf_evlist__close(struct perf_evlist \*evlist);
-  void perf_evlist__enable(struct perf_evlist \*evlist);
-  void perf_evlist__disable(struct perf_evlist \*evlist);
-  perf_evlist__for_each_evsel(evlist, pos)
-  void perf_evlist__set_maps(struct perf_evlist \*evlist,
-                           struct perf_cpu_map \*cpus,
-                           struct perf_thread_map \*threads);
-
-perf/evsel.h
-------------
-.. code-block:: c
-
-  struct perf_counts_values {
-        union {
-                struct {
-                        uint64_t val;
-                        uint64_t ena;
-                        uint64_t run;
-                };
-                uint64_t values[3];
-        };
-  };
-
-  void perf_evsel__init(struct perf_evsel \*evsel,
-                      struct perf_event_attr \*attr);
-  struct perf_evsel \*perf_evsel__new(struct perf_event_attr \*attr);
-  void perf_evsel__delete(struct perf_evsel \*evsel);
-  int perf_evsel__open(struct perf_evsel \*evsel, struct perf_cpu_map \*cpus,
-                     struct perf_thread_map \*threads);
-  void perf_evsel__close(struct perf_evsel \*evsel);
-  int perf_evsel__read(struct perf_evsel \*evsel, int cpu, int thread,
-                     struct perf_counts_values \*count);
-  int perf_evsel__enable(struct perf_evsel \*evsel);
-  int perf_evsel__disable(struct perf_evsel \*evsel);
-  int perf_evsel__apply_filter(struct perf_evsel \*evsel, const char \*filter);
-  struct perf_cpu_map \*perf_evsel__cpus(struct perf_evsel \*evsel);
-  struct perf_thread_map \*perf_evsel__threads(struct perf_evsel \*evsel);
-  struct perf_event_attr \*perf_evsel__attr(struct perf_evsel \*evsel);
diff --git a/tools/perf/lib/Documentation/tutorial/tutorial.rst b/tools/perf/lib/Documentation/tutorial/tutorial.rst
deleted file mode 100644
index 7be7bc27b385..000000000000
--- a/tools/perf/lib/Documentation/tutorial/tutorial.rst
+++ /dev/null
@@ -1,123 +0,0 @@
-.. SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
-
-libperf tutorial
-================
-
-Compile and install libperf from kernel sources
-===============================================
-.. code-block:: bash
-
-  git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
-  cd linux/tools/perf/lib
-  make
-  sudo make install prefix=/usr
-
-Libperf object
-==============
-The libperf library provides several high level objects:
-
-struct perf_cpu_map
-  Provides a cpu list abstraction.
-
-struct perf_thread_map
-  Provides a thread list abstraction.
-
-struct perf_evsel
-  Provides an abstraction for single a perf event.
-
-struct perf_evlist
-  Gathers several struct perf_evsel object and performs functions on all of them.
-
-The exported API binds these objects together,
-for full reference see the libperf.7 man page.
-
-Examples
-========
-Examples aim to explain libperf functionality on simple use cases.
-They are based in on a checked out linux kernel git tree:
-
-.. code-block:: bash
-
-  $ cd tools/perf/lib/Documentation/tutorial/
-  $ ls -d  ex-*
-  ex-1-compile  ex-2-evsel-stat  ex-3-evlist-stat
-
-ex-1-compile example
-====================
-This example shows the basic usage of *struct perf_cpu_map*,
-how to create it and display its cpus:
-
-.. code-block:: bash
-
-  $ cd ex-1-compile/
-  $ make
-  gcc -o test test.c -lperf
-  $ ./test
-  0 1 2 3 4 5 6 7
-
-
-The full code listing is here:
-
-.. code-block:: c
-
-   1 #include <perf/cpumap.h>
-   2
-   3 int main(int argc, char **Argv)
-   4 {
-   5         struct perf_cpu_map *cpus;
-   6         int cpu, tmp;
-   7
-   8         cpus = perf_cpu_map__new(NULL);
-   9
-  10         perf_cpu_map__for_each_cpu(cpu, tmp, cpus)
-  11                 fprintf(stdout, "%d ", cpu);
-  12
-  13         fprintf(stdout, "\n");
-  14
-  15         perf_cpu_map__put(cpus);
-  16         return 0;
-  17 }
-
-
-First you need to include the proper header to have *struct perf_cpumap*
-declaration and functions:
-
-.. code-block:: c
-
-   1 #include <perf/cpumap.h>
-
-
-The *struct perf_cpumap* object is created by *perf_cpu_map__new* call.
-The *NULL* argument asks it to populate the object with the current online CPUs list:
-
-.. code-block:: c
-
-   8         cpus = perf_cpu_map__new(NULL);
-
-This is paired with a *perf_cpu_map__put*, that drops its reference at the end, possibly deleting it.
-
-.. code-block:: c
-
-  15         perf_cpu_map__put(cpus);
-
-The iteration through the *struct perf_cpumap* CPUs is done using the *perf_cpu_map__for_each_cpu*
-macro which requires 3 arguments:
-
-- cpu  - the cpu numer
-- tmp  - iteration helper variable
-- cpus - the *struct perf_cpumap* object
-
-.. code-block:: c
-
-  10         perf_cpu_map__for_each_cpu(cpu, tmp, cpus)
-  11                 fprintf(stdout, "%d ", cpu);
-
-ex-2-evsel-stat example
-=======================
-
-TBD
-
-ex-3-evlist-stat example
-========================
-
-TBD
diff --git a/tools/perf/lib/Makefile b/tools/perf/lib/Makefile
deleted file mode 100644
index 0f233638ef1f..000000000000
--- a/tools/perf/lib/Makefile
+++ /dev/null
@@ -1,188 +0,0 @@
-# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
-# Most of this file is copied from tools/lib/bpf/Makefile
-
-LIBPERF_VERSION = 0
-LIBPERF_PATCHLEVEL = 0
-LIBPERF_EXTRAVERSION = 1
-
-MAKEFLAGS += --no-print-directory
-
-ifeq ($(srctree),)
-srctree := $(patsubst %/,%,$(dir $(CURDIR)))
-srctree := $(patsubst %/,%,$(dir $(srctree)))
-srctree := $(patsubst %/,%,$(dir $(srctree)))
-#$(info Determined 'srctree' to be $(srctree))
-endif
-
-INSTALL = install
-
-# Use DESTDIR for installing into a different root directory.
-# This is useful for building a package. The program will be
-# installed in this directory as if it was the root directory.
-# Then the build tool can move it later.
-DESTDIR ?=
-DESTDIR_SQ = '$(subst ','\'',$(DESTDIR))'
-
-include $(srctree)/tools/scripts/Makefile.include
-include $(srctree)/tools/scripts/Makefile.arch
-
-ifeq ($(LP64), 1)
-  libdir_relative = lib64
-else
-  libdir_relative = lib
-endif
-
-prefix ?=
-libdir = $(prefix)/$(libdir_relative)
-
-# Shell quotes
-libdir_SQ = $(subst ','\'',$(libdir))
-libdir_relative_SQ = $(subst ','\'',$(libdir_relative))
-
-ifeq ("$(origin V)", "command line")
-  VERBOSE = $(V)
-endif
-ifndef VERBOSE
-  VERBOSE = 0
-endif
-
-ifeq ($(VERBOSE),1)
-  Q =
-else
-  Q = @
-endif
-
-# Set compile option CFLAGS
-ifdef EXTRA_CFLAGS
-  CFLAGS := $(EXTRA_CFLAGS)
-else
-  CFLAGS := -g -Wall
-endif
-
-INCLUDES = \
--I$(srctree)/tools/perf/lib/include \
--I$(srctree)/tools/lib/ \
--I$(srctree)/tools/include \
--I$(srctree)/tools/arch/$(SRCARCH)/include/ \
--I$(srctree)/tools/arch/$(SRCARCH)/include/uapi \
--I$(srctree)/tools/include/uapi
-
-# Append required CFLAGS
-override CFLAGS += $(EXTRA_WARNINGS)
-override CFLAGS += -Werror -Wall
-override CFLAGS += -fPIC
-override CFLAGS += $(INCLUDES)
-override CFLAGS += -fvisibility=hidden
-
-all:
-
-export srctree OUTPUT CC LD CFLAGS V
-export DESTDIR DESTDIR_SQ
-
-include $(srctree)/tools/build/Makefile.include
-
-VERSION_SCRIPT := libperf.map
-
-PATCHLEVEL    = $(LIBPERF_PATCHLEVEL)
-EXTRAVERSION  = $(LIBPERF_EXTRAVERSION)
-VERSION       = $(LIBPERF_VERSION).$(LIBPERF_PATCHLEVEL).$(LIBPERF_EXTRAVERSION)
-
-LIBPERF_SO := $(OUTPUT)libperf.so.$(VERSION)
-LIBPERF_A  := $(OUTPUT)libperf.a
-LIBPERF_IN := $(OUTPUT)libperf-in.o
-LIBPERF_PC := $(OUTPUT)libperf.pc
-
-LIBPERF_ALL := $(LIBPERF_A) $(OUTPUT)libperf.so*
-
-LIB_DIR := $(srctree)/tools/lib/api/
-
-ifneq ($(OUTPUT),)
-ifneq ($(subdir),)
-  API_PATH=$(OUTPUT)/../lib/api/
-else
-  API_PATH=$(OUTPUT)
-endif
-else
-  API_PATH=$(LIB_DIR)
-endif
-
-LIBAPI = $(API_PATH)libapi.a
-export LIBAPI
-
-$(LIBAPI): FORCE
-	$(Q)$(MAKE) -C $(LIB_DIR) O=$(OUTPUT) $(OUTPUT)libapi.a
-
-$(LIBAPI)-clean:
-	$(call QUIET_CLEAN, libapi)
-	$(Q)$(MAKE) -C $(LIB_DIR) O=$(OUTPUT) clean >/dev/null
-
-$(LIBPERF_IN): FORCE
-	$(Q)$(MAKE) $(build)=libperf
-
-$(LIBPERF_A): $(LIBPERF_IN)
-	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(LIBPERF_IN)
-
-$(LIBPERF_SO): $(LIBPERF_IN) $(LIBAPI)
-	$(QUIET_LINK)$(CC) --shared -Wl,-soname,libperf.so \
-                                    -Wl,--version-script=$(VERSION_SCRIPT) $^ -o $@
-	@ln -sf $(@F) $(OUTPUT)libperf.so
-	@ln -sf $(@F) $(OUTPUT)libperf.so.$(LIBPERF_VERSION)
-
-
-libs: $(LIBPERF_A) $(LIBPERF_SO) $(LIBPERF_PC)
-
-all: fixdep
-	$(Q)$(MAKE) libs
-
-clean: $(LIBAPI)-clean
-	$(call QUIET_CLEAN, libperf) $(RM) $(LIBPERF_A) \
-                *.o *~ *.a *.so *.so.$(VERSION) *.so.$(LIBPERF_VERSION) .*.d .*.cmd LIBPERF-CFLAGS $(LIBPERF_PC)
-	$(Q)$(MAKE) -C tests clean
-
-tests: libs
-	$(Q)$(MAKE) -C tests
-	$(Q)$(MAKE) -C tests run
-
-$(LIBPERF_PC):
-	$(QUIET_GEN)sed -e "s|@PREFIX@|$(prefix)|" \
-		-e "s|@LIBDIR@|$(libdir_SQ)|" \
-		-e "s|@VERSION@|$(VERSION)|" \
-		< libperf.pc.template > $@
-
-define do_install_mkdir
-	if [ ! -d '$(DESTDIR_SQ)$1' ]; then             \
-		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$1'; \
-	fi
-endef
-
-define do_install
-	if [ ! -d '$(DESTDIR_SQ)$2' ]; then             \
-		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$2'; \
-	fi;                                             \
-	$(INSTALL) $1 $(if $3,-m $3,) '$(DESTDIR_SQ)$2'
-endef
-
-install_lib: libs
-	$(call QUIET_INSTALL, $(LIBPERF_ALL)) \
-		$(call do_install_mkdir,$(libdir_SQ)); \
-		cp -fpR $(LIBPERF_ALL) $(DESTDIR)$(libdir_SQ)
-
-install_headers:
-	$(call QUIET_INSTALL, headers) \
-		$(call do_install,include/perf/core.h,$(prefix)/include/perf,644); \
-		$(call do_install,include/perf/cpumap.h,$(prefix)/include/perf,644); \
-		$(call do_install,include/perf/threadmap.h,$(prefix)/include/perf,644); \
-		$(call do_install,include/perf/evlist.h,$(prefix)/include/perf,644); \
-		$(call do_install,include/perf/evsel.h,$(prefix)/include/perf,644); \
-		$(call do_install,include/perf/event.h,$(prefix)/include/perf,644); \
-		$(call do_install,include/perf/mmap.h,$(prefix)/include/perf,644);
-
-install_pkgconfig: $(LIBPERF_PC)
-	$(call QUIET_INSTALL, $(LIBPERF_PC)) \
-		$(call do_install,$(LIBPERF_PC),$(libdir_SQ)/pkgconfig,644)
-
-install: install_lib install_headers install_pkgconfig
-
-FORCE:
-
-.PHONY: all install clean tests FORCE
diff --git a/tools/perf/lib/core.c b/tools/perf/lib/core.c
deleted file mode 100644
index 58fc894b76c5..000000000000
--- a/tools/perf/lib/core.c
+++ /dev/null
@@ -1,38 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-
-#define __printf(a, b)  __attribute__((format(printf, a, b)))
-
-#include <stdio.h>
-#include <stdarg.h>
-#include <unistd.h>
-#include <linux/compiler.h>
-#include <perf/core.h>
-#include <internal/lib.h>
-#include "internal.h"
-
-static int __base_pr(enum libperf_print_level level __maybe_unused, const char *format,
-		     va_list args)
-{
-	return vfprintf(stderr, format, args);
-}
-
-static libperf_print_fn_t __libperf_pr = __base_pr;
-
-__printf(2, 3)
-void libperf_print(enum libperf_print_level level, const char *format, ...)
-{
-	va_list args;
-
-	if (!__libperf_pr)
-		return;
-
-	va_start(args, format);
-	__libperf_pr(level, format, args);
-	va_end(args);
-}
-
-void libperf_init(libperf_print_fn_t fn)
-{
-	page_size = sysconf(_SC_PAGE_SIZE);
-	__libperf_pr = fn;
-}
diff --git a/tools/perf/lib/cpumap.c b/tools/perf/lib/cpumap.c
deleted file mode 100644
index f93f4e703e4c..000000000000
--- a/tools/perf/lib/cpumap.c
+++ /dev/null
@@ -1,345 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-#include <perf/cpumap.h>
-#include <stdlib.h>
-#include <linux/refcount.h>
-#include <internal/cpumap.h>
-#include <asm/bug.h>
-#include <stdio.h>
-#include <string.h>
-#include <unistd.h>
-#include <ctype.h>
-#include <limits.h>
-
-struct perf_cpu_map *perf_cpu_map__dummy_new(void)
-{
-	struct perf_cpu_map *cpus = malloc(sizeof(*cpus) + sizeof(int));
-
-	if (cpus != NULL) {
-		cpus->nr = 1;
-		cpus->map[0] = -1;
-		refcount_set(&cpus->refcnt, 1);
-	}
-
-	return cpus;
-}
-
-static void cpu_map__delete(struct perf_cpu_map *map)
-{
-	if (map) {
-		WARN_ONCE(refcount_read(&map->refcnt) != 0,
-			  "cpu_map refcnt unbalanced\n");
-		free(map);
-	}
-}
-
-struct perf_cpu_map *perf_cpu_map__get(struct perf_cpu_map *map)
-{
-	if (map)
-		refcount_inc(&map->refcnt);
-	return map;
-}
-
-void perf_cpu_map__put(struct perf_cpu_map *map)
-{
-	if (map && refcount_dec_and_test(&map->refcnt))
-		cpu_map__delete(map);
-}
-
-static struct perf_cpu_map *cpu_map__default_new(void)
-{
-	struct perf_cpu_map *cpus;
-	int nr_cpus;
-
-	nr_cpus = sysconf(_SC_NPROCESSORS_ONLN);
-	if (nr_cpus < 0)
-		return NULL;
-
-	cpus = malloc(sizeof(*cpus) + nr_cpus * sizeof(int));
-	if (cpus != NULL) {
-		int i;
-
-		for (i = 0; i < nr_cpus; ++i)
-			cpus->map[i] = i;
-
-		cpus->nr = nr_cpus;
-		refcount_set(&cpus->refcnt, 1);
-	}
-
-	return cpus;
-}
-
-static int cmp_int(const void *a, const void *b)
-{
-	return *(const int *)a - *(const int*)b;
-}
-
-static struct perf_cpu_map *cpu_map__trim_new(int nr_cpus, int *tmp_cpus)
-{
-	size_t payload_size = nr_cpus * sizeof(int);
-	struct perf_cpu_map *cpus = malloc(sizeof(*cpus) + payload_size);
-	int i, j;
-
-	if (cpus != NULL) {
-		memcpy(cpus->map, tmp_cpus, payload_size);
-		qsort(cpus->map, nr_cpus, sizeof(int), cmp_int);
-		/* Remove dups */
-		j = 0;
-		for (i = 0; i < nr_cpus; i++) {
-			if (i == 0 || cpus->map[i] != cpus->map[i - 1])
-				cpus->map[j++] = cpus->map[i];
-		}
-		cpus->nr = j;
-		assert(j <= nr_cpus);
-		refcount_set(&cpus->refcnt, 1);
-	}
-
-	return cpus;
-}
-
-struct perf_cpu_map *perf_cpu_map__read(FILE *file)
-{
-	struct perf_cpu_map *cpus = NULL;
-	int nr_cpus = 0;
-	int *tmp_cpus = NULL, *tmp;
-	int max_entries = 0;
-	int n, cpu, prev;
-	char sep;
-
-	sep = 0;
-	prev = -1;
-	for (;;) {
-		n = fscanf(file, "%u%c", &cpu, &sep);
-		if (n <= 0)
-			break;
-		if (prev >= 0) {
-			int new_max = nr_cpus + cpu - prev - 1;
-
-			WARN_ONCE(new_max >= MAX_NR_CPUS, "Perf can support %d CPUs. "
-							  "Consider raising MAX_NR_CPUS\n", MAX_NR_CPUS);
-
-			if (new_max >= max_entries) {
-				max_entries = new_max + MAX_NR_CPUS / 2;
-				tmp = realloc(tmp_cpus, max_entries * sizeof(int));
-				if (tmp == NULL)
-					goto out_free_tmp;
-				tmp_cpus = tmp;
-			}
-
-			while (++prev < cpu)
-				tmp_cpus[nr_cpus++] = prev;
-		}
-		if (nr_cpus == max_entries) {
-			max_entries += MAX_NR_CPUS;
-			tmp = realloc(tmp_cpus, max_entries * sizeof(int));
-			if (tmp == NULL)
-				goto out_free_tmp;
-			tmp_cpus = tmp;
-		}
-
-		tmp_cpus[nr_cpus++] = cpu;
-		if (n == 2 && sep == '-')
-			prev = cpu;
-		else
-			prev = -1;
-		if (n == 1 || sep == '\n')
-			break;
-	}
-
-	if (nr_cpus > 0)
-		cpus = cpu_map__trim_new(nr_cpus, tmp_cpus);
-	else
-		cpus = cpu_map__default_new();
-out_free_tmp:
-	free(tmp_cpus);
-	return cpus;
-}
-
-static struct perf_cpu_map *cpu_map__read_all_cpu_map(void)
-{
-	struct perf_cpu_map *cpus = NULL;
-	FILE *onlnf;
-
-	onlnf = fopen("/sys/devices/system/cpu/online", "r");
-	if (!onlnf)
-		return cpu_map__default_new();
-
-	cpus = perf_cpu_map__read(onlnf);
-	fclose(onlnf);
-	return cpus;
-}
-
-struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list)
-{
-	struct perf_cpu_map *cpus = NULL;
-	unsigned long start_cpu, end_cpu = 0;
-	char *p = NULL;
-	int i, nr_cpus = 0;
-	int *tmp_cpus = NULL, *tmp;
-	int max_entries = 0;
-
-	if (!cpu_list)
-		return cpu_map__read_all_cpu_map();
-
-	/*
-	 * must handle the case of empty cpumap to cover
-	 * TOPOLOGY header for NUMA nodes with no CPU
-	 * ( e.g., because of CPU hotplug)
-	 */
-	if (!isdigit(*cpu_list) && *cpu_list != '\0')
-		goto out;
-
-	while (isdigit(*cpu_list)) {
-		p = NULL;
-		start_cpu = strtoul(cpu_list, &p, 0);
-		if (start_cpu >= INT_MAX
-		    || (*p != '\0' && *p != ',' && *p != '-'))
-			goto invalid;
-
-		if (*p == '-') {
-			cpu_list = ++p;
-			p = NULL;
-			end_cpu = strtoul(cpu_list, &p, 0);
-
-			if (end_cpu >= INT_MAX || (*p != '\0' && *p != ','))
-				goto invalid;
-
-			if (end_cpu < start_cpu)
-				goto invalid;
-		} else {
-			end_cpu = start_cpu;
-		}
-
-		WARN_ONCE(end_cpu >= MAX_NR_CPUS, "Perf can support %d CPUs. "
-						  "Consider raising MAX_NR_CPUS\n", MAX_NR_CPUS);
-
-		for (; start_cpu <= end_cpu; start_cpu++) {
-			/* check for duplicates */
-			for (i = 0; i < nr_cpus; i++)
-				if (tmp_cpus[i] == (int)start_cpu)
-					goto invalid;
-
-			if (nr_cpus == max_entries) {
-				max_entries += MAX_NR_CPUS;
-				tmp = realloc(tmp_cpus, max_entries * sizeof(int));
-				if (tmp == NULL)
-					goto invalid;
-				tmp_cpus = tmp;
-			}
-			tmp_cpus[nr_cpus++] = (int)start_cpu;
-		}
-		if (*p)
-			++p;
-
-		cpu_list = p;
-	}
-
-	if (nr_cpus > 0)
-		cpus = cpu_map__trim_new(nr_cpus, tmp_cpus);
-	else if (*cpu_list != '\0')
-		cpus = cpu_map__default_new();
-	else
-		cpus = perf_cpu_map__dummy_new();
-invalid:
-	free(tmp_cpus);
-out:
-	return cpus;
-}
-
-int perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int idx)
-{
-	if (idx < cpus->nr)
-		return cpus->map[idx];
-
-	return -1;
-}
-
-int perf_cpu_map__nr(const struct perf_cpu_map *cpus)
-{
-	return cpus ? cpus->nr : 1;
-}
-
-bool perf_cpu_map__empty(const struct perf_cpu_map *map)
-{
-	return map ? map->map[0] == -1 : true;
-}
-
-int perf_cpu_map__idx(struct perf_cpu_map *cpus, int cpu)
-{
-	int i;
-
-	for (i = 0; i < cpus->nr; ++i) {
-		if (cpus->map[i] == cpu)
-			return i;
-	}
-
-	return -1;
-}
-
-int perf_cpu_map__max(struct perf_cpu_map *map)
-{
-	int i, max = -1;
-
-	for (i = 0; i < map->nr; i++) {
-		if (map->map[i] > max)
-			max = map->map[i];
-	}
-
-	return max;
-}
-
-/*
- * Merge two cpumaps
- *
- * orig either gets freed and replaced with a new map, or reused
- * with no reference count change (similar to "realloc")
- * other has its reference count increased.
- */
-
-struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
-					 struct perf_cpu_map *other)
-{
-	int *tmp_cpus;
-	int tmp_len;
-	int i, j, k;
-	struct perf_cpu_map *merged;
-
-	if (!orig && !other)
-		return NULL;
-	if (!orig) {
-		perf_cpu_map__get(other);
-		return other;
-	}
-	if (!other)
-		return orig;
-	if (orig->nr == other->nr &&
-	    !memcmp(orig->map, other->map, orig->nr * sizeof(int)))
-		return orig;
-
-	tmp_len = orig->nr + other->nr;
-	tmp_cpus = malloc(tmp_len * sizeof(int));
-	if (!tmp_cpus)
-		return NULL;
-
-	/* Standard merge algorithm from wikipedia */
-	i = j = k = 0;
-	while (i < orig->nr && j < other->nr) {
-		if (orig->map[i] <= other->map[j]) {
-			if (orig->map[i] == other->map[j])
-				j++;
-			tmp_cpus[k++] = orig->map[i++];
-		} else
-			tmp_cpus[k++] = other->map[j++];
-	}
-
-	while (i < orig->nr)
-		tmp_cpus[k++] = orig->map[i++];
-
-	while (j < other->nr)
-		tmp_cpus[k++] = other->map[j++];
-	assert(k <= tmp_len);
-
-	merged = cpu_map__trim_new(k, tmp_cpus);
-	free(tmp_cpus);
-	perf_cpu_map__put(orig);
-	return merged;
-}
diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
deleted file mode 100644
index ae9e65aa2491..000000000000
--- a/tools/perf/lib/evlist.c
+++ /dev/null
@@ -1,641 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <perf/evlist.h>
-#include <perf/evsel.h>
-#include <linux/bitops.h>
-#include <linux/list.h>
-#include <linux/hash.h>
-#include <sys/ioctl.h>
-#include <internal/evlist.h>
-#include <internal/evsel.h>
-#include <internal/xyarray.h>
-#include <internal/mmap.h>
-#include <internal/cpumap.h>
-#include <internal/threadmap.h>
-#include <internal/xyarray.h>
-#include <internal/lib.h>
-#include <linux/zalloc.h>
-#include <sys/ioctl.h>
-#include <stdlib.h>
-#include <errno.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <signal.h>
-#include <poll.h>
-#include <sys/mman.h>
-#include <perf/cpumap.h>
-#include <perf/threadmap.h>
-#include <api/fd/array.h>
-
-void perf_evlist__init(struct perf_evlist *evlist)
-{
-	int i;
-
-	for (i = 0; i < PERF_EVLIST__HLIST_SIZE; ++i)
-		INIT_HLIST_HEAD(&evlist->heads[i]);
-	INIT_LIST_HEAD(&evlist->entries);
-	evlist->nr_entries = 0;
-	fdarray__init(&evlist->pollfd, 64);
-}
-
-static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
-					  struct perf_evsel *evsel)
-{
-	/*
-	 * We already have cpus for evsel (via PMU sysfs) so
-	 * keep it, if there's no target cpu list defined.
-	 */
-	if (!evsel->own_cpus || evlist->has_user_cpus) {
-		perf_cpu_map__put(evsel->cpus);
-		evsel->cpus = perf_cpu_map__get(evlist->cpus);
-	} else if (evsel->cpus != evsel->own_cpus) {
-		perf_cpu_map__put(evsel->cpus);
-		evsel->cpus = perf_cpu_map__get(evsel->own_cpus);
-	}
-
-	perf_thread_map__put(evsel->threads);
-	evsel->threads = perf_thread_map__get(evlist->threads);
-	evlist->all_cpus = perf_cpu_map__merge(evlist->all_cpus, evsel->cpus);
-}
-
-static void perf_evlist__propagate_maps(struct perf_evlist *evlist)
-{
-	struct perf_evsel *evsel;
-
-	perf_evlist__for_each_evsel(evlist, evsel)
-		__perf_evlist__propagate_maps(evlist, evsel);
-}
-
-void perf_evlist__add(struct perf_evlist *evlist,
-		      struct perf_evsel *evsel)
-{
-	list_add_tail(&evsel->node, &evlist->entries);
-	evlist->nr_entries += 1;
-	__perf_evlist__propagate_maps(evlist, evsel);
-}
-
-void perf_evlist__remove(struct perf_evlist *evlist,
-			 struct perf_evsel *evsel)
-{
-	list_del_init(&evsel->node);
-	evlist->nr_entries -= 1;
-}
-
-struct perf_evlist *perf_evlist__new(void)
-{
-	struct perf_evlist *evlist = zalloc(sizeof(*evlist));
-
-	if (evlist != NULL)
-		perf_evlist__init(evlist);
-
-	return evlist;
-}
-
-struct perf_evsel *
-perf_evlist__next(struct perf_evlist *evlist, struct perf_evsel *prev)
-{
-	struct perf_evsel *next;
-
-	if (!prev) {
-		next = list_first_entry(&evlist->entries,
-					struct perf_evsel,
-					node);
-	} else {
-		next = list_next_entry(prev, node);
-	}
-
-	/* Empty list is noticed here so don't need checking on entry. */
-	if (&next->node == &evlist->entries)
-		return NULL;
-
-	return next;
-}
-
-static void perf_evlist__purge(struct perf_evlist *evlist)
-{
-	struct perf_evsel *pos, *n;
-
-	perf_evlist__for_each_entry_safe(evlist, n, pos) {
-		list_del_init(&pos->node);
-		perf_evsel__delete(pos);
-	}
-
-	evlist->nr_entries = 0;
-}
-
-void perf_evlist__exit(struct perf_evlist *evlist)
-{
-	perf_cpu_map__put(evlist->cpus);
-	perf_thread_map__put(evlist->threads);
-	evlist->cpus = NULL;
-	evlist->threads = NULL;
-	fdarray__exit(&evlist->pollfd);
-}
-
-void perf_evlist__delete(struct perf_evlist *evlist)
-{
-	if (evlist == NULL)
-		return;
-
-	perf_evlist__munmap(evlist);
-	perf_evlist__close(evlist);
-	perf_evlist__purge(evlist);
-	perf_evlist__exit(evlist);
-	free(evlist);
-}
-
-void perf_evlist__set_maps(struct perf_evlist *evlist,
-			   struct perf_cpu_map *cpus,
-			   struct perf_thread_map *threads)
-{
-	/*
-	 * Allow for the possibility that one or another of the maps isn't being
-	 * changed i.e. don't put it.  Note we are assuming the maps that are
-	 * being applied are brand new and evlist is taking ownership of the
-	 * original reference count of 1.  If that is not the case it is up to
-	 * the caller to increase the reference count.
-	 */
-	if (cpus != evlist->cpus) {
-		perf_cpu_map__put(evlist->cpus);
-		evlist->cpus = perf_cpu_map__get(cpus);
-	}
-
-	if (threads != evlist->threads) {
-		perf_thread_map__put(evlist->threads);
-		evlist->threads = perf_thread_map__get(threads);
-	}
-
-	perf_evlist__propagate_maps(evlist);
-}
-
-int perf_evlist__open(struct perf_evlist *evlist)
-{
-	struct perf_evsel *evsel;
-	int err;
-
-	perf_evlist__for_each_entry(evlist, evsel) {
-		err = perf_evsel__open(evsel, evsel->cpus, evsel->threads);
-		if (err < 0)
-			goto out_err;
-	}
-
-	return 0;
-
-out_err:
-	perf_evlist__close(evlist);
-	return err;
-}
-
-void perf_evlist__close(struct perf_evlist *evlist)
-{
-	struct perf_evsel *evsel;
-
-	perf_evlist__for_each_entry_reverse(evlist, evsel)
-		perf_evsel__close(evsel);
-}
-
-void perf_evlist__enable(struct perf_evlist *evlist)
-{
-	struct perf_evsel *evsel;
-
-	perf_evlist__for_each_entry(evlist, evsel)
-		perf_evsel__enable(evsel);
-}
-
-void perf_evlist__disable(struct perf_evlist *evlist)
-{
-	struct perf_evsel *evsel;
-
-	perf_evlist__for_each_entry(evlist, evsel)
-		perf_evsel__disable(evsel);
-}
-
-u64 perf_evlist__read_format(struct perf_evlist *evlist)
-{
-	struct perf_evsel *first = perf_evlist__first(evlist);
-
-	return first->attr.read_format;
-}
-
-#define SID(e, x, y) xyarray__entry(e->sample_id, x, y)
-
-static void perf_evlist__id_hash(struct perf_evlist *evlist,
-				 struct perf_evsel *evsel,
-				 int cpu, int thread, u64 id)
-{
-	int hash;
-	struct perf_sample_id *sid = SID(evsel, cpu, thread);
-
-	sid->id = id;
-	sid->evsel = evsel;
-	hash = hash_64(sid->id, PERF_EVLIST__HLIST_BITS);
-	hlist_add_head(&sid->node, &evlist->heads[hash]);
-}
-
-void perf_evlist__id_add(struct perf_evlist *evlist,
-			 struct perf_evsel *evsel,
-			 int cpu, int thread, u64 id)
-{
-	perf_evlist__id_hash(evlist, evsel, cpu, thread, id);
-	evsel->id[evsel->ids++] = id;
-}
-
-int perf_evlist__id_add_fd(struct perf_evlist *evlist,
-			   struct perf_evsel *evsel,
-			   int cpu, int thread, int fd)
-{
-	u64 read_data[4] = { 0, };
-	int id_idx = 1; /* The first entry is the counter value */
-	u64 id;
-	int ret;
-
-	ret = ioctl(fd, PERF_EVENT_IOC_ID, &id);
-	if (!ret)
-		goto add;
-
-	if (errno != ENOTTY)
-		return -1;
-
-	/* Legacy way to get event id.. All hail to old kernels! */
-
-	/*
-	 * This way does not work with group format read, so bail
-	 * out in that case.
-	 */
-	if (perf_evlist__read_format(evlist) & PERF_FORMAT_GROUP)
-		return -1;
-
-	if (!(evsel->attr.read_format & PERF_FORMAT_ID) ||
-	    read(fd, &read_data, sizeof(read_data)) == -1)
-		return -1;
-
-	if (evsel->attr.read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
-		++id_idx;
-	if (evsel->attr.read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
-		++id_idx;
-
-	id = read_data[id_idx];
-
-add:
-	perf_evlist__id_add(evlist, evsel, cpu, thread, id);
-	return 0;
-}
-
-int perf_evlist__alloc_pollfd(struct perf_evlist *evlist)
-{
-	int nr_cpus = perf_cpu_map__nr(evlist->cpus);
-	int nr_threads = perf_thread_map__nr(evlist->threads);
-	int nfds = 0;
-	struct perf_evsel *evsel;
-
-	perf_evlist__for_each_entry(evlist, evsel) {
-		if (evsel->system_wide)
-			nfds += nr_cpus;
-		else
-			nfds += nr_cpus * nr_threads;
-	}
-
-	if (fdarray__available_entries(&evlist->pollfd) < nfds &&
-	    fdarray__grow(&evlist->pollfd, nfds) < 0)
-		return -ENOMEM;
-
-	return 0;
-}
-
-int perf_evlist__add_pollfd(struct perf_evlist *evlist, int fd,
-			    void *ptr, short revent)
-{
-	int pos = fdarray__add(&evlist->pollfd, fd, revent | POLLERR | POLLHUP);
-
-	if (pos >= 0) {
-		evlist->pollfd.priv[pos].ptr = ptr;
-		fcntl(fd, F_SETFL, O_NONBLOCK);
-	}
-
-	return pos;
-}
-
-static void perf_evlist__munmap_filtered(struct fdarray *fda, int fd,
-					 void *arg __maybe_unused)
-{
-	struct perf_mmap *map = fda->priv[fd].ptr;
-
-	if (map)
-		perf_mmap__put(map);
-}
-
-int perf_evlist__filter_pollfd(struct perf_evlist *evlist, short revents_and_mask)
-{
-	return fdarray__filter(&evlist->pollfd, revents_and_mask,
-			       perf_evlist__munmap_filtered, NULL);
-}
-
-int perf_evlist__poll(struct perf_evlist *evlist, int timeout)
-{
-	return fdarray__poll(&evlist->pollfd, timeout);
-}
-
-static struct perf_mmap* perf_evlist__alloc_mmap(struct perf_evlist *evlist, bool overwrite)
-{
-	int i;
-	struct perf_mmap *map;
-
-	map = zalloc(evlist->nr_mmaps * sizeof(struct perf_mmap));
-	if (!map)
-		return NULL;
-
-	for (i = 0; i < evlist->nr_mmaps; i++) {
-		struct perf_mmap *prev = i ? &map[i - 1] : NULL;
-
-		/*
-		 * When the perf_mmap() call is made we grab one refcount, plus
-		 * one extra to let perf_mmap__consume() get the last
-		 * events after all real references (perf_mmap__get()) are
-		 * dropped.
-		 *
-		 * Each PERF_EVENT_IOC_SET_OUTPUT points to this mmap and
-		 * thus does perf_mmap__get() on it.
-		 */
-		perf_mmap__init(&map[i], prev, overwrite, NULL);
-	}
-
-	return map;
-}
-
-static void perf_evlist__set_sid_idx(struct perf_evlist *evlist,
-				     struct perf_evsel *evsel, int idx, int cpu,
-				     int thread)
-{
-	struct perf_sample_id *sid = SID(evsel, cpu, thread);
-
-	sid->idx = idx;
-	if (evlist->cpus && cpu >= 0)
-		sid->cpu = evlist->cpus->map[cpu];
-	else
-		sid->cpu = -1;
-	if (!evsel->system_wide && evlist->threads && thread >= 0)
-		sid->tid = perf_thread_map__pid(evlist->threads, thread);
-	else
-		sid->tid = -1;
-}
-
-static struct perf_mmap*
-perf_evlist__mmap_cb_get(struct perf_evlist *evlist, bool overwrite, int idx)
-{
-	struct perf_mmap *maps;
-
-	maps = overwrite ? evlist->mmap_ovw : evlist->mmap;
-
-	if (!maps) {
-		maps = perf_evlist__alloc_mmap(evlist, overwrite);
-		if (!maps)
-			return NULL;
-
-		if (overwrite)
-			evlist->mmap_ovw = maps;
-		else
-			evlist->mmap = maps;
-	}
-
-	return &maps[idx];
-}
-
-#define FD(e, x, y) (*(int *) xyarray__entry(e->fd, x, y))
-
-static int
-perf_evlist__mmap_cb_mmap(struct perf_mmap *map, struct perf_mmap_param *mp,
-			  int output, int cpu)
-{
-	return perf_mmap__mmap(map, mp, output, cpu);
-}
-
-static void perf_evlist__set_mmap_first(struct perf_evlist *evlist, struct perf_mmap *map,
-					bool overwrite)
-{
-	if (overwrite)
-		evlist->mmap_ovw_first = map;
-	else
-		evlist->mmap_first = map;
-}
-
-static int
-mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
-	       int idx, struct perf_mmap_param *mp, int cpu_idx,
-	       int thread, int *_output, int *_output_overwrite)
-{
-	int evlist_cpu = perf_cpu_map__cpu(evlist->cpus, cpu_idx);
-	struct perf_evsel *evsel;
-	int revent;
-
-	perf_evlist__for_each_entry(evlist, evsel) {
-		bool overwrite = evsel->attr.write_backward;
-		struct perf_mmap *map;
-		int *output, fd, cpu;
-
-		if (evsel->system_wide && thread)
-			continue;
-
-		cpu = perf_cpu_map__idx(evsel->cpus, evlist_cpu);
-		if (cpu == -1)
-			continue;
-
-		map = ops->get(evlist, overwrite, idx);
-		if (map == NULL)
-			return -ENOMEM;
-
-		if (overwrite) {
-			mp->prot = PROT_READ;
-			output   = _output_overwrite;
-		} else {
-			mp->prot = PROT_READ | PROT_WRITE;
-			output   = _output;
-		}
-
-		fd = FD(evsel, cpu, thread);
-
-		if (*output == -1) {
-			*output = fd;
-
-			/*
-			 * The last one will be done at perf_mmap__consume(), so that we
-			 * make sure we don't prevent tools from consuming every last event in
-			 * the ring buffer.
-			 *
-			 * I.e. we can get the POLLHUP meaning that the fd doesn't exist
-			 * anymore, but the last events for it are still in the ring buffer,
-			 * waiting to be consumed.
-			 *
-			 * Tools can chose to ignore this at their own discretion, but the
-			 * evlist layer can't just drop it when filtering events in
-			 * perf_evlist__filter_pollfd().
-			 */
-			refcount_set(&map->refcnt, 2);
-
-			if (ops->mmap(map, mp, *output, evlist_cpu) < 0)
-				return -1;
-
-			if (!idx)
-				perf_evlist__set_mmap_first(evlist, map, overwrite);
-		} else {
-			if (ioctl(fd, PERF_EVENT_IOC_SET_OUTPUT, *output) != 0)
-				return -1;
-
-			perf_mmap__get(map);
-		}
-
-		revent = !overwrite ? POLLIN : 0;
-
-		if (!evsel->system_wide &&
-		    perf_evlist__add_pollfd(evlist, fd, map, revent) < 0) {
-			perf_mmap__put(map);
-			return -1;
-		}
-
-		if (evsel->attr.read_format & PERF_FORMAT_ID) {
-			if (perf_evlist__id_add_fd(evlist, evsel, cpu, thread,
-						   fd) < 0)
-				return -1;
-			perf_evlist__set_sid_idx(evlist, evsel, idx, cpu,
-						 thread);
-		}
-	}
-
-	return 0;
-}
-
-static int
-mmap_per_thread(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
-		struct perf_mmap_param *mp)
-{
-	int thread;
-	int nr_threads = perf_thread_map__nr(evlist->threads);
-
-	for (thread = 0; thread < nr_threads; thread++) {
-		int output = -1;
-		int output_overwrite = -1;
-
-		if (ops->idx)
-			ops->idx(evlist, mp, thread, false);
-
-		if (mmap_per_evsel(evlist, ops, thread, mp, 0, thread,
-				   &output, &output_overwrite))
-			goto out_unmap;
-	}
-
-	return 0;
-
-out_unmap:
-	perf_evlist__munmap(evlist);
-	return -1;
-}
-
-static int
-mmap_per_cpu(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
-	     struct perf_mmap_param *mp)
-{
-	int nr_threads = perf_thread_map__nr(evlist->threads);
-	int nr_cpus    = perf_cpu_map__nr(evlist->cpus);
-	int cpu, thread;
-
-	for (cpu = 0; cpu < nr_cpus; cpu++) {
-		int output = -1;
-		int output_overwrite = -1;
-
-		if (ops->idx)
-			ops->idx(evlist, mp, cpu, true);
-
-		for (thread = 0; thread < nr_threads; thread++) {
-			if (mmap_per_evsel(evlist, ops, cpu, mp, cpu,
-					   thread, &output, &output_overwrite))
-				goto out_unmap;
-		}
-	}
-
-	return 0;
-
-out_unmap:
-	perf_evlist__munmap(evlist);
-	return -1;
-}
-
-static int perf_evlist__nr_mmaps(struct perf_evlist *evlist)
-{
-	int nr_mmaps;
-
-	nr_mmaps = perf_cpu_map__nr(evlist->cpus);
-	if (perf_cpu_map__empty(evlist->cpus))
-		nr_mmaps = perf_thread_map__nr(evlist->threads);
-
-	return nr_mmaps;
-}
-
-int perf_evlist__mmap_ops(struct perf_evlist *evlist,
-			  struct perf_evlist_mmap_ops *ops,
-			  struct perf_mmap_param *mp)
-{
-	struct perf_evsel *evsel;
-	const struct perf_cpu_map *cpus = evlist->cpus;
-	const struct perf_thread_map *threads = evlist->threads;
-
-	if (!ops || !ops->get || !ops->mmap)
-		return -EINVAL;
-
-	mp->mask = evlist->mmap_len - page_size - 1;
-
-	evlist->nr_mmaps = perf_evlist__nr_mmaps(evlist);
-
-	perf_evlist__for_each_entry(evlist, evsel) {
-		if ((evsel->attr.read_format & PERF_FORMAT_ID) &&
-		    evsel->sample_id == NULL &&
-		    perf_evsel__alloc_id(evsel, perf_cpu_map__nr(cpus), threads->nr) < 0)
-			return -ENOMEM;
-	}
-
-	if (evlist->pollfd.entries == NULL && perf_evlist__alloc_pollfd(evlist) < 0)
-		return -ENOMEM;
-
-	if (perf_cpu_map__empty(cpus))
-		return mmap_per_thread(evlist, ops, mp);
-
-	return mmap_per_cpu(evlist, ops, mp);
-}
-
-int perf_evlist__mmap(struct perf_evlist *evlist, int pages)
-{
-	struct perf_mmap_param mp;
-	struct perf_evlist_mmap_ops ops = {
-		.get  = perf_evlist__mmap_cb_get,
-		.mmap = perf_evlist__mmap_cb_mmap,
-	};
-
-	evlist->mmap_len = (pages + 1) * page_size;
-
-	return perf_evlist__mmap_ops(evlist, &ops, &mp);
-}
-
-void perf_evlist__munmap(struct perf_evlist *evlist)
-{
-	int i;
-
-	if (evlist->mmap) {
-		for (i = 0; i < evlist->nr_mmaps; i++)
-			perf_mmap__munmap(&evlist->mmap[i]);
-	}
-
-	if (evlist->mmap_ovw) {
-		for (i = 0; i < evlist->nr_mmaps; i++)
-			perf_mmap__munmap(&evlist->mmap_ovw[i]);
-	}
-
-	zfree(&evlist->mmap);
-	zfree(&evlist->mmap_ovw);
-}
-
-struct perf_mmap*
-perf_evlist__next_mmap(struct perf_evlist *evlist, struct perf_mmap *map,
-		       bool overwrite)
-{
-	if (map)
-		return map->next;
-
-	return overwrite ? evlist->mmap_ovw_first : evlist->mmap_first;
-}
diff --git a/tools/perf/lib/evsel.c b/tools/perf/lib/evsel.c
deleted file mode 100644
index 4dc06289f4c7..000000000000
--- a/tools/perf/lib/evsel.c
+++ /dev/null
@@ -1,301 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <errno.h>
-#include <unistd.h>
-#include <sys/syscall.h>
-#include <perf/evsel.h>
-#include <perf/cpumap.h>
-#include <perf/threadmap.h>
-#include <linux/list.h>
-#include <internal/evsel.h>
-#include <linux/zalloc.h>
-#include <stdlib.h>
-#include <internal/xyarray.h>
-#include <internal/cpumap.h>
-#include <internal/threadmap.h>
-#include <internal/lib.h>
-#include <linux/string.h>
-#include <sys/ioctl.h>
-
-void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr)
-{
-	INIT_LIST_HEAD(&evsel->node);
-	evsel->attr = *attr;
-}
-
-struct perf_evsel *perf_evsel__new(struct perf_event_attr *attr)
-{
-	struct perf_evsel *evsel = zalloc(sizeof(*evsel));
-
-	if (evsel != NULL)
-		perf_evsel__init(evsel, attr);
-
-	return evsel;
-}
-
-void perf_evsel__delete(struct perf_evsel *evsel)
-{
-	free(evsel);
-}
-
-#define FD(e, x, y) (*(int *) xyarray__entry(e->fd, x, y))
-
-int perf_evsel__alloc_fd(struct perf_evsel *evsel, int ncpus, int nthreads)
-{
-	evsel->fd = xyarray__new(ncpus, nthreads, sizeof(int));
-
-	if (evsel->fd) {
-		int cpu, thread;
-		for (cpu = 0; cpu < ncpus; cpu++) {
-			for (thread = 0; thread < nthreads; thread++) {
-				FD(evsel, cpu, thread) = -1;
-			}
-		}
-	}
-
-	return evsel->fd != NULL ? 0 : -ENOMEM;
-}
-
-static int
-sys_perf_event_open(struct perf_event_attr *attr,
-		    pid_t pid, int cpu, int group_fd,
-		    unsigned long flags)
-{
-	return syscall(__NR_perf_event_open, attr, pid, cpu, group_fd, flags);
-}
-
-int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
-		     struct perf_thread_map *threads)
-{
-	int cpu, thread, err = 0;
-
-	if (cpus == NULL) {
-		static struct perf_cpu_map *empty_cpu_map;
-
-		if (empty_cpu_map == NULL) {
-			empty_cpu_map = perf_cpu_map__dummy_new();
-			if (empty_cpu_map == NULL)
-				return -ENOMEM;
-		}
-
-		cpus = empty_cpu_map;
-	}
-
-	if (threads == NULL) {
-		static struct perf_thread_map *empty_thread_map;
-
-		if (empty_thread_map == NULL) {
-			empty_thread_map = perf_thread_map__new_dummy();
-			if (empty_thread_map == NULL)
-				return -ENOMEM;
-		}
-
-		threads = empty_thread_map;
-	}
-
-	if (evsel->fd == NULL &&
-	    perf_evsel__alloc_fd(evsel, cpus->nr, threads->nr) < 0)
-		return -ENOMEM;
-
-	for (cpu = 0; cpu < cpus->nr; cpu++) {
-		for (thread = 0; thread < threads->nr; thread++) {
-			int fd;
-
-			fd = sys_perf_event_open(&evsel->attr,
-						 threads->map[thread].pid,
-						 cpus->map[cpu], -1, 0);
-
-			if (fd < 0)
-				return -errno;
-
-			FD(evsel, cpu, thread) = fd;
-		}
-	}
-
-	return err;
-}
-
-static void perf_evsel__close_fd_cpu(struct perf_evsel *evsel, int cpu)
-{
-	int thread;
-
-	for (thread = 0; thread < xyarray__max_y(evsel->fd); ++thread) {
-		if (FD(evsel, cpu, thread) >= 0)
-			close(FD(evsel, cpu, thread));
-		FD(evsel, cpu, thread) = -1;
-	}
-}
-
-void perf_evsel__close_fd(struct perf_evsel *evsel)
-{
-	int cpu;
-
-	for (cpu = 0; cpu < xyarray__max_x(evsel->fd); cpu++)
-		perf_evsel__close_fd_cpu(evsel, cpu);
-}
-
-void perf_evsel__free_fd(struct perf_evsel *evsel)
-{
-	xyarray__delete(evsel->fd);
-	evsel->fd = NULL;
-}
-
-void perf_evsel__close(struct perf_evsel *evsel)
-{
-	if (evsel->fd == NULL)
-		return;
-
-	perf_evsel__close_fd(evsel);
-	perf_evsel__free_fd(evsel);
-}
-
-void perf_evsel__close_cpu(struct perf_evsel *evsel, int cpu)
-{
-	if (evsel->fd == NULL)
-		return;
-
-	perf_evsel__close_fd_cpu(evsel, cpu);
-}
-
-int perf_evsel__read_size(struct perf_evsel *evsel)
-{
-	u64 read_format = evsel->attr.read_format;
-	int entry = sizeof(u64); /* value */
-	int size = 0;
-	int nr = 1;
-
-	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
-		size += sizeof(u64);
-
-	if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
-		size += sizeof(u64);
-
-	if (read_format & PERF_FORMAT_ID)
-		entry += sizeof(u64);
-
-	if (read_format & PERF_FORMAT_GROUP) {
-		nr = evsel->nr_members;
-		size += sizeof(u64);
-	}
-
-	size += entry * nr;
-	return size;
-}
-
-int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
-		     struct perf_counts_values *count)
-{
-	size_t size = perf_evsel__read_size(evsel);
-
-	memset(count, 0, sizeof(*count));
-
-	if (FD(evsel, cpu, thread) < 0)
-		return -EINVAL;
-
-	if (readn(FD(evsel, cpu, thread), count->values, size) <= 0)
-		return -errno;
-
-	return 0;
-}
-
-static int perf_evsel__run_ioctl(struct perf_evsel *evsel,
-				 int ioc,  void *arg,
-				 int cpu)
-{
-	int thread;
-
-	for (thread = 0; thread < xyarray__max_y(evsel->fd); thread++) {
-		int fd = FD(evsel, cpu, thread),
-		    err = ioctl(fd, ioc, arg);
-
-		if (err)
-			return err;
-	}
-
-	return 0;
-}
-
-int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu)
-{
-	return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, NULL, cpu);
-}
-
-int perf_evsel__enable(struct perf_evsel *evsel)
-{
-	int i;
-	int err = 0;
-
-	for (i = 0; i < xyarray__max_x(evsel->fd) && !err; i++)
-		err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, NULL, i);
-	return err;
-}
-
-int perf_evsel__disable_cpu(struct perf_evsel *evsel, int cpu)
-{
-	return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_DISABLE, NULL, cpu);
-}
-
-int perf_evsel__disable(struct perf_evsel *evsel)
-{
-	int i;
-	int err = 0;
-
-	for (i = 0; i < xyarray__max_x(evsel->fd) && !err; i++)
-		err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_DISABLE, NULL, i);
-	return err;
-}
-
-int perf_evsel__apply_filter(struct perf_evsel *evsel, const char *filter)
-{
-	int err = 0, i;
-
-	for (i = 0; i < evsel->cpus->nr && !err; i++)
-		err = perf_evsel__run_ioctl(evsel,
-				     PERF_EVENT_IOC_SET_FILTER,
-				     (void *)filter, i);
-	return err;
-}
-
-struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel)
-{
-	return evsel->cpus;
-}
-
-struct perf_thread_map *perf_evsel__threads(struct perf_evsel *evsel)
-{
-	return evsel->threads;
-}
-
-struct perf_event_attr *perf_evsel__attr(struct perf_evsel *evsel)
-{
-	return &evsel->attr;
-}
-
-int perf_evsel__alloc_id(struct perf_evsel *evsel, int ncpus, int nthreads)
-{
-	if (ncpus == 0 || nthreads == 0)
-		return 0;
-
-	if (evsel->system_wide)
-		nthreads = 1;
-
-	evsel->sample_id = xyarray__new(ncpus, nthreads, sizeof(struct perf_sample_id));
-	if (evsel->sample_id == NULL)
-		return -ENOMEM;
-
-	evsel->id = zalloc(ncpus * nthreads * sizeof(u64));
-	if (evsel->id == NULL) {
-		xyarray__delete(evsel->sample_id);
-		evsel->sample_id = NULL;
-		return -ENOMEM;
-	}
-
-	return 0;
-}
-
-void perf_evsel__free_id(struct perf_evsel *evsel)
-{
-	xyarray__delete(evsel->sample_id);
-	evsel->sample_id = NULL;
-	zfree(&evsel->id);
-	evsel->ids = 0;
-}
diff --git a/tools/perf/lib/include/internal/cpumap.h b/tools/perf/lib/include/internal/cpumap.h
deleted file mode 100644
index 840d4032587b..000000000000
--- a/tools/perf/lib/include/internal/cpumap.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __LIBPERF_INTERNAL_CPUMAP_H
-#define __LIBPERF_INTERNAL_CPUMAP_H
-
-#include <linux/refcount.h>
-
-struct perf_cpu_map {
-	refcount_t	refcnt;
-	int		nr;
-	int		map[];
-};
-
-#ifndef MAX_NR_CPUS
-#define MAX_NR_CPUS	2048
-#endif
-
-int perf_cpu_map__idx(struct perf_cpu_map *cpus, int cpu);
-
-#endif /* __LIBPERF_INTERNAL_CPUMAP_H */
diff --git a/tools/perf/lib/include/internal/evlist.h b/tools/perf/lib/include/internal/evlist.h
deleted file mode 100644
index 74dc8c3f0b66..000000000000
--- a/tools/perf/lib/include/internal/evlist.h
+++ /dev/null
@@ -1,127 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __LIBPERF_INTERNAL_EVLIST_H
-#define __LIBPERF_INTERNAL_EVLIST_H
-
-#include <linux/list.h>
-#include <api/fd/array.h>
-#include <internal/evsel.h>
-
-#define PERF_EVLIST__HLIST_BITS 8
-#define PERF_EVLIST__HLIST_SIZE (1 << PERF_EVLIST__HLIST_BITS)
-
-struct perf_cpu_map;
-struct perf_thread_map;
-struct perf_mmap_param;
-
-struct perf_evlist {
-	struct list_head	 entries;
-	int			 nr_entries;
-	bool			 has_user_cpus;
-	struct perf_cpu_map	*cpus;
-	struct perf_cpu_map	*all_cpus;
-	struct perf_thread_map	*threads;
-	int			 nr_mmaps;
-	size_t			 mmap_len;
-	struct fdarray		 pollfd;
-	struct hlist_head	 heads[PERF_EVLIST__HLIST_SIZE];
-	struct perf_mmap	*mmap;
-	struct perf_mmap	*mmap_ovw;
-	struct perf_mmap	*mmap_first;
-	struct perf_mmap	*mmap_ovw_first;
-};
-
-typedef void
-(*perf_evlist_mmap__cb_idx_t)(struct perf_evlist*, struct perf_mmap_param*, int, bool);
-typedef struct perf_mmap*
-(*perf_evlist_mmap__cb_get_t)(struct perf_evlist*, bool, int);
-typedef int
-(*perf_evlist_mmap__cb_mmap_t)(struct perf_mmap*, struct perf_mmap_param*, int, int);
-
-struct perf_evlist_mmap_ops {
-	perf_evlist_mmap__cb_idx_t	idx;
-	perf_evlist_mmap__cb_get_t	get;
-	perf_evlist_mmap__cb_mmap_t	mmap;
-};
-
-int perf_evlist__alloc_pollfd(struct perf_evlist *evlist);
-int perf_evlist__add_pollfd(struct perf_evlist *evlist, int fd,
-			    void *ptr, short revent);
-
-int perf_evlist__mmap_ops(struct perf_evlist *evlist,
-			  struct perf_evlist_mmap_ops *ops,
-			  struct perf_mmap_param *mp);
-
-void perf_evlist__init(struct perf_evlist *evlist);
-void perf_evlist__exit(struct perf_evlist *evlist);
-
-/**
- * __perf_evlist__for_each_entry - iterate thru all the evsels
- * @list: list_head instance to iterate
- * @evsel: struct perf_evsel iterator
- */
-#define __perf_evlist__for_each_entry(list, evsel) \
-	list_for_each_entry(evsel, list, node)
-
-/**
- * evlist__for_each_entry - iterate thru all the evsels
- * @evlist: perf_evlist instance to iterate
- * @evsel: struct perf_evsel iterator
- */
-#define perf_evlist__for_each_entry(evlist, evsel) \
-	__perf_evlist__for_each_entry(&(evlist)->entries, evsel)
-
-/**
- * __perf_evlist__for_each_entry_reverse - iterate thru all the evsels in reverse order
- * @list: list_head instance to iterate
- * @evsel: struct evsel iterator
- */
-#define __perf_evlist__for_each_entry_reverse(list, evsel) \
-	list_for_each_entry_reverse(evsel, list, node)
-
-/**
- * perf_evlist__for_each_entry_reverse - iterate thru all the evsels in reverse order
- * @evlist: evlist instance to iterate
- * @evsel: struct evsel iterator
- */
-#define perf_evlist__for_each_entry_reverse(evlist, evsel) \
-	__perf_evlist__for_each_entry_reverse(&(evlist)->entries, evsel)
-
-/**
- * __perf_evlist__for_each_entry_safe - safely iterate thru all the evsels
- * @list: list_head instance to iterate
- * @tmp: struct evsel temp iterator
- * @evsel: struct evsel iterator
- */
-#define __perf_evlist__for_each_entry_safe(list, tmp, evsel) \
-	list_for_each_entry_safe(evsel, tmp, list, node)
-
-/**
- * perf_evlist__for_each_entry_safe - safely iterate thru all the evsels
- * @evlist: evlist instance to iterate
- * @evsel: struct evsel iterator
- * @tmp: struct evsel temp iterator
- */
-#define perf_evlist__for_each_entry_safe(evlist, tmp, evsel) \
-	__perf_evlist__for_each_entry_safe(&(evlist)->entries, tmp, evsel)
-
-static inline struct perf_evsel *perf_evlist__first(struct perf_evlist *evlist)
-{
-	return list_entry(evlist->entries.next, struct perf_evsel, node);
-}
-
-static inline struct perf_evsel *perf_evlist__last(struct perf_evlist *evlist)
-{
-	return list_entry(evlist->entries.prev, struct perf_evsel, node);
-}
-
-u64 perf_evlist__read_format(struct perf_evlist *evlist);
-
-void perf_evlist__id_add(struct perf_evlist *evlist,
-			 struct perf_evsel *evsel,
-			 int cpu, int thread, u64 id);
-
-int perf_evlist__id_add_fd(struct perf_evlist *evlist,
-			   struct perf_evsel *evsel,
-			   int cpu, int thread, int fd);
-
-#endif /* __LIBPERF_INTERNAL_EVLIST_H */
diff --git a/tools/perf/lib/include/internal/evsel.h b/tools/perf/lib/include/internal/evsel.h
deleted file mode 100644
index 1ffd083b235e..000000000000
--- a/tools/perf/lib/include/internal/evsel.h
+++ /dev/null
@@ -1,63 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __LIBPERF_INTERNAL_EVSEL_H
-#define __LIBPERF_INTERNAL_EVSEL_H
-
-#include <linux/types.h>
-#include <linux/perf_event.h>
-#include <stdbool.h>
-#include <sys/types.h>
-
-struct perf_cpu_map;
-struct perf_thread_map;
-struct xyarray;
-
-/*
- * Per fd, to map back from PERF_SAMPLE_ID to evsel, only used when there are
- * more than one entry in the evlist.
- */
-struct perf_sample_id {
-	struct hlist_node	 node;
-	u64			 id;
-	struct perf_evsel	*evsel;
-       /*
-	* 'idx' will be used for AUX area sampling. A sample will have AUX area
-	* data that will be queued for decoding, where there are separate
-	* queues for each CPU (per-cpu tracing) or task (per-thread tracing).
-	* The sample ID can be used to lookup 'idx' which is effectively the
-	* queue number.
-	*/
-	int			 idx;
-	int			 cpu;
-	pid_t			 tid;
-
-	/* Holds total ID period value for PERF_SAMPLE_READ processing. */
-	u64			 period;
-};
-
-struct perf_evsel {
-	struct list_head	 node;
-	struct perf_event_attr	 attr;
-	struct perf_cpu_map	*cpus;
-	struct perf_cpu_map	*own_cpus;
-	struct perf_thread_map	*threads;
-	struct xyarray		*fd;
-	struct xyarray		*sample_id;
-	u64			*id;
-	u32			 ids;
-
-	/* parse modifier helper */
-	int			 nr_members;
-	bool			 system_wide;
-};
-
-void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr);
-int perf_evsel__alloc_fd(struct perf_evsel *evsel, int ncpus, int nthreads);
-void perf_evsel__close_fd(struct perf_evsel *evsel);
-void perf_evsel__free_fd(struct perf_evsel *evsel);
-int perf_evsel__read_size(struct perf_evsel *evsel);
-int perf_evsel__apply_filter(struct perf_evsel *evsel, const char *filter);
-
-int perf_evsel__alloc_id(struct perf_evsel *evsel, int ncpus, int nthreads);
-void perf_evsel__free_id(struct perf_evsel *evsel);
-
-#endif /* __LIBPERF_INTERNAL_EVSEL_H */
diff --git a/tools/perf/lib/include/internal/lib.h b/tools/perf/lib/include/internal/lib.h
deleted file mode 100644
index 5175d491b2d4..000000000000
--- a/tools/perf/lib/include/internal/lib.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __LIBPERF_INTERNAL_LIB_H
-#define __LIBPERF_INTERNAL_LIB_H
-
-#include <sys/types.h>
-
-extern unsigned int page_size;
-
-ssize_t readn(int fd, void *buf, size_t n);
-ssize_t writen(int fd, const void *buf, size_t n);
-
-#endif /* __LIBPERF_INTERNAL_CPUMAP_H */
diff --git a/tools/perf/lib/include/internal/mmap.h b/tools/perf/lib/include/internal/mmap.h
deleted file mode 100644
index be7556e0a2b2..000000000000
--- a/tools/perf/lib/include/internal/mmap.h
+++ /dev/null
@@ -1,55 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __LIBPERF_INTERNAL_MMAP_H
-#define __LIBPERF_INTERNAL_MMAP_H
-
-#include <linux/compiler.h>
-#include <linux/refcount.h>
-#include <linux/types.h>
-#include <stdbool.h>
-
-/* perf sample has 16 bits size limit */
-#define PERF_SAMPLE_MAX_SIZE (1 << 16)
-
-struct perf_mmap;
-
-typedef void (*libperf_unmap_cb_t)(struct perf_mmap *map);
-
-/**
- * struct perf_mmap - perf's ring buffer mmap details
- *
- * @refcnt - e.g. code using PERF_EVENT_IOC_SET_OUTPUT to share this
- */
-struct perf_mmap {
-	void			*base;
-	int			 mask;
-	int			 fd;
-	int			 cpu;
-	refcount_t		 refcnt;
-	u64			 prev;
-	u64			 start;
-	u64			 end;
-	bool			 overwrite;
-	u64			 flush;
-	libperf_unmap_cb_t	 unmap_cb;
-	char			 event_copy[PERF_SAMPLE_MAX_SIZE] __aligned(8);
-	struct perf_mmap	*next;
-};
-
-struct perf_mmap_param {
-	int	prot;
-	int	mask;
-};
-
-size_t perf_mmap__mmap_len(struct perf_mmap *map);
-
-void perf_mmap__init(struct perf_mmap *map, struct perf_mmap *prev,
-		     bool overwrite, libperf_unmap_cb_t unmap_cb);
-int perf_mmap__mmap(struct perf_mmap *map, struct perf_mmap_param *mp,
-		    int fd, int cpu);
-void perf_mmap__munmap(struct perf_mmap *map);
-void perf_mmap__get(struct perf_mmap *map);
-void perf_mmap__put(struct perf_mmap *map);
-
-u64 perf_mmap__read_head(struct perf_mmap *map);
-
-#endif /* __LIBPERF_INTERNAL_MMAP_H */
diff --git a/tools/perf/lib/include/internal/tests.h b/tools/perf/lib/include/internal/tests.h
deleted file mode 100644
index 2093e8868a67..000000000000
--- a/tools/perf/lib/include/internal/tests.h
+++ /dev/null
@@ -1,33 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __LIBPERF_INTERNAL_TESTS_H
-#define __LIBPERF_INTERNAL_TESTS_H
-
-#include <stdio.h>
-
-int tests_failed;
-
-#define __T_START					\
-do {							\
-	fprintf(stdout, "- running %s...", __FILE__);	\
-	fflush(NULL);					\
-	tests_failed = 0;				\
-} while (0)
-
-#define __T_END								\
-do {									\
-	if (tests_failed)						\
-		fprintf(stdout, "  FAILED (%d)\n", tests_failed);	\
-	else								\
-		fprintf(stdout, "OK\n");				\
-} while (0)
-
-#define __T(text, cond)                                                          \
-do {                                                                             \
-	if (!(cond)) {                                                           \
-		fprintf(stderr, "FAILED %s:%d %s\n", __FILE__, __LINE__, text);  \
-		tests_failed++;                                                  \
-		return -1;                                                       \
-	}                                                                        \
-} while (0)
-
-#endif /* __LIBPERF_INTERNAL_TESTS_H */
diff --git a/tools/perf/lib/include/internal/threadmap.h b/tools/perf/lib/include/internal/threadmap.h
deleted file mode 100644
index df748baf9eda..000000000000
--- a/tools/perf/lib/include/internal/threadmap.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __LIBPERF_INTERNAL_THREADMAP_H
-#define __LIBPERF_INTERNAL_THREADMAP_H
-
-#include <linux/refcount.h>
-#include <sys/types.h>
-#include <unistd.h>
-
-struct thread_map_data {
-	pid_t	 pid;
-	char	*comm;
-};
-
-struct perf_thread_map {
-	refcount_t	refcnt;
-	int		nr;
-	int		err_thread;
-	struct thread_map_data map[];
-};
-
-struct perf_thread_map *perf_thread_map__realloc(struct perf_thread_map *map, int nr);
-
-#endif /* __LIBPERF_INTERNAL_THREADMAP_H */
diff --git a/tools/perf/lib/include/internal/xyarray.h b/tools/perf/lib/include/internal/xyarray.h
deleted file mode 100644
index 51e35d6c8ec4..000000000000
--- a/tools/perf/lib/include/internal/xyarray.h
+++ /dev/null
@@ -1,36 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __LIBPERF_INTERNAL_XYARRAY_H
-#define __LIBPERF_INTERNAL_XYARRAY_H
-
-#include <linux/compiler.h>
-#include <sys/types.h>
-
-struct xyarray {
-	size_t row_size;
-	size_t entry_size;
-	size_t entries;
-	size_t max_x;
-	size_t max_y;
-	char contents[] __aligned(8);
-};
-
-struct xyarray *xyarray__new(int xlen, int ylen, size_t entry_size);
-void xyarray__delete(struct xyarray *xy);
-void xyarray__reset(struct xyarray *xy);
-
-static inline void *xyarray__entry(struct xyarray *xy, int x, int y)
-{
-	return &xy->contents[x * xy->row_size + y * xy->entry_size];
-}
-
-static inline int xyarray__max_y(struct xyarray *xy)
-{
-	return xy->max_y;
-}
-
-static inline int xyarray__max_x(struct xyarray *xy)
-{
-	return xy->max_x;
-}
-
-#endif /* __LIBPERF_INTERNAL_XYARRAY_H */
diff --git a/tools/perf/lib/include/perf/core.h b/tools/perf/lib/include/perf/core.h
deleted file mode 100644
index a3f6d68edad7..000000000000
--- a/tools/perf/lib/include/perf/core.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __LIBPERF_CORE_H
-#define __LIBPERF_CORE_H
-
-#include <stdarg.h>
-
-#ifndef LIBPERF_API
-#define LIBPERF_API __attribute__((visibility("default")))
-#endif
-
-enum libperf_print_level {
-	LIBPERF_ERR,
-	LIBPERF_WARN,
-	LIBPERF_INFO,
-	LIBPERF_DEBUG,
-	LIBPERF_DEBUG2,
-	LIBPERF_DEBUG3,
-};
-
-typedef int (*libperf_print_fn_t)(enum libperf_print_level level,
-				  const char *, va_list ap);
-
-LIBPERF_API void libperf_init(libperf_print_fn_t fn);
-
-#endif /* __LIBPERF_CORE_H */
diff --git a/tools/perf/lib/include/perf/cpumap.h b/tools/perf/lib/include/perf/cpumap.h
deleted file mode 100644
index 6a17ad730cbc..000000000000
--- a/tools/perf/lib/include/perf/cpumap.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __LIBPERF_CPUMAP_H
-#define __LIBPERF_CPUMAP_H
-
-#include <perf/core.h>
-#include <stdio.h>
-#include <stdbool.h>
-
-struct perf_cpu_map;
-
-LIBPERF_API struct perf_cpu_map *perf_cpu_map__dummy_new(void);
-LIBPERF_API struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list);
-LIBPERF_API struct perf_cpu_map *perf_cpu_map__read(FILE *file);
-LIBPERF_API struct perf_cpu_map *perf_cpu_map__get(struct perf_cpu_map *map);
-LIBPERF_API struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
-						     struct perf_cpu_map *other);
-LIBPERF_API void perf_cpu_map__put(struct perf_cpu_map *map);
-LIBPERF_API int perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int idx);
-LIBPERF_API int perf_cpu_map__nr(const struct perf_cpu_map *cpus);
-LIBPERF_API bool perf_cpu_map__empty(const struct perf_cpu_map *map);
-LIBPERF_API int perf_cpu_map__max(struct perf_cpu_map *map);
-
-#define perf_cpu_map__for_each_cpu(cpu, idx, cpus)		\
-	for ((idx) = 0, (cpu) = perf_cpu_map__cpu(cpus, idx);	\
-	     (idx) < perf_cpu_map__nr(cpus);			\
-	     (idx)++, (cpu) = perf_cpu_map__cpu(cpus, idx))
-
-#endif /* __LIBPERF_CPUMAP_H */
diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
deleted file mode 100644
index 18106899cb4e..000000000000
--- a/tools/perf/lib/include/perf/event.h
+++ /dev/null
@@ -1,385 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __LIBPERF_EVENT_H
-#define __LIBPERF_EVENT_H
-
-#include <linux/perf_event.h>
-#include <linux/types.h>
-#include <linux/limits.h>
-#include <linux/bpf.h>
-#include <sys/types.h> /* pid_t */
-
-struct perf_record_mmap {
-	struct perf_event_header header;
-	__u32			 pid, tid;
-	__u64			 start;
-	__u64			 len;
-	__u64			 pgoff;
-	char			 filename[PATH_MAX];
-};
-
-struct perf_record_mmap2 {
-	struct perf_event_header header;
-	__u32			 pid, tid;
-	__u64			 start;
-	__u64			 len;
-	__u64			 pgoff;
-	__u32			 maj;
-	__u32			 min;
-	__u64			 ino;
-	__u64			 ino_generation;
-	__u32			 prot;
-	__u32			 flags;
-	char			 filename[PATH_MAX];
-};
-
-struct perf_record_comm {
-	struct perf_event_header header;
-	__u32			 pid, tid;
-	char			 comm[16];
-};
-
-struct perf_record_namespaces {
-	struct perf_event_header header;
-	__u32			 pid, tid;
-	__u64			 nr_namespaces;
-	struct perf_ns_link_info link_info[];
-};
-
-struct perf_record_fork {
-	struct perf_event_header header;
-	__u32			 pid, ppid;
-	__u32			 tid, ptid;
-	__u64			 time;
-};
-
-struct perf_record_lost {
-	struct perf_event_header header;
-	__u64			 id;
-	__u64			 lost;
-};
-
-struct perf_record_lost_samples {
-	struct perf_event_header header;
-	__u64			 lost;
-};
-
-/*
- * PERF_FORMAT_ENABLED | PERF_FORMAT_RUNNING | PERF_FORMAT_ID
- */
-struct perf_record_read {
-	struct perf_event_header header;
-	__u32			 pid, tid;
-	__u64			 value;
-	__u64			 time_enabled;
-	__u64			 time_running;
-	__u64			 id;
-};
-
-struct perf_record_throttle {
-	struct perf_event_header header;
-	__u64			 time;
-	__u64			 id;
-	__u64			 stream_id;
-};
-
-#ifndef KSYM_NAME_LEN
-#define KSYM_NAME_LEN 256
-#endif
-
-struct perf_record_ksymbol {
-	struct perf_event_header header;
-	__u64			 addr;
-	__u32			 len;
-	__u16			 ksym_type;
-	__u16			 flags;
-	char			 name[KSYM_NAME_LEN];
-};
-
-struct perf_record_bpf_event {
-	struct perf_event_header header;
-	__u16			 type;
-	__u16			 flags;
-	__u32			 id;
-
-	/* for bpf_prog types */
-	__u8			 tag[BPF_TAG_SIZE];  // prog tag
-};
-
-struct perf_record_sample {
-	struct perf_event_header header;
-	__u64			 array[];
-};
-
-struct perf_record_switch {
-	struct perf_event_header header;
-	__u32			 next_prev_pid;
-	__u32			 next_prev_tid;
-};
-
-struct perf_record_header_attr {
-	struct perf_event_header header;
-	struct perf_event_attr	 attr;
-	__u64			 id[];
-};
-
-enum {
-	PERF_CPU_MAP__CPUS = 0,
-	PERF_CPU_MAP__MASK = 1,
-};
-
-struct cpu_map_entries {
-	__u16			 nr;
-	__u16			 cpu[];
-};
-
-struct perf_record_record_cpu_map {
-	__u16			 nr;
-	__u16			 long_size;
-	unsigned long		 mask[];
-};
-
-struct perf_record_cpu_map_data {
-	__u16			 type;
-	char			 data[];
-};
-
-struct perf_record_cpu_map {
-	struct perf_event_header	 header;
-	struct perf_record_cpu_map_data	 data;
-};
-
-enum {
-	PERF_EVENT_UPDATE__UNIT  = 0,
-	PERF_EVENT_UPDATE__SCALE = 1,
-	PERF_EVENT_UPDATE__NAME  = 2,
-	PERF_EVENT_UPDATE__CPUS  = 3,
-};
-
-struct perf_record_event_update_cpus {
-	struct perf_record_cpu_map_data	 cpus;
-};
-
-struct perf_record_event_update_scale {
-	double			 scale;
-};
-
-struct perf_record_event_update {
-	struct perf_event_header header;
-	__u64			 type;
-	__u64			 id;
-	char			 data[];
-};
-
-#define MAX_EVENT_NAME 64
-
-struct perf_trace_event_type {
-	__u64			 event_id;
-	char			 name[MAX_EVENT_NAME];
-};
-
-struct perf_record_header_event_type {
-	struct perf_event_header	 header;
-	struct perf_trace_event_type	 event_type;
-};
-
-struct perf_record_header_tracing_data {
-	struct perf_event_header header;
-	__u32			 size;
-};
-
-struct perf_record_header_build_id {
-	struct perf_event_header header;
-	pid_t			 pid;
-	__u8			 build_id[24];
-	char			 filename[];
-};
-
-struct id_index_entry {
-	__u64			 id;
-	__u64			 idx;
-	__u64			 cpu;
-	__u64			 tid;
-};
-
-struct perf_record_id_index {
-	struct perf_event_header header;
-	__u64			 nr;
-	struct id_index_entry	 entries[0];
-};
-
-struct perf_record_auxtrace_info {
-	struct perf_event_header header;
-	__u32			 type;
-	__u32			 reserved__; /* For alignment */
-	__u64			 priv[];
-};
-
-struct perf_record_auxtrace {
-	struct perf_event_header header;
-	__u64			 size;
-	__u64			 offset;
-	__u64			 reference;
-	__u32			 idx;
-	__u32			 tid;
-	__u32			 cpu;
-	__u32			 reserved__; /* For alignment */
-};
-
-#define MAX_AUXTRACE_ERROR_MSG 64
-
-struct perf_record_auxtrace_error {
-	struct perf_event_header header;
-	__u32			 type;
-	__u32			 code;
-	__u32			 cpu;
-	__u32			 pid;
-	__u32			 tid;
-	__u32			 fmt;
-	__u64			 ip;
-	__u64			 time;
-	char			 msg[MAX_AUXTRACE_ERROR_MSG];
-};
-
-struct perf_record_aux {
-	struct perf_event_header header;
-	__u64			 aux_offset;
-	__u64			 aux_size;
-	__u64			 flags;
-};
-
-struct perf_record_itrace_start {
-	struct perf_event_header header;
-	__u32			 pid;
-	__u32			 tid;
-};
-
-struct perf_record_thread_map_entry {
-	__u64			 pid;
-	char			 comm[16];
-};
-
-struct perf_record_thread_map {
-	struct perf_event_header		 header;
-	__u64					 nr;
-	struct perf_record_thread_map_entry	 entries[];
-};
-
-enum {
-	PERF_STAT_CONFIG_TERM__AGGR_MODE	= 0,
-	PERF_STAT_CONFIG_TERM__INTERVAL		= 1,
-	PERF_STAT_CONFIG_TERM__SCALE		= 2,
-	PERF_STAT_CONFIG_TERM__MAX		= 3,
-};
-
-struct perf_record_stat_config_entry {
-	__u64			 tag;
-	__u64			 val;
-};
-
-struct perf_record_stat_config {
-	struct perf_event_header		 header;
-	__u64					 nr;
-	struct perf_record_stat_config_entry	 data[];
-};
-
-struct perf_record_stat {
-	struct perf_event_header header;
-
-	__u64			 id;
-	__u32			 cpu;
-	__u32			 thread;
-
-	union {
-		struct {
-			__u64	 val;
-			__u64	 ena;
-			__u64	 run;
-		};
-		__u64		 values[3];
-	};
-};
-
-struct perf_record_stat_round {
-	struct perf_event_header header;
-	__u64			 type;
-	__u64			 time;
-};
-
-struct perf_record_time_conv {
-	struct perf_event_header header;
-	__u64			 time_shift;
-	__u64			 time_mult;
-	__u64			 time_zero;
-};
-
-struct perf_record_header_feature {
-	struct perf_event_header header;
-	__u64			 feat_id;
-	char			 data[];
-};
-
-struct perf_record_compressed {
-	struct perf_event_header header;
-	char			 data[];
-};
-
-enum perf_user_event_type { /* above any possible kernel type */
-	PERF_RECORD_USER_TYPE_START		= 64,
-	PERF_RECORD_HEADER_ATTR			= 64,
-	PERF_RECORD_HEADER_EVENT_TYPE		= 65, /* deprecated */
-	PERF_RECORD_HEADER_TRACING_DATA		= 66,
-	PERF_RECORD_HEADER_BUILD_ID		= 67,
-	PERF_RECORD_FINISHED_ROUND		= 68,
-	PERF_RECORD_ID_INDEX			= 69,
-	PERF_RECORD_AUXTRACE_INFO		= 70,
-	PERF_RECORD_AUXTRACE			= 71,
-	PERF_RECORD_AUXTRACE_ERROR		= 72,
-	PERF_RECORD_THREAD_MAP			= 73,
-	PERF_RECORD_CPU_MAP			= 74,
-	PERF_RECORD_STAT_CONFIG			= 75,
-	PERF_RECORD_STAT			= 76,
-	PERF_RECORD_STAT_ROUND			= 77,
-	PERF_RECORD_EVENT_UPDATE		= 78,
-	PERF_RECORD_TIME_CONV			= 79,
-	PERF_RECORD_HEADER_FEATURE		= 80,
-	PERF_RECORD_COMPRESSED			= 81,
-	PERF_RECORD_HEADER_MAX
-};
-
-union perf_event {
-	struct perf_event_header		header;
-	struct perf_record_mmap			mmap;
-	struct perf_record_mmap2		mmap2;
-	struct perf_record_comm			comm;
-	struct perf_record_namespaces		namespaces;
-	struct perf_record_fork			fork;
-	struct perf_record_lost			lost;
-	struct perf_record_lost_samples		lost_samples;
-	struct perf_record_read			read;
-	struct perf_record_throttle		throttle;
-	struct perf_record_sample		sample;
-	struct perf_record_bpf_event		bpf;
-	struct perf_record_ksymbol		ksymbol;
-	struct perf_record_header_attr		attr;
-	struct perf_record_event_update		event_update;
-	struct perf_record_header_event_type	event_type;
-	struct perf_record_header_tracing_data	tracing_data;
-	struct perf_record_header_build_id	build_id;
-	struct perf_record_id_index		id_index;
-	struct perf_record_auxtrace_info	auxtrace_info;
-	struct perf_record_auxtrace		auxtrace;
-	struct perf_record_auxtrace_error	auxtrace_error;
-	struct perf_record_aux			aux;
-	struct perf_record_itrace_start		itrace_start;
-	struct perf_record_switch		context_switch;
-	struct perf_record_thread_map		thread_map;
-	struct perf_record_cpu_map		cpu_map;
-	struct perf_record_stat_config		stat_config;
-	struct perf_record_stat			stat;
-	struct perf_record_stat_round		stat_round;
-	struct perf_record_time_conv		time_conv;
-	struct perf_record_header_feature	feat;
-	struct perf_record_compressed		pack;
-};
-
-#endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/lib/include/perf/evlist.h b/tools/perf/lib/include/perf/evlist.h
deleted file mode 100644
index 0a7479dc13bf..000000000000
--- a/tools/perf/lib/include/perf/evlist.h
+++ /dev/null
@@ -1,49 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __LIBPERF_EVLIST_H
-#define __LIBPERF_EVLIST_H
-
-#include <perf/core.h>
-#include <stdbool.h>
-
-struct perf_evlist;
-struct perf_evsel;
-struct perf_cpu_map;
-struct perf_thread_map;
-
-LIBPERF_API void perf_evlist__add(struct perf_evlist *evlist,
-				  struct perf_evsel *evsel);
-LIBPERF_API void perf_evlist__remove(struct perf_evlist *evlist,
-				     struct perf_evsel *evsel);
-LIBPERF_API struct perf_evlist *perf_evlist__new(void);
-LIBPERF_API void perf_evlist__delete(struct perf_evlist *evlist);
-LIBPERF_API struct perf_evsel* perf_evlist__next(struct perf_evlist *evlist,
-						 struct perf_evsel *evsel);
-LIBPERF_API int perf_evlist__open(struct perf_evlist *evlist);
-LIBPERF_API void perf_evlist__close(struct perf_evlist *evlist);
-LIBPERF_API void perf_evlist__enable(struct perf_evlist *evlist);
-LIBPERF_API void perf_evlist__disable(struct perf_evlist *evlist);
-
-#define perf_evlist__for_each_evsel(evlist, pos)	\
-	for ((pos) = perf_evlist__next((evlist), NULL);	\
-	     (pos) != NULL;				\
-	     (pos) = perf_evlist__next((evlist), (pos)))
-
-LIBPERF_API void perf_evlist__set_maps(struct perf_evlist *evlist,
-				       struct perf_cpu_map *cpus,
-				       struct perf_thread_map *threads);
-LIBPERF_API int perf_evlist__poll(struct perf_evlist *evlist, int timeout);
-LIBPERF_API int perf_evlist__filter_pollfd(struct perf_evlist *evlist,
-					   short revents_and_mask);
-
-LIBPERF_API int perf_evlist__mmap(struct perf_evlist *evlist, int pages);
-LIBPERF_API void perf_evlist__munmap(struct perf_evlist *evlist);
-
-LIBPERF_API struct perf_mmap *perf_evlist__next_mmap(struct perf_evlist *evlist,
-						     struct perf_mmap *map,
-						     bool overwrite);
-#define perf_evlist__for_each_mmap(evlist, pos, overwrite)		\
-	for ((pos) = perf_evlist__next_mmap((evlist), NULL, overwrite);	\
-	     (pos) != NULL;						\
-	     (pos) = perf_evlist__next_mmap((evlist), (pos), overwrite))
-
-#endif /* __LIBPERF_EVLIST_H */
diff --git a/tools/perf/lib/include/perf/evsel.h b/tools/perf/lib/include/perf/evsel.h
deleted file mode 100644
index c82ec39a4ad0..000000000000
--- a/tools/perf/lib/include/perf/evsel.h
+++ /dev/null
@@ -1,40 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __LIBPERF_EVSEL_H
-#define __LIBPERF_EVSEL_H
-
-#include <stdint.h>
-#include <perf/core.h>
-
-struct perf_evsel;
-struct perf_event_attr;
-struct perf_cpu_map;
-struct perf_thread_map;
-
-struct perf_counts_values {
-	union {
-		struct {
-			uint64_t val;
-			uint64_t ena;
-			uint64_t run;
-		};
-		uint64_t values[3];
-	};
-};
-
-LIBPERF_API struct perf_evsel *perf_evsel__new(struct perf_event_attr *attr);
-LIBPERF_API void perf_evsel__delete(struct perf_evsel *evsel);
-LIBPERF_API int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
-				 struct perf_thread_map *threads);
-LIBPERF_API void perf_evsel__close(struct perf_evsel *evsel);
-LIBPERF_API void perf_evsel__close_cpu(struct perf_evsel *evsel, int cpu);
-LIBPERF_API int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
-				 struct perf_counts_values *count);
-LIBPERF_API int perf_evsel__enable(struct perf_evsel *evsel);
-LIBPERF_API int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu);
-LIBPERF_API int perf_evsel__disable(struct perf_evsel *evsel);
-LIBPERF_API int perf_evsel__disable_cpu(struct perf_evsel *evsel, int cpu);
-LIBPERF_API struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel);
-LIBPERF_API struct perf_thread_map *perf_evsel__threads(struct perf_evsel *evsel);
-LIBPERF_API struct perf_event_attr *perf_evsel__attr(struct perf_evsel *evsel);
-
-#endif /* __LIBPERF_EVSEL_H */
diff --git a/tools/perf/lib/include/perf/mmap.h b/tools/perf/lib/include/perf/mmap.h
deleted file mode 100644
index 9508ad90d8b9..000000000000
--- a/tools/perf/lib/include/perf/mmap.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __LIBPERF_MMAP_H
-#define __LIBPERF_MMAP_H
-
-#include <perf/core.h>
-
-struct perf_mmap;
-union perf_event;
-
-LIBPERF_API void perf_mmap__consume(struct perf_mmap *map);
-LIBPERF_API int perf_mmap__read_init(struct perf_mmap *map);
-LIBPERF_API void perf_mmap__read_done(struct perf_mmap *map);
-LIBPERF_API union perf_event *perf_mmap__read_event(struct perf_mmap *map);
-
-#endif /* __LIBPERF_MMAP_H */
diff --git a/tools/perf/lib/include/perf/threadmap.h b/tools/perf/lib/include/perf/threadmap.h
deleted file mode 100644
index a7c50de8d010..000000000000
--- a/tools/perf/lib/include/perf/threadmap.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __LIBPERF_THREADMAP_H
-#define __LIBPERF_THREADMAP_H
-
-#include <perf/core.h>
-#include <sys/types.h>
-
-struct perf_thread_map;
-
-LIBPERF_API struct perf_thread_map *perf_thread_map__new_dummy(void);
-
-LIBPERF_API void perf_thread_map__set_pid(struct perf_thread_map *map, int thread, pid_t pid);
-LIBPERF_API char *perf_thread_map__comm(struct perf_thread_map *map, int thread);
-LIBPERF_API int perf_thread_map__nr(struct perf_thread_map *threads);
-LIBPERF_API pid_t perf_thread_map__pid(struct perf_thread_map *map, int thread);
-
-LIBPERF_API struct perf_thread_map *perf_thread_map__get(struct perf_thread_map *map);
-LIBPERF_API void perf_thread_map__put(struct perf_thread_map *map);
-
-#endif /* __LIBPERF_THREADMAP_H */
diff --git a/tools/perf/lib/internal.h b/tools/perf/lib/internal.h
deleted file mode 100644
index 2c27e158de6b..000000000000
--- a/tools/perf/lib/internal.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __LIBPERF_INTERNAL_H
-#define __LIBPERF_INTERNAL_H
-
-#include <perf/core.h>
-
-void libperf_print(enum libperf_print_level level,
-		   const char *format, ...)
-	__attribute__((format(printf, 2, 3)));
-
-#define __pr(level, fmt, ...)   \
-do {                            \
-	libperf_print(level, "libperf: " fmt, ##__VA_ARGS__);     \
-} while (0)
-
-#define pr_err(fmt, ...)        __pr(LIBPERF_ERR, fmt, ##__VA_ARGS__)
-#define pr_warning(fmt, ...)    __pr(LIBPERF_WARN, fmt, ##__VA_ARGS__)
-#define pr_info(fmt, ...)       __pr(LIBPERF_INFO, fmt, ##__VA_ARGS__)
-#define pr_debug(fmt, ...)      __pr(LIBPERF_DEBUG, fmt, ##__VA_ARGS__)
-#define pr_debug2(fmt, ...)     __pr(LIBPERF_DEBUG2, fmt, ##__VA_ARGS__)
-#define pr_debug3(fmt, ...)     __pr(LIBPERF_DEBUG3, fmt, ##__VA_ARGS__)
-
-#endif /* __LIBPERF_INTERNAL_H */
diff --git a/tools/perf/lib/lib.c b/tools/perf/lib/lib.c
deleted file mode 100644
index 18658931fc71..000000000000
--- a/tools/perf/lib/lib.c
+++ /dev/null
@@ -1,48 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <unistd.h>
-#include <stdbool.h>
-#include <errno.h>
-#include <linux/kernel.h>
-#include <internal/lib.h>
-
-unsigned int page_size;
-
-static ssize_t ion(bool is_read, int fd, void *buf, size_t n)
-{
-	void *buf_start = buf;
-	size_t left = n;
-
-	while (left) {
-		/* buf must be treated as const if !is_read. */
-		ssize_t ret = is_read ? read(fd, buf, left) :
-					write(fd, buf, left);
-
-		if (ret < 0 && errno == EINTR)
-			continue;
-		if (ret <= 0)
-			return ret;
-
-		left -= ret;
-		buf  += ret;
-	}
-
-	BUG_ON((size_t)(buf - buf_start) != n);
-	return n;
-}
-
-/*
- * Read exactly 'n' bytes or return an error.
- */
-ssize_t readn(int fd, void *buf, size_t n)
-{
-	return ion(true, fd, buf, n);
-}
-
-/*
- * Write exactly 'n' bytes or return an error.
- */
-ssize_t writen(int fd, const void *buf, size_t n)
-{
-	/* ion does not modify buf. */
-	return ion(false, fd, (void *)buf, n);
-}
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
deleted file mode 100644
index 7be1af8a546c..000000000000
--- a/tools/perf/lib/libperf.map
+++ /dev/null
@@ -1,51 +0,0 @@
-LIBPERF_0.0.1 {
-	global:
-		libperf_init;
-		perf_cpu_map__dummy_new;
-		perf_cpu_map__get;
-		perf_cpu_map__put;
-		perf_cpu_map__new;
-		perf_cpu_map__read;
-		perf_cpu_map__nr;
-		perf_cpu_map__cpu;
-		perf_cpu_map__empty;
-		perf_cpu_map__max;
-		perf_thread_map__new_dummy;
-		perf_thread_map__set_pid;
-		perf_thread_map__comm;
-		perf_thread_map__nr;
-		perf_thread_map__pid;
-		perf_thread_map__get;
-		perf_thread_map__put;
-		perf_evsel__new;
-		perf_evsel__delete;
-		perf_evsel__enable;
-		perf_evsel__disable;
-		perf_evsel__open;
-		perf_evsel__close;
-		perf_evsel__read;
-		perf_evsel__cpus;
-		perf_evsel__threads;
-		perf_evsel__attr;
-		perf_evlist__new;
-		perf_evlist__delete;
-		perf_evlist__open;
-		perf_evlist__close;
-		perf_evlist__enable;
-		perf_evlist__disable;
-		perf_evlist__add;
-		perf_evlist__remove;
-		perf_evlist__next;
-		perf_evlist__set_maps;
-		perf_evlist__poll;
-		perf_evlist__mmap;
-		perf_evlist__munmap;
-		perf_evlist__filter_pollfd;
-		perf_evlist__next_mmap;
-		perf_mmap__consume;
-		perf_mmap__read_init;
-		perf_mmap__read_done;
-		perf_mmap__read_event;
-	local:
-		*;
-};
diff --git a/tools/perf/lib/libperf.pc.template b/tools/perf/lib/libperf.pc.template
deleted file mode 100644
index 117e4a237b55..000000000000
--- a/tools/perf/lib/libperf.pc.template
+++ /dev/null
@@ -1,11 +0,0 @@
-# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
-
-prefix=@PREFIX@
-libdir=@LIBDIR@
-includedir=${prefix}/include
-
-Name: libperf
-Description: perf library
-Version: @VERSION@
-Libs: -L${libdir} -lperf
-Cflags: -I${includedir}
diff --git a/tools/perf/lib/mmap.c b/tools/perf/lib/mmap.c
deleted file mode 100644
index 79d5ed6c38cc..000000000000
--- a/tools/perf/lib/mmap.c
+++ /dev/null
@@ -1,275 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <sys/mman.h>
-#include <inttypes.h>
-#include <asm/bug.h>
-#include <errno.h>
-#include <string.h>
-#include <linux/ring_buffer.h>
-#include <linux/perf_event.h>
-#include <perf/mmap.h>
-#include <perf/event.h>
-#include <internal/mmap.h>
-#include <internal/lib.h>
-#include <linux/kernel.h>
-#include "internal.h"
-
-void perf_mmap__init(struct perf_mmap *map, struct perf_mmap *prev,
-		     bool overwrite, libperf_unmap_cb_t unmap_cb)
-{
-	map->fd = -1;
-	map->overwrite = overwrite;
-	map->unmap_cb  = unmap_cb;
-	refcount_set(&map->refcnt, 0);
-	if (prev)
-		prev->next = map;
-}
-
-size_t perf_mmap__mmap_len(struct perf_mmap *map)
-{
-	return map->mask + 1 + page_size;
-}
-
-int perf_mmap__mmap(struct perf_mmap *map, struct perf_mmap_param *mp,
-		    int fd, int cpu)
-{
-	map->prev = 0;
-	map->mask = mp->mask;
-	map->base = mmap(NULL, perf_mmap__mmap_len(map), mp->prot,
-			 MAP_SHARED, fd, 0);
-	if (map->base == MAP_FAILED) {
-		map->base = NULL;
-		return -1;
-	}
-
-	map->fd  = fd;
-	map->cpu = cpu;
-	return 0;
-}
-
-void perf_mmap__munmap(struct perf_mmap *map)
-{
-	if (map && map->base != NULL) {
-		munmap(map->base, perf_mmap__mmap_len(map));
-		map->base = NULL;
-		map->fd = -1;
-		refcount_set(&map->refcnt, 0);
-	}
-	if (map && map->unmap_cb)
-		map->unmap_cb(map);
-}
-
-void perf_mmap__get(struct perf_mmap *map)
-{
-	refcount_inc(&map->refcnt);
-}
-
-void perf_mmap__put(struct perf_mmap *map)
-{
-	BUG_ON(map->base && refcount_read(&map->refcnt) == 0);
-
-	if (refcount_dec_and_test(&map->refcnt))
-		perf_mmap__munmap(map);
-}
-
-static inline void perf_mmap__write_tail(struct perf_mmap *md, u64 tail)
-{
-	ring_buffer_write_tail(md->base, tail);
-}
-
-u64 perf_mmap__read_head(struct perf_mmap *map)
-{
-	return ring_buffer_read_head(map->base);
-}
-
-static bool perf_mmap__empty(struct perf_mmap *map)
-{
-	struct perf_event_mmap_page *pc = map->base;
-
-	return perf_mmap__read_head(map) == map->prev && !pc->aux_size;
-}
-
-void perf_mmap__consume(struct perf_mmap *map)
-{
-	if (!map->overwrite) {
-		u64 old = map->prev;
-
-		perf_mmap__write_tail(map, old);
-	}
-
-	if (refcount_read(&map->refcnt) == 1 && perf_mmap__empty(map))
-		perf_mmap__put(map);
-}
-
-static int overwrite_rb_find_range(void *buf, int mask, u64 *start, u64 *end)
-{
-	struct perf_event_header *pheader;
-	u64 evt_head = *start;
-	int size = mask + 1;
-
-	pr_debug2("%s: buf=%p, start=%"PRIx64"\n", __func__, buf, *start);
-	pheader = (struct perf_event_header *)(buf + (*start & mask));
-	while (true) {
-		if (evt_head - *start >= (unsigned int)size) {
-			pr_debug("Finished reading overwrite ring buffer: rewind\n");
-			if (evt_head - *start > (unsigned int)size)
-				evt_head -= pheader->size;
-			*end = evt_head;
-			return 0;
-		}
-
-		pheader = (struct perf_event_header *)(buf + (evt_head & mask));
-
-		if (pheader->size == 0) {
-			pr_debug("Finished reading overwrite ring buffer: get start\n");
-			*end = evt_head;
-			return 0;
-		}
-
-		evt_head += pheader->size;
-		pr_debug3("move evt_head: %"PRIx64"\n", evt_head);
-	}
-	WARN_ONCE(1, "Shouldn't get here\n");
-	return -1;
-}
-
-/*
- * Report the start and end of the available data in ringbuffer
- */
-static int __perf_mmap__read_init(struct perf_mmap *md)
-{
-	u64 head = perf_mmap__read_head(md);
-	u64 old = md->prev;
-	unsigned char *data = md->base + page_size;
-	unsigned long size;
-
-	md->start = md->overwrite ? head : old;
-	md->end = md->overwrite ? old : head;
-
-	if ((md->end - md->start) < md->flush)
-		return -EAGAIN;
-
-	size = md->end - md->start;
-	if (size > (unsigned long)(md->mask) + 1) {
-		if (!md->overwrite) {
-			WARN_ONCE(1, "failed to keep up with mmap data. (warn only once)\n");
-
-			md->prev = head;
-			perf_mmap__consume(md);
-			return -EAGAIN;
-		}
-
-		/*
-		 * Backward ring buffer is full. We still have a chance to read
-		 * most of data from it.
-		 */
-		if (overwrite_rb_find_range(data, md->mask, &md->start, &md->end))
-			return -EINVAL;
-	}
-
-	return 0;
-}
-
-int perf_mmap__read_init(struct perf_mmap *map)
-{
-	/*
-	 * Check if event was unmapped due to a POLLHUP/POLLERR.
-	 */
-	if (!refcount_read(&map->refcnt))
-		return -ENOENT;
-
-	return __perf_mmap__read_init(map);
-}
-
-/*
- * Mandatory for overwrite mode
- * The direction of overwrite mode is backward.
- * The last perf_mmap__read() will set tail to map->core.prev.
- * Need to correct the map->core.prev to head which is the end of next read.
- */
-void perf_mmap__read_done(struct perf_mmap *map)
-{
-	/*
-	 * Check if event was unmapped due to a POLLHUP/POLLERR.
-	 */
-	if (!refcount_read(&map->refcnt))
-		return;
-
-	map->prev = perf_mmap__read_head(map);
-}
-
-/* When check_messup is true, 'end' must points to a good entry */
-static union perf_event *perf_mmap__read(struct perf_mmap *map,
-					 u64 *startp, u64 end)
-{
-	unsigned char *data = map->base + page_size;
-	union perf_event *event = NULL;
-	int diff = end - *startp;
-
-	if (diff >= (int)sizeof(event->header)) {
-		size_t size;
-
-		event = (union perf_event *)&data[*startp & map->mask];
-		size = event->header.size;
-
-		if (size < sizeof(event->header) || diff < (int)size)
-			return NULL;
-
-		/*
-		 * Event straddles the mmap boundary -- header should always
-		 * be inside due to u64 alignment of output.
-		 */
-		if ((*startp & map->mask) + size != ((*startp + size) & map->mask)) {
-			unsigned int offset = *startp;
-			unsigned int len = min(sizeof(*event), size), cpy;
-			void *dst = map->event_copy;
-
-			do {
-				cpy = min(map->mask + 1 - (offset & map->mask), len);
-				memcpy(dst, &data[offset & map->mask], cpy);
-				offset += cpy;
-				dst += cpy;
-				len -= cpy;
-			} while (len);
-
-			event = (union perf_event *)map->event_copy;
-		}
-
-		*startp += size;
-	}
-
-	return event;
-}
-
-/*
- * Read event from ring buffer one by one.
- * Return one event for each call.
- *
- * Usage:
- * perf_mmap__read_init()
- * while(event = perf_mmap__read_event()) {
- *	//process the event
- *	perf_mmap__consume()
- * }
- * perf_mmap__read_done()
- */
-union perf_event *perf_mmap__read_event(struct perf_mmap *map)
-{
-	union perf_event *event;
-
-	/*
-	 * Check if event was unmapped due to a POLLHUP/POLLERR.
-	 */
-	if (!refcount_read(&map->refcnt))
-		return NULL;
-
-	/* non-overwirte doesn't pause the ringbuffer */
-	if (!map->overwrite)
-		map->end = perf_mmap__read_head(map);
-
-	event = perf_mmap__read(map, &map->start, map->end);
-
-	if (!map->overwrite)
-		map->prev = map->start;
-
-	return event;
-}
diff --git a/tools/perf/lib/tests/Makefile b/tools/perf/lib/tests/Makefile
deleted file mode 100644
index a43cd08c5c03..000000000000
--- a/tools/perf/lib/tests/Makefile
+++ /dev/null
@@ -1,38 +0,0 @@
-# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
-
-TESTS = test-cpumap test-threadmap test-evlist test-evsel
-
-TESTS_SO := $(addsuffix -so,$(TESTS))
-TESTS_A  := $(addsuffix -a,$(TESTS))
-
-# Set compile option CFLAGS
-ifdef EXTRA_CFLAGS
-  CFLAGS := $(EXTRA_CFLAGS)
-else
-  CFLAGS := -g -Wall
-endif
-
-all:
-
-include $(srctree)/tools/scripts/Makefile.include
-
-INCLUDE = -I$(srctree)/tools/perf/lib/include -I$(srctree)/tools/include -I$(srctree)/tools/lib
-
-$(TESTS_A): FORCE
-	$(QUIET_LINK)$(CC) $(INCLUDE) $(CFLAGS) -o $@ $(subst -a,.c,$@) ../libperf.a $(LIBAPI)
-
-$(TESTS_SO): FORCE
-	$(QUIET_LINK)$(CC) $(INCLUDE) $(CFLAGS) -L.. -o $@ $(subst -so,.c,$@) $(LIBAPI) -lperf
-
-all: $(TESTS_A) $(TESTS_SO)
-
-run:
-	@echo "running static:"
-	@for i in $(TESTS_A); do ./$$i; done
-	@echo "running dynamic:"
-	@for i in $(TESTS_SO); do LD_LIBRARY_PATH=../ ./$$i; done
-
-clean:
-	$(call QUIET_CLEAN, tests)$(RM) $(TESTS_A) $(TESTS_SO)
-
-.PHONY: all clean FORCE
diff --git a/tools/perf/lib/tests/test-cpumap.c b/tools/perf/lib/tests/test-cpumap.c
deleted file mode 100644
index c8d45091e7c2..000000000000
--- a/tools/perf/lib/tests/test-cpumap.c
+++ /dev/null
@@ -1,31 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <stdarg.h>
-#include <stdio.h>
-#include <perf/cpumap.h>
-#include <internal/tests.h>
-
-static int libperf_print(enum libperf_print_level level,
-			 const char *fmt, va_list ap)
-{
-	return vfprintf(stderr, fmt, ap);
-}
-
-int main(int argc, char **argv)
-{
-	struct perf_cpu_map *cpus;
-
-	__T_START;
-
-	libperf_init(libperf_print);
-
-	cpus = perf_cpu_map__dummy_new();
-	if (!cpus)
-		return -1;
-
-	perf_cpu_map__get(cpus);
-	perf_cpu_map__put(cpus);
-	perf_cpu_map__put(cpus);
-
-	__T_END;
-	return 0;
-}
diff --git a/tools/perf/lib/tests/test-evlist.c b/tools/perf/lib/tests/test-evlist.c
deleted file mode 100644
index 6d8ebe0c2504..000000000000
--- a/tools/perf/lib/tests/test-evlist.c
+++ /dev/null
@@ -1,413 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE // needed for sched.h to get sched_[gs]etaffinity and CPU_(ZERO,SET)
-#include <sched.h>
-#include <stdio.h>
-#include <stdarg.h>
-#include <unistd.h>
-#include <stdlib.h>
-#include <linux/perf_event.h>
-#include <linux/limits.h>
-#include <sys/types.h>
-#include <sys/wait.h>
-#include <sys/prctl.h>
-#include <perf/cpumap.h>
-#include <perf/threadmap.h>
-#include <perf/evlist.h>
-#include <perf/evsel.h>
-#include <perf/mmap.h>
-#include <perf/event.h>
-#include <internal/tests.h>
-#include <api/fs/fs.h>
-
-static int libperf_print(enum libperf_print_level level,
-			 const char *fmt, va_list ap)
-{
-	return vfprintf(stderr, fmt, ap);
-}
-
-static int test_stat_cpu(void)
-{
-	struct perf_cpu_map *cpus;
-	struct perf_evlist *evlist;
-	struct perf_evsel *evsel;
-	struct perf_event_attr attr1 = {
-		.type	= PERF_TYPE_SOFTWARE,
-		.config	= PERF_COUNT_SW_CPU_CLOCK,
-	};
-	struct perf_event_attr attr2 = {
-		.type	= PERF_TYPE_SOFTWARE,
-		.config	= PERF_COUNT_SW_TASK_CLOCK,
-	};
-	int err, cpu, tmp;
-
-	cpus = perf_cpu_map__new(NULL);
-	__T("failed to create cpus", cpus);
-
-	evlist = perf_evlist__new();
-	__T("failed to create evlist", evlist);
-
-	evsel = perf_evsel__new(&attr1);
-	__T("failed to create evsel1", evsel);
-
-	perf_evlist__add(evlist, evsel);
-
-	evsel = perf_evsel__new(&attr2);
-	__T("failed to create evsel2", evsel);
-
-	perf_evlist__add(evlist, evsel);
-
-	perf_evlist__set_maps(evlist, cpus, NULL);
-
-	err = perf_evlist__open(evlist);
-	__T("failed to open evsel", err == 0);
-
-	perf_evlist__for_each_evsel(evlist, evsel) {
-		cpus = perf_evsel__cpus(evsel);
-
-		perf_cpu_map__for_each_cpu(cpu, tmp, cpus) {
-			struct perf_counts_values counts = { .val = 0 };
-
-			perf_evsel__read(evsel, cpu, 0, &counts);
-			__T("failed to read value for evsel", counts.val != 0);
-		}
-	}
-
-	perf_evlist__close(evlist);
-	perf_evlist__delete(evlist);
-
-	perf_cpu_map__put(cpus);
-	return 0;
-}
-
-static int test_stat_thread(void)
-{
-	struct perf_counts_values counts = { .val = 0 };
-	struct perf_thread_map *threads;
-	struct perf_evlist *evlist;
-	struct perf_evsel *evsel;
-	struct perf_event_attr attr1 = {
-		.type	= PERF_TYPE_SOFTWARE,
-		.config	= PERF_COUNT_SW_CPU_CLOCK,
-	};
-	struct perf_event_attr attr2 = {
-		.type	= PERF_TYPE_SOFTWARE,
-		.config	= PERF_COUNT_SW_TASK_CLOCK,
-	};
-	int err;
-
-	threads = perf_thread_map__new_dummy();
-	__T("failed to create threads", threads);
-
-	perf_thread_map__set_pid(threads, 0, 0);
-
-	evlist = perf_evlist__new();
-	__T("failed to create evlist", evlist);
-
-	evsel = perf_evsel__new(&attr1);
-	__T("failed to create evsel1", evsel);
-
-	perf_evlist__add(evlist, evsel);
-
-	evsel = perf_evsel__new(&attr2);
-	__T("failed to create evsel2", evsel);
-
-	perf_evlist__add(evlist, evsel);
-
-	perf_evlist__set_maps(evlist, NULL, threads);
-
-	err = perf_evlist__open(evlist);
-	__T("failed to open evsel", err == 0);
-
-	perf_evlist__for_each_evsel(evlist, evsel) {
-		perf_evsel__read(evsel, 0, 0, &counts);
-		__T("failed to read value for evsel", counts.val != 0);
-	}
-
-	perf_evlist__close(evlist);
-	perf_evlist__delete(evlist);
-
-	perf_thread_map__put(threads);
-	return 0;
-}
-
-static int test_stat_thread_enable(void)
-{
-	struct perf_counts_values counts = { .val = 0 };
-	struct perf_thread_map *threads;
-	struct perf_evlist *evlist;
-	struct perf_evsel *evsel;
-	struct perf_event_attr attr1 = {
-		.type	  = PERF_TYPE_SOFTWARE,
-		.config	  = PERF_COUNT_SW_CPU_CLOCK,
-		.disabled = 1,
-	};
-	struct perf_event_attr attr2 = {
-		.type	  = PERF_TYPE_SOFTWARE,
-		.config	  = PERF_COUNT_SW_TASK_CLOCK,
-		.disabled = 1,
-	};
-	int err;
-
-	threads = perf_thread_map__new_dummy();
-	__T("failed to create threads", threads);
-
-	perf_thread_map__set_pid(threads, 0, 0);
-
-	evlist = perf_evlist__new();
-	__T("failed to create evlist", evlist);
-
-	evsel = perf_evsel__new(&attr1);
-	__T("failed to create evsel1", evsel);
-
-	perf_evlist__add(evlist, evsel);
-
-	evsel = perf_evsel__new(&attr2);
-	__T("failed to create evsel2", evsel);
-
-	perf_evlist__add(evlist, evsel);
-
-	perf_evlist__set_maps(evlist, NULL, threads);
-
-	err = perf_evlist__open(evlist);
-	__T("failed to open evsel", err == 0);
-
-	perf_evlist__for_each_evsel(evlist, evsel) {
-		perf_evsel__read(evsel, 0, 0, &counts);
-		__T("failed to read value for evsel", counts.val == 0);
-	}
-
-	perf_evlist__enable(evlist);
-
-	perf_evlist__for_each_evsel(evlist, evsel) {
-		perf_evsel__read(evsel, 0, 0, &counts);
-		__T("failed to read value for evsel", counts.val != 0);
-	}
-
-	perf_evlist__disable(evlist);
-
-	perf_evlist__close(evlist);
-	perf_evlist__delete(evlist);
-
-	perf_thread_map__put(threads);
-	return 0;
-}
-
-static int test_mmap_thread(void)
-{
-	struct perf_evlist *evlist;
-	struct perf_evsel *evsel;
-	struct perf_mmap *map;
-	struct perf_cpu_map *cpus;
-	struct perf_thread_map *threads;
-	struct perf_event_attr attr = {
-		.type             = PERF_TYPE_TRACEPOINT,
-		.sample_period    = 1,
-		.wakeup_watermark = 1,
-		.disabled         = 1,
-	};
-	char path[PATH_MAX];
-	int id, err, pid, go_pipe[2];
-	union perf_event *event;
-	char bf;
-	int count = 0;
-
-	snprintf(path, PATH_MAX, "%s/kernel/debug/tracing/events/syscalls/sys_enter_prctl/id",
-		 sysfs__mountpoint());
-
-	if (filename__read_int(path, &id)) {
-		fprintf(stderr, "error: failed to get tracepoint id: %s\n", path);
-		return -1;
-	}
-
-	attr.config = id;
-
-	err = pipe(go_pipe);
-	__T("failed to create pipe", err == 0);
-
-	fflush(NULL);
-
-	pid = fork();
-	if (!pid) {
-		int i;
-
-		read(go_pipe[0], &bf, 1);
-
-		/* Generate 100 prctl calls. */
-		for (i = 0; i < 100; i++)
-			prctl(0, 0, 0, 0, 0);
-
-		exit(0);
-	}
-
-	threads = perf_thread_map__new_dummy();
-	__T("failed to create threads", threads);
-
-	cpus = perf_cpu_map__dummy_new();
-	__T("failed to create cpus", cpus);
-
-	perf_thread_map__set_pid(threads, 0, pid);
-
-	evlist = perf_evlist__new();
-	__T("failed to create evlist", evlist);
-
-	evsel = perf_evsel__new(&attr);
-	__T("failed to create evsel1", evsel);
-
-	perf_evlist__add(evlist, evsel);
-
-	perf_evlist__set_maps(evlist, cpus, threads);
-
-	err = perf_evlist__open(evlist);
-	__T("failed to open evlist", err == 0);
-
-	err = perf_evlist__mmap(evlist, 4);
-	__T("failed to mmap evlist", err == 0);
-
-	perf_evlist__enable(evlist);
-
-	/* kick the child and wait for it to finish */
-	write(go_pipe[1], &bf, 1);
-	waitpid(pid, NULL, 0);
-
-	/*
-	 * There's no need to call perf_evlist__disable,
-	 * monitored process is dead now.
-	 */
-
-	perf_evlist__for_each_mmap(evlist, map, false) {
-		if (perf_mmap__read_init(map) < 0)
-			continue;
-
-		while ((event = perf_mmap__read_event(map)) != NULL) {
-			count++;
-			perf_mmap__consume(map);
-		}
-
-		perf_mmap__read_done(map);
-	}
-
-	/* calls perf_evlist__munmap/perf_evlist__close */
-	perf_evlist__delete(evlist);
-
-	perf_thread_map__put(threads);
-	perf_cpu_map__put(cpus);
-
-	/*
-	 * The generated prctl calls should match the
-	 * number of events in the buffer.
-	 */
-	__T("failed count", count == 100);
-
-	return 0;
-}
-
-static int test_mmap_cpus(void)
-{
-	struct perf_evlist *evlist;
-	struct perf_evsel *evsel;
-	struct perf_mmap *map;
-	struct perf_cpu_map *cpus;
-	struct perf_event_attr attr = {
-		.type             = PERF_TYPE_TRACEPOINT,
-		.sample_period    = 1,
-		.wakeup_watermark = 1,
-		.disabled         = 1,
-	};
-	cpu_set_t saved_mask;
-	char path[PATH_MAX];
-	int id, err, cpu, tmp;
-	union perf_event *event;
-	int count = 0;
-
-	snprintf(path, PATH_MAX, "%s/kernel/debug/tracing/events/syscalls/sys_enter_prctl/id",
-		 sysfs__mountpoint());
-
-	if (filename__read_int(path, &id)) {
-		fprintf(stderr, "error: failed to get tracepoint id: %s\n", path);
-		return -1;
-	}
-
-	attr.config = id;
-
-	cpus = perf_cpu_map__new(NULL);
-	__T("failed to create cpus", cpus);
-
-	evlist = perf_evlist__new();
-	__T("failed to create evlist", evlist);
-
-	evsel = perf_evsel__new(&attr);
-	__T("failed to create evsel1", evsel);
-
-	perf_evlist__add(evlist, evsel);
-
-	perf_evlist__set_maps(evlist, cpus, NULL);
-
-	err = perf_evlist__open(evlist);
-	__T("failed to open evlist", err == 0);
-
-	err = perf_evlist__mmap(evlist, 4);
-	__T("failed to mmap evlist", err == 0);
-
-	perf_evlist__enable(evlist);
-
-	err = sched_getaffinity(0, sizeof(saved_mask), &saved_mask);
-	__T("sched_getaffinity failed", err == 0);
-
-	perf_cpu_map__for_each_cpu(cpu, tmp, cpus) {
-		cpu_set_t mask;
-
-		CPU_ZERO(&mask);
-		CPU_SET(cpu, &mask);
-
-		err = sched_setaffinity(0, sizeof(mask), &mask);
-		__T("sched_setaffinity failed", err == 0);
-
-		prctl(0, 0, 0, 0, 0);
-	}
-
-	err = sched_setaffinity(0, sizeof(saved_mask), &saved_mask);
-	__T("sched_setaffinity failed", err == 0);
-
-	perf_evlist__disable(evlist);
-
-	perf_evlist__for_each_mmap(evlist, map, false) {
-		if (perf_mmap__read_init(map) < 0)
-			continue;
-
-		while ((event = perf_mmap__read_event(map)) != NULL) {
-			count++;
-			perf_mmap__consume(map);
-		}
-
-		perf_mmap__read_done(map);
-	}
-
-	/* calls perf_evlist__munmap/perf_evlist__close */
-	perf_evlist__delete(evlist);
-
-	/*
-	 * The generated prctl events should match the
-	 * number of cpus or be bigger (we are system-wide).
-	 */
-	__T("failed count", count >= perf_cpu_map__nr(cpus));
-
-	perf_cpu_map__put(cpus);
-
-	return 0;
-}
-
-int main(int argc, char **argv)
-{
-	__T_START;
-
-	libperf_init(libperf_print);
-
-	test_stat_cpu();
-	test_stat_thread();
-	test_stat_thread_enable();
-	test_mmap_thread();
-	test_mmap_cpus();
-
-	__T_END;
-	return 0;
-}
diff --git a/tools/perf/lib/tests/test-evsel.c b/tools/perf/lib/tests/test-evsel.c
deleted file mode 100644
index 135722ac965b..000000000000
--- a/tools/perf/lib/tests/test-evsel.c
+++ /dev/null
@@ -1,135 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <stdarg.h>
-#include <stdio.h>
-#include <linux/perf_event.h>
-#include <perf/cpumap.h>
-#include <perf/threadmap.h>
-#include <perf/evsel.h>
-#include <internal/tests.h>
-
-static int libperf_print(enum libperf_print_level level,
-			 const char *fmt, va_list ap)
-{
-	return vfprintf(stderr, fmt, ap);
-}
-
-static int test_stat_cpu(void)
-{
-	struct perf_cpu_map *cpus;
-	struct perf_evsel *evsel;
-	struct perf_event_attr attr = {
-		.type	= PERF_TYPE_SOFTWARE,
-		.config	= PERF_COUNT_SW_CPU_CLOCK,
-	};
-	int err, cpu, tmp;
-
-	cpus = perf_cpu_map__new(NULL);
-	__T("failed to create cpus", cpus);
-
-	evsel = perf_evsel__new(&attr);
-	__T("failed to create evsel", evsel);
-
-	err = perf_evsel__open(evsel, cpus, NULL);
-	__T("failed to open evsel", err == 0);
-
-	perf_cpu_map__for_each_cpu(cpu, tmp, cpus) {
-		struct perf_counts_values counts = { .val = 0 };
-
-		perf_evsel__read(evsel, cpu, 0, &counts);
-		__T("failed to read value for evsel", counts.val != 0);
-	}
-
-	perf_evsel__close(evsel);
-	perf_evsel__delete(evsel);
-
-	perf_cpu_map__put(cpus);
-	return 0;
-}
-
-static int test_stat_thread(void)
-{
-	struct perf_counts_values counts = { .val = 0 };
-	struct perf_thread_map *threads;
-	struct perf_evsel *evsel;
-	struct perf_event_attr attr = {
-		.type	= PERF_TYPE_SOFTWARE,
-		.config	= PERF_COUNT_SW_TASK_CLOCK,
-	};
-	int err;
-
-	threads = perf_thread_map__new_dummy();
-	__T("failed to create threads", threads);
-
-	perf_thread_map__set_pid(threads, 0, 0);
-
-	evsel = perf_evsel__new(&attr);
-	__T("failed to create evsel", evsel);
-
-	err = perf_evsel__open(evsel, NULL, threads);
-	__T("failed to open evsel", err == 0);
-
-	perf_evsel__read(evsel, 0, 0, &counts);
-	__T("failed to read value for evsel", counts.val != 0);
-
-	perf_evsel__close(evsel);
-	perf_evsel__delete(evsel);
-
-	perf_thread_map__put(threads);
-	return 0;
-}
-
-static int test_stat_thread_enable(void)
-{
-	struct perf_counts_values counts = { .val = 0 };
-	struct perf_thread_map *threads;
-	struct perf_evsel *evsel;
-	struct perf_event_attr attr = {
-		.type	  = PERF_TYPE_SOFTWARE,
-		.config	  = PERF_COUNT_SW_TASK_CLOCK,
-		.disabled = 1,
-	};
-	int err;
-
-	threads = perf_thread_map__new_dummy();
-	__T("failed to create threads", threads);
-
-	perf_thread_map__set_pid(threads, 0, 0);
-
-	evsel = perf_evsel__new(&attr);
-	__T("failed to create evsel", evsel);
-
-	err = perf_evsel__open(evsel, NULL, threads);
-	__T("failed to open evsel", err == 0);
-
-	perf_evsel__read(evsel, 0, 0, &counts);
-	__T("failed to read value for evsel", counts.val == 0);
-
-	err = perf_evsel__enable(evsel);
-	__T("failed to enable evsel", err == 0);
-
-	perf_evsel__read(evsel, 0, 0, &counts);
-	__T("failed to read value for evsel", counts.val != 0);
-
-	err = perf_evsel__disable(evsel);
-	__T("failed to enable evsel", err == 0);
-
-	perf_evsel__close(evsel);
-	perf_evsel__delete(evsel);
-
-	perf_thread_map__put(threads);
-	return 0;
-}
-
-int main(int argc, char **argv)
-{
-	__T_START;
-
-	libperf_init(libperf_print);
-
-	test_stat_cpu();
-	test_stat_thread();
-	test_stat_thread_enable();
-
-	__T_END;
-	return 0;
-}
diff --git a/tools/perf/lib/tests/test-threadmap.c b/tools/perf/lib/tests/test-threadmap.c
deleted file mode 100644
index 7dc4d6fbedde..000000000000
--- a/tools/perf/lib/tests/test-threadmap.c
+++ /dev/null
@@ -1,31 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <stdarg.h>
-#include <stdio.h>
-#include <perf/threadmap.h>
-#include <internal/tests.h>
-
-static int libperf_print(enum libperf_print_level level,
-			 const char *fmt, va_list ap)
-{
-	return vfprintf(stderr, fmt, ap);
-}
-
-int main(int argc, char **argv)
-{
-	struct perf_thread_map *threads;
-
-	__T_START;
-
-	libperf_init(libperf_print);
-
-	threads = perf_thread_map__new_dummy();
-	if (!threads)
-		return -1;
-
-	perf_thread_map__get(threads);
-	perf_thread_map__put(threads);
-	perf_thread_map__put(threads);
-
-	__T_END;
-	return 0;
-}
diff --git a/tools/perf/lib/threadmap.c b/tools/perf/lib/threadmap.c
deleted file mode 100644
index e92c368b0a6c..000000000000
--- a/tools/perf/lib/threadmap.c
+++ /dev/null
@@ -1,91 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <perf/threadmap.h>
-#include <stdlib.h>
-#include <linux/refcount.h>
-#include <internal/threadmap.h>
-#include <string.h>
-#include <asm/bug.h>
-#include <stdio.h>
-
-static void perf_thread_map__reset(struct perf_thread_map *map, int start, int nr)
-{
-	size_t size = (nr - start) * sizeof(map->map[0]);
-
-	memset(&map->map[start], 0, size);
-	map->err_thread = -1;
-}
-
-struct perf_thread_map *perf_thread_map__realloc(struct perf_thread_map *map, int nr)
-{
-	size_t size = sizeof(*map) + sizeof(map->map[0]) * nr;
-	int start = map ? map->nr : 0;
-
-	map = realloc(map, size);
-	/*
-	 * We only realloc to add more items, let's reset new items.
-	 */
-	if (map)
-		perf_thread_map__reset(map, start, nr);
-
-	return map;
-}
-
-#define thread_map__alloc(__nr) perf_thread_map__realloc(NULL, __nr)
-
-void perf_thread_map__set_pid(struct perf_thread_map *map, int thread, pid_t pid)
-{
-	map->map[thread].pid = pid;
-}
-
-char *perf_thread_map__comm(struct perf_thread_map *map, int thread)
-{
-	return map->map[thread].comm;
-}
-
-struct perf_thread_map *perf_thread_map__new_dummy(void)
-{
-	struct perf_thread_map *threads = thread_map__alloc(1);
-
-	if (threads != NULL) {
-		perf_thread_map__set_pid(threads, 0, -1);
-		threads->nr = 1;
-		refcount_set(&threads->refcnt, 1);
-	}
-	return threads;
-}
-
-static void perf_thread_map__delete(struct perf_thread_map *threads)
-{
-	if (threads) {
-		int i;
-
-		WARN_ONCE(refcount_read(&threads->refcnt) != 0,
-			  "thread map refcnt unbalanced\n");
-		for (i = 0; i < threads->nr; i++)
-			free(perf_thread_map__comm(threads, i));
-		free(threads);
-	}
-}
-
-struct perf_thread_map *perf_thread_map__get(struct perf_thread_map *map)
-{
-	if (map)
-		refcount_inc(&map->refcnt);
-	return map;
-}
-
-void perf_thread_map__put(struct perf_thread_map *map)
-{
-	if (map && refcount_dec_and_test(&map->refcnt))
-		perf_thread_map__delete(map);
-}
-
-int perf_thread_map__nr(struct perf_thread_map *threads)
-{
-	return threads ? threads->nr : 1;
-}
-
-pid_t perf_thread_map__pid(struct perf_thread_map *map, int thread)
-{
-	return map->map[thread].pid;
-}
diff --git a/tools/perf/lib/xyarray.c b/tools/perf/lib/xyarray.c
deleted file mode 100644
index dcd901d154bb..000000000000
--- a/tools/perf/lib/xyarray.c
+++ /dev/null
@@ -1,33 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <internal/xyarray.h>
-#include <linux/zalloc.h>
-#include <stdlib.h>
-#include <string.h>
-
-struct xyarray *xyarray__new(int xlen, int ylen, size_t entry_size)
-{
-	size_t row_size = ylen * entry_size;
-	struct xyarray *xy = zalloc(sizeof(*xy) + xlen * row_size);
-
-	if (xy != NULL) {
-		xy->entry_size = entry_size;
-		xy->row_size   = row_size;
-		xy->entries    = xlen * ylen;
-		xy->max_x      = xlen;
-		xy->max_y      = ylen;
-	}
-
-	return xy;
-}
-
-void xyarray__reset(struct xyarray *xy)
-{
-	size_t n = xy->entries * xy->entry_size;
-
-	memset(xy->contents, 0, n);
-}
-
-void xyarray__delete(struct xyarray *xy)
-{
-	free(xy);
-}
-- 
2.21.0

