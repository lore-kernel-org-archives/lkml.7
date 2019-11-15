Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF5FC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E0882072D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbfKOMno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 07:43:44 -0500
Received: from mga14.intel.com ([192.55.52.115]:58938 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727699AbfKOMnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 07:43:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2019 04:43:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,308,1569308400"; 
   d="scan'208";a="257749690"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.197])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Nov 2019 04:43:36 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 10/15] perf session: Add facility to peek at all events
Date:   Fri, 15 Nov 2019 14:42:20 +0200
Message-Id: <20191115124225.5247-11-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191115124225.5247-1-adrian.hunter@intel.com>
References: <20191115124225.5247-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AUX area samples are not limited in how far back in time the sample could
start. Consequently samples must be queued in advance to allow for
time-ordered processing. To achieve that, add perf_session__peek_events()
that walks and peeks at all the events.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/session.c | 28 ++++++++++++++++++++++++++++
 tools/perf/util/session.h |  5 +++++
 2 files changed, 33 insertions(+)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 72a1f73c2878..cd0c4ce1edca 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1659,6 +1659,34 @@ int perf_session__peek_event(struct perf_session *session, off_t file_offset,
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
index 8456e1d868fd..f76480166d38 100644
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
 
-- 
2.17.1

