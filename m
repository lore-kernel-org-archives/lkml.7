Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C4CC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68D35217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564455655;
	bh=FwWs/GtZup6DxOF2lPS0CEk0zVSxmeYWNcs8OZLdaYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wXFcmo//gtehU0T5UlCy0xwW+9YzNUJmuRe6JrGIt2xiChKIiWqChIN50UcubK3wB
	 cJ5pVgG1BqxunvLiLMqNfl3+J5S2EnFAnZ7kgqfo4WjW5crF2GTDznNmlUbMYL1Zjw
	 DxMifRGoPcdZB4zdEGtR1qwGEPh7ghYnmi4zpWM0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732490AbfG3DAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 23:00:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:50168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732462AbfG3DAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 23:00:52 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9843B2171F;
        Tue, 30 Jul 2019 03:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455650;
        bh=FwWs/GtZup6DxOF2lPS0CEk0zVSxmeYWNcs8OZLdaYA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d4ZTGbvDfvFx2kOOZ2YEw9cAP2Q9tpbPseox7yPezIH8DhfT4zH+941vNhlRKmuEy
         tVWGVXygzI0Ml2kYRvlh3X+Dcef5wy76ZXSTk9dqj7aHETtBfaS3DgGQaBYVbskHBa
         3kpR/zGxZ0vSTW9u1sTFPHcJir2IskntwOLXgzBU=
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
Subject: [PATCH 080/107] libperf: Add has_user_cpus to struct perf_evlist
Date:   Mon, 29 Jul 2019 23:55:43 -0300
Message-Id: <20190730025610.22603-81-acme@kernel.org>
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

Move has_user_cpus from tools/perf's evlist to libbperf's perf_evlist struct.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-54-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/internal/evlist.h | 1 +
 tools/perf/util/evlist.c                 | 4 ++--
 tools/perf/util/evlist.h                 | 1 -
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/lib/include/internal/evlist.h b/tools/perf/lib/include/internal/evlist.h
index a12c712a9197..9964e4a9456e 100644
--- a/tools/perf/lib/include/internal/evlist.h
+++ b/tools/perf/lib/include/internal/evlist.h
@@ -5,6 +5,7 @@
 struct perf_evlist {
 	struct list_head	entries;
 	int			nr_entries;
+	bool			has_user_cpus;
 };
 
 #endif /* __LIBPERF_INTERNAL_EVLIST_H */
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 5ce8fc730453..23a8ead4512f 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -159,7 +159,7 @@ static void __perf_evlist__propagate_maps(struct evlist *evlist,
 	 * We already have cpus for evsel (via PMU sysfs) so
 	 * keep it, if there's no target cpu list defined.
 	 */
-	if (!evsel->core.own_cpus || evlist->has_user_cpus) {
+	if (!evsel->core.own_cpus || evlist->core.has_user_cpus) {
 		perf_cpu_map__put(evsel->core.cpus);
 		evsel->core.cpus = perf_cpu_map__get(evlist->cpus);
 	} else if (evsel->core.cpus != evsel->core.own_cpus) {
@@ -1095,7 +1095,7 @@ int perf_evlist__create_maps(struct evlist *evlist, struct target *target)
 	if (!cpus)
 		goto out_delete_threads;
 
-	evlist->has_user_cpus = !!target->cpu_list;
+	evlist->core.has_user_cpus = !!target->cpu_list;
 
 	perf_evlist__set_maps(evlist, cpus, threads);
 
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 17dd83021a79..35cca0242631 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -31,7 +31,6 @@ struct evlist {
 	int		 nr_groups;
 	int		 nr_mmaps;
 	bool		 enabled;
-	bool		 has_user_cpus;
 	size_t		 mmap_len;
 	int		 id_pos;
 	int		 is_pos;
-- 
2.21.0

