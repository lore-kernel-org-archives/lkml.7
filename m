Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D27AC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 14:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6C5520672
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 14:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574434725;
	bh=cHg/O589AKGsVWgFP8zppA3o0r/Kmjmz5rJ70N/4m6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1dymlbus8vmCX65AZNZTla74Y2YRaeQgnL9+r+n1JncaSEjO2ar0zLWz9pWwMSNoO
	 mRN1zmQglNlNDZzGWI0AEpRWJ9Qbr4k5EwadNdnGRW/pAENx6OLnJ+AcVgl7kZE9cZ
	 57Y65UWWfjRSBZUw0mb9V6/TM73oYGdmc/lhOcYs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbfKVO6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 09:58:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:59120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727425AbfKVO6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 09:58:06 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A9862073B;
        Fri, 22 Nov 2019 14:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574434686;
        bh=cHg/O589AKGsVWgFP8zppA3o0r/Kmjmz5rJ70N/4m6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ztWrUzX4B/cpZtAvN7WOraNpk1JQwblJ8y+IWOQMkJU1DxDWLcHq/vzxsPDIDOru7
         aoGIW1lfLohDKf0m4OlPmkEJ5ddYu+ZRUVC1bQseCckfh1X9tYgz4ijTSUyu7H7k2d
         YLwYRldGnYDpMz5je4uDUeziu/ZJOja2BHOvqPfo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 17/26] perf session: Add facility to peek at all events
Date:   Fri, 22 Nov 2019 11:57:02 -0300
Message-Id: <20191122145711.3171-18-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191122145711.3171-1-acme@kernel.org>
References: <20191122145711.3171-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

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
index ab4dae1efea3..d0d7d25b23e3 100644
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
2.21.0

