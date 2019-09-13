Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65006C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C99D20640
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381273;
	bh=gj/EHfCKh9y+MAAULJh8EA852vPBEUCJ1C1pzh7oDow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zgMzYVuLSROlAmDJK7mcdM4uuCoHXL2WgIHcn+DG8wgHp556CGC4Z2x/0JDNMcMZ9
	 3qhfc+2CWJ5cHlt62k6EMYmPVLdUc7BVIsBCsP1Yj2yQg87XJ2FDeqmgv8vYoNDu1C
	 3aEynH6m9YpGqm8nA2pa6eYHKRHh4bXL7T/k5nT8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391475AbfIMNZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:25:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51504 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390602AbfIMNZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:25:55 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1A8E43023080;
        Fri, 13 Sep 2019 13:25:55 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 74A1B5C1D4;
        Fri, 13 Sep 2019 13:25:53 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 47/73] perf tools: Use perf_mmap way to detect aux mmap
Date:   Fri, 13 Sep 2019 15:23:29 +0200
Message-Id: <20190913132355.21634-48-jolsa@kernel.org>
In-Reply-To: <20190913132355.21634-1-jolsa@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Fri, 13 Sep 2019 13:25:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will move this code into libperf shortly, so we
need to free it of 'struct auxtrace_mmap' usage,
because it won't be available in libperf (for now).

The perf_event_mmap_page::aux_size is set when the
aux mmap is mapped, so the check is equivalent.

Link: http://lkml.kernel.org/n/tip-nmj5fchj8wdglxj7d1voxj66@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/mmap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index b904a7a57fdf..4b1d1ae79042 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -106,7 +106,9 @@ union perf_event *perf_mmap__read_event(struct mmap *map)
 
 static bool perf_mmap__empty(struct mmap *map)
 {
-	return perf_mmap__read_head(map) == map->core.prev && !map->auxtrace_mmap.base;
+	struct perf_event_mmap_page *pc = map->core.base;
+
+	return perf_mmap__read_head(map) == map->core.prev && !pc->aux_size;
 }
 
 void perf_mmap__consume(struct mmap *map)
-- 
2.21.0

