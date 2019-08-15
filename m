Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5846BC31E40
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28CCC21855
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="AI+AVi7A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731187AbfHOJTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 05:19:43 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33455 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730029AbfHOJTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 05:19:42 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7F9JRe82270798
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 15 Aug 2019 02:19:27 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7F9JRe82270798
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565860768;
        bh=jt09sm/FbqS3/ZRBM+eduG92Hd9GagXxLGOwzPm+ryw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=AI+AVi7AvO7LFw7jGYZYswn0g/5wjpxzap+wtqOQKHhmfe8m/8lWPE7X9d5fJH1fD
         pwBwHcZmb6bY8nUw1D05iBDW45jkS+xLnBF8HMl2NxLWP6dFCoQkMaticlrfsmmJC7
         H712smotH49pfJBCLd+TnwlsM8pwkhUbb5cLTkXpDKz9+s+U6+cYUR2fk5Mo2Ajnql
         Q0Pi+ebncD9PmvsDTTevb5jWJHjZ6tvdhSwsY9WJo0d705Ev1ZUbuqEMzieYjEsKW2
         9uA9TfJQQJJvpYLfZfn/04OXL17I3I+mrwP4AwINi3Rj1zSO0r2Ix2mBypSOeTAo8+
         6xHE4UVQipUhQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7F9JQee2270795;
        Thu, 15 Aug 2019 02:19:26 -0700
Date:   Thu, 15 Aug 2019 02:19:26 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Luke Mujica <tipbot@zytor.com>
Message-ID: <tip-2b75863b0845764529e01014a5c90664d8044cbe@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        irogers@google.com, hpa@zytor.com, acme@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        peterz@infradead.org, eranian@google.com, lukemujica@google.com,
        mingo@kernel.org
Reply-To: acme@redhat.com, peterz@infradead.org, eranian@google.com,
          jolsa@redhat.com, linux-kernel@vger.kernel.org,
          irogers@google.com, hpa@zytor.com,
          alexander.shishkin@linux.intel.com, mingo@kernel.org,
          lukemujica@google.com, tglx@linutronix.de
In-Reply-To: <20190719202253.220261-1-lukemujica@google.com>
References: <20190719202253.220261-1-lukemujica@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Fix paths in include statements
Git-Commit-ID: 2b75863b0845764529e01014a5c90664d8044cbe
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

Commit-ID:  2b75863b0845764529e01014a5c90664d8044cbe
Gitweb:     https://git.kernel.org/tip/2b75863b0845764529e01014a5c90664d8044cbe
Author:     Luke Mujica <lukemujica@google.com>
AuthorDate: Fri, 19 Jul 2019 13:22:53 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 12 Aug 2019 16:26:02 -0300

perf tools: Fix paths in include statements

These paths point to the wrong location but still work because they get
picked up by a -I flag that happens to direct to the correct file. Fix
paths to lead to the actual file location without help from include
flags.

Signed-off-by: Luke Mujica <lukemujica@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20190719202253.220261-1-lukemujica@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/util/kvm-stat.c | 4 ++--
 tools/perf/arch/x86/util/tsc.c      | 6 +++---
 tools/perf/ui/helpline.c            | 4 ++--
 tools/perf/ui/util.c                | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/arch/x86/util/kvm-stat.c b/tools/perf/arch/x86/util/kvm-stat.c
index 54a3f2373c35..81b531a707bf 100644
--- a/tools/perf/arch/x86/util/kvm-stat.c
+++ b/tools/perf/arch/x86/util/kvm-stat.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
-#include "../../util/kvm-stat.h"
-#include "../../util/evsel.h"
+#include "../../../util/kvm-stat.h"
+#include "../../../util/evsel.h"
 #include <asm/svm.h>
 #include <asm/vmx.h>
 #include <asm/kvm.h>
diff --git a/tools/perf/arch/x86/util/tsc.c b/tools/perf/arch/x86/util/tsc.c
index 950539f9a4f7..b1eb963b4a6e 100644
--- a/tools/perf/arch/x86/util/tsc.c
+++ b/tools/perf/arch/x86/util/tsc.c
@@ -5,10 +5,10 @@
 #include <linux/stddef.h>
 #include <linux/perf_event.h>
 
-#include "../../perf.h"
+#include "../../../perf.h"
 #include <linux/types.h>
-#include "../../util/debug.h"
-#include "../../util/tsc.h"
+#include "../../../util/debug.h"
+#include "../../../util/tsc.h"
 
 int perf_read_tsc_conversion(const struct perf_event_mmap_page *pc,
 			     struct perf_tsc_conversion *tc)
diff --git a/tools/perf/ui/helpline.c b/tools/perf/ui/helpline.c
index b3c421429ed4..54bcd08df87e 100644
--- a/tools/perf/ui/helpline.c
+++ b/tools/perf/ui/helpline.c
@@ -3,10 +3,10 @@
 #include <stdlib.h>
 #include <string.h>
 
-#include "../debug.h"
+#include "../util/debug.h"
 #include "helpline.h"
 #include "ui.h"
-#include "../util.h"
+#include "../util/util.h"
 
 char ui_helpline__current[512];
 
diff --git a/tools/perf/ui/util.c b/tools/perf/ui/util.c
index 63bf06e80ab9..9ed76e88a3e4 100644
--- a/tools/perf/ui/util.c
+++ b/tools/perf/ui/util.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "util.h"
-#include "../debug.h"
+#include "../util/debug.h"
 
 
 /*
