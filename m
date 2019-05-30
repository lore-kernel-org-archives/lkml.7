Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08464C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7E0624986
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="C3wq7Q+q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfE3IR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 04:17:29 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53271 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbfE3IR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 04:17:29 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4U7uIni2900042
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 30 May 2019 00:56:19 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4U7uIni2900042
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559202979;
        bh=xNWCPfEpSC/tFibFnuA1OKl5+d/pV7LHcS/KOass5m8=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=C3wq7Q+q3svuAW/du6njlWpx/Nt0lP5aEGzJyxkCE7DitB5AlsaYY2VYrCBMmEoQw
         SIWfloqL/m6cdTrAQ8TQI/OLZfZTgzsr+/Np5VgPuzooI5v2y/Pl5WopMOlm6owSKx
         MkvFy8USwG/sVsM2lCugFrLbnMt1215XomtloMLUyPntYX7OZlXbP6dt5yA5hdao+A
         7d1WkfTfdHzpbkOO6KlIVWYsXMBPIt314yilr1q6Cbn6Rao1GJCMWT3aPDcxHQX8Sf
         tigsnxUGzJ+LdKAZapWpslt7FqNrESUoLyZcvcUTUhIV+49qpijsRCLZbAWhPUpHSM
         MqSFVGxqwe8ZA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4U7uIic2900039;
        Thu, 30 May 2019 00:56:18 -0700
Date:   Thu, 30 May 2019 00:56:18 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-fb5a88d4131a9ee8bec3f4bb7c034d7a4e9cf5ea@git.kernel.org>
Cc:     songliubraving@fb.com, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        ak@linux.intel.com, hpa@zytor.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
        acme@redhat.com, mingo@kernel.org, sdf@google.com, jolsa@kernel.org
Reply-To: alexander.shishkin@linux.intel.com, hpa@zytor.com,
          adrian.hunter@intel.com, ak@linux.intel.com,
          peterz@infradead.org, namhyung@kernel.org, tglx@linutronix.de,
          songliubraving@fb.com, linux-kernel@vger.kernel.org,
          sdf@google.com, jolsa@kernel.org, mingo@kernel.org,
          acme@redhat.com
In-Reply-To: <20190508132010.14512-9-jolsa@kernel.org>
References: <20190508132010.14512-9-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Preserve eBPF maps when loading kcore
Git-Commit-ID: fb5a88d4131a9ee8bec3f4bb7c034d7a4e9cf5ea
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

Commit-ID:  fb5a88d4131a9ee8bec3f4bb7c034d7a4e9cf5ea
Gitweb:     https://git.kernel.org/tip/fb5a88d4131a9ee8bec3f4bb7c034d7a4e9cf5ea
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Wed, 8 May 2019 15:20:06 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 28 May 2019 18:37:42 -0300

perf tools: Preserve eBPF maps when loading kcore

We need to preserve eBPF maps even if they are covered by kcore, because
we need to access eBPF dso for source data.

Add the map_groups__merge_in function to do that.  It merges a map into
map_groups by splitting the new map within the existing map regions.

Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Song Liu <songliubraving@fb.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stanislav Fomichev <sdf@google.com>
Link: http://lkml.kernel.org/r/20190508132010.14512-9-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol.c | 97 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 93 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 5cbad55cd99d..29780fcd049c 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1166,6 +1166,85 @@ static int kcore_mapfn(u64 start, u64 len, u64 pgoff, void *data)
 	return 0;
 }
 
+/*
+ * Merges map into map_groups by splitting the new map
+ * within the existing map regions.
+ */
+static int map_groups__merge_in(struct map_groups *kmaps, struct map *new_map)
+{
+	struct map *old_map;
+	LIST_HEAD(merged);
+
+	for (old_map = map_groups__first(kmaps); old_map;
+	     old_map = map_groups__next(old_map)) {
+
+		/* no overload with this one */
+		if (new_map->end < old_map->start ||
+		    new_map->start >= old_map->end)
+			continue;
+
+		if (new_map->start < old_map->start) {
+			/*
+			 * |new......
+			 *       |old....
+			 */
+			if (new_map->end < old_map->end) {
+				/*
+				 * |new......|     -> |new..|
+				 *       |old....| ->       |old....|
+				 */
+				new_map->end = old_map->start;
+			} else {
+				/*
+				 * |new.............| -> |new..|       |new..|
+				 *       |old....|    ->       |old....|
+				 */
+				struct map *m = map__clone(new_map);
+
+				if (!m)
+					return -ENOMEM;
+
+				m->end = old_map->start;
+				list_add_tail(&m->node, &merged);
+				new_map->start = old_map->end;
+			}
+		} else {
+			/*
+			 *      |new......
+			 * |old....
+			 */
+			if (new_map->end < old_map->end) {
+				/*
+				 *      |new..|   -> x
+				 * |old.........| -> |old.........|
+				 */
+				map__put(new_map);
+				new_map = NULL;
+				break;
+			} else {
+				/*
+				 *      |new......| ->         |new...|
+				 * |old....|        -> |old....|
+				 */
+				new_map->start = old_map->end;
+			}
+		}
+	}
+
+	while (!list_empty(&merged)) {
+		old_map = list_entry(merged.next, struct map, node);
+		list_del_init(&old_map->node);
+		map_groups__insert(kmaps, old_map);
+		map__put(old_map);
+	}
+
+	if (new_map) {
+		map_groups__insert(kmaps, new_map);
+		map__put(new_map);
+	}
+	return 0;
+}
+
 static int dso__load_kcore(struct dso *dso, struct map *map,
 			   const char *kallsyms_filename)
 {
@@ -1222,7 +1301,12 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 	while (old_map) {
 		struct map *next = map_groups__next(old_map);
 
-		if (old_map != map)
+		/*
+		 * We need to preserve eBPF maps even if they are
+		 * covered by kcore, because we need to access
+		 * eBPF dso for source data.
+		 */
+		if (old_map != map && !__map__is_bpf_prog(old_map))
 			map_groups__remove(kmaps, old_map);
 		old_map = next;
 	}
@@ -1256,11 +1340,16 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 			map_groups__remove(kmaps, map);
 			map_groups__insert(kmaps, map);
 			map__put(map);
+			map__put(new_map);
 		} else {
-			map_groups__insert(kmaps, new_map);
+			/*
+			 * Merge kcore map into existing maps,
+			 * and ensure that current maps (eBPF)
+			 * stay intact.
+			 */
+			if (map_groups__merge_in(kmaps, new_map))
+				goto out_err;
 		}
-
-		map__put(new_map);
 	}
 
 	if (machine__is(machine, "x86_64")) {
