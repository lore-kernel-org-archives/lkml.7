Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A74AC4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 15:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71DEA2082F
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 15:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbfI2Po3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 11:44:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42084 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbfI2Po3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 11:44:29 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5CB7E10DCC8A;
        Sun, 29 Sep 2019 15:44:28 +0000 (UTC)
Received: from krava (ovpn-204-45.brq.redhat.com [10.40.204.45])
        by smtp.corp.redhat.com (Postfix) with SMTP id 970685D9C3;
        Sun, 29 Sep 2019 15:44:22 +0000 (UTC)
Date:   Sun, 29 Sep 2019 17:44:21 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Steve MacLean <Steve.MacLean@microsoft.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Eric Saint-Etienne <eric.saint.etienne@oracle.com>,
        John Keeping <john@metanate.com>,
        Andi Kleen <ak@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Leo Yan <leo.yan@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Brian Robbins <brianrob@microsoft.com>,
        Tom McDonald <Thomas.McDonald@microsoft.com>,
        John Salem <josalem@microsoft.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 1/4] perf map: fix overlapped map handling
Message-ID: <20190929154421.GA602@krava>
References: <BN8PR21MB136270949F22A6A02335C238F7800@BN8PR21MB1362.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN8PR21MB136270949F22A6A02335C238F7800@BN8PR21MB1362.namprd21.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.64]); Sun, 29 Sep 2019 15:44:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 28, 2019 at 01:39:00AM +0000, Steve MacLean wrote:

SNIP

> Before:
> 
> perf script --show-mmap-events 2>&1 | grep -e MMAP -e unknown |\
>    grep libcoreclr.so | head -n 4
>       dotnet  1907 373352.698780: PERF_RECORD_MMAP2 1907/1907: \
>           [0x7fe615726000(0x768000) @ 0 08:02 5510620 765057155]: \
>           r-xp .../3.0.0-preview9-19423-09/libcoreclr.so
>       dotnet  1907 373352.701091: PERF_RECORD_MMAP2 1907/1907: \
>           [0x7fe615974000(0x1000) @ 0x24e000 08:02 5510620 765057155]: \
>           rwxp .../3.0.0-preview9-19423-09/libcoreclr.so
>       dotnet  1907 373352.701241: PERF_RECORD_MMAP2 1907/1907: \
>           [0x7fe615c42000(0x1000) @ 0x51c000 08:02 5510620 765057155]: \
>           rwxp .../3.0.0-preview9-19423-09/libcoreclr.so
>       dotnet  1907 373352.705249:     250000 cpu-clock: \
>            7fe6159a1f99 [unknown] \
>            (.../3.0.0-preview9-19423-09/libcoreclr.so)
> 
> After:
> 
> perf script --show-mmap-events 2>&1 | grep -e MMAP -e unknown |\
>    grep libcoreclr.so | head -n 4
>       dotnet  1907 373352.698780: PERF_RECORD_MMAP2 1907/1907: \
>           [0x7fe615726000(0x768000) @ 0 08:02 5510620 765057155]: \
>           r-xp .../3.0.0-preview9-19423-09/libcoreclr.so
>       dotnet  1907 373352.701091: PERF_RECORD_MMAP2 1907/1907: \
>           [0x7fe615974000(0x1000) @ 0x24e000 08:02 5510620 765057155]: \
>           rwxp .../3.0.0-preview9-19423-09/libcoreclr.so
>       dotnet  1907 373352.701241: PERF_RECORD_MMAP2 1907/1907: \
>           [0x7fe615c42000(0x1000) @ 0x51c000 08:02 5510620 765057155]: \
>           rwxp .../3.0.0-preview9-19423-09/libcoreclr.so
> 
> All the [unknown] symbols were resolved.
> 
> Tested-by: Brian Robbins <brianrob@microsoft.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Stephane Eranian <eranian@google.com>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Steve MacLean <Steve.MacLean@Microsoft.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  tools/perf/util/map.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> index 5b83ed1..eec9b28 100644
> --- a/tools/perf/util/map.c
> +++ b/tools/perf/util/map.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include "symbol.h"
> +#include <assert.h>
>  #include <errno.h>
>  #include <inttypes.h>
>  #include <limits.h>
> @@ -850,6 +851,8 @@ static int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp
>  			}
>  
>  			after->start = map->end;
> +			after->pgoff += map->end - pos->start;
> +			assert(pos->map_ip(pos, map->end) == after->map_ip(after, map->end));
>  			__map_groups__insert(pos->groups, after);
>  			if (verbose >= 2 && !use_browser)
>  				map__fprintf(after, fp);
> -- 
> 2.7.4
