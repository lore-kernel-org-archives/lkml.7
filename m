Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2276C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F8CF2377B
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567340700;
	bh=eUf/tY/Ebp24h9eKXU/5g3IP95DY7T2QipTxDpHKHII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ig/Ld4xtnhDIP+Im0n+iapYLd2eKUmk8dMAshGq5HJo1dd9cI8SdXx2RoQLt2yniO
	 CHf+9QX8cchmIbf9kM56TXPZcRJGo2u+0NCbdkm3H8e4Bv7cy5kuU9StnFS2Pck/a2
	 N+Iv7Ty33O2aYe9YFV+yvS6epbBKGG3qO00zGxVg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbfIAMY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 08:24:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:42106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729138AbfIAMY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 08:24:56 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3305923431;
        Sun,  1 Sep 2019 12:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567340693;
        bh=eUf/tY/Ebp24h9eKXU/5g3IP95DY7T2QipTxDpHKHII=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d2wKrSLK0X7bwsx4EI3wJwTiWOgz8rrKobFwusR14iS47xowutLHwIZcL2LNgNteG
         JStnJ/nTdnVMz7p7As7wzPNJOvUYHxhWiHLg4O+rqmHdTDpTow9avYXGiGltTWxJkd
         lh6JseaLJChHcyij5HgupWsQWv1zRXziKXTOwtBc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 26/47] perf dsos: Move the dsos struct and its methods to separate source files
Date:   Sun,  1 Sep 2019 09:23:05 -0300
Message-Id: <20190901122326.5793-27-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190901122326.5793-1-acme@kernel.org>
References: <20190901122326.5793-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

So that we can reduce the header dependency tree further, in the process
noticed that lots of places were getting even things like build-id
routines and 'struct perf_tool' definition indirectly, so fix all those
too.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-ti0btma9ow5ndrytyoqdk62j@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-annotate.c                 |   1 +
 tools/perf/builtin-buildid-cache.c            |   1 +
 tools/perf/builtin-buildid-list.c             |   1 +
 tools/perf/builtin-inject.c                   |   1 +
 tools/perf/builtin-kallsyms.c                 |   1 +
 tools/perf/builtin-kmem.c                     |   1 +
 tools/perf/builtin-kvm.c                      |   1 +
 tools/perf/builtin-mem.c                      |   1 +
 tools/perf/builtin-report.c                   |   1 +
 tools/perf/builtin-script.c                   |   1 +
 tools/perf/builtin-top.c                      |   1 +
 tools/perf/builtin-trace.c                    |   2 +
 tools/perf/tests/code-reading.c               |   1 +
 tools/perf/tests/dso-data.c                   |   1 +
 tools/perf/tests/dwarf-unwind.c               |   1 +
 tools/perf/tests/event_update.c               |   1 +
 tools/perf/tests/hists_common.c               |   1 +
 tools/perf/tests/hists_cumulate.c             |   1 +
 tools/perf/tests/hists_output.c               |   1 +
 tools/perf/tests/vmlinux-kallsyms.c           |   1 +
 tools/perf/ui/browsers/annotate.c             |   1 +
 tools/perf/ui/browsers/hists.c                |   1 +
 tools/perf/util/Build                         |   1 +
 tools/perf/util/bpf-event.c                   |   1 +
 tools/perf/util/callchain.c                   |   1 +
 tools/perf/util/cs-etm.c                      |   2 +
 tools/perf/util/db-export.c                   |   1 +
 tools/perf/util/dso.c                         | 235 +-----------------
 tools/perf/util/dso.h                         |  25 +-
 tools/perf/util/dsos.c                        | 232 +++++++++++++++++
 tools/perf/util/dsos.h                        |  44 ++++
 tools/perf/util/event.c                       |   2 +
 tools/perf/util/header.c                      |   1 +
 tools/perf/util/hist.c                        |   1 +
 tools/perf/util/intel-bts.c                   |   1 +
 tools/perf/util/jitdump.c                     |   1 +
 tools/perf/util/machine.c                     |   1 +
 tools/perf/util/machine.h                     |   3 +-
 tools/perf/util/map.c                         |   1 +
 tools/perf/util/parse-events.c                |   1 +
 tools/perf/util/probe-event.c                 |   2 +
 tools/perf/util/s390-cpumsf.c                 |   1 +
 .../util/scripting-engines/trace-event-perl.c |   1 +
 .../scripting-engines/trace-event-python.c    |   2 +
 tools/perf/util/sort.c                        |   1 +
 tools/perf/util/thread.c                      |   1 +
 tools/perf/util/unwind-libdw.c                |   1 +
 tools/perf/util/unwind-libunwind.c            |   1 +
 tools/perf/util/vdso.c                        |   1 +
 49 files changed, 331 insertions(+), 257 deletions(-)
 create mode 100644 tools/perf/util/dsos.c
 create mode 100644 tools/perf/util/dsos.h

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 9bb637165bf9..738471a0a549 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -27,6 +27,7 @@
 #include "util/thread.h"
 #include "util/sort.h"
 #include "util/hist.h"
+#include "util/dso.h"
 #include "util/map.h"
 #include "util/session.h"
 #include "util/tool.h"
diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
index 9e756004ef28..b035911969b8 100644
--- a/tools/perf/builtin-buildid-cache.c
+++ b/tools/perf/builtin-buildid-cache.c
@@ -22,6 +22,7 @@
 #include "util/strlist.h"
 #include "util/build-id.h"
 #include "util/session.h"
+#include "util/dso.h"
 #include "util/symbol.h"
 #include "util/time-utils.h"
 #include "util/util.h"
diff --git a/tools/perf/builtin-buildid-list.c b/tools/perf/builtin-buildid-list.c
index 72bdc0eba990..38b2ec61c021 100644
--- a/tools/perf/builtin-buildid-list.c
+++ b/tools/perf/builtin-buildid-list.c
@@ -12,6 +12,7 @@
 #include "util/build-id.h"
 #include "util/cache.h"
 #include "util/debug.h"
+#include "util/dso.h"
 #include <subcmd/parse-options.h>
 #include "util/session.h"
 #include "util/symbol.h"
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index ae46de46e826..c14f40b858bc 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -9,6 +9,7 @@
 #include "builtin.h"
 
 #include "util/color.h"
+#include "util/dso.h"
 #include "util/evlist.h"
 #include "util/evsel.h"
 #include "util/map.h"
diff --git a/tools/perf/builtin-kallsyms.c b/tools/perf/builtin-kallsyms.c
index c1a44671b0b5..c08ee81529e8 100644
--- a/tools/perf/builtin-kallsyms.c
+++ b/tools/perf/builtin-kallsyms.c
@@ -11,6 +11,7 @@
 #include <linux/compiler.h>
 #include <subcmd/parse-options.h>
 #include "debug.h"
+#include "dso.h"
 #include "machine.h"
 #include "map.h"
 #include "symbol.h"
diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 378b09c910a8..b5682beaad72 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -2,6 +2,7 @@
 #include "builtin.h"
 #include "perf.h"
 
+#include "util/dso.h"
 #include "util/evlist.h"
 #include "util/evsel.h"
 #include "util/config.h"
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 69d16ac852c3..474c4799d29d 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -2,6 +2,7 @@
 #include "builtin.h"
 #include "perf.h"
 
+#include "util/build-id.h"
 #include "util/evsel.h"
 #include "util/evlist.h"
 #include "util/term.h"
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 9e60eda9297d..c5f3b9e9509d 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -13,6 +13,7 @@
 #include "util/data.h"
 #include "util/mem-events.h"
 #include "util/debug.h"
+#include "util/dso.h"
 #include "util/map.h"
 #include "util/symbol.h"
 
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 94e7e354cb16..ba419ee40283 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -12,6 +12,7 @@
 
 #include "util/annotate.h"
 #include "util/color.h"
+#include "util/dso.h"
 #include <linux/list.h>
 #include <linux/rbtree.h>
 #include <linux/err.h>
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index f3b31c6ed15f..1ff04b00a561 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -4,6 +4,7 @@
 #include "util/cache.h"
 #include "util/counts.h"
 #include "util/debug.h"
+#include "util/dso.h"
 #include <subcmd/exec-cmd.h>
 #include "util/header.h"
 #include <subcmd/parse-options.h>
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 5538b5886e35..0b7b12cfdd63 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -24,6 +24,7 @@
 #include "util/bpf-event.h"
 #include "util/config.h"
 #include "util/color.h"
+#include "util/dso.h"
 #include "util/evlist.h"
 #include "util/evsel.h"
 #include "util/event.h"
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index b1ec8ff52740..0f633f0d6be8 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -25,6 +25,7 @@
 #include "util/color.h"
 #include "util/config.h"
 #include "util/debug.h"
+#include "util/dso.h"
 #include "util/env.h"
 #include "util/event.h"
 #include "util/evlist.h"
@@ -42,6 +43,7 @@
 #include "util/intlist.h"
 #include "util/thread_map.h"
 #include "util/stat.h"
+#include "util/tool.h"
 #include "util/util.h"
 #include "trace/beauty/beauty.h"
 #include "trace-event.h"
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index c4b73bb4b113..7b2b89f4b716 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -12,6 +12,7 @@
 #include <perf/evlist.h>
 
 #include "debug.h"
+#include "dso.h"
 #include "parse-events.h"
 #include "evlist.h"
 #include "evsel.h"
diff --git a/tools/perf/tests/dso-data.c b/tools/perf/tests/dso-data.c
index 946ab4b63acd..a4874d4ce7ef 100644
--- a/tools/perf/tests/dso-data.c
+++ b/tools/perf/tests/dso-data.c
@@ -9,6 +9,7 @@
 #include <sys/time.h>
 #include <sys/resource.h>
 #include <api/fs/fs.h>
+#include "dso.h"
 #include "util.h"
 #include "machine.h"
 #include "symbol.h"
diff --git a/tools/perf/tests/dwarf-unwind.c b/tools/perf/tests/dwarf-unwind.c
index f33709a79335..4125255ff637 100644
--- a/tools/perf/tests/dwarf-unwind.c
+++ b/tools/perf/tests/dwarf-unwind.c
@@ -3,6 +3,7 @@
 #include <linux/types.h>
 #include <linux/zalloc.h>
 #include <inttypes.h>
+#include <limits.h>
 #include <unistd.h>
 #include "tests.h"
 #include "debug.h"
