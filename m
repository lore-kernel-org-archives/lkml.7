Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F8DC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 07:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB66520857
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 07:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfKOHlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 02:41:11 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42588 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfKOHkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 02:40:23 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iVWDG-0002Ve-Hp; Fri, 15 Nov 2019 08:40:14 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 30C881C08AC;
        Fri, 15 Nov 2019 08:40:14 +0100 (CET)
Date:   Fri, 15 Nov 2019 07:40:13 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf map: Combine maps__fixup_overlappings with its only use
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-e50eqtqw3za24vmbjnqmmcs6@git.kernel.org>
References: <tip-e50eqtqw3za24vmbjnqmmcs6@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157380361380.29467.9955626577114050046.tip-bot2@tip-bot2>
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

Commit-ID:     3f662fc08dddebd7bab654eada1f3e7568959eef
Gitweb:        https://git.kernel.org/tip/3f662fc08dddebd7bab654eada1f3e7568959eef
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Fri, 01 Nov 2019 17:53:02 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 12 Nov 2019 08:20:53 -03:00

perf map: Combine maps__fixup_overlappings with its only use

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
index 6c59f55..27d8508 100644
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
@@ -853,12 +854,6 @@ out:
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
