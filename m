Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A6AC3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 12:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9958821848
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 12:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732426AbfHWM3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 08:29:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35355 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730804AbfHWM3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 08:29:33 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i18h2-00024i-Uk; Fri, 23 Aug 2019 14:29:25 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 838901C04F3;
        Fri, 23 Aug 2019 14:29:24 +0200 (CEST)
Date:   Fri, 23 Aug 2019 12:29:24 -0000
From:   tip-bot2 for Gerald BAEZA <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] libperf: Fix alignment trap with xyarray contents in 'perf
 stat'
Cc:     Gerald Baeza <gerald.baeza@st.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1566464769-16374-1-git-send-email-gerald.baeza@st.com>
References: <1566464769-16374-1-git-send-email-gerald.baeza@st.com>
MIME-Version: 1.0
Message-ID: <156656336440.32674.1760481697733567809.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from
 these emails
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     d9c5c083416500e95da098c01be092b937def7fa
Gitweb:        https://git.kernel.org/tip/d9c5c083416500e95da098c01be092b937def7fa
Author:        Gerald BAEZA <gerald.baeza@st.com>
AuthorDate:    Thu, 22 Aug 2019 09:07:01 
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 22 Aug 2019 17:16:57 -03:00

libperf: Fix alignment trap with xyarray contents in 'perf stat'

Following the patch 'perf stat: Fix --no-scale', an alignment trap
happens in process_counter_values() on ARMv7 platforms due to the
attempt to copy non 64 bits aligned double words (pointed by 'count')
via a NEON vectored instruction ('vld1' with 64 bits alignment
constraint).

This patch sets a 64 bits alignment constraint on 'contents[]' field in
'struct xyarray' since the 'count' pointer used above points to such a
structure.

Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1566464769-16374-1-git-send-email-gerald.baeza@st.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/internal/xyarray.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/lib/include/internal/xyarray.h b/tools/perf/lib/include/internal/xyarray.h
index 3bf70e4..51e35d6 100644
--- a/tools/perf/lib/include/internal/xyarray.h
+++ b/tools/perf/lib/include/internal/xyarray.h
@@ -2,6 +2,7 @@
 #ifndef __LIBPERF_INTERNAL_XYARRAY_H
 #define __LIBPERF_INTERNAL_XYARRAY_H
 
+#include <linux/compiler.h>
 #include <sys/types.h>
 
 struct xyarray {
@@ -10,7 +11,7 @@ struct xyarray {
 	size_t entries;
 	size_t max_x;
 	size_t max_y;
-	char contents[];
+	char contents[] __aligned(8);
 };
 
 struct xyarray *xyarray__new(int xlen, int ylen, size_t entry_size);
