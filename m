Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78EC2C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 469C72084B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="qdXOjm00"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbfFQTps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:45:48 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45213 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfFQTpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:45:47 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJiUEh3569088
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:44:30 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJiUEh3569088
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560800670;
        bh=8gl/eYDJX8pT7ax8tqFxPUFuvJS+i8tDss4fzL2vDCw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=qdXOjm001P5lx86OY5aLeK6uGFOGmr5rIgvIqe7YL3iaAvMz64aA27DpkkSmTVilC
         NKVcOK/1Q+7qFCZpapHrkDLHWqrSfdFGvIn7wtEWowryiU4t8oSm/amQ0ZKQgTmcZz
         9xnCfj73o1j7noLeesjd2U+sIZgyS6jt59DiNFgmpagwfvFK1QS91kFxsInJjCeQ+Q
         Jrhe+ZvfOSu4MzP1rEyTOgXvbWgYSJcJqGz3pVwycR4bQle2R2C1K7GVd0JpxeNJ0d
         N5fJfucOTSVakGU/KoFUv2xScVxbLYCVVRu70PkCQtmoFu2n1mZlwR/IRzNd7gmtM+
         93Jp9Up+TJFGw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJiUVm3569085;
        Mon, 17 Jun 2019 12:44:30 -0700
Date:   Mon, 17 Jun 2019 12:44:30 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-da9000ae35027fb7305b8cad0b37df71937ad578@git.kernel.org>
Cc:     hpa@zytor.com, tglx@linutronix.de, yao.jin@linux.intel.com,
        jolsa@redhat.com, acme@redhat.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, adrian.hunter@intel.com
Reply-To: adrian.hunter@intel.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, acme@redhat.com, jolsa@redhat.com,
          yao.jin@linux.intel.com, hpa@zytor.com, tglx@linutronix.de
In-Reply-To: <20190604130017.31207-11-adrian.hunter@intel.com>
References: <20190604130017.31207-11-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf intel-pt: Add support for lookahead
Git-Commit-ID: da9000ae35027fb7305b8cad0b37df71937ad578
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  da9000ae35027fb7305b8cad0b37df71937ad578
Gitweb:     https://git.kernel.org/tip/da9000ae35027fb7305b8cad0b37df71937ad578
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Tue, 4 Jun 2019 16:00:08 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 10 Jun 2019 16:20:12 -0300

perf intel-pt: Add support for lookahead

Implement the lookahead callback to let the decoder access subsequent
buffers. intel_pt_lookahead() manages the buffer lifetime and calls the
decoder for each buffer until the decoder returns a non-zero value.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190604130017.31207-11-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt.c | 59 +++++++++++++++++++++++++++++++++++++++++++++-
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
