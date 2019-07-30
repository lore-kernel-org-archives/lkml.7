Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00859C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C82102070B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564455715;
	bh=+LHqlzuhos4Vk9wMrb2/wn6QwDnWWhLFT0F275NhC/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a2iLFiuNjvfpgGTNWQjndxL88IfAtP7A6bSeWfUyUrZGH1twj7JqVLopLA+4Fjv5w
	 TlZVR4rruSru3LS1mg5V1rdg+SsOoeYu5kLAMw9q9F63HoBGiHEKn8WJ5l+aKw+/HJ
	 7OEYPN8o8xszJrn50HYi52oJ9wMMX130uQkTj0Nw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732706AbfG3DBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 23:01:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:51214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732635AbfG3DBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 23:01:51 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 635EC217D6;
        Tue, 30 Jul 2019 03:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455711;
        bh=+LHqlzuhos4Vk9wMrb2/wn6QwDnWWhLFT0F275NhC/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MkUK9GOlbt3nyFoKkwOFGj93P5TCM1oIe3ijgGLwheSTrLlb4pA81fW5RQ8waKH3r
         NIzRu+9gpCib7aiykKVh7r5tNwU4SRMboOr+iFlCb85TItCIQS8hlqq7s7S3wfcJRE
         7ev46kgNvlYCDSzF7BN2tiPT+G7/mlwmt6HwhuCw=
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
Subject: [PATCH 097/107] libperf: Add perf_evsel__attr() function
Date:   Mon, 29 Jul 2019 23:56:00 -0300
Message-Id: <20190730025610.22603-98-acme@kernel.org>
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

Add a perf_evsel__attr() function to get attr pointer from a perf_evsel
instance.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-71-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evsel.c              | 5 +++++
 tools/perf/lib/include/perf/evsel.h | 1 +
 tools/perf/lib/libperf.map          | 1 +
 3 files changed, 7 insertions(+)

diff --git a/tools/perf/lib/evsel.c b/tools/perf/lib/evsel.c
index 8dbe0e841b8f..24abc80dd767 100644
--- a/tools/perf/lib/evsel.c
+++ b/tools/perf/lib/evsel.c
@@ -225,3 +225,8 @@ struct perf_thread_map *perf_evsel__threads(struct perf_evsel *evsel)
 {
 	return evsel->threads;
 }
+
+struct perf_event_attr *perf_evsel__attr(struct perf_evsel *evsel)
+{
+	return &evsel->attr;
+}
diff --git a/tools/perf/lib/include/perf/evsel.h b/tools/perf/lib/include/perf/evsel.h
index ae9f7eeb53a2..4388667f265c 100644
--- a/tools/perf/lib/include/perf/evsel.h
+++ b/tools/perf/lib/include/perf/evsel.h
@@ -34,5 +34,6 @@ LIBPERF_API int perf_evsel__enable(struct perf_evsel *evsel);
 LIBPERF_API int perf_evsel__disable(struct perf_evsel *evsel);
 LIBPERF_API struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel);
 LIBPERF_API struct perf_thread_map *perf_evsel__threads(struct perf_evsel *evsel);
+LIBPERF_API struct perf_event_attr *perf_evsel__attr(struct perf_evsel *evsel);
 
 #endif /* __LIBPERF_EVSEL_H */
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index 2068e3d52227..e24d3cec01c1 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -23,6 +23,7 @@ LIBPERF_0.0.1 {
 		perf_evsel__read;
 		perf_evsel__cpus;
 		perf_evsel__threads;
+		perf_evsel__attr;
 		perf_evlist__new;
 		perf_evlist__delete;
 		perf_evlist__open;
-- 
2.21.0

