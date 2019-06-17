Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C0EC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF62A208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="QoUbnu2P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbfFQToC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:44:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58669 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfFQToC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:44:02 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJhmPj3567439
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:43:48 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJhmPj3567439
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560800629;
        bh=Ho9wqOocm9zbiJpAD5jHwobX8E0hpB/XFFyOv/ogX9I=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=QoUbnu2PP4785nJUl1Rohe+qiEgxhtZpityVDhqCdp0djIeqb4EYy7mSM7I3akfsa
         IGqh0rC/bLM/PS4zf4iMjv91F/pMJkoeq+adSkEEV7pdLxtSDD4pbCZ/bRdkrfgJ5Q
         MRt6lZbpewd4OSBxLyROqe/zKa1OdujvShqn0muOvNmVgorIhXiYQVr74o4sQyq4jB
         Mv/+i0wxQHuO0/oTohuLI++ivkYRGG3XRcF3HNyrvhB/OHDv49Cd0TDZmJjdpMUYmA
         wzsEm66nHhicpyeE0tId0usXSYIHI27wQfGGm5uK4/fEWqHpxgi7uT3YP9/IF77mE8
         5n+gq4UvwEqNg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJhm4Y3567436;
        Mon, 17 Jun 2019 12:43:48 -0700
Date:   Mon, 17 Jun 2019 12:43:48 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-e96f7df8807615b96af59f8f8bc6263a7adc27b7@git.kernel.org>
Cc:     adrian.hunter@intel.com, acme@redhat.com, jolsa@redhat.com,
        yao.jin@linux.intel.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, yao.jin@linux.intel.com,
          tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
          adrian.hunter@intel.com, jolsa@redhat.com, acme@redhat.com
In-Reply-To: <20190604130017.31207-10-adrian.hunter@intel.com>
References: <20190604130017.31207-10-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf intel-pt: Factor out intel_pt_get_buffer()
Git-Commit-ID: e96f7df8807615b96af59f8f8bc6263a7adc27b7
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

Commit-ID:  e96f7df8807615b96af59f8f8bc6263a7adc27b7
Gitweb:     https://git.kernel.org/tip/e96f7df8807615b96af59f8f8bc6263a7adc27b7
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Tue, 4 Jun 2019 16:00:07 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 10 Jun 2019 16:20:12 -0300

perf intel-pt: Factor out intel_pt_get_buffer()

Factor out intel_pt_get_buffer() so it can be reused.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190604130017.31207-10-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt.c | 60 ++++++++++++++++++++++++++++------------------
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
 
