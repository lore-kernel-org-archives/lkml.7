Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D994EC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC353208C0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404941AbfITQVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 12:21:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52766 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404667AbfITQVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 12:21:10 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iBLeZ-00045x-M7; Fri, 20 Sep 2019 18:21:03 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5308B1C0E31;
        Fri, 20 Sep 2019 18:20:59 +0200 (CEST)
Date:   Fri, 20 Sep 2019 16:20:59 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf python: Remove debug.h
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-s0gy4ur3drmhsknsddwjco59@git.kernel.org>
References: <tip-s0gy4ur3drmhsknsddwjco59@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156899645927.24167.7411825787917240199.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     5939cacc60d22161adba3d6c8b3fe88b76e0f6c0
Gitweb:        https://git.kernel.org/tip/5939cacc60d22161adba3d6c8b3fe88b76e0f6c0
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Wed, 11 Sep 2019 12:54:33 +01:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 20 Sep 2019 09:19:21 -03:00

perf python: Remove debug.h

We only need to have the prototype for the eprintf() replacement we use
in the python binding, provide it and avoid dragging debug.h as a
dependency.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-s0gy4ur3drmhsknsddwjco59@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/python.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 96dd333..0ba19dd 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -6,7 +6,6 @@
 #include <linux/err.h>
 #include <perf/cpumap.h>
 #include <traceevent/event-parse.h>
-#include "debug.h"
 #include "evlist.h"
 #include "callchain.h"
 #include "evsel.h"
@@ -60,6 +59,8 @@ int parse_callchain_record(const char *arg __maybe_unused,
  */
 int verbose;
 
+int eprintf(int level, int var, const char *fmt, ...);
+
 int eprintf(int level, int var, const char *fmt, ...)
 {
 	va_list args;
