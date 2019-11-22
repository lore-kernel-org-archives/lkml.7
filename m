Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66ABC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 14:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97A9320730
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 14:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574434645;
	bh=sBlOPEsaAW6LXEWbMXoWlBOhG1kQDMpQol/B3BjaPS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v/PHPe1KN0jDi4qaTOWTkN/dYcnq69slXr4z+S79IAd6DBw85ouaz6Ze1+ILEe2Rt
	 3kP5gFFMkVifMoRYZXItMNNljsIA91mphNUahKP2lgmn8arxHNeMnAQ02u/nlE3kGr
	 q6bpOYYgSb74v8VzFeAkYM+TU1F2ENaS7qX3AYlM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfKVO5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 09:57:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:58092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726836AbfKVO5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 09:57:23 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14DE22071C;
        Fri, 22 Nov 2019 14:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574434642;
        bh=sBlOPEsaAW6LXEWbMXoWlBOhG1kQDMpQol/B3BjaPS4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oQKSFDBuuSMepXfeexZeTy43PC00KmcWbU/rxHpbqqyWEz53bGQd5eLJEE9i8ybAs
         8Gqc44jh8T3kczWJMVVUGhZ4IQgVvMIVfGWPZfeWwNumnb98GZVpYAMxwaw5mEBwMN
         +R/PgWlOJIM6fLX+k/Ak5AMifbWnTZ02QckgCa38=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 01/26] perf map: Move maj/min/ino/ino_generation to separate struct
Date:   Fri, 22 Nov 2019 11:56:46 -0300
Message-Id: <20191122145711.3171-2-acme@kernel.org>
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

And this patch highlights where these fields are being used: in the sort
order where it uses it to compare maps and classify samples taking into
account not just the DSO, but those DSO id fields.

I think these should be used to differentiate DSOs with the same name
but different 'struct dso_id' fields, i.e. these fields should move to
'struct dso' and then be used as part of the key when doing lookups for
DSOs, in addition to the DSO name.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-8v5isitqy0dup47nnwkpc80f@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-report.c |  2 +-
 tools/perf/util/map.c       |  8 ++++----
 tools/perf/util/map.h       | 14 +++++++++++---
 tools/perf/util/sort.c      | 24 ++++++++++++------------
 4 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 585805f51f15..04c197d3beea 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -771,7 +771,7 @@ static size_t maps__fprintf_task(struct maps *maps, int indent, FILE *fp)
 				   map->prot & PROT_EXEC ? 'x' : '-',
 				   map->flags & MAP_SHARED ? 's' : 'p',
 				   map->pgoff,
-				   map->ino, map->dso->name);
+				   map->dso_id.ino, map->dso->name);
 	}
 
 	return printed;
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 67e0f81416cb..4f50b1b2961f 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -162,10 +162,10 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 		vdso = is_vdso_map(filename);
 		no_dso = is_no_dso_memory(filename);
 
-		map->maj = d_maj;
-		map->min = d_min;
-		map->ino = ino;
-		map->ino_generation = ino_gen;
+		map->dso_id.maj = d_maj;
+		map->dso_id.min = d_min;
+		map->dso_id.ino = ino;
+		map->dso_id.ino_generation = ino_gen;
 		map->prot = prot;
 		map->flags = flags;
 		nsi = nsinfo__get(thread->nsinfo);
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 0a6c45f85cd9..70d87dcbe35d 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -18,6 +18,16 @@ struct map_groups;
 struct machine;
 struct evsel;
 
+/*
+ * Data about backing storage DSO, comes from PERF_RECORD_MMAP2 meta events
+ */
+struct dso_id {
+	u32	maj;
+	u32	min;
+	u64	ino;
+	u64	ino_generation;
+};
+
 struct map {
 	union {
 		struct rb_node	rb_node;
@@ -30,9 +40,6 @@ struct map {
 	u32			prot;
 	u64			pgoff;
 	u64			reloc;
-	u32			maj, min; /* only valid for MMAP2 record */
-	u64			ino;      /* only valid for MMAP2 record */
-	u64			ino_generation;/* only valid for MMAP2 record */
 
 	/* ip -> dso rip */
 	u64			(*map_ip)(struct map *, u64);
@@ -40,6 +47,7 @@ struct map {
 	u64			(*unmap_ip)(struct map *, u64);
 
 	struct dso		*dso;
+	struct dso_id		dso_id;
 	refcount_t		refcnt;
 	u32			flags;
 };
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 6b626e6b111e..bc589438cd12 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -1212,17 +1212,17 @@ sort__dcacheline_cmp(struct hist_entry *left, struct hist_entry *right)
 	if (!l_map) return -1;
 	if (!r_map) return 1;
 
-	if (l_map->maj > r_map->maj) return -1;
-	if (l_map->maj < r_map->maj) return 1;
+	if (l_map->dso_id.maj > r_map->dso_id.maj) return -1;
+	if (l_map->dso_id.maj < r_map->dso_id.maj) return 1;
 
-	if (l_map->min > r_map->min) return -1;
-	if (l_map->min < r_map->min) return 1;
+	if (l_map->dso_id.min > r_map->dso_id.min) return -1;
+	if (l_map->dso_id.min < r_map->dso_id.min) return 1;
 
-	if (l_map->ino > r_map->ino) return -1;
-	if (l_map->ino < r_map->ino) return 1;
+	if (l_map->dso_id.ino > r_map->dso_id.ino) return -1;
+	if (l_map->dso_id.ino < r_map->dso_id.ino) return 1;
 
-	if (l_map->ino_generation > r_map->ino_generation) return -1;
-	if (l_map->ino_generation < r_map->ino_generation) return 1;
+	if (l_map->dso_id.ino_generation > r_map->dso_id.ino_generation) return -1;
+	if (l_map->dso_id.ino_generation < r_map->dso_id.ino_generation) return 1;
 
 	/*
 	 * Addresses with no major/minor numbers are assumed to be
@@ -1234,8 +1234,8 @@ sort__dcacheline_cmp(struct hist_entry *left, struct hist_entry *right)
 
 	if ((left->cpumode != PERF_RECORD_MISC_KERNEL) &&
 	    (!(l_map->flags & MAP_SHARED)) &&
-	    !l_map->maj && !l_map->min && !l_map->ino &&
-	    !l_map->ino_generation) {
+	    !l_map->dso_id.maj && !l_map->dso_id.min &&
+	    !l_map->dso_id.ino && !l_map->dso_id.ino_generation) {
 		/* userspace anonymous */
 
 		if (left->thread->pid_ > right->thread->pid_) return -1;
@@ -1271,8 +1271,8 @@ static int hist_entry__dcacheline_snprintf(struct hist_entry *he, char *bf,
 		if ((he->cpumode != PERF_RECORD_MISC_KERNEL) &&
 		     map && !(map->prot & PROT_EXEC) &&
 		    (map->flags & MAP_SHARED) &&
-		    (map->maj || map->min || map->ino ||
-		     map->ino_generation))
+		    (map->dso_id.maj || map->dso_id.min ||
+		     map->dso_id.ino || map->dso_id.ino_generation))
 			level = 's';
 		else if (!map)
 			level = 'X';
-- 
2.21.0

