Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D52C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 23:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECB9621479
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 23:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="v5Npx+mP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfETXm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 19:42:56 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:26320 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfETXmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 19:42:55 -0400
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x4KNgd93026157
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 08:42:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x4KNgd93026157
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1558395760;
        bh=bMEEWPkw/l3GzgIcOi6OUYhuunoxIQmSpFg+bUlfseA=;
        h=From:Date:Subject:To:Cc:From;
        b=v5Npx+mPQ0gfD1S6iEUiC8BpVkdkKLHiqFiD0bl2/ZOUePQQf2KDmKwxCZVkmd46c
         ig6SmJNG2/csVMFtwYyIRUggU4pYEhYwHHF7iNA7jRYJh6QMTt7Pc8xQ21dT18tU/N
         QPViS1O8brKJx4tsxLQJaxcXWP28E0EAkajprmrXW5InuqD/3RR/nACnI7p3CYPXCe
         Icd6qWDyymm54JCml4l0b9ZRpIWd7nBwtoeMdQEcHoOUYDgYjVNsKHywlmL0jGqbEo
         y3lkryHxSfEgVMc7vQZmXPB0kbyAfQpDgTDWkWDBtIqqHcjrSi9vkvb87flXqAUACK
         1pLpQ4HcpffVA==
X-Nifty-SrcIP: [209.85.222.41]
Received: by mail-ua1-f41.google.com with SMTP id 7so567199uah.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 16:42:39 -0700 (PDT)
X-Gm-Message-State: APjAAAXFh0uFNZ2gwLMl6wWFlZu+cWMOY9EVowccxVwcpPXR9Sb1xopv
        abflJyI/cR3zoTkbQt4Eo5mXQ7pJyyBH93ClBpI=
X-Google-Smtp-Source: APXvYqwWwbdPUa+hI8Qy2iuPb7Kzfp7Z+RtFtq4SBvwlyc7si0EWn/pEbBY4cTjy33eHPMb+KHIeHaZke+3H1Y1YMfM=
X-Received: by 2002:a9f:24a3:: with SMTP id 32mr15088086uar.109.1558395758638;
 Mon, 20 May 2019 16:42:38 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 21 May 2019 08:42:02 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS=5WYQ50inX5e6+VS_N9kzk5n5t7X6aoRXPEsKe_gxXw@mail.gmail.com>
Message-ID: <CAK7LNAS=5WYQ50inX5e6+VS_N9kzk5n5t7X6aoRXPEsKe_gxXw@mail.gmail.com>
Subject: Missing newline at EOF of json files in tools/perf
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

When I talked about the EOF line checker of checkpatch.pl,
I pointed out most of .json files in tools/perf miss
new line at EOF.

https://lkml.org/lkml/2019/5/13/985
https://lkml.org/lkml/2019/5/13/989


I do not think this is intentional,
but it is better to ask just in case.

The following do not have new line at EOF:

