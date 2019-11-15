Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C55C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 07:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7595F20857
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 07:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfKOHkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 02:40:33 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42622 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbfKOHk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 02:40:28 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iVWDO-0002Zc-03; Fri, 15 Nov 2019 08:40:22 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7451A1C18CD;
        Fri, 15 Nov 2019 08:40:18 +0100 (CET)
Date:   Fri, 15 Nov 2019 07:40:18 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf map_groups: Pass the object to map_groups__find_ams()
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-nmi2pbggqloogwl6vxrvex5a@git.kernel.org>
References: <tip-nmi2pbggqloogwl6vxrvex5a@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157380361808.29467.1347672115478756281.tip-bot2@tip-bot2>
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

Commit-ID:     9d355b381b35be1ac4e77600d6b9b27c674c5d5f
Gitweb:        https://git.kernel.org/tip/9d355b381b35be1ac4e77600d6b9b27c674c5d5f
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 04 Nov 2019 10:14:05 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 12 Nov 2019 08:20:53 -03:00

perf map_groups: Pass the object to map_groups__find_ams()

We were just passing a map to look for and reuse its map->groups member,
but the idea is that this is going away, as a map can be in multiple
rb_trees when being reused via a map_node, so do as all the other
map_groups methods and pass as its first arg the object being operated
on.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-nmi2pbggqloogwl6vxrvex5a@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/s390/annotate/instructions.c | 2 +-
 tools/perf/util/annotate.c                   | 6 +++---
 tools/perf/util/map.c                        | 6 +++---
 tools/perf/util/map_groups.h                 | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/arch/s390/annotate/instructions.c b/tools/perf/arch/s390/annotate/instructions.c
index a50e70b..20050fb 100644
--- a/tools/perf/arch/s390/annotate/instructions.c
+++ b/tools/perf/arch/s390/annotate/instructions.c
@@ -38,7 +38,7 @@ static int s390_call__parse(struct arch *arch, struct ins_operands *ops,
 		return -1;
 	target.addr = map__objdump_2mem(map, ops->target.addr);
 
-	if (map_groups__find_ams(&target) == 0 &&
+	if (map_groups__find_ams(map->groups, &target) == 0 &&
 	    map__rip_2objdump(target.map, map->map_ip(target.map, target.addr)) == ops->target.addr)
 		ops->target.sym = target.sym;
 
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index bee0fee..ecc0244 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -271,7 +271,7 @@ static int call__parse(struct arch *arch, struct ins_operands *ops, struct map_s
 find_target:
 	target.addr = map__objdump_2mem(map, ops->target.addr);
 
-	if (map_groups__find_ams(&target) == 0 &&
+	if (map_groups__find_ams(map->groups, &target) == 0 &&
 	    map__rip_2objdump(target.map, map->map_ip(target.map, target.addr)) == ops->target.addr)
 		ops->target.sym = target.sym;
 
@@ -391,7 +391,7 @@ static int jump__parse(struct arch *arch, struct ins_operands *ops, struct map_s
 	 * Actual navigation will come next, with further understanding of how
 	 * the symbol searching and disassembly should be done.
 	 */
-	if (map_groups__find_ams(&target) == 0 &&
+	if (map_groups__find_ams(map->groups, &target) == 0 &&
 	    map__rip_2objdump(target.map, map->map_ip(target.map, target.addr)) == ops->target.addr)
 		ops->target.sym = target.sym;
 
@@ -1544,7 +1544,7 @@ static int symbol__parse_objdump_line(struct symbol *sym,
 			.addr = dl->ops.target.addr,
 		};
 
-		if (!map_groups__find_ams(&target) &&
+		if (!map_groups__find_ams(map->groups, &target) &&
 		    target.sym->start == target.al_addr)
 			dl->ops.target.sym = target.sym;
 	}
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index a4d889c..db84256 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -703,12 +703,12 @@ struct symbol *map_groups__find_symbol_by_name(struct map_groups *mg,
 	return maps__find_symbol_by_name(&mg->maps, name, mapp);
 }
 
-int map_groups__find_ams(struct addr_map_symbol *ams)
+int map_groups__find_ams(struct map_groups *mg, struct addr_map_symbol *ams)
 {
 	if (ams->addr < ams->map->start || ams->addr >= ams->map->end) {
-		if (ams->map->groups == NULL)
+		if (mg == NULL)
 			return -1;
-		ams->map = map_groups__find(ams->map->groups, ams->addr);
+		ams->map = map_groups__find(mg, ams->addr);
 		if (ams->map == NULL)
 			return -1;
 	}
diff --git a/tools/perf/util/map_groups.h b/tools/perf/util/map_groups.h
index bfbdbf5..99cb810 100644
--- a/tools/perf/util/map_groups.h
+++ b/tools/perf/util/map_groups.h
@@ -100,7 +100,7 @@ struct symbol *map_groups__find_symbol_by_name(struct map_groups *mg, const char
 
 struct addr_map_symbol;
 
-int map_groups__find_ams(struct addr_map_symbol *ams);
+int map_groups__find_ams(struct map_groups *mg, struct addr_map_symbol *ams);
 
 int map_groups__fixup_overlappings(struct map_groups *mg, struct map *map, FILE *fp);
 
