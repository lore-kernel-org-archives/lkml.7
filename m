Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356F7C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 16:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0169C208D4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 16:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbfKSQ7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 11:59:12 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52840 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728638AbfKSQ5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 11:57:06 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iX6oC-0007T4-J5; Tue, 19 Nov 2019 17:56:56 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id BD3831C19D7;
        Tue, 19 Nov 2019 17:56:49 +0100 (CET)
Date:   Tue, 19 Nov 2019 16:56:49 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf map_groups: Auto sort maps by name, if needed
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-c5lmbyr14x448rcfii7y6t3k@git.kernel.org>
References: <tip-c5lmbyr14x448rcfii7y6t3k@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157418260971.12247.16181537627866809288.tip-bot2@tip-bot2>
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

Commit-ID:     a7c2b572e217418ad34441202ad3addd8f94d2ea
Gitweb:        https://git.kernel.org/tip/a7c2b572e217418ad34441202ad3addd8f94d2ea
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Sun, 17 Nov 2019 11:38:13 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 18 Nov 2019 13:01:58 -03:00

perf map_groups: Auto sort maps by name, if needed

There are still lots of lookups by name, even if just when loading
vmlinux, till that code is studied to figure out if its possible to do
away with those map lookup by names, provide a way to sort it using
libc's qsort/bsearch.

Doing it at the first lookup defers the sorting a bit, and as the code
stands now, is never done for user maps, just for the kernel ones.

  # perf probe -l
  # perf probe -x ~/bin/perf -L __map_groups__find_by_name
  <__map_groups__find_by_name@/home/acme/git/perf/tools/perf/util/symbol.c:0>
        0  static struct map *__map_groups__find_by_name(struct map_groups *mg, const char *name)
        1  {
                  struct map **mapp;

        4         if (mg->maps_by_name == NULL &&
        5             map__groups__sort_by_name_from_rbtree(mg))
        6                 return NULL;

        8         mapp = bsearch(name, mg->maps_by_name, mg->nr_maps, sizeof(*mapp), map__strcmp_name);
        9         if (mapp)
       10                 return *mapp;
       11         return NULL;
       12  }

           struct map *map_groups__find_by_name(struct map_groups *mg, const char *name)
           {

  # perf probe -x ~/bin/perf 'found=__map_groups__find_by_name:10 name:string'
  Added new event:
    probe_perf:found     (on __map_groups__find_by_name:10 in /home/acme/bin/perf with name:string)

  You can now use it in all perf tools, such as:

  	perf record -e probe_perf:found -aR sleep 1

  #
  # perf probe -x ~/bin/perf -L map_groups__find_by_name
  <map_groups__find_by_name@/home/acme/git/perf/tools/perf/util/symbol.c:0>
        0  struct map *map_groups__find_by_name(struct map_groups *mg, const char *name)
        1  {
        2         struct maps *maps = &mg->maps;
                  struct map *map;

        5         down_read(&maps->lock);

        7         if (mg->last_search_by_name && strcmp(mg->last_search_by_name->dso->short_name, name) == 0) {
        8                 map = mg->last_search_by_name;
        9                 goto out_unlock;
                  }
                  /*
                   * If we have mg->maps_by_name, then the name isn't in the rbtree,
                   * as mg->maps_by_name mirrors the rbtree when lookups by name are
                   * made.
                   */
       16         map = __map_groups__find_by_name(mg, name);
       17         if (map || mg->maps_by_name != NULL)
       18                 goto out_unlock;

                  /* Fallback to traversing the rbtree... */
       21         maps__for_each_entry(maps, map)
       22                 if (strcmp(map->dso->short_name, name) == 0) {
       23                         mg->last_search_by_name = map;
       24                         goto out_unlock;
                          }

       27         map = NULL;

           out_unlock:
       30         up_read(&maps->lock);
       31         return map;
       32  }

           int dso__load_vmlinux(struct dso *dso, struct map *map,
                                const char *vmlinux, bool vmlinux_allocated)

  # perf probe -x ~/bin/perf 'fallback=map_groups__find_by_name:21 name:string'
  Added new events:
    probe_perf:fallback  (on map_groups__find_by_name:21 in /home/acme/bin/perf with name:string)
    probe_perf:fallback_1 (on map_groups__find_by_name:21 in /home/acme/bin/perf with name:string)

  You can now use it in all perf tools, such as:

  	perf record -e probe_perf:fallback_1 -aR sleep 1

  #
  # perf probe -l
    probe_perf:fallback  (on map_groups__find_by_name:21@util/symbol.c in /home/acme/bin/perf with name_string)
    probe_perf:fallback_1 (on map_groups__find_by_name:21@util/symbol.c in /home/acme/bin/perf with name_string)
    probe_perf:found     (on __map_groups__find_by_name:10@util/symbol.c in /home/acme/bin/perf with name_string)
  #
  # perf stat -e probe_perf:*

Now run 'perf top' in another term and then, after a while, stop 'perf stat':

Furthermore, if we ask for interval printing, we can see that that is done just
at the start of the workload:

  # perf stat -I1000 -e probe_perf:*
  #           time             counts unit events
       1.000319513                  0      probe_perf:found
       1.000319513                  0      probe_perf:fallback_1
       1.000319513                  0      probe_perf:fallback
       2.001868092             23,251      probe_perf:found
       2.001868092                  0      probe_perf:fallback_1
       2.001868092                  0      probe_perf:fallback
       3.002901597                  0      probe_perf:found
       3.002901597                  0      probe_perf:fallback_1
       3.002901597                  0      probe_perf:fallback
       4.003358591                  0      probe_perf:found
       4.003358591                  0      probe_perf:fallback_1
       4.003358591                  0      probe_perf:fallback
  ^C
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-c5lmbyr14x448rcfii7y6t3k@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.c        | 49 +++++++++++++++++++++++++++--
 tools/perf/util/map_groups.h |  6 ++++-
 tools/perf/util/symbol.c     | 59 +++++++++++++++++++++++++++++++++++-
 3 files changed, 111 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index d0899df..67e0f81 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -573,20 +573,63 @@ void map_groups__init(struct map_groups *mg, struct machine *machine)
 	maps__init(&mg->maps);
 	mg->machine = machine;
 	mg->last_search_by_name = NULL;
+	mg->nr_maps = 0;
+	mg->maps_by_name = NULL;
 	refcount_set(&mg->refcnt, 1);
 }
 
