Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E53C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 08:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EFB72071C
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 08:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfKWIPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 03:15:24 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36327 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbfKWIPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 03:15:18 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iYQZU-0002eQ-J0; Sat, 23 Nov 2019 09:15:13 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7ECE51C1ADD;
        Sat, 23 Nov 2019 09:15:03 +0100 (CET)
Date:   Sat, 23 Nov 2019 08:15:03 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf map: Pass a dso_id to map__new()
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <tip-gp5s1xgxacurmih5d1l94ymy@git.kernel.org>
References: <tip-gp5s1xgxacurmih5d1l94ymy@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157449690340.21853.17517616578399359386.tip-bot2@tip-bot2>
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

Commit-ID:     4a7380a52ec90fbb1565dd638ee7f5b6e709f7fb
Gitweb:        https://git.kernel.org/tip/4a7380a52ec90fbb1565dd638ee7f5b6e709f7fb
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Tue, 19 Nov 2019 12:40:29 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 19 Nov 2019 15:09:26 -03:00

perf map: Pass a dso_id to map__new()

Instead of the 4 fields, a step in the direction of moving this to
struct dso.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-gp5s1xgxacurmih5d1l94ymy@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 15 ++++++++-------
 tools/perf/util/map.c     | 13 +++++++------
 tools/perf/util/map.h     |  3 +--
 3 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 71ee078..41b4263 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1651,6 +1651,12 @@ int machine__process_mmap2_event(struct machine *machine,
 {
 	struct thread *thread;
 	struct map *map;
+	struct dso_id dso_id = {
+		.maj = event->mmap2.maj,
+		.min = event->mmap2.min,
+		.ino = event->mmap2.ino,
+		.ino_generation = event->mmap2.ino_generation,
+	};
 	int ret = 0;
 
 	if (dump_trace)
@@ -1671,10 +1677,7 @@ int machine__process_mmap2_event(struct machine *machine,
 
 	map = map__new(machine, event->mmap2.start,
 			event->mmap2.len, event->mmap2.pgoff,
-			event->mmap2.maj,
-			event->mmap2.min, event->mmap2.ino,
-			event->mmap2.ino_generation,
-			event->mmap2.prot,
+			&dso_id, event->mmap2.prot,
 			event->mmap2.flags,
 			event->mmap2.filename, thread);
 
@@ -1727,9 +1730,7 @@ int machine__process_mmap_event(struct machine *machine, union perf_event *event
 
 	map = map__new(machine, event->mmap.start,
 			event->mmap.len, event->mmap.pgoff,
-			0, 0, 0, 0, prot, 0,
-			event->mmap.filename,
-			thread);
+			NULL, prot, 0, event->mmap.filename, thread);
 
 	if (map == NULL)
 		goto out_problem_map;
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 4f50b1b..812d663 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -144,8 +144,8 @@ void map__init(struct map *map, u64 start, u64 end, u64 pgoff, struct dso *dso)
 }
 
 struct map *map__new(struct machine *machine, u64 start, u64 len,
-		     u64 pgoff, u32 d_maj, u32 d_min, u64 ino,
-		     u64 ino_gen, u32 prot, u32 flags, char *filename,
+		     u64 pgoff, struct dso_id *id,
+		     u32 prot, u32 flags, char *filename,
 		     struct thread *thread)
 {
 	struct map *map = malloc(sizeof(*map));
@@ -162,10 +162,11 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 		vdso = is_vdso_map(filename);
 		no_dso = is_no_dso_memory(filename);
 
-		map->dso_id.maj = d_maj;
-		map->dso_id.min = d_min;
-		map->dso_id.ino = ino;
-		map->dso_id.ino_generation = ino_gen;
+		if (id)
+			map->dso_id = *id;
+		else
+			map->dso_id.min = map->dso_id.ino = map->dso_id.ino_generation = 0;
+
 		map->prot = prot;
 		map->flags = flags;
 		nsi = nsinfo__get(thread->nsinfo);
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 70d87dc..f962eb9 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -117,8 +117,7 @@ struct thread;
 void map__init(struct map *map,
 	       u64 start, u64 end, u64 pgoff, struct dso *dso);
 struct map *map__new(struct machine *machine, u64 start, u64 len,
-		     u64 pgoff, u32 d_maj, u32 d_min, u64 ino,
-		     u64 ino_gen, u32 prot, u32 flags,
+		     u64 pgoff, struct dso_id *id, u32 prot, u32 flags,
 		     char *filename, struct thread *thread);
 struct map *map__new2(u64 start, struct dso *dso);
 void map__delete(struct map *map);
