Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E5AC3A59F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 382F22186A
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566869825;
	bh=OhEdShg2I/bdI3eKEHSBPZ66r7ZsS63+qE8LA4iLWb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YMim4tBCjJfAGaYexD8t8sqNMCoY2rBycGnUhZbnejm/YG3ZuyfzbYZWPHELTsl4F
	 8wWOcZIqi6mh9AP6wypr3nuqCqIhiKzPDkstmVr7AWLAsIHiqOa6kuIt/byQ2kmkxl
	 76xOqgOqZFrY//mCnFJOs8XOhX+4veG+c+l9Q2FM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbfH0BhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 21:37:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:50180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728742AbfH0BhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 21:37:01 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2F902173E;
        Tue, 27 Aug 2019 01:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566869819;
        bh=OhEdShg2I/bdI3eKEHSBPZ66r7ZsS63+qE8LA4iLWb4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vTTHgwGn1QWRRN1gpDIRdJHDa/GuEABx1A7h62hfRROT+ndz2HF2oUfYj1Rd1p5eU
         cHr0DSa1C1G+hydByXIRzxt6awfaITLB8dhDOD2ZyvDKIv+VpbF8FSw3Fqc6yXzyz/
         F/AgHmbiADs+jyN6B+EaWjU09wz+mDpxIdzwmDE0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 06/33] perf sort: Remove needless headers from sort.h, provide fwd struct decls
Date:   Mon, 26 Aug 2019 22:36:07 -0300
Message-Id: <20190827013634.3173-7-acme@kernel.org>
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

Reducing the includes hell a bit more, speeding up the build and
avoiding needless rebuilds when just one of those files gets updated.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-u63el2vqsovsmnhebx1rcixo@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/res_sample.c |  2 ++
 tools/perf/ui/browsers/scripts.c    |  2 ++
 tools/perf/ui/stdio/hist.c          |  1 +
 tools/perf/util/callchain.c         |  1 +
 tools/perf/util/sort.h              | 15 ++-------------
 5 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/tools/perf/ui/browsers/res_sample.c b/tools/perf/ui/browsers/res_sample.c
index 08897bd5eb0f..41a9d8923ec4 100644
--- a/tools/perf/ui/browsers/res_sample.c
+++ b/tools/perf/ui/browsers/res_sample.c
@@ -6,6 +6,8 @@
 #include "sort.h"
 #include "config.h"
 #include "time-utils.h"
+#include "../util.h"
+#include "../../util/util.h"
 #include <linux/time64.h>
 #include <linux/zalloc.h>
 
diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/scripts.c
index 04f9aff5621e..f2fd9f0d7ab5 100644
--- a/tools/perf/ui/browsers/scripts.c
+++ b/tools/perf/ui/browsers/scripts.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "../../builtin.h"
 #include "../../util/sort.h"
+#include "../../util/util.h"
 #include "../../util/hist.h"
 #include "../../util/debug.h"
 #include "../../util/symbol.h"
diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
index ee7ea6deed21..51ed67548b83 100644
--- a/tools/perf/ui/stdio/hist.c
+++ b/tools/perf/ui/stdio/hist.c
@@ -3,6 +3,7 @@
 #include <linux/string.h>
 
 #include "../../util/callchain.h"
+#include "../../util/debug.h"
 #include "../../util/hist.h"
 #include "../../util/map.h"
 #include "../../util/map_groups.h"
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index d077704f9afa..dd6e01000385 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -20,6 +20,7 @@
 
 #include "asm/bug.h"
 
+#include "debug.h"
 #include "hist.h"
 #include "sort.h"
 #include "machine.h"
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index 4ae155c6a808..3d7cef73924c 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -1,29 +1,18 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __PERF_SORT_H
 #define __PERF_SORT_H
-#include "../builtin.h"
-
 #include <regex.h>
-
-#include "color.h"
+#include <stdbool.h>
 #include <linux/list.h>
-#include "cache.h"
 #include <linux/rbtree.h>
 #include "map_symbol.h"
 #include "symbol_conf.h"
-#include "string.h"
 #include "callchain.h"
 #include "values.h"
 
-#include "../perf.h"
-#include "debug.h"
-#include "header.h"
-
-#include <subcmd/parse-options.h>
-#include "parse-events.h"
 #include "hist.h"
-#include "srcline.h"
 
+struct option;
 struct thread;
 
 extern regex_t parent_regex;
-- 
2.21.0

