Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31016C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 18:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0982121872
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 18:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573583945;
	bh=uFc1QOcfcC5upocJ+L5CTB117u3aYYC/uWiThFDlE78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JfiqQ/wlazP0f3cGHcrl3HEzocJLRDg3ZEisK9+5IxHviwKlcCaPvo+ozQXegwsCU
	 gT9ZwwUHDbNkTcixM0kSlSVpe/h3B4zC/EUEPAh5c9/WX/Z/QefFCIFWPSSaDI6VyU
	 lGEfDdzrO+FDt51QgTLNdua7iDtIaLPWoAo+1/jo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbfKLSjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 13:39:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:57014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727049AbfKLSjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 13:39:03 -0500
Received: from quaco.ghostprotocols.net (unknown [177.195.211.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FF4B214E0;
        Tue, 12 Nov 2019 18:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573583942;
        bh=uFc1QOcfcC5upocJ+L5CTB117u3aYYC/uWiThFDlE78=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b0Mpsg6MRzW6cgVDFwpsdn142XXQthvgj6vatZSclLvRFwvkbX1CEHNEroTL7vRJ4
         u32OIWs/YWbZ2IIDbMX7R2WQ1gyres/w16prUHz+H0lKhR4WLtqL+3DEiXa2U0hzA/
         aFu9RgP89oZAi06pLhM+JCorrrBj6lGopgMzha3Y=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 12/15] perf map: Combine maps__fixup_overlappings with its only use
Date:   Tue, 12 Nov 2019 15:37:54 -0300
Message-Id: <20191112183757.28660-13-acme@kernel.org>
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

In the process we can kill some of the struct map->groups usage, trying
to get rid of this per-full struct map fields getting in the way of
sharing a map across father/parent processes.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-e50eqtqw3za24vmbjnqmmcs6@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 6c59f55026c1..27d8508f8a44 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -752,8 +752,9 @@ static void __map_groups__insert(struct map_groups *mg, struct map *map)
 	map->groups = mg;
 }
 
-static int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
+int map_groups__fixup_overlappings(struct map_groups *mg, struct map *map, FILE *fp)
 {
+	struct maps *maps = &mg->maps;
 	struct rb_root *root;
 	struct rb_node *next, *first;
 	int err = 0;
@@ -818,7 +819,7 @@ static int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp
 			}
 
 			before->end = map->start;
-			__map_groups__insert(pos->groups, before);
+			__map_groups__insert(mg, before);
 			if (verbose >= 2 && !use_browser)
 				map__fprintf(before, fp);
 			map__put(before);
@@ -835,7 +836,7 @@ static int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp
 			after->start = map->end;
 			after->pgoff += map->end - pos->start;
 			assert(pos->map_ip(pos, map->end) == after->map_ip(after, map->end));
-			__map_groups__insert(pos->groups, after);
+			__map_groups__insert(mg, after);
 			if (verbose >= 2 && !use_browser)
 				map__fprintf(after, fp);
 			map__put(after);
@@ -853,12 +854,6 @@ static int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp
 	return err;
 }
 
-int map_groups__fixup_overlappings(struct map_groups *mg, struct map *map,
-				   FILE *fp)
-{
-	return maps__fixup_overlappings(&mg->maps, map, fp);
-}
-
 /*
  * XXX This should not really _copy_ te maps, but refcount them.
  */
-- 
2.21.0

