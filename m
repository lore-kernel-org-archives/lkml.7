Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8A1C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94323206A5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381181;
	bh=xEDa7I8Tpy/Ve9u1HG3lultDCwXHJzTiFS+0euzCpHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2S7ltqkrFPRtEH3+9RO1HBy9PA8lc6T/b15n8qOUjESkv+HfuGsVCsOlt14JeMa2k
	 8Dl0nobRYWtlzUOaSYRf0JRhUmBC6XN/Mq0gpZd57muQXLg8xUT9heMNP1KmGhGT/x
	 TXRf55gRUI92Fnvom0J77g2VemsAJfGY3pISpM9M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403776AbfIMN0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:26:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57234 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391556AbfIMN0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:26:19 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C71FF30860BD;
        Fri, 13 Sep 2019 13:26:18 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B54D95C1D4;
        Fri, 13 Sep 2019 13:26:16 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 57/73] perf tools: Add perf_evlist__mmap_cb_idx function
Date:   Fri, 13 Sep 2019 15:23:39 +0200
Message-Id: <20190913132355.21634-58-jolsa@kernel.org>
In-Reply-To: <20190913132355.21634-1-jolsa@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 13 Sep 2019 13:26:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding perf_evlist__mmap_cb_idx function to call
auxtrace_mmap_params__set_idx on each new index
during perf_evlist__mmap_ops call.

Link: http://lkml.kernel.org/n/tip-26emdgzve9miryyzvcr77qgh@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/evlist.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index a9fc35d25a59..850dacf7bf97 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -714,6 +714,17 @@ static int evlist__mmap_per_evsel(struct evlist *evlist, int idx,
 	return 0;
 }
 
+static void
+perf_evlist__mmap_cb_idx(struct perf_evlist *_evlist,
+			 struct perf_mmap_param *_mp,
+			 int idx, bool per_cpu)
+{
+	struct evlist *evlist = container_of(_evlist, struct evlist, core);
+	struct mmap_params *mp = container_of(_mp, struct mmap_params, core);
+
+	auxtrace_mmap_params__set_idx(&mp->auxtrace_mp, evlist, idx, per_cpu);
+}
+
 static int evlist__mmap_per_cpu(struct evlist *evlist,
 				     struct mmap_params *mp)
 {
@@ -910,6 +921,9 @@ int evlist__mmap_ex(struct evlist *evlist, unsigned int pages,
 		.flush		= flush,
 		.comp_level	= comp_level
 	};
+	struct perf_evlist_mmap_ops ops __maybe_unused = {
+		.idx = perf_evlist__mmap_cb_idx,
+	};
 
 	if (!evlist->mmap)
 		evlist->mmap = evlist__alloc_mmap(evlist, false);
-- 
2.21.0

