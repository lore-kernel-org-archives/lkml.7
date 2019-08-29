Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A787C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF2F0233FF
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567089676;
	bh=kRp9iALN0aK/Tliy3iTmovECT04hboBdFR7/W3UXpUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nicalSL9kKm6cnaqKZhwVpRdk7xNAuXLBHiQDfamNlqGUm2I+AbPyjWMlmspOjTtF
	 WYpZWTkamay7U9KfWbFThRhmYZNF/muGrcoU+AyKPmQiUST0MiK+y2kJqiuqBNHVxf
	 vSCHjdFQKvvl3hGNrJzleDNLjzP7xA1CDvIOkvUw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbfH2OlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 10:41:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:45122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728839AbfH2OlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:41:12 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9057423428;
        Thu, 29 Aug 2019 14:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567089672;
        bh=kRp9iALN0aK/Tliy3iTmovECT04hboBdFR7/W3UXpUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h/ILqbfTA1CEE1UyOdm2fEF7B1Quo/ZOpOKU57QjbFqR+szHNBU6uh02X5EWkM6Eo
         A/XRYloWOSdXoFQZwh99jOiCKeDTVx1/GxwShuPVMO2Hf1lcaDcfL0Mog4DvMqB35b
         +eocOAIs5/wFy66yq2V87Xe10jTr3OH3oviIzTsY=
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
Subject: [PATCH 30/37] libperf: Add PERF_RECORD_HEADER_FEATURE 'struct feature_event' to perf/event.h
Date:   Thu, 29 Aug 2019 11:39:10 -0300
Message-Id: <20190829143917.29745-31-acme@kernel.org>
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

Move the PERF_RECORD_HEADER_FEATURE event definition to libperf's
event.h.

In order to keep libperf simple, we switch 'u64/u32/u16/u8' types used
events to their generic '__u*' versions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190828135717.7245-20-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-report.c         | 2 +-
 tools/perf/lib/include/perf/event.h | 6 ++++++
 tools/perf/util/event.h             | 6 ------
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 0338916af4bf..33c20e26b290 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -212,7 +212,7 @@ static int process_feature_event(struct perf_session *session,
 		return perf_event__process_feature(session, event);
 
 	if (event->feat.feat_id != HEADER_LAST_FEATURE) {
-		pr_err("failed: wrong feature ID: %" PRIu64 "\n",
+		pr_err("failed: wrong feature ID: %" PRI_lu64 "\n",
 		       event->feat.feat_id);
 		return -1;
 	}
diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index 7600f53f6ad1..ed1c22e650e2 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -312,4 +312,10 @@ struct time_conv_event {
 	__u64			 time_zero;
 };
 
+struct feature_event {
+	struct perf_event_header header;
+	__u64			 feat_id;
+	char			 data[];
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index d758485956b3..94777ee435c2 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -337,12 +337,6 @@ enum {
 	PERF_STAT_ROUND_TYPE__FINAL	= 1,
 };
 
-struct feature_event {
-	struct perf_event_header 	header;
-	u64				feat_id;
-	char				data[];
-};
-
 struct compressed_event {
 	struct perf_event_header	header;
 	char				data[];
-- 
2.21.0

