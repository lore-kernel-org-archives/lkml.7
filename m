Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34556C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01FCE233A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567000683;
	bh=SDpdYAwrw0hc3He3PD6oRzSkrR11e6DlFKKRUYCHaao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qaWtqoZRF/u9KiVT/dy3t4MGP0gbCTUeELphaGTVEqe/UsDtYj3aKZeAee1XmkFrS
	 yvKiOrQeMAChDULi/Z6bwlzvzj6JCqv+x7IK64Fhsai3Z9VotfVmBZiNQDpHLaNb8n
	 2UOemv8CzBQ17dst64laFOcNcEvjoGiSpIyBvbG4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfH1N6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 09:58:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59166 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727030AbfH1N56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:57:58 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E2989A5326D;
        Wed, 28 Aug 2019 13:57:57 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 48EAE1001B05;
        Wed, 28 Aug 2019 13:57:56 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 17/23] libperf: Add PERF_RECORD_STAT_ROUND 'struct stat_round_event' to perf/event.h
Date:   Wed, 28 Aug 2019 15:57:11 +0200
Message-Id: <20190828135717.7245-18-jolsa@kernel.org>
In-Reply-To: <20190828135717.7245-1-jolsa@kernel.org>
References: <20190828135717.7245-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Wed, 28 Aug 2019 13:57:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the PERF_RECORD_STAT_ROUND event definition to libperf's event.h.

In order to keep libperf simple, we switch 'u64/u32/u16/u8'
types used events to their generic '__u*' versions.

Link: http://lkml.kernel.org/n/tip-x7c2m4n8303nftb4maf333of@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/include/perf/event.h | 6 ++++++
 tools/perf/util/event.h             | 6 ------
 tools/perf/util/stat.c              | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index 7d1834f558d6..34d365bd2c5c 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -299,4 +299,10 @@ struct stat_event {
 	};
 };
 
+struct stat_round_event {
+	struct perf_event_header header;
+	__u64			 type;
+	__u64			 time;
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index f3a02e01852a..ec76412afba1 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -337,12 +337,6 @@ enum {
 	PERF_STAT_ROUND_TYPE__FINAL	= 1,
 };
 
-struct stat_round_event {
-	struct perf_event_header	header;
-	u64				type;
-	u64				time;
-};
-
 struct time_conv_event {
 	struct perf_event_header header;
 	u64 time_shift;
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index c0cd9f9bb0ea..4c7957496e7c 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -418,7 +418,7 @@ size_t perf_event__fprintf_stat_round(union perf_event *event, FILE *fp)
 	struct stat_round_event *rd = (struct stat_round_event *)event;
 	size_t ret;
 
-	ret = fprintf(fp, "\n... time %" PRIu64 ", type %s\n", rd->time,
+	ret = fprintf(fp, "\n... time %" PRI_lu64 ", type %s\n", rd->time,
 		      rd->type == PERF_STAT_ROUND_TYPE__FINAL ? "FINAL" : "INTERVAL");
 
 	return ret;
-- 
2.21.0

