Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74AAC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBAD921D6C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570452876;
	bh=L4FldDIKHGogGwA/BVoiXiBHHpuTyhA8WBYnEKVFerc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nC7aHwh4mRoHeXkrXhKdtYjknmp10E7hKQq3UiYNDDW7xA8l230y2Pu325SZIral3
	 /M5NM+3J72Mmgxyc/77YrWAjQpm3LL6ich4Hxpvi4yHxxag9Gup1Hwavtr5UyH7/Hn
	 D6o/jJJhnjFMtbrP/UUzi68Or2j+GtMgHxbyYSVA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbfJGMyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 08:54:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44786 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727715AbfJGMyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:54:33 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 01D1C51EE1;
        Mon,  7 Oct 2019 12:54:33 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA8835D9CC;
        Mon,  7 Oct 2019 12:54:30 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 20/36] perf tools: Add perf_evlist__mmap_cb_mmap function
Date:   Mon,  7 Oct 2019 14:53:28 +0200
Message-Id: <20191007125344.14268-21-jolsa@kernel.org>
In-Reply-To: <20191007125344.14268-1-jolsa@kernel.org>
References: <20191007125344.14268-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 07 Oct 2019 12:54:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding perf_evlist__mmap_cb_mmap function to call perf
specific mmap__mmap function during perf_evlist__mmap_ops
call.

Link: http://lkml.kernel.org/n/tip-38lonlyp6kzfartpl20qy2dy@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/evlist.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index a59303de3421..e7216139f37a 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -749,6 +749,16 @@ perf_evlist__mmap_cb_get(struct perf_evlist *_evlist, bool overwrite, int idx)
 	return &maps[idx].core;
 }
 
+static int
+perf_evlist__mmap_cb_mmap(struct perf_mmap *_map, struct perf_mmap_param *_mp,
+			  int output, int cpu)
+{
+	struct mmap *map = container_of(_map, struct mmap, core);
+	struct mmap_params *mp = container_of(_mp, struct mmap_params, core);
+
+	return mmap__mmap(map, mp, output, cpu);
+}
+
 static int evlist__mmap_per_cpu(struct evlist *evlist,
 				     struct mmap_params *mp)
 {
@@ -946,8 +956,9 @@ int evlist__mmap_ex(struct evlist *evlist, unsigned int pages,
 		.comp_level	= comp_level
 	};
 	struct perf_evlist_mmap_ops ops __maybe_unused = {
-		.idx = perf_evlist__mmap_cb_idx,
-		.get = perf_evlist__mmap_cb_get,
+		.idx  = perf_evlist__mmap_cb_idx,
+		.get  = perf_evlist__mmap_cb_get,
+		.mmap = perf_evlist__mmap_cb_mmap,
 	};
 
 	if (!evlist->mmap)
-- 
2.21.0

