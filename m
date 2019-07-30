Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346FCC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 078BC20578
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564455633;
	bh=CUCM1R6GgLJdb5LHdmoWMhfdaBCuWow7fWqB8jMC3y8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RKRzMwxmpYXGnjDmiJlZDtxopLksonEdA/1Aq50La4jRj/1X62JqxyxVgKiTYNa9G
	 XZT4tww64AnxOKMf8hwO2xiwhz2eaEKLZibn/ynSDK5EqF2BoLWBzrOcNT0hsNCcaD
	 /enhHbZk/kw6gc+0zc7k/D6X/S4hgv0RdkTc/N9A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732382AbfG3DAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 23:00:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:49738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732395AbfG3DA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 23:00:26 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D744A206DD;
        Tue, 30 Jul 2019 03:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455625;
        bh=CUCM1R6GgLJdb5LHdmoWMhfdaBCuWow7fWqB8jMC3y8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L2tWryznaKBK4JBYyKHG2hCVj1XRbWhXU9OT9y2uH8u9WFwpPVCTb8UmK/D8BsCq3
         IlXzN+YufLj3C0i+b+2NFntkxedGPrXamTEeNM3vAlGGWgvyHB5uygRpBu0i+V35yx
         G3J0iCrwv1UgF0h72Qc9NWU/GpRwoxb/+6JSpMC4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 073/107] libperf: Add perf_evsel__new() function
Date:   Mon, 29 Jul 2019 23:55:36 -0300
Message-Id: <20190730025610.22603-74-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190730025610.22603-1-acme@kernel.org>
References: <20190730025610.22603-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add a perf_evsel__new() function to create and init a perf_evsel struct
dynamicaly.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-47-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evsel.c              | 11 +++++++++++
 tools/perf/lib/include/perf/evsel.h |  1 +
 tools/perf/lib/libperf.map          |  1 +
 3 files changed, 13 insertions(+)

diff --git a/tools/perf/lib/evsel.c b/tools/perf/lib/evsel.c
index 17cba35becc7..8e91738c5c38 100644
--- a/tools/perf/lib/evsel.c
+++ b/tools/perf/lib/evsel.c
@@ -2,9 +2,20 @@
 #include <perf/evsel.h>
 #include <linux/list.h>
 #include <internal/evsel.h>
+#include <linux/zalloc.h>
 
 void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr)
 {
 	INIT_LIST_HEAD(&evsel->node);
 	evsel->attr = *attr;
 }
+
+struct perf_evsel *perf_evsel__new(struct perf_event_attr *attr)
+{
+	struct perf_evsel *evsel = zalloc(sizeof(*evsel));
+
+	if (evsel != NULL)
+		perf_evsel__init(evsel, attr);
+
+	return evsel;
+}
diff --git a/tools/perf/lib/include/perf/evsel.h b/tools/perf/lib/include/perf/evsel.h
index 295583b89f46..21b66fc1937f 100644
--- a/tools/perf/lib/include/perf/evsel.h
+++ b/tools/perf/lib/include/perf/evsel.h
@@ -9,5 +9,6 @@ struct perf_event_attr;
 
 LIBPERF_API void perf_evsel__init(struct perf_evsel *evsel,
 				  struct perf_event_attr *attr);
+LIBPERF_API struct perf_evsel *perf_evsel__new(struct perf_event_attr *attr);
 
 #endif /* __LIBPERF_EVSEL_H */
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index 5e685d6c7a95..e3eac9b60726 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -11,6 +11,7 @@ LIBPERF_0.0.1 {
 		perf_thread_map__comm;
 		perf_thread_map__get;
 		perf_thread_map__put;
+		perf_evsel__new;
 		perf_evsel__init;
 		perf_evlist__new;
 		perf_evlist__init;
-- 
2.21.0

