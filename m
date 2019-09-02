Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5603C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6DED215EA
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730571AbfIBITI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 04:19:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56215 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730178AbfIBIQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 04:16:43 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i4hVt-00086M-CS; Mon, 02 Sep 2019 10:16:37 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 151B01C0DF9;
        Mon,  2 Sep 2019 10:16:34 +0200 (CEST)
Date:   Mon, 02 Sep 2019 08:16:33 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf symbols: Move symsrc prototypes to a separate header
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-ip683cegt306ncu3gsz7ii21@git.kernel.org>
References: <tip-ip683cegt306ncu3gsz7ii21@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156741219400.17339.1610175190643025403.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     b1d1b094f7570a13dd7c9b995209baacc8aa6273
Gitweb:        https://git.kernel.org/tip/b1d1b094f7570a13dd7c9b995209baacc8aa6273
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Fri, 30 Aug 2019 10:26:37 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Sat, 31 Aug 2019 22:24:05 -03:00

perf symbols: Move symsrc prototypes to a separate header

So that we can remove dso.h from symbol.h and reduce the header
dependency tree.

Fixup cases where struct dso guts are needed but were obtained via
symbol.h, indirectly.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-ip683cegt306ncu3gsz7ii21@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/powerpc/util/sym-handling.c |  1 +-
 tools/perf/builtin-probe.c                  |  1 +-
 tools/perf/ui/browsers/map.c                |  1 +-
 tools/perf/ui/gtk/annotate.c                |  1 +-
 tools/perf/util/symbol-elf.c                |  1 +-
 tools/perf/util/symbol-minimal.c            |  2 +-
 tools/perf/util/symbol.c                    |  1 +-
 tools/perf/util/symbol.h                    | 36 +---------------
 tools/perf/util/symbol_fprintf.c            |  1 +-
 tools/perf/util/symsrc.h                    | 46 ++++++++++++++++++++-
 10 files changed, 58 insertions(+), 33 deletions(-)
 create mode 100644 tools/perf/util/symsrc.h

diff --git a/tools/perf/arch/powerpc/util/sym-handling.c b/tools/perf/arch/powerpc/util/sym-handling.c
index b0a67ea..8a4b717 100644
--- a/tools/perf/arch/powerpc/util/sym-handling.c
+++ b/tools/perf/arch/powerpc/util/sym-handling.c
@@ -5,6 +5,7 @@
  */
 
 #include "debug.h"
+#include "dso.h"
 #include "symbol.h"
 #include "map.h"
 #include "probe-event.h"
diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
index 8950c05..6dce172 100644
--- a/tools/perf/builtin-probe.c
+++ b/tools/perf/builtin-probe.c
@@ -18,6 +18,7 @@
 
 #include "builtin.h"
 #include "namespaces.h"
+#include "util/build-id.h"
 #include "util/strlist.h"
 #include "util/strfilter.h"
 #include "util/symbol.h"
diff --git a/tools/perf/ui/browsers/map.c b/tools/perf/ui/browsers/map.c
index 4c545b9..893b065 100644
--- a/tools/perf/ui/browsers/map.c
+++ b/tools/perf/ui/browsers/map.c
@@ -8,6 +8,7 @@
 #include "../../util/util.h"
 #include "../../util/debug.h"
 #include "../../util/map.h"
+#include "../../util/dso.h"
 #include "../../util/symbol.h"
 #include "../browser.h"
 #include "../helpline.h"
diff --git a/tools/perf/ui/gtk/annotate.c b/tools/perf/ui/gtk/annotate.c
index d7f9844..8e744af 100644
--- a/tools/perf/ui/gtk/annotate.c
+++ b/tools/perf/ui/gtk/annotate.c
@@ -5,6 +5,7 @@
 #include "util/annotate.h"
 #include "util/evsel.h"
 #include "util/map.h"
+#include "util/dso.h"
 #include "util/symbol.h"
 #include "ui/helpline.h"
 #include <inttypes.h>
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 6d22437..9428639 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -10,6 +10,7 @@
 #include "map.h"
 #include "map_groups.h"
 #include "symbol.h"
+#include "symsrc.h"
 #include "demangle-java.h"
 #include "demangle-rust.h"
 #include "machine.h"
diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-minimal.c
index 3bc8b7e..7e2813e 100644
--- a/tools/perf/util/symbol-minimal.c
+++ b/tools/perf/util/symbol-minimal.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "dso.h"
 #include "symbol.h"
+#include "symsrc.h"
 #include "util.h"
 
 #include <errno.h>
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index b11a696..e5ffe61 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -25,6 +25,7 @@
 #include "machine.h"
 #include "map.h"
 #include "symbol.h"
+#include "symsrc.h"
 #include "strlist.h"
 #include "intlist.h"
 #include "namespaces.h"
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 22660c7..5a58407 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -20,8 +20,7 @@
 #endif
 #include <elf.h>
 
-#include "dso.h"
-
+struct dso;
 struct map;
 struct map_groups;
 struct option;
@@ -148,37 +147,6 @@ struct addr_location {
 	s32	      socket;
 };
 
-struct symsrc {
-	char *name;
-	int fd;
-	enum dso_binary_type type;
-
-#ifdef HAVE_LIBELF_SUPPORT
-	Elf *elf;
-	GElf_Ehdr ehdr;
-
-	Elf_Scn *opdsec;
-	size_t opdidx;
-	GElf_Shdr opdshdr;
-
-	Elf_Scn *symtab;
-	GElf_Shdr symshdr;
-
-	Elf_Scn *dynsym;
-	size_t dynsym_idx;
-	GElf_Shdr dynshdr;
-
-	bool adjust_symbols;
-	bool is_64_bit;
-#endif
-};
-
-void symsrc__destroy(struct symsrc *ss);
-int symsrc__init(struct symsrc *ss, struct dso *dso, const char *name,
-		 enum dso_binary_type type);
-bool symsrc__has_symtab(struct symsrc *ss);
-bool symsrc__possibly_runtime(struct symsrc *ss);
-
 int dso__load(struct dso *dso, struct map *map);
 int dso__load_vmlinux(struct dso *dso, struct map *map,
 		      const char *vmlinux, bool vmlinux_allocated);
@@ -232,6 +200,8 @@ bool symbol__restricted_filename(const char *filename,
 int symbol__config_symfs(const struct option *opt __maybe_unused,
 			 const char *dir, int unset __maybe_unused);
 
+struct symsrc;
+
 int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 		  struct symsrc *runtime_ss, int kmodule);
 int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss);
diff --git a/tools/perf/util/symbol_fprintf.c b/tools/perf/util/symbol_fprintf.c
index 02e89b0..35c936c 100644
--- a/tools/perf/util/symbol_fprintf.c
+++ b/tools/perf/util/symbol_fprintf.c
@@ -3,6 +3,7 @@
 #include <inttypes.h>
 #include <stdio.h>
 
+#include "dso.h"
 #include "map.h"
 #include "symbol.h"
 
diff --git a/tools/perf/util/symsrc.h b/tools/perf/util/symsrc.h
new file mode 100644
index 0000000..2665b4b
--- /dev/null
+++ b/tools/perf/util/symsrc.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PERF_SYMSRC_
+#define __PERF_SYMSRC_ 1
+
+#include <stdbool.h>
+#include <stddef.h>
+#include "dso.h"
+
+#ifdef HAVE_LIBELF_SUPPORT
+#include <libelf.h>
+#include <gelf.h>
+#endif
+#include <elf.h>
+
+struct symsrc {
+	char		     *name;
+	int		     fd;
+	enum dso_binary_type type;
+
+#ifdef HAVE_LIBELF_SUPPORT
+	Elf		     *elf;
+	GElf_Ehdr	     ehdr;
+
+	Elf_Scn		     *opdsec;
+	size_t		     opdidx;
+	GElf_Shdr	     opdshdr;
+
+	Elf_Scn		     *symtab;
+	GElf_Shdr	     symshdr;
+
+	Elf_Scn		     *dynsym;
+	size_t		     dynsym_idx;
+	GElf_Shdr	     dynshdr;
+
+	bool		     adjust_symbols;
+	bool		     is_64_bit;
+#endif
+};
+
+int symsrc__init(struct symsrc *ss, struct dso *dso, const char *name, enum dso_binary_type type);
+void symsrc__destroy(struct symsrc *ss);
+
+bool symsrc__has_symtab(struct symsrc *ss);
+bool symsrc__possibly_runtime(struct symsrc *ss);
+
+#endif /* __PERF_SYMSRC_ */
