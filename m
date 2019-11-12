Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACBDC17448
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5327522490
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfKLLSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 06:18:25 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33791 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbfKLLSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 06:18:20 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iUUBZ-0000Wg-Rh; Tue, 12 Nov 2019 12:18:14 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id EAAB81C0084;
        Tue, 12 Nov 2019 12:18:05 +0100 (CET)
Date:   Tue, 12 Nov 2019 11:18:05 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf map: Allow map__next() to receive a NULL arg
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-pbde2ucn49khnrebclys9pny@git.kernel.org>
References: <tip-pbde2ucn49khnrebclys9pny@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157355748556.29376.11680687534918838530.tip-bot2@tip-bot2>
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

Commit-ID:     20419d3a5bc0a278ed7e2ee54943674004411933
Gitweb:        https://git.kernel.org/tip/20419d3a5bc0a278ed7e2ee54943674004411933
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 28 Oct 2019 11:50:12 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 06 Nov 2019 15:43:06 -03:00

perf map: Allow map__next() to receive a NULL arg

Just like free(), return NULL in that case, will simplify the
for_each_entry_safe() iterators.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-pbde2ucn49khnrebclys9pny@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index c9ba495..86d8d18 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -1007,7 +1007,7 @@ struct map *maps__first(struct maps *maps)
 	return NULL;
 }
 
-struct map *map__next(struct map *map)
+static struct map *__map__next(struct map *map)
 {
 	struct rb_node *next = rb_next(&map->rb_node);
 
@@ -1016,6 +1016,11 @@ struct map *map__next(struct map *map)
 	return NULL;
 }
 
+struct map *map__next(struct map *map)
+{
+	return map ? __map__next(map) : NULL;
+}
+
 struct kmap *__map__kmap(struct map *map)
 {
 	if (!map->dso || !map->dso->kernel)
