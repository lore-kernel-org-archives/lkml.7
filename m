Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C091C3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 18:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30F9A217F4
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 18:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566757110;
	bh=DD4Wk5WRnBWY0cKeMnHnKnJ9+K6GtFwT2iGYHx+Dtz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T7ogeeaQF8UvbvftLK3ndCqZD3BrCfuoy+Uf0yeijILFJ+MM6Dgot2zWNdom0Y7jt
	 y+P2zwJvUE0BQWzKBuqHhuEEIHnx9wJVq2IY3aGPpFmr39apbrvJkk0QuOuObDluY6
	 qHoFd0I9ZSMLXnUzRyLo157dyGGiUHUlKpYMTcck=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbfHYSS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 14:18:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43750 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728990AbfHYSSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 14:18:25 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8A8C3878E5D;
        Sun, 25 Aug 2019 18:18:25 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-45.brq.redhat.com [10.40.204.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 812BE5D9C3;
        Sun, 25 Aug 2019 18:18:23 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 11/12] libperf: Add bpf_event to perf/event.h
Date:   Sun, 25 Aug 2019 20:17:51 +0200
Message-Id: <20190825181752.722-12-jolsa@kernel.org>
In-Reply-To: <20190825181752.722-1-jolsa@kernel.org>
References: <20190825181752.722-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Sun, 25 Aug 2019 18:18:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving lost_samples_event event definition into libperf's event.h
header include.

In order to keep libperf simple, we switch 'u64/u32/u16/u8'
types used events to their generic '__u*' versions.

Link: http://lkml.kernel.org/n/tip-s4z0vtr5x14u2ybme4jq5f2n@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/include/perf/event.h | 11 +++++++++++
 tools/perf/util/event.h             | 10 ----------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index ecab3246913d..74317bcf74bf 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -5,6 +5,7 @@
 #include <linux/perf_event.h>
 #include <linux/types.h>
 #include <linux/limits.h>
+#include <linux/bpf.h>
 
 struct mmap_event {
 	struct perf_event_header header;
@@ -93,4 +94,14 @@ struct ksymbol_event {
 	char name[KSYM_NAME_LEN];
 };
 
+struct bpf_event {
+	struct perf_event_header header;
+	__u16 type;
+	__u16 flags;
+	__u32 id;
+
+	/* for bpf_prog types */
+	__u8 tag[BPF_TAG_SIZE];  // prog tag
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index dbabde3a43a6..cd1d8d1007dc 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -16,16 +16,6 @@
 #define PRI_lu64 "l" PRIu64
 #define PRI_lx64 "l" PRIx64
 
-struct bpf_event {
-	struct perf_event_header header;
-	u16 type;
-	u16 flags;
-	u32 id;
-
-	/* for bpf_prog types */
-	u8 tag[BPF_TAG_SIZE];  // prog tag
-};
-
 #define PERF_SAMPLE_MASK				\
 	(PERF_SAMPLE_IP | PERF_SAMPLE_TID |		\
 	 PERF_SAMPLE_TIME | PERF_SAMPLE_ADDR |		\
-- 
2.21.0

