Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC9AC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B343022CED
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567089652;
	bh=ulOrw1tBwMG5QY+3d6vyw3mQaBlkNbZwx5OuPu97xUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OD2tqclmHbpeLctqMpjcEtsNUlmZORIicfk8EAOH3N4x7QUBE4QuEJHJeAe2zqpj7
	 azpl2U+1ixArLarDhDCbwclVBTnLTmw2HthlrJsT63T2zSfhwLaRHYjeRD1I9TgSqU
	 yShIINz/2gOysO6kWF8n1Oef7/cQ4HoUCZY143mQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbfH2Okv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 10:40:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:44638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728716AbfH2Oks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:40:48 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5649223429;
        Thu, 29 Aug 2019 14:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567089647;
        bh=ulOrw1tBwMG5QY+3d6vyw3mQaBlkNbZwx5OuPu97xUU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=av8i3aSCP4yrrHWuF2UK0Ohf6Qws/azZLYuyS34mln4EGsno+vaXoxTVCVvm92324
         IRX7h+ORWPHpXHdNDX8f9oI7gpDPWg/TOZX+rSUGVwzuwA+NWijscuWkmXl1tIcCMN
         LLabdriKYJcJ6PNMYoqzdxQhrTAr/N56qy4NX2DU=
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
Subject: [PATCH 22/37] libperf: Add PERF_RECORD_AUX 'struct aux_event' to perf/event.h
Date:   Thu, 29 Aug 2019 11:39:02 -0300
Message-Id: <20190829143917.29745-23-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190829143917.29745-1-acme@kernel.org>
References: <20190829143917.29745-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move the PERF_RECORD_AUX event definition to libperf's event.h.

In order to keep libperf simple, we switch 'u64/u32/u16/u8' types used
events to their generic '__u*' versions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190828135717.7245-12-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/perf/event.h | 7 +++++++
 tools/perf/util/event.c             | 2 +-
 tools/perf/util/event.h             | 7 -------
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index 6292b7c41bac..d453ac833a58 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -234,4 +234,11 @@ struct auxtrace_error_event {
 	char			 msg[MAX_AUXTRACE_ERROR_MSG];
 };
 
+struct aux_event {
+	struct perf_event_header header;
+	__u64			 aux_offset;
+	__u64			 aux_size;
+	__u64			 flags;
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index e33dd1a040cc..b048e6084612 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1449,7 +1449,7 @@ int perf_event__process_exit(struct perf_tool *tool __maybe_unused,
 
 size_t perf_event__fprintf_aux(union perf_event *event, FILE *fp)
 {
-	return fprintf(fp, " offset: %#"PRIx64" size: %#"PRIx64" flags: %#"PRIx64" [%s%s%s]\n",
+	return fprintf(fp, " offset: %#"PRI_lx64" size: %#"PRI_lx64" flags: %#"PRI_lx64" [%s%s%s]\n",
 		       event->aux.aux_offset, event->aux.aux_size,
 		       event->aux.flags,
 		       event->aux.flags & PERF_AUX_FLAG_TRUNCATED ? "T" : "",
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index e334ecbe50a0..db901aea33af 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -332,13 +332,6 @@ struct events_stats {
 	u32 nr_proc_map_timeout;
 };
 
-struct aux_event {
-	struct perf_event_header header;
-	u64	aux_offset;
-	u64	aux_size;
-	u64	flags;
-};
-
 struct itrace_start_event {
 	struct perf_event_header header;
 	u32 pid, tid;
-- 
2.21.0

