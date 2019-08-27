Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9106C3A59F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A12EC23431
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566869868;
	bh=nDcEOJCWb4CdaN18SZlmDnHEt3V9rSZ367uBwE+Lx4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Zs2rTZHrOKlcVKTHKoXyKkCfIzVxXvEK7wQYzWloLtvC2MWK8tNmcrIJ97bYcxFJU
	 wH7/uQYMhsZSt1qgmM1pZ8yKK0DIaxRf3AeqvHKhxODQG8nekFqC1LJ4zvfdS9qv/k
	 qtL893SuB+Ipx5ZLwkmZX5NbO7TL83EarhI+RAYs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbfH0Bhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 21:37:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:50914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729072AbfH0Bhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 21:37:43 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 625C421881;
        Tue, 27 Aug 2019 01:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566869863;
        bh=nDcEOJCWb4CdaN18SZlmDnHEt3V9rSZ367uBwE+Lx4o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mhM2l8b6hZzvD77bkeToIwL3Nzg2TnhnMX8JbwPfQnppyqmKGhiQggaIR3qYb/6DQ
         lyTVkGENKQKlpWPbJufZtlHV1kI//6Qi8eQrSetQXwwso4lMLsY3Q/SZ/eW/KrKp0O
         nzE8UBE26RukCW+C+XEW4Fs6U253ArVN5qiBjopk=
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
Subject: [PATCH 20/33] libperf: Add PERF_RECORD_NAMESPACES 'struct namespaces_event' to perf/event.h
Date:   Mon, 26 Aug 2019 22:36:21 -0300
Message-Id: <20190827013634.3173-21-acme@kernel.org>
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

Move the namespaces_event event definition into libperf's event.h header
include.

In order to keep libperf simple, we switch 'u64/u32/u16/u8' types used
events to their generic '__u*' versions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190825181752.722-5-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/perf/event.h | 7 +++++++
 tools/perf/util/event.h             | 7 -------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index 3729a7d9253e..b90a8a21e613 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -36,4 +36,11 @@ struct comm_event {
 	char			 comm[16];
 };
 
+struct namespaces_event {
+	struct perf_event_header header;
+	__u32			 pid, tid;
+	__u64			 nr_namespaces;
+	struct perf_ns_link_info link_info[];
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index e8973a783267..0d3ac4fd3ecf 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -27,13 +27,6 @@
 #define PRI_lx64 PRIx64
 #endif
 
-struct namespaces_event {
-	struct perf_event_header header;
-	u32 pid, tid;
-	u64 nr_namespaces;
-	struct perf_ns_link_info link_info[];
-};
-
 struct fork_event {
 	struct perf_event_header header;
 	u32 pid, ppid;
-- 
2.21.0