+static void __map_groups__free_maps_by_name(struct map_groups *mg)
+{
+	/*
+	 * Free everything to try to do it from the rbtree in the next search
+	 */
+	zfree(&mg->maps_by_name);
+	mg->nr_maps_allocated = 0;
+}
+
 void map_groups__insert(struct map_groups *mg, struct map *map)
 {
-	maps__insert(&mg->maps, map);
+	struct maps *maps = &mg->maps;
+
+	down_write(&maps->lock);
+	__maps__insert(maps, map);
+	++mg->nr_maps;
+
+	/*
+	 * If we already performed some search by name, then we need to add the just
+	 * inserted map and resort.
+	 */
+	if (mg->maps_by_name) {
+		if (mg->nr_maps > mg->nr_maps_allocated) {
+			int nr_allocate = mg->nr_maps * 2;
+			struct map **maps_by_name = realloc(mg->maps_by_name, nr_allocate * sizeof(map));
+
+			if (maps_by_name == NULL) {
+				__map_groups__free_maps_by_name(mg);
+				return;
+			}
+
+			mg->maps_by_name = maps_by_name;
+			mg->nr_maps_allocated = nr_allocate;
+		}
+		mg->maps_by_name[mg->nr_maps - 1] = map;
+		__map_groups__sort_by_name(mg);
+	}
+	up_write(&maps->lock);
 }
 
 void map_groups__remove(struct map_groups *mg, struct map *map)
 {
+	struct maps *maps = &mg->maps;
+	down_write(&maps->lock);
 	if (mg->last_search_by_name == map)
 		mg->last_search_by_name = NULL;
 
-	maps__remove(&mg->maps, map);
+	__maps__remove(maps, map);
+	--mg->nr_maps;
+	if (mg->maps_by_name)
+		__map_groups__free_maps_by_name(mg);
+	up_write(&maps->lock);
 }
 
 static void __maps__purge(struct maps *maps)
@@ -904,7 +947,7 @@ void maps__insert(struct maps *maps, struct map *map)
 	up_write(&maps->lock);
 }
 
