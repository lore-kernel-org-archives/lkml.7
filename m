Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921F4C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6525020644
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567089658;
	bh=dOQNpxAC0ExSPIbky1nNtKw61tbR5ahWLNhqi75z7e8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WjY3wZiR2jbK9Yzni4Vjgfg11ASGD5QFqtoYYGUF6Gh/S6iyJ2st82PabP61ObyxJ
	 emxBEI6EGz3w4kDtdiH5MCVteQqwyakTcQbbQJBxaKzDFW7P7r+20mus/SasVRxBWJ
	 S1l7Ep5gbxjvuduTy00kN5Pu4pebzO06ynmAySVo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbfH2Ok4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 10:40:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:44774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728737AbfH2Oky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:40:54 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32F0523407;
        Thu, 29 Aug 2019 14:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567089653;
        bh=dOQNpxAC0ExSPIbky1nNtKw61tbR5ahWLNhqi75z7e8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xpyuGPszuAok+DlEV9ZW35erPM8h2ZTJrIqdymPLOzt6NcCuAuMKAtavEbdYBTw97
         VLrH0MTromjN0Y0TSKgUUc/G9Na8su7sNceDMx2l6uGo2c2l2a/QAUyaeqXS8mkrmD
         psAmoDYTxmNNtEjOEy/roHXwVt99eUJkQf4OR15k=
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
Subject: [PATCH 24/37] libperf: Add PERF_RECORD_SWITCH 'struct context_switch_event' to perf/event.h
Date:   Thu, 29 Aug 2019 11:39:04 -0300
Message-Id: <20190829143917.29745-25-acme@kernel.org>
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

Move the PERF_RECORD_SWITCH event definition to libperf's event.h.

In order to keep libperf simple, we switch 'u64/u32/u16/u8' types used
events to their generic '__u*' versions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190828135717.7245-14-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/perf/event.h | 6 ++++++
 tools/perf/util/event.h             | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index 3bcbc1eaeb35..a7b0344bb8b4 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -110,6 +110,12 @@ struct perf_record_sample {
 	__u64			 array[];
 };
 
+struct context_switch_event {
+	struct perf_event_header header;
+	__u32			 next_prev_pid;
+	__u32			 next_prev_tid;
+};
+
 struct attr_event {
 	struct perf_event_header header;
 	struct perf_event_attr	 attr;
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index f89e8ddadd46..012b2ba9a9a8 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -332,12 +332,6 @@ struct events_stats {
 	u32 nr_proc_map_timeout;
 };
 
-struct context_switch_event {
-	struct perf_event_header header;
-	u32 next_prev_pid;
-	u32 next_prev_tid;
-};
-
 struct thread_map_event_entry {
 	u64	pid;
 	char	comm[16];
-- 
2.21.0

