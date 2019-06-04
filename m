Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C12F3C28CC3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 13:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5DE7248EE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 13:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfFDNCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 09:02:11 -0400
Received: from mga07.intel.com ([134.134.136.100]:5114 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727512AbfFDNCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 09:02:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jun 2019 06:02:06 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by fmsmga005.fm.intel.com with ESMTP; 04 Jun 2019 06:02:05 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Jin Yao <yao.jin@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/19] perf intel-pt: Add support for lookahead
Date:   Tue,  4 Jun 2019 16:00:08 +0300
Message-Id: <20190604130017.31207-11-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604130017.31207-1-adrian.hunter@intel.com>
References: <20190604130017.31207-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the lookahead callback to let the decoder access subsequent
buffers. intel_pt_lookahead() manages the buffer lifetime and calls the
decoder for each buffer until the decoder returns a non-zero value.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/intel-pt.c | 59 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 4a61c73c9711..3e3a01318b76 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -278,7 +278,63 @@ static int intel_pt_get_buffer(struct intel_pt_queue *ptq,
 	return 0;
 }
 
-/* This function assumes data is processed sequentially only */
+/* Do not drop buffers with references - refer intel_pt_get_trace() */
+static void intel_pt_lookahead_drop_buffer(struct intel_pt_queue *ptq,
+					   struct auxtrace_buffer *buffer)
+{
+	if (!buffer || buffer == ptq->buffer || buffer == ptq->old_buffer)
+		return;
+
+	auxtrace_buffer__drop_data(buffer);
+}
+
+/* Must be serialized with respect to intel_pt_get_trace() */
+static int intel_pt_lookahead(void *data, intel_pt_lookahead_cb_t cb,
+			      void *cb_data)
+{
+	struct intel_pt_queue *ptq = data;
+	struct auxtrace_buffer *buffer = ptq->buffer;
+	struct auxtrace_buffer *old_buffer = ptq->old_buffer;
+	struct auxtrace_queue *queue;
+	int err = 0;
+
+	queue = &ptq->pt->queues.queue_array[ptq->queue_nr];
+
+	while (1) {
+		struct intel_pt_buffer b = { .len = 0 };
+
+		buffer = auxtrace_buffer__next(queue, buffer);
+		if (!buffer)
+			break;
+
+		err = intel_pt_get_buffer(ptq, buffer, old_buffer, &b);
+		if (err)
+			break;
+
+		if (b.len) {
+			intel_pt_lookahead_drop_buffer(ptq, old_buffer);
+			old_buffer = buffer;
+		} else {
+			intel_pt_lookahead_drop_buffer(ptq, buffer);
+			continue;
+		}
+
+		err = cb(&b, cb_data);
+		if (err)
+			break;
+	}
+
+	if (buffer != old_buffer)
+		intel_pt_lookahead_drop_buffer(ptq, buffer);
+	intel_pt_lookahead_drop_buffer(ptq, old_buffer);
+
+	return err;
+}
+
+/*
+ * This function assumes data is processed sequentially only.
+ * Must be serialized with respect to intel_pt_lookahead()
+ */
 static int intel_pt_get_trace(struct intel_pt_buffer *b, void *data)
 {
 	struct intel_pt_queue *ptq = data;
@@ -827,6 +883,7 @@ static struct intel_pt_queue *intel_pt_alloc_queue(struct intel_pt *pt,
 
 	params.get_trace = intel_pt_get_trace;
 	params.walk_insn = intel_pt_walk_next_insn;
+	params.lookahead = intel_pt_lookahead;
 	params.data = ptq;
 	params.return_compression = intel_pt_return_compression(pt);
 	params.branch_enable = intel_pt_branch_enable(pt);
-- 
2.17.1

