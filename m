Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22BEC388F3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A508321924
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569928401;
	bh=Llp2SQjqkC/mu2n3hj4e4dsjUlKCyvIJARC4iZguoTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kud6QY7ByejLzGxRkzzsjqXUsaqNRIwwxZt//eajqCwhDXAoMRVVsXXBJgP3IrdTO
	 HrrxGbMDbNu+yOxzsHL1NA0KR++3szlR4UD8Cr94kIrf7OBjaxkV0F2EYDXIxm5Q3W
	 n5S3jVgH6X7YOS5aA3cdjKdokY/EOUSIr1hkUQD8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731776AbfJALNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:13:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:35278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731480AbfJALNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:13:20 -0400
Received: from quaco.ghostprotocols.net (177.206.223.101.dynamic.adsl.gvt.net.br [177.206.223.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3343421920;
        Tue,  1 Oct 2019 11:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569928398;
        bh=Llp2SQjqkC/mu2n3hj4e4dsjUlKCyvIJARC4iZguoTU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wi9K6IiIedE5sJ7QzoDwy0boguV+BtqOAyLCDoAoOe2vpPRp7Xq4YrKbAuzfN2gCA
         gZxqZxSFsA3SiFe0pLfaZWgH+JaI8Tsx0OgO6wb1R+r8zY+FPmomkzZO/Jsiz7WC63
         imZmMyhos6X88LZ0+X5kOPGso6DI+crcLxSdugGo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Steve MacLean <Steve.MacLean@microsoft.com>,
        Steve MacLean <Steve.MacLean@Microsoft.com>,
        Brian Robbins <brianrob@microsoft.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Eric Saint-Etienne <eric.saint.etienne@oracle.com>,
        John Keeping <john@metanate.com>,
        John Salem <josalem@microsoft.com>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Stephane Eranian <eranian@google.com>,
        Tom McDonald <thomas.mcdonald@microsoft.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 12/24] perf map: Fix overlapped map handling
Date:   Tue,  1 Oct 2019 08:12:04 -0300
Message-Id: <20191001111216.7208-13-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191001111216.7208-1-acme@kernel.org>
References: <20191001111216.7208-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steve MacLean <Steve.MacLean@microsoft.com>

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
index 5b83ed1ebbd6..eec9b282c047 100644
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
-- 
2.21.0

