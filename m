Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B14C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CBF2216C8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564455559;
	bh=M3imdE/64+OBNbl1Ye+5LF6F8i6HV+hEufphrQ8GLog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Cp5L+NNXkFndlBGnpz79yz5Iu2J0WRfKjt7yQ4d9VDnkTwX1Act5Bajy3LrQn/zKP
	 B5oJidIAGJXCFrczAyCJvKXNvfL9l4gjwXcy8UJdQRMINDbOXlBttvdvB4Fa5ceMYK
	 RvBJaQmXix1inGr8EpTlgfEvmoNiGXSewrHXqDfw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732185AbfG3C7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 22:59:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:48670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732158AbfG3C7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 22:59:15 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73F82206DD;
        Tue, 30 Jul 2019 02:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455554;
        bh=M3imdE/64+OBNbl1Ye+5LF6F8i6HV+hEufphrQ8GLog=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fIcbKV5fQbvvd0ixvZNQcR6EUNB/CJ68vIZHPKu9FK02zOIHTjghZwQYoQ0LzPJ7t
         RLsP/RgQEYg5Twd/KkJvakSB5/PEGMHGHJaA0/wV9iKXyULXizsUBvHG9EInT1pN/Q
         wF7hPP6g90a3qHkO2OMhcm+ZC40DVm2v/Ww43/XM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 053/107] libperf: Add perf/core.h header
Date:   Mon, 29 Jul 2019 23:55:16 -0300
Message-Id: <20190730025610.22603-54-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190730025610.22603-1-acme@kernel.org>
References: <20190730025610.22603-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add perf/core.h header to be used in header files coming in the
following patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-27-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/perf/core.h | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 tools/perf/lib/include/perf/core.h

diff --git a/tools/perf/lib/include/perf/core.h b/tools/perf/lib/include/perf/core.h
new file mode 100644
index 000000000000..e2e4b43c9131
--- /dev/null
+++ b/tools/perf/lib/include/perf/core.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LIBPERF_CORE_H
+#define __LIBPERF_CORE_H
+
+#ifndef LIBPERF_API
+#define LIBPERF_API __attribute__((visibility("default")))
+#endif
+
+#endif /* __LIBPERF_CORE_H */
-- 
2.21.0

