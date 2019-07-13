Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB9EC742D7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 11:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C19432083B
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 11:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="f8DoR9S3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbfGMLA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 07:00:26 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58883 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfGMLAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 07:00:25 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6DB0ITD3838650
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 13 Jul 2019 04:00:19 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6DB0ITD3838650
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563015619;
        bh=iu89fW5us/SMJemQhCaKfZJ9R6H53fK7iUWH3fQWux8=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=f8DoR9S3l2wNUU3IIoEdJeMlbOew3lKNmFE2dcJ2gKyy3G28fkI/Gjscp7L7L/OX6
         mQL9mu4UA4b9fbCh43LwLChZe0zdsbcPwxQBuynUG17Ot5H28n2c/HbKv5/YVXTRwG
         o0tVc3kvYxfMN/7ojGYytC3kfsNqD1LOoPj0qfeDyjR4aHN4KSvF/BueNCA2IlSPnC
         HOAtc7hXypUWrFqy9+PoKTfWR3y3O8MCu1SQS9g4uBbVlMWAOOZAYgPuZ3AcKQmnYY
         iN/OwWPu2IzAmfD8w9Jmbk+lkbXv+53fvQsSCy38BgN31I6SkrdnJAfeKZKOx6NhAk
         2Do/Jya0DucQQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6DB0Ifl3838647;
        Sat, 13 Jul 2019 04:00:18 -0700
Date:   Sat, 13 Jul 2019 04:00:18 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-xpzvuu9d0gei9jl9bkzgobln@git.kernel.org>
Cc:     namhyung@kernel.org, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, acme@redhat.com,
        jolsa@kernel.org, hpa@zytor.com, mingo@kernel.org
Reply-To: namhyung@kernel.org, linux-kernel@vger.kernel.org,
          adrian.hunter@intel.com, hpa@zytor.com, jolsa@kernel.org,
          tglx@linutronix.de, acme@redhat.com, mingo@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: Move get_current_dir_name() cond
 prototype out of util.h
Git-Commit-ID: e5653eb82ddc71ad8ffcbb3c74dd6f0c0230ab4c
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

Commit-ID:  e5653eb82ddc71ad8ffcbb3c74dd6f0c0230ab4c
Gitweb:     https://git.kernel.org/tip/e5653eb82ddc71ad8ffcbb3c74dd6f0c0230ab4c
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 5 Jul 2019 14:16:15 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 9 Jul 2019 10:13:26 -0300

perf tools: Move get_current_dir_name() cond prototype out of util.h

And in a separate header, so that we erode util.h a bit more.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-xpzvuu9d0gei9jl9bkzgobln@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/get_current_dir_name.c | 6 +++---
 tools/perf/util/get_current_dir_name.h | 8 ++++++++
 tools/perf/util/namespaces.c           | 1 +
 tools/perf/util/util.h                 | 4 ----
 4 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/get_current_dir_name.c b/tools/perf/util/get_current_dir_name.c
index 267aa609a582..01f32f26552d 100644
--- a/tools/perf/util/get_current_dir_name.c
+++ b/tools/perf/util/get_current_dir_name.c
@@ -1,8 +1,8 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2018, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
+// SPDX-License-Identifier: LGPL-2.1
+// Copyright (C) 2018, 2019 Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
 //
 #ifndef HAVE_GET_CURRENT_DIR_NAME
-#include "util.h"
+#include "get_current_dir_name.h"
 #include <unistd.h>
 #include <stdlib.h>
 #include <stdlib.h>
diff --git a/tools/perf/util/get_current_dir_name.h b/tools/perf/util/get_current_dir_name.h
new file mode 100644
index 000000000000..69f7d5537d32
--- /dev/null
+++ b/tools/perf/util/get_current_dir_name.h
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: LGPL-2.1
+// Copyright (C) 2018, 2019 Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
+//
+#ifndef __PERF_GET_CURRENT_DIR_NAME_H
+#ifndef HAVE_GET_CURRENT_DIR_NAME
+char *get_current_dir_name(void);
+#endif // HAVE_GET_CURRENT_DIR_NAME
+#endif // __PERF_GET_CURRENT_DIR_NAME_H
diff --git a/tools/perf/util/namespaces.c b/tools/perf/util/namespaces.c
index 023c4efd788d..fda2fa1e8819 100644
--- a/tools/perf/util/namespaces.c
+++ b/tools/perf/util/namespaces.c
@@ -7,6 +7,7 @@
 #include "namespaces.h"
 #include "util.h"
 #include "event.h"
+#include "get_current_dir_name.h"
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index 59fe33708090..cfc4d85bbd42 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -59,10 +59,6 @@ int fetch_kernel_version(unsigned int *puint,
 
 const char *perf_tip(const char *dirpath);
 
-#ifndef HAVE_GET_CURRENT_DIR_NAME
-char *get_current_dir_name(void);
-#endif
-
 #ifndef HAVE_SCHED_GETCPU_SUPPORT
 int sched_getcpu(void);
 #endif
