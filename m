Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0DFC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEE9E206DD
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564455794;
	bh=M+9uVDaMoUFEtmZ49b2HF/3gLCVAbAJlLITH3hReZk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WAu6Z+QLhX9Ki7WE/QBmtyHXDFVF+ICfWg6s4A6rR7Z9V+PkGeqQN6mwxUBaVgWxh
	 s91eaI8++0jfza6KjLwNjH/3X5x5/k5N6nKshOTdUAvrqnnxkixI/2IAiaDRxn/iah
	 LJsLqMExuAiUMuuEouDHVcPjKkJumqvSvhlluPVM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732876AbfG3DDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 23:03:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:49856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730288AbfG3DAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 23:00:33 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E61FF216C8;
        Tue, 30 Jul 2019 03:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455633;
        bh=M+9uVDaMoUFEtmZ49b2HF/3gLCVAbAJlLITH3hReZk4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EMaiCb8jesSxvxdJ544PIMuoH5m8sgnxXVIhg/OW7NWMzbp2lFGMF97FBZapmiTAC
         mcqjTOptZNQRUSa29df+ErBsfdOgTXR4GApbNU9lix5Yj2BZI8Ua+mTeT5AjzD/eVX
         HDbqsId0M9OMMCoFEEDrux3Xy18MQq0uTP4Vxo7c=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 075/107] libperf: Add perf_evlist__delete() function
Date:   Mon, 29 Jul 2019 23:55:38 -0300
Message-Id: <20190730025610.22603-76-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190730025610.22603-1-acme@kernel.org>
References: <20190730025610.22603-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add the perf_evlist__delete() function to delete a perf_evlist instance.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-49-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evlist.c              | 6 ++++++
 tools/perf/lib/include/perf/evlist.h | 1 +
 tools/perf/lib/libperf.map           | 1 +
 3 files changed, 8 insertions(+)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index 979ee423490f..087ef76ea8fd 100644
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

