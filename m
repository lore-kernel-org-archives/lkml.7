Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62935C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 06:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41FB721835
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 06:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfK2GDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 01:03:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48067 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbfK2GDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 01:03:05 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iaZMq-0008NB-M3; Fri, 29 Nov 2019 07:03:00 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 507DF1C210B;
        Fri, 29 Nov 2019 07:02:53 +0100 (CET)
Date:   Fri, 29 Nov 2019 06:02:53 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf map: Remove unused functions
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <tip-p2k98mj3ff2uk1z95sbl5r6e@git.kernel.org>
References: <tip-p2k98mj3ff2uk1z95sbl5r6e@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157500737321.21853.13720782224200269774.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     a82f15e39a4b75482d48d0910f6abe5e4f869b76
Gitweb:        https://git.kernel.org/tip/a82f15e39a4b75482d48d0910f6abe5e4f869b76
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 25 Nov 2019 10:42:38 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 26 Nov 2019 11:07:46 -03:00

perf map: Remove unused functions

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
index b59944e..267d951 100644
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
index 63ed211..f627024 100644
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
