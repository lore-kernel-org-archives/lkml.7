Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB29C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 08:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F712084D
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 08:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfKWIPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 03:15:15 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36255 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbfKWIPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 03:15:12 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iYQZK-0002WR-Ge; Sat, 23 Nov 2019 09:15:02 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D30691C1ACC;
        Sat, 23 Nov 2019 09:15:00 +0100 (CET)
Date:   Sat, 23 Nov 2019 08:15:00 -0000
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf auxtrace: Add support for queuing AUX area samples
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191115124225.5247-12-adrian.hunter@intel.com>
References: <20191115124225.5247-12-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <157449690079.21853.17585003631960442237.tip-bot2@tip-bot2>
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

Commit-ID:     ac2f445fc8989e152dc35eb7af368fd34b92e48a
Gitweb:        https://git.kernel.org/tip/ac2f445fc8989e152dc35eb7af368fd34b92e48a
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Fri, 15 Nov 2019 14:42:21 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 22 Nov 2019 10:48:13 -03:00

perf auxtrace: Add support for queuing AUX area samples

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
 tools/perf/util/auxtrace.c | 107 ++++++++++++++++++++++++++++++++++++-
 tools/perf/util/auxtrace.h |  15 +++++-
 2 files changed, 122 insertions(+)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 4f5c5fe..eb087e7 100644
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
index 4a8ac7d..749d72c 100644
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
