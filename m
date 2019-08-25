Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B58C3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 18:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1E542082F
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 18:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566757095;
	bh=gLYUuSbj0ljDzFmOZgaAU5GTxLAVm1JGI8DxXj3bt9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mHxvf8HX6sMfwOm/vJvzg3uqVpxSFiXgmAXv33TnfD5JnBP3gvJsBdm67u3Ipva8U
	 IgSJKqm+8A/NYu4NvhpX0OSD7jbNx6wnJ91NRHEXV0qi2sYdnPQLrYhPnmF9q/1F4d
	 FqnJwXkqs9J0y9mVLls8UIdQyJjxw8llB4uNACy4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbfHYSSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 14:18:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33480 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728881AbfHYSSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 14:18:03 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7C4AC18C8910;
        Sun, 25 Aug 2019 18:18:03 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-45.brq.redhat.com [10.40.204.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 43C6A5ED3C;
        Sun, 25 Aug 2019 18:18:01 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 03/12] libperf: Add comm_event to perf/event.h
Date:   Sun, 25 Aug 2019 20:17:43 +0200
Message-Id: <20190825181752.722-4-jolsa@kernel.org>
In-Reply-To: <20190825181752.722-1-jolsa@kernel.org>
References: <20190825181752.722-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.70]); Sun, 25 Aug 2019 18:18:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving comm_event event definition into libperf's event.h
header include.

In order to keep libperf simple, we switch 'u64/u32/u16/u8'
types used events to their generic '__u*' versions.

Link: http://lkml.kernel.org/n/tip-2wp8wtf6p0dgdcul1in49wg6@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/include/perf/event.h | 6 ++++++
 tools/perf/util/event.h             | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index f1f5b0787782..11adfb1b1524 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -30,4 +30,10 @@ struct mmap2_event {
 	char filename[PATH_MAX];
 };
 
+struct comm_event {
+	struct perf_event_header header;
+	__u32 pid, tid;
+	char comm[16];
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index fdff9dcd7c2b..12bc9de3d539 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -16,12 +16,6 @@
 #define PRI_lu64 "l" PRIu64
 #define PRI_lx64 "l" PRIx64
 
-struct comm_event {
-	struct perf_event_header header;
-	u32 pid, tid;
-	char comm[16];
-};
-
 struct namespaces_event {
 	struct perf_event_header header;
 	u32 pid, tid;
-- 
2.21.0

