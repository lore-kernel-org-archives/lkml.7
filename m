Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B73CA9EB0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FCD220882
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730746AbfJVAEh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 20:04:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38895 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730718AbfJVAEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 20:04:34 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iMgxH-00049U-II; Tue, 22 Oct 2019 01:19:15 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 358851C04DD;
        Tue, 22 Oct 2019 01:19:12 +0200 (CEST)
Date:   Mon, 21 Oct 2019 23:19:11 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf string: Export asprintf__tp_filter_pids()
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Luis =?utf-8?q?Cl=C3=A1udio_Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-w3cuwjs63lxf5zpryy3145uv@git.kernel.org>
References: <tip-w3cuwjs63lxf5zpryy3145uv@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157169995179.29376.3543190043695058395.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     da949f507a73df5b5ad5031cb23b82a4d81846eb
Gitweb:        https://git.kernel.org/tip/da949f507a73df5b5ad5031cb23b82a4d81846eb
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 14 Oct 2019 20:10:50 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 15 Oct 2019 13:03:57 -03:00

perf string: Export asprintf__tp_filter_pids()

Will be used directly in 'perf trace' for setting up the command line
argv array to pass to cmd_record, as this was how 'perf trace record'
was implemented, following the model used in 'perf kvm record', 'perf
sched record', etc.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-w3cuwjs63lxf5zpryy3145uv@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c  | 3 ++-
 tools/perf/util/string2.h | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 8793b4e..0f9cd70 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -21,6 +21,7 @@
 #include "../perf.h"
 #include "asm/bug.h"
 #include "bpf-event.h"
+#include "util/string2.h"
 #include <signal.h>
 #include <unistd.h>
 #include <sched.h>
@@ -959,7 +960,7 @@ int perf_evlist__append_tp_filter(struct evlist *evlist, const char *filter)
 	return err;
 }
 
-static char *asprintf__tp_filter_pids(size_t npids, pid_t *pids)
+char *asprintf__tp_filter_pids(size_t npids, pid_t *pids)
 {
 	char *filter;
 	size_t i;
diff --git a/tools/perf/util/string2.h b/tools/perf/util/string2.h
index 708805f..73df616 100644
--- a/tools/perf/util/string2.h
+++ b/tools/perf/util/string2.h
@@ -4,6 +4,7 @@
 
 #include <linux/string.h>
 #include <linux/types.h>
+#include <sys/types.h> // pid_t
 #include <stddef.h>
 #include <string.h>
 
@@ -32,6 +33,8 @@ static inline char *asprintf_expr_not_in_ints(const char *var, size_t nints, int
 	return asprintf_expr_inout_ints(var, false, nints, ints);
 }
 
+char *asprintf__tp_filter_pids(size_t npids, pid_t *pids);
+
 char *strpbrk_esc(char *str, const char *stopset);
 char *strdup_esc(const char *str);
 
