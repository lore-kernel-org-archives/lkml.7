Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403B2C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 135652189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567000650;
	bh=KFr+6JjeOcJ0L/CpXa9gJAevWnS+2UMKOC512D4IFJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pz+HPobZqkgdgVMkttoYlpUV9bm3q19huvfskkklAPrDSoEFQ/Sf08p8umUq9N0VE
	 B+/F9blH8HJHilYVC/JRVfbxylPmZSZMWio6VlnOeXgOI9oMsGhMmW/zR5DAphroMi
	 wZSbzf2s2RdZQnAUbLFtTSSm4tM5Rlj8rlHnn5no=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfH1N53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 09:57:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:2365 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbfH1N5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:57:24 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4384F18C8900;
        Wed, 28 Aug 2019 13:57:24 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9E6641001B00;
        Wed, 28 Aug 2019 13:57:22 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 02/23] libperf: Add PERF_RECORD_CPU_MAP 'struct cpu_map_event' to perf/event.h
Date:   Wed, 28 Aug 2019 15:56:56 +0200
Message-Id: <20190828135717.7245-3-jolsa@kernel.org>
In-Reply-To: <20190828135717.7245-1-jolsa@kernel.org>
References: <20190828135717.7245-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.70]); Wed, 28 Aug 2019 13:57:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the PERF_RECORD_CPU_MAP event definition to libperf's event.h.

In order to keep libperf simple, we switch 'u64/u32/u16/u8'
types used events to their generic '__u*' versions.

Link: http://lkml.kernel.org/n/tip-mvxietu3tdtqfi7e2nbqkwy2@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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

