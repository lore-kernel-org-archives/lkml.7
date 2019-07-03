Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2E1C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63879218B0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="OZ3Dt17O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfGCOQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:16:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33453 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbfGCOQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:16:02 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x63EFdfF3322716
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 07:15:39 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x63EFdfF3322716
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562163340;
        bh=ZCaTlxmc3q7nlrvnxRADxdRoilsnMsMwZw++mbo9Zhg=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=OZ3Dt17Ob8gntrdw94mlLnXed3H2SCZRggiqkkzLO1V/QS8dJ9Wr4PYCj4HBnf981
         c3Ii9xeXrz3xuNDOQJOudeGvnOSmJjCwDOxJX+DkxYyx/viexPILeVvS38WiJaUZdB
         rHwQWoitXyPkz12Lzce2c6+YWCOEAjy9NU5WjZ4CA3TlBRrVXPxC5Sx2CLsh+9fP/p
         rmQaBK6XHBxbATXdEFmnmp3d3l6fkvV5vN1aA9zZEZvLXvIXbTpVfFvtPklcfZYkNr
         rKPi6qNzryu98Un8k9DCZqHSkwjhHQ223IEI/mhcAsT5SDZkFlFClAlRTyof3wMLSz
         7IglCmUTywEbQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x63EFcun3322708;
        Wed, 3 Jul 2019 07:15:38 -0700
Date:   Wed, 3 Jul 2019 07:15:38 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-7k9868l713wqtgo01xxygn12@git.kernel.org>
Cc:     tglx@linutronix.de, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, acme@redhat.com, mingo@kernel.org,
        jolsa@kernel.org, hpa@zytor.com, adrian.hunter@intel.com
Reply-To: mingo@kernel.org, acme@redhat.com, adrian.hunter@intel.com,
          jolsa@kernel.org, hpa@zytor.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, namhyung@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools perf: Move from sane_ctype.h obtained from
 git to the Linux's original
Git-Commit-ID: 3052ba56bcb589046eca6a931bd897742653d2cb
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

Commit-ID:  3052ba56bcb589046eca6a931bd897742653d2cb
Gitweb:     https://git.kernel.org/tip/3052ba56bcb589046eca6a931bd897742653d2cb
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 25 Jun 2019 17:27:31 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 25 Jun 2019 21:02:47 -0300

tools perf: Move from sane_ctype.h obtained from git to the Linux's original

We got the sane_ctype.h headers from git and kept using it so far, but
since that code originally came from the kernel sources to the git
sources, perhaps its better to just use the one in the kernel, so that
we can leverage tools/perf/check_headers.sh to be notified when our copy
gets out of sync, i.e. when fixes or goodies are added to the code we've
copied.

This will help with things like tools/lib/string.c where we want to have
more things in common with the kernel, such as strim(), skip_spaces(),
etc so as to go on removing the things that we have in tools/perf/util/
and instead using the code in the kernel, indirectly and removing things
like EXPORT_SYMBOL(), etc, getting notified when fixes and improvements
are made to the original code.

