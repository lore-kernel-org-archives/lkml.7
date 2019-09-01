Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84870C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5896221897
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567340791;
	bh=bCfMwuW82gtY6k5z2w2XC/idKYTnVDR468nuzZe+jgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tM9dZqXHjXiZWTdtD1T3OqILOWdmngJlfJJz/04JzKwhgxEsW4xEEHZsKyvn2RIU+
	 G/EBeBMWODlKHl8PGWIpP5ncAAor9PV6Y5Eh4O6BUnQuM1ZU9me7vpjdJiFJiLFVOX
	 TjjqdHU2cgbPZaUjbG8sbWJy3QA3BszS7eOfRehU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbfIAM0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 08:26:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:42170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729159AbfIAMY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 08:24:56 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C88D9233A2;
        Sun,  1 Sep 2019 12:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567340695;
        bh=bCfMwuW82gtY6k5z2w2XC/idKYTnVDR468nuzZe+jgA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TM7UgfAXikkx90ZzLWkzUEeY5wnPWC2Q2WS4gtjAPdnI725hvy8uZSIQ2xD5WrH+5
         sGarbcF2NlCDYQJ8hZCXooQOSaukAo4fimYohYZGtMcYt5EwJhFFa68dA8DBlktKHZ
         1cQLO+jPPT7X/gKHGy4Vb1Z3OglmQ8TAsWM6/9y4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 27/47] perf hist: Remove needless ui/progress.h from hist.h
Date:   Sun,  1 Sep 2019 09:23:06 -0300
Message-Id: <20190901122326.5793-28-acme@kernel.org>
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

We only need a forward declaration, add it and fixup all the files that
need ui_progress definitions but were wrongly getting it from hist.h.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-84a90o9jdxybffxo9jmouokw@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-c2c.c    | 1 +
 tools/perf/builtin-report.c | 1 +
 tools/perf/util/hist.h      | 2 +-
 tools/perf/util/session.c   | 1 +
 4 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index d1ad694c67a2..0d76b2cb8c0a 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -37,6 +37,7 @@
 #include "mem2node.h"
 #include "symbol.h"
 #include "ui/ui.h"
+#include "ui/progress.h"
 #include "../perf.h"
 
 struct c2c_hists {
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index ba419ee40283..d7a345667945 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -47,6 +47,7 @@
 #include "util/branch.h"
 #include "util/util.h"
 #include "ui/ui.h"
+#include "ui/progress.h"
 
 #include <dlfcn.h>
 #include <errno.h>
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 7b9267ebebeb..1c0a635e5e32 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -8,7 +8,6 @@
 #include "evsel.h"
 #include "header.h"
 #include "color.h"
-#include "ui/progress.h"
 
 struct hist_entry;
 struct hist_entry_ops;
@@ -18,6 +17,7 @@ struct mem_info;
 struct branch_info;
 struct block_info;
 struct symbol;
+struct ui_progress;
 
 enum hist_filter {
 	HIST_FILTER__DSO,
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index a72774e4463f..f166da76acf1 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -30,6 +30,7 @@
 #include "sample-raw.h"
 #include "stat.h"
 #include "util.h"
+#include "ui/progress.h"
 #include "../perf.h"
 #include "arch/common.h"
 
-- 
2.21.0

