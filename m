Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DA7C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 382C6217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564455626;
	bh=nM3OKcDcLtjGq2riIhP0b9VfCdXQd7QG70nfOPnM2WE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cdYt77MOrNCutcKf7xDJ3QTVVQcgGMnv/nqC0i6qL+qGhL2FgJXKP3W8j6JU33l1u
	 JdLzrxD3h2Xcx7KE2Y7TXG2F+73O5yIGt8XJo5fOTiohi4mxWTSAkbGByZPEN7kgua
	 y73oa01Hh6ggrfrOFUTHzSgo+6PVa0LGD9n10Mp8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732391AbfG3DAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 23:00:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:49658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732374AbfG3DAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 23:00:19 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2F162171F;
        Tue, 30 Jul 2019 03:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455618;
        bh=nM3OKcDcLtjGq2riIhP0b9VfCdXQd7QG70nfOPnM2WE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DNIzWXCiUQt7FMszPBS0GtW7jdO5x8peGp9NV8MiW/CIeNlfrMaNL0rJtew3grsmW
         wf1oFNxi9ZDtLy7SpZxz4fXB4dMZpeuRYK82iami+e5KsC2RFrvHSGuzXVh3CuAiuU
         AhcOzxWd+1kGwQOCOXQwy1WFoGbYnMBiUnOWslnQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 071/107] libperf: Move zalloc.o into libperf
Date:   Mon, 29 Jul 2019 23:55:34 -0300
Message-Id: <20190730025610.22603-72-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190730025610.22603-1-acme@kernel.org>
References: <20190730025610.22603-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

We need it in both perf and libperf, thus moving it to libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-45-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/Build               | 5 +++++
 tools/perf/util/Build              | 5 -----
 tools/perf/util/python-ext-sources | 1 -
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/tools/perf/lib/Build b/tools/perf/lib/Build
index b27c1543b046..faf64db13e37 100644
--- a/tools/perf/lib/Build
+++ b/tools/perf/lib/Build
@@ -3,3 +3,8 @@ libperf-y += cpumap.o
 libperf-y += threadmap.o
 libperf-y += evsel.o
 libperf-y += evlist.o
+libperf-y += zalloc.o
+
+$(OUTPUT)zalloc.o: ../../lib/zalloc.c FORCE
+	$(call rule_mkdir)
+	$(call if_changed_dep,cc_o_c)
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 14f812bb07a7..08f670d21615 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -26,7 +26,6 @@ perf-y += rbtree.o
 perf-y += libstring.o
 perf-y += bitmap.o
 perf-y += hweight.o
-perf-y += zalloc.o
 perf-y += smt.o
 perf-y += strbuf.o
 perf-y += string.o
@@ -243,7 +242,3 @@ $(OUTPUT)util/hweight.o: ../lib/hweight.c FORCE
 $(OUTPUT)util/vsprintf.o: ../lib/vsprintf.c FORCE
 	$(call rule_mkdir)
 	$(call if_changed_dep,cc_o_c)
-
-$(OUTPUT)util/zalloc.o: ../lib/zalloc.c FORCE
-	$(call rule_mkdir)
-	$(call if_changed_dep,cc_o_c)
diff --git a/tools/perf/util/python-ext-sources b/tools/perf/util/python-ext-sources
index ceb8afdf9a89..2237bac9fadb 100644
--- a/tools/perf/util/python-ext-sources
+++ b/tools/perf/util/python-ext-sources
@@ -18,7 +18,6 @@ util/namespaces.c
 ../lib/hweight.c
 ../lib/string.c
 ../lib/vsprintf.c
-../lib/zalloc.c
 util/thread_map.c
 util/util.c
 util/xyarray.c
-- 
2.21.0

