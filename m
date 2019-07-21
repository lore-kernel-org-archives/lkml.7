Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDCFC76195
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6FF82085A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563708647;
	bh=Q6HXx0OsHdDGvhKUT4n3hyha8rOG/mvXQnin7kywztY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jMBG1d08gZvaHbEc9X/jyAsVFL4hfML/q8qpmdNIyUndY5Krr7+DK75Qvce08SoEj
	 hN9yY4BI40Mgp9ShnZ9f4HZgR2pK5jiHlLxilX7kWckmggQQexiBK9/8KYU+yh1LhE
	 BebXCnXFo0Vrw1CyTJGHGOzQQphO/4j7ZYRId8vI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfGULaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 07:30:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49852 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbfGULap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 07:30:45 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 36BDE8553A;
        Sun, 21 Jul 2019 11:30:45 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-23.brq.redhat.com [10.40.204.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 98F145D9D3;
        Sun, 21 Jul 2019 11:30:41 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 48/79] libperf: Add perf_evlist__delete function
Date:   Sun, 21 Jul 2019 13:24:35 +0200
Message-Id: <20190721112506.12306-49-jolsa@kernel.org>
In-Reply-To: <20190721112506.12306-1-jolsa@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Sun, 21 Jul 2019 11:30:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding perf_evlist__delete function to delete
perf_evlist struct.

Link: http://lkml.kernel.org/n/tip-l0bn8sv18gjt7cv44zvieuh1@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/evlist.c              | 6 ++++++
 tools/perf/lib/include/perf/evlist.h | 1 +
 tools/perf/lib/libperf.map           | 1 +
 3 files changed, 8 insertions(+)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index 8c26ebf290f0..c14b535bd765 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -4,6 +4,7 @@
 #include <internal/evlist.h>
 #include <internal/evsel.h>
 #include <linux/zalloc.h>
+#include <stdlib.h>
 
 void perf_evlist__init(struct perf_evlist *evlist)
 {
@@ -54,3 +55,8 @@ perf_evlist__next(struct perf_evlist *evlist, struct perf_evsel *prev)
 
 	return next;
 }
+
+void perf_evlist__delete(struct perf_evlist *evlist)
+{
+	free(evlist);
+}
diff --git a/tools/perf/lib/include/perf/evlist.h b/tools/perf/lib/include/perf/evlist.h
index 5092b622935b..9a126fd0773c 100644
--- a/tools/perf/lib/include/perf/evlist.h
+++ b/tools/perf/lib/include/perf/evlist.h
@@ -13,6 +13,7 @@ LIBPERF_API void perf_evlist__add(struct perf_evlist *evlist,
 LIBPERF_API void perf_evlist__remove(struct perf_evlist *evlist,
 				     struct perf_evsel *evsel);
 LIBPERF_API struct perf_evlist *perf_evlist__new(void);
+LIBPERF_API void perf_evlist__delete(struct perf_evlist *evlist);
 LIBPERF_API struct perf_evsel* perf_evlist__next(struct perf_evlist *evlist,
 						 struct perf_evsel *evsel);
 
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index c0968226f7b6..153e77cd6739 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -14,6 +14,7 @@ LIBPERF_0.0.1 {
 		perf_evsel__new;
 		perf_evsel__init;
 		perf_evlist__new;
+		perf_evlist__delete;
 		perf_evlist__init;
 		perf_evlist__add;
 		perf_evlist__remove;
-- 
2.21.0