Hopefully this also should help with reducing the difference of code
hosted in tools/ to the one in the kernel proper.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-7k9868l713wqtgo01xxygn12@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 {include => tools/include}/linux/ctype.h |  3 +-
 {lib => tools/lib}/ctype.c               |  3 --
 tools/lib/symbol/kallsyms.c              |  1 -
 tools/lib/symbol/kallsyms.h              |  1 +
 tools/perf/MANIFEST                      |  1 +
 tools/perf/arch/x86/util/machine.c       |  2 +-
 tools/perf/builtin-kmem.c                |  2 +-
 tools/perf/builtin-report.c              |  2 +-
 tools/perf/builtin-sched.c               |  2 +-
 tools/perf/builtin-script.c              |  2 +-
 tools/perf/builtin-stat.c                |  2 +-
 tools/perf/builtin-top.c                 |  2 +-
 tools/perf/builtin-trace.c               |  2 +-
 tools/perf/check-headers.sh              |  2 ++
 tools/perf/tests/code-reading.c          |  2 +-
 tools/perf/ui/browser.c                  |  2 +-
 tools/perf/ui/browsers/hists.c           |  2 +-
 tools/perf/ui/browsers/map.c             |  2 +-
 tools/perf/ui/stdio/hist.c               |  2 +-
 tools/perf/util/Build                    |  4 +++
 tools/perf/util/annotate.c               |  2 +-
 tools/perf/util/auxtrace.c               |  2 +-
 tools/perf/util/build-id.c               |  2 +-
 tools/perf/util/config.c                 |  2 +-
 tools/perf/util/cpumap.c                 |  2 +-
 tools/perf/util/ctype.c                  | 32 ----------------------
 tools/perf/util/data-convert-bt.c        |  2 +-
 tools/perf/util/debug.c                  |  2 +-
 tools/perf/util/demangle-java.c          |  2 +-
 tools/perf/util/env.c                    |  2 +-
 tools/perf/util/event.c                  |  2 +-
 tools/perf/util/evsel.c                  |  2 +-
 tools/perf/util/header.c                 |  2 +-
 tools/perf/util/jitdump.c                |  2 +-
 tools/perf/util/machine.c                |  2 +-
 tools/perf/util/print_binary.c           |  2 +-
 tools/perf/util/probe-event.c            |  2 +-
 tools/perf/util/probe-finder.h           |  2 +-
 tools/perf/util/python-ext-sources       |  2 +-
 tools/perf/util/sane_ctype.h             | 47 --------------------------------
 tools/perf/util/stat-display.c           |  2 +-
 tools/perf/util/strfilter.c              |  2 +-
 tools/perf/util/string.c                 |  2 +-
 tools/perf/util/symbol-elf.c             |  2 +-
 tools/perf/util/symbol.c                 |  2 +-
 tools/perf/util/trace-event-parse.c      |  2 +-
 46 files changed, 47 insertions(+), 121 deletions(-)

diff --git a/include/linux/ctype.h b/tools/include/linux/ctype.h
similarity index 96%
copy from include/linux/ctype.h
copy to tools/include/linux/ctype.h
index 363b004426db..310090b4c474 100644
--- a/include/linux/ctype.h
+++ b/tools/include/linux/ctype.h
@@ -23,10 +23,11 @@ extern const unsigned char _ctype[];
 #define isalnum(c)	((__ismask(c)&(_U|_L|_D)) != 0)
 #define isalpha(c)	((__ismask(c)&(_U|_L)) != 0)
 #define iscntrl(c)	((__ismask(c)&(_C)) != 0)
-static inline int isdigit(int c)
+static inline int __isdigit(int c)
 {
 	return '0' <= c && c <= '9';
 }
+#define isdigit(c)	__isdigit(c)
 #define isgraph(c)	((__ismask(c)&(_P|_U|_L|_D)) != 0)
 #define islower(c)	((__ismask(c)&(_L)) != 0)
 #define isprint(c)	((__ismask(c)&(_P|_U|_L|_D|_SP)) != 0)
diff --git a/lib/ctype.c b/tools/lib/ctype.c
similarity index 96%
copy from lib/ctype.c
copy to tools/lib/ctype.c
index c819fe269eb2..4d2e05fd3336 100644
--- a/lib/ctype.c
+++ b/tools/lib/ctype.c
@@ -7,7 +7,6 @@
 
 #include <linux/ctype.h>
 #include <linux/compiler.h>
-#include <linux/export.h>
 
 const unsigned char _ctype[] = {
 _C,_C,_C,_C,_C,_C,_C,_C,				/* 0-7 */
@@ -34,5 +33,3 @@ _U,_U,_U,_U,_U,_U,_U,_U,_U,_U,_U,_U,_U,_U,_U,_U,	/* 192-207 */
 _U,_U,_U,_U,_U,_U,_U,_P,_U,_U,_U,_U,_U,_U,_U,_L,	/* 208-223 */
 _L,_L,_L,_L,_L,_L,_L,_L,_L,_L,_L,_L,_L,_L,_L,_L,	/* 224-239 */
 _L,_L,_L,_L,_L,_L,_L,_P,_L,_L,_L,_L,_L,_L,_L,_L};	/* 240-255 */
