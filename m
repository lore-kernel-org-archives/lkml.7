Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A385C3A59F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDFC92080C
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566869892;
	bh=6BJ9onFCcnZV6cy1mYIl8DGFSnDcMWRPQDQhF+k9bSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m9Azxuv5RZ+VAjBk285d0jX8DlDXOtjlrRRwcW4D8B+HHvDG168fhcJKVYeiK0tz9
	 yN31iQrjP8TRv/3QjR3ypUKf925qx5+YNUjD/zuHAgxQH5Bf5oC8z36/d5jRx/QYRh
	 KJcQNnhkhNE1DgMIIzWaBezRFobpxeEqEA4XnW/E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbfH0BiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 21:38:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:51274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729189AbfH0BiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 21:38:05 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5342E2173E;
        Tue, 27 Aug 2019 01:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566869885;
        bh=6BJ9onFCcnZV6cy1mYIl8DGFSnDcMWRPQDQhF+k9bSk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z8i1d0GqybkO/CBzDJwABDTMp4wcICASbZX8ksDBJ7kitDdiL8G5IXt73i6J4ea1D
         FfrRDKeQ+qU3vjciobF9evHyqUawZO/cAHqaJWgqOoWQ7IN7GMMDsuP2da4GsWnkBU
         3F14GU8fD7tcRgl1yQlHBmaF2Nsj9ajiTstcPXEk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 27/33] libperf: Add PERF_RECORD_BPF_EVENT 'struct bpf_event' to perf/event.h
Date:   Mon, 26 Aug 2019 22:36:28 -0300
Message-Id: <20190827013634.3173-28-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190827013634.3173-1-acme@kernel.org>
References: <20190827013634.3173-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move the PERF_RECORD_BPF_EVENT event definition to libperf's event.h.

In order to keep libperf simple, we switch 'u64/u32/u16/u8'
types used events to their generic '__u*' versions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190825181752.722-12-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/perf/event.h | 11 +++++++++++
 tools/perf/util/event.h             | 10 ----------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index 8c367931cecc..585c9d82dba3 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -5,6 +5,7 @@
 #include <linux/perf_event.h>
 #include <linux/types.h>
 #include <linux/limits.h>
+#include <linux/bpf.h>
 
 struct mmap_event {
 	struct perf_event_header header;
@@ -93,4 +94,14 @@ struct ksymbol_event {
 	char			 name[KSYM_NAME_LEN];
 };
 
+struct bpf_event {
+	struct perf_event_header header;
+	__u16			 type;
+	__u16			 flags;
+	__u32			 id;
+
+	/* for bpf_prog types */
+	__u8			 tag[BPF_TAG_SIZE];  // prog tag
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index c4eec1f164ba..091a0690a280 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -27,16 +27,6 @@
 #define PRI_lx64 PRIx64
 #endif
 
-struct bpf_event {
-	struct perf_event_header header;
-	u16 type;
-	u16 flags;
-	u32 id;
-
-	/* for bpf_prog types */
-	u8 tag[BPF_TAG_SIZE];  // prog tag
-};
-
 #define PERF_SAMPLE_MASK				\
 	(PERF_SAMPLE_IP | PERF_SAMPLE_TID |		\
 	 PERF_SAMPLE_TIME | PERF_SAMPLE_ADDR |		\
-- 
2.21.0

