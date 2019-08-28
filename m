Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F92C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CC9A2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567000725;
	bh=p5x+2OOPMmD2aBCmfdY2PCUr5vPxZAiwX2GpN4lXIVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MVqSW2gTpGl+9bjwo3XHZ57W91r/5CPipM5MibMuCMXA9zOQBghBYpsrhNu6ub2VZ
	 x7nOjtcLlLigm5Lk0yvFParbvUSKoD0WDgRAZcZhDTau0mP2aBIDjU+6lRbh1VzODv
	 dd5uIN9pc/Kz0Uta73kl5YHHAi7teH6D+EqQ/020=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbfH1N6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 09:58:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46116 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726999AbfH1N5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:57:52 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9A10FC056808;
        Wed, 28 Aug 2019 13:57:52 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 002C81001B00;
        Wed, 28 Aug 2019 13:57:50 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 15/23] libperf: Add PERF_RECORD_STAT_CONFIG 'struct stat_config_event' to perf/event.h
Date:   Wed, 28 Aug 2019 15:57:09 +0200
Message-Id: <20190828135717.7245-16-jolsa@kernel.org>
In-Reply-To: <20190828135717.7245-1-jolsa@kernel.org>
References: <20190828135717.7245-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 28 Aug 2019 13:57:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the PERF_RECORD_STAT_CONFIG event definition to libperf's event.h.

In order to keep libperf simple, we switch 'u64/u32/u16/u8'
types used events to their generic '__u*' versions.

Link: http://lkml.kernel.org/n/tip-ftr4j2l1by743i4rk9msjbmi@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
index 85f9f27782b1..2369333d61d8 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1234,7 +1234,7 @@ void perf_event__read_stat_config(struct perf_stat_config *config,
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

