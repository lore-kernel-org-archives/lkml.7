Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9B8C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 19:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC4A2080F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 19:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HC9NApN1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406211AbfITTi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 15:38:57 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44931 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfITTi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 15:38:56 -0400
Received: by mail-qk1-f193.google.com with SMTP id u22so4968694qkk.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 12:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HPiPEiJFgD/jwy0RVx5HWzug8lnmj5MBi1VsVPdTBVQ=;
        b=HC9NApN1TrPGFCVB87OggyWNs1AVcY6h764RCGQjlS+Vr3ySwHbmDDSctFOQ9GbhHX
         Bx3GAfac3ec5ZF9H1QoJEZLrtvn/V22hfGhSOiDz3ASpAleqh5D7tIshBUEWvolqOen6
         qH1TJYtmaZEGQMpuak29tt8haQ00eOWEsX0c+ulO/dNvi4atHxDVyRu/pW62VOF8qNzf
         OF7U275FwFdFsRN4DwW8GudtwNuyWn4D2XuICsHIgInEuxNktwknk1L0aWGuq5TE+vP4
         nSYI55z/1CH474O+TDnv3R2M6HJqRFg7yvfNBcABENALc4qTEXeIpQNDoh9eTDPKunnO
         LyQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HPiPEiJFgD/jwy0RVx5HWzug8lnmj5MBi1VsVPdTBVQ=;
        b=jw7Cmmx6GD2fdJlbENZhuDrOxums9lymIY6pawRD9Xu5CFRUvLiBcDGeCiykQG0G83
         td57cVLRWwxireOyYPj3b93pzB4vNLK9D0sVKHTn5wG9u+Qyb6c37HK51T9FEir9qBNS
         zZp2vJB2BdkuVT8wlU6nRsD4gtwBLIoqrkrhpkdziFV9ePSfCc8I6Y5ySwfTBPgftW7w
         VDr7WRuP03T4OaCUuEQNuxVQzFbZE1NXuUTYF9aSlGp5YyaVxrsKojfckM0TspGst0pO
         rSpLY2kJkOkrtKaHK/EsfDzseiyrzM22IR104EM+BY/sU9zkOGGPfV1Nokomh058KvOT
         4LLQ==
X-Gm-Message-State: APjAAAUDl596jmYtm2udZ8VXecCN++XgEKbmpG9S+Vl66hKHla0yLsVH
        XaAzv6Tk60CHOEL/xMBHq+g=
X-Google-Smtp-Source: APXvYqz3UJlhkYy2p5UEPy/wxS0V0hCOeNmU/B5HObSnsTk4nY0kxeHctie3ZSxV9JnbUOXeS+TqeA==
X-Received: by 2002:ae9:e20f:: with SMTP id c15mr5486890qkc.122.1569008335673;
        Fri, 20 Sep 2019 12:38:55 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.95.178.75])
        by smtp.gmail.com with ESMTPSA id a14sm1541500qkg.59.2019.09.20.12.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 12:38:54 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6F5BB40340; Fri, 20 Sep 2019 16:38:52 -0300 (-03)
Date:   Fri, 20 Sep 2019 16:38:52 -0300
To:     Steve MacLean <Steve.MacLean@microsoft.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Changbin Du <changbin.du@intel.com>,
        Eric Saint-Etienne <eric.saint.etienne@oracle.com>,
        John Keeping <john@metanate.com>,
        Andi Kleen <ak@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Leo Yan <leo.yan@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Brian Robbins <brianrob@microsoft.com>,
        Tom McDonald <Thomas.McDonald@microsoft.com>,
        John Salem <josalem@microsoft.com>
Subject: Re: [PATCH] perf map: fix overlapped map handling
Message-ID: <20190920193852.GI4865@kernel.org>
References: <BN8PR21MB136261C1A4BB2C884F10FCECF7880@BN8PR21MB1362.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN8PR21MB136261C1A4BB2C884F10FCECF7880@BN8PR21MB1362.namprd21.prod.outlook.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Sep 20, 2019 at 07:20:18PM +0000, Steve MacLean escreveu:
> Whenever an mmap/mmap2 event occurs, the map tree must be updated to add a new
> entry. If a new map overlaps a previous map, the overlapped section of the
> previous map is effectively unmapped, but the non-overlapping sections are
> still valid.
> 
> maps__fixup_overlappings() is responsible for creating any new map entries from
> the previously overlapped map. It optionally creates a before and an after map.
> 
> When creating the after map the existing code failed to adjust the map.pgoff.
> This meant the new after map would incorrectly calculate the file offset
> for the ip. This results in incorrect symbol name resolution for any ip in the
> after region.
> 
> Make maps__fixup_overlappings() correctly populate map.pgoff.
> 
> Add an assert that new mapping matches old mapping at the beginning of
> the after map.
> 
> Signed-off-by: Steve MacLean <Steve.MacLean@Microsoft.com>
> ---
>  tools/perf/util/map.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> index 5b83ed1..73870d7 100644
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
> +			after->pgoff = pos->map_ip(pos, map->end);

So is this equivalent to what __split_vma() does in the kernel, i.e.:

        if (new_below)
                new->vm_end = addr;
        else {
                new->vm_start = addr;
                new->vm_pgoff += ((addr - vma->vm_start) >> PAGE_SHIFT);
        }

where new->vm_pgoff starts equal to the vm_pgoff of the mmap being
split?

- Arnaldo

> +			assert(pos->map_ip(pos, map->end) == after->map_ip(after, map->end));



>  			__map_groups__insert(pos->groups, after);
>  			if (verbose >= 2 && !use_browser)
>  				map__fprintf(after, fp);
> -- 
> 2.7.4

-- 

- Arnaldo
