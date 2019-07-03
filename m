Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CA9C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD47521881
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="AGWL/uod"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfGCOQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:16:45 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56863 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfGCOQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:16:45 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x63EGOup3322820
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 07:16:24 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x63EGOup3322820
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562163385;
        bh=wM56GBSddd8n//6PR4NJTkHaLEt/Awr3gbIrt0w+4Ig=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=AGWL/uodiH2e5mD99TzEq1mHhMsbHBGW7ko1OwlupRhIZCepI3TnC0Yhzfbh5odI0
         x5p/17D6fmG75VPssY9tWY0Uu3DajPye81MgT7+dnvVieWUbKpKvfeZxISEr9F0atY
         cf9q+aDuXxzkXuLxVJFtIvqvHkV328QxgUlp/VOJjKMBNYMCA41AldnwC6tCQEq42C
         ID7rDXa0VF+xvk/Lq135K3FKgv8St/kriziFIY8eoWl/avafu6u81UrbQgKgWvLs3J
         gBLEGZTi9/TT475N6TusZJXrQj3bogY9E2vLTqeamW9BLZGegKwT0pzzz3vpgSCDLa
         CiqDBLlcaRryg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x63EGNRG3322817;
        Wed, 3 Jul 2019 07:16:23 -0700
Date:   Wed, 3 Jul 2019 07:16:23 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-wa4nz4kt61eze88eprk20tfd@git.kernel.org>
Cc:     hpa@zytor.com, acme@redhat.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        namhyung@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com
Reply-To: namhyung@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
          hpa@zytor.com, acme@redhat.com, tglx@linutronix.de,
          mingo@kernel.org, linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Use linux/ctype.h in more places
Git-Commit-ID: bd9860bf050f77c4e260a9ae10a5587009ad6e07
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

Commit-ID:  bd9860bf050f77c4e260a9ae10a5587009ad6e07
Gitweb:     https://git.kernel.org/tip/bd9860bf050f77c4e260a9ae10a5587009ad6e07
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 25 Jun 2019 21:13:51 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 25 Jun 2019 21:13:51 -0300

perf tools: Use linux/ctype.h in more places

There were a few places where we still were using the libc version of
ctype.h, switch to the one in tools/lib/ctype.c that the rest of perf
uses.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-wa4nz4kt61eze88eprk20tfd@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/s390/util/header.c | 2 +-
 tools/perf/util/metricgroup.c      | 2 +-
 tools/perf/util/time-utils.c       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/arch/s390/util/header.c b/tools/perf/arch/s390/util/header.c
index 3db85cd2069e..a25896135abe 100644
--- a/tools/perf/arch/s390/util/header.c
+++ b/tools/perf/arch/s390/util/header.c
@@ -11,7 +11,7 @@
 #include <unistd.h>
 #include <stdio.h>
 #include <string.h>
-#include <ctype.h>
+#include <linux/ctype.h>
 
 #include "../../util/header.h"
 #include "../../util/util.h"
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 699e020737d9..a0cf3cd95ced 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -17,7 +17,7 @@
 #include "pmu-events/pmu-events.h"
 #include "strlist.h"
 #include <assert.h>
-#include <ctype.h>
+#include <linux/ctype.h>
 
 struct metric_event *metricgroup__lookup(struct rblist *metric_events,
 					 struct perf_evsel *evsel,
diff --git a/tools/perf/util/time-utils.c b/tools/perf/util/time-utils.c
index 2b48816a2d2e..369fa19dd596 100644
--- a/tools/perf/util/time-utils.c
+++ b/tools/perf/util/time-utils.c
@@ -7,7 +7,7 @@
 #include <errno.h>
 #include <inttypes.h>
 #include <math.h>
-#include <ctype.h>
+#include <linux/ctype.h>
 
 #include "perf.h"
 #include "debug.h"