-
-EXPORT_SYMBOL(_ctype);
diff --git a/tools/lib/symbol/kallsyms.c b/tools/lib/symbol/kallsyms.c
index 7501611abee4..1a7a9f877095 100644
--- a/tools/lib/symbol/kallsyms.c
+++ b/tools/lib/symbol/kallsyms.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <ctype.h>
 #include "symbol/kallsyms.h"
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/tools/lib/symbol/kallsyms.h b/tools/lib/symbol/kallsyms.h
index 2b238f181d97..bd988f7b18d4 100644
--- a/tools/lib/symbol/kallsyms.h
+++ b/tools/lib/symbol/kallsyms.h
@@ -3,6 +3,7 @@
 #define __TOOLS_KALLSYMS_H_ 1
 
 #include <elf.h>
+#include <linux/ctype.h>
 #include <linux/types.h>
 
 #ifndef KSYM_NAME_LEN
diff --git a/tools/perf/MANIFEST b/tools/perf/MANIFEST
index 627b7cada144..aac4c755d81b 100644
--- a/tools/perf/MANIFEST
+++ b/tools/perf/MANIFEST
@@ -7,6 +7,7 @@ tools/lib/traceevent
 tools/lib/api
 tools/lib/bpf
 tools/lib/subcmd
+tools/lib/ctype.c
 tools/lib/hweight.c
 tools/lib/rbtree.c
 tools/lib/string.c
diff --git a/tools/perf/arch/x86/util/machine.c b/tools/perf/arch/x86/util/machine.c
index 0e508f26f83a..1e9ec783b9a1 100644
--- a/tools/perf/arch/x86/util/machine.c
+++ b/tools/perf/arch/x86/util/machine.c
@@ -7,7 +7,7 @@
 #include "../../util/machine.h"
 #include "../../util/map.h"
 #include "../../util/symbol.h"
-#include "../../util/sane_ctype.h"
+#include <linux/ctype.h>
 
 #include <symbol/kallsyms.h>
 
diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index b833b03d7195..9bd3829de76d 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -31,7 +31,7 @@
 #include <locale.h>
 #include <regex.h>
 
-#include "sane_ctype.h"
+#include <linux/ctype.h>
 
 static int	kmem_slab;
 static int	kmem_page;
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 91c40808380d..91a3762b4211 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -47,7 +47,7 @@
 #include <errno.h>
 #include <inttypes.h>
 #include <regex.h>
-#include "sane_ctype.h"
+#include <linux/ctype.h>
 #include <signal.h>
 #include <linux/bitmap.h>
 #include <linux/stringify.h>
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 79577b67c898..1519989961ff 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -37,7 +37,7 @@
 #include <api/fs/fs.h>
 #include <linux/time64.h>
 
-#include "sane_ctype.h"
+#include <linux/ctype.h>
 
 #define PR_SET_NAME		15               /* Set process name */
 #define MAX_CPUS		4096
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 61f00055476a..0131f7a0d48d 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -49,7 +49,7 @@
 #include <unistd.h>
 #include <subcmd/pager.h>
 
-#include "sane_ctype.h"
+#include <linux/ctype.h>
 
 static char const		*script_name;
 static char const		*generate_script_lang;
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 8a35fc5a7281..e5e19b461061 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -82,7 +82,7 @@
 #include <sys/time.h>
 #include <sys/resource.h>
 
-#include "sane_ctype.h"
+#include <linux/ctype.h>
 
 #define DEFAULT_SEPARATOR	" "
 #define FREEZE_ON_SMI_PATH	"devices/cpu/freeze_on_smi"
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 4ef02e6888ff..6d40a4ef58c5 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -76,7 +76,7 @@
 #include <linux/time64.h>
 #include <linux/types.h>
 
-#include "sane_ctype.h"
+#include <linux/ctype.h>
 
 static volatile int done;
 static volatile int resize;
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index f3532b081b31..d0eb7224dd36 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -64,7 +64,7 @@
 #include <fcntl.h>
 #include <sys/sysmacros.h>
 
