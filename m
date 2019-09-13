Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA2DC4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71563206A5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381185;
	bh=WpV7t9vdu04mRgVhHt44xqotUb51goPW34EdMjkLMoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PPjxJI4tP9s3vLdLNtxeeHHeXM40jFuPwpgxH81vxB7zI7ZY17Rz42kBvqrnknOji
	 cXRpdaltKad37PIA5MiuanklWlyINTP/XURYr/+OyTnA1xAvL7ZlaREGSKaiSFtLjK
	 gtC7u5DCpjEcMNKOjAms8yx88PEKiVKdzQpN6h7E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403789AbfIMN0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:26:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49726 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403778AbfIMN0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:26:21 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 40F94308A9E2;
        Fri, 13 Sep 2019 13:26:21 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1F99D5C1D4;
        Fri, 13 Sep 2019 13:26:18 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 58/73] perf tools: Add perf_evlist__mmap_cb_new function
Date:   Fri, 13 Sep 2019 15:23:40 +0200
Message-Id: <20190913132355.21634-59-jolsa@kernel.org>
In-Reply-To: <20190913132355.21634-1-jolsa@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Fri, 13 Sep 2019 13:26:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding perf_evlist__mmap_cb_new function to return 'struct perf_mmap'
object during perf_evlist__mmap_ops call.

The array of 'struct mmap' is allocated via evlist__alloc_mmap,
in this callback we simply returns pointer to the base object.

Link: http://lkml.kernel.org/n/tip-tiyl8aymuk3fv9j033yo8d1v@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/evlist.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 850dacf7bf97..52a6af91e877 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -725,6 +725,29 @@ perf_evlist__mmap_cb_idx(struct perf_evlist *_evlist,
 	auxtrace_mmap_params__set_idx(&mp->auxtrace_mp, evlist, idx, per_cpu);
 }
 
+static struct perf_mmap*
+perf_evlist__mmap_cb_new(struct perf_evlist *_evlist, bool overwrite, int idx)
+{
+	struct evlist *evlist = container_of(_evlist, struct evlist, core);
+	struct mmap *maps = evlist->mmap;
+
+	if (overwrite) {
+		maps = evlist->overwrite_mmap;
+
+		if (!maps) {
+			maps = evlist__alloc_mmap(evlist, true);
+			if (!maps)
+				return NULL;
+
+			evlist->overwrite_mmap = maps;
+			if (evlist->bkw_mmap_state == BKW_MMAP_NOTREADY)
+				perf_evlist__toggle_bkw_mmap(evlist, BKW_MMAP_RUNNING);
+		}
+	}
+
+	return &maps[idx].core;
+}
+
 static int evlist__mmap_per_cpu(struct evlist *evlist,
 				     struct mmap_params *mp)
 {
@@ -923,6 +946,7 @@ int evlist__mmap_ex(struct evlist *evlist, unsigned int pages,
 	};
 	struct perf_evlist_mmap_ops ops __maybe_unused = {
 		.idx = perf_evlist__mmap_cb_idx,
+		.new = perf_evlist__mmap_cb_new,
 	};
 
 	if (!evlist->mmap)
-- 
2.21.0

