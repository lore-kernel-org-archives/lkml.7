Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193D5C3A5A4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E58F321848
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566869822;
	bh=j2pugDQwANd5FjxBmmjCx/+lzI/V0esVionnlN1ZFrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RUzWtvd61OOmHg+H5x254b0c1poq0c+tcL/0hp97j+C/EPT8oug2hA/7Ve5+ZynLt
	 IbFmuDlKkz9fJ5Wt+Y4d6A9rD0586fUH1s+uB8k4qEsw/KVWnPgmxBVttHyNtZ2aP+
	 s8p/5rw8OO6RUfiaRz/r7gN60H1XmZ82N8u8ocuc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbfH0BhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 21:37:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:50118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728730AbfH0Bg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 21:36:58 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0533922CED;
        Tue, 27 Aug 2019 01:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566869817;
        bh=j2pugDQwANd5FjxBmmjCx/+lzI/V0esVionnlN1ZFrk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WdmhgjPms0pRH3FsY7nOnBp4+oACj8JTDPiMnI1eldAngzXfBg127tBBU0ER8+1s4
         IqkHT9Y7rCTvMaskqsYWPUhEK7XGHUxFIkLU62Q9qdumTshQ+IQxJojDPKE8n37fau
         mwgdSOOoiAthH3X8hMguHAkAtX1L50qZriIIKtvQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 05/33] perf srcline: Add missing srcline.h header to files needing its defs
Date:   Mon, 26 Aug 2019 22:36:06 -0300
Message-Id: <20190827013634.3173-6-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190827013634.3173-1-acme@kernel.org>
References: <20190827013634.3173-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When srcline was introduced it wrongly added the include to util/sort.h,
even with that header not needing the definitions it provides, fix it by
adding it to the places that need it as a pre patch to remove srcline.h
from sort.h.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-shuebppedtye8hrgxk15qe3x@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-diff.c   | 2 ++
 tools/perf/builtin-report.c | 1 +
 tools/perf/builtin-script.c | 1 +
 tools/perf/util/annotate.c  | 2 ++
 tools/perf/util/machine.c   | 2 ++
 tools/perf/util/sort.c      | 1 +
 6 files changed, 9 insertions(+)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index e91c0d798181..51c37e53b3d8 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -15,6 +15,7 @@
 #include "util/session.h"
 #include "util/tool.h"
 #include "util/sort.h"
+#include "util/srcline.h"
 #include "util/symbol.h"
 #include "util/data.h"
 #include "util/config.h"
@@ -22,6 +23,7 @@
 #include "util/annotate.h"
 #include "util/map.h"
 #include <linux/zalloc.h>
+#include <subcmd/parse-options.h>
 
 #include <errno.h>
 #include <inttypes.h>
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 79dfb1139f94..318b0b95c14c 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -28,6 +28,7 @@
 #include "util/evswitch.h"
 #include "util/header.h"
 #include "util/session.h"
+#include "util/srcline.h"
 #include "util/tool.h"
 
 #include <subcmd/parse-options.h>
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index ee05621d3bd6..6f389b33fbe5 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -11,6 +11,7 @@
 #include "util/session.h"
 #include "util/tool.h"
 #include "util/map.h"
+#include "util/srcline.h"
 #include "util/symbol.h"
 #include "util/thread.h"
 #include "util/trace-event.h"
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index e0518dc4c4d2..3bd1691f0be7 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -22,6 +22,7 @@
 #include "cache.h"
 #include "map.h"
 #include "symbol.h"
+#include "srcline.h"
 #include "units.h"
 #include "debug.h"
 #include "annotate.h"
@@ -37,6 +38,7 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <bpf/libbpf.h>
+#include <subcmd/parse-options.h>
 
 /* FIXME: For the HE_COLORSET */
 #include "ui/browser.h"
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index f7c1a7e6c4ba..47430afd3c2d 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -10,11 +10,13 @@
 #include "hist.h"
 #include "machine.h"
 #include "map.h"
+#include "srcline.h"
 #include "symbol.h"
 #include "sort.h"
 #include "strlist.h"
 #include "target.h"
 #include "thread.h"
+#include "util.h"
 #include "vdso.h"
 #include <stdbool.h>
 #include <sys/types.h>
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 904ff4b2f57f..c522bdde3f71 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -13,6 +13,7 @@
 #include "thread.h"
 #include "evsel.h"
 #include "evlist.h"
+#include "srcline.h"
 #include "strlist.h"
 #include "strbuf.h"
 #include <traceevent/event-parse.h>
-- 
2.21.0

