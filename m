Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E97C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 08:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B1B62071C
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 08:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfKWIPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 03:15:40 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36336 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbfKWIPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 03:15:21 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iYQZW-0002ds-Vb; Sat, 23 Nov 2019 09:15:15 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4FB701C1ADC;
        Sat, 23 Nov 2019 09:15:03 +0100 (CET)
Date:   Sat, 23 Nov 2019 08:15:03 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf map: Move comparision of map's dso_id to a
 separate function
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <tip-u2nr1oq03o0i29w2ay9jx03s@git.kernel.org>
References: <tip-u2nr1oq03o0i29w2ay9jx03s@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157449690325.21853.13915598590850331012.tip-bot2@tip-bot2>
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

Commit-ID:     7b59a82493b49b715224bfe3b35fae52e48e5fa1
Gitweb:        https://git.kernel.org/tip/7b59a82493b49b715224bfe3b35fae52e48e5fa1
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Tue, 19 Nov 2019 16:30:56 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 19 Nov 2019 16:30:56 -03:00

perf map: Move comparision of map's dso_id to a separate function

We'll use it when doing DSO lookups using dso_ids.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-u2nr1oq03o0i29w2ay9jx03s@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dsos.c | 25 +++++++++++++++++++++++++
 tools/perf/util/map.h  |  2 ++
 tools/perf/util/sort.c | 16 ++++------------
 3 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index 3ea80d2..ecf8d73 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -2,6 +2,7 @@
 #include "debug.h"
 #include "dsos.h"
 #include "dso.h"
+#include "map.h"
 #include "vdso.h"
 #include "namespaces.h"
 #include <libgen.h>
@@ -9,6 +10,30 @@
 #include <string.h>
 #include <symbol.h> // filename__read_build_id
 
+int dso_id__cmp(struct dso_id *a, struct dso_id *b)
+{
+	/*
+	 * The second is always dso->id, so zeroes if not set, assume passing
+	 * NULL for a means a zeroed id
+	 */
+	if (a == NULL)
+		return 0;
+
+	if (a->maj > b->maj) return -1;
+	if (a->maj < b->maj) return 1;
+
+	if (a->min > b->min) return -1;
+	if (a->min < b->min) return 1;
+
+	if (a->ino > b->ino) return -1;
+	if (a->ino < b->ino) return 1;
+
+	if (a->ino_generation > b->ino_generation) return -1;
+	if (a->ino_generation < b->ino_generation) return 1;
+
+	return 0;
+}
+
 bool __dsos__read_build_ids(struct list_head *head, bool with_hits)
 {
 	bool have_build_id = false;
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index f962eb9..e1e573a 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -28,6 +28,8 @@ struct dso_id {
 	u64	ino_generation;
 };
 
+int dso_id__cmp(struct dso_id *a, struct dso_id *b);
+
 struct map {
 	union {
 		struct rb_node	rb_node;
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index bc58943..f148100 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -1194,6 +1194,7 @@ sort__dcacheline_cmp(struct hist_entry *left, struct hist_entry *right)
 {
 	u64 l, r;
 	struct map *l_map, *r_map;
+	int rc;
 
 	if (!left->mem_info)  return -1;
 	if (!right->mem_info) return 1;
@@ -1212,18 +1213,9 @@ sort__dcacheline_cmp(struct hist_entry *left, struct hist_entry *right)
 	if (!l_map) return -1;
 	if (!r_map) return 1;
 
-	if (l_map->dso_id.maj > r_map->dso_id.maj) return -1;
-	if (l_map->dso_id.maj < r_map->dso_id.maj) return 1;
-
-	if (l_map->dso_id.min > r_map->dso_id.min) return -1;
-	if (l_map->dso_id.min < r_map->dso_id.min) return 1;
-
-	if (l_map->dso_id.ino > r_map->dso_id.ino) return -1;
-	if (l_map->dso_id.ino < r_map->dso_id.ino) return 1;
-
-	if (l_map->dso_id.ino_generation > r_map->dso_id.ino_generation) return -1;
-	if (l_map->dso_id.ino_generation < r_map->dso_id.ino_generation) return 1;
-
+	rc = dso_id__cmp(&l_map->dso_id, &r_map->dso_id);
+	if (rc)
+		return rc;
 	/*
 	 * Addresses with no major/minor numbers are assumed to be
 	 * anonymous in userspace.  Sort those on pid then address.