-#include "sane_ctype.h"
+#include <linux/ctype.h>
 
 #ifndef O_CLOEXEC
 # define O_CLOEXEC		02000000
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index c68ee06cae63..f211c015cb76 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -105,6 +105,8 @@ check arch/x86/lib/memcpy_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/ex
 check arch/x86/lib/memset_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/export.h>"'
 check include/uapi/asm-generic/mman.h '-I "^#include <\(uapi/\)*asm-generic/mman-common\(-tools\)*.h>"'
 check include/uapi/linux/mman.h       '-I "^#include <\(uapi/\)*asm/mman.h>"'
+check include/linux/ctype.h	      '-I "isdigit("'
+check lib/ctype.c		      '-I "^EXPORT_SYMBOL" -I "^#include <linux/export.h>" -B'
 
 # diff non-symmetric files
 check_2 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl arch/x86/entry/syscalls/syscall_64.tbl
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 4ebd2681e760..aa6df122b175 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -22,7 +22,7 @@
 
 #include "tests.h"
 
-#include "sane_ctype.h"
+#include <linux/ctype.h>
 
 #define BUFSZ	1024
 #define READLEN	128
diff --git a/tools/perf/ui/browser.c b/tools/perf/ui/browser.c
index 4ad37d8c7d6a..8812c1564995 100644
--- a/tools/perf/ui/browser.c
+++ b/tools/perf/ui/browser.c
@@ -16,7 +16,7 @@
 #include "helpline.h"
 #include "keysyms.h"
 #include "../color.h"
-#include "sane_ctype.h"
+#include <linux/ctype.h>
 
 static int ui_browser__percent_color(struct ui_browser *browser,
 				     double percent, bool current)
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 3421ecbdd3f0..59483bdb0027 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -33,7 +33,7 @@
 #include "units.h"
 #include "time-utils.h"
 
-#include "sane_ctype.h"
+#include <linux/ctype.h>
 
 extern void hist_browser__init_hpp(void);
 
diff --git a/tools/perf/ui/browsers/map.c b/tools/perf/ui/browsers/map.c
index c70d9337405b..5f6529c9eb8e 100644
--- a/tools/perf/ui/browsers/map.c
+++ b/tools/perf/ui/browsers/map.c
@@ -13,7 +13,7 @@
 #include "../keysyms.h"
 #include "map.h"
 