diff --git a/tools/perf/tests/event_update.c b/tools/perf/tests/event_update.c
index 1411155597b8..4b68ec3a13fc 100644
--- a/tools/perf/tests/event_update.c
+++ b/tools/perf/tests/event_update.c
@@ -4,6 +4,7 @@
 #include "evlist.h"
 #include "evsel.h"
 #include "machine.h"
+#include "tool.h"
 #include "tests.h"
 #include "debug.h"
 
diff --git a/tools/perf/tests/hists_common.c b/tools/perf/tests/hists_common.c
index 96ad95d3f338..cdde41c03056 100644
--- a/tools/perf/tests/hists_common.c
+++ b/tools/perf/tests/hists_common.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <inttypes.h>
 #include "util/debug.h"
+#include "util/dso.h"
 #include "util/map.h"
 #include "util/symbol.h"
 #include "util/sort.h"
diff --git a/tools/perf/tests/hists_cumulate.c b/tools/perf/tests/hists_cumulate.c
index 93af420ad2e4..fa55b7bad3af 100644
--- a/tools/perf/tests/hists_cumulate.c
+++ b/tools/perf/tests/hists_cumulate.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "util/debug.h"
+#include "util/dso.h"
 #include "util/event.h"
 #include "util/map.h"
 #include "util/symbol.h"
diff --git a/tools/perf/tests/hists_output.c b/tools/perf/tests/hists_output.c
index 07f4ca0704fb..3f6dfa212260 100644
--- a/tools/perf/tests/hists_output.c
+++ b/tools/perf/tests/hists_output.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "util/debug.h"
+#include "util/dso.h"
 #include "util/event.h"
 #include "util/map.h"
 #include "util/symbol.h"
diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index 5e8834fc7dec..01f434c067c6 100644
--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -4,6 +4,7 @@
 #include <inttypes.h>
 #include <string.h>
 #include <stdlib.h>
+#include "dso.h"
 #include "map.h"
 #include "symbol.h"
 #include "util.h"
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 715601f5fce3..ac74ed2c23a0 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -5,6 +5,7 @@
 #include "../util.h"
 #include "../../util/annotate.h"
 #include "../../util/debug.h"
+#include "../../util/dso.h"
 #include "../../util/hist.h"
 #include "../../util/sort.h"
 #include "../../util/map.h"
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index a14dda74f43a..cf8857456056 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -12,6 +12,7 @@
 #include <linux/zalloc.h>
 
 #include "../../util/debug.h"
+#include "../../util/dso.h"
 #include "../../util/callchain.h"
 #include "../../util/evsel.h"
 #include "../../util/evlist.h"
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 2e3856471e61..0b4d8e0d474c 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -36,6 +36,7 @@ perf-y += strfilter.o
 perf-y += top.o
 perf-y += usage.o
 perf-y += dso.o
+perf-y += dsos.o
 perf-y += symbol.o
 perf-y += symbol_fprintf.o
 perf-y += color.o
diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 2d6d500c9af7..7a3d4b125323 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -8,6 +8,7 @@
 #include <linux/err.h>
 #include "bpf-event.h"
 #include "debug.h"
+#include "dso.h"
 #include "symbol.h"
 #include "machine.h"
 #include "env.h"
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 76bf05b26d3b..c14646c1f2eb 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -22,6 +22,7 @@
 #include "asm/bug.h"
 
 #include "debug.h"
+#include "dso.h"
 #include "hist.h"
 #include "sort.h"
 #include "machine.h"
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index d6de3834865e..3ed1d3bb7089 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -21,12 +21,14 @@
 #include "cs-etm.h"
 #include "cs-etm-decoder/cs-etm-decoder.h"
 #include "debug.h"
+#include "dso.h"
 #include "evlist.h"
 #include "intlist.h"
 #include "machine.h"
 #include "map.h"
 #include "perf.h"
 #include "symbol.h"
+#include "tool.h"
 #include "thread.h"
 #include "thread_map.h"
 #include "thread-stack.h"
diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index 701e9f814313..752227b265e7 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -7,6 +7,7 @@
 #include <errno.h>
 #include <stdlib.h>
 
+#include "dso.h"
 #include "evsel.h"
 #include "machine.h"
 #include "thread.h"
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index ebc9d46c15a7..ece97209792d 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -10,7 +10,6 @@
 #include <unistd.h>
 #include <errno.h>
 #include <fcntl.h>
-#include <libgen.h>
 #include <bpf/libbpf.h>
 #include "bpf-event.h"
 #include "compress.h"
@@ -20,6 +19,7 @@
 #include "symbol.h"
 #include "srcline.h"
 #include "dso.h"
+#include "dsos.h"
 #include "machine.h"
 #include "auxtrace.h"
 #include "util.h" /* O_CLOEXEC for older systems */
@@ -1094,66 +1094,6 @@ struct dso *machine__findnew_kernel(struct machine *machine, const char *name,
 	return dso;
 }
 
