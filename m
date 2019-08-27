Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C113EC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A13062173E
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730950AbfH0I1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:27:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42828 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729931AbfH0I0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:26:32 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2Wo5-0007wK-JZ; Tue, 27 Aug 2019 10:26:25 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 0E98D1C0DE1;
        Tue, 27 Aug 2019 10:26:23 +0200 (CEST)
Date:   Tue, 27 Aug 2019 08:26:22 -0000
From:   tip-bot2 for Jiri Olsa <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] libperf: Add PERF_RECORD_BPF_EVENT 'struct
 bpf_event' to perf/event.h
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190825181752.722-12-jolsa@kernel.org>
References: <20190825181752.722-12-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <156689438297.24553.15231613609627693154.tip-bot2@tip-bot2>
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

Commit-ID:     b1b510142283c02991f48b27d399852364f7d89b
Gitweb:        https://git.kernel.org/tip/b1b510142283c02991f48b27d399852364f7d89b
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Sun, 25 Aug 2019 20:17:51 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 26 Aug 2019 19:39:10 -03:00

libperf: Add PERF_RECORD_BPF_EVENT 'struct bpf_event' to perf/event.h

Move the PERF_RECORD_BPF_EVENT event definition to libperf's event.h.

In order to keep libperf simple, we switch 'u64/u32/u16/u8'
types used events to their generic '__u*' versions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190825181752.722-12-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/perf/event.h | 11 +++++++++++
 tools/perf/util/event.h             | 10 ----------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index 8c36793..585c9d8 100644
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
 	char			 name[KSYM_NAME_LEN];
 };
 
+struct bpf_event {
+	struct perf_event_header header;
+	__u16			 type;
+	__u16			 flags;
+	__u32			 id;
+
+	/* for bpf_prog types */
+	__u8			 tag[BPF_TAG_SIZE];  // prog tag
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index c4eec1f..091a069 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -27,16 +27,6 @@
 #define PRI_lx64 PRIx64
 #endif
 
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
