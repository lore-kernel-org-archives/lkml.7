Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2A1C3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 18:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B396921848
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 18:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566757088;
	bh=NR8745syLt4vidV7HR/1GTDtLaQHU/ObHtD4c7OeTZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lT98MX97Etq1HGTxJu0/GSSuDd4R07rG0hO8nInzucpA7hT0Sl7bF7fGMLLFB00Qt
	 MtX1URPcEOvXlHGieCdglusN74f7CMTQgaPgALtWMHDipPrIobWAjKwTXrSp+NP4j1
	 R/BudhVj71ERCAuYQ3PSpIztKyjBnmQvdWq7ERD0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbfHYSSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 14:18:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44318 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728897AbfHYSSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 14:18:06 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8D4EE1089041;
        Sun, 25 Aug 2019 18:18:06 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-45.brq.redhat.com [10.40.204.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D43A95D9C3;
        Sun, 25 Aug 2019 18:18:03 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 04/12] libperf: Add namespaces_event to perf/event.h
Date:   Sun, 25 Aug 2019 20:17:44 +0200
Message-Id: <20190825181752.722-5-jolsa@kernel.org>
In-Reply-To: <20190825181752.722-1-jolsa@kernel.org>
References: <20190825181752.722-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.64]); Sun, 25 Aug 2019 18:18:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving namespaces_event event definition into libperf's event.h
header include.

In order to keep libperf simple, we switch 'u64/u32/u16/u8'
types used events to their generic '__u*' versions.

Link: http://lkml.kernel.org/n/tip-mmombtaqynjtfgrju0hgp3wc@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/include/perf/event.h | 7 +++++++
 tools/perf/util/event.h             | 7 -------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index 11adfb1b1524..265bb01029f0 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -36,4 +36,11 @@ struct comm_event {
 	char comm[16];
 };
 
+struct namespaces_event {
+	struct perf_event_header header;
+	__u32 pid, tid;
+	__u64 nr_namespaces;
+	struct perf_ns_link_info link_info[];
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 12bc9de3d539..e8c57c23aa24 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -16,13 +16,6 @@
 #define PRI_lu64 "l" PRIu64
 #define PRI_lx64 "l" PRIx64
 
-struct namespaces_event {
-	struct perf_event_header header;
-	u32 pid, tid;
-	u64 nr_namespaces;
-	struct perf_ns_link_info link_info[];
-};
-
 struct fork_event {
 	struct perf_event_header header;
 	u32 pid, ppid;
-- 
2.21.0

