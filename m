Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE78C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E9D521721
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565808274;
	bh=rALSgB5DyqpzsfuTaocLyvXXUFv8NIwbvmoDKsPDAOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hHpL65lbta1bsUgkeHkG9csY9DA9OfBk5mSKxsFN5tXXkIwOOF0JRLC9TaU2IPjH9
	 EtwAR+Vqe6zA73oEO2YzQa/xjvCxYry35tYMDVINsC0G9Fwic7L3B3TdCnDONyq+67
	 8JZEG9kC4rDZjBI21kfxFclKrr4T4aVWGCjaaZIs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbfHNSod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:44:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:54422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728265AbfHNSod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:44:33 -0400
Received: from quaco.ghostprotocols.net (unknown [177.195.212.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C007E2064A;
        Wed, 14 Aug 2019 18:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565808272;
        bh=rALSgB5DyqpzsfuTaocLyvXXUFv8NIwbvmoDKsPDAOo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yRiGT9rfGeKptHZBnam88x474QLPR45bsduMMcW8DpAAyGY/GCfA/8xAQjvAqc+HH
         6j05PaMCqwj6wzLBc1lGjxP5HZsEdYr1r8dHt5avvbGlFVtTiZSHwPVbm5AHRgtR/t
         E8bw7lWEw41Xb1U5W9j8cgXQbTjlf2HecpWqARtc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Igor Lubashev <ilubashe@akamai.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 16/28] perf ftrace: Use CAP_SYS_ADMIN instead of euid==0
Date:   Wed, 14 Aug 2019 15:40:39 -0300
Message-Id: <20190814184051.3125-17-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190814184051.3125-1-acme@kernel.org>
References: <20190814184051.3125-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Lubashev <ilubashe@akamai.com>

The kernel requires CAP_SYS_ADMIN instead of euid==0 to mount debugfs
for ftrace.  Make perf do the same.

Signed-off-by: Igor Lubashev <ilubashe@akamai.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: James Morris <jmorris@namei.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/bd8763b72ed4d58d0b42d44fbc7eb474d32e53a3.1565188228.git.ilubashe@akamai.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-ftrace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 20d4c0ce8b53..01a5bb58eb04 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -13,6 +13,7 @@
 #include <signal.h>
 #include <fcntl.h>
 #include <poll.h>
+#include <linux/capability.h>
 
 #include "debug.h"
 #include <subcmd/parse-options.h>
@@ -21,6 +22,7 @@
 #include "target.h"
 #include "cpumap.h"
 #include "thread_map.h"
+#include "util/cap.h"
 #include "util/config.h"
 
 
@@ -281,7 +283,7 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 		.events = POLLIN,
 	};
 
-	if (geteuid() != 0) {
+	if (!perf_cap__capable(CAP_SYS_ADMIN)) {
 		pr_err("ftrace only works for root!\n");
 		return -1;
 	}
-- 
2.21.0

