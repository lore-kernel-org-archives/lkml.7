Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EDCC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 164D92087F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556871552;
	bh=gHbYBKNKOQoymahz2R4ZtPLG0yjklTwxHMoKyHSrzlA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oqg+aaUbq/8r3dVbvUs+Y4fPXnLdNhoinwRW7jNulnPA7aQ0C7Yuhxc4rH+6rI7oA
	 H6AaNYNvqlYmWd6l1OPKVxaLYP5fw0n9waC5CTiJFdReI6elw6XmAWSZv5c5Kg8wSo
	 yjp3hdZ3FntcUgtQP/ttcWILPF5DSoM/MoM2GsaM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfECITL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 04:19:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59849 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727109AbfECITI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 04:19:08 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5DC8B307D989;
        Fri,  3 May 2019 08:19:08 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3C7C0F6E6;
        Fri,  3 May 2019 08:19:06 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Song Liu <songliubraving@fb.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 08/12] perf tools: Preserve eBPF maps when loading kcore
Date:   Fri,  3 May 2019 10:18:37 +0200
Message-Id: <20190503081841.1908-9-jolsa@kernel.org>
In-Reply-To: <20190503081841.1908-1-jolsa@kernel.org>
References: <20190503081841.1908-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 03 May 2019 08:19:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to preserve eBPF maps even if they are
covered by kcore, because we need to access
eBPF dso for source data.

Adding map_groups__merge_in function to do that.
It merges map into map_groups by splitting the
new map within the existing map regions.

Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
Link: http://lkml.kernel.org/n/tip-mlu13e9zl6rbsz4fa00x7mfa@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/symbol.c | 97 ++++++++++++++++++++++++++++++++++++++--
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
-- 
2.20.1

