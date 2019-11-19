Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F73C43141
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 11:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC09F22311
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 11:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574163210;
	bh=+W1vnl8OetME72wyr9X1YEE3rzSVpKf6jYabBvHlC7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ODOXHMDucYp9jnqiW4nGXlKOqGhoKnTzNIaDDlNZzeFOuS+I3lgscp23Nsp1wLNbh
	 bR9B+jS2PGEByjBjMfW1CnUIbnpw8xPHrc7vQYJk8Do5U5dNVMfP0LCzJQ8DzSHqWB
	 jDZhUZurkRhuO1BzJ08BfgBmbl2ewJ0pwcn79hLI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbfKSLd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 06:33:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:47204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727504AbfKSLd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 06:33:28 -0500
Received: from quaco.ghostprotocols.net (179.176.11.138.dynamic.adsl.gvt.net.br [179.176.11.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11D1422316;
        Tue, 19 Nov 2019 11:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574163206;
        bh=+W1vnl8OetME72wyr9X1YEE3rzSVpKf6jYabBvHlC7s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FIvEgXBi/jgMWmdcADly+1inFzfb19UMcELAcY1pjp9ayY/uoJmWfZGPPeRh+NOTA
         pJj6cJC7tzTqtqy3YRvCfLzoHqxaNv9Op8ksnsEivkpFauYzhMgx4c9IFz2qM5Ka2J
         fe+fL6es4FpSA/pzU8nI4o2cT4nrS2Z/8NOR9fPM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 07/25] perf map_groups: Add a front end cache for map lookups by name
Date:   Tue, 19 Nov 2019 08:32:27 -0300
Message-Id: <20191119113245.19593-8-acme@kernel.org>
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
 tools/perf/util/map.c        | 9 +++++++++
 tools/perf/util/map_groups.h | 6 ++----
 tools/perf/util/symbol.c     | 9 ++++++++-
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 49e353eaa337..d0899df77baa 100644
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
index 26fc68bd4f60..f2a3158572eb 100644
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
index 0fb9bd8bcf0d..b146d87176e7 100644
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
 
-- 
2.21.0

