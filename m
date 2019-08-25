Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F726C3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 18:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 395B62082F
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 18:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566757104;
	bh=Y9nWof3O9CQELbfHkYNIgV/fQC2HKQ8h7sdUXekfvkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VBiKtGQcAOjH4WBXr3aft3xoSSMCzMpWdnIVwMs2gg2w+GK97Ux3IuBTtRbaw0Dfl
	 MSj+wQS4Gv+LB1prGd080HUGpUjuGOK2AGByZoN4A95fcoUVizGGO7uZR5sJnhIjD4
	 nBjvZGeI74jlH7t++b6O8J2UKvcBRHbk4HdF2FzY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbfHYSSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 14:18:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44342 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728972AbfHYSSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 14:18:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8F0DF10576D9;
        Sun, 25 Aug 2019 18:18:20 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-45.brq.redhat.com [10.40.204.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 95ABF6DA91;
        Sun, 25 Aug 2019 18:18:18 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 09/12] libperf: Add throttle_event to perf/event.h
Date:   Sun, 25 Aug 2019 20:17:49 +0200
Message-Id: <20190825181752.722-10-jolsa@kernel.org>
In-Reply-To: <20190825181752.722-1-jolsa@kernel.org>
References: <20190825181752.722-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.64]); Sun, 25 Aug 2019 18:18:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving throttle_event event definition into libperf's event.h
header include.

In order to keep libperf simple, we switch 'u64/u32/u16/u8'
types used events to their generic '__u*' versions.

Perf added 'u*' types mainly to ease up printing __u64 values
as stated in the linux/types.h comment:

  /*
   * We define u64 as uint64_t for every architecture
   * so that we can print it with "%"PRIx64 without getting warnings.
   *
   * typedef __u64 u64;
   * typedef __s64 s64;
   */

Adding and using new PRI_lu64 and PRI_lx64 macros to be used for
that.  Using extra '_' to ease up the reading and differentiate
them from standard PRI*64 macros.

Link: http://lkml.kernel.org/n/tip-u7lk8zc4lpm2sxijnun00siz@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/include/perf/event.h | 7 +++++++
 tools/perf/util/event.h             | 7 -------
 tools/perf/util/python.c            | 4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index a03dbe776a44..80d0bc48baff 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -73,4 +73,11 @@ struct read_event {
 	__u64 id;
 };
 
+struct throttle_event {
+	struct perf_event_header header;
+	__u64 time;
+	__u64 id;
+	__u64 stream_id;
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 89872279a5af..d03a70e2e6a4 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -16,13 +16,6 @@
 #define PRI_lu64 "l" PRIu64
 #define PRI_lx64 "l" PRIx64
 
-struct throttle_event {
-	struct perf_event_header header;
-	u64 time;
-	u64 id;
-	u64 stream_id;
-};
-
 #ifndef KSYM_NAME_LEN
 #define KSYM_NAME_LEN 256
 #endif
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 5be85f50cd1c..d21e270c7823 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -233,8 +233,8 @@ static PyObject *pyrf_throttle_event__repr(struct pyrf_event *pevent)
 {
 	struct throttle_event *te = (struct throttle_event *)(&pevent->event.header + 1);
 
-	return _PyUnicode_FromFormat("{ type: %sthrottle, time: %" PRIu64 ", id: %" PRIu64
-				   ", stream_id: %" PRIu64 " }",
+	return _PyUnicode_FromFormat("{ type: %sthrottle, time: %" PRI_lu64 ", id: %" PRI_lu64
+				   ", stream_id: %" PRI_lu64 " }",
 				   pevent->event.header.type == PERF_RECORD_THROTTLE ? "" : "un",
 				   te->time, te->id, te->stream_id);
 }
-- 
2.21.0

