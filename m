Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA55C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 16:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D400E223D8
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 16:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbfKSQ5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 11:57:15 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52872 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728656AbfKSQ5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 11:57:09 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iX6oH-0007W7-54; Tue, 19 Nov 2019 17:57:01 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 73A621C19DA;
        Tue, 19 Nov 2019 17:56:50 +0100 (CET)
Date:   Tue, 19 Nov 2019 16:56:50 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf map_groups: Add a front end cache for map
 lookups by name
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-tcz37g3nxv3tvxw3q90vga3p@git.kernel.org>
References: <tip-tcz37g3nxv3tvxw3q90vga3p@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157418261040.12247.12941079165025669139.tip-bot2@tip-bot2>
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

Commit-ID:     1ae14516cba032a83b561144d3d48fd381584c0c
Gitweb:        https://git.kernel.org/tip/1ae14516cba032a83b561144d3d48fd381584c0c
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Wed, 13 Nov 2019 16:33:33 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 18 Nov 2019 11:21:32 -03:00

perf map_groups: Add a front end cache for map lookups by name

Lets see if it helps:

First look at the probeable lines for the function that does lookups by
name in a map_groups struct:

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

       12         maps__for_each_entry(maps, map)
       13                 if (strcmp(map->dso->short_name, name) == 0) {
       14                         mg->last_search_by_name = map;
       15                         goto out_unlock;
                          }

       18         map = NULL;

           out_unlock:
       21         up_read(&maps->lock);
       22         return map;
       23  }

           int dso__load_vmlinux(struct dso *dso, struct map *map,
                                const char *vmlinux, bool vmlinux_allocated)

  #

Now add a probe to the place where we reuse the last search:

  # perf probe -x ~/bin/perf map_groups__find_by_name:8
  Added new event:
    probe_perf:map_groups__find_by_name (on map_groups__find_by_name:8 in /home/acme/bin/perf)

  You can now use it in all perf tools, such as:

  	perf record -e probe_perf:map_groups__find_by_name -aR sleep 1

  #

Now lets do a system wide 'perf stat' counting those events:

  # perf stat -e probe_perf:*

Leave it running and lets do a 'perf top', then, after a while, stop the
'perf stat':

  # perf stat -e probe_perf:*
  ^C
   Performance counter stats for 'system wide':

               3,603      probe_perf:map_groups__find_by_name

        44.565253139 seconds time elapsed
  #

yeah, good to have.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-tcz37g3nxv3tvxw3q90vga3p@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.c        |  9 +++++++++
 tools/perf/util/map_groups.h |  6 ++----
 tools/perf/util/symbol.c     |  9 ++++++++-
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 49e353e..d0899df 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -572,6 +572,7 @@ void map_groups__init(struct map_groups *mg, struct machine *machine)
 {
 	maps__init(&mg->maps);
 	mg->machine = machine;
+	mg->last_search_by_name = NULL;
 	refcount_set(&mg->refcnt, 1);
 }
 
@@ -580,6 +581,14 @@ void map_groups__insert(struct map_groups *mg, struct map *map)
 	maps__insert(&mg->maps, map);
 }
 
+void map_groups__remove(struct map_groups *mg, struct map *map)
+{
+	if (mg->last_search_by_name == map)
+		mg->last_search_by_name = NULL;
+
+	maps__remove(&mg->maps, map);
+}
+
 static void __maps__purge(struct maps *maps)
 {
 	struct map *pos, *next;
diff --git a/tools/perf/util/map_groups.h b/tools/perf/util/map_groups.h
index 26fc68b..f2a3158 100644
--- a/tools/perf/util/map_groups.h
+++ b/tools/perf/util/map_groups.h
@@ -36,6 +36,7 @@ struct symbol *maps__find_symbol_by_name(struct maps *maps, const char *name, st
 struct map_groups {
 	struct maps	 maps;
 	struct machine	 *machine;
+	struct map	 *last_search_by_name;
 	refcount_t	 refcnt;
 #ifdef HAVE_LIBUNWIND_SUPPORT
 	void				*addr_space;
@@ -70,10 +71,7 @@ size_t map_groups__fprintf(struct map_groups *mg, FILE *fp);
 
 void map_groups__insert(struct map_groups *mg, struct map *map);
 
-static inline void map_groups__remove(struct map_groups *mg, struct map *map)
-{
-	maps__remove(&mg->maps, map);
-}
+void map_groups__remove(struct map_groups *mg, struct map *map);
 
 static inline struct map *map_groups__find(struct map_groups *mg, u64 addr)
 {
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 0fb9bd8..b146d87 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1767,9 +1767,16 @@ struct map *map_groups__find_by_name(struct map_groups *mg, const char *name)
 
 	down_read(&maps->lock);
 
+	if (mg->last_search_by_name && strcmp(mg->last_search_by_name->dso->short_name, name) == 0) {
+		map = mg->last_search_by_name;
+		goto out_unlock;
+	}
+
 	maps__for_each_entry(maps, map)
-		if (strcmp(map->dso->short_name, name) == 0)
+		if (strcmp(map->dso->short_name, name) == 0) {
+			mg->last_search_by_name = map;
 			goto out_unlock;
+		}
 
 	map = NULL;
 
