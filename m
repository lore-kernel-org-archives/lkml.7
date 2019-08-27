Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39036C3A59F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC2A52080C
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566869888;
	bh=fG3J8D1mkqAxAh7P5nG28CZzkPlhZjIBeS5U8PD/Ymk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e4C0NQ5lE3KJcFRGyv1HEjJNizAYcW1+XAlOvfuEUSIIwSZRF+ikWYIeva413v3MY
	 3XMhQyks4/GYUiOKlL3TeDmbTKzEtC4xRsm8ZtfcY50uQePm/sOgMJxG+kNgIYOhJp
	 3Lg0Ze/AqbvUez0ipgVspX0K6HJXNT1iuLmM3iAw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729245AbfH0BiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 21:38:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:51218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729204AbfH0BiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 21:38:02 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 329E72080C;
        Tue, 27 Aug 2019 01:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566869881;
        bh=fG3J8D1mkqAxAh7P5nG28CZzkPlhZjIBeS5U8PD/Ymk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XX8N0v/nTUYIUPYBchWH+RjdOphRTLg2Ho2OhbBMNyeVxyAsg2M3nAI5Ta+7YWEZ8
         qIJ8DC6sh7+IEqGxu1X4o9cEyjDYS8CzelYeyBMzsmepWjf6mQHiZX5/IQhG56nc6O
         bZDSm2srPhti3xY9zmcFvSo21ZimrtvuxLsT6Wq4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 26/33] libperf: Add PERF_RECORD_KSYMBOL 'struct ksymbol_event' to perf/event.h
Date:   Mon, 26 Aug 2019 22:36:27 -0300
Message-Id: <20190827013634.3173-27-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190827013634.3173-1-acme@kernel.org>
References: <20190827013634.3173-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move the PERF_RECORD_KSYMBOL event definition into libperf's event.h
header include.

In order to keep libperf simple, we switch 'u64/u32/u16/u8' types used
events to their generic '__u*' versions.

Perf added 'u*' types mainly to ease up printing __u64 values
as stated in the linux/types.h comment:

  /*
   * We define u64 as uint64_t for every architecture
   * so that we can print it with "%"PRIx64 without getting warnings.
   *
   * typedef __u64 u64;
   * typedef __s64 s64;
   */

Add and use new PRI_lu64 and PRI_lx64 macros for that.  Use extra '_' to
ease up the reading and differentiate them from standard PRI*64 macros.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190825181752.722-11-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/perf/event.h | 13 +++++++++++++
 tools/perf/util/event.c             |  2 +-
 tools/perf/util/event.h             | 13 -------------
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index ef5ec66b566e..8c367931cecc 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -80,4 +80,17 @@ struct throttle_event {
 	__u64			 stream_id;
 };
 
+#ifndef KSYM_NAME_LEN
+#define KSYM_NAME_LEN 256
+#endif
+
+struct ksymbol_event {
+	struct perf_event_header header;
+	__u64			 addr;
+	__u32			 len;
+	__u16			 ksym_type;
+	__u16			 flags;
+	char			 name[KSYM_NAME_LEN];
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
index 40020f5b0484..c4eec1f164ba 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -27,19 +27,6 @@
 #define PRI_lx64 PRIx64
 #endif
 
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

