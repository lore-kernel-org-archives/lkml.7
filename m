Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798BAC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50AAD23403
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567089623;
	bh=bho52MFjeXSqX46GNRe658txdeWitAKtaiDk7HTT6z4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gWp/HmuSMlp3Vis1ukB2i3vlkLaDLpUft8ewyMyMuLwdpqQd4fViXi7zxT/agywd7
	 vnmbSGvsZXsL+ZcRsZMAeCCzU1DBFiE5O08OBpLSNblRIy3GNuALAUiaOFLMDKtNyc
	 URnYOlspwoDvaiCa+dwzC6fN79spp+abKt+P7vG8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbfH2OkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 10:40:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:44056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728517AbfH2OkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:40:19 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33CA922CED;
        Thu, 29 Aug 2019 14:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567089618;
        bh=bho52MFjeXSqX46GNRe658txdeWitAKtaiDk7HTT6z4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cO9nLekX339fJxQxBn7mIIlVeLs0xluSBBR1hOQo3xH3UEaZ5k4IfRcC4fdeYgR63
         qogsbaiP4MY+Y9x3od96PsQnoPl+5vyM4ODEahz8jcH3QQ/4MB5EXzNeGw8EEyJGwN
         b4oLINpUW7P2JDdLfhGyepxUPgk8ZVs+GRrGA+R4=
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
Subject: [PATCH 12/37] libperf: Add PERF_RECORD_HEADER_ATTR 'struct attr_event' to perf/event.h
Date:   Thu, 29 Aug 2019 11:38:52 -0300
Message-Id: <20190829143917.29745-13-acme@kernel.org>
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

Move the PERF_RECORD_HEADER_ATTR event definition to libperf's event.h.

In order to keep libperf simple, we switch 'u64/u32/u16/u8' types used
events to their generic '__u*' versions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190828135717.7245-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/perf/event.h | 6 ++++++
 tools/perf/util/event.h             | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index 36ad3a4a79e6..bb66da57d366 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -109,4 +109,10 @@ struct perf_record_sample {
 	__u64			 array[];
 };
 
+struct attr_event {
+	struct perf_event_header header;
+	struct perf_event_attr	 attr;
+	__u64			 id[];
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 429a3fe52d6c..21fa6c2acea4 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -363,12 +363,6 @@ struct cpu_map_event {
 	struct cpu_map_data		data;
 };
 
-struct attr_event {
-	struct perf_event_header header;
-	struct perf_event_attr attr;
-	u64 id[];
-};
-
 enum {
 	PERF_EVENT_UPDATE__UNIT  = 0,
 	PERF_EVENT_UPDATE__SCALE = 1,
-- 
2.21.0

