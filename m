Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD21C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 07:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D94A20857
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 07:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbfKOHkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 02:40:36 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42620 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbfKOHk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 02:40:27 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iVWDG-0002Vb-3F; Fri, 15 Nov 2019 08:40:14 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id AFF551C18CD;
        Fri, 15 Nov 2019 08:40:13 +0100 (CET)
Date:   Fri, 15 Nov 2019 07:40:13 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf map: Remove ->groups from 'struct map'
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-ymlv3nzpofv2fugnjnizkrwy@git.kernel.org>
References: <tip-ymlv3nzpofv2fugnjnizkrwy@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157380361326.29467.15056834595261302192.tip-bot2@tip-bot2>
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

Commit-ID:     7b018e298752b9bcaf34eba8e1d3c08e3207dfd8
Gitweb:        https://git.kernel.org/tip/7b018e298752b9bcaf34eba8e1d3c08e3207dfd8
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 04 Nov 2019 16:55:53 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 12 Nov 2019 08:20:53 -03:00

perf map: Remove ->groups from 'struct map'

With this 'struct map' uses a bit over 3 cachelines:

  $ pahole -C map ~/bin/perf
  <SNIP>
  	/* --- cacheline 2 boundary (128 bytes) --- */
  	u64                        (*unmap_ip)(struct map *, u64); /*   128     8 */
  	struct dso *               dso;                            /*   136     8 */
  	refcount_t                 refcnt;                         /*   144     4 */

  	/* size: 152, cachelines: 3, members: 18 */
  	/* sum members: 145, holes: 1, sum holes: 3 */
  	/* padding: 4 */
  	/* forced alignments: 2 */
  	/* last cacheline: 24 bytes */
  } __attribute__((__aligned__(8)));
  $

We probably can move map->map/unmap_ip() moved to 'struct map_groups',
that will shave more 16 bytes, getting this almost to two cachelines.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-ymlv3nzpofv2fugnjnizkrwy@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.c | 4 ----
 tools/perf/util/map.h | 1 -
 2 files changed, 5 deletions(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 27d8508..3598468 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -140,7 +140,6 @@ void map__init(struct map *map, u64 start, u64 end, u64 pgoff, struct dso *dso)
 	map->map_ip   = map__map_ip;
 	map->unmap_ip = map__unmap_ip;
 	RB_CLEAR_NODE(&map->rb_node);
-	map->groups   = NULL;
 	map->erange_warned = false;
 	refcount_set(&map->refcnt, 1);
 }
@@ -388,7 +387,6 @@ struct map *map__clone(struct map *from)
 		refcount_set(&map->refcnt, 1);
 		RB_CLEAR_NODE(&map->rb_node);
 		dso__get(map->dso);
-		map->groups = NULL;
 	}
 
 	return map;
@@ -582,7 +580,6 @@ void map_groups__init(struct map_groups *mg, struct machine *machine)
 void map_groups__insert(struct map_groups *mg, struct map *map)
 {
 	maps__insert(&mg->maps, map);
-	map->groups = mg;
 }
 
 static void __maps__purge(struct maps *maps)
@@ -749,7 +746,6 @@ static void __map_groups__insert(struct map_groups *mg, struct map *map)
 {
 	__maps__insert(&mg->maps, map);
 	__maps__insert_name(&mg->maps, map);
-	map->groups = mg;
 }
 
 int map_groups__fixup_overlappings(struct map_groups *mg, struct map *map, FILE *fp)
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index c361419..365deb6 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -42,7 +42,6 @@ struct map {
 	u64			(*unmap_ip)(struct map *, u64);
 
 	struct dso		*dso;
-	struct map_groups	*groups;
 	refcount_t		refcnt;
 };
 
