Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B879C31E40
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1BAD208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="LX0xnt5n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730390AbfHOJ3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 05:29:14 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38151 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfHOJ3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 05:29:13 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7F9Rm4P2273930
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 15 Aug 2019 02:27:48 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7F9Rm4P2273930
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565861269;
        bh=jlsBxp77Asfo/zJcUww11QSpMvlzdBF4vVG+TL/UKpk=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=LX0xnt5n9ymQMDCywqxfSLRJmHjnSn24HemXd0pIB3AkXKFGbW6Um3+esO5ZhXB0z
         Bvl3DYJdKy1Jwp6/27XIQwu3CZjQNmtp9nu+nSqqmN1cBQBRNq2HLzspFkK031Yln7
         jRs758vTr5AUUrP0oQLBGxXF2kbq9JhydXZ9TDAmrrzGZ5hl7M1Iig0qea4i4giEPi
         PH8PJ0f3ayuUlpUMQdUK3rb8npMvFicL6tfUo/1iWLEuDzEp1PGH1m0HUIvz7YhV7n
         kbyhJpCQZACC1MLD+uS5AqLbMoF0ItNG/or3uX0AYS79XtucAPro9wTd9MGQuztdat
         XH3bZ7PpnzTHg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7F9Rlvb2273927;
        Thu, 15 Aug 2019 02:27:47 -0700
Date:   Thu, 15 Aug 2019 02:27:47 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Igor Lubashev <tipbot@zytor.com>
Message-ID: <tip-c766f3df635de14295e410c6dd5410bc416c24a0@git.kernel.org>
Cc:     mingo@kernel.org, jmorris@namei.org, namhyung@kernel.org,
        alexander.shishkin@linux.intel.com, mathieu.poirier@linaro.org,
        acme@redhat.com, hpa@zytor.com, alexey.budankov@linux.intel.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        jolsa@kernel.org, ilubashe@akamai.com, suzuki.poulose@arm.com,
        tglx@linutronix.de
Reply-To: suzuki.poulose@arm.com, tglx@linutronix.de, ilubashe@akamai.com,
          jolsa@kernel.org, peterz@infradead.org,
          linux-kernel@vger.kernel.org, alexey.budankov@linux.intel.com,
          alexander.shishkin@linux.intel.com, mathieu.poirier@linaro.org,
          acme@redhat.com, hpa@zytor.com, namhyung@kernel.org,
          mingo@kernel.org, jmorris@namei.org
In-Reply-To: <bd8763b72ed4d58d0b42d44fbc7eb474d32e53a3.1565188228.git.ilubashe@akamai.com>
References: <bd8763b72ed4d58d0b42d44fbc7eb474d32e53a3.1565188228.git.ilubashe@akamai.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf ftrace: Use CAP_SYS_ADMIN instead of euid==0
Git-Commit-ID: c766f3df635de14295e410c6dd5410bc416c24a0
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  c766f3df635de14295e410c6dd5410bc416c24a0
Gitweb:     https://git.kernel.org/tip/c766f3df635de14295e410c6dd5410bc416c24a0
Author:     Igor Lubashev <ilubashe@akamai.com>
AuthorDate: Wed, 7 Aug 2019 10:44:17 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 14 Aug 2019 10:59:59 -0300

perf ftrace: Use CAP_SYS_ADMIN instead of euid==0

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
