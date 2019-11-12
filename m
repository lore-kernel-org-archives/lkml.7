Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE21C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 18:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 743F620818
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 18:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573583936;
	bh=p4W3epR6DXJhz9ZvcgdUpg51+8RaTMiuVkncy6GbUuE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DlLs3M9mNbuGalenTB3poS4YY430M5djGcJ+6dNkIt6kwJD+kFBe/q9raoKw1VPCw
	 HHAKhS61Z6QaoTeNp6RgnJis4uTdKVxJdOjH6CTlcZ6VHGQ77Q+jJOHtH5FdB76znY
	 9igaX+tLK7CeSivoQ2gry4dn3yALcYpXyKOL9qzQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbfKLSiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 13:38:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:56908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727049AbfKLSix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 13:38:53 -0500
Received: from quaco.ghostprotocols.net (unknown [177.195.211.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57DBF21783;
        Tue, 12 Nov 2019 18:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573583932;
        bh=p4W3epR6DXJhz9ZvcgdUpg51+8RaTMiuVkncy6GbUuE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=faX+VzeXIsx0Ep46SRbRO/iiGixl4GblZ0GqhijLQrcGetvRRYW4hU8zQIAJNzOUU
         CN2zWOvxXBQ17zszysnZEJ9vynVXIU8jz2E7+0HE7+ylccKbSy0IoGXQD3MlYtxpu1
         7DRnin6RNHx8g3wzUabCmZtW8xK5HduY7WX3Bd5o=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 11/15] perf annotate: Stop using map->groups, use map_symbol->mg instead
Date:   Tue, 12 Nov 2019 15:37:53 -0300
Message-Id: <20191112183757.28660-12-acme@kernel.org>
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

These were the last uses of map->groups, next cset will nuke it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-n3g0foos7l7uxq9nar0zo0vj@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/s390/annotate/instructions.c | 2 +-
 tools/perf/ui/browsers/annotate.c            | 1 +
 tools/perf/util/annotate.c                   | 6 +++---
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/arch/s390/annotate/instructions.c b/tools/perf/arch/s390/annotate/instructions.c
index bdd7ab34ce4f..2a6662e42f89 100644
--- a/tools/perf/arch/s390/annotate/instructions.c
+++ b/tools/perf/arch/s390/annotate/instructions.c
@@ -38,7 +38,7 @@ static int s390_call__parse(struct arch *arch, struct ins_operands *ops,
 		return -1;
 	target.addr = map__objdump_2mem(map, ops->target.addr);
 
-	if (map_groups__find_ams(map->groups, &target) == 0 &&
+	if (map_groups__find_ams(ms->mg, &target) == 0 &&
 	    map__rip_2objdump(target.ms.map, map->map_ip(target.ms.map, target.addr)) == ops->target.addr)
 		ops->target.sym = target.ms.sym;
 
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index ad1fe5b6d0cd..992705c78bd0 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -430,6 +430,7 @@ static bool annotate_browser__callq(struct annotate_browser *browser,
 		return true;
 	}
 
+	target_ms.mg  = ms->mg;
 	target_ms.map = ms->map;
 	target_ms.sym = dl->ops.target.sym;
 	pthread_mutex_unlock(&notes->lock);
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index e0a9e9e49bb1..5ea9a4534848 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -271,7 +271,7 @@ static int call__parse(struct arch *arch, struct ins_operands *ops, struct map_s
 find_target:
 	target.addr = map__objdump_2mem(map, ops->target.addr);
 
-	if (map_groups__find_ams(map->groups, &target) == 0 &&
+	if (map_groups__find_ams(ms->mg, &target) == 0 &&
 	    map__rip_2objdump(target.ms.map, map->map_ip(target.ms.map, target.addr)) == ops->target.addr)
 		ops->target.sym = target.ms.sym;
 
@@ -391,7 +391,7 @@ static int jump__parse(struct arch *arch, struct ins_operands *ops, struct map_s
 	 * Actual navigation will come next, with further understanding of how
 	 * the symbol searching and disassembly should be done.
 	 */
-	if (map_groups__find_ams(map->groups, &target) == 0 &&
+	if (map_groups__find_ams(ms->mg, &target) == 0 &&
 	    map__rip_2objdump(target.ms.map, map->map_ip(target.ms.map, target.addr)) == ops->target.addr)
 		ops->target.sym = target.ms.sym;
 
@@ -1545,7 +1545,7 @@ static int symbol__parse_objdump_line(struct symbol *sym,
 			.ms = { .map = map, },
 		};
 
-		if (!map_groups__find_ams(map->groups, &target) &&
+		if (!map_groups__find_ams(args->ms.mg, &target) &&
 		    target.ms.sym->start == target.al_addr)
 			dl->ops.target.sym = target.ms.sym;
 	}
-- 
2.21.0

