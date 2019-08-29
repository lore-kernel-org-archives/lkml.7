Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5C6C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15E6B23427
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567089673;
	bh=CqKO13EsSau/q2yj1AltwQkkllP4v8MY/KGubfP1GpU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P1SwTw6p6dmDkGgfziv95QyEKAGq/JGrJZPAKyhu+gOyyG3LZTMvy0ASHKG9IZ1oS
	 g0m4jYqd81L2L2GFdX8ATEiQgprmfRbvy+2E4lxVjjOZ9DliZZL4fb6JX64EUsKi10
	 whcPEI19W2T9FnfzvuWDV7+WLZZoFCBLgU/0kg/I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbfH2OlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 10:41:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:45064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728017AbfH2OlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:41:09 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A209D233FF;
        Thu, 29 Aug 2019 14:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567089669;
        bh=CqKO13EsSau/q2yj1AltwQkkllP4v8MY/KGubfP1GpU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ulA/I13dDEzsY3cq758l7JBx+EP7mmpvL9+nj/N4/3O4mf8iytrQg8hKkkMiCMmGY
         eD8citEe+42pw5aXuBUSmELxYNZ7FYrORixAQF6crTU/DK4ybcJ+CFfCaad3YJmKzZ
         g0Yb6EEI2MPpq1xko4yjZQOJKDNmhQa/519IBlL0=
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
Subject: [PATCH 29/37] libperf: Add PERF_RECORD_TIME_CONV 'struct time_conv_event' to perf/event.h
Date:   Thu, 29 Aug 2019 11:39:09 -0300
Message-Id: <20190829143917.29745-30-acme@kernel.org>
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

Move the PERF_RECORD_TIME_CONV event definition to libperf's event.h.

In order to keep libperf simple, we switch 'u64/u32/u16/u8' types used
events to their generic '__u*' versions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190828135717.7245-19-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/perf/event.h | 7 +++++++
 tools/perf/util/event.h             | 7 -------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index 34d365bd2c5c..7600f53f6ad1 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -305,4 +305,11 @@ struct stat_round_event {
 	__u64			 time;
 };
 
+struct time_conv_event {
+	struct perf_event_header header;
+	__u64			 time_shift;
+	__u64			 time_mult;
+	__u64			 time_zero;
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index ec76412afba1..d758485956b3 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -337,13 +337,6 @@ enum {
 	PERF_STAT_ROUND_TYPE__FINAL	= 1,
 };
 
-struct time_conv_event {
-	struct perf_event_header header;
-	u64 time_shift;
-	u64 time_mult;
-	u64 time_zero;
-};
-
 struct feature_event {
 	struct perf_event_header 	header;
 	u64				feat_id;
-- 
2.21.0

