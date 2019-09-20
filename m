Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2C4C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFACA208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568989622;
	bh=4reO+khlH9f+4DYYFudb45FXnfmDwrBrRKe7ID+l8+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hjkO7bqweXL5LLQL2i7CFsTmAgpU9dbWoaDVxswB1vQWzJcVeVcGtbup9eTQ0EU8S
	 kgLSDS/DNy3Qc6ww9F+YRv8HQzOHJs4WHF6RGmebOGlXpbxxnABS30nvlDzLupdO0r
	 J3XTBBTy45uvY1WkYR3XaJbGmbQz2v0IMv1MDGI0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389499AbfITO1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 10:27:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:38694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388909AbfITO0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 10:26:14 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B83972173E;
        Fri, 20 Sep 2019 14:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568989573;
        bh=4reO+khlH9f+4DYYFudb45FXnfmDwrBrRKe7ID+l8+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TcP7QIhlOYz8aBXc6I7fUOjSzTyX8s5QzYyODOKQLy6hnrpg+tu1sQAyi4ihDEBff
         DTUgiUPvzLMZSFgztCb6LCwT5dWujYUElqlYFSTnoGPfMq+pkupkjMe95J6Llnq4h3
         Z83bnfaV932hVMyYVMnfsdE1Cqor/t/k6+SIrmcA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 07/31] perf tools: Remove needless builtin.h include directives
Date:   Fri, 20 Sep 2019 11:25:18 -0300
Message-Id: <20190920142542.12047-8-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190920142542.12047-1-acme@kernel.org>
References: <20190920142542.12047-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Now that builtin.h isn't included by any other header, we can check
where it is really needed, i.e. we can remove it and be sure that it
isn't being obtained indirectly.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-mn7jheex85iw9qo6tlv26hb2@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/bench/numa.c            | 1 -
 tools/perf/bench/sched-messaging.c | 1 -
 tools/perf/bench/sched-pipe.c      | 1 -
 tools/perf/util/jitdump.c          | 1 -
 4 files changed, 4 deletions(-)

diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
index 62b8ef4bcb1f..5797253b9700 100644
--- a/tools/perf/bench/numa.c
+++ b/tools/perf/bench/numa.c
@@ -9,7 +9,6 @@
 /* For the CLR_() macros */
 #include <pthread.h>
 
-#include "../builtin.h"
 #include <subcmd/parse-options.h>
 #include "../util/cloexec.h"
 
diff --git a/tools/perf/bench/sched-messaging.c b/tools/perf/bench/sched-messaging.c
index c63eb9a46346..6e499b32bf00 100644
--- a/tools/perf/bench/sched-messaging.c
+++ b/tools/perf/bench/sched-messaging.c
@@ -12,7 +12,6 @@
 
 #include "../util/util.h"
 #include <subcmd/parse-options.h>
-#include "../builtin.h"
 #include "bench.h"
 
 /* Test groups of 20 processes spraying to 20 receivers */
diff --git a/tools/perf/bench/sched-pipe.c b/tools/perf/bench/sched-pipe.c
index 35b07f197d48..edd40aafa318 100644
--- a/tools/perf/bench/sched-pipe.c
+++ b/tools/perf/bench/sched-pipe.c
@@ -11,7 +11,6 @@
  */
 #include "../util/util.h"
 #include <subcmd/parse-options.h>
-#include "../builtin.h"
 #include "bench.h"
 
 #include <unistd.h>
diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index b80f29bfc7bb..00db9957fdb0 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -27,7 +27,6 @@
 #include "jit.h"
 #include "jitdump.h"
 #include "genelf.h"
-#include "../builtin.h"
 
 #include <linux/ctype.h>
 #include <linux/zalloc.h>
-- 
2.21.0

