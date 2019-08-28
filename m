Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E83C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06FC9233FF
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567000674;
	bh=WYmvE4grZS1AXS9JrpGUcUTybSVIOMaRUJHQQuW0d9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sVLKaUD2YBTDkZfwOjr0ytyt9lhQla47yxt7sOv5SRHIQymJf66sFhZp2bDbFrayx
	 cNHwJL3sqA5KtowMbHw6/sBi1ioCvvIu0wu+TVlu5hqUZ4MPeK51pWwVw3Q8ScPmVG
	 c2QapUipyDNdX/ccq9XSB2AKCqVwukoBs4shGT4Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfH1N5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 09:57:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51218 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726947AbfH1N5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:57:47 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C1F7E8980EA;
        Wed, 28 Aug 2019 13:57:46 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2466E1001B00;
        Wed, 28 Aug 2019 13:57:43 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 12/23] libperf: Add PERF_RECORD_ITRACE_START 'struct itrace_start_event' to perf/event.h
Date:   Wed, 28 Aug 2019 15:57:06 +0200
Message-Id: <20190828135717.7245-13-jolsa@kernel.org>
In-Reply-To: <20190828135717.7245-1-jolsa@kernel.org>
References: <20190828135717.7245-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.67]); Wed, 28 Aug 2019 13:57:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the PERF_RECORD_ITRACE_START event definition to libperf's event.h.

In order to keep libperf simple, we switch 'u64/u32/u16/u8'
types used events to their generic '__u*' versions.

Link: http://lkml.kernel.org/n/tip-it9jc5sr10hblg89ljuz7j93@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/include/perf/event.h | 6 ++++++
 tools/perf/util/event.h             | 5 -----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index d453ac833a58..3bcbc1eaeb35 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -241,4 +241,10 @@ struct aux_event {
 	__u64			 flags;
 };
 
+struct itrace_start_event {
+	struct perf_event_header header;
+	__u32			 pid;
+	__u32			 tid;
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index db901aea33af..f89e8ddadd46 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -332,11 +332,6 @@ struct events_stats {
 	u32 nr_proc_map_timeout;
 };
 
-struct itrace_start_event {
-	struct perf_event_header header;
-	u32 pid, tid;
-};
-
 struct context_switch_event {
 	struct perf_event_header header;
 	u32 next_prev_pid;
-- 
2.21.0

