Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70AEC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B2182189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567000656;
	bh=sLIWmYkqXWAG7eyGtVWA8A5uxpIe9QRBkNaL7dfQoaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z1RqY0WLh3qqqw4hdbMQMVrpbhLEJUKubjbcyWCp3GbIPZXzOAL+9IerxXwtZCwBI
	 SAwxF7gLb/juU6CLOyG+uipJ3OBqdPvzves7AL/+OXXp1Y0eykb6SffCY7wxCOsegQ
	 7IA3UMZLCbfxKNXaXwiPzhbHe/+oY+Ti9OpZErsY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfH1N5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 09:57:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:6364 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726775AbfH1N5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:57:32 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1C81F308429D;
        Wed, 28 Aug 2019 13:57:32 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 768791001B00;
        Wed, 28 Aug 2019 13:57:30 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 06/23] libperf: Add PERF_RECORD_HEADER_BUILD_ID 'struct build_id_event' to perf/event.h
Date:   Wed, 28 Aug 2019 15:57:00 +0200
Message-Id: <20190828135717.7245-7-jolsa@kernel.org>
In-Reply-To: <20190828135717.7245-1-jolsa@kernel.org>
References: <20190828135717.7245-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 28 Aug 2019 13:57:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the PERF_RECORD_HEADER_BUILD_ID event definition to libperf's event.h.

In order to keep libperf simple, we switch 'u64/u32/u16/u8'
types used events to their generic '__u*' versions.

Adding the fix value for build_id variable,
because it will never change.

Link: http://lkml.kernel.org/n/tip-k8qspx6f04gaveoe7qwpapw8@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/include/perf/event.h | 8 ++++++++
 tools/perf/util/event.h             | 7 -------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index fa81fea8dc02..5e6b6d16793c 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -6,6 +6,7 @@
 #include <linux/types.h>
 #include <linux/limits.h>
 #include <linux/bpf.h>
+#include <sys/types.h> /* pid_t */
 
 struct perf_record_mmap {
 	struct perf_event_header header;
@@ -180,4 +181,11 @@ struct tracing_data_event {
 	__u32			 size;
 };
 
+struct build_id_event {
+	struct perf_event_header header;
+	pid_t			 pid;
+	__u8			 build_id[24];
+	char			 filename[];
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 67f6a67ad3b4..4b6cf89f31db 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -144,13 +144,6 @@ struct perf_sample {
 	 PERF_MEM_S(LOCK, NA) |\
 	 PERF_MEM_S(TLB, NA))
 
-struct build_id_event {
-	struct perf_event_header header;
-	pid_t			 pid;
-	u8			 build_id[PERF_ALIGN(BUILD_ID_SIZE, sizeof(u64))];
-	char			 filename[];
-};
-
 enum perf_user_event_type { /* above any possible kernel type */
 	PERF_RECORD_USER_TYPE_START		= 64,
 	PERF_RECORD_HEADER_ATTR			= 64,
-- 
2.21.0

