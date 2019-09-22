Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F04C3A5A6
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FBA7206C2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569179515;
	bh=zIB6enQRKUOm7r8yE168P/tQImuRNxbYA2o2FnrrdMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N7wma+D/naBnGNLCkNNAFWP1wUO7z5fFDR6tsUUG5OOyFU9Gf3QQuYZTmfWeqovK0
	 VdG10q/L/plRFKfjs5/Eshl3vxPFh/37Q2NQ+Ar1C+US2AlpA2lbkulhZIoUuoRiG8
	 S3CLKN6bCK5MWTW4wXRAzrvsxjbnqayKJR9XwLoY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436637AbfIVTLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 15:11:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:32778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394876AbfIVS6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 14:58:20 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2905921BE5;
        Sun, 22 Sep 2019 18:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178699;
        bh=zIB6enQRKUOm7r8yE168P/tQImuRNxbYA2o2FnrrdMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iZ3c3gQLPjSk+xfOqBexFsEARoqbyg48aK+WuZTRnW2V+qczs7Z8jnDx8MAAtJNRR
         Gte6cRp+c4WxXb8Cx0j03R0gfKF/Xv3Fjp3pzEH5DRDwZqvT83GCu7G5bLhm9rd4nH
         GHcOqawOlRnx21P17u9kOM2PN6ULNx6Ucq5ph2Wc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Igor Lubashev <ilubashe@akamai.com>, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 38/89] perf ftrace: Use CAP_SYS_ADMIN instead of euid==0
Date:   Sun, 22 Sep 2019 14:56:26 -0400
Message-Id: <20190922185717.3412-38-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922185717.3412-1-sashal@kernel.org>
References: <20190922185717.3412-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Lubashev <ilubashe@akamai.com>

[ Upstream commit c766f3df635de14295e410c6dd5410bc416c24a0 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/builtin-ftrace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 13a33fb71a6da..6f07c5541fdea 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -14,6 +14,7 @@
 #include <signal.h>
 #include <fcntl.h>
 #include <poll.h>
+#include <linux/capability.h>
 
 #include "debug.h"
 #include <subcmd/parse-options.h>
@@ -22,6 +23,7 @@
 #include "target.h"
 #include "cpumap.h"
 #include "thread_map.h"
+#include "util/cap.h"
 #include "util/config.h"
 
 
@@ -270,7 +272,7 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 		.events = POLLIN,
 	};
 
-	if (geteuid() != 0) {
+	if (!perf_cap__capable(CAP_SYS_ADMIN)) {
 		pr_err("ftrace only works for root!\n");
 		return -1;
 	}
-- 
2.20.1

