Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA88C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 18:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56A9120818
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 18:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573583906;
	bh=UJNprejzjFmWjN7e+kl6hqOPjJxyXt0+FXfanNdlNVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CSbFV0EMTkw66YdhcYI5UIbl4ZnUUFE1L5irmkxyVpVGqF8ofb1vXfI3/BnSg7vhq
	 fChJnNXI+vFnRhYPLIg7vVwEMYWXIBJIowIGwIUkqhAsTWdY0HYtYmktf6vwbRz25B
	 g7TFkWI6PIgROvJTcQRFE+9c1XSkZQI+UYwHxfKo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfKLSiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 13:38:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:56392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726912AbfKLSiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 13:38:22 -0500
Received: from quaco.ghostprotocols.net (unknown [177.195.211.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F47721872;
        Tue, 12 Nov 2019 18:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573583902;
        bh=UJNprejzjFmWjN7e+kl6hqOPjJxyXt0+FXfanNdlNVs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m+73rl5fsPkMJL+WHrV4JsGa3YzEmRTi68j07TjO6Z9cLMxbX+7UWquMSzFp1+hPg
         vtcZ+lhK1ET1zP+6Owh3ioixqdYL4v7lfHpLW7KxCQhm79oH0XUm698JqOD/GKesJ+
         Q24WgqtKowmhZnXjsoVdMSeAjUsyTl0EPvvmV1cM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 03/15] perf map_groups: Pass the object to map_groups__find_ams()
Date:   Tue, 12 Nov 2019 15:37:45 -0300
Message-Id: <20191112183757.28660-4-acme@kernel.org>
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
index a50e70baf918..20050fb54948 100644
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
index bee0fee122f8..ecc024495f56 100644
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
index a4d889c0fa88..db842568f4be 100644
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
index bfbdbf5a443a..99cb810acc7c 100644
--- a/tools/perf/util/map_groups.h
+++ b/tools/perf/util/map_groups.h
@@ -100,7 +100,7 @@ struct symbol *map_groups__find_symbol_by_name(struct map_groups *mg, const char
 
 struct addr_map_symbol;
 
-int map_groups__find_ams(struct addr_map_symbol *ams);
+int map_groups__find_ams(struct map_groups *mg, struct addr_map_symbol *ams);
 
 int map_groups__fixup_overlappings(struct map_groups *mg, struct map *map, FILE *fp);
 
-- 
2.21.0

