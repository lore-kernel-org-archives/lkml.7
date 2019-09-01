Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549AFC3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27BE12377F
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567340705;
	bh=NjPc9LS4FbwtSCC4USydrNyRncnUArAvxD5XJYSZ2dw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SdXUmIndrjEM2IXoL/6AN4CGT9pxwh9MlCkwW9pEpsIh3k1abm3k5T2VKQszwI0/T
	 Qcu23l247ru+40pENA+5UI0Dh/eYETZpns/J0alZbuVcB37LVpHhfYkHLjAcm9w0HD
	 Rrhvhsee6teI72OMu2u+z7x8Tz8dA6JRyIinWksQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbfIAMZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 08:25:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:42286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729179AbfIAMZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 08:25:02 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED8F523717;
        Sun,  1 Sep 2019 12:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567340701;
        bh=NjPc9LS4FbwtSCC4USydrNyRncnUArAvxD5XJYSZ2dw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sg861gMsUZ/AqdXYo4AnRkbEhCDbjDc4n1qQpoHhDHC0jq8jnQKceKF3DJd97etdv
         S0TaYi22ALdgBSMq3LCu9jT6XeeoaV5C36WQtE0WzrWhZjsS+Wl8OAP9uRVARSOCGI
         ysvUoGrXSlfJnt+ywnoICrxhYGDvIJjWn8AlWTkg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 29/47] perf tools: Remove needless sort.h include directives
Date:   Sun,  1 Sep 2019 09:23:08 -0300
Message-Id: <20190901122326.5793-30-acme@kernel.org>
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

Now that sort.h isn't included by any other header, we can check where
it is really needed, i.e. we can remove it and be sure that it isn't
being obtained indirectly.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-tom8k0lbsxd9joprr8zpu6w1@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c         | 1 +
 tools/perf/ui/browsers/scripts.c | 1 -
 tools/perf/util/hist.c           | 1 +
 tools/perf/util/mem-events.c     | 1 -
 tools/perf/util/session.c        | 1 -
 5 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 0b7b12cfdd63..0f0d96262d14 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -39,6 +39,7 @@
 #include <linux/rbtree.h>
 #include <subcmd/parse-options.h>
 #include "util/parse-events.h"
+#include "util/callchain.h"
 #include "util/cpumap.h"
 #include "util/sort.h"
 #include "util/string2.h"
diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/scripts.c
index 77809c0fad02..bf1d9f9ec035 100644
--- a/tools/perf/ui/browsers/scripts.c
+++ b/tools/perf/ui/browsers/scripts.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "../../builtin.h"
 #include "../../perf.h"
-#include "../../util/sort.h"
 #include "../../util/util.h"
 #include "../../util/hist.h"
 #include "../../util/debug.h"
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index b526ef3ede98..0978dc4a33db 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -20,6 +20,7 @@
 #include <math.h>
 #include <inttypes.h>
 #include <sys/param.h>
+#include <linux/rbtree.h>
 #include <linux/string.h>
 #include <linux/time64.h>
 #include <linux/zalloc.h>
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 42c3e5a229d2..3a8d38ce3b54 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -11,7 +11,6 @@
 #include "mem-events.h"
 #include "debug.h"
 #include "symbol.h"
-#include "sort.h"
 
 unsigned int perf_mem_events__loads_ldlat = 30;
 
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index f166da76acf1..e5ac5f3c94d4 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -20,7 +20,6 @@
 #include "symbol.h"
 #include "session.h"
 #include "tool.h"
-#include "sort.h"
 #include "cpumap.h"
 #include "perf_regs.h"
 #include "asm/bug.h"
-- 
2.21.0

