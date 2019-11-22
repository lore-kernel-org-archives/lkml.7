Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C4CC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 14:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EA632075B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 14:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574434651;
	bh=PzJa/gkaNHY7pCJpNm6vlkTQduV/9e0pSFtZ+yqe9i4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Mo19TV9Guy8HWby1YSKAoIjeAAseb47NN4UQhB3ELDlWLp30vtfkn+gj4QLrWqvcC
	 AJzlRQz+MMixWzRd+6AAM3Lwj9oT01S6W+GGrk9rtw+dsiv1yEvjYUqVihf6yS5qee
	 xL158MflggurG63zkOuk16iZ8CaS7X6ERGCosYGo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfKVO5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 09:57:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:58242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbfKVO52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 09:57:28 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FEC220721;
        Fri, 22 Nov 2019 14:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574434647;
        bh=PzJa/gkaNHY7pCJpNm6vlkTQduV/9e0pSFtZ+yqe9i4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EVyzqpYkAwJk99BWXQiIbD9mtSoBj/imVsn4zMqNCxD2zuiWIY9P9qlQKPXl5FmR9
         KZsz+KzVfE5MoUO2fWdDowKyo1dUF30gIiD88h8qKuzeohEpNEakxlnMGF2cs3RJIZ
         4M9Sqvy7vRURFDSCR0wo5b8WiFykUmKglcoNvIUU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 03/26] perf map: Move comparision of map's dso_id to a separate function
Date:   Fri, 22 Nov 2019 11:56:48 -0300
Message-Id: <20191122145711.3171-4-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191122145711.3171-1-acme@kernel.org>
References: <20191122145711.3171-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We'll use it when doing DSO lookups using dso_ids.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-u2nr1oq03o0i29w2ay9jx03s@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dsos.c | 25 +++++++++++++++++++++++++
 tools/perf/util/map.h  |  2 ++
 tools/perf/util/sort.c | 16 ++++------------
 3 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index 3ea80d203587..ecf8d7346685 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -2,6 +2,7 @@
 #include "debug.h"
 #include "dsos.h"
 #include "dso.h"
+#include "map.h"
 #include "vdso.h"
 #include "namespaces.h"
 #include <libgen.h>
@@ -9,6 +10,30 @@
 #include <string.h>
 #include <symbol.h> // filename__read_build_id
 
+int dso_id__cmp(struct dso_id *a, struct dso_id *b)
+{
+	/*
+	 * The second is always dso->id, so zeroes if not set, assume passing
+	 * NULL for a means a zeroed id
+	 */
+	if (a == NULL)
+		return 0;
+
+	if (a->maj > b->maj) return -1;
+	if (a->maj < b->maj) return 1;
+
+	if (a->min > b->min) return -1;
+	if (a->min < b->min) return 1;
+
+	if (a->ino > b->ino) return -1;
+	if (a->ino < b->ino) return 1;
+
+	if (a->ino_generation > b->ino_generation) return -1;
+	if (a->ino_generation < b->ino_generation) return 1;
+
+	return 0;
+}
+
 bool __dsos__read_build_ids(struct list_head *head, bool with_hits)
 {
 	bool have_build_id = false;
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index f962eb9035c7..e1e573a28a55 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -28,6 +28,8 @@ struct dso_id {
 	u64	ino_generation;
 };
 
+int dso_id__cmp(struct dso_id *a, struct dso_id *b);
+
 struct map {
 	union {
 		struct rb_node	rb_node;
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index bc589438cd12..f1481002fafb 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -1194,6 +1194,7 @@ sort__dcacheline_cmp(struct hist_entry *left, struct hist_entry *right)
 {
 	u64 l, r;
 	struct map *l_map, *r_map;
+	int rc;
 
 	if (!left->mem_info)  return -1;
 	if (!right->mem_info) return 1;
@@ -1212,18 +1213,9 @@ sort__dcacheline_cmp(struct hist_entry *left, struct hist_entry *right)
 	if (!l_map) return -1;
 	if (!r_map) return 1;
 
-	if (l_map->dso_id.maj > r_map->dso_id.maj) return -1;
-	if (l_map->dso_id.maj < r_map->dso_id.maj) return 1;
-
-	if (l_map->dso_id.min > r_map->dso_id.min) return -1;
-	if (l_map->dso_id.min < r_map->dso_id.min) return 1;
-
-	if (l_map->dso_id.ino > r_map->dso_id.ino) return -1;
-	if (l_map->dso_id.ino < r_map->dso_id.ino) return 1;
-
-	if (l_map->dso_id.ino_generation > r_map->dso_id.ino_generation) return -1;
-	if (l_map->dso_id.ino_generation < r_map->dso_id.ino_generation) return 1;
-
+	rc = dso_id__cmp(&l_map->dso_id, &r_map->dso_id);
+	if (rc)
+		return rc;
 	/*
 	 * Addresses with no major/minor numbers are assumed to be
 	 * anonymous in userspace.  Sort those on pid then address.
-- 
2.21.0

