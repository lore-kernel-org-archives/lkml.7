Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D10EC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D38AB2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567000729;
	bh=/0b2b4YCI4UJzXlSoBcJ7j0WgiXyzrYZo124yYs1TDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m2BI3GuXKQdssgZj1Vt7B6NYNYNJuPFL5Vgg76oFBE5hTz9GjDYK4hwTCvIh0U7zk
	 f5GNZQLJBIkzwkP8NfZ5gAiTm+XoEBpm3mFy1a79Liv9wrn+cxMFi0ZtYBeYp9aIWc
	 A1K+GW5t3aH8AXv+e8Mmq1QzVKuPYkV5HjiQ7rIc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfH1N6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 09:58:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56026 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726983AbfH1N5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:57:50 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AAE19307D962;
        Wed, 28 Aug 2019 13:57:50 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0E1541001B00;
        Wed, 28 Aug 2019 13:57:48 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 14/23] libperf: Add PERF_RECORD_THREAD_MAP 'struct thread_map_event' to perf/event.h
Date:   Wed, 28 Aug 2019 15:57:08 +0200
Message-Id: <20190828135717.7245-15-jolsa@kernel.org>
In-Reply-To: <20190828135717.7245-1-jolsa@kernel.org>
References: <20190828135717.7245-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 28 Aug 2019 13:57:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the PERF_RECORD_THREAD_MAP event definition to libperf's event.h.

In order to keep libperf simple, we switch 'u64/u32/u16/u8'
types used events to their generic '__u*' versions.

Link: http://lkml.kernel.org/n/tip-7gqcq30lozmcm0rsbs8kq67k@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/include/perf/event.h | 11 +++++++++++
 tools/perf/util/event.h             | 11 -----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index a7b0344bb8b4..fe0ce655af17 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -253,4 +253,15 @@ struct itrace_start_event {
 	__u32			 tid;
 };
 
+struct thread_map_event_entry {
+	__u64			 pid;
+	char			 comm[16];
+};
+
+struct thread_map_event {
+	struct perf_event_header	 header;
+	__u64				 nr;
+	struct thread_map_event_entry	 entries[];
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 012b2ba9a9a8..3a856696c6b1 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -332,17 +332,6 @@ struct events_stats {
 	u32 nr_proc_map_timeout;
 };
 
-struct thread_map_event_entry {
-	u64	pid;
-	char	comm[16];
-};
-
-struct thread_map_event {
-	struct perf_event_header	header;
-	u64				nr;
-	struct thread_map_event_entry	entries[];
-};
-
 enum {
 	PERF_STAT_CONFIG_TERM__AGGR_MODE	= 0,
 	PERF_STAT_CONFIG_TERM__INTERVAL		= 1,
-- 
2.21.0

