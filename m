Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62D5C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 07:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A94F920640
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 07:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575445901;
	bh=8QpDtsmNPdaDSp+5CU+ICx3Gctl8iRJg4TOAPnU9ne0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qfbsYs7FT3RrhGTdgWDEzLxBzue0xG3rNSPDJd1QGxFq5tpybHIdxHQMs1/mRZ1/7
	 iyyYOINTbi9fpQf+6J2pBXf13uS25tAciNn4jMAmxctl00jDPFe/vj5h9i7hMWdUMO
	 2YjGRn8rj2DKG6GULdAfTpk6EFrIGyKEHGM8JGdw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfLDHvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 02:51:40 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39838 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfLDHvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 02:51:40 -0500
Received: by mail-wr1-f66.google.com with SMTP id y11so7270753wrt.6;
        Tue, 03 Dec 2019 23:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d3HbM0ODdlNKB9WcOwE3VNxvNSYFaXuEW0sqO16IZaQ=;
        b=NI3Rw0xO6yn88l2Qxm54NqUFkypRlkUqKEuJ2KtqZeVkCy8vzHfopmMwfVvwYeMkbN
         xlvYxqCsG8HnQo5kZbwJHVjZjoWjdxaNkiJsvzHl58OLaibIuMUCPiEWrGveMFSxvs6x
         jID6Y5oN7YMJSSL+EkVqgqcEvkwNt/x1oNUi6r7KSwi0Eh/TvKivAmWa4MzZBBh5wdJm
         L2mX5fzq2w+pWQG/5DaFqalMe3I4VnIJ16IyDlca/4OOFs+HA9SAwUEPQ7IEj/27uSKT
         2tEz+X1nOHVEMATIWPG62zICE40xfVV9ZzB0mtIkrj42nIVyLDpYQrYCJxXgmxwC7COu
         uJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=d3HbM0ODdlNKB9WcOwE3VNxvNSYFaXuEW0sqO16IZaQ=;
        b=ZsTPdzJTpvIgjbk2m3Qfr4J32BVOfm342eWJqNRsWAK/WtonqxO8RUmLSMi+HQrmhS
         DwBCzxHoLq5HsCJyJMh0ty/CtIXCWkBSxD2sKph10htOr4NkMe7uDkkY4n8aB2iUi/8c
         QiPbv2vmUkwAGvDK0QmrWgg3BUe0D1+Be+PNtgBHF1zGgM+ySolIQMfFmpaNso0zWHhe
         MbNZu2d5rT0Zg6FP/EyLPhiysjISWQeD3qsdeQhgEqSveYBfTvXDq2zR6wdOZnlD/Nh+
         gRxMlMypj+TUednl4C+7NKEuxYB4xy0Db1BGzm0wVBQJYZTNfu/iA4uNzSEKS+WBhIEe
         qokg==
X-Gm-Message-State: APjAAAWcEIWF7d6vTW4kmvMDC2dqHF2Mqr53r6+dvesedyAWIBjFaW9e
        zzLNNB/9BJuKALp+FDy3lZA=
X-Google-Smtp-Source: APXvYqz5x8aXYAuwNnis53lPnqsBoHOkOOUkQkfA0jt7m32Al1K4dQEwzudPGwVsj3S9nm3uOPD3tg==
X-Received: by 2002:adf:b605:: with SMTP id f5mr2275860wre.383.1575445897033;
        Tue, 03 Dec 2019 23:51:37 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id x7sm6923479wrq.41.2019.12.03.23.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 23:51:36 -0800 (PST)
