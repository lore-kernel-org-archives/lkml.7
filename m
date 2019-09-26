Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF754C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84073222C3
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569458191;
	bh=xy0feKi1pEzjdSav6Ilw6hSvjbgR28tFtk4mt0k/fN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NKizp6zNIVGNucDNryDfJQ0RgRnW76zOq7Oid6Yhy7PXWBajVdMRYupfLst45xmDl
	 nrF5iplgOW+G/v7qeT4QLDoyqGE2hxQDL26+a+oPbvre5BNhWCkrQioKPVSG5uuBvN
	 dSpByMh/i31gnBLho46gRO91xXIBYnkdPr9k93GI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390628AbfIZAga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 20:36:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:39220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390543AbfIZAg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 20:36:28 -0400
Received: from quaco.localdomain (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0817F222C7;
        Thu, 26 Sep 2019 00:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569458186;
        bh=xy0feKi1pEzjdSav6Ilw6hSvjbgR28tFtk4mt0k/fN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V+qfZTlDugNBTZPJz+J6XZvhTPkkKmpLHgH8L0KnUPwL+XUQFxv5rbb7CmWDywjlr
         dTBN2hW1wHcTdbJ+tGpFOtVdP8Qv7FpfOZ0FuAnGT3kOtk2vXupwRTXa8H6AMvGcgt
         azQqG6OjMQZX9z8c7VnZ3q6dw1pq2qR7bgTokL1Q=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 58/66] perf evlist: Remove unused perf_evlist__fprintf() method
Date:   Wed, 25 Sep 2019 21:32:36 -0300
Message-Id: <20190926003244.13962-59-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Ditch it, noone is using it, one more stdio.h include in a hot header.

Fix the fallout in parse-events.y, where we end up using a FILE pointer,
I think due to YYDEBUG being set and in some places, like Amazon Linux 1
we don't get stdio.h included by luck, like in most other places, add a
explicit stdio.h include directive.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-37k5q0lhdbo2hvvfbnnzn7og@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c       | 13 -------------
 tools/perf/util/evlist.h       |  3 ---
 tools/perf/util/parse-events.y |  1 +
 3 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index d4c7fd125ce9..84c42790dab3 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1421,19 +1421,6 @@ int perf_evlist__parse_sample_timestamp(struct evlist *evlist,
 	return perf_evsel__parse_sample_timestamp(evsel, event, timestamp);
 }
 
-size_t perf_evlist__fprintf(struct evlist *evlist, FILE *fp)
-{
-	struct evsel *evsel;
-	size_t printed = 0;
-
-	evlist__for_each_entry(evlist, evsel) {
-		printed += fprintf(fp, "%s%s", evsel->idx ? ", " : "",
-				   perf_evsel__name(evsel));
-	}
-
-	return printed + fprintf(fp, "\n");
-}
-
 int perf_evlist__strerror_open(struct evlist *evlist,
 			       int err, char *buf, size_t size)
 {
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 130d44d691b8..7cfe75522ba5 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -7,7 +7,6 @@
 #include <linux/refcount.h>
 #include <linux/list.h>
 #include <api/fd/array.h>
-#include <stdio.h>
 #include <internal/evlist.h>
 #include <internal/evsel.h>
 #include "events_stats.h"
@@ -249,8 +248,6 @@ static inline struct evsel *evlist__last(struct evlist *evlist)
 	return container_of(evsel, struct evsel, core);
 }
 
-size_t perf_evlist__fprintf(struct evlist *evlist, FILE *fp);
-
 int perf_evlist__strerror_open(struct evlist *evlist, int err, char *buf, size_t size);
 int perf_evlist__strerror_mmap(struct evlist *evlist, int err, char *buf, size_t size);
 
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index f1c36ed1cf36..65809ad67808 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -9,6 +9,7 @@
 #define YYDEBUG 1
 
 #include <fnmatch.h>
+#include <stdio.h>
 #include <linux/compiler.h>
 #include <linux/list.h>
 #include <linux/types.h>
-- 
2.21.0

