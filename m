Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EBD4C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F12C222BD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbfKMK5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 05:57:03 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37366 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfKMK5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 05:57:00 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iUqKL-00026S-IZ; Wed, 13 Nov 2019 11:56:45 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 31EC51C0092;
        Wed, 13 Nov 2019 11:56:45 +0100 (CET)
Date:   Wed, 13 Nov 2019 10:56:44 -0000
From:   "tip-bot2 for Alexander Shishkin" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/pt: Add sampling support
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>,
        adrian.hunter@intel.com, mathieu.poirier@linaro.org,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191025140835.53665-4-alexander.shishkin@linux.intel.com>
References: <20191025140835.53665-4-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Message-ID: <157364260484.29376.825811827291053349.tip-bot2@tip-bot2>
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

Commit-ID:     25e8920b301c133aeaa9f57d81295bf4ac78e17b
Gitweb:        https://git.kernel.org/tip/25e8920b301c133aeaa9f57d81295bf4ac78e17b
Author:        Alexander Shishkin <alexander.shishkin@linux.intel.com>
AuthorDate:    Fri, 25 Oct 2019 17:08:35 +03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 13 Nov 2019 11:06:16 +01:00

perf/x86/intel/pt: Add sampling support

Add AUX sampling support to the PT PMU: implement an NMI-safe callback
that takes a snapshot of the buffer without touching the event states.
This is done for PT events that don't use PMIs, that is, snapshot mode
(RO mapping of the AUX area).

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: adrian.hunter@intel.com
Cc: mathieu.poirier@linaro.org
Link: https://lkml.kernel.org/r/20191025140835.53665-4-alexander.shishkin@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/pt.c | 54 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 170f3b4..2f20d5a 100644
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
