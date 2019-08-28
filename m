Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D6B2C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B2E92064A
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567000740;
	bh=v7k44HgF4ZF8jcgu/ioPtz4zkqOhNRSkI0KLt7yKC90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dUk5Pp+Xfgf8ecVtqGH6el3J6bsscmsQVi6LC9zD7fvyLENVRNkYQ+xVE9SGGOPSL
	 6Oq6R6xXIkHfjNONslxZ8G72sncwYTkFvPOmCjYF6M6pa38UsjNOzOOQwiyCkkVeYz
	 bXITowSg8wp6tVVKqP69twDMGet3TmCb+Rc5duhM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfH1N66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 09:58:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58738 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726702AbfH1N5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:57:30 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2914D7F745;
        Wed, 28 Aug 2019 13:57:30 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8371C1001B08;
        Wed, 28 Aug 2019 13:57:28 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 05/23] libperf: Add PERF_RECORD_HEADER_TRACING_DATA 'struct tracing_data_event' to perf/event.h
Date:   Wed, 28 Aug 2019 15:56:59 +0200
Message-Id: <20190828135717.7245-6-jolsa@kernel.org>
In-Reply-To: <20190828135717.7245-1-jolsa@kernel.org>
References: <20190828135717.7245-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.71]); Wed, 28 Aug 2019 13:57:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the PERF_RECORD_HEADER_TRACING_DATA event definition to libperf's event.h.

In order to keep libperf simple, we switch 'u64/u32/u16/u8'
types used events to their generic '__u*' versions.

Link: http://lkml.kernel.org/n/tip-a3vv3556pgb0k7gmp1hybqwy@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/include/perf/event.h | 5 +++++
 tools/perf/util/event.h             | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index ecd1536a3a0c..fa81fea8dc02 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -175,4 +175,9 @@ struct event_type_event {
 	struct perf_trace_event_type	 event_type;
 };
 
+struct tracing_data_event {
+	struct perf_event_header header;
+	__u32			 size;
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 00725a1b602b..67f6a67ad3b4 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -337,11 +337,6 @@ struct events_stats {
 	u32 nr_proc_map_timeout;
 };
 
-struct tracing_data_event {
-	struct perf_event_header header;
-	u32 size;
-};
-
 struct id_index_entry {
 	u64 id;
 	u64 idx;
-- 
2.21.0

