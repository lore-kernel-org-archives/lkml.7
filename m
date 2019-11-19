Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3938C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 11:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8B1D22316
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 11:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574163203;
	bh=zJiKPPuUjPA+yFMZkNziIKQSe6ZecWtCoxpDmixorfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EilELBOrlIcNL1WV+iwxwQ3n3fNjmfyUzLpyvO4p207FFecXlNVcfhSyU5db7o6/6
	 kN0/FoImpH3PuzOZ74ZieO3q9saFTwiHfJ7pJlRxV2m9jlNgw/2NrUTyOKpUG2dAqf
	 KhWbI12ZutQipzULCfNty0+Z9KxB287rgksGTubQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbfKSLdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 06:33:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:47036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbfKSLdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 06:33:21 -0500
Received: from quaco.ghostprotocols.net (179.176.11.138.dynamic.adsl.gvt.net.br [179.176.11.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37EE8222DD;
        Tue, 19 Nov 2019 11:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574163200;
        bh=zJiKPPuUjPA+yFMZkNziIKQSe6ZecWtCoxpDmixorfs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f9xiW3qYN87r1WoVt51d4yHtRpfxsbLZenqM4cQd3GFw+XbkaTazyqTjfK2bPqniC
         bmOrn5oMbGdK0Hj+IOiTkkx7mNn87tq1yIrDmhaWgVuvFS0K6teNbKSKkU1oRBCCtv
         /3cuZVD6FJYC/p78wgJBxpyoO3wZrnsgZeM7A7ms=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 05/25] perf maps: Purge the entries from maps->names in __maps__purge()
Date:   Tue, 19 Nov 2019 08:32:25 -0300
Message-Id: <20191119113245.19593-6-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191119113245.19593-1-acme@kernel.org>
References: <20191119113245.19593-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

No need to iterate via the ->names rbtree, as all the entries there
as in maps->entries as well, reuse __maps__purge() for that.

Doing it this way we can kill maps__for_each_entry_by_name(),
maps__for_each_entry_by_name_safe(), maps__{first,next}_by_name().

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-ps0nrio8pydyo23rr2s696ue@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.c        | 34 +---------------------------------
 tools/perf/util/map_groups.h |  8 --------
 2 files changed, 1 insertion(+), 41 deletions(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 359846833a00..69b9e9b3d915 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -589,15 +589,7 @@ static void __maps__purge(struct maps *maps)
 	maps__for_each_entry_safe(maps, pos, next) {
 		rb_erase_init(&pos->rb_node,  &maps->entries);
 		map__put(pos);
-	}
-}
-
-static void __maps__purge_names(struct maps *maps)
-{
-	struct map *pos, *next;
-
-	maps__for_each_entry_by_name_safe(maps, pos, next) {
-		rb_erase_init(&pos->rb_node_name,  &maps->names);
+		rb_erase_init(&pos->rb_node_name, &maps->names);
 		map__put(pos);
 	}
 }
@@ -606,7 +598,6 @@ static void maps__exit(struct maps *maps)
 {
 	down_write(&maps->lock);
 	__maps__purge(maps);
-	__maps__purge_names(maps);
 	up_write(&maps->lock);
 }
 
@@ -994,29 +985,6 @@ struct map *map__next(struct map *map)
 	return map ? __map__next(map) : NULL;
 }
 
-struct map *maps__first_by_name(struct maps *maps)
-{
-	struct rb_node *first = rb_first(&maps->names);
-
-	if (first)
-		return rb_entry(first, struct map, rb_node_name);
-	return NULL;
-}
-
-static struct map *__map__next_by_name(struct map *map)
-{
-	struct rb_node *next = rb_next(&map->rb_node_name);
-
-	if (next)
-		return rb_entry(next, struct map, rb_node_name);
-	return NULL;
-}
-
-struct map *map__next_by_name(struct map *map)
-{
-	return map ? __map__next_by_name(map) : NULL;
-}
-
 struct kmap *__map__kmap(struct map *map)
 {
 	if (!map->dso || !map->dso->kernel)
diff --git a/tools/perf/util/map_groups.h b/tools/perf/util/map_groups.h
index 99cb810acc7c..3f361405a4d4 100644
--- a/tools/perf/util/map_groups.h
+++ b/tools/perf/util/map_groups.h
@@ -33,14 +33,6 @@ struct map *map__next(struct map *map);
 	for (map = maps__first(maps), next = map__next(map); map; map = next, next = map__next(map))
 
 struct symbol *maps__find_symbol_by_name(struct maps *maps, const char *name, struct map **mapp);
-struct map *maps__first_by_name(struct maps *maps);
-struct map *map__next_by_name(struct map *map);
-
-#define maps__for_each_entry_by_name(maps, map) \
-	for (map = maps__first_by_name(maps); map; map = map__next_by_name(map))
-
-#define maps__for_each_entry_by_name_safe(maps, map, next) \
-	for (map = maps__first_by_name(maps), next = map__next_by_name(map); map; map = next, next = map__next_by_name(map))
 
 struct map_groups {
 	struct maps	 maps;
-- 
2.21.0

