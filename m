Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872B4ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B3ED21721
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbfJGOuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 10:50:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44535 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728724AbfJGOts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 10:49:48 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iHUK8-0005z8-Vd; Mon, 07 Oct 2019 16:49:21 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B90AB1C0DCC;
        Mon,  7 Oct 2019 16:49:15 +0200 (CEST)
Date:   Mon, 07 Oct 2019 14:49:15 -0000
From:   "tip-bot2 for Steve MacLean" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf map: Fix overlapped map handling
Cc:     Steve MacLean <Steve.MacLean@Microsoft.com>,
        Brian Robbins <brianrob@microsoft.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Eric Saint-Etienne" <eric.saint.etienne@oracle.com>,
        John Keeping <john@metanate.com>,
        John Salem <josalem@microsoft.com>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Stephane Eranian <eranian@google.com>,
        Tom McDonald <thomas.mcdonald@microsoft.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3CBN8PR21MB136270949F22A6A02335C238F7800=40BN8PR21MB?=
 =?utf-8?q?1362=2Enamprd21=2Eprod=2Eoutlook=2Ecom=3E?=
References: =?utf-8?q?=3CBN8PR21MB136270949F22A6A02335C238F7800=40BN8PR21M?=
 =?utf-8?q?B1362=2Enamprd21=2Eprod=2Eoutlook=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <157045975569.9978.13642071368077226305.tip-bot2@tip-bot2>
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

Commit-ID:     ee212d6ea20887c0ef352be8563ca13dbf965906
Gitweb:        https://git.kernel.org/tip/ee212d6ea20887c0ef352be8563ca13dbf965906
Author:        Steve MacLean <Steve.MacLean@microsoft.com>
AuthorDate:    Sat, 28 Sep 2019 01:39:00 
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 30 Sep 2019 17:29:46 -03:00

perf map: Fix overlapped map handling

Whenever an mmap/mmap2 event occurs, the map tree must be updated to add a new
entry. If a new map overlaps a previous map, the overlapped section of the
previous map is effectively unmapped, but the non-overlapping sections are
still valid.

maps__fixup_overlappings() is responsible for creating any new map entries from
the previously overlapped map. It optionally creates a before and an after map.

When creating the after map the existing code failed to adjust the map.pgoff.
This meant the new after map would incorrectly calculate the file offset
for the ip. This results in incorrect symbol name resolution for any ip in the
after region.

Make maps__fixup_overlappings() correctly populate map.pgoff.

Add an assert that new mapping matches old mapping at the beginning of
the after map.

Committer-testing:

Validated correct parsing of libcoreclr.so symbols from .NET Core 3.0 preview9
(which didn't strip symbols).

Preparation:

  ~/dotnet3.0-preview9/dotnet new webapi -o perfSymbol
  cd perfSymbol
  ~/dotnet3.0-preview9/dotnet publish
  perf record ~/dotnet3.0-preview9/dotnet \
      bin/Debug/netcoreapp3.0/publish/perfSymbol.dll
  ^C

Before:

  perf script --show-mmap-events 2>&1 | grep -e MMAP -e unknown |\
     grep libcoreclr.so | head -n 4
        dotnet  1907 373352.698780: PERF_RECORD_MMAP2 1907/1907: \
            [0x7fe615726000(0x768000) @ 0 08:02 5510620 765057155]: \
            r-xp .../3.0.0-preview9-19423-09/libcoreclr.so
        dotnet  1907 373352.701091: PERF_RECORD_MMAP2 1907/1907: \
            [0x7fe615974000(0x1000) @ 0x24e000 08:02 5510620 765057155]: \
            rwxp .../3.0.0-preview9-19423-09/libcoreclr.so
        dotnet  1907 373352.701241: PERF_RECORD_MMAP2 1907/1907: \
            [0x7fe615c42000(0x1000) @ 0x51c000 08:02 5510620 765057155]: \
            rwxp .../3.0.0-preview9-19423-09/libcoreclr.so
        dotnet  1907 373352.705249:     250000 cpu-clock: \
             7fe6159a1f99 [unknown] \
             (.../3.0.0-preview9-19423-09/libcoreclr.so)

After:

  perf script --show-mmap-events 2>&1 | grep -e MMAP -e unknown |\
     grep libcoreclr.so | head -n 4
        dotnet  1907 373352.698780: PERF_RECORD_MMAP2 1907/1907: \
            [0x7fe615726000(0x768000) @ 0 08:02 5510620 765057155]: \
            r-xp .../3.0.0-preview9-19423-09/libcoreclr.so
        dotnet  1907 373352.701091: PERF_RECORD_MMAP2 1907/1907: \
            [0x7fe615974000(0x1000) @ 0x24e000 08:02 5510620 765057155]: \
            rwxp .../3.0.0-preview9-19423-09/libcoreclr.so
        dotnet  1907 373352.701241: PERF_RECORD_MMAP2 1907/1907: \
            [0x7fe615c42000(0x1000) @ 0x51c000 08:02 5510620 765057155]: \
            rwxp .../3.0.0-preview9-19423-09/libcoreclr.so

All the [unknown] symbols were resolved.

Signed-off-by: Steve MacLean <Steve.MacLean@Microsoft.com>
Tested-by: Brian Robbins <brianrob@microsoft.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Eric Saint-Etienne <eric.saint.etienne@oracle.com>
Cc: John Keeping <john@metanate.com>
Cc: John Salem <josalem@microsoft.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Tom McDonald <thomas.mcdonald@microsoft.com>
Link: http://lore.kernel.org/lkml/BN8PR21MB136270949F22A6A02335C238F7800@BN8PR21MB1362.namprd21.prod.outlook.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 5b83ed1..eec9b28 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "symbol.h"
+#include <assert.h>
 #include <errno.h>
 #include <inttypes.h>
 #include <limits.h>
@@ -850,6 +851,8 @@ static int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp
 			}
 
 			after->start = map->end;
+			after->pgoff += map->end - pos->start;
+			assert(pos->map_ip(pos, map->end) == after->map_ip(after, map->end));
 			__map_groups__insert(pos->groups, after);
 			if (verbose >= 2 && !use_browser)
 				map__fprintf(after, fp);
