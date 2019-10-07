Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61569ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32B5C205F4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570452938;
	bh=si+kMSYZUc+N4hi9NMl7DdyE3rCpUQC4igDTMRoFFLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Tlze7GUPDi2MefMJ9XVNj7wdtnccFbY0m47/OcwQfU9cup1P11TZksfN6ItdPA01W
	 1AD9GWMPVxsIWChtpIdOQN9/PEo+3O6usa+9r105xF84a9i6yIahamy0rwMOe91M8B
	 ++5wI8BLS25q2hMoFmJnKX4xKYJV1AUkqrpM/WPE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbfJGMzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 08:55:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60882 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728382AbfJGMyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:54:43 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 738C4A44AF8;
        Mon,  7 Oct 2019 12:54:43 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3AC145D9CC;
        Mon,  7 Oct 2019 12:54:41 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 24/36] libperf: Add perf_evlist__exit function
Date:   Mon,  7 Oct 2019 14:53:32 +0200
Message-Id: <20191007125344.14268-25-jolsa@kernel.org>
In-Reply-To: <20191007125344.14268-1-jolsa@kernel.org>
References: <20191007125344.14268-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Mon, 07 Oct 2019 12:54:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding perf_evlist__exit function, so far it's not
exported and added only for internal use for perf
and libperf.

Using it to release cpus/threads and pollfd array.

Link: http://lkml.kernel.org/n/tip-1n61vkdnvfqaeb7k4mwlvs1h@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/evlist.c                  | 12 +++++++++++-
 tools/perf/lib/include/internal/evlist.h |  2 ++
 tools/perf/util/evlist.c                 |  6 +-----
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index 5ae1da97d2e6..7ba98f0e6365 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -109,13 +109,23 @@ perf_evlist__next(struct perf_evlist *evlist, struct perf_evsel *prev)
 	return next;
 }
 
+void perf_evlist__exit(struct perf_evlist *evlist)
+{
+	perf_cpu_map__put(evlist->cpus);
+	perf_thread_map__put(evlist->threads);
+	evlist->cpus = NULL;
+	evlist->threads = NULL;
+	fdarray__exit(&evlist->pollfd);
+}
+
 void perf_evlist__delete(struct perf_evlist *evlist)
 {
 	if (evlist == NULL)
 		return;
 
 	perf_evlist__munmap(evlist);
-	fdarray__exit(&evlist->pollfd);
+	perf_evlist__close(evlist);
+	perf_evlist__exit(evlist);
 	free(evlist);
 }
 
diff --git a/tools/perf/lib/include/internal/evlist.h b/tools/perf/lib/include/internal/evlist.h
index b2019700cdc0..0721512ffb19 100644
--- a/tools/perf/lib/include/internal/evlist.h
+++ b/tools/perf/lib/include/internal/evlist.h
@@ -48,6 +48,8 @@ int perf_evlist__mmap_ops(struct perf_evlist *evlist,
 			  struct perf_evlist_mmap_ops *ops,
 			  struct perf_mmap_param *mp);
 
+void perf_evlist__exit(struct perf_evlist *evlist);
+
 /**
  * __perf_evlist__for_each_entry - iterate thru all the evsels
  * @list: list_head instance to iterate
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 71679cce7257..3669ca767340 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -138,7 +138,7 @@ void evlist__exit(struct evlist *evlist)
 {
 	zfree(&evlist->mmap);
 	zfree(&evlist->overwrite_mmap);
-	fdarray__exit(&evlist->core.pollfd);
+	perf_evlist__exit(&evlist->core);
 }
 
 void evlist__delete(struct evlist *evlist)
@@ -148,10 +148,6 @@ void evlist__delete(struct evlist *evlist)
 
 	evlist__munmap(evlist);
 	evlist__close(evlist);
-	perf_cpu_map__put(evlist->core.cpus);
-	perf_thread_map__put(evlist->core.threads);
-	evlist->core.cpus = NULL;
-	evlist->core.threads = NULL;
 	evlist__purge(evlist);
 	evlist__exit(evlist);
 	free(evlist);
-- 
2.21.0

