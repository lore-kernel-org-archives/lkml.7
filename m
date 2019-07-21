Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE31C76188
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F63C2147A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563708671;
	bh=zxE1zPyaRWUsFoanXcUVvA70+PCn/EuN8GbwKDnBmY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gMQEkBO0slv3ZFpzWS6V6JF8GxMXRe2r7T9QLl3SiXRNNLlPMMKmLSUxhO9OvRT83
	 vT6f//6jbKKD4Z2z5f5BGd6xbgT8TUQ+JLaGClEcSzqFgB+HqnnMypkcpIWz8go/aD
	 JPbntUfajHBRsDsNWXjLNx4NJicTCAJ489uPxDaU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbfGULbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 07:31:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35612 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbfGULbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 07:31:08 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 29260307D910;
        Sun, 21 Jul 2019 11:31:08 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-23.brq.redhat.com [10.40.204.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 697FD5D9D3;
        Sun, 21 Jul 2019 11:31:04 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 53/79] libperf: Add has_user_cpus to struct perf_evlist
Date:   Sun, 21 Jul 2019 13:24:40 +0200
Message-Id: <20190721112506.12306-54-jolsa@kernel.org>
In-Reply-To: <20190721112506.12306-1-jolsa@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Sun, 21 Jul 2019 11:31:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving has_user_cpus from evlist into perf_evlist struct.

Link: http://lkml.kernel.org/n/tip-5xa3xakotbq9aphsyhte8xrv@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
index dfba8e4ee7e3..5d104678d4d9 100644
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

