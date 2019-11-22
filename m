Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C96B3C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 14:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 942E12075B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 14:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574434693;
	bh=XKiISVLCmYRbT7a/PJXfowqAzOFzM9sp7HMJkAZ26Ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f6nJzlhhQvx40jzVTGK4AjqPvgOOtu4bmEPQ9lHMQyn6r6LQN1Nh03nHxC+0wvd3g
	 T3fEdwGCW/oxdB9bXJuwEBf9kkRit83oxTZ9YvbSTREigEFCyYpxjnnKBsLtnkfiDj
	 u3JKFgfm2XFHEkeCfSpkFDPnFjZy9W10Vfr8z4ak=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbfKVO6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 09:58:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:59182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727516AbfKVO6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 09:58:10 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF60F20730;
        Fri, 22 Nov 2019 14:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574434688;
        bh=XKiISVLCmYRbT7a/PJXfowqAzOFzM9sp7HMJkAZ26Ac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X2wy09V2Qe7H4kXvcSzp3TEo5ZT18KmFRnJ/ftUv/lkq/Cq4bHl0w3yl8A4HWIMbQ
         ZpEORf0gIW9w1GP2YVd9svUfGtmIKAGReAeGw2L4ZQcLZ8pqVidrAI8zkXNgD0vFvZ
         E6mKZfB87rz8BrKre8jpfvp1rQLU8R0ZKuWlNrso=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 18/26] perf auxtrace: Add support for queuing AUX area samples
Date:   Fri, 22 Nov 2019 11:57:03 -0300
Message-Id: <20191122145711.3171-19-acme@kernel.org>
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

Add functions to queue AUX area samples in advance
(auxtrace_queue_data()) or individually (auxtrace_queues__add_sample())
or find out what queue a sample belongs on
(auxtrace_queues__sample_queue()).

auxtrace_queue_data() can also queue snapshot data which keeps snapshots
and samples ordered with respect to each other in case support for that
is desired.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20191115124225.5247-12-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/auxtrace.c | 107 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/auxtrace.h |  15 ++++++
 2 files changed, 122 insertions(+)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 4f5c5fe3516b..eb087e7df6f4 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1004,6 +1004,113 @@ struct auxtrace_buffer *auxtrace_buffer__next(struct auxtrace_queue *queue,
 	}
 }
 
