Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A236BC3A59F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75ABB2080C
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566869921;
	bh=XAP+bFNfsfwa4XDcXB0WdP+rywPP34xU6eyFFIAkkdw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=le9g19wztZxCStJ2gNWWK95qyuT0ooebKOi7oylKY3tqW1jF+j+QFn2/lF7lr9JuS
	 +i5zfv0049aWjq7ZbCPemw7gRc6FmEDOilxELljoatnJolY+hIHMy0MQWibyTLCdH6
	 0hrlvNzHlus/nYKOfaUKQ3pJ3KhfpG+QVu84NHbU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbfH0Bh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 21:37:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:51074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729094AbfH0Bhx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 21:37:53 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C535F22CF5;
        Tue, 27 Aug 2019 01:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566869872;
        bh=XAP+bFNfsfwa4XDcXB0WdP+rywPP34xU6eyFFIAkkdw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p/rE6XCZUkxW+tewzh8GJuaxuZVcBK2XGIahclgj+0oAe+3IYyOMJAAL291SG2JxM
         ljracntKYWgpEFOLQY0hDjZurmLDkrJjJuDrlvgrr6Q2CFes2fU68YBa4xxa9kxXHw
         fW7dOkHWWXqIZDCAUYWy6UPqZaQ/CmR8KrRiUJJc=
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
Subject: [PATCH 23/33] libperf: Add PERF_RECORD_LOST_SAMPLES 'struct lost_samples_event' to perf/event.h
Date:   Mon, 26 Aug 2019 22:36:24 -0300
Message-Id: <20190827013634.3173-24-acme@kernel.org>
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

Move the PERF_RECORD_LOST_SAMPLES event definition into libperf's
event.h header include.

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

Add and use new PRI_lu64 and PRI_lx64 macros for that.  Use extra '_' to
ease up the reading and differentiate them from standard PRI*64 macros.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190825181752.722-8-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/perf/event.h | 5 +++++
 tools/perf/util/event.h             | 5 -----
 tools/perf/util/machine.c           | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index 71045ea8214c..86a779593405 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -56,4 +56,9 @@ struct lost_event {
 	__u64			 lost;
 };
 
+struct lost_samples_event {
+	struct perf_event_header header;
+	__u64			 lost;
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 4a3f50203d04..976a8f00d2a2 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -27,11 +27,6 @@
 #define PRI_lx64 PRIx64
 #endif
 
-struct lost_samples_event {
-	struct perf_event_header header;
-	u64 lost;
-};
-
 /*
  * PERF_FORMAT_ENABLED | PERF_FORMAT_RUNNING | PERF_FORMAT_ID
  */
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 1ad6e984c2f5..823aaf7b1b83 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -653,7 +653,7 @@ int machine__process_lost_event(struct machine *machine __maybe_unused,
 int machine__process_lost_samples_event(struct machine *machine __maybe_unused,
 					union perf_event *event, struct perf_sample *sample)
 {
-	dump_printf(": id:%" PRIu64 ": lost samples :%" PRIu64 "\n",
+	dump_printf(": id:%" PRIu64 ": lost samples :%" PRI_lu64 "\n",
 		    sample->id, event->lost_samples.lost);
 	return 0;
 }
-- 
2.21.0

