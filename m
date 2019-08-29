Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF94C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF20022CED
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567089743;
	bh=8jHpZ2GLVYIHthlJoyTsw5yO9hkXBW4S8QAApZ7mBsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Qi46jQ/jnipHH8F4/iUAbrSS1TD+UYt3EW0/OLOlNwZlpXbhtapfCMhC4LGOnLO61
	 3mCWr9VM+3bUhQ8FqclLln0b59smYpawHI7aY8E7l4J9T9uF1OY2cjziVnOX2xHsK7
	 NNxSZracmP6b65QuBepJzSa4TOLUElaJtIrbqEpo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbfH2OkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 10:40:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:44120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728538AbfH2OkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:40:22 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B9E8233FF;
        Thu, 29 Aug 2019 14:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567089621;
        bh=8jHpZ2GLVYIHthlJoyTsw5yO9hkXBW4S8QAApZ7mBsU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IGYh8a+Kw5FX1ogpzLOFe/QD7M9ttTr0F+dTd9RbXUZcSOGoNovnbFbkU22u6/CXc
         Ez2lMmcHXaFrjOsFaHdgbAAU/HjXuAUprwveEbQ1aZNfw5VPJatSCLQrzvIPWbTuF3
         ARPEyjGJ1FTUqPvX1pj2UIJ9RtXEwj8MhwY4XcWE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 13/37] libperf: Add PERF_RECORD_CPU_MAP 'struct cpu_map_event' to perf/event.h
Date:   Thu, 29 Aug 2019 11:38:53 -0300
Message-Id: <20190829143917.29745-14-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190829143917.29745-1-acme@kernel.org>
References: <20190829143917.29745-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move the PERF_RECORD_CPU_MAP event definition to libperf's event.h.

In order to keep libperf simple, we switch 'u64/u32/u16/u8'
types used events to their generic '__u*' versions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190828135717.7245-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/perf/event.h | 26 ++++++++++++++++++++++++++
 tools/perf/util/event.h             | 26 --------------------------
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index bb66da57d366..469be778fdc1 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -115,4 +115,30 @@ struct attr_event {
 	__u64			 id[];
 };
 
+enum {
+	PERF_CPU_MAP__CPUS = 0,
+	PERF_CPU_MAP__MASK = 1,
+};
+
+struct cpu_map_entries {
+	__u16			 nr;
+	__u16			 cpu[];
+};
+
+struct cpu_map_mask {
+	__u16			 nr;
+	__u16			 long_size;
+	unsigned long		 mask[];
+};
+
+struct cpu_map_data {
+	__u16			 type;
+	char			 data[];
+};
+
+struct cpu_map_event {
+	struct perf_event_header header;
+	struct cpu_map_data	 data;
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 21fa6c2acea4..84bf67353635 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -337,32 +337,6 @@ struct events_stats {
 	u32 nr_proc_map_timeout;
 };
 
-enum {
-	PERF_CPU_MAP__CPUS = 0,
-	PERF_CPU_MAP__MASK = 1,
-};
-
-struct cpu_map_entries {
-	u16	nr;
-	u16	cpu[];
-};
-
-struct cpu_map_mask {
-	u16	nr;
-	u16	long_size;
-	unsigned long mask[];
-};
-
-struct cpu_map_data {
-	u16	type;
-	char	data[];
-};
-
-struct cpu_map_event {
-	struct perf_event_header	header;
-	struct cpu_map_data		data;
-};
-
 enum {
 	PERF_EVENT_UPDATE__UNIT  = 0,
 	PERF_EVENT_UPDATE__SCALE = 1,
-- 
2.21.0

