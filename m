Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB42AECE58D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9F8920673
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570824690;
	bh=bCTevvkEOlTvOqmfcJPQBpLeipb2Bmuc+eOGNAO9M8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vzIwAIYvM8alaOQQAms2BnmnzDLR6dpfzpkWjNxVopqmuQAgWyLP9zU80zCR2yZX9
	 bYbL4Ik4AsBDfhCy1YKsmrIMPCZm+7J4leoKSrVTFeYKr2p9YjDPg7uj/ggdyYNCbM
	 Q/S14kRHoaN06QDwSQ+O6MIFklHDqaB5oeEbpoj8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729820AbfJKUL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 16:11:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:47468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729803AbfJKULY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 16:11:24 -0400
Received: from quaco.ghostprotocols.net (189-94-137-67.3g.claro.net.br [189.94.137.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B01D206CD;
        Fri, 11 Oct 2019 20:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570824684;
        bh=bCTevvkEOlTvOqmfcJPQBpLeipb2Bmuc+eOGNAO9M8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jIDH5mPRAuH/CDbs8h8/jgTDumaW7wUx2g6+eZWQaW6J2xLl5j1+A/XJ+TSPnTLCz
         vgr8SBwaWDKwfFz2t/O1sgIIHmCTdKb5sfSVAbadz5KSALxCn5JYk4Vxw+SciHEYSt
         tXJPL6G64QBxVMxlaVsKODVB9bYYUSqXGraq2pvM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 60/69] perf evlist: Introduce perf_evlist__mmap_cb_get()
Date:   Fri, 11 Oct 2019 17:05:50 -0300
Message-Id: <20191011200559.7156-61-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191011200559.7156-1-acme@kernel.org>
References: <20191011200559.7156-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add the perf_evlist__mmap_cb_get() function to return 'struct perf_mmap'
object during perf_evlist__mmap_ops() call.

The array of 'struct mmap' is allocated via evlist__alloc_mmap(), in
this callback we simply returns pointer to the base object.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191007125344.14268-20-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 11716f2b965a..f50ee5cb6554 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -750,6 +750,29 @@ perf_evlist__mmap_cb_idx(struct perf_evlist *_evlist,
 	auxtrace_mmap_params__set_idx(&mp->auxtrace_mp, evlist, idx, per_cpu);
 }
 
+static struct perf_mmap*
+perf_evlist__mmap_cb_get(struct perf_evlist *_evlist, bool overwrite, int idx)
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
@@ -948,6 +971,7 @@ int evlist__mmap_ex(struct evlist *evlist, unsigned int pages,
 	};
 	struct perf_evlist_mmap_ops ops __maybe_unused = {
 		.idx = perf_evlist__mmap_cb_idx,
+		.get = perf_evlist__mmap_cb_get,
 	};
 
 	if (!evlist->mmap)
-- 
2.21.0

