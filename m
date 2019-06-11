Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BED0C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 548AC2183E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560279869;
	bh=cWC9WCKFBYymiaKR3AELIx9hhdgcgSHePxydWkn6sFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rKQgoiKM3Ez+L9PUxEgqJUSQBaCMvlhzXRQJ1wI1pGv4RY66xQtd9MZ63VzIAHNpZ
	 XJVCGtaBup+loZWnUL9IebG/QlS+2iI2JSnUqXMujJfxePCJB6LvYogv18t1NxXPNr
	 Y2yRtkNr44E3o0Yz1nfj98UhrvwQpkEb/D/56RXk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407286AbfFKTE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:04:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:40658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405412AbfFKTE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:04:26 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97619217D6;
        Tue, 11 Jun 2019 19:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279865;
        bh=cWC9WCKFBYymiaKR3AELIx9hhdgcgSHePxydWkn6sFA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M8ZuWSEZEJxn3Mve4rtB66btPCn4pIvEMz9/LN7MlfN1pHbhGz/rgMd+gjbQVCIcK
         Z5N+SnmagnWLoEqJmqZDzGk4rVkU5WzQM0K3dZq2npbh83Fu8sR0hU7GC69GqoYKT8
         cwpxWSK5sT90kfy6x2JlicWKpcpU+Nz15mXFW7ms=
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
Subject: [PATCH 72/85] perf intel-pt: Add support for lookahead
Date:   Tue, 11 Jun 2019 15:58:58 -0300
Message-Id: <20190611185911.11645-73-acme@kernel.org>
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

Implement the lookahead callback to let the decoder access subsequent
buffers. intel_pt_lookahead() manages the buffer lifetime and calls the
decoder for each buffer until the decoder returns a non-zero value.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190604130017.31207-11-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.20.1

