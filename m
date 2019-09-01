Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9507FC3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6601423431
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567340711;
	bh=znlNm8nufsDVNg/zdC9Vw98qrPrAyE1eyG1QSdshyVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q+AoE21Z2HgouCoJxBUbjSGSF2ryPdLKfy/EuB9TlJXCzayGmrsyHk4pFFFkpWHc6
	 tGFjFMe4HNdED8NNyOah8OoWUbJP7gFEpJcUqOkbYPpvnYHKjvcCLBsAa8ubF9R3Lz
	 XTuIFOO7ESMKDv7WuLQzZLABVOhPDlqUnYt5vcqk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbfIAMZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 08:25:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:42402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728970AbfIAMZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 08:25:07 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21BCF233A2;
        Sun,  1 Sep 2019 12:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567340706;
        bh=znlNm8nufsDVNg/zdC9Vw98qrPrAyE1eyG1QSdshyVU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KyCaf9DeYZRbUeh++g8EQjRiI3P/ipdDtzWg6+t23QHrjlXD6lr3K7MFqzUaxB7aq
         cRaXYQiLYBpwziFk1qMKfVI5F2+T357EvvGj9uEW/8ysq2wre2Fh5o+F3XnNjpny2Z
         FKERb9+pxjYiQ4R8XeCdtF/8M4P5S5xfvp5f+LO8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 31/47] perf tools: Remove needless map.h include directives
Date:   Sun,  1 Sep 2019 09:23:10 -0300
Message-Id: <20190901122326.5793-32-acme@kernel.org>
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

Now that map.h isn't included by any other header, we can check where
it is really needed, i.e. we can remove it and be sure that it isn't
being obtained indirectly.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-iu8ylqky7g1i9i54v3y7qovw@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm64/util/sym-handling.c | 8 +++-----
 tools/perf/tests/thread-mg-share.c        | 1 -
 tools/perf/util/intel-bts.c               | 1 -
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/tools/perf/arch/arm64/util/sym-handling.c b/tools/perf/arch/arm64/util/sym-handling.c
index 27fcf24d6850..5df788985130 100644
--- a/tools/perf/arch/arm64/util/sym-handling.c
+++ b/tools/perf/arch/arm64/util/sym-handling.c
@@ -4,11 +4,9 @@
  * Copyright (C) 2015 Naveen N. Rao, IBM Corporation
  */
 
-#include "debug.h"
-#include "symbol.h"
-#include "map.h"
-#include "probe-event.h"
-#include "probe-file.h"
+#include "symbol.h" // for the elf__needs_adjust_symbols() prototype
+#include <stdbool.h>
+#include <gelf.h>
 
 #ifdef HAVE_LIBELF_SUPPORT
 bool elf__needs_adjust_symbols(GElf_Ehdr ehdr)
diff --git a/tools/perf/tests/thread-mg-share.c b/tools/perf/tests/thread-mg-share.c
index b1d1bbafe7ae..cbac71716dec 100644
--- a/tools/perf/tests/thread-mg-share.c
+++ b/tools/perf/tests/thread-mg-share.c
@@ -2,7 +2,6 @@
 #include "tests.h"
 #include "machine.h"
 #include "thread.h"
-#include "map.h"
 #include "debug.h"
 
 int test__thread_mg_share(struct test *test __maybe_unused, int subtest __maybe_unused)
diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index a30427aa1de0..aacffa2b0362 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -19,7 +19,6 @@
 #include "evsel.h"
 #include "evlist.h"
 #include "machine.h"
-#include "map.h"
 #include "symbol.h"
 #include "session.h"
 #include "tool.h"
-- 
2.21.0

