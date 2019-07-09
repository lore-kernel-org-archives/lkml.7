Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D33C73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5606320665
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562697161;
	bh=BcupqZH5L5bwXl/bKLOaWHacm7+i8mnDpt5/LYy/Dp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YETa4iCDFw3kpoLO889zReRNo11a0p4Ze0ypyluAlbb9UMIAfERbqGh/McjAfvgb8
	 wNGnCoHESbuUv8YKPQC/yumOK3VCnPmiriNO9iTNDCHQQVkLjYunk8krUcmI8jLzn4
	 tqiD7QZdeLauO5bLr8gyn55PWlAUsvYkn9b0mkEA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfGIScj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 14:32:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:54126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729166AbfGISci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 14:32:38 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CE6821670;
        Tue,  9 Jul 2019 18:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562697157;
        bh=BcupqZH5L5bwXl/bKLOaWHacm7+i8mnDpt5/LYy/Dp8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FvZvVMaOc+mGSU4lq6omU04mv0Ca2IQKCdIvNgr0XzKlo38LcNZEKB65eEpkvn842
         4lvi49NunJQFyTf/egsFlaRhjXF9m2lcEifrM1FhU1WDBbOXJNRAuC5LTU3IrZn1qu
         Paz9YdeC1F+cmwkKTs6fiQXnsUlNYctPZXJxF1ng=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 12/25] perf tools: Move get_current_dir_name() cond prototype out of util.h
Date:   Tue,  9 Jul 2019 15:31:13 -0300
Message-Id: <20190709183126.30257-13-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190709183126.30257-1-acme@kernel.org>
References: <20190709183126.30257-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
 create mode 100644 tools/perf/util/get_current_dir_name.h

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
-- 
2.21.0

