Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F385EC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 12:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D16FE21897
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 12:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394480AbfHWMVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 08:21:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35190 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732316AbfHWMVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 08:21:48 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i18Za-0001i7-Tw; Fri, 23 Aug 2019 14:21:43 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8CD571C089A;
        Fri, 23 Aug 2019 14:21:42 +0200 (CEST)
Date:   Fri, 23 Aug 2019 12:21:42 -0000
From:   tip-bot2 for Arnaldo Carvalho de Melo <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf evsel: Move xyarray.h from evsel.c to evsel.h to reduce
 include dep tree
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <tip-wwqce6ixwcyq6yzx3ljrdm80@git.kernel.org>
References: <tip-wwqce6ixwcyq6yzx3ljrdm80@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156656290247.31560.11450295013203969135.tip-bot2@tip-bot2>
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

Commit-ID:     7646602401e6f45e4013ddb7c41f6bc211032d02
Gitweb:        https://git.kernel.org/tip/7646602401e6f45e4013ddb7c41f6bc211032d02
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Wed, 21 Aug 2019 11:30:29 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 22 Aug 2019 17:16:56 -03:00

perf evsel: Move xyarray.h from evsel.c to evsel.h to reduce include dep tree

All we need in util/evsel.h is the foward declaration of 'struct
xyarray', not the internal/xyarray.h, that can be moved to util/evsel.c
and then we reduce the header dependency tree.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-wwqce6ixwcyq6yzx3ljrdm80@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 1 +
 tools/perf/util/evsel.h | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 0a33f73..477c47c 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -39,6 +39,7 @@
 #include "string2.h"
 #include "memswap.h"
 #include "util/parse-branch-options.h"
+#include <internal/xyarray.h>
 
 #include <linux/ctype.h>
 
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index efe0806..2928eee 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -8,7 +8,6 @@
 #include <linux/perf_event.h>
 #include <linux/types.h>
 #include <internal/evsel.h>
-#include <internal/xyarray.h>
 #include "symbol_conf.h"
 #include "cpumap.h"
 #include "counts.h"
@@ -93,6 +92,7 @@ enum perf_tool_event {
 };
 
 struct bpf_object;
+struct xyarray;
 
 /** struct evsel - event selector
  *
