Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD35C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4802B2184C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560279865;
	bh=QfqZ0TnqD8vNI0tAhe2tPnK9c3wp3Ua//Kews5Gurxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o8egPtCV/l3r+c7ebTQ349Kch317WFYQHrXU7PT69KuF+vo2ie5dDuUdLGoUJzPDz
	 5CNbSbGfUoosueXiHspMB5fVfXBBy/Y1LOrspyMw7ZmKuNh3c90/Jbhu7UlRZuqEcf
	 1P+f2V5jUu7HN/6s8H+ksGadhCAZqL9A3cuyG/rM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407278AbfFKTEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:04:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:40624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405412AbfFKTEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:04:23 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77A8F2183E;
        Tue, 11 Jun 2019 19:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279862;
        bh=QfqZ0TnqD8vNI0tAhe2tPnK9c3wp3Ua//Kews5Gurxw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uhHhaARF7Xd+YIZihzFS7/bd02+eUb3TL/roCej9Q/K0GZjzYWjGY2taZbWzdCF4T
         IboA1Q5aNCdIry+sJUUGuuggBiZnRDM1qpYi5yUwRi/33bnYmsREeAg5KMgs6Ju5dC
         fHNlO/0kxn3Pc8p4WFy3Ij6RnNjOUfTbdsiGUzKg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 71/85] perf intel-pt: Factor out intel_pt_get_buffer()
Date:   Tue, 11 Jun 2019 15:58:57 -0300
Message-Id: <20190611185911.11645-72-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Factor out intel_pt_get_buffer() so it can be reused.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190604130017.31207-10-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt.c | 60 +++++++++++++++++++++++---------------
 1 file changed, 37 insertions(+), 23 deletions(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 3cff8fe2eaa0..4a61c73c9711 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -239,32 +239,13 @@ static int intel_pt_do_fix_overlap(struct intel_pt *pt, struct auxtrace_buffer *
 	return 0;
 }
 
-/* This function assumes data is processed sequentially only */
-static int intel_pt_get_trace(struct intel_pt_buffer *b, void *data)
+static int intel_pt_get_buffer(struct intel_pt_queue *ptq,
+			       struct auxtrace_buffer *buffer,
+			       struct auxtrace_buffer *old_buffer,
+			       struct intel_pt_buffer *b)
 {
-	struct intel_pt_queue *ptq = data;
-	struct auxtrace_buffer *buffer = ptq->buffer;
-	struct auxtrace_buffer *old_buffer = ptq->old_buffer;
-	struct auxtrace_queue *queue;
 	bool might_overlap;
 
-	if (ptq->stop) {
-		b->len = 0;
-		return 0;
-	}
-
-	queue = &ptq->pt->queues.queue_array[ptq->queue_nr];
-
-	buffer = auxtrace_buffer__next(queue, buffer);
-	if (!buffer) {
-		if (old_buffer)
-			auxtrace_buffer__drop_data(old_buffer);
-		b->len = 0;
-		return 0;
-	}
-
-	ptq->buffer = buffer;
-
 	if (!buffer->data) {
 		int fd = perf_data__fd(ptq->pt->session->data);
 
@@ -294,6 +275,39 @@ static int intel_pt_get_trace(struct intel_pt_buffer *b, void *data)
 		b->consecutive = true;
 	}
 
+	return 0;
+}
+
+/* This function assumes data is processed sequentially only */
+static int intel_pt_get_trace(struct intel_pt_buffer *b, void *data)
+{
+	struct intel_pt_queue *ptq = data;
+	struct auxtrace_buffer *buffer = ptq->buffer;
+	struct auxtrace_buffer *old_buffer = ptq->old_buffer;
+	struct auxtrace_queue *queue;
+	int err;
+
+	if (ptq->stop) {
+		b->len = 0;
+		return 0;
+	}
+
+	queue = &ptq->pt->queues.queue_array[ptq->queue_nr];
+
+	buffer = auxtrace_buffer__next(queue, buffer);
+	if (!buffer) {
+		if (old_buffer)
+			auxtrace_buffer__drop_data(old_buffer);
+		b->len = 0;
+		return 0;
+	}
+
+	ptq->buffer = buffer;
+
+	err = intel_pt_get_buffer(ptq, buffer, old_buffer, b);
+	if (err)
+		return err;
+
 	if (ptq->step_through_buffers)
 		ptq->stop = true;
 
-- 
2.20.1

