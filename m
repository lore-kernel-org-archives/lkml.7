Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B66C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08DE0214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=netflix.com header.i=@netflix.com header.b="LyIeA2xa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733037AbfLKQHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 11:07:55 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45036 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387491AbfLKQHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 11:07:49 -0500
Received: by mail-pf1-f194.google.com with SMTP id d199so2012751pfd.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 08:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netflix.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=3m2cv863s8gDC9b4gczbkHnW6KALvnxLaZRbbOr5EDY=;
        b=LyIeA2xaZWzOA7roATJ7wOnCVKwtKgpBO3VoMArqM2ym3/ANWTerF07FYN2TV3cOsG
         eRpqJmnsND8zVybXKxatKjjHq9LF0sOb234twkZ1eVyWHSisv4QIxcCSrkOdN+gT672r
         WLRVQlDYhV1mJX0yRCItRpJx6P97jrR6GwTqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3m2cv863s8gDC9b4gczbkHnW6KALvnxLaZRbbOr5EDY=;
        b=HdT22wYEPOrNynaSSBUed6HZcBprBl8g8kqqJmHp5QpO13W/cn+o3K69JNOEOvE9+V
         5fLfnquecKj/02b8vmfUKW2VDwkMebM7bGuYA6NNJUq16vOQWWtCnA7BvnvVQSSoYeHw
         RmqD6B85/kWQh1J5ddAvHlhL6Rh57f7Q/Pv7+CFQoRnt3g7SWMErOlz4ap1O40zq4XiC
         rq5xQpkEILC7/DCMkfl1VrN7AikwqRO+4i8YRjdONSdhmgZ6vnOJ9QajyUEOkJ1tNp1Z
         hNJ/P9zNcnJRTf7ADYy1R782eyGqjCok/FpyZD566ZldUPrJZKOwlCOTbBkj/r9/d2OD
         L7fA==
X-Gm-Message-State: APjAAAXI6ryRGN9PMzzbrfHdu0kOrJG99YXM1dkHiEPnN99x7ynCxIN6
        O/STcxlM2EZVBlzneu8ClaSN4A==
X-Google-Smtp-Source: APXvYqwid8x3Q9/FYkWqmBmg2Ic0uiKvx9kozxuCJzOmp9sPbJRrH2eVEj44LbX1eUPAMbNlnPgn3Q==
X-Received: by 2002:a65:66d7:: with SMTP id c23mr5140529pgw.40.1576080468679;
        Wed, 11 Dec 2019 08:07:48 -0800 (PST)
Received: from laul-mmarchini.netflix.com ([207.38.45.92])
        by smtp.gmail.com with ESMTPSA id s60sm3079280pjb.3.2019.12.11.08.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 08:07:48 -0800 (PST)
From:   Matheus Marchini <mmarchini@netflix.com>
To:     linux-perf-users@vger.kernel.org
Cc:     jkoch@netflix.com, khlebnikov@yandex-team.ru,
        Matheus Marchini <mmarchini@netflix.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Changbin Du <changbin.du@intel.com>,
        Song Liu <songliubraving@fb.com>,
        John Keeping <john@metanate.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] perf map: fix infinite loop on map_groups__fixup_overlappings
Date:   Wed, 11 Dec 2019 08:07:31 -0800
Message-Id: <20191211160734.18087-1-mmarchini@netflix.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases, when using perf inject and there are JIT_CODE_MOVE
records in the jitdump file, perf will end up in an infinite loop on
map_groups__fixup_overlappings, which will keep allocating memory
indefinitely. This issue was observed on Node.js (with changes to
generate JIT_CODE_MOVE records) and on Java.

This issue started to occur after 6a9405b56c274 (perf map:
Optimize maps__fixup_overlappings()). To prevent it from happening,
partially revert those changes without losing the optimizations
introduced in it.

Signed-off-by: Matheus Marchini <mmarchini@netflix.com>
---
 tools/perf/util/map.c | 17 +++++++++++++++++
 tools/perf/util/map.h |  1 +
 2 files changed, 18 insertions(+)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 744bfbaf35cf..8918fdb8ddab 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -781,6 +781,21 @@ static void __map_groups__insert(struct map_groups *mg, struct map *map)
 	__maps__insert(&mg->maps, map);
 }
 
+int map__overlap(struct map *l, struct map *r)
+{
+	if (l->start > r->start) {
+		struct map *t = l;
+
+		l = r;
+		r = t;
+	}
+
+	if (l->end > r->start)
+		return 1;
+
+	return 0;
+}
+
 int map_groups__fixup_overlappings(struct map_groups *mg, struct map *map, FILE *fp)
 {
 	struct maps *maps = &mg->maps;
@@ -821,6 +836,8 @@ int map_groups__fixup_overlappings(struct map_groups *mg, struct map *map, FILE
 		 */
 		if (pos->start >= map->end)
 			break;
+		if (!map__overlap(map, pos))
+			continue;
 
 		if (verbose >= 2) {
 
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 5e8899883231..1383571437aa 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -132,6 +132,7 @@ static inline void __map__zput(struct map **map)
 
 #define map__zput(map) __map__zput(&map)
 
+int map__overlap(struct map *l, struct map *r);
 size_t map__fprintf(struct map *map, FILE *fp);
 size_t map__fprintf_dsoname(struct map *map, FILE *fp);
 char *map__srcline(struct map *map, u64 addr, struct symbol *sym);
-- 
2.17.1

