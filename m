Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D45C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46D3720693
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="WTWAeZb9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388392AbfG3SsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:48:10 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51325 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388028AbfG3SsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:48:09 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UIkufc3334995
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 11:46:56 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UIkufc3334995
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564512417;
        bh=bCdFtbl9rLVZRmw/ALUKM6Lv8KXBqJ0jF+YzBICirOE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=WTWAeZb9TLRl1NtOW2h/MMv9fcApizsDe7yem6VdvKRzxi+6Uf/gkUVTyFoZhvbuI
         mgoD4Qt73j8OmE8vt0zWPCQwIFsOq8ibeTXaK1RRXLghdjbOoFt8xkJAfutkQgG9jv
         kem5Cqn637URLsfKGr/zBdZ5Hhjsdj/H7MLSqtYBUpGEZ2te+UGdNw2AWcv9MMH3Oc
         jAH2KpvKvJRuKBIsiECxtuTcptXx2WMeAz8YZrjeoYh/6J7MxP18o7y0bPiqfQyexx
         4RUIIGI/VEvFdQSLPL4Hl7iBfq2VNlj8evJpnXAb4dWa0m/5oZXTvqYco6P61ev0Uw
         NwwkI/wf3mk6A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UIkuAP3334992;
        Tue, 30 Jul 2019 11:46:56 -0700
Date:   Tue, 30 Jul 2019 11:46:56 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-ec903f264f0184a0aba62b42d7717c61f1893450@git.kernel.org>
Cc:     jolsa@kernel.org, hpa@zytor.com, mpetlan@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, alexey.budankov@linux.intel.com,
        peterz@infradead.org, alexander.shishkin@linux.intel.com,
        tglx@linutronix.de, ak@linux.intel.com, acme@redhat.com
Reply-To: alexey.budankov@linux.intel.com,
          alexander.shishkin@linux.intel.com, peterz@infradead.org,
          ak@linux.intel.com, acme@redhat.com, tglx@linutronix.de,
          mingo@kernel.org, linux-kernel@vger.kernel.org,
          mpetlan@redhat.com, namhyung@kernel.org, jolsa@kernel.org,
          hpa@zytor.com
In-Reply-To: <20190721112506.12306-54-jolsa@kernel.org>
References: <20190721112506.12306-54-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] libperf: Add has_user_cpus to struct perf_evlist
Git-Commit-ID: ec903f264f0184a0aba62b42d7717c61f1893450
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  ec903f264f0184a0aba62b42d7717c61f1893450
Gitweb:     https://git.kernel.org/tip/ec903f264f0184a0aba62b42d7717c61f1893450
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 21 Jul 2019 13:24:40 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:45 -0300

libperf: Add has_user_cpus to struct perf_evlist

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