-static void __maps__remove(struct maps *maps, struct map *map)
+void __maps__remove(struct maps *maps, struct map *map)
 {
 	rb_erase_init(&map->rb_node, &maps->entries);
 	map__put(map);
diff --git a/tools/perf/util/map_groups.h b/tools/perf/util/map_groups.h
index f2a3158..63ed211 100644
--- a/tools/perf/util/map_groups.h
+++ b/tools/perf/util/map_groups.h
@@ -21,6 +21,7 @@ struct maps {
 
 void maps__insert(struct maps *maps, struct map *map);
 void maps__remove(struct maps *maps, struct map *map);
+void __maps__remove(struct maps *maps, struct map *map);
 struct map *maps__find(struct maps *maps, u64 addr);
 struct map *maps__first(struct maps *maps);
 struct map *map__next(struct map *map);
@@ -37,7 +38,10 @@ struct map_groups {
 	struct maps	 maps;
 	struct machine	 *machine;
 	struct map	 *last_search_by_name;
+	struct map	 **maps_by_name;
 	refcount_t	 refcnt;
+	unsigned int	 nr_maps;
+	unsigned int	 nr_maps_allocated;
 #ifdef HAVE_LIBUNWIND_SUPPORT
 	void				*addr_space;
 	struct unwind_libunwind_ops	*unwind_libunwind_ops;
@@ -97,4 +101,6 @@ struct map *map_groups__find_by_name(struct map_groups *mg, const char *name);
 
 int map_groups__merge_in(struct map_groups *kmaps, struct map *new_map);
 
+void __map_groups__sort_by_name(struct map_groups *mg);
+
 #endif // __PERF_MAP_GROUPS_H
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index b5ae82a..db9667a 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1760,6 +1760,56 @@ out:
 	return ret;
 }
 
+static int map__strcmp(const void *a, const void *b)
+{
+	const struct map *ma = *(const struct map **)a, *mb = *(const struct map **)b;
+	return strcmp(ma->dso->short_name, mb->dso->short_name);
+}
+
+static int map__strcmp_name(const void *name, const void *b)
+{
+	const struct map *map = *(const struct map **)b;
+	return strcmp(name, map->dso->short_name);
+}
+
+void __map_groups__sort_by_name(struct map_groups *mg)
+{
+	qsort(mg->maps_by_name, mg->nr_maps, sizeof(struct map *), map__strcmp);
+}
+
+static int map__groups__sort_by_name_from_rbtree(struct map_groups *mg)
+{
+	struct map *map;
+	struct map **maps_by_name = realloc(mg->maps_by_name, mg->nr_maps * sizeof(map));
+	int i = 0;
+
+	if (maps_by_name == NULL)
+		return -1;
+
+	mg->maps_by_name = maps_by_name;
+	mg->nr_maps_allocated = mg->nr_maps;
+
+	maps__for_each_entry(&mg->maps, map)
+		maps_by_name[i++] = map;
+
+	__map_groups__sort_by_name(mg);
+	return 0;
+}
+
+static struct map *__map_groups__find_by_name(struct map_groups *mg, const char *name)
+{
+	struct map **mapp;
+
+	if (mg->maps_by_name == NULL &&
+	    map__groups__sort_by_name_from_rbtree(mg))
+		return NULL;
+
+	mapp = bsearch(name, mg->maps_by_name, mg->nr_maps, sizeof(*mapp), map__strcmp_name);
+	if (mapp)
+		return *mapp;
+	return NULL;
+}
+
 struct map *map_groups__find_by_name(struct map_groups *mg, const char *name)
 {
 	struct maps *maps = &mg->maps;
@@ -1771,7 +1821,16 @@ struct map *map_groups__find_by_name(struct map_groups *mg, const char *name)
 		map = mg->last_search_by_name;
 		goto out_unlock;
 	}
+	/*
+	 * If we have mg->maps_by_name, then the name isn't in the rbtree,
+	 * as mg->maps_by_name mirrors the rbtree when lookups by name are
+	 * made.
+	 */
+	map = __map_groups__find_by_name(mg, name);
+	if (map || mg->maps_by_name != NULL)
+		goto out_unlock;
 
+	/* Fallback to traversing the rbtree... */
 	maps__for_each_entry(maps, map)
 		if (strcmp(map->dso->short_name, name) == 0) {
 			mg->last_search_by_name = map;
