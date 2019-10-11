Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B475C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEFDB2247C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570824697;
	bh=KGR5DbLBQucy3Gvp5KXV1o9E289tGcMy301+8bgGsr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SaH8AsIEx2mFiYqsZ0z0zQ36ExXdSC57K7qBK0n/ki29E5DGhhqBIB39oXC/UIOc3
	 C2V/MFjNyJEDgrb9He9DXGm1HaoNBkeFvYuC8/AcsGPjL6lppBIgrOO3U8h+HXKE6E
	 52ESiAXQxZW1Hx47K/mCx9zWC+7Orblsf9H4Cx6c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbfJKULf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 16:11:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:47560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729806AbfJKUL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 16:11:28 -0400
Received: from quaco.ghostprotocols.net (189-94-137-67.3g.claro.net.br [189.94.137.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEAAA222C5;
        Fri, 11 Oct 2019 20:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570824687;
        bh=KGR5DbLBQucy3Gvp5KXV1o9E289tGcMy301+8bgGsr4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cFyUZn9jbMZCbMLFq5+jf2s2r1odhai+yn0ghMyjm/XbJU7Luh55RESshM4yjqmLf
         +/5cbwWyn/2MIEc/DAbarIu2Y82KctdFfpX9KUrzhObg0Qb0hU75fxmPP+5QucH6jo
         X24aC9BfIp0j0qZqxupKsKKTjzfpRF1uRBzlyGMY=
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
Subject: [PATCH 61/69] perf evlist: Introduce perf_evlist__mmap_cb_mmap()
Date:   Fri, 11 Oct 2019 17:05:51 -0300
Message-Id: <20191011200559.7156-62-acme@kernel.org>
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

Add the perf_evlist__mmap_cb_mmap() function to call perf specific
mmap__mmap() function during perf_evlist__mmap_ops() call.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191007125344.14268-21-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index f50ee5cb6554..d57b684b4b7b 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -773,6 +773,16 @@ perf_evlist__mmap_cb_get(struct perf_evlist *_evlist, bool overwrite, int idx)
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
@@ -970,8 +980,9 @@ int evlist__mmap_ex(struct evlist *evlist, unsigned int pages,
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

