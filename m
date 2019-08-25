Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314B9C3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 18:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 064652082F
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 18:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566757093;
	bh=Vpu3tcxK57A4/F6/i6QFMrgZg+RznyjN/EGGz20aUqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=th870WqJICOmBvByrQ9bt8wmwkwZZWR0P2C154nsiZqxsPzpp5sZHD4SdZZoDGsOh
	 d0J2dSjS6Zg+omvfvmdbizL0O95YP4FfqgfP1hW4UIWYmfBci8ZC0dJJ7THhvJPBck
	 FM+DFLxRCWkPYkvbJWrgK7LiN8lUA7Pg24JUtgrs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbfHYSSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 14:18:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40394 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728897AbfHYSSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 14:18:10 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E532710881CA;
        Sun, 25 Aug 2019 18:18:09 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-45.brq.redhat.com [10.40.204.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 088905D9C3;
        Sun, 25 Aug 2019 18:18:06 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 05/12] libperf: Add fork_event to perf/event.h
Date:   Sun, 25 Aug 2019 20:17:45 +0200
Message-Id: <20190825181752.722-6-jolsa@kernel.org>
In-Reply-To: <20190825181752.722-1-jolsa@kernel.org>
References: <20190825181752.722-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.65]); Sun, 25 Aug 2019 18:18:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving fork_event event definition into libperf's event.h
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

Link: http://lkml.kernel.org/n/tip-p4ooh7midl03a03o03xcsqws@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/include/perf/event.h | 7 +++++++
 tools/perf/util/event.h             | 7 -------
 tools/perf/util/python.c            | 2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index 265bb01029f0..7a34221abbba 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -43,4 +43,11 @@ struct namespaces_event {
 	struct perf_ns_link_info link_info[];
 };
 
+struct fork_event {
+	struct perf_event_header header;
+	__u32 pid, ppid;
+	__u32 tid, ptid;
+	__u64 time;
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index e8c57c23aa24..817f12643f11 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -16,13 +16,6 @@
 #define PRI_lu64 "l" PRIu64
 #define PRI_lx64 "l" PRIx64
 
-struct fork_event {
-	struct perf_event_header header;
-	u32 pid, ppid;
-	u32 tid, ptid;
-	u64 time;
-};
-
 struct lost_event {
 	struct perf_event_header header;
 	u64 id;
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 55ff0c3182d6..8bdadb24f6ba 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -170,7 +170,7 @@ static PyMemberDef pyrf_task_event__members[] = {
 static PyObject *pyrf_task_event__repr(struct pyrf_event *pevent)
 {
 	return _PyUnicode_FromFormat("{ type: %s, pid: %u, ppid: %u, tid: %u, "
-				   "ptid: %u, time: %" PRIu64 "}",
+				   "ptid: %u, time: %" PRI_lu64 "}",
 				   pevent->event.header.type == PERF_RECORD_FORK ? "fork" : "exit",
 				   pevent->event.fork.pid,
 				   pevent->event.fork.ppid,
-- 
2.21.0

