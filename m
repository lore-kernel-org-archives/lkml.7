Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203B6C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB7A6216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574948449;
	bh=e5o0Sdc16klvd+K1k1729i/7ErRVZCpGsZhlCCClq0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iyDV7UINIduYULs1nEfZHXnyhr7oFOdI/5bn0g9mXGtbaAogXiRuRXADsrPVw+nTo
	 kPBVniOubzPz8qAxaLP8kR09AdN/wiWVJVBiqOpp2harUEevgt/JqYCfA5i9g+3Y9C
	 z+PC/gXeFEIqRCLQYO+O0P494YBe534gyK0etlos=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfK1Nks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 08:40:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:37270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726733AbfK1Nkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 08:40:47 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01E21217AB;
        Thu, 28 Nov 2019 13:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574948446;
        bh=e5o0Sdc16klvd+K1k1729i/7ErRVZCpGsZhlCCClq0k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BEXmhfykCHkkmvzBhfJEVzarjzcfwmhYJ882jORLHAb5Jc7ZYkXHu8NUqgjXfQBH2
         6PqW+E/RsIueE0pgxV/5dGh0fuqdCMWhmriAjJbBPzutFBeMDsw7jzyd7YJqZKIKkQ
         tYpwezH0C9Ta9rTbWJkRG5hQIubQ/tgOkztDvM44=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 04/22] perf map: Remove unused functions
Date:   Thu, 28 Nov 2019 10:40:09 -0300
Message-Id: <20191128134027.23726-5-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191128134027.23726-1-acme@kernel.org>
References: <20191128134027.23726-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

At some point those stopped being used, prune them.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-p2k98mj3ff2uk1z95sbl5r6e@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.c        | 30 ++++++++----------------------
 tools/perf/util/map_groups.h |  5 -----
 2 files changed, 8 insertions(+), 27 deletions(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index b59944eb469e..267d951b5dfd 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -568,6 +568,12 @@ void map_groups__insert(struct map_groups *mg, struct map *map)
 	up_write(&maps->lock);
 }
 
+static void __maps__remove(struct maps *maps, struct map *map)
+{
+	rb_erase_init(&map->rb_node, &maps->entries);
+	map__put(map);
+}
+
 void map_groups__remove(struct map_groups *mg, struct map *map)
 {
 	struct maps *maps = &mg->maps;
@@ -654,8 +660,8 @@ static bool map__contains_symbol(struct map *map, struct symbol *sym)
 	return ip >= map->start && ip < map->end;
 }
 
-struct symbol *maps__find_symbol_by_name(struct maps *maps, const char *name,
-					 struct map **mapp)
+static struct symbol *maps__find_symbol_by_name(struct maps *maps, const char *name,
+						struct map **mapp)
 {
 	struct symbol *sym;
 	struct map *pos;
@@ -890,26 +896,6 @@ static void __maps__insert(struct maps *maps, struct map *map)
 	map__get(map);
 }
 
-void maps__insert(struct maps *maps, struct map *map)
-{
-	down_write(&maps->lock);
-	__maps__insert(maps, map);
-	up_write(&maps->lock);
-}
-
-void __maps__remove(struct maps *maps, struct map *map)
-{
-	rb_erase_init(&map->rb_node, &maps->entries);
-	map__put(map);
-}
-
-void maps__remove(struct maps *maps, struct map *map)
-{
-	down_write(&maps->lock);
-	__maps__remove(maps, map);
-	up_write(&maps->lock);
-}
-
 struct map *maps__find(struct maps *maps, u64 ip)
 {
 	struct rb_node *p;
diff --git a/tools/perf/util/map_groups.h b/tools/perf/util/map_groups.h
index 63ed211fe241..f6270243ac4b 100644
--- a/tools/perf/util/map_groups.h
+++ b/tools/perf/util/map_groups.h
@@ -19,9 +19,6 @@ struct maps {
 	struct rw_semaphore lock;
 };
 
-void maps__insert(struct maps *maps, struct map *map);
-void maps__remove(struct maps *maps, struct map *map);
-void __maps__remove(struct maps *maps, struct map *map);
 struct map *maps__find(struct maps *maps, u64 addr);
 struct map *maps__first(struct maps *maps);
 struct map *map__next(struct map *map);
@@ -32,8 +29,6 @@ struct map *map__next(struct map *map);
 #define maps__for_each_entry_safe(maps, map, next) \
 	for (map = maps__first(maps), next = map__next(map); map; map = next, next = map__next(map))
 
-struct symbol *maps__find_symbol_by_name(struct maps *maps, const char *name, struct map **mapp);
-
 struct map_groups {
 	struct maps	 maps;
 	struct machine	 *machine;
-- 
2.21.0

