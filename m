Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278B4C3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 18:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F39042173E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 18:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566757101;
	bh=52Uod72cSAU4Rh9ai/AZ8mZmVq/yyE1eG93MHn+bjxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Oz5vdjoljKSrV1esIiuCDfYzIycIKDQ6VLbe4jgiP6JEDc5wOmcGM7He9HT7vXEw3
	 2l67SxRPAr16fkuB5HLMNlOxxmmqtqunqmizcuGoVSqGl34latXv0xCrPdQi2gcYC9
	 NiihdoLF6Q60oMy3mv7o+eQ39IwRtlK3JJsHvQro=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbfHYSST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 14:18:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43740 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728933AbfHYSSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 14:18:15 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8A31EA28883;
        Sun, 25 Aug 2019 18:18:15 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-45.brq.redhat.com [10.40.204.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7800E5D9C3;
        Sun, 25 Aug 2019 18:18:13 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 07/12] libperf: Add lost_samples_event to perf/event.h
Date:   Sun, 25 Aug 2019 20:17:47 +0200
Message-Id: <20190825181752.722-8-jolsa@kernel.org>
In-Reply-To: <20190825181752.722-1-jolsa@kernel.org>
References: <20190825181752.722-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Sun, 25 Aug 2019 18:18:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving lost_samples_event event definition into libperf's event.h
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

Link: http://lkml.kernel.org/n/tip-m3fg0vd8lo1wl8cy828agzbo@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/include/perf/event.h | 5 +++++
 tools/perf/util/event.h             | 5 -----
 tools/perf/util/machine.c           | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index 6c25d0adbe6d..3bd2727ac5f9 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -56,4 +56,9 @@ struct lost_event {
 	__u64 lost;
 };
 
+struct lost_samples_event {
+	struct perf_event_header header;
+	__u64 lost;
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index cc9cc38f0bf7..1bf44b73fbbf 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -16,11 +16,6 @@
 #define PRI_lu64 "l" PRIu64
 #define PRI_lx64 "l" PRIx64
 
-struct lost_samples_event {
-	struct perf_event_header header;
-	u64 lost;
-};
-
 /*
  * PERF_FORMAT_ENABLED | PERF_FORMAT_RUNNING | PERF_FORMAT_ID
  */
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index f61349d1d0d4..9094e86e4db8 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -650,7 +650,7 @@ int machine__process_lost_event(struct machine *machine __maybe_unused,
 int machine__process_lost_samples_event(struct machine *machine __maybe_unused,
 					union perf_event *event, struct perf_sample *sample)
 {
-	dump_printf(": id:%" PRIu64 ": lost samples :%" PRIu64 "\n",
+	dump_printf(": id:%" PRIu64 ": lost samples :%" PRI_lu64 "\n",
 		    sample->id, event->lost_samples.lost);
 	return 0;
 }
-- 
2.21.0

