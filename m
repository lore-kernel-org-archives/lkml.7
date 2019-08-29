Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9690AC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B5FD22CED
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567089634;
	bh=eILrO6YEy58DrNTFHc4LuEW986Wg0QHvpkUSmCJR89E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=csIEix5i9/DOSiSke42wLcRCJv5d2FhPz9FwiFvLd9LXT58lZSpCZ4gYMyZx6dVPg
	 FKUKw3ajT2HnvyN+Rb87uVwkieAP21NyCu4OiaDSqiE0mwnVxpoMolwJDoaw7NIK62
	 JMons/sTDKTVfSQWev2kIwoOOwH6F4u6/N1J8Bt4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbfH2Okd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 10:40:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:44308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728555AbfH2Okb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:40:31 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D019823403;
        Thu, 29 Aug 2019 14:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567089630;
        bh=eILrO6YEy58DrNTFHc4LuEW986Wg0QHvpkUSmCJR89E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tsHMWh5VFrpY1tk5byj3R9DVQ/L2fDxunO5reLpWWdqmNnWvOmYwLYEMPUaI+QRWw
         gh4x+xzJGpvvD+pKvw63cSHDYTP+NRHldNZ5DKJh8aJNdOdOML51fxGbNtWvbhjlZH
         +Y6FyQ9h/EZqqGuEzBjH1MoyqPkJOsmxKdMJJta8=
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
Subject: [PATCH 16/37] libperf: Add PERF_RECORD_HEADER_TRACING_DATA 'struct tracing_data_event' to perf/event.h
Date:   Thu, 29 Aug 2019 11:38:56 -0300
Message-Id: <20190829143917.29745-17-acme@kernel.org>
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

Move the PERF_RECORD_HEADER_TRACING_DATA event definition to libperf's event.h.

In order to keep libperf simple, we switch 'u64/u32/u16/u8'
types used events to their generic '__u*' versions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190828135717.7245-6-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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

