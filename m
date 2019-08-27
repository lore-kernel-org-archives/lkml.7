Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29329C3A59F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F23D522CBB
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566869865;
	bh=M2xjQ6ZmpMbIBC5uG8EVrEZMz2gbQZ8/yMvoXKWpa8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LZHK9O6hKIW+vwH/WU7Di9M6Oz9UyqE1wAXoCmnRj78yLesguQr4xOiIcRjSKXqUk
	 wHLgP1Ahb9XbHKcFx/APdaLelLiC4KBGOVOqS4HYlOSYgfa7QfEhnrJm2mKK2k9AvG
	 O/hQF742sszYmSKrulY6jqtm1VugHJQoXirDtsMQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbfH0Bhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 21:37:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:50828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729024AbfH0Bhh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 21:37:37 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1146321848;
        Tue, 27 Aug 2019 01:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566869856;
        bh=M2xjQ6ZmpMbIBC5uG8EVrEZMz2gbQZ8/yMvoXKWpa8c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vtLGTYRdFVwQDzafEg6gP/k+a2BWi2EUY9hz8JU68sWmcr86PPMZMQHKpvIJK/Qbh
         0XoiUL9MIz17XCZP2zhf3RtIbzsb5Yt5WIZfevMEjCOMa/oa3uHDN87DNlDO5JDRbp
         8HXCvqnsf3y75nOsUxK64TZeq983L5GAAb3hmaKk=
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
Subject: [PATCH 18/33] libperf: Add PERF_RECORD_MMAP2 'struct mmap2_event' to perf/event.h
Date:   Mon, 26 Aug 2019 22:36:19 -0300
Message-Id: <20190827013634.3173-19-acme@kernel.org>
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

Moving mmap2_event event definition into libperf's event.h header
include.

In order to keep libperf simple, we switch 'u64/u32/u16/u8' types used
events to their generic '__u*' versions.

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

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/n/tip-ufs9ityr5w2xqwtd5w3p6dm4@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/perf/event.h | 15 +++++++++++++++
 tools/perf/util/event.c             |  6 +++---
 tools/perf/util/event.h             | 15 ---------------
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index 13fe15a2fe7f..c82e0c2c004b 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -15,4 +15,19 @@ struct mmap_event {
 	char			 filename[PATH_MAX];
 };
 
+struct mmap2_event {
+	struct perf_event_header header;
+	__u32			 pid, tid;
+	__u64			 start;
+	__u64			 len;
+	__u64			 pgoff;
+	__u32			 maj;
+	__u32			 min;
+	__u64			 ino;
+	__u64			 ino_generation;
+	__u32			 prot;
+	__u32			 flags;
+	char			 filename[PATH_MAX];
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 43c86257e7fa..0954f980574f 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -387,7 +387,7 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
 		strcpy(execname, "");
 
 		/* 00400000-0040c000 r-xp 00000000 fd:01 41038  /bin/cat */
-		n = sscanf(bf, "%"PRIx64"-%"PRIx64" %s %"PRIx64" %x:%x %u %[^\n]\n",
+		n = sscanf(bf, "%"PRI_lx64"-%"PRI_lx64" %s %"PRI_lx64" %x:%x %u %[^\n]\n",
 		       &event->mmap2.start, &event->mmap2.len, prot,
 		       &event->mmap2.pgoff, &event->mmap2.maj,
 		       &event->mmap2.min,
@@ -1362,8 +1362,8 @@ size_t perf_event__fprintf_mmap(union perf_event *event, FILE *fp)
 
 size_t perf_event__fprintf_mmap2(union perf_event *event, FILE *fp)
 {
-	return fprintf(fp, " %d/%d: [%#" PRIx64 "(%#" PRIx64 ") @ %#" PRIx64
-			   " %02x:%02x %"PRIu64" %"PRIu64"]: %c%c%c%c %s\n",
+	return fprintf(fp, " %d/%d: [%#" PRI_lx64 "(%#" PRI_lx64 ") @ %#" PRI_lx64
+			   " %02x:%02x %"PRI_lu64" %"PRI_lu64"]: %c%c%c%c %s\n",
 		       event->mmap2.pid, event->mmap2.tid, event->mmap2.start,
 		       event->mmap2.len, event->mmap2.pgoff, event->mmap2.maj,
 		       event->mmap2.min, event->mmap2.ino,
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index f43eff2fba2d..af252be8ca5b 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -27,21 +27,6 @@
 #define PRI_lx64 PRIx64
 #endif
 
-struct mmap2_event {
-	struct perf_event_header header;
-	u32 pid, tid;
-	u64 start;
-	u64 len;
-	u64 pgoff;
-	u32 maj;
-	u32 min;
-	u64 ino;
-	u64 ino_generation;
-	u32 prot;
-	u32 flags;
-	char filename[PATH_MAX];
-};
-
 struct comm_event {
 	struct perf_event_header header;
 	u32 pid, tid;
-- 
2.21.0

