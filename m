Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EFEC3A5A4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86B5B2184D
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730217AbfH0I0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:26:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42861 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730055AbfH0I0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:26:37 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2Wo9-0007vM-Vf; Tue, 27 Aug 2019 10:26:30 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9AFC11C0DE4;
        Tue, 27 Aug 2019 10:26:22 +0200 (CEST)
Date:   Tue, 27 Aug 2019 08:26:22 -0000
From:   tip-bot2 for Jiri Olsa <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] libperf: Add PERF_RECORD_KSYMBOL 'struct
 ksymbol_event' to perf/event.h
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190825181752.722-11-jolsa@kernel.org>
References: <20190825181752.722-11-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <156689438252.24550.2082971928714763322.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     f15e3c25a1b40794a0ef2647360afe873fe34f54
Gitweb:        https://git.kernel.org/tip/f15e3c25a1b40794a0ef2647360afe873fe34f54
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Sun, 25 Aug 2019 20:17:50 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 26 Aug 2019 19:39:10 -03:00

libperf: Add PERF_RECORD_KSYMBOL 'struct ksymbol_event' to perf/event.h

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
index ef5ec66..8c36793 100644
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
index 3bd9fc2..4447cd2 100644
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
index 40020f5..c4eec1f 100644
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
