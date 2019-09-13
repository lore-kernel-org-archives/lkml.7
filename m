Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0F5C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8788206A5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381063;
	bh=KbNQQoE9gwDeCJ0cXBxe5Jm+KJQkCIwOQUCnZ6x7HF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1WsAuSI6cpx8+qWSZ6yPwsRNu/SNlhzkNTdTFm4dTxpPLYW1Vpa7aMQThthSqhMFB
	 GzG25mCyff+N3CuWk5agZybiZ+Oc3fMiYT2Bs9zNSMjhvAHibvvRBDJLKipwZYh/94
	 eV6TDoOOnmEeiwOD0F1fHkQxEr/nNdz5YmqSvbNM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391139AbfIMNYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:24:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59234 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390528AbfIMNYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:24:20 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B98D43CA0F;
        Fri, 13 Sep 2019 13:24:20 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2010E5C1D4;
        Fri, 13 Sep 2019 13:24:18 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 08/73] perf tools: Rename perf_evlist__purge() to evlist__purge()
Date:   Fri, 13 Sep 2019 15:22:50 +0200
Message-Id: <20190913132355.21634-9-jolsa@kernel.org>
In-Reply-To: <20190913132355.21634-1-jolsa@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 13 Sep 2019 13:24:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename (perf_evlist__purge) to evlist__purge(), so we don't have a
name clash when we add (perf_evlist__purge) in libperf.

Link: http://lkml.kernel.org/n/tip-snvcdpyj28haygnvkuocxeh7@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/evlist.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index d71fafd472ea..ac738b90a71f 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -124,7 +124,7 @@ static void perf_evlist__update_id_pos(struct evlist *evlist)
 	perf_evlist__set_id_pos(evlist);
 }
 
-static void perf_evlist__purge(struct evlist *evlist)
+static void evlist__purge(struct evlist *evlist)
 {
 	struct evsel *pos, *n;
 
@@ -155,7 +155,7 @@ void evlist__delete(struct evlist *evlist)
 	perf_thread_map__put(evlist->core.threads);
 	evlist->core.cpus = NULL;
 	evlist->core.threads = NULL;
-	perf_evlist__purge(evlist);
+	evlist__purge(evlist);
 	evlist__exit(evlist);
 	free(evlist);
 }
-- 
2.21.0

