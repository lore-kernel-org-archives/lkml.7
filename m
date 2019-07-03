Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D47DC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A20F218A3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562162227;
	bh=A/Y1BRKc8RjjvjySbfBBiJIL3q8z3CylHGuSSZg25hM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mhHMxkaBexOHDohFZZGWdpTo4ugByTXqbiya9DXfPs3R3NGmVmck058oBLK3A/kQJ
	 xSzPx78RooMQbNyMFm2kLMjbQ++iz61LfbCfI+FunN1I6h3Fr/UaMmN20KwRrnu3r7
	 ETzkvsWJcrqvzKY5jNCzLhxrEMyaLz879H1bMsnM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfGCN5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 09:57:05 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41363 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfGCN5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 09:57:05 -0400
Received: by mail-wr1-f68.google.com with SMTP id c2so2922316wrm.8;
        Wed, 03 Jul 2019 06:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dKMDMyWa08xLpVvBOprd0gf66kxRqMrKCmCkMVp5v3w=;
        b=g2vmXiLj5ietQUUQPKSXVooYWv6itxE5a7epTjrUwN8g/zpunWNeD5bHccaDKH+FEa
         jC2td8uosCBax9QGHI7w32g2FVroOsI0gUwfTsE1ptRPlqfHN/9giuqWqsa+1nRAjbXI
         MB4y2zMXQG5ugP/V/iUOuAxGzP5G0XJt0+68EdllvykSjx5h+k4ZoNMF8Mami4ULB8Kl
         ZOLk9/goGM1TvXryWPu0P0a6pNy8hibQBGRIPazpphZLMZPLlk0VgQvPXkicm7ziafOv
         xO5rI5usRhAtRrnJdkOLn818dokYHKxtHSUJQq3je8z+IF/1wltN3OA/Mf6dngiHR/1m
         vDxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=dKMDMyWa08xLpVvBOprd0gf66kxRqMrKCmCkMVp5v3w=;
        b=NrYQNcc/NCH1GFOy2ATL8JNqZBkccn7wPVQaEja5/SBxrLcYWw0xbcES6wAVvqvi6g
         j/7upleSbIzxRjgb5xdipLkkAwVIatbzq1+7VQeAtb0ik/bHEFnLGKZ3QMFN3cg+tPFf
         Tsp8ESoK6aBl/fHjPLieJlg1Tzw6w9SLinDDEyZwFRlsgBYe/08l6GkiQMJBcR/TXhXM
         UC/IyA2tJQk1sbZr0UhPY6f587mw2w/qejTcvTj9NjRy0AIPszyEZ/sNt1Qrq1Y1D2i9
         3+F9C3FpVvfJ0bJCpFJr4vavXVMJwYPSLWnHJsoyc5gvfuCXgNkUSIAEOsFst+tFMbzH
         rOUg==
X-Gm-Message-State: APjAAAUoTZ32DhdDDripHdqRkGWnK1Ss+PviJ9QdyrmWUJH0Zo759cW/
        eI1s3qOjEkJMwIkWu+YMu0U=
X-Google-Smtp-Source: APXvYqzs6+DfaJgCdT2IvDks8GgHhcyyDQBYj2//ZGcTu00rEvUJ55UPsUDmB33gZFZ/BnRnaQq5NA==
X-Received: by 2002:a5d:4e4d:: with SMTP id r13mr30872035wrt.295.1562162222509;
        Wed, 03 Jul 2019 06:57:02 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id w67sm3725079wma.24.2019.07.03.06.57.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 06:57:01 -0700 (PDT)