-/*
- * Find a matching entry and/or link current entry to RB tree.
- * Either one of the dso or name parameter must be non-NULL or the
- * function will not work.
- */
-static struct dso *__dso__findlink_by_longname(struct rb_root *root,
-					       struct dso *dso, const char *name)
-{
-	struct rb_node **p = &root->rb_node;
-	struct rb_node  *parent = NULL;
-
-	if (!name)
-		name = dso->long_name;
-	/*
-	 * Find node with the matching name
-	 */
-	while (*p) {
-		struct dso *this = rb_entry(*p, struct dso, rb_node);
-		int rc = strcmp(name, this->long_name);
-
-		parent = *p;
-		if (rc == 0) {
-			/*
-			 * In case the new DSO is a duplicate of an existing
-			 * one, print a one-time warning & put the new entry
-			 * at the end of the list of duplicates.
-			 */
-			if (!dso || (dso == this))
-				return this;	/* Find matching dso */
-			/*
-			 * The core kernel DSOs may have duplicated long name.
-			 * In this case, the short name should be different.
-			 * Comparing the short names to differentiate the DSOs.
-			 */
-			rc = strcmp(dso->short_name, this->short_name);
-			if (rc == 0) {
-				pr_err("Duplicated dso name: %s\n", name);
-				return NULL;
-			}
-		}
-		if (rc < 0)
-			p = &parent->rb_left;
-		else
-			p = &parent->rb_right;
-	}
-	if (dso) {
-		/* Add new node and rebalance tree */
-		rb_link_node(&dso->rb_node, parent, p);
-		rb_insert_color(&dso->rb_node, root);
-		dso->root = root;
-	}
-	return NULL;
-}
-
-static inline struct dso *__dso__find_by_longname(struct rb_root *root,
-						  const char *name)
-{
-	return __dso__findlink_by_longname(root, NULL, name);
-}
-
 void dso__set_long_name(struct dso *dso, const char *name, bool name_allocated)
 {
 	struct rb_root *root = dso->root;
@@ -1167,7 +1107,7 @@ void dso__set_long_name(struct dso *dso, const char *name, bool name_allocated)
 	if (root) {
 		rb_erase(&dso->rb_node, root);
 		/*
-		 * __dso__findlink_by_longname() isn't guaranteed to add it
+		 * __dsos__findnew_link_by_longname() isn't guaranteed to add it
 		 * back, so a clean removal is required here.
 		 */
 		RB_CLEAR_NODE(&dso->rb_node);
@@ -1179,7 +1119,7 @@ void dso__set_long_name(struct dso *dso, const char *name, bool name_allocated)
 	dso->long_name_allocated = name_allocated;
 
 	if (root)
-		__dso__findlink_by_longname(root, dso, NULL);
+		__dsos__findnew_link_by_longname(root, dso, NULL);
 }
 
 void dso__set_short_name(struct dso *dso, const char *name, bool name_allocated)
@@ -1195,38 +1135,6 @@ void dso__set_short_name(struct dso *dso, const char *name, bool name_allocated)
 	dso->short_name_allocated = name_allocated;
 }
 
