Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5F1C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B096B222CA
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569458095;
	bh=lMhfzCiB5FtYjaqqt2YfpoxXEmUE/0wDwgDE0Sj3Lps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a/y1Cu/Hks16BfOTEIcTOw9IWXsseMJlaxd5XYggJ4TcyUrUs5XAiQfYhcg7lAUIk
	 ISV65m6lQ/9/4xZRSCkFTX3AOp6jqDghH5MRzrecr3dGQ019ZPuCY4yhBl5Ba3J3cL
	 BmgJs8qhTsJGQaq/TYne+Je+UhnDMrgTB+Bu05q8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388940AbfIZAey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 20:34:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:37538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388841AbfIZAet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 20:34:49 -0400
Received: from quaco.localdomain (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B91221D7B;
        Thu, 26 Sep 2019 00:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569458088;
        bh=lMhfzCiB5FtYjaqqt2YfpoxXEmUE/0wDwgDE0Sj3Lps=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OYHrX9YXOoknW192BPZTlh/U3vGAAOUpPpTEhthaXG4nrcn1NAnmraTnTskAZq/V5
         LuDcN4bqgizqkDlErSX22O+WQbFkN3hgawM+7mZ5k2apZ+EAGPTQ2PbHTrs3y0DkcS
         /kOiJ36I3Xz3C0wBGP3xv90TpSHszBlu2tjWZoZ8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 30/66] libperf: Add 'event_copy' to 'struct perf_mmap'
Date:   Wed, 25 Sep 2019 21:32:08 -0300
Message-Id: <20190926003244.13962-31-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move 'event_copy' from tools/perf's mmap to libperf's perf_mmap struct.

Committer notes:

Add linux/compiler.h as we need it for '__aligned'.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lore.kernel.org/lkml/20190913132355.21634-18-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/internal/mmap.h | 5 +++++
 tools/perf/util/mmap.c                 | 4 ++--
 tools/perf/util/mmap.h                 | 1 -
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/lib/include/internal/mmap.h b/tools/perf/lib/include/internal/mmap.h
index 47c09f375fb6..10653b6e864e 100644
--- a/tools/perf/lib/include/internal/mmap.h
+++ b/tools/perf/lib/include/internal/mmap.h
@@ -2,10 +2,14 @@
 #ifndef __LIBPERF_INTERNAL_MMAP_H
 #define __LIBPERF_INTERNAL_MMAP_H
 
+#include <linux/compiler.h>
 #include <linux/refcount.h>
 #include <linux/types.h>
 #include <stdbool.h>
 
+/* perf sample has 16 bits size limit */
+#define PERF_SAMPLE_MAX_SIZE (1 << 16)
+
 /**
  * struct perf_mmap - perf's ring buffer mmap details
  *
@@ -21,6 +25,7 @@ struct perf_mmap {
 	u64		 start;
 	u64		 end;
 	bool		 overwrite;
+	char		 event_copy[PERF_SAMPLE_MAX_SIZE] __aligned(8);
 };
 
 #endif /* __LIBPERF_INTERNAL_MMAP_H */
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index a8850ce2c2ff..4b8ec8dd79c5 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -51,7 +51,7 @@ static union perf_event *perf_mmap__read(struct mmap *map,
 		if ((*startp & map->core.mask) + size != ((*startp + size) & map->core.mask)) {
 			unsigned int offset = *startp;
 			unsigned int len = min(sizeof(*event), size), cpy;
-			void *dst = map->event_copy;
+			void *dst = map->core.event_copy;
 
 			do {
 				cpy = min(map->core.mask + 1 - (offset & map->core.mask), len);
@@ -61,7 +61,7 @@ static union perf_event *perf_mmap__read(struct mmap *map,
 				len -= cpy;
 			} while (len);
 
-			event = (union perf_event *)map->event_copy;
+			event = (union perf_event *)map->core.event_copy;
 		}
 
 		*startp += size;
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index d3e74c8da51a..75c77fa57121 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -23,7 +23,6 @@ struct aiocb;
 struct mmap {
 	struct perf_mmap	core;
 	struct auxtrace_mmap auxtrace_mmap;
-	char		 event_copy[PERF_SAMPLE_MAX_SIZE] __aligned(8);
 #ifdef HAVE_AIO_SUPPORT
 	struct {
 		void		 **data;
-- 
2.21.0