Date:   Wed, 4 Dec 2019 08:51:34 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Sudipm Mukherjee <sudipm.mukherjee@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL] perf/core improvements and fixes
Message-ID: <20191204075134.GA29770@gmail.com>
References: <20191203135606.24902-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191203135606.24902-1-acme@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo/Thomas,
> 
> 	Please consider pulling,
> 
> Best regards,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit e680a41fcaf07ccac8817c589fc4824988b48eac:
> 
>   Merge tag 'perf-core-for-mingo-5.5-20191128' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2019-11-29 06:56:05 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.5-20191203
> 
> for you to fetch changes up to 15b3904f8e884e0d34d5f09906cf6526d0b889a2:
> 
>   libtraceevent: Copy pkg-config file to output folder when using O= (2019-12-02 21:58:20 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> perf report/top:
> 
>   - Fix segfault due to missing initialization of recently introduced
>     struct map_symbol 'maps' field in append_inlines(), when running
>     with DWARF callchains.
> 
> perf stat:
> 
>   Andi Kleen:
> 
>   - Affinity based optimizations for sessions with many events in
>     machines with large core counts, avoiding excessive number of IPIs.
> 
> libtraceevent:
> 
>   - Sudip Mukherjee:
> 
>   - Fix installation with O=.
> 
>   - Copy pkg-config file to output folder when using O=.
> 
> perf bench:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Update the copies of x86's mem{cpy,set}_64.S, and because that
>     now uses new stuff in linux/linkage.h, update that header too, which
>     made the minimal clang version to build perf to be 3.5, as
>     3.4 as found in some of the container images used to test build perf
>     can't grok STT_FUNC as a token in .type lines.
> 
> ABI headers:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Sync x86's msr-index.h copy with the kernel sources, resulting
>     in new MSRs to be usable in filter expressions in 'perf trace',
>     such as IA32_TSX_CTRL.
> 
>   - Sync linux/fscrypt.h, linux/stat.h, sched.h and the kvm headers.
> 
> perf trace:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Add CLEAR_SIGHAND support for clone's flags arg
> 
> perf kvm:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Clarify the 'perf kvm' -i and -o command line options
> 
> perf test:
> 
>   Ian Rogers:
> 
>   - Move test functionality in to a 'perf test' entry.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Andi Kleen (10):
>       perf cpumap: Maintain cpumaps ordered and without dups
>       perf evlist: Maintain evlist->all_cpus
>       perf evsel: Add iterator to iterate over events ordered by CPU
>       perf evsel: Add functions to close evsel on a CPU
>       perf stat: Use affinity for closing file descriptors
>       perf stat: Factor out open error handling
>       perf stat: Use affinity for opening events
>       perf stat: Use affinity for reading
>       perf evsel: Add functions to enable/disable for a specific CPU
>       perf stat: Use affinity for enabling/disabling events
> 
> Arnaldo Carvalho de Melo (10):
>       perf machine: Fill map_symbol->maps in append_inlines() to fix segfault
>       perf bench: Update the copies of x86's mem{cpy,set}_64.S
>       tools arch x86: Sync the msr-index.h copy with the kernel sources
>       tools headers uapi: Sync linux/fscrypt.h with the kernel sources
>       tools headers uapi: Sync linux/stat.h with the kernel sources
>       tools headers kvm: Sync kvm headers with the kernel sources
>       tools headers UAPI: Sync sched.h with the kernel
>       perf beauty: Add CLEAR_SIGHAND support for clone's flags arg
>       tools arch x86: Sync asm/cpufeatures.h with the kernel sources
>       perf kvm: Clarify the 'perf kvm' -i and -o command line options
> 
> Ian Rogers (1):
>       perf jit: Move test functionality in to a test
> 
> Sudip Mukherjee (2):
>       libtraceevent: Fix lib installation with O=
>       libtraceevent: Copy pkg-config file to output folder when using O=
> 
>  tools/arch/arm/include/uapi/asm/kvm.h     |   3 +-
>  tools/arch/arm64/include/uapi/asm/kvm.h   |   5 +-
>  tools/arch/powerpc/include/uapi/asm/kvm.h |   3 +
>  tools/arch/x86/include/asm/cpufeatures.h  |   3 +
>  tools/arch/x86/include/asm/msr-index.h    |  18 ++
>  tools/arch/x86/lib/memcpy_64.S            |  20 +--
>  tools/arch/x86/lib/memset_64.S            |  16 +-
>  tools/include/uapi/linux/fscrypt.h        |   3 +-
>  tools/include/uapi/linux/kvm.h            |  11 ++
>  tools/include/uapi/linux/sched.h          |  60 +++++--
>  tools/include/uapi/linux/stat.h           |   2 +-
>  tools/lib/traceevent/Makefile             |   6 +-
>  tools/perf/Documentation/perf-kvm.txt     |   5 +-
>  tools/perf/arch/arm/tests/regs_load.S     |   4 +-
>  tools/perf/arch/arm64/tests/regs_load.S   |   4 +-
>  tools/perf/arch/x86/tests/regs_load.S     |   8 +-
>  tools/perf/builtin-record.c               |   2 +-
>  tools/perf/builtin-stat.c                 | 288 +++++++++++++++++++++---------
>  tools/perf/check-headers.sh               |   4 +-
>  tools/perf/lib/cpumap.c                   |  73 +++++++-
>  tools/perf/lib/evlist.c                   |   1 +
>  tools/perf/lib/evsel.c                    |  76 ++++++--
>  tools/perf/lib/include/internal/evlist.h  |   1 +
>  tools/perf/lib/include/perf/cpumap.h      |   2 +
>  tools/perf/lib/include/perf/evsel.h       |   3 +
>  tools/perf/tests/Build                    |   1 +
>  tools/perf/tests/builtin-test.c           |   9 +
>  tools/perf/tests/cpumap.c                 |  16 ++
>  tools/perf/tests/event-times.c            |   4 +-
>  tools/perf/tests/genelf.c                 |  51 ++++++
>  tools/perf/tests/tests.h                  |   2 +
>  tools/perf/trace/beauty/clone.c           |   1 +
>  tools/perf/util/cpumap.h                  |   1 +
>  tools/perf/util/evlist.c                  | 113 +++++++++++-
>  tools/perf/util/evlist.h                  |  11 +-
>  tools/perf/util/evsel.c                   |  35 +++-
>  tools/perf/util/evsel.h                   |   9 +-
>  tools/perf/util/genelf.c                  |  46 -----
>  tools/perf/util/include/linux/linkage.h   |  89 ++++++++-
>  tools/perf/util/machine.c                 |   1 +
>  tools/perf/util/stat.c                    |   5 +-
>  tools/perf/util/stat.h                    |   3 +-
>  42 files changed, 789 insertions(+), 229 deletions(-)
>  create mode 100644 tools/perf/tests/genelf.c

Pulled, thanks a lot Arnaldo!

	Ingo
