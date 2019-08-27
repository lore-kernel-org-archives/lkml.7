Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A33FC3A59F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E95C21872
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566869884;
	bh=UY68OIrX0S015L2npmJ3LkMObNrolcv3toiMwtB+MDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kVaV82Bp+hU3Wz6l8sRKfCJtlwHYqPQIfse1ksIcOa2eF2Nl0iw/SG2btrB4hdD1U
	 ifVNzyu7q7pqxEYIBWqSqTfg8aQJ4AFSpNo/z3sGeuU04UXd1nPzw9IYoNZsDPlLp5
	 vSofmO/IfxvYobkn5gA78IxU/R0Gd1Y8BxnyOTm8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbfH0BiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 21:38:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:51158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729189AbfH0BiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 21:38:00 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11430233FF;
        Tue, 27 Aug 2019 01:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566869878;
        bh=UY68OIrX0S015L2npmJ3LkMObNrolcv3toiMwtB+MDY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZwuRWGsoTBVO+GOxjRXYC2YVZR1wRaU73KfmfTJkNv9fw9Btbg8W3oy/pt0eE2VfL
         01sMybzM+oTzMKoggC5QJPXRll3VquV5tKlfKEoaWItT+JCaOUI0xXf0XwHbHpuYiI
         FJdaoP+XR3fL3/qKM+VJztEX9zpe9mKDihs9e0Jk=
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
Subject: [PATCH 25/33] libperf: Add PERF_RECORD_THROTTLE 'struct throttle_event' to perf/event.h
Date:   Mon, 26 Aug 2019 22:36:26 -0300
Message-Id: <20190827013634.3173-26-acme@kernel.org>
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

Move the PERF_RECORD_THROTTLE event definition into libperf's event.h
header include.

In order to keep libperf simple, we switch 'u64/u32/u16/u8' types used
events to their generic '__u*' versions.

Perf added 'u*' types mainly to ease up printing __u64 values as stated
in the linux/types.h comment:

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
Link: http://lkml.kernel.org/r/20190825181752.722-10-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/perf/event.h | 7 +++++++
 tools/perf/util/event.h             | 7 -------
 tools/perf/util/python.c            | 4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index f1830702e49a..ef5ec66b566e 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -73,4 +73,11 @@ struct read_event {
 	__u64			 id;
 };
 
+struct throttle_event {
+	struct perf_event_header header;
+	__u64			 time;
+	__u64			 id;
+	__u64			 stream_id;
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 008a2839d667..40020f5b0484 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -27,13 +27,6 @@
 #define PRI_lx64 PRIx64
 #endif
 
-struct throttle_event {
-	struct perf_event_header header;
-	u64 time;
-	u64 id;
-	u64 stream_id;
-};
-
 #ifndef KSYM_NAME_LEN
 #define KSYM_NAME_LEN 256
 #endif
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 5be85f50cd1c..d21e270c7823 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -233,8 +233,8 @@ static PyObject *pyrf_throttle_event__repr(struct pyrf_event *pevent)
 {
 	struct throttle_event *te = (struct throttle_event *)(&pevent->event.header + 1);
 
-	return _PyUnicode_FromFormat("{ type: %sthrottle, time: %" PRIu64 ", id: %" PRIu64
-				   ", stream_id: %" PRIu64 " }",
+	return _PyUnicode_FromFormat("{ type: %sthrottle, time: %" PRI_lu64 ", id: %" PRI_lu64
+				   ", stream_id: %" PRI_lu64 " }",
 				   pevent->event.header.type == PERF_RECORD_THROTTLE ? "" : "un",
 				   te->time, te->id, te->stream_id);
 }
-- 
2.21.0

