Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C723ACA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 09:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A76F020B7C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 09:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731652AbfJVJ6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 05:58:48 -0400
Received: from mga12.intel.com ([192.55.52.136]:26087 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731220AbfJVJ6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 05:58:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2019 02:58:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,326,1566889200"; 
   d="scan'208";a="197074473"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 22 Oct 2019 02:58:43 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, adrian.hunter@intel.com,
        mathieu.poirier@linaro.org, mark.rutland@arm.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH v2 3/4] perf/x86/intel/pt: Add sampling support
Date:   Tue, 22 Oct 2019 12:58:11 +0300
Message-Id: <20191022095812.67071-4-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191022095812.67071-1-alexander.shishkin@linux.intel.com>
References: <20191022095812.67071-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add AUX sampling support to the PT PMU: implement an NMI-safe callback
that takes a snapshot of the buffer without touching the event states.
This is done for PT events that don't use PMIs, that is, snapshot mode
(RO mapping of the AUX area).

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 arch/x86/events/intel/pt.c | 54 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 170f3b402274..2f20d5a333c1 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -1208,6 +1208,13 @@ pt_buffer_setup_aux(struct perf_event *event, void **pages,
 	if (!nr_pages)
 		return NULL;
 
+	/*
+	 * Only support AUX sampling in snapshot mode, where we don't
+	 * generate NMIs.
+	 */
+	if (event->attr.aux_sample_size && !snapshot)
+		return NULL;
+
 	if (cpu == -1)
 		cpu = raw_smp_processor_id();
 	node = cpu_to_node(cpu);
@@ -1506,6 +1513,52 @@ static void pt_event_stop(struct perf_event *event, int mode)
 	}
 }
 
+static long pt_event_snapshot_aux(struct perf_event *event,
+				  struct perf_output_handle *handle,
+				  unsigned long size)
+{
+	struct pt *pt = this_cpu_ptr(&pt_ctx);
+	struct pt_buffer *buf = perf_get_aux(&pt->handle);
+	unsigned long from = 0, to;
+	long ret;
+
+	if (WARN_ON_ONCE(!buf))
+		return 0;
+
+	/*
+	 * Sampling is only allowed on snapshot events;
+	 * see pt_buffer_setup_aux().
+	 */
+	if (WARN_ON_ONCE(!buf->snapshot))
+		return 0;
+
+	/*
+	 * Here, handle_nmi tells us if the tracing is on
+	 */
+	if (READ_ONCE(pt->handle_nmi))
+		pt_config_stop(event);
+
+	pt_read_offset(buf);
+	pt_update_head(pt);
+
+	to = local_read(&buf->data_size);
+	if (to < size)
+		from = buf->nr_pages << PAGE_SHIFT;
+	from += to - size;
+
+	ret = perf_output_copy_aux(&pt->handle, handle, from, to);
+
+	/*
+	 * If the tracing was on when we turned up, restart it.
+	 * Compiler barrier not needed as we couldn't have been
+	 * preempted by anything that touches pt->handle_nmi.
+	 */
+	if (pt->handle_nmi)
+		pt_config_start(event);
+
+	return ret;
+}
+
 static void pt_event_del(struct perf_event *event, int mode)
 {
 	pt_event_stop(event, PERF_EF_UPDATE);
@@ -1625,6 +1678,7 @@ static __init int pt_init(void)
 	pt_pmu.pmu.del			 = pt_event_del;
 	pt_pmu.pmu.start		 = pt_event_start;
 	pt_pmu.pmu.stop			 = pt_event_stop;
+	pt_pmu.pmu.snapshot_aux		 = pt_event_snapshot_aux;
 	pt_pmu.pmu.read			 = pt_event_read;
 	pt_pmu.pmu.setup_aux		 = pt_buffer_setup_aux;
 	pt_pmu.pmu.free_aux		 = pt_buffer_free_aux;
-- 
2.23.0

