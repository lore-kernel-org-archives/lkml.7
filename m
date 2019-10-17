Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2EF9FA3733
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 10:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F2E21A49
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 10:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571309999;
	bh=3NRiu5gDsrDTcZdHLsVlqS+Ybfgzf5pCqcdP0Aw1mVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OLabhxW3H9v4q+Y4x+rtWsD0/3BBtc3PVT86zIsF2VprHUWvO709XUu/ot0DQcBY1
	 Bm2k9OtN77n+kEJSSrsnwmdJBwF4hUCxVxuE5kHJtV7b0gtqT9LAkGlJYB6T0hbfoa
	 /1BIaIQhEBC9alRUC8V7FSfqj2pX+Doboq8xjquc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409289AbfJQK75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 06:59:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43720 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409254AbfJQK7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 06:59:46 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8083E18CB911;
        Thu, 17 Oct 2019 10:59:45 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3BDB95D713;
        Thu, 17 Oct 2019 10:59:43 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH 09/10] libperf: Do not export perf_evsel__init/perf_evlist__init
Date:   Thu, 17 Oct 2019 12:59:17 +0200
Message-Id: <20191017105918.20873-10-jolsa@kernel.org>
In-Reply-To: <20191017105918.20873-1-jolsa@kernel.org>
References: <20191017105918.20873-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.63]); Thu, 17 Oct 2019 10:59:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no point to export perf_evsel__init/perf_evlist__init,
it's called from perf_evsel__new/perf_evlist__new respectively.

It's used only from perf where perf_evsel/perf_evlist is embedded
perf's evsel/evlist.

Link: http://lkml.kernel.org/n/tip-k0w3i2vqos0lvnadfm95a8fy@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/include/internal/evlist.h | 1 +
 tools/perf/lib/include/internal/evsel.h  | 1 +
 tools/perf/lib/include/perf/evlist.h     | 1 -
 tools/perf/lib/include/perf/evsel.h      | 2 --
 tools/perf/lib/libperf.map               | 2 --
 5 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/perf/lib/include/internal/evlist.h b/tools/perf/lib/include/internal/evlist.h
index 20d90e29fc0e..a2fbccf1922f 100644
--- a/tools/perf/lib/include/internal/evlist.h
+++ b/tools/perf/lib/include/internal/evlist.h
@@ -50,6 +50,7 @@ int perf_evlist__mmap_ops(struct perf_evlist *evlist,
 			  struct perf_evlist_mmap_ops *ops,
 			  struct perf_mmap_param *mp);
 
+void perf_evlist__init(struct perf_evlist *evlist);
 void perf_evlist__exit(struct perf_evlist *evlist);
 
 /**
diff --git a/tools/perf/lib/include/internal/evsel.h b/tools/perf/lib/include/internal/evsel.h
index a69b8299c36f..1ffd083b235e 100644
--- a/tools/perf/lib/include/internal/evsel.h
+++ b/tools/perf/lib/include/internal/evsel.h
@@ -50,6 +50,7 @@ struct perf_evsel {
 	bool			 system_wide;
 };
 
+void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr);
 int perf_evsel__alloc_fd(struct perf_evsel *evsel, int ncpus, int nthreads);
 void perf_evsel__close_fd(struct perf_evsel *evsel);
 void perf_evsel__free_fd(struct perf_evsel *evsel);
diff --git a/tools/perf/lib/include/perf/evlist.h b/tools/perf/lib/include/perf/evlist.h
index 8c4b3c28535e..0a7479dc13bf 100644
--- a/tools/perf/lib/include/perf/evlist.h
+++ b/tools/perf/lib/include/perf/evlist.h
@@ -10,7 +10,6 @@ struct perf_evsel;
 struct perf_cpu_map;
 struct perf_thread_map;
 
-LIBPERF_API void perf_evlist__init(struct perf_evlist *evlist);
 LIBPERF_API void perf_evlist__add(struct perf_evlist *evlist,
 				  struct perf_evsel *evsel);
 LIBPERF_API void perf_evlist__remove(struct perf_evlist *evlist,
diff --git a/tools/perf/lib/include/perf/evsel.h b/tools/perf/lib/include/perf/evsel.h
index 4388667f265c..557f5815a9c9 100644
--- a/tools/perf/lib/include/perf/evsel.h
+++ b/tools/perf/lib/include/perf/evsel.h
@@ -21,8 +21,6 @@ struct perf_counts_values {
 	};
 };
 
-LIBPERF_API void perf_evsel__init(struct perf_evsel *evsel,
-				  struct perf_event_attr *attr);
 LIBPERF_API struct perf_evsel *perf_evsel__new(struct perf_event_attr *attr);
 LIBPERF_API void perf_evsel__delete(struct perf_evsel *evsel);
 LIBPERF_API int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index 8be02afc324b..7be1af8a546c 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -21,7 +21,6 @@ LIBPERF_0.0.1 {
 		perf_evsel__delete;
 		perf_evsel__enable;
 		perf_evsel__disable;
-		perf_evsel__init;
 		perf_evsel__open;
 		perf_evsel__close;
 		perf_evsel__read;
@@ -34,7 +33,6 @@ LIBPERF_0.0.1 {
 		perf_evlist__close;
 		perf_evlist__enable;
 		perf_evlist__disable;
-		perf_evlist__init;
 		perf_evlist__add;
 		perf_evlist__remove;
 		perf_evlist__next;
-- 
2.21.0