Date:   Wed, 3 Jul 2019 15:56:59 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Mariano Pache <npache@redhat.com>,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL] perf/core improvements and fixes
Message-ID: <20190703135659.GB108545@gmail.com>
References: <20190703032746.21692-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703032746.21692-1-acme@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling, this is on top of perf-core-for-mingo-5.3-20190701.
> 
> Best regards,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 06c642c0e9fceafd16b1a4c80d44b1c09e282215:
> 
>   perf jevents: Use nonlocal include statements in pmu-events.c (2019-07-01 22:50:42 -0300)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.3-20190703
> 
> for you to fetch changes up to 15a108af1a18b597bfbd7f7b3c7b4823bfbaf8df:
> 
>   perf script: Allow specifying the files to process guest samples (2019-07-03 00:13:25 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> perf metrics:
> 
>   Andi Kleen:
> 
>   - Fixes for SkylakeX and CascadeLakeX Intel vendor events.
> 
>   - Avoid extra ':' for --raw metrics.
> 
>   - Don't include duration_time in group.
> 
> perf script:
> 
>   Arnaldo Carvalho de Melo/Jiri Olsa:
> 
>   - Fix processing guest samples.
> 
> perf diff:
> 
>   Jin Yao:
> 
>   - Do diffs by basic blocks.
> 
> objtool:
> 
>   Jiri Olsa:
> 
>   - Fix build by linking against tools/lib/ctype.o sources.
> 
> perf pmu:
> 
>   John Garry:
> 
>   - Support more complex PMU event aliasing.
> 
>   - Add support for Hisi hip08 DDRC, HHA and L3C PMU aliasing.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Andi Kleen (4):
>       perf tools: Fix typos / broken sentences
>       perf vendor events intel: Metric fixes for SKX/CLX
>       perf list: Avoid extra : for --raw metrics
>       perf tools metric: Don't include duration_time in group
> 
> Arnaldo Carvalho de Melo (1):
>       perf script: Allow specifying the files to process guest samples
> 
> Jin Yao (7):
>       perf symbol: Create block_info structure
>       perf hists: Add block_info in hist_entry
>       perf diff: Check if all data files with branch stacks
>       perf diff: Use hists to manage basic blocks per symbol
>       perf diff: Link same basic blocks among different data
>       perf diff: Print the basic block cycles diff
>       perf diff: Documentation -c cycles option
> 
> Jiri Olsa (1):
>       objtool: Fix build by linking against tools/lib/ctype.o sources
> 
> John Garry (4):
>       perf pmu: Support more complex PMU event aliasing
>       perf jevents: Add support for Hisi hip08 DDRC PMU aliasing
>       perf jevents: Add support for Hisi hip08 HHA PMU aliasing
>       perf jevents: Add support for Hisi hip08 L3C PMU aliasing
> 
>  tools/objtool/Build                                |   5 +
>  tools/perf/Documentation/perf-diff.txt             |  17 +-
>  tools/perf/Documentation/perf-report.txt           |   2 +-
>  tools/perf/Documentation/tips.txt                  |   2 +-
>  tools/perf/builtin-diff.c                          | 382 ++++++++++++++++++++-
>  tools/perf/builtin-script.c                        |  19 +
>  .../arch/arm64/hisilicon/hip08/uncore-ddrc.json    |  44 +++
>  .../arch/arm64/hisilicon/hip08/uncore-hha.json     |  51 +++
>  .../arch/arm64/hisilicon/hip08/uncore-l3c.json     |  37 ++
>  .../arch/x86/cascadelakex/clx-metrics.json         |   4 +-
>  .../pmu-events/arch/x86/skylakex/skx-metrics.json  |  22 +-
>  tools/perf/pmu-events/jevents.c                    |   3 +
>  tools/perf/ui/stdio/hist.c                         |  27 ++
>  tools/perf/util/hist.c                             |  41 ++-
>  tools/perf/util/hist.h                             |   8 +
>  tools/perf/util/metricgroup.c                      |  21 +-
>  tools/perf/util/pmu.c                              |  46 ++-
>  tools/perf/util/sort.h                             |  13 +
>  tools/perf/util/srcline.c                          |   4 +-
>  tools/perf/util/symbol.c                           |  22 ++
>  tools/perf/util/symbol.h                           |  23 ++
>  tools/perf/util/symbol_conf.h                      |   4 +-
>  22 files changed, 753 insertions(+), 44 deletions(-)
>  create mode 100644 tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-ddrc.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-l3c.json

Pulled, thanks a lot Arnaldo!

	Ingo
