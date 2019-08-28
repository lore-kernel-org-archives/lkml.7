Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B552C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2A082339E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567000720;
	bh=+gjGUoIe8moF+trN7VvHczuZcTTcFaQt8w8Chba1/YE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oaLpnPeL7XZL7+DoGDP7w//6JX5D+cw3mr1PPt0cOntlQR422BFSp6Q2JdwFpn6sR
	 Vpk/0TJS4sX0GJWe4iUcQih/zjswW5G12E7hLAgkKt/Mqg0len0QVPGJx22TMPRFAM
	 asMPP/WQnxU4Z8u+BPe6uyzSAOZbyXFzjUJnXsxM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfH1N6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 09:58:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58420 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727055AbfH1N6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:58:00 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D40A1103EF49;
        Wed, 28 Aug 2019 13:57:59 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 38E741001B05;
        Wed, 28 Aug 2019 13:57:58 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 18/23] libperf: Add PERF_RECORD_TIME_CONV 'struct time_conv_event' to perf/event.h
Date:   Wed, 28 Aug 2019 15:57:12 +0200
Message-Id: <20190828135717.7245-19-jolsa@kernel.org>
In-Reply-To: <20190828135717.7245-1-jolsa@kernel.org>
References: <20190828135717.7245-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.64]); Wed, 28 Aug 2019 13:57:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the PERF_RECORD_TIME_CONV event definition to libperf's event.h.

In order to keep libperf simple, we switch 'u64/u32/u16/u8'
types used events to their generic '__u*' versions.

Link: http://lkml.kernel.org/n/tip-dize9k67s0341vek7hs8vhty@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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

