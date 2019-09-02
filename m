Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9009C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C767C215EA
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730564AbfIBIS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 04:18:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56238 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730189AbfIBIQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 04:16:43 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i4hVh-0007ya-UR; Mon, 02 Sep 2019 10:16:26 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8D30E1C0793;
        Mon,  2 Sep 2019 10:16:25 +0200 (CEST)
Date:   Mon, 02 Sep 2019 08:16:25 -0000
From:   "tip-bot2 for Kyle Meyer" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf header: Replace MAX_NR_CPUS with cpu__max_cpu()
Cc:     Kyle Meyer <kyle.meyer@hpe.com>, Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Russ Anderson <russ.anderson@hpe.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190827214352.94272-7-meyerk@stormcage.eag.rdlabs.hpecorp.net>
References: <20190827214352.94272-7-meyerk@stormcage.eag.rdlabs.hpecorp.net>
MIME-Version: 1.0
Message-ID: <156741218548.17283.4925605246141492237.tip-bot2@tip-bot2>
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

Commit-ID:     dc84187f32a3e8eb86bd97f3b10494e1f1fe5e7f
Gitweb:        https://git.kernel.org/tip/dc84187f32a3e8eb86bd97f3b10494e1f1fe5e7f
Author:        Kyle Meyer <meyerk@hpe.com>
AuthorDate:    Tue, 27 Aug 2019 16:43:51 -05:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 29 Aug 2019 17:38:32 -03:00

perf header: Replace MAX_NR_CPUS with cpu__max_cpu()

The function cpu__max_cpu() returns the possible number of CPUs as
defined in the sysfs and can be used as an alternative for MAX_NR_CPUS
in write_cache.

MAX_CACHES is replaced by cpu__max_cpu() * MAX_CACHE_LVL.

Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
Reviewed-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Russ Anderson <russ.anderson@hpe.com>
Link: http://lore.kernel.org/lkml/20190827214352.94272-7-meyerk@stormcage.eag.rdlabs.hpecorp.net
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 0a842d9..dd2bb08 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1122,16 +1122,17 @@ static int build_caches(struct cpu_cache_level caches[], u32 size, u32 *cntp)
 	return 0;
 }
 
-#define MAX_CACHES (MAX_NR_CPUS * 4)
+#define MAX_CACHE_LVL 4
 
 static int write_cache(struct feat_fd *ff,
 		       struct evlist *evlist __maybe_unused)
 {
-	struct cpu_cache_level caches[MAX_CACHES];
+	u32 max_caches = cpu__max_cpu() * MAX_CACHE_LVL;
+	struct cpu_cache_level caches[max_caches];
 	u32 cnt = 0, i, version = 1;
 	int ret;
 
-	ret = build_caches(caches, MAX_CACHES, &cnt);
+	ret = build_caches(caches, max_caches, &cnt);
 	if (ret)
 		goto out;
 
