Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDAAC3A5A7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF74C215EA
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730290AbfIBIQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 04:16:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56202 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730157AbfIBIQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 04:16:39 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i4hVr-00082U-88; Mon, 02 Sep 2019 10:16:35 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6669A1C0DF5;
        Mon,  2 Sep 2019 10:16:30 +0200 (CEST)
Date:   Mon, 02 Sep 2019 08:16:30 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf env: Remove env.h from other headers where just
 a fwd decl is needed
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-sw8k3kpla98pr3rqypbjk9hf@git.kernel.org>
References: <tip-sw8k3kpla98pr3rqypbjk9hf@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156741219030.17314.7245835187933451800.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     b6b5574b80d6ce6ca87ae3ea1e97cff1bf730f2e
Gitweb:        https://git.kernel.org/tip/b6b5574b80d6ce6ca87ae3ea1e97cff1bf730f2e
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Thu, 29 Aug 2019 17:10:59 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Sat, 31 Aug 2019 19:10:40 -03:00

perf env: Remove env.h from other headers where just a fwd decl is needed

And fixup the fallout of c files not building due to now missing
headers.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-sw8k3kpla98pr3rqypbjk9hf@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/common.h    | 4 +++-
 tools/perf/tests/mem2node.c | 2 ++
 tools/perf/util/cputopo.h   | 1 -
 tools/perf/util/mem2node.c  | 2 ++
 tools/perf/util/mem2node.h  | 3 ++-
 5 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/perf/arch/common.h b/tools/perf/arch/common.h
index c298a44..e965ed8 100644
--- a/tools/perf/arch/common.h
+++ b/tools/perf/arch/common.h
@@ -2,7 +2,9 @@
 #ifndef ARCH_PERF_COMMON_H
 #define ARCH_PERF_COMMON_H
 
-#include "../util/env.h"
+#include <stdbool.h>
+
+struct perf_env;
 
 int perf_env__lookup_objdump(struct perf_env *env, const char **path);
 bool perf_env__single_address_space(struct perf_env *env);
diff --git a/tools/perf/tests/mem2node.c b/tools/perf/tests/mem2node.c
index 73b2855..7672ade 100644
--- a/tools/perf/tests/mem2node.c
+++ b/tools/perf/tests/mem2node.c
@@ -1,10 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/compiler.h>
 #include <linux/bitmap.h>
+#include <linux/kernel.h>
 #include <linux/zalloc.h>
 #include <perf/cpumap.h>
 #include "cpumap.h"
 #include "debug.h"
+#include "env.h"
 #include "mem2node.h"
 #include "tests.h"
 
diff --git a/tools/perf/util/cputopo.h b/tools/perf/util/cputopo.h
index bae2f1d..7bf6b81 100644
--- a/tools/perf/util/cputopo.h
+++ b/tools/perf/util/cputopo.h
@@ -3,7 +3,6 @@
 #define __PERF_CPUTOPO_H
 
 #include <linux/types.h>
-#include "env.h"
 
 struct cpu_topology {
 	u32	  core_sib;
diff --git a/tools/perf/util/mem2node.c b/tools/perf/util/mem2node.c
index 14fb9e7..797d86a 100644
--- a/tools/perf/util/mem2node.c
+++ b/tools/perf/util/mem2node.c
@@ -1,8 +1,10 @@
 #include <errno.h>
 #include <inttypes.h>
 #include <linux/bitmap.h>
+#include <linux/kernel.h>
 #include <linux/zalloc.h>
 #include "debug.h"
+#include "env.h"
 #include "mem2node.h"
 
 struct phys_entry {
diff --git a/tools/perf/util/mem2node.h b/tools/perf/util/mem2node.h
index 59c4752..8dfa2b5 100644
--- a/tools/perf/util/mem2node.h
+++ b/tools/perf/util/mem2node.h
@@ -2,8 +2,9 @@
 #define __MEM2NODE_H
 
 #include <linux/rbtree.h>
-#include "env.h"
+#include <linux/types.h>
 
+struct perf_env;
 struct phys_entry;
 
 struct mem2node {
