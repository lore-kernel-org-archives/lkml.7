Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8C2C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 08:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 771932071C
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 08:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfKWIPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 03:15:13 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36266 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfKWIPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 03:15:12 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iYQZO-0002WS-Gd; Sat, 23 Nov 2019 09:15:06 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 01BD61C1ACF;
        Sat, 23 Nov 2019 09:15:01 +0100 (CET)
Date:   Sat, 23 Nov 2019 08:15:00 -0000
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf session: Add facility to peek at all events
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191115124225.5247-11-adrian.hunter@intel.com>
References: <20191115124225.5247-11-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <157449690093.21853.12380294088272415245.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     103ed40e4bfa6986d80983b3e67be9d2f61fc9ee
Gitweb:        https://git.kernel.org/tip/103ed40e4bfa6986d80983b3e67be9d2f61fc9ee
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Fri, 15 Nov 2019 14:42:20 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 22 Nov 2019 10:48:13 -03:00

perf session: Add facility to peek at all events

AUX area samples are not limited in how far back in time the sample
could start. Consequently samples must be queued in advance to allow for
time-ordered processing. To achieve that, add
perf_session__peek_events() that walks and peeks at all the events.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20191115124225.5247-11-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/session.c | 28 ++++++++++++++++++++++++++++
 tools/perf/util/session.h |  5 +++++
 2 files changed, 33 insertions(+)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index ab4dae1..d0d7d25 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1659,6 +1659,34 @@ out_parse_sample:
 	return 0;
 }
 
+int perf_session__peek_events(struct perf_session *session, u64 offset,
+			      u64 size, peek_events_cb_t cb, void *data)
+{
+	u64 max_offset = offset + size;
+	char buf[PERF_SAMPLE_MAX_SIZE];
+	union perf_event *event;
+	int err;
+
+	do {
+		err = perf_session__peek_event(session, offset, buf,
+					       PERF_SAMPLE_MAX_SIZE, &event,
+					       NULL);
+		if (err)
+			return err;
+
+		err = cb(session, event, offset, data);
+		if (err)
+			return err;
+
+		offset += event->header.size;
+		if (event->header.type == PERF_RECORD_AUXTRACE)
+			offset += event->auxtrace.size;
+
+	} while (offset < max_offset);
+
+	return err;
+}
+
 static s64 perf_session__process_event(struct perf_session *session,
 				       union perf_event *event, u64 file_offset)
 {
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index 8456e1d..f764801 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -64,6 +64,11 @@ int perf_session__peek_event(struct perf_session *session, off_t file_offset,
 			     void *buf, size_t buf_sz,
 			     union perf_event **event_ptr,
 			     struct perf_sample *sample);
+typedef int (*peek_events_cb_t)(struct perf_session *session,
+				union perf_event *event, u64 offset,
+				void *data);
+int perf_session__peek_events(struct perf_session *session, u64 offset,
+			      u64 size, peek_events_cb_t cb, void *data);
 
 int perf_session__process_events(struct perf_session *session);
 
