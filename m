Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891EBC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 11:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5597D24655
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 11:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfLQLb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 06:31:59 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55023 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbfLQLb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 06:31:59 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ihB50-0007MM-3I; Tue, 17 Dec 2019 12:31:54 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B40A11C2A37;
        Tue, 17 Dec 2019 12:31:53 +0100 (CET)
Date:   Tue, 17 Dec 2019 11:31:53 -0000
From:   "tip-bot2 for Michael Petlan" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf header: Fix false warning when there are no
 duplicate cache entries
Cc:     Michael Petlan <mpetlan@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157658231353.30329.192775548688495092.tip-bot2@tip-bot2>
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

Commit-ID:     28707826877f84bce0977845ea529cbdd08e4e8d
Gitweb:        https://git.kernel.org/tip/28707826877f84bce0977845ea529cbdd08e4e8d
Author:        Michael Petlan <mpetlan@redhat.com>
AuthorDate:    Sun, 08 Dec 2019 17:20:56 +01:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 11 Dec 2019 12:28:14 -03:00

perf header: Fix false warning when there are no duplicate cache entries

Before this patch, perf expected that there might be NPROC*4 unique
cache entries at max, however, it also expected that some of them would
be shared and/or of the same size, thus the final number of entries
would be reduced to be lower than NPROC*4. In case the number of entries
hadn't been reduced (was NPROC*4), the warning was printed.

However, some systems might have unusual cache topology, such as the
following two-processor KVM guest:

	cpu  level  shared_cpu_list  size
	  0     1         0           32K
	  0     1         0           64K
	  0     2         0           512K
	  0     3         0           8192K
	  1     1         1           32K
	  1     1         1           64K
	  1     2         1           512K
	  1     3         1           8192K

This KVM guest has 8 (NPROC*4) unique cache entries, which used to make
perf printing the message, although there actually aren't "way too many
cpu caches".

v2: Removing unused argument.

v3: Unifying the way we obtain number of cpus.

v4: Removed '& UINT_MAX' construct which is redundant.

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
LPU-Reference: 20191208162056.20772-1-mpetlan@redhat.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 4d39a75..93ad278 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1089,21 +1089,18 @@ static void cpu_cache_level__fprintf(FILE *out, struct cpu_cache_level *c)
 	fprintf(out, "L%d %-15s %8s [%s]\n", c->level, c->type, c->size, c->map);
 }
 
-static int build_caches(struct cpu_cache_level caches[], u32 size, u32 *cntp)
+#define MAX_CACHE_LVL 4
+
+static int build_caches(struct cpu_cache_level caches[], u32 *cntp)
 {
 	u32 i, cnt = 0;
-	long ncpus;
 	u32 nr, cpu;
 	u16 level;
 
-	ncpus = sysconf(_SC_NPROCESSORS_CONF);
-	if (ncpus < 0)
-		return -1;
-
-	nr = (u32)(ncpus & UINT_MAX);
+	nr = cpu__max_cpu();
 
 	for (cpu = 0; cpu < nr; cpu++) {
-		for (level = 0; level < 10; level++) {
+		for (level = 0; level < MAX_CACHE_LVL; level++) {
 			struct cpu_cache_level c;
 			int err;
 
@@ -1123,18 +1120,12 @@ static int build_caches(struct cpu_cache_level caches[], u32 size, u32 *cntp)
 				caches[cnt++] = c;
 			else
 				cpu_cache_level__free(&c);
-
-			if (WARN_ONCE(cnt == size, "way too many cpu caches.."))
-				goto out;
 		}
 	}
- out:
 	*cntp = cnt;
 	return 0;
 }
 
-#define MAX_CACHE_LVL 4
-
 static int write_cache(struct feat_fd *ff,
 		       struct evlist *evlist __maybe_unused)
 {
@@ -1143,7 +1134,7 @@ static int write_cache(struct feat_fd *ff,
 	u32 cnt = 0, i, version = 1;
 	int ret;
 
-	ret = build_caches(caches, max_caches, &cnt);
+	ret = build_caches(caches, &cnt);
 	if (ret)
 		goto out;
 