+struct auxtrace_queue *auxtrace_queues__sample_queue(struct auxtrace_queues *queues,
+						     struct perf_sample *sample,
+						     struct perf_session *session)
+{
+	struct perf_sample_id *sid;
+	unsigned int idx;
+	u64 id;
+
+	id = sample->id;
+	if (!id)
+		return NULL;
+
+	sid = perf_evlist__id2sid(session->evlist, id);
+	if (!sid)
+		return NULL;
+
+	idx = sid->idx;
+
+	if (idx >= queues->nr_queues)
+		return NULL;
+
+	return &queues->queue_array[idx];
+}
+
+int auxtrace_queues__add_sample(struct auxtrace_queues *queues,
+				struct perf_session *session,
+				struct perf_sample *sample, u64 data_offset,
+				u64 reference)
+{
+	struct auxtrace_buffer buffer = {
+		.pid = -1,
+		.data_offset = data_offset,
+		.reference = reference,
+		.size = sample->aux_sample.size,
+	};
+	struct perf_sample_id *sid;
+	u64 id = sample->id;
+	unsigned int idx;
+
+	if (!id)
+		return -EINVAL;
+
+	sid = perf_evlist__id2sid(session->evlist, id);
+	if (!sid)
+		return -ENOENT;
+
+	idx = sid->idx;
+	buffer.tid = sid->tid;
+	buffer.cpu = sid->cpu;
+
+	return auxtrace_queues__add_buffer(queues, session, idx, &buffer, NULL);
+}
+
+struct queue_data {
+	bool samples;
+	bool events;
+};
+
+static int auxtrace_queue_data_cb(struct perf_session *session,
+				  union perf_event *event, u64 offset,
+				  void *data)
+{
+	struct queue_data *qd = data;
+	struct perf_sample sample;
+	int err;
+
+	if (qd->events && event->header.type == PERF_RECORD_AUXTRACE) {
+		if (event->header.size < sizeof(struct perf_record_auxtrace))
+			return -EINVAL;
+		offset += event->header.size;
+		return session->auxtrace->queue_data(session, NULL, event,
+						     offset);
+	}
+
+	if (!qd->samples || event->header.type != PERF_RECORD_SAMPLE)
+		return 0;
+
+	err = perf_evlist__parse_sample(session->evlist, event, &sample);
+	if (err)
+		return err;
+
+	if (!sample.aux_sample.size)
+		return 0;
+
+	offset += sample.aux_sample.data - (void *)event;
+
+	return session->auxtrace->queue_data(session, &sample, NULL, offset);
+}
+
+int auxtrace_queue_data(struct perf_session *session, bool samples, bool events)
+{
+	struct queue_data qd = {
+		.samples = samples,
+		.events = events,
+	};
+
+	if (auxtrace__dont_decode(session))
+		return 0;
+
+	if (!session->auxtrace || !session->auxtrace->queue_data)
+		return -EINVAL;
+
+	return perf_session__peek_events(session, session->header.data_offset,
+					 session->header.data_size,
+					 auxtrace_queue_data_cb, &qd);
+}
+
 void *auxtrace_buffer__get_data(struct auxtrace_buffer *buffer, int fd)
 {
 	size_t adj = buffer->data_offset & (page_size - 1);
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 4a8ac7de6e22..749d72cd9c7b 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -141,6 +141,8 @@ struct auxtrace_index {
  * struct auxtrace - session callbacks to allow AUX area data decoding.
  * @process_event: lets the decoder see all session events
  * @process_auxtrace_event: process a PERF_RECORD_AUXTRACE event
+ * @queue_data: queue an AUX sample or PERF_RECORD_AUXTRACE event for later
+ *              processing
  * @dump_auxtrace_sample: dump AUX area sample data
  * @flush_events: process any remaining data
  * @free_events: free resources associated with event processing
@@ -154,6 +156,9 @@ struct auxtrace {
 	int (*process_auxtrace_event)(struct perf_session *session,
 				      union perf_event *event,
 				      struct perf_tool *tool);
+	int (*queue_data)(struct perf_session *session,
+			  struct perf_sample *sample, union perf_event *event,
+			  u64 data_offset);
 	void (*dump_auxtrace_sample)(struct perf_session *session,
 				     struct perf_sample *sample);
 	int (*flush_events)(struct perf_session *session,
@@ -467,9 +472,19 @@ int auxtrace_queues__add_event(struct auxtrace_queues *queues,
 			       struct perf_session *session,
 			       union perf_event *event, off_t data_offset,
 			       struct auxtrace_buffer **buffer_ptr);
+struct auxtrace_queue *
+auxtrace_queues__sample_queue(struct auxtrace_queues *queues,
+			      struct perf_sample *sample,
+			      struct perf_session *session);
+int auxtrace_queues__add_sample(struct auxtrace_queues *queues,
+				struct perf_session *session,
+				struct perf_sample *sample, u64 data_offset,
+				u64 reference);
 void auxtrace_queues__free(struct auxtrace_queues *queues);
 int auxtrace_queues__process_index(struct auxtrace_queues *queues,
 				   struct perf_session *session);
+int auxtrace_queue_data(struct perf_session *session, bool samples,
+			bool events);
 struct auxtrace_buffer *auxtrace_buffer__next(struct auxtrace_queue *queue,
 					      struct auxtrace_buffer *buffer);
 void *auxtrace_buffer__get_data(struct auxtrace_buffer *buffer, int fd);
-- 
2.21.0

