Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84859C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B018206A5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381172;
	bh=4URZ7cVpSL96FbdDARqsoOLzNgUaBl5KhGHax/usFv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ag1DRdU2D548T5z7Di9QX/D3Awpqo7PydVAWdSL+FLozrY3o4gmqts8EYXX/y7ocv
	 2P4r1uosSC/XcnCrLxvdDpIeAW9zZMFfjLZ/uYmcsIanPd058vu9m8ZzUbhCaEOO9/
	 x+xro4aKOpOvW1y8bsqRROE4ZO5cLteXxf9qS9e0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390702AbfIMN0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:26:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36412 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391511AbfIMN0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:26:09 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B49FB300BEA4;
        Fri, 13 Sep 2019 13:26:08 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 19B8D5C1D4;
        Fri, 13 Sep 2019 13:26:06 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 53/73] libperf: Add perf_evlist__mmap_ops function
Date:   Fri, 13 Sep 2019 15:23:35 +0200
Message-Id: <20190913132355.21634-54-jolsa@kernel.org>
In-Reply-To: <20190913132355.21634-1-jolsa@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 13 Sep 2019 13:26:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To be able to pass specific callbacks to evlist's mmap.
There will be specific call to this function from perf's
evlist_mmap and libperf's perf_evlist__mmap functions in
following changes.

Link: http://lkml.kernel.org/n/tip-mjpp6cdpckq2yj52tpab1eq6@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/evlist.c                  | 28 +++++++++++++++++-------
 tools/perf/lib/include/internal/evlist.h |  8 +++++++
 2 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index 168bc5d0a1c8..0f103c10d8ca 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -443,15 +443,16 @@ mmap_per_cpu(struct perf_evlist *evlist, struct perf_mmap_param *mp)
 	return -1;
 }
 
-int perf_evlist__mmap(struct perf_evlist *evlist, int pages)
+int perf_evlist__mmap_ops(struct perf_evlist *evlist,
+			  struct perf_evlist_mmap_ops *ops,
+			  struct perf_mmap_param *mp)
 {
 	struct perf_evsel *evsel;
 	const struct perf_cpu_map *cpus = evlist->cpus;
 	const struct perf_thread_map *threads = evlist->threads;
-	struct perf_mmap_param mp;
 
-	if (!evlist->mmap && perf_evlist__alloc_maps(evlist))
-		return -ENOMEM;
+	if (!ops)
+		return -EINVAL;
 
 	perf_evlist__for_each_entry(evlist, evsel) {
 		if ((evsel->attr.read_format & PERF_FORMAT_ID) &&
@@ -460,13 +461,24 @@ int perf_evlist__mmap(struct perf_evlist *evlist, int pages)
 			return -ENOMEM;
 	}
 
+	if (perf_cpu_map__empty(cpus))
+		return mmap_per_thread(evlist, mp);
+
+	return mmap_per_cpu(evlist, mp);
+}
+
+int perf_evlist__mmap(struct perf_evlist *evlist, int pages)
+{
+	struct perf_mmap_param mp;
+	struct perf_evlist_mmap_ops ops;
+
+	if (!evlist->mmap && perf_evlist__alloc_maps(evlist))
+		return -ENOMEM;
+
 	evlist->mmap_len = (pages + 1) * page_size;
 	mp.mask = evlist->mmap_len - page_size - 1;
 
-	if (perf_cpu_map__empty(cpus))
-		return mmap_per_thread(evlist, &mp);
-
-	return mmap_per_cpu(evlist, &mp);
+	return perf_evlist__mmap_ops(evlist, &ops, &mp);
 }
 
 void perf_evlist__munmap(struct perf_evlist *evlist)
diff --git a/tools/perf/lib/include/internal/evlist.h b/tools/perf/lib/include/internal/evlist.h
index b136d1b4ea72..5a8706a81c0d 100644
--- a/tools/perf/lib/include/internal/evlist.h
+++ b/tools/perf/lib/include/internal/evlist.h
@@ -11,6 +11,7 @@
 
 struct perf_cpu_map;
 struct perf_thread_map;
+struct perf_mmap_param;
 
 struct perf_evlist {
 	struct list_head	 entries;
@@ -26,10 +27,17 @@ struct perf_evlist {
 	struct perf_mmap	**mmap_ovw;
 };
 
+struct perf_evlist_mmap_ops {
+};
+
 int perf_evlist__alloc_pollfd(struct perf_evlist *evlist);
 int perf_evlist__add_pollfd(struct perf_evlist *evlist, int fd,
 			    void *ptr, short revent);
 
+int perf_evlist__mmap_ops(struct perf_evlist *evlist,
+			  struct perf_evlist_mmap_ops *ops,
+			  struct perf_mmap_param *mp);
+
 /**
  * __perf_evlist__for_each_entry - iterate thru all the evsels
  * @list: list_head instance to iterate
-- 
2.21.0

