Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 706FEC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 14:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44F1720672
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 14:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574434727;
	bh=gwtE0YlbFhBeQ+V71cnqqOafttHu7FNH3fC3wt2q8Wk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eFIHQDWsXfkI+y92Ov8OyVQVl54nbIYrpD7/0M2W/ON95CMuA3/cqygzvNjmlMpMt
	 PLwea3+hHp6WFNVkcP8qHYo6qTT6oHk85fvPpg+++N0Y/sTPD5+FlYosEh2S9fAbUB
	 OBkLvJATeEb2izNNaequBPCZKkQyzr81rIVjNaDc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbfKVO6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 09:58:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:59082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727341AbfKVO6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 09:58:05 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B13A207FA;
        Fri, 22 Nov 2019 14:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574434683;
        bh=gwtE0YlbFhBeQ+V71cnqqOafttHu7FNH3fC3wt2q8Wk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R5DnbAmIHNrd4EgjgxfJVFIGJoq5lRqXzk2vne7bXiAXizckxT2pk7HgdcZ2S6jYs
         wi1IkzkN1GbzXhbcMWUXhw3ZV2H/diSwTBn8/hu6Gga0Xr/MRZPMEZ4GexB4LevtJ0
         WIQ+xR4E7Bn/5ellfS2cbbJMzSUQKnZ9mDASvfsU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 16/26] perf auxtrace: Add support for dumping AUX area samples
Date:   Fri, 22 Nov 2019 11:57:01 -0300
Message-Id: <20191122145711.3171-17-acme@kernel.org>
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

Add support for dumping AUX area samples i.e. via the perf script/report
 -D (--dump-raw-trace) option.

Committer notes:

Add __maybe_unused to the two args for auxtrace__dump_auxtrace_sample()
for when we don't HAVE_AUXTRACE_SUPPORT.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20191115124225.5247-10-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/auxtrace.c | 10 ++++++++++
 tools/perf/util/auxtrace.h | 11 +++++++++++
 tools/perf/util/session.c  |  9 +++++++--
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 026585b67a3c..4f5c5fe3516b 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -2417,6 +2417,16 @@ int auxtrace__process_event(struct perf_session *session, union perf_event *even
 	return session->auxtrace->process_event(session, event, sample, tool);
 }
 
+void auxtrace__dump_auxtrace_sample(struct perf_session *session,
+				    struct perf_sample *sample)
+{
+	if (!session->auxtrace || !session->auxtrace->dump_auxtrace_sample ||
+	    auxtrace__dont_decode(session))
+		return;
+
+	session->auxtrace->dump_auxtrace_sample(session, sample);
+}
+
 int auxtrace__flush_events(struct perf_session *session, struct perf_tool *tool)
 {
 	if (!session->auxtrace)
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index ab48de13c353..4a8ac7de6e22 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -141,6 +141,7 @@ struct auxtrace_index {
  * struct auxtrace - session callbacks to allow AUX area data decoding.
  * @process_event: lets the decoder see all session events
  * @process_auxtrace_event: process a PERF_RECORD_AUXTRACE event
+ * @dump_auxtrace_sample: dump AUX area sample data
  * @flush_events: process any remaining data
  * @free_events: free resources associated with event processing
  * @free: free resources associated with the session
@@ -153,6 +154,8 @@ struct auxtrace {
 	int (*process_auxtrace_event)(struct perf_session *session,
 				      union perf_event *event,
 				      struct perf_tool *tool);
+	void (*dump_auxtrace_sample)(struct perf_session *session,
+				     struct perf_sample *sample);
 	int (*flush_events)(struct perf_session *session,
 			    struct perf_tool *tool);
 	void (*free_events)(struct perf_session *session);
@@ -555,6 +558,8 @@ int auxtrace_parse_filters(struct evlist *evlist);
 
 int auxtrace__process_event(struct perf_session *session, union perf_event *event,
 			    struct perf_sample *sample, struct perf_tool *tool);
+void auxtrace__dump_auxtrace_sample(struct perf_session *session,
+				    struct perf_sample *sample);
 int auxtrace__flush_events(struct perf_session *session, struct perf_tool *tool);
 void auxtrace__free_events(struct perf_session *session);
 void auxtrace__free(struct perf_session *session);
@@ -674,6 +679,12 @@ int auxtrace__process_event(struct perf_session *session __maybe_unused,
 	return 0;
 }
 
+static inline
+void auxtrace__dump_auxtrace_sample(struct perf_session *session __maybe_unused,
+				    struct perf_sample *sample __maybe_unused)
+{
+}
+
 static inline
 int auxtrace__flush_events(struct perf_session *session __maybe_unused,
 			   struct perf_tool *tool __maybe_unused)
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index dbdb47624dec..ab4dae1efea3 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1496,8 +1496,13 @@ static int perf_session__deliver_event(struct perf_session *session,
 	if (ret > 0)
 		return 0;
 
-	return machines__deliver_event(&session->machines, session->evlist,
-				       event, &sample, tool, file_offset);
+	ret = machines__deliver_event(&session->machines, session->evlist,
+				      event, &sample, tool, file_offset);
+
+	if (dump_trace && sample.aux_sample.size)
+		auxtrace__dump_auxtrace_sample(session, &sample);
+
+	return ret;
 }
 
 static s64 perf_session__process_user_event(struct perf_session *session,
-- 
2.21.0

