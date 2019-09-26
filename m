Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AED0C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F897222C5
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569458140;
	bh=ZmfIjuMycGDhug4m/W1xCX+R34vQlcGRbH8/c9dgo40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1mvQ5YYF0Axj7G47q3xPIuunLF/PKqBcYYec10C6Y+ceaY/9xLZCDYtXB8fKGhaqS
	 PkeNwkJ1WoayKhkNqcjcfxfxJIihG4XjPJZ7cQRwTseQqJYuAnuv9xQOWFxp6b3lMa
	 JkenZ6UG1ergeM0jNPxjLsiCoKLsE/yobw4dKy30=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389691AbfIZAfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 20:35:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:38384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389786AbfIZAff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 20:35:35 -0400
Received: from quaco.localdomain (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9344222C1;
        Thu, 26 Sep 2019 00:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569458134;
        bh=ZmfIjuMycGDhug4m/W1xCX+R34vQlcGRbH8/c9dgo40=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ODxMSFW52IG7sZG5botNII2zcprk9q6hKKqDEp41Ad6iJ/c7ZJ0P/r1aA7kG6fpsu
         BHOWbZuyZw3QHiXAT7CFErkU6omj6NDGHGW0eOKP7fPXXsEeL8FTZJ7oU1VxilNgf2
         WwV9j3v8XbsBronIm/0kUxD20ebLw4mUfyjYXt+8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 43/66] libperf: Add perf_evlist__read_format() function
Date:   Wed, 25 Sep 2019 21:32:21 -0300
Message-Id: <20190926003244.13962-44-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add the perf_evlist__read_format() function to libperf as internal
function.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lore.kernel.org/lkml/20190913132355.21634-30-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evlist.c                  | 7 +++++++
 tools/perf/lib/include/internal/evlist.h | 2 ++
 tools/perf/util/evlist.c                 | 8 +-------
 tools/perf/util/evlist.h                 | 1 -
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index 2bdd9d2c79d9..ae861bf38976 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -161,3 +161,10 @@ void perf_evlist__disable(struct perf_evlist *evlist)
 	perf_evlist__for_each_entry(evlist, evsel)
 		perf_evsel__disable(evsel);
 }
+
+u64 perf_evlist__read_format(struct perf_evlist *evlist)
+{
+	struct perf_evsel *first = perf_evlist__first(evlist);
+
+	return first->attr.read_format;
+}
diff --git a/tools/perf/lib/include/internal/evlist.h b/tools/perf/lib/include/internal/evlist.h
index 16ae6d6cfb39..63516fe14f4c 100644
--- a/tools/perf/lib/include/internal/evlist.h
+++ b/tools/perf/lib/include/internal/evlist.h
@@ -66,4 +66,6 @@ static inline struct perf_evsel *perf_evlist__last(struct perf_evlist *evlist)
 	return list_entry(evlist->entries.prev, struct perf_evsel, node);
 }
 
+u64 perf_evlist__read_format(struct perf_evlist *evlist);
+
 #endif /* __LIBPERF_INTERNAL_EVLIST_H */
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index e8f0357b1532..bc788192493f 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -503,7 +503,7 @@ int perf_evlist__id_add_fd(struct evlist *evlist,
 	 * This way does not work with group format read, so bail
 	 * out in that case.
 	 */
-	if (perf_evlist__read_format(evlist) & PERF_FORMAT_GROUP)
+	if (perf_evlist__read_format(&evlist->core) & PERF_FORMAT_GROUP)
 		return -1;
 
 	if (!(evsel->core.attr.read_format & PERF_FORMAT_ID) ||
@@ -1240,12 +1240,6 @@ bool perf_evlist__valid_read_format(struct evlist *evlist)
 	return true;
 }
 
-u64 perf_evlist__read_format(struct evlist *evlist)
-{
-	struct evsel *first = evlist__first(evlist);
-	return first->core.attr.read_format;
-}
-
 u16 perf_evlist__id_hdr_size(struct evlist *evlist)
 {
 	struct evsel *first = evlist__first(evlist);
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 6529ad2a9d97..3f89d9913a30 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -217,7 +217,6 @@ int perf_evlist__apply_filters(struct evlist *evlist, struct evsel **err_evsel);
 void __perf_evlist__set_leader(struct list_head *list);
 void perf_evlist__set_leader(struct evlist *evlist);
 
-u64 perf_evlist__read_format(struct evlist *evlist);
 u64 __perf_evlist__combined_sample_type(struct evlist *evlist);
 u64 perf_evlist__combined_sample_type(struct evlist *evlist);
 u64 perf_evlist__combined_branch_type(struct evlist *evlist);
-- 
2.21.0

