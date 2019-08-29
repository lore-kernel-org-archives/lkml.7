Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F49C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4199022CED
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567089665;
	bh=Ok/XdzLpKk3BaZ9GofottpjxDIyBEeFj0cGFmRweiJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l8I7ZeYj6YctiLfqLZ9D3aevy2W61RxPIXicIwlCkV2Zz5A81yZwLg8D6A0QM9h/g
	 vTdFKnqPBO7c0tLr3LtdGtE2KhX8sTVXYB0xIvZJWx6M9u0lUG/GFr40GhcvQEHBpW
	 3t6KDGE+5oSYjgGtNCXXRa/RXfDovASeEhFtKO2E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbfH2OlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 10:41:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:44864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728797AbfH2OlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:41:01 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F1E523428;
        Thu, 29 Aug 2019 14:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567089659;
        bh=Ok/XdzLpKk3BaZ9GofottpjxDIyBEeFj0cGFmRweiJ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uoSfEF4D7JmOsZZrea67pWqSuulIG4kAAP3B0K3nveuJ/0OMrnuyUl3btw9F7VCgf
         quR+9jznkuvEH/LQlw11j91TLiqQI4dYb1ZNu7V7MrwMpWyLa4irWm8pYccrEhmgaR
         78LAEku9CZ3X7BIv7gzIufKtV+/nyHiT2WGi33No=
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
Subject: [PATCH 26/37] libperf: Add PERF_RECORD_STAT_CONFIG 'struct stat_config_event' to perf/event.h
Date:   Thu, 29 Aug 2019 11:39:06 -0300
Message-Id: <20190829143917.29745-27-acme@kernel.org>
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

Move the PERF_RECORD_STAT_CONFIG event definition to libperf's event.h.

In order to keep libperf simple, we switch 'u64/u32/u16/u8' types used
events to their generic '__u*' versions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190828135717.7245-16-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/perf/event.h | 18 ++++++++++++++++++
 tools/perf/util/event.c             |  2 +-
 tools/perf/util/event.h             | 18 ------------------
 3 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index fe0ce655af17..ba6ed243a31f 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -264,4 +264,22 @@ struct thread_map_event {
 	struct thread_map_event_entry	 entries[];
 };
 
+enum {
+	PERF_STAT_CONFIG_TERM__AGGR_MODE	= 0,
+	PERF_STAT_CONFIG_TERM__INTERVAL		= 1,
+	PERF_STAT_CONFIG_TERM__SCALE		= 2,
+	PERF_STAT_CONFIG_TERM__MAX		= 3,
+};
+
+struct stat_config_event_entry {
+	__u64			 tag;
+	__u64			 val;
+};
+
+struct stat_config_event {
+	struct perf_event_header	 header;
+	__u64				 nr;
+	struct stat_config_event_entry	 data[];
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index b048e6084612..b711019a9ed2 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1235,7 +1235,7 @@ void perf_event__read_stat_config(struct perf_stat_config *config,
 		CASE(INTERVAL,  interval)
 #undef CASE
 		default:
-			pr_warning("unknown stat config term %" PRIu64 "\n",
+			pr_warning("unknown stat config term %" PRI_lu64 "\n",
 				   event->data[i].tag);
 		}
 	}
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 3a856696c6b1..68531d08dcec 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -332,24 +332,6 @@ struct events_stats {
 	u32 nr_proc_map_timeout;
 };
 
-enum {
-	PERF_STAT_CONFIG_TERM__AGGR_MODE	= 0,
-	PERF_STAT_CONFIG_TERM__INTERVAL		= 1,
-	PERF_STAT_CONFIG_TERM__SCALE		= 2,
-	PERF_STAT_CONFIG_TERM__MAX		= 3,
-};
-
-struct stat_config_event_entry {
-	u64	tag;
-	u64	val;
-};
-
-struct stat_config_event {
-	struct perf_event_header	header;
-	u64				nr;
-	struct stat_config_event_entry	data[];
-};
-
 struct stat_event {
 	struct perf_event_header	header;
 
-- 
2.21.0