./tools/perf/pmu-events/arch/powerpc/power9/cache.json
./tools/perf/pmu-events/arch/powerpc/power9/floating-point.json
./tools/perf/pmu-events/arch/powerpc/power9/frontend.json
./tools/perf/pmu-events/arch/powerpc/power9/marked.json
./tools/perf/pmu-events/arch/powerpc/power9/memory.json
./tools/perf/pmu-events/arch/powerpc/power9/other.json
./tools/perf/pmu-events/arch/powerpc/power9/pipeline.json
./tools/perf/pmu-events/arch/powerpc/power9/pmc.json
./tools/perf/pmu-events/arch/powerpc/power9/translation.json
./tools/perf/pmu-events/arch/x86/bonnell/cache.json
./tools/perf/pmu-events/arch/x86/bonnell/floating-point.json
./tools/perf/pmu-events/arch/x86/bonnell/frontend.json
./tools/perf/pmu-events/arch/x86/bonnell/memory.json
./tools/perf/pmu-events/arch/x86/bonnell/other.json
./tools/perf/pmu-events/arch/x86/bonnell/pipeline.json
./tools/perf/pmu-events/arch/x86/bonnell/virtual-memory.json
./tools/perf/pmu-events/arch/x86/broadwell/cache.json
./tools/perf/pmu-events/arch/x86/broadwellde/cache.json
./tools/perf/pmu-events/arch/x86/broadwellde/floating-point.json
./tools/perf/pmu-events/arch/x86/broadwellde/frontend.json
./tools/perf/pmu-events/arch/x86/broadwellde/memory.json
./tools/perf/pmu-events/arch/x86/broadwellde/other.json
./tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json
./tools/perf/pmu-events/arch/x86/broadwellde/virtual-memory.json
./tools/perf/pmu-events/arch/x86/broadwell/floating-point.json
./tools/perf/pmu-events/arch/x86/broadwell/frontend.json
./tools/perf/pmu-events/arch/x86/broadwell/memory.json
./tools/perf/pmu-events/arch/x86/broadwell/other.json
./tools/perf/pmu-events/arch/x86/broadwell/pipeline.json
./tools/perf/pmu-events/arch/x86/broadwell/uncore.json
./tools/perf/pmu-events/arch/x86/broadwell/virtual-memory.json
./tools/perf/pmu-events/arch/x86/broadwellx/cache.json
./tools/perf/pmu-events/arch/x86/broadwellx/floating-point.json
./tools/perf/pmu-events/arch/x86/broadwellx/frontend.json
./tools/perf/pmu-events/arch/x86/broadwellx/memory.json
./tools/perf/pmu-events/arch/x86/broadwellx/other.json
./tools/perf/pmu-events/arch/x86/broadwellx/pipeline.json
./tools/perf/pmu-events/arch/x86/broadwellx/virtual-memory.json
./tools/perf/pmu-events/arch/x86/cascadelakex/cache.json
./tools/perf/pmu-events/arch/x86/cascadelakex/floating-point.json
./tools/perf/pmu-events/arch/x86/cascadelakex/frontend.json
./tools/perf/pmu-events/arch/x86/cascadelakex/memory.json
./tools/perf/pmu-events/arch/x86/cascadelakex/other.json
./tools/perf/pmu-events/arch/x86/cascadelakex/pipeline.json
./tools/perf/pmu-events/arch/x86/cascadelakex/virtual-memory.json
./tools/perf/pmu-events/arch/x86/goldmont/cache.json
./tools/perf/pmu-events/arch/x86/goldmont/frontend.json
./tools/perf/pmu-events/arch/x86/goldmont/memory.json
./tools/perf/pmu-events/arch/x86/goldmont/other.json
./tools/perf/pmu-events/arch/x86/goldmont/pipeline.json
./tools/perf/pmu-events/arch/x86/goldmontplus/cache.json
./tools/perf/pmu-events/arch/x86/goldmontplus/frontend.json
./tools/perf/pmu-events/arch/x86/goldmontplus/memory.json
./tools/perf/pmu-events/arch/x86/goldmontplus/other.json
./tools/perf/pmu-events/arch/x86/goldmontplus/pipeline.json
./tools/perf/pmu-events/arch/x86/goldmontplus/virtual-memory.json
./tools/perf/pmu-events/arch/x86/goldmont/virtual-memory.json
./tools/perf/pmu-events/arch/x86/haswell/cache.json
./tools/perf/pmu-events/arch/x86/haswell/floating-point.json
./tools/perf/pmu-events/arch/x86/haswell/frontend.json
./tools/perf/pmu-events/arch/x86/haswell/memory.json
./tools/perf/pmu-events/arch/x86/haswell/other.json
./tools/perf/pmu-events/arch/x86/haswell/pipeline.json
./tools/perf/pmu-events/arch/x86/haswell/uncore.json
./tools/perf/pmu-events/arch/x86/haswell/virtual-memory.json
./tools/perf/pmu-events/arch/x86/haswellx/cache.json
./tools/perf/pmu-events/arch/x86/haswellx/floating-point.json
./tools/perf/pmu-events/arch/x86/haswellx/frontend.json
./tools/perf/pmu-events/arch/x86/haswellx/memory.json
./tools/perf/pmu-events/arch/x86/haswellx/other.json
./tools/perf/pmu-events/arch/x86/haswellx/pipeline.json
./tools/perf/pmu-events/arch/x86/haswellx/virtual-memory.json
./tools/perf/pmu-events/arch/x86/ivybridge/cache.json
./tools/perf/pmu-events/arch/x86/ivybridge/floating-point.json
./tools/perf/pmu-events/arch/x86/ivybridge/frontend.json
./tools/perf/pmu-events/arch/x86/ivybridge/memory.json
./tools/perf/pmu-events/arch/x86/ivybridge/other.json
./tools/perf/pmu-events/arch/x86/ivybridge/pipeline.json
./tools/perf/pmu-events/arch/x86/ivybridge/uncore.json
./tools/perf/pmu-events/arch/x86/ivybridge/virtual-memory.json
./tools/perf/pmu-events/arch/x86/ivytown/cache.json
./tools/perf/pmu-events/arch/x86/ivytown/floating-point.json
./tools/perf/pmu-events/arch/x86/ivytown/frontend.json
./tools/perf/pmu-events/arch/x86/ivytown/memory.json
./tools/perf/pmu-events/arch/x86/ivytown/other.json
./tools/perf/pmu-events/arch/x86/ivytown/pipeline.json
./tools/perf/pmu-events/arch/x86/ivytown/virtual-memory.json
./tools/perf/pmu-events/arch/x86/jaketown/cache.json
./tools/perf/pmu-events/arch/x86/jaketown/floating-point.json
./tools/perf/pmu-events/arch/x86/jaketown/frontend.json
./tools/perf/pmu-events/arch/x86/jaketown/memory.json
./tools/perf/pmu-events/arch/x86/jaketown/other.json
./tools/perf/pmu-events/arch/x86/jaketown/pipeline.json
./tools/perf/pmu-events/arch/x86/jaketown/virtual-memory.json
./tools/perf/pmu-events/arch/x86/knightslanding/cache.json
./tools/perf/pmu-events/arch/x86/knightslanding/frontend.json
./tools/perf/pmu-events/arch/x86/knightslanding/memory.json
./tools/perf/pmu-events/arch/x86/knightslanding/pipeline.json
./tools/perf/pmu-events/arch/x86/knightslanding/virtual-memory.json
./tools/perf/pmu-events/arch/x86/nehalemep/cache.json
./tools/perf/pmu-events/arch/x86/nehalemep/floating-point.json
./tools/perf/pmu-events/arch/x86/nehalemep/frontend.json
./tools/perf/pmu-events/arch/x86/nehalemep/memory.json
./tools/perf/pmu-events/arch/x86/nehalemep/other.json
./tools/perf/pmu-events/arch/x86/nehalemep/pipeline.json
./tools/perf/pmu-events/arch/x86/nehalemep/virtual-memory.json
./tools/perf/pmu-events/arch/x86/nehalemex/cache.json
./tools/perf/pmu-events/arch/x86/nehalemex/floating-point.json
./tools/perf/pmu-events/arch/x86/nehalemex/frontend.json
./tools/perf/pmu-events/arch/x86/nehalemex/memory.json
./tools/perf/pmu-events/arch/x86/nehalemex/other.json
./tools/perf/pmu-events/arch/x86/nehalemex/pipeline.json
./tools/perf/pmu-events/arch/x86/nehalemex/virtual-memory.json
./tools/perf/pmu-events/arch/x86/sandybridge/cache.json
./tools/perf/pmu-events/arch/x86/sandybridge/floating-point.json
./tools/perf/pmu-events/arch/x86/sandybridge/frontend.json
./tools/perf/pmu-events/arch/x86/sandybridge/memory.json
./tools/perf/pmu-events/arch/x86/sandybridge/other.json
./tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json
./tools/perf/pmu-events/arch/x86/sandybridge/uncore.json
./tools/perf/pmu-events/arch/x86/sandybridge/virtual-memory.json
./tools/perf/pmu-events/arch/x86/silvermont/cache.json
./tools/perf/pmu-events/arch/x86/silvermont/frontend.json
./tools/perf/pmu-events/arch/x86/silvermont/memory.json
./tools/perf/pmu-events/arch/x86/silvermont/other.json
./tools/perf/pmu-events/arch/x86/silvermont/pipeline.json
./tools/perf/pmu-events/arch/x86/silvermont/virtual-memory.json
./tools/perf/pmu-events/arch/x86/skylake/cache.json
./tools/perf/pmu-events/arch/x86/skylake/floating-point.json
./tools/perf/pmu-events/arch/x86/skylake/frontend.json
./tools/perf/pmu-events/arch/x86/skylake/memory.json
./tools/perf/pmu-events/arch/x86/skylake/other.json
./tools/perf/pmu-events/arch/x86/skylake/pipeline.json
./tools/perf/pmu-events/arch/x86/skylake/uncore.json
./tools/perf/pmu-events/arch/x86/skylake/virtual-memory.json
./tools/perf/pmu-events/arch/x86/skylakex/cache.json
./tools/perf/pmu-events/arch/x86/skylakex/floating-point.json
./tools/perf/pmu-events/arch/x86/skylakex/frontend.json
./tools/perf/pmu-events/arch/x86/skylakex/memory.json
./tools/perf/pmu-events/arch/x86/skylakex/other.json
./tools/perf/pmu-events/arch/x86/skylakex/pipeline.json
./tools/perf/pmu-events/arch/x86/skylakex/virtual-memory.json
./tools/perf/pmu-events/arch/x86/westmereep-dp/cache.json
./tools/perf/pmu-events/arch/x86/westmereep-dp/floating-point.json
./tools/perf/pmu-events/arch/x86/westmereep-dp/frontend.json
./tools/perf/pmu-events/arch/x86/westmereep-dp/memory.json
./tools/perf/pmu-events/arch/x86/westmereep-dp/other.json
./tools/perf/pmu-events/arch/x86/westmereep-dp/pipeline.json
./tools/perf/pmu-events/arch/x86/westmereep-dp/virtual-memory.json
./tools/perf/pmu-events/arch/x86/westmereep-sp/cache.json
./tools/perf/pmu-events/arch/x86/westmereep-sp/floating-point.json
./tools/perf/pmu-events/arch/x86/westmereep-sp/frontend.json
./tools/perf/pmu-events/arch/x86/westmereep-sp/memory.json
./tools/perf/pmu-events/arch/x86/westmereep-sp/other.json
./tools/perf/pmu-events/arch/x86/westmereep-sp/pipeline.json
./tools/perf/pmu-events/arch/x86/westmereep-sp/virtual-memory.json
./tools/perf/pmu-events/arch/x86/westmereex/cache.json
./tools/perf/pmu-events/arch/x86/westmereex/floating-point.json
./tools/perf/pmu-events/arch/x86/westmereex/frontend.json
./tools/perf/pmu-events/arch/x86/westmereex/memory.json
./tools/perf/pmu-events/arch/x86/westmereex/other.json
./tools/perf/pmu-events/arch/x86/westmereex/pipeline.json
./tools/perf/pmu-events/arch/x86/westmereex/virtual-memory.json




-- 
Best Regards
Masahiro Yamada
