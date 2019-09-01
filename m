Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BDBC3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFC392377F
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567340658;
	bh=wvL+Evt9KA/rLqyZNsJgxJFu88geXdXhIaL9asGCKpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cQVvRP8WIPEsL9HhT+A9ntgDJyXnQvcaBLMtc3FqliJtXMCbTt63cOj8o7arqwba8
	 uf4Z5SORXmLJR/wTQS6n/i0EwcztZf6S8LspF4fZkJbU9KA2zMxyAPLH33wrsaLJO9
	 Xx6chpshc5ovSoiO+AfC6lzJjsKPBoWFMUR4MjtU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbfIAMYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 08:24:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:40822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728937AbfIAMYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 08:24:06 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D8D22343A;
        Sun,  1 Sep 2019 12:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567340645;
        bh=wvL+Evt9KA/rLqyZNsJgxJFu88geXdXhIaL9asGCKpM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=avDC8f3ZkU9gVjM/VCNfyHT3kAWZsx1fo/5uOJZCUG5IVqiKNaqM/8ZAA1CHSo8bO
         AhJWxX06KMZWkKlzn1Cemcmn679ipRyREHtlKDZ8b6i6Cxe3P6KfWOCPWMHblY7ohx
         qm2heUCX/EPhdjr5qaN1muVsaCNQ6c/xIqmlkjVc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>
Subject: [PATCH 09/47] perf tools: Remove needless libtraceevent include directives
Date:   Sun,  1 Sep 2019 09:22:48 -0300
Message-Id: <20190901122326.5793-10-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190901122326.5793-1-acme@kernel.org>
References: <20190901122326.5793-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Remove traceevent/event-parse.h and traceevent/trace-seq.h from places
where it is not needed.

Should avoid rebuilding those files when these traceevent headers get
changed.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Link: https://lkml.kernel.org/n/tip-26hn75jn9rdealn4uqtzend6@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-timechart.c | 1 -
 tools/perf/util/session.c      | 1 -
 tools/perf/util/trace-event.h  | 1 -
 3 files changed, 3 deletions(-)

diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 1ff81a790931..1a74499f3311 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -10,7 +10,6 @@
 
 #include <errno.h>
 #include <inttypes.h>
-#include <traceevent/event-parse.h>
 
 #include "builtin.h"
 #include "util/color.h"
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 13486bcf74a0..9eb843e5e6f0 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -4,7 +4,6 @@
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/zalloc.h>
-#include <traceevent/event-parse.h>
 #include <api/fs/fs.h>
 
 #include <byteswap.h>
diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
index 258d79071d81..2e158387b3d7 100644
--- a/tools/perf/util/trace-event.h
+++ b/tools/perf/util/trace-event.h
@@ -3,7 +3,6 @@
 #define _PERF_UTIL_TRACE_EVENT_H
 
 #include <traceevent/event-parse.h>
-#include <traceevent/trace-seq.h>
 #include "parse-events.h"
 
 struct machine;
-- 
2.21.0

