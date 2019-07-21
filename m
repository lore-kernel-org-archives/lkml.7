Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B59C76195
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FAA620578
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563708796;
	bh=yu/fFq7jFm8OBSZJCa1px8MulhNh8gqUFNdXzV3Xwic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RsO2DwBqWFkLT6/b0RodiEuEk/j/JmjkJ+jVXUqvxDTpEW1v6itekizPFc+verTxW
	 o4NMqkF0clYe6OjkSaY9EUTXoWwX+NlkysUO9j5QYV72+rSlyvx0ZhJcjVj+4q+6Sp
	 DS3SIvlk2zs7AFucPqWz9LgTUp/694bLG9hEGiiI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbfGULdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 07:33:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40066 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbfGULdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 07:33:14 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E31DF3082E24;
        Sun, 21 Jul 2019 11:33:13 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-23.brq.redhat.com [10.40.204.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D5D8E5D9D3;
        Sun, 21 Jul 2019 11:33:09 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 79/79] libperf: Initial documentation
Date:   Sun, 21 Jul 2019 13:25:06 +0200
Message-Id: <20190721112506.12306-80-jolsa@kernel.org>
In-Reply-To: <20190721112506.12306-1-jolsa@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Sun, 21 Jul 2019 11:33:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding initial drafts of documentation files,
hugely unfinished.

Link: http://lkml.kernel.org/n/tip-aabha27sybyctxfpbdjwyfr2@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/Documentation/Makefile         |   7 +
 tools/perf/lib/Documentation/man/libperf.rst  | 102 +++++++++++++++
 .../lib/Documentation/tutorial/tutorial.rst   | 123 ++++++++++++++++++
 3 files changed, 232 insertions(+)
 create mode 100644 tools/perf/lib/Documentation/Makefile
 create mode 100644 tools/perf/lib/Documentation/man/libperf.rst
 create mode 100644 tools/perf/lib/Documentation/tutorial/tutorial.rst

diff --git a/tools/perf/lib/Documentation/Makefile b/tools/perf/lib/Documentation/Makefile
new file mode 100644
index 000000000000..586425a88795
--- /dev/null
+++ b/tools/perf/lib/Documentation/Makefile
@@ -0,0 +1,7 @@
+all:
+	rst2man man/libperf.rst > man/libperf.7
+	rst2pdf tutorial/tutorial.rst
+
+clean:
+	rm -f man/libperf.7
+	rm -f tutorial/tutorial.pdf
diff --git a/tools/perf/lib/Documentation/man/libperf.rst b/tools/perf/lib/Documentation/man/libperf.rst
new file mode 100644
index 000000000000..34fb93e41f5c
--- /dev/null
+++ b/tools/perf/lib/Documentation/man/libperf.rst
@@ -0,0 +1,102 @@
+.. SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+
+=======
+libperf
+=======
+
+The libperf library provides API to access linux kernel perf
+events subsystem. It provides following high level object:
+
+  - struct perf_cpu_map
+  - struct perf_thread_map
+  - struct perf_evlist
+  - struct perf_evsel
+
+reference
+=========
+Function refference by header files:
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
diff --git a/tools/perf/lib/Documentation/tutorial/tutorial.rst b/tools/perf/lib/Documentation/tutorial/tutorial.rst
new file mode 100644
index 000000000000..8ea72e3b2de9
--- /dev/null
+++ b/tools/perf/lib/Documentation/tutorial/tutorial.rst
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
+  Provides cpu list abstraction.
+
+struct perf_thread_map
+  Provides thread list abstraction.
+
+struct perf_evsel
+  Provides abstraction for single perf event.
+
+struct perf_evlist
+  Gathers several struct perf_evsel object and performs function on all of them.
+
+The exported API binds these objects together,
+for full reference see libperf.7 man page.
+
+Examples
+========
+Examples aim to explain libperf functionality on simple use cases.
+They are based in linux kernel git tree path:
+
+.. code-block:: bash
+
+  $ cd tools/perf/lib/Documentation/tutorial/
+  $ ls -d  ex-*
+  ex-1-compile  ex-2-evsel-stat  ex-3-evlist-stat
+
+ex-1-compile example
+====================
+This example shows basic usage of *struct perf_cpu_map*,
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
+First you need to include proper header to have *struct perf_cpumap*
+declaration and functions:
+
+.. code-block:: c
+
+   1 #include <perf/cpumap.h>
+
+
+The *struct perf_cpumap* object is created by *perf_cpu_map__new* call.
+The *NULL* argument populates the object with the current online cpus list:
+
+.. code-block:: c
+
+   8         cpus = perf_cpu_map__new(NULL);
+
+This is paired with *perf_cpu_map__put*, that destroys it  at the end:
+
+.. code-block:: c
+
+  15         perf_cpu_map__put(cpus);
+
+The iteration through the *struct perf_cpumap* cpus is done by *perf_cpu_map__for_each_cpu*
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
-- 
2.21.0

