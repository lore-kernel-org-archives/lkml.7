Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2608ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8B38205F4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570452873;
	bh=uSM5B/vFWdY+o3kS+kUSPs2F460bgWJ47dYQt0geopE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lfrmR+lDQMfb0IyRe5FUyHFB8jzjVKPtx4g15dfsht9B3PAr8JgynhRaPzpgE2DlS
	 VGBNUUuunVOlkbUbymuTGYlYfbjW15+MNmWR/9WJnmQsJTpMow0FCPQok+dBsFi+kM
	 guDYoFgbtaBfBq0d4yIYJ2523FBTt8PDJW2wIk88=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbfJGMyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 08:54:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48984 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727715AbfJGMya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:54:30 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 61364308FBA6;
        Mon,  7 Oct 2019 12:54:30 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1DC6E5D9CC;
        Mon,  7 Oct 2019 12:54:27 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 19/36] perf tools: Add perf_evlist__mmap_cb_get function
Date:   Mon,  7 Oct 2019 14:53:27 +0200
Message-Id: <20191007125344.14268-20-jolsa@kernel.org>
In-Reply-To: <20191007125344.14268-1-jolsa@kernel.org>
References: <20191007125344.14268-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 07 Oct 2019 12:54:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding perf_evlist__mmap_cb_get function to return 'struct perf_mmap'
object during perf_evlist__mmap_ops call.

The array of 'struct mmap' is allocated via evlist__alloc_mmap,
in this callback we simply returns pointer to the base object.

Link: http://lkml.kernel.org/n/tip-tiyl8aymuk3fv9j033yo8d1v@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/evlist.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 71fdc6c92920..a59303de3421 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -726,6 +726,29 @@ perf_evlist__mmap_cb_idx(struct perf_evlist *_evlist,
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
@@ -924,6 +947,7 @@ int evlist__mmap_ex(struct evlist *evlist, unsigned int pages,
 	};
 	struct perf_evlist_mmap_ops ops __maybe_unused = {
 		.idx = perf_evlist__mmap_cb_idx,
+		.get = perf_evlist__mmap_cb_get,
 	};
 
 	if (!evlist->mmap)
-- 
2.21.0

