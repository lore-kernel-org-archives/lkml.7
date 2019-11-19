Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A9AC43215
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 16:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB0752241E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 16:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbfKSQ6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 11:58:24 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52923 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728718AbfKSQ5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 11:57:15 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iX6oL-0007WI-EU; Tue, 19 Nov 2019 17:57:05 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D07F01C19DC;
        Tue, 19 Nov 2019 17:56:50 +0100 (CET)
Date:   Tue, 19 Nov 2019 16:56:50 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf maps: Purge the entries from maps->names in
 __maps__purge()
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-ps0nrio8pydyo23rr2s696ue@git.kernel.org>
References: <tip-ps0nrio8pydyo23rr2s696ue@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157418261074.12247.14398818002410876760.tip-bot2@tip-bot2>
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

Commit-ID:     bcb8af5c46e452018de9b58db1fd0ffd94b5d96c
Gitweb:        https://git.kernel.org/tip/bcb8af5c46e452018de9b58db1fd0ffd94b5d96c
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Wed, 13 Nov 2019 16:06:28 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 13 Nov 2019 16:06:28 -03:00

perf maps: Purge the entries from maps->names in __maps__purge()

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
index 3598468..69b9e9b 100644
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
index 99cb810..3f36140 100644
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
