Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A793BC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 07:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BDCC20859
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 07:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfKOHkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 02:40:31 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42618 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfKOHk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 02:40:26 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iVWDM-0002aC-PX; Fri, 15 Nov 2019 08:40:20 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 619B21C18CE;
        Fri, 15 Nov 2019 08:40:19 +0100 (CET)
Date:   Fri, 15 Nov 2019 07:40:19 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf map: Use map->dso->kernel + map__kmaps() in
 map__kmaps()
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-bdbazuj4ggrmzxdviaqdrdwh@git.kernel.org>
References: <tip-bdbazuj4ggrmzxdviaqdrdwh@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157380361902.29467.3509690738885805245.tip-bot2@tip-bot2>
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

Commit-ID:     de90d513b2464d28a17fc4eaada97f4ad742ba00
Gitweb:        https://git.kernel.org/tip/de90d513b2464d28a17fc4eaada97f4ad742ba00
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 04 Nov 2019 16:31:33 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 12 Nov 2019 08:20:52 -03:00

perf map: Use map->dso->kernel + map__kmaps() in map__kmaps()

Its equivalent to using map->groups to obtain the machine struct.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-bdbazuj4ggrmzxdviaqdrdwh@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 466c9b0..a4d889c 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -244,18 +244,11 @@ struct map *map__new2(u64 start, struct dso *dso)
 	return map;
 }
 
-/*
- * Use this and __map__is_kmodule() for map instances that are in
- * machine->kmaps, and thus have map->groups->machine all properly set, to
- * disambiguate between the kernel and modules.
- *
- * When the need arises, introduce map__is_{kernel,kmodule)() that
- * checks (map->groups != NULL && map->groups->machine != NULL &&
- * map->dso->kernel) before calling __map__is_{kernel,kmodule}())
- */
 bool __map__is_kernel(const struct map *map)
 {
-	return machine__kernel_map(map->groups->machine) == map;
+	if (!map->dso->kernel)
+		return false;
+	return machine__kernel_map(map__kmaps((struct map *)map)->machine) == map;
 }
 
 bool __map__is_extra_kernel_map(const struct map *map)
