Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4E5C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E84DA22DA7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567000687;
	bh=GZsNct0w4RlylFK+XzNx4uuZSjywvG24cXGdduPPy+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LfP9ygRxWqOVPe5fevnmXkut+fexawR9N693bwX0g/GfOB9pyfF4HKpJYTsxgx7Oh
	 xT8z4wQM/gfR64b5CZir3DaSSz+HOk8w19JakW9IJWj7IvubgjTtklYbn+qkN62lPR
	 8CQbWjDwLmX3obXAXZWIMjlnpamYLGcBbH/rO5ko=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfH1N6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 09:58:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59022 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726658AbfH1N6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:58:02 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CE0892A973;
        Wed, 28 Aug 2019 13:58:01 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2FC0A1001B05;
        Wed, 28 Aug 2019 13:58:00 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 19/23] libperf: Add PERF_RECORD_HEADER_FEATURE 'struct feature_event' to perf/event.h
Date:   Wed, 28 Aug 2019 15:57:13 +0200
Message-Id: <20190828135717.7245-20-jolsa@kernel.org>
In-Reply-To: <20190828135717.7245-1-jolsa@kernel.org>
References: <20190828135717.7245-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.71]); Wed, 28 Aug 2019 13:58:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the PERF_RECORD_HEADER_FEATURE event definition to libperf's event.h.

In order to keep libperf simple, we switch 'u64/u32/u16/u8'
types used events to their generic '__u*' versions.

Link: http://lkml.kernel.org/n/tip-adohmimljqrbq2i3dxhhrpnp@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-report.c         | 2 +-
 tools/perf/lib/include/perf/event.h | 6 ++++++
 tools/perf/util/event.h             | 6 ------
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 318b0b95c14c..0d71f26a8a44 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -211,7 +211,7 @@ static int process_feature_event(struct perf_session *session,
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

