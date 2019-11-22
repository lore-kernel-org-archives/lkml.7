Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BB3C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 14:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FDF920730
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 14:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574434648;
	bh=s3+2BtByjVlj8VckRBOdRtzGRDSefPDxir/VloryU4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ppi5VL29mplc/0W8zJ+dkkgph2ahpXWkBi/gDuWBEY4KxrLLijA4w31dKtgFRbQDo
	 SnBEzhdZtMi/1fwDQ9A+omktDR5EvFtvK3kCH4fVVkKPFDvVvUWSyRAmFJIMs7XzEP
	 VbfGEdEw1//FY5cPJknOfpJGVQp0pNEXaLZuYhSc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfKVO51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 09:57:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:58174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726836AbfKVO5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 09:57:25 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6D562072E;
        Fri, 22 Nov 2019 14:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574434644;
        bh=s3+2BtByjVlj8VckRBOdRtzGRDSefPDxir/VloryU4I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qG6MyALWmt+IoMTLdoYRThGxxVl1nPcFoO0Y+VjZt84rAz7bxwGE0YrjapqRB4XOU
         /DX6BD25wiqlbXExRfz98yjxp049eB0Qsy/94C/O8s85KeksjSU/ylDYZ43oKaY/aM
         3VkHMyruWmEQos3CLKqowzXESxptMNF9qy2jx9Aw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 02/26] perf map: Pass a dso_id to map__new()
Date:   Fri, 22 Nov 2019 11:56:47 -0300
Message-Id: <20191122145711.3171-3-acme@kernel.org>
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
index 71ee078d30f4..41b4263c073d 100644
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
index 4f50b1b2961f..812d663ebb57 100644
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
index 70d87dcbe35d..f962eb9035c7 100644
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
-- 
2.21.0

