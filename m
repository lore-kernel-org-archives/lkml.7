Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF0FC432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 08:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B109A2071C
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 08:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfKWIPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 03:15:42 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36331 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbfKWIPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 03:15:20 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iYQZV-0002fJ-FA; Sat, 23 Nov 2019 09:15:13 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B04881C1ADE;
        Sat, 23 Nov 2019 09:15:03 +0100 (CET)
Date:   Sat, 23 Nov 2019 08:15:03 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf map: Move maj/min/ino/ino_generation to separate struct
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <tip-8v5isitqy0dup47nnwkpc80f@git.kernel.org>
References: <tip-8v5isitqy0dup47nnwkpc80f@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157449690360.21853.4699547808950551360.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     99459a84d5870a88274b4f10bc85c3e39e1d642c
Gitweb:        https://git.kernel.org/tip/99459a84d5870a88274b4f10bc85c3e39e1d642c
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Tue, 19 Nov 2019 12:26:19 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 19 Nov 2019 15:09:26 -03:00

perf map: Move maj/min/ino/ino_generation to separate struct

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
index 585805f..04c197d 100644
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
index 67e0f81..4f50b1b 100644
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
index 0a6c45f..70d87dc 100644
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
index 6b626e6..bc58943 100644
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