-#include "sane_ctype.h"
+#include <linux/ctype.h>
 
 struct map_browser {
 	struct ui_browser b;
diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
index 4c97e3cdf173..4b1a6e921d1c 100644
--- a/tools/perf/ui/stdio/hist.c
+++ b/tools/perf/ui/stdio/hist.c
@@ -13,7 +13,7 @@
 #include "../../util/srcline.h"
 #include "../../util/string2.h"
 #include "../../util/thread.h"
-#include "../../util/sane_ctype.h"
+#include <linux/ctype.h>
 
 static size_t callchain__fprintf_left_margin(FILE *fp, int left_margin)
 {
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 6d5bbc8b589b..b4dc6112138f 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -213,6 +213,10 @@ $(OUTPUT)util/bitmap.o: ../lib/bitmap.c FORCE
 	$(call rule_mkdir)
 	$(call if_changed_dep,cc_o_c)
 
+$(OUTPUT)util/ctype.o: ../lib/ctype.c FORCE
+	$(call rule_mkdir)
+	$(call if_changed_dep,cc_o_c)
+
 $(OUTPUT)util/find_bit.o: ../lib/find_bit.c FORCE
 	$(call rule_mkdir)
 	$(call if_changed_dep,cc_o_c)
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index c8ce13419d9b..65005ccea232 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -49,7 +49,7 @@
 #define DARROW_CHAR	((unsigned char)'.')
 #define UARROW_CHAR	((unsigned char)'-')
 
-#include "sane_ctype.h"
+#include <linux/ctype.h>
 
 struct annotation_options annotation__default_options = {
 	.use_offset     = true,
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index cfdbf65f1e02..bc215fe0b4b4 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -51,7 +51,7 @@
 #include "arm-spe.h"
 #include "s390-cpumsf.h"
 
-#include "sane_ctype.h"
+#include <linux/ctype.h>
 #include "symbol/kallsyms.h"
 
 static bool auxtrace__dont_decode(struct perf_session *session)
diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index 0c5517a8d0b7..89c6913dfc25 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -29,7 +29,7 @@
 #include "probe-file.h"
 #include "strlist.h"
 
-#include "sane_ctype.h"
+#include <linux/ctype.h>
 
 static bool no_buildid_cache;
 
diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index e7d2c08d263a..752cce853e51 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -24,7 +24,7 @@
 #include <unistd.h>
 #include <linux/string.h>
 
-#include "sane_ctype.h"
+#include <linux/ctype.h>
 
 #define MAXNAME (256)
 
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index c11a459ca582..0d8fbedf7bd5 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -10,7 +10,7 @@
 #include <linux/bitmap.h>
 #include "asm/bug.h"
 
-#include "sane_ctype.h"
+#include <linux/ctype.h>
 
 static int max_cpu_num;
 static int max_present_cpu_num;
diff --git a/tools/perf/util/ctype.c b/tools/perf/util/ctype.c
deleted file mode 100644
index f84ecd9e5329..000000000000
--- a/tools/perf/util/ctype.c
+++ /dev/null
@@ -1,32 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Sane locale-independent, ASCII ctype.
- *
- * No surprises, and works with signed and unsigned chars.
- */
-#include "sane_ctype.h"
-
-enum {
-	S = GIT_SPACE,
-	A = GIT_ALPHA,
-	D = GIT_DIGIT,
-	G = GIT_GLOB_SPECIAL,	/* *, ?, [, \\ */
-	R = GIT_REGEX_SPECIAL,	/* $, (, ), +, ., ^, {, | * */
-	P = GIT_PRINT_EXTRA,	/* printable - alpha - digit - glob - regex */
-
-	PS = GIT_SPACE | GIT_PRINT_EXTRA,
-};
-
-unsigned char sane_ctype[256] = {
-/*	0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F			    */
-
-	0, 0, 0, 0, 0, 0, 0, 0, 0, S, S, 0, 0, S, 0, 0,		/*   0.. 15 */
-	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,		/*  16.. 31 */
-	PS,P, P, P, R, P, P, P, R, R, G, R, P, P, R, P,		/*  32.. 47 */
-	D, D, D, D, D, D, D, D, D, D, P, P, P, P, P, G,		/*  48.. 63 */
-	P, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A,		/*  64.. 79 */
-	A, A, A, A, A, A, A, A, A, A, A, G, G, P, R, P,		/*  80.. 95 */
-	P, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A,		/*  96..111 */
-	A, A, A, A, A, A, A, A, A, A, A, R, R, P, P, 0,		/* 112..127 */
-	/* Nothing in the 128.. range */
-};
diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index b79e1d6839ed..7b06e7373b9e 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -29,7 +29,7 @@
 #include "evsel.h"
 #include "machine.h"
 #include "config.h"
-#include "sane_ctype.h"
+#include <linux/ctype.h>
 
 #define pr_N(n, fmt, ...) \
 	eprintf(n, debug_data_convert, fmt, ##__VA_ARGS__)
diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
index 3d6459626c2a..3cc578343f48 100644
--- a/tools/perf/util/debug.c
+++ b/tools/perf/util/debug.c
@@ -21,7 +21,7 @@
 #include "util.h"
 #include "target.h"
 
-#include "sane_ctype.h"
+#include <linux/ctype.h>
 
 int verbose;
 bool dump_trace = false, quiet = false;
diff --git a/tools/perf/util/demangle-java.c b/tools/perf/util/demangle-java.c
index e4c486756053..5b4900d67c80 100644
--- a/tools/perf/util/demangle-java.c
+++ b/tools/perf/util/demangle-java.c
@@ -8,7 +8,7 @@
 
 #include "demangle-java.h"
 
-#include "sane_ctype.h"
+#include <linux/ctype.h>
 
 enum {
 	MODE_PREFIX = 0,
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 1cc7a1837822..22eee8942527 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "cpumap.h"
 #include "env.h"
-#include "sane_ctype.h"
+#include <linux/ctype.h>
 #include "util.h"
 #include "bpf-event.h"
 #include <errno.h>
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index c9c6857360e4..d8f8a20543c5 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -20,7 +20,7 @@
 #include "strlist.h"
 #include "thread.h"
 #include "thread_map.h"
-#include "sane_ctype.h"
+#include <linux/ctype.h>
 #include "map.h"
 #include "symbol.h"
 #include "symbol/kallsyms.h"
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 4b175166d264..5ab31a4a658d 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -39,7 +39,7 @@
 #include "memswap.h"
 #include "util/parse-branch-options.h"
 
-#include "sane_ctype.h"
+#include <linux/ctype.h>
 
 struct perf_missing_features perf_missing_features;
 
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index abc9c2145efe..fca9dbaf61ae 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -43,7 +43,7 @@
 #include "cputopo.h"
 #include "bpf-event.h"
 
-#include "sane_ctype.h"
+#include <linux/ctype.h>
 
 /*
  * magic2 = "PERFILE2"
diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index eda28d3570bc..28908afedec4 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -28,7 +28,7 @@
 #include "genelf.h"
 #include "../builtin.h"
 
-#include "sane_ctype.h"
+#include <linux/ctype.h>
 
 struct jit_buf_desc {
 	struct perf_data *output;
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index a0bb05dd008f..1b3d7265bca9 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -25,7 +25,7 @@
 #include "asm/bug.h"
 #include "bpf-event.h"
 
-#include "sane_ctype.h"
+#include <linux/ctype.h>
 #include <symbol/kallsyms.h>
 #include <linux/mman.h>
 
diff --git a/tools/perf/util/print_binary.c b/tools/perf/util/print_binary.c
index 23e367063446..599a1543871d 100644
--- a/tools/perf/util/print_binary.c
+++ b/tools/perf/util/print_binary.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "print_binary.h"
 #include <linux/log2.h>
-#include "sane_ctype.h"
+#include <linux/ctype.h>
 
 int binary__fprintf(unsigned char *data, size_t len,
 		    size_t bytes_per_line, binary__fprintf_t printer,
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 2ebf8673f8e9..6f24eaf6e504 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -39,7 +39,7 @@
 #include "session.h"
 #include "string2.h"
 
-#include "sane_ctype.h"
+#include <linux/ctype.h>
 
 #define PERFPROBE_GROUP "probe"
 
diff --git a/tools/perf/util/probe-finder.h b/tools/perf/util/probe-finder.h
index 16252980ff00..670c477bf8cf 100644
--- a/tools/perf/util/probe-finder.h
+++ b/tools/perf/util/probe-finder.h
@@ -5,7 +5,7 @@
 #include <stdbool.h>
 #include "intlist.h"
 #include "probe-event.h"
-#include "sane_ctype.h"
+#include <linux/ctype.h>
 
 #define MAX_PROBE_BUFFER	1024
 #define MAX_PROBES		 128
diff --git a/tools/perf/util/python-ext-sources b/tools/perf/util/python-ext-sources
index 7aa0ea64544e..648bcd80b475 100644
--- a/tools/perf/util/python-ext-sources
+++ b/tools/perf/util/python-ext-sources
@@ -6,7 +6,7 @@
 #
 
 util/python.c
-util/ctype.c
+../lib/ctype.c
 util/evlist.c
 util/evsel.c
 util/cpumap.c
diff --git a/tools/perf/util/sane_ctype.h b/tools/perf/util/sane_ctype.h
deleted file mode 100644
index c4dce9e3001b..000000000000
--- a/tools/perf/util/sane_ctype.h
+++ /dev/null
@@ -1,47 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _PERF_SANE_CTYPE_H
-#define _PERF_SANE_CTYPE_H
-
-/* Sane ctype - no locale, and works with signed chars */
-#undef isascii
-#undef isspace
-#undef isdigit
-#undef isxdigit
-#undef isalpha
-#undef isprint
-#undef isalnum
-#undef islower
-#undef isupper
-#undef tolower
-#undef toupper
-
-extern unsigned char sane_ctype[256];
-#define GIT_SPACE		0x01
-#define GIT_DIGIT		0x02
-#define GIT_ALPHA		0x04
-#define GIT_GLOB_SPECIAL	0x08
-#define GIT_REGEX_SPECIAL	0x10
-#define GIT_PRINT_EXTRA		0x20
-#define GIT_PRINT		0x3E
-#define sane_istest(x,mask) ((sane_ctype[(unsigned char)(x)] & (mask)) != 0)
-#define isascii(x) (((x) & ~0x7f) == 0)
-#define isspace(x) sane_istest(x,GIT_SPACE)
-#define isdigit(x) sane_istest(x,GIT_DIGIT)
-#define isxdigit(x)	\
-	(sane_istest(toupper(x), GIT_ALPHA | GIT_DIGIT) && toupper(x) < 'G')
-#define isalpha(x) sane_istest(x,GIT_ALPHA)
-#define isalnum(x) sane_istest(x,GIT_ALPHA | GIT_DIGIT)
-#define isprint(x) sane_istest(x,GIT_PRINT)
-#define islower(x) (sane_istest(x,GIT_ALPHA) && (x & 0x20))
-#define isupper(x) (sane_istest(x,GIT_ALPHA) && !(x & 0x20))
-#define tolower(x) sane_case((unsigned char)(x), 0x20)
-#define toupper(x) sane_case((unsigned char)(x), 0)
-
-static inline int sane_case(int x, int high)
-{
-	if (sane_istest(x, GIT_ALPHA))
-		x = (x & ~0x20) | high;
-	return x;
-}
-
-#endif /* _PERF_SANE_CTYPE_H */
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index a6b9de3e83fc..992e327bce85 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -10,7 +10,7 @@
 #include "thread_map.h"
 #include "cpumap.h"
 #include "string2.h"
-#include "sane_ctype.h"
+#include <linux/ctype.h>
 #include "cgroup.h"
 #include <math.h>
 #include <api/fs/fs.h>
diff --git a/tools/perf/util/strfilter.c b/tools/perf/util/strfilter.c
index 7f3253d44afd..2c3a2904ebcd 100644
--- a/tools/perf/util/strfilter.c
+++ b/tools/perf/util/strfilter.c
@@ -4,7 +4,7 @@
 #include "strfilter.h"
 
 #include <errno.h>
-#include "sane_ctype.h"
+#include <linux/ctype.h>
 
 /* Operators */
 static const char *OP_and	= "&";	/* Logical AND */
diff --git a/tools/perf/util/string.c b/tools/perf/util/string.c
index b18884bd673b..084c3e4e9400 100644
--- a/tools/perf/util/string.c
+++ b/tools/perf/util/string.c
@@ -4,7 +4,7 @@
 #include <linux/string.h>
 #include <stdlib.h>
 
-#include "sane_ctype.h"
+#include <linux/ctype.h>
 
 const char *graph_dotted_line =
 	"---------------------------------------------------------------------"
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index f04ef851ae86..62008756d8cc 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -15,7 +15,7 @@
 #include "vdso.h"
 #include "debug.h"
 #include "util.h"
-#include "sane_ctype.h"
+#include <linux/ctype.h>
 #include <symbol/kallsyms.h>
 
 #ifndef EM_AARCH64
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index f4540f8bbed1..46d2c03814a1 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -25,7 +25,7 @@
 #include "namespaces.h"
 #include "header.h"
 #include "path.h"
-#include "sane_ctype.h"
+#include <linux/ctype.h>
 
 #include <elf.h>
 #include <limits.h>
diff --git a/tools/perf/util/trace-event-parse.c b/tools/perf/util/trace-event-parse.c
index 62bc61155dd1..b3982e1bb4c5 100644
--- a/tools/perf/util/trace-event-parse.c
+++ b/tools/perf/util/trace-event-parse.c
@@ -11,7 +11,7 @@
 #include "debug.h"
 #include "trace-event.h"
 
-#include "sane_ctype.h"
+#include <linux/ctype.h>
 
 static int get_common_field(struct scripting_context *context,
 			    int *offset, int *size, const char *type)