-static void dso__set_basename(struct dso *dso)
-{
-	char *base, *lname;
-	int tid;
-
-	if (sscanf(dso->long_name, "/tmp/perf-%d.map", &tid) == 1) {
-		if (asprintf(&base, "[JIT] tid %d", tid) < 0)
-			return;
-	} else {
-	      /*
-	       * basename() may modify path buffer, so we must pass
-               * a copy.
-               */
-		lname = strdup(dso->long_name);
-		if (!lname)
-			return;
-
-		/*
-		 * basename() may return a pointer to internal
-		 * storage which is reused in subsequent calls
-		 * so copy the result.
-		 */
-		base = strdup(basename(lname));
-
-		free(lname);
-
-		if (!base)
-			return;
-	}
-	dso__set_short_name(dso, base, true);
-}
-
 int dso__name_len(const struct dso *dso)
 {
 	if (!dso)
@@ -1377,143 +1285,6 @@ int dso__kernel_module_get_build_id(struct dso *dso,
 	return 0;
 }
 
-bool __dsos__read_build_ids(struct list_head *head, bool with_hits)
-{
-	bool have_build_id = false;
-	struct dso *pos;
-	struct nscookie nsc;
-
-	list_for_each_entry(pos, head, node) {
-		if (with_hits && !pos->hit && !dso__is_vdso(pos))
-			continue;
-		if (pos->has_build_id) {
-			have_build_id = true;
-			continue;
-		}
-		nsinfo__mountns_enter(pos->nsinfo, &nsc);
-		if (filename__read_build_id(pos->long_name, pos->build_id,
-					    sizeof(pos->build_id)) > 0) {
-			have_build_id	  = true;
-			pos->has_build_id = true;
-		}
-		nsinfo__mountns_exit(&nsc);
-	}
-
-	return have_build_id;
-}
-
-void __dsos__add(struct dsos *dsos, struct dso *dso)
-{
-	list_add_tail(&dso->node, &dsos->head);
-	__dso__findlink_by_longname(&dsos->root, dso, NULL);
-	/*
-	 * It is now in the linked list, grab a reference, then garbage collect
-	 * this when needing memory, by looking at LRU dso instances in the
-	 * list with atomic_read(&dso->refcnt) == 1, i.e. no references
-	 * anywhere besides the one for the list, do, under a lock for the
-	 * list: remove it from the list, then a dso__put(), that probably will
-	 * be the last and will then call dso__delete(), end of life.
-	 *
-	 * That, or at the end of the 'struct machine' lifetime, when all
-	 * 'struct dso' instances will be removed from the list, in
-	 * dsos__exit(), if they have no other reference from some other data
-	 * structure.
-	 *
-	 * E.g.: after processing a 'perf.data' file and storing references
-	 * to objects instantiated while processing events, we will have
-	 * references to the 'thread', 'map', 'dso' structs all from 'struct
-	 * hist_entry' instances, but we may not need anything not referenced,
-	 * so we might as well call machines__exit()/machines__delete() and
-	 * garbage collect it.
-	 */
-	dso__get(dso);
-}
-
-void dsos__add(struct dsos *dsos, struct dso *dso)
-{
-	down_write(&dsos->lock);
-	__dsos__add(dsos, dso);
-	up_write(&dsos->lock);
-}
-
-struct dso *__dsos__find(struct dsos *dsos, const char *name, bool cmp_short)
-{
-	struct dso *pos;
-
-	if (cmp_short) {
-		list_for_each_entry(pos, &dsos->head, node)
-			if (strcmp(pos->short_name, name) == 0)
-				return pos;
-		return NULL;
-	}
-	return __dso__find_by_longname(&dsos->root, name);
-}
-
-struct dso *dsos__find(struct dsos *dsos, const char *name, bool cmp_short)
-{
-	struct dso *dso;
-	down_read(&dsos->lock);
-	dso = __dsos__find(dsos, name, cmp_short);
-	up_read(&dsos->lock);
-	return dso;
-}
-
-struct dso *__dsos__addnew(struct dsos *dsos, const char *name)
-{
-	struct dso *dso = dso__new(name);
-
-	if (dso != NULL) {
-		__dsos__add(dsos, dso);
-		dso__set_basename(dso);
-		/* Put dso here because __dsos_add already got it */
-		dso__put(dso);
-	}
-	return dso;
-}
-
-struct dso *__dsos__findnew(struct dsos *dsos, const char *name)
-{
-	struct dso *dso = __dsos__find(dsos, name, false);
-
-	return dso ? dso : __dsos__addnew(dsos, name);
-}
-
-struct dso *dsos__findnew(struct dsos *dsos, const char *name)
-{
-	struct dso *dso;
-	down_write(&dsos->lock);
-	dso = dso__get(__dsos__findnew(dsos, name));
-	up_write(&dsos->lock);
-	return dso;
-}
-
-size_t __dsos__fprintf_buildid(struct list_head *head, FILE *fp,
-			       bool (skip)(struct dso *dso, int parm), int parm)
-{
-	struct dso *pos;
-	size_t ret = 0;
-
-	list_for_each_entry(pos, head, node) {
-		if (skip && skip(pos, parm))
-			continue;
-		ret += dso__fprintf_buildid(pos, fp);
-		ret += fprintf(fp, " %s\n", pos->long_name);
-	}
-	return ret;
-}
-
-size_t __dsos__fprintf(struct list_head *head, FILE *fp)
-{
-	struct dso *pos;
-	size_t ret = 0;
-
-	list_for_each_entry(pos, head, node) {
-		ret += dso__fprintf(pos, fp);
-	}
-
-	return ret;
-}
-
 size_t dso__fprintf_buildid(struct dso *dso, FILE *fp)
 {
 	char sbuild_id[SBUILD_ID_SIZE];
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index ff0b81854628..e4dddb76770d 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -2,13 +2,13 @@
 #ifndef __PERF_DSO
 #define __PERF_DSO
 
+#include <pthread.h>
 #include <linux/refcount.h>
 #include <linux/types.h>
 #include <linux/rbtree.h>
 #include <sys/types.h>
 #include <stdbool.h>
 #include <stdio.h>
-#include "rwsem.h"
 #include <linux/bitops.h>
 #include "build-id.h"
 
@@ -129,16 +129,6 @@ struct dso_cache {
 	char data[0];
 };
 
-/*
- * DSOs are put into both a list for fast iteration and rbtree for fast
- * long name lookup.
- */
-struct dsos {
-	struct list_head head;
-	struct rb_root	 root;	/* rbtree root sorted by long name */
-	struct rw_semaphore lock;
-};
-
 struct auxtrace_cache;
 
 struct dso {
@@ -347,21 +337,8 @@ struct map *dso__new_map(const char *name);
 struct dso *machine__findnew_kernel(struct machine *machine, const char *name,
 				    const char *short_name, int dso_type);
 
-void __dsos__add(struct dsos *dsos, struct dso *dso);
-void dsos__add(struct dsos *dsos, struct dso *dso);
-struct dso *__dsos__addnew(struct dsos *dsos, const char *name);
-struct dso *__dsos__find(struct dsos *dsos, const char *name, bool cmp_short);
-struct dso *dsos__find(struct dsos *dsos, const char *name, bool cmp_short);
-struct dso *__dsos__findnew(struct dsos *dsos, const char *name);
-struct dso *dsos__findnew(struct dsos *dsos, const char *name);
-bool __dsos__read_build_ids(struct list_head *head, bool with_hits);
-
 void dso__reset_find_symbol_cache(struct dso *dso);
 
-size_t __dsos__fprintf_buildid(struct list_head *head, FILE *fp,
-			       bool (skip)(struct dso *dso, int parm), int parm);
-size_t __dsos__fprintf(struct list_head *head, FILE *fp);
-
 size_t dso__fprintf_buildid(struct dso *dso, FILE *fp);
 size_t dso__fprintf_symbols_by_name(struct dso *dso, FILE *fp);
 size_t dso__fprintf(struct dso *dso, FILE *fp);
diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
new file mode 100644
index 000000000000..3ea80d203587
--- /dev/null
+++ b/tools/perf/util/dsos.c
@@ -0,0 +1,232 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "debug.h"
+#include "dsos.h"
+#include "dso.h"
+#include "vdso.h"
+#include "namespaces.h"
+#include <libgen.h>
+#include <stdlib.h>
+#include <string.h>
+#include <symbol.h> // filename__read_build_id
+
+bool __dsos__read_build_ids(struct list_head *head, bool with_hits)
+{
+	bool have_build_id = false;
+	struct dso *pos;
+	struct nscookie nsc;
+
+	list_for_each_entry(pos, head, node) {
+		if (with_hits && !pos->hit && !dso__is_vdso(pos))
+			continue;
+		if (pos->has_build_id) {
+			have_build_id = true;
+			continue;
+		}
+		nsinfo__mountns_enter(pos->nsinfo, &nsc);
+		if (filename__read_build_id(pos->long_name, pos->build_id,
+					    sizeof(pos->build_id)) > 0) {
+			have_build_id	  = true;
+			pos->has_build_id = true;
+		}
+		nsinfo__mountns_exit(&nsc);
+	}
+
+	return have_build_id;
+}
+
+/*
+ * Find a matching entry and/or link current entry to RB tree.
+ * Either one of the dso or name parameter must be non-NULL or the
+ * function will not work.
+ */
+struct dso *__dsos__findnew_link_by_longname(struct rb_root *root, struct dso *dso, const char *name)
+{
+	struct rb_node **p = &root->rb_node;
+	struct rb_node  *parent = NULL;
+
+	if (!name)
+		name = dso->long_name;
+	/*
+	 * Find node with the matching name
+	 */
+	while (*p) {
+		struct dso *this = rb_entry(*p, struct dso, rb_node);
+		int rc = strcmp(name, this->long_name);
+
+		parent = *p;
+		if (rc == 0) {
+			/*
+			 * In case the new DSO is a duplicate of an existing
+			 * one, print a one-time warning & put the new entry
+			 * at the end of the list of duplicates.
+			 */
+			if (!dso || (dso == this))
+				return this;	/* Find matching dso */
+			/*
+			 * The core kernel DSOs may have duplicated long name.
+			 * In this case, the short name should be different.
+			 * Comparing the short names to differentiate the DSOs.
+			 */
+			rc = strcmp(dso->short_name, this->short_name);
+			if (rc == 0) {
+				pr_err("Duplicated dso name: %s\n", name);
+				return NULL;
+			}
+		}
+		if (rc < 0)
+			p = &parent->rb_left;
+		else
+			p = &parent->rb_right;
+	}
+	if (dso) {
+		/* Add new node and rebalance tree */
+		rb_link_node(&dso->rb_node, parent, p);
+		rb_insert_color(&dso->rb_node, root);
+		dso->root = root;
+	}
+	return NULL;
+}
+
+void __dsos__add(struct dsos *dsos, struct dso *dso)
+{
+	list_add_tail(&dso->node, &dsos->head);
+	__dsos__findnew_link_by_longname(&dsos->root, dso, NULL);
+	/*
+	 * It is now in the linked list, grab a reference, then garbage collect
+	 * this when needing memory, by looking at LRU dso instances in the
+	 * list with atomic_read(&dso->refcnt) == 1, i.e. no references
+	 * anywhere besides the one for the list, do, under a lock for the
+	 * list: remove it from the list, then a dso__put(), that probably will
+	 * be the last and will then call dso__delete(), end of life.
+	 *
+	 * That, or at the end of the 'struct machine' lifetime, when all
+	 * 'struct dso' instances will be removed from the list, in
+	 * dsos__exit(), if they have no other reference from some other data
+	 * structure.
+	 *
+	 * E.g.: after processing a 'perf.data' file and storing references
+	 * to objects instantiated while processing events, we will have
+	 * references to the 'thread', 'map', 'dso' structs all from 'struct
+	 * hist_entry' instances, but we may not need anything not referenced,
+	 * so we might as well call machines__exit()/machines__delete() and
+	 * garbage collect it.
+	 */
+	dso__get(dso);
+}
+
+void dsos__add(struct dsos *dsos, struct dso *dso)
+{
+	down_write(&dsos->lock);
+	__dsos__add(dsos, dso);
+	up_write(&dsos->lock);
+}
+
+struct dso *__dsos__find(struct dsos *dsos, const char *name, bool cmp_short)
+{
+	struct dso *pos;
+
+	if (cmp_short) {
+		list_for_each_entry(pos, &dsos->head, node)
+			if (strcmp(pos->short_name, name) == 0)
+				return pos;
+		return NULL;
+	}
+	return __dsos__findnew_by_longname(&dsos->root, name);
+}
+
+struct dso *dsos__find(struct dsos *dsos, const char *name, bool cmp_short)
+{
+	struct dso *dso;
+	down_read(&dsos->lock);
+	dso = __dsos__find(dsos, name, cmp_short);
+	up_read(&dsos->lock);
+	return dso;
+}
+
+static void dso__set_basename(struct dso *dso)
+{
+	char *base, *lname;
+	int tid;
+
+	if (sscanf(dso->long_name, "/tmp/perf-%d.map", &tid) == 1) {
+		if (asprintf(&base, "[JIT] tid %d", tid) < 0)
+			return;
+	} else {
+	      /*
+	       * basename() may modify path buffer, so we must pass
+               * a copy.
+               */
+		lname = strdup(dso->long_name);
+		if (!lname)
+			return;
+
+		/*
+		 * basename() may return a pointer to internal
+		 * storage which is reused in subsequent calls
+		 * so copy the result.
+		 */
+		base = strdup(basename(lname));
+
+		free(lname);
+
+		if (!base)
+			return;
+	}
+	dso__set_short_name(dso, base, true);
+}
+
+struct dso *__dsos__addnew(struct dsos *dsos, const char *name)
+{
+	struct dso *dso = dso__new(name);
+
+	if (dso != NULL) {
+		__dsos__add(dsos, dso);
+		dso__set_basename(dso);
+		/* Put dso here because __dsos_add already got it */
+		dso__put(dso);
+	}
+	return dso;
+}
+
+struct dso *__dsos__findnew(struct dsos *dsos, const char *name)
+{
+	struct dso *dso = __dsos__find(dsos, name, false);
+
+	return dso ? dso : __dsos__addnew(dsos, name);
+}
+
+struct dso *dsos__findnew(struct dsos *dsos, const char *name)
+{
+	struct dso *dso;
+	down_write(&dsos->lock);
+	dso = dso__get(__dsos__findnew(dsos, name));
+	up_write(&dsos->lock);
+	return dso;
+}
+
+size_t __dsos__fprintf_buildid(struct list_head *head, FILE *fp,
+			       bool (skip)(struct dso *dso, int parm), int parm)
+{
+	struct dso *pos;
+	size_t ret = 0;
+
+	list_for_each_entry(pos, head, node) {
+		if (skip && skip(pos, parm))
+			continue;
+		ret += dso__fprintf_buildid(pos, fp);
+		ret += fprintf(fp, " %s\n", pos->long_name);
+	}
+	return ret;
+}
+
+size_t __dsos__fprintf(struct list_head *head, FILE *fp)
+{
+	struct dso *pos;
+	size_t ret = 0;
+
+	list_for_each_entry(pos, head, node) {
+		ret += dso__fprintf(pos, fp);
+	}
+
+	return ret;
+}
diff --git a/tools/perf/util/dsos.h b/tools/perf/util/dsos.h
new file mode 100644
index 000000000000..32f1fbee0feb
--- /dev/null
+++ b/tools/perf/util/dsos.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PERF_DSOS
+#define __PERF_DSOS
+
+#include <stdbool.h>
+#include <stdio.h>
+#include <linux/list.h>
+#include <linux/rbtree.h>
+#include "rwsem.h"
+
+struct dso;
+
+/*
+ * DSOs are put into both a list for fast iteration and rbtree for fast
+ * long name lookup.
+ */
+struct dsos {
+	struct list_head    head;
+	struct rb_root	    root;	/* rbtree root sorted by long name */
+	struct rw_semaphore lock;
+};
+
+void __dsos__add(struct dsos *dsos, struct dso *dso);
+void dsos__add(struct dsos *dsos, struct dso *dso);
+struct dso *__dsos__addnew(struct dsos *dsos, const char *name);
+struct dso *__dsos__find(struct dsos *dsos, const char *name, bool cmp_short);
+struct dso *dsos__find(struct dsos *dsos, const char *name, bool cmp_short);
+struct dso *__dsos__findnew(struct dsos *dsos, const char *name);
+struct dso *dsos__findnew(struct dsos *dsos, const char *name);
+
+struct dso *__dsos__findnew_link_by_longname(struct rb_root *root, struct dso *dso, const char *name);
+
+static inline struct dso *__dsos__findnew_by_longname(struct rb_root *root, const char *name)
+{
+	return __dsos__findnew_link_by_longname(root, NULL, name);
+}
+
+bool __dsos__read_build_ids(struct list_head *head, bool with_hits);
+
+size_t __dsos__fprintf_buildid(struct list_head *head, FILE *fp,
+			       bool (skip)(struct dso *dso, int parm), int parm);
+size_t __dsos__fprintf(struct list_head *head, FILE *fp);
+
+#endif /* __PERF_DSOS */
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 54169ad335c7..f4afbb858ebb 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -11,6 +11,7 @@
 #include <api/fs/fs.h>
 #include <linux/perf_event.h>
 #include <linux/zalloc.h>
+#include "dso.h"
 #include "event.h"
 #include "debug.h"
 #include "hist.h"
@@ -29,6 +30,7 @@
 #include "stat.h"
 #include "session.h"
 #include "bpf-event.h"
+#include "tool.h"
 #include "../perf.h"
 
 #define DEFAULT_PROC_MAP_PARSE_TIMEOUT 500
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 20fb06162fd4..b0c34dda30a0 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -22,6 +22,7 @@
 #include <bpf/libbpf.h>
 #include <perf/cpumap.h>
 
+#include "dso.h"
 #include "evlist.h"
 #include "evsel.h"
 #include "header.h"
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 02ea2ee62814..b526ef3ede98 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "callchain.h"
 #include "debug.h"
+#include "dso.h"
 #include "build-id.h"
 #include "hist.h"
 #include "map.h"
diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index 99dddb63dac1..a30427aa1de0 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -22,6 +22,7 @@
 #include "map.h"
 #include "symbol.h"
 #include "session.h"
+#include "tool.h"
 #include "thread.h"
 #include "thread-stack.h"
 #include "debug.h"
diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index bbeac4f66402..b80f29bfc7bb 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -14,6 +14,7 @@
 #include <sys/mman.h>
 #include <linux/stringify.h>
 
+#include "build-id.h"
 #include "util.h"
 #include "event.h"
 #include "debug.h"
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 6e9afe4e55dd..003025465198 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -5,6 +5,7 @@
 #include <regex.h>
 #include "callchain.h"
 #include "debug.h"
+#include "dso.h"
 #include "event.h"
 #include "evsel.h"
 #include "hist.h"
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index 7d69119d0b5d..ffd391a925a6 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -5,12 +5,13 @@
 #include <sys/types.h>
 #include <linux/rbtree.h>
 #include "map_groups.h"
-#include "dso.h"
+#include "dsos.h"
 #include "event.h"
 #include "rwsem.h"
 
 struct addr_location;
 struct branch_stack;
+struct dso;
 struct evsel;
 struct perf_sample;
 struct symbol;
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index c75b20b93820..623a63cd1eec 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -8,6 +8,7 @@
 #include <stdio.h>
 #include <unistd.h>
 #include <uapi/linux/mman.h> /* To get things like MAP_HUGETLB even on older libc headers */
+#include "dso.h"
 #include "map.h"
 #include "thread.h"
 #include "vdso.h"
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 5f1ba6820cdd..523af1bd82e6 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -10,6 +10,7 @@
 #include <fcntl.h>
 #include <sys/param.h>
 #include "term.h"
+#include "build-id.h"
 #include "evlist.h"
 #include "evsel.h"
 #include <subcmd/parse-options.h>
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 8394d48f8b32..5d12a78c8ac8 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -19,11 +19,13 @@
 #include <limits.h>
 #include <elf.h>
 
+#include "build-id.h"
 #include "event.h"
 #include "namespaces.h"
 #include "strlist.h"
 #include "strfilter.h"
 #include "debug.h"
+#include "dso.h"
 #include "cache.h"
 #include "color.h"
 #include "map.h"
diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
index 4f6c1465998f..2ba4baa2c52f 100644
--- a/tools/perf/util/s390-cpumsf.c
+++ b/tools/perf/util/s390-cpumsf.c
@@ -157,6 +157,7 @@
 #include "evlist.h"
 #include "machine.h"
 #include "session.h"
+#include "tool.h"
 #include "thread.h"
 #include "debug.h"
 #include "auxtrace.h"
diff --git a/tools/perf/util/scripting-engines/trace-event-perl.c b/tools/perf/util/scripting-engines/trace-event-perl.c
index 800e82d35230..15961854ba67 100644
--- a/tools/perf/util/scripting-engines/trace-event-perl.c
+++ b/tools/perf/util/scripting-engines/trace-event-perl.c
@@ -35,6 +35,7 @@
 #include <perl.h>
 
 #include "../callchain.h"
+#include "../dso.h"
 #include "../machine.h"
 #include "../map.h"
 #include "../symbol.h"
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index abfde356be18..666a56e88d8e 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -31,8 +31,10 @@
 #include <linux/compiler.h>
 #include <linux/time64.h>
 
+#include "../build-id.h"
 #include "../counts.h"
 #include "../debug.h"
+#include "../dso.h"
 #include "../callchain.h"
 #include "../evsel.h"
 #include "../util.h"
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 4650704540c9..32ade5a1b553 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -5,6 +5,7 @@
 #include <linux/mman.h>
 #include <linux/time64.h>
 #include "debug.h"
+#include "dso.h"
 #include "sort.h"
 #include "hist.h"
 #include "cacheline.h"
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 5ba1601e8860..b64e9e049636 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -5,6 +5,7 @@
 #include <string.h>
 #include <linux/kernel.h>
 #include <linux/zalloc.h>
+#include "dso.h"
 #include "session.h"
 #include "thread.h"
 #include "thread-stack.h"
diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index 28f71ca6ce1c..9ece188ae48a 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -5,6 +5,7 @@
 #include <inttypes.h>
 #include <errno.h>
 #include "debug.h"
+#include "dso.h"
 #include "unwind.h"
 #include "unwind-libdw.h"
 #include "machine.h"
diff --git a/tools/perf/util/unwind-libunwind.c b/tools/perf/util/unwind-libunwind.c
index 6499b22b158b..a24fb57c9b2c 100644
--- a/tools/perf/util/unwind-libunwind.c
+++ b/tools/perf/util/unwind-libunwind.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "unwind.h"
+#include "dso.h"
 #include "map.h"
 #include "thread.h"
 #include "session.h"
diff --git a/tools/perf/util/vdso.c b/tools/perf/util/vdso.c
index 7f427bab6c12..e5e6599603f4 100644
--- a/tools/perf/util/vdso.c
+++ b/tools/perf/util/vdso.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 
 #include "vdso.h"
+#include "dso.h"
 #include "util.h"
 #include "map.h"
 #include "symbol.h"
-- 
2.21.0

