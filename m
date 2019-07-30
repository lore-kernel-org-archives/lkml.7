Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27899C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2759216C8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564455641;
	bh=lTNvaO0CotrZLKshR9mp9rx7k2kR1edto+egP3ezFjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ortXnShZOvzt4/dK2mQlblPEKXlx/lontT34R/Lww196pGqEZ0wdyh7d6cTUAGK+J
	 bx0vW6N0lHwOCNP7iJnAgNoqtm/hcTXUVn0+RchcdKBQnLr/NSO1wgi8loA9jRwD+4
	 WUPhB1y7tdAR0T8p+5RsHF5oc5I9Zx+7uoR6DTgY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732439AbfG3DAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 23:00:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:49926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732425AbfG3DAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 23:00:37 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 725C72171F;
        Tue, 30 Jul 2019 03:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455636;
        bh=lTNvaO0CotrZLKshR9mp9rx7k2kR1edto+egP3ezFjo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EUXUnBhMMBpuM5TwzvvIKHjFLZV7uHcf1YqmyrlJvwtcitGc2ILxAOXcbyUMxHrpk
         kPsf5TZdetEN2AK5twU7I1z9tRz9d+KpUA5+w4rZJIllqKsqA5N24Txi8mtXhN7Nkz
         ZhmalBxv857xZ0KzNqja9bA/67qO7BDx5a5wlKuA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 076/107] libperf: Add perf_evsel__delete() function
Date:   Mon, 29 Jul 2019 23:55:39 -0300
Message-Id: <20190730025610.22603-77-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190730025610.22603-1-acme@kernel.org>
References: <20190730025610.22603-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add the perf_evsel__delete() function to delete a perf_evsel instance.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-50-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evsel.c              | 6 ++++++
 tools/perf/lib/include/perf/evsel.h | 1 +
 tools/perf/lib/libperf.map          | 1 +
 3 files changed, 8 insertions(+)

diff --git a/tools/perf/lib/evsel.c b/tools/perf/lib/evsel.c
index 8e91738c5c38..ddc3ad447bfb 100644
--- a/tools/perf/lib/evsel.c
+++ b/tools/perf/lib/evsel.c
@@ -3,6 +3,7 @@
 #include <linux/list.h>
 #include <internal/evsel.h>
 #include <linux/zalloc.h>
+#include <stdlib.h>
 
 void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr)
 {
@@ -19,3 +20,8 @@ struct perf_evsel *perf_evsel__new(struct perf_event_attr *attr)
 
 	return evsel;
 }
+
+void perf_evsel__delete(struct perf_evsel *evsel)
+{
+	free(evsel);
+}
diff --git a/tools/perf/lib/include/perf/evsel.h b/tools/perf/lib/include/perf/evsel.h
index 21b66fc1937f..a57efc0f5c8b 100644
--- a/tools/perf/lib/include/perf/evsel.h
+++ b/tools/perf/lib/include/perf/evsel.h
@@ -10,5 +10,6 @@ struct perf_event_attr;
 LIBPERF_API void perf_evsel__init(struct perf_evsel *evsel,
 				  struct perf_event_attr *attr);
 LIBPERF_API struct perf_evsel *perf_evsel__new(struct perf_event_attr *attr);
+LIBPERF_API void perf_evsel__delete(struct perf_evsel *evsel);
 
 #endif /* __LIBPERF_EVSEL_H */
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index 153e77cd6739..28ed04cbd223 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -12,6 +12,7 @@ LIBPERF_0.0.1 {
 		perf_thread_map__get;
 		perf_thread_map__put;
 		perf_evsel__new;
+		perf_evsel__delete;
 		perf_evsel__init;
 		perf_evlist__new;
 		perf_evlist__delete;
-- 
2.21.0

