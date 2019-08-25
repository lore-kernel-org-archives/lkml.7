Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57817C3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 18:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FF472173E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 18:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566757106;
	bh=bMYLE0dKiGQTBYFIbHvR+niDrPnQ7yPPzsqWrY/sFYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q4Jx2EEw2iXEDPHYrYvhlDbcaFiPY0wH0anA37C4U0ykvizFCZUz1VQMmYLNlBDcu
	 2E8D8NtSqom5jRevmBtjNvTr+fqjYviA6Ghom9A2PEFjeJxzOz5KwNOxjme0mf0akd
	 HQSB+QubFAvv2nqqyj5E6jMDSCMIx78nZXERZQtA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbfHYSSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 14:18:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48196 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728990AbfHYSSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 14:18:23 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0A53E18C426C;
        Sun, 25 Aug 2019 18:18:23 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-45.brq.redhat.com [10.40.204.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ED3C65D9C3;
        Sun, 25 Aug 2019 18:18:20 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 10/12] libperf: Add ksymbol_event to perf/event.h
Date:   Sun, 25 Aug 2019 20:17:50 +0200
Message-Id: <20190825181752.722-11-jolsa@kernel.org>
In-Reply-To: <20190825181752.722-1-jolsa@kernel.org>
References: <20190825181752.722-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.62]); Sun, 25 Aug 2019 18:18:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving ksymbol_event event definition into libperf's event.h
header include.

In order to keep libperf simple, we switch 'u64/u32/u16/u8'
types used events to their generic '__u*' versions.

Perf added 'u*' types mainly to ease up printing __u64 values
as stated in the linux/types.h comment:

  /*
   * We define u64 as uint64_t for every architecture
   * so that we can print it with "%"PRIx64 without getting warnings.
   *
   * typedef __u64 u64;
   * typedef __s64 s64;
   */

Adding and using new PRI_lu64 and PRI_lx64 macros to be used for
that.  Using extra '_' to ease up the reading and differentiate
them from standard PRI*64 macros.

Link: http://lkml.kernel.org/n/tip-2galzeqp0v362u9ie8oci8cn@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/include/perf/event.h | 13 +++++++++++++
 tools/perf/util/event.c             |  2 +-
 tools/perf/util/event.h             | 13 -------------
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index 80d0bc48baff..ecab3246913d 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -80,4 +80,17 @@ struct throttle_event {
 	__u64 stream_id;
 };
 
+#ifndef KSYM_NAME_LEN
+#define KSYM_NAME_LEN 256
+#endif
+
+struct ksymbol_event {
+	struct perf_event_header header;
+	__u64 addr;
+	__u32 len;
+	__u16 ksym_type;
+	__u16 flags;
+	char name[KSYM_NAME_LEN];
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 3bd9fc2a3ae8..4447cd25e3f2 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1485,7 +1485,7 @@ static size_t perf_event__fprintf_lost(union perf_event *event, FILE *fp)
 
 size_t perf_event__fprintf_ksymbol(union perf_event *event, FILE *fp)
 {
-	return fprintf(fp, " addr %" PRIx64 " len %u type %u flags 0x%x name %s\n",
+	return fprintf(fp, " addr %" PRI_lx64 " len %u type %u flags 0x%x name %s\n",
 		       event->ksymbol_event.addr, event->ksymbol_event.len,
 		       event->ksymbol_event.ksym_type,
 		       event->ksymbol_event.flags, event->ksymbol_event.name);
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index d03a70e2e6a4..dbabde3a43a6 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -16,19 +16,6 @@
 #define PRI_lu64 "l" PRIu64
 #define PRI_lx64 "l" PRIx64
 
-#ifndef KSYM_NAME_LEN
-#define KSYM_NAME_LEN 256
-#endif
-
-struct ksymbol_event {
-	struct perf_event_header header;
-	u64 addr;
-	u32 len;
-	u16 ksym_type;
-	u16 flags;
-	char name[KSYM_NAME_LEN];
-};
-
 struct bpf_event {
 	struct perf_event_header header;
 	u16 type;
-- 
2.21.0

