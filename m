Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CADC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 18:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9940E214E0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 18:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573583950;
	bh=SX0sscmtqcirWY9smAnEU8p8skfruOWEftotFi7hEDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qmmLE5fKN60ePNuYqrsIxJz7Qz5oYEWHLFrts9+bvhLtvnjDDq2J5Vd+A5IX4G734
	 HOEzoXFCd/MHE0zgnj/IsF7v1ZpZCvg0yOAMTGkNlx9Uc3cPFIb6khTZqkWVpFrq2Y
	 97JHvLFpCEiUujkIthj/EQbiwsSng7aS5ZunvRf8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfKLSjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 13:39:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:57080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726959AbfKLSjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 13:39:08 -0500
Received: from quaco.ghostprotocols.net (unknown [177.195.211.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAE6C20818;
        Tue, 12 Nov 2019 18:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573583947;
        bh=SX0sscmtqcirWY9smAnEU8p8skfruOWEftotFi7hEDo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b2sB7lUiXzYH9+aircYu8Y/I4sHIh/Fx5tlOab1RaLt77CNAUz1MwxmbAGxRIPGbi
         Z2h36gonMxCjYUAZkarCjjv5gJ9jlBvftZY8YArkYVqtvLCsfDsbeBNOeNOtkt07pc
         iiYRBThBZput9cz+uGliWcJb++ZfvLEk7pjKcXeo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 13/15] perf map: Remove ->groups from 'struct map'
Date:   Tue, 12 Nov 2019 15:37:55 -0300
Message-Id: <20191112183757.28660-14-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191112183757.28660-1-acme@kernel.org>
References: <20191112183757.28660-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
index 27d8508f8a44..359846833a00 100644
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
index c3614195ddc7..365deb6375ab 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -42,7 +42,6 @@ struct map {
 	u64			(*unmap_ip)(struct map *, u64);
 
 	struct dso		*dso;
-	struct map_groups	*groups;
 	refcount_t		refcnt;
 };
 
-- 
2.21.0

