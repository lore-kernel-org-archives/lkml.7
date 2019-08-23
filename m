Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAFCC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 10:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CC96206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 10:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566556252;
	bh=GKgY01diFFFrqvIdZkNRN/j8jJtB6+ztGYB7ufcJ0kU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zv0slEp1ygwGsCKW49LCgt1NHs4PrhJ2xUVlMlJrzwKx964X2aCeGYp2Ynu5uHGXv
	 d48U8KSisyA1b4Ns180Huo4bDn+gihi1577j60pCxjGBetxi0C+TB1G0hcg1s/Xs+T
	 vqr24pxhYza7ih3ErF6U+gOvbveITXGmTRFfZanM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390534AbfHWKav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 06:30:51 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38742 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730693AbfHWKau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 06:30:50 -0400
Received: by mail-wr1-f68.google.com with SMTP id g17so8170690wrr.5;
        Fri, 23 Aug 2019 03:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iZbsW1Wa+9GttdQnFIjynzz7NoT2aDEPHbgt6h9R4kI=;
        b=nD01l8xmmIwfc7+EeRG1LNRi7TsejBrZ5+Eii6pgGhRVN2Encpva3qP2FDpJqsVb0P
         n9GE+WULJcLOkj0CXGjQNQ9md2mpZ4kVHRL7u3gVQnjCczcKBwydQCuJGXv7/r8Njkl7
         6C/kM5xgJFqeLdB1xvFQTh0UC3QROrniSPdnDkjWEuw5v39kS1lWw1+CRUPzMoiSpX1z
         OWcjLki9peYX4mojwyquvJMpOafMs81tm5eMZ7y8DZ6zT3TJ4TSIiw1jiHxGhkM/IBMw
         XkOxN3vyU+IKMODg5BLSk6svQPu+tW0asDRWiyv0XymJ632ZS1rQOBcHyGJOTrmmC/dl
         RuGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=iZbsW1Wa+9GttdQnFIjynzz7NoT2aDEPHbgt6h9R4kI=;
        b=Bb+5YK9BBHAb/Ta4fDBEKeDFwvcElUav8aS0QoGW5okH/yrrngI6Jm1h7GRKzVkGO/
         c44PXu+ZRKrr5cfJE96suAXoS3p1R5QHEyiVo0pT5gUpFY8JSUsFneMEDEHbTzOIaKg1
         eahcFEE4ieQACvfZTZ9gVD8GrL/cqikBdo/Y+5HKPPKQvTfi4CiLjhl/YtwBu9FhpqcB
         BXus5ULeQmp7BUzwN6YOT0ERl+NogItF68/h5EhTkpScG3+VU/tDvK5EAErh+rhNkMlo
         HJTp7xTlWMO/wh8riO3y9wkCdSPZLT1ysrjrmkG7oNd6DJr6uCTQNJNIe6QbkuueEIaI
         EPcw==
X-Gm-Message-State: APjAAAUKt+Ez3MC536F0k2KGjeM2e4J+KA0wHx/aWrfcRtcwuIj9uA+v
        KojklPd1LdCdvlH0XYyKHEY=
X-Google-Smtp-Source: APXvYqxzN8IULDZ5ysCcny8xwlt3UDQhjVxjSe2mV7kBoYTUN7eCLxcYRUH46E1ywi5yRPXhzWMz7w==
X-Received: by 2002:adf:e782:: with SMTP id n2mr4191215wrm.1.1566556247987;
        Fri, 23 Aug 2019 03:30:47 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id e3sm4400365wrs.37.2019.08.23.03.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 03:30:47 -0700 (PDT)
Date:   Fri, 23 Aug 2019 12:30:45 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Gerald Baeza <gerald.baeza@st.com>,
        Nageswara R Sastry <nasastry@in.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL] perf/core improvements and fixes
Message-ID: <20190823103045.GA90468@gmail.com>
References: <20190822210100.3461-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822210100.3461-1-acme@kernel.org>
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
> The following changes since commit 4e92b18e5b0b61211f4511cdbc5803300eeead40:
> 
>   Merge tag 'perf-core-for-mingo-5.4-20190820' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2019-08-20 21:38:22 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.4-20190822
> 
> for you to fetch changes up to d9c5c083416500e95da098c01be092b937def7fa:
> 
>   libperf: Fix alignment trap with xyarray contents in 'perf stat' (2019-08-22 17:16:57 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> perf c2c:
> 
>   Ravi Bangoria:
> 
>   - Fix report with offline cpus.
> 
> libperf:
> 
>   Gerald BAEZA:
> 
>   - Fix alignment trap with xyarray contents in 'perf stat', noticed on ARMv7.
> 
>   Jiri Olsa:
> 
>   - Move some more cpu_map and thread_map methods from tools/perf/util/ to libperf.
> 
> headers:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Do some house cleaning on the headers, removing needless includes in some places,
>     providing forward declarations when those are the only thing needed, and fixing
>     up the fallout from that for cases where we were using stuff and not adding the
>     necessary headers. Should speed up the build and avoid needless rebuilds when
>     something unrelated gets touched.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (18):
>       perf arm64: Add missing debug.h header
>       perf kvm s390: Add missing string.h header
>       perf metricgroup: Remove needless includes from metricgroup.h
>       perf evsel: Move xyarray.h from evsel.c to evsel.h to reduce include dep tree
>       perf counts: Add missing headers needed for types used
>       perf bpf: Add missing xyarray.h header
>       perf evlist: Add missing xyarray.h header
>       perf script: Add missing counts.h
>       perf tests: Add missing counts.h
>       perf stat: Add missing counts.h
>       perf scripting python: Add missing counts.h header
>       perf evsel: Add missing perf/evsel.h header in util/evsel.h
>       perf evsel: Remove needless counts.h header from util/evsel.h
>       perf evsel: Remove needless stddef.h from util/evsel.h
>       perf evsel: util/evsel.h needs stdio.h as it uses FILE
>       perf x86 kvm-stat: Add missing string.h header
>       perf evsel: Switch to libperf's cpumap.h
>       perf cpumap: Remove needless includes from cpumap.h
> 
> Gerald BAEZA (1):
>       libperf: Fix alignment trap with xyarray contents in 'perf stat'
> 
> Jiri Olsa (5):
>       tools headers: Add missing perf_event.h include
>       perf tools: Use perf_cpu_map__nr instead of cpu_map__nr
>       libperf: Move perf's cpu_map__empty() to perf_cpu_map__empty()
>       libperf: Move perf's cpu_map__idx() to perf_cpu_map__idx()
>       libperf: Add perf_thread_map__nr/perf_thread_map__pid functions
> 
> Ravi Bangoria (1):
>       perf c2c: Fix report with offline cpus
> 
>  tools/include/linux/ring_buffer.h                  |  1 +
>  tools/perf/arch/arm/util/cs-etm.c                  | 12 ++++----
>  tools/perf/arch/arm64/util/header.c                |  1 +
>  tools/perf/arch/s390/util/kvm-stat.c               |  1 +
>  tools/perf/arch/x86/util/header.c                  |  1 +
>  tools/perf/arch/x86/util/intel-bts.c               |  4 +--
>  tools/perf/arch/x86/util/intel-pt.c                | 10 +++----
>  tools/perf/arch/x86/util/kvm-stat.c                |  1 +
>  tools/perf/builtin-c2c.c                           |  4 +--
>  tools/perf/builtin-ftrace.c                        |  2 +-
>  tools/perf/builtin-script.c                        |  5 ++--
>  tools/perf/builtin-stat.c                          |  8 +++---
>  tools/perf/builtin-trace.c                         |  4 +--
>  tools/perf/lib/cpumap.c                            | 17 ++++++++++++
>  tools/perf/lib/include/internal/cpumap.h           |  2 ++
>  tools/perf/lib/include/internal/xyarray.h          |  3 +-
>  tools/perf/lib/include/perf/cpumap.h               |  2 ++
>  tools/perf/lib/include/perf/threadmap.h            |  2 ++
>  tools/perf/lib/libperf.map                         |  3 ++
>  tools/perf/lib/threadmap.c                         | 10 +++++++
>  tools/perf/tests/mem2node.c                        |  1 +
>  tools/perf/tests/openat-syscall-all-cpus.c         |  1 +
>  tools/perf/tests/openat-syscall.c                  |  1 +
>  tools/perf/tests/thread-map.c                      |  6 ++--
>  tools/perf/util/auxtrace.c                         |  4 +--
>  tools/perf/util/bpf-loader.c                       |  2 ++
>  tools/perf/util/counts.h                           |  4 +++
>  tools/perf/util/cpumap.c                           | 22 ++++-----------
>  tools/perf/util/cpumap.h                           | 17 ++----------
>  tools/perf/util/cputopo.c                          |  2 ++
>  tools/perf/util/env.c                              |  1 +
>  tools/perf/util/event.c                            | 10 +++----
>  tools/perf/util/evlist.c                           | 32 ++++++++++++----------
>  tools/perf/util/evsel.c                            |  6 ++--
>  tools/perf/util/evsel.h                            | 12 +++++---
>  tools/perf/util/mem2node.c                         |  1 +
>  tools/perf/util/metricgroup.c                      |  3 +-
>  tools/perf/util/metricgroup.h                      | 13 +++++----
>  tools/perf/util/mmap.c                             |  2 +-
>  tools/perf/util/pmu.c                              |  1 +
>  tools/perf/util/record.c                           |  2 +-
>  .../util/scripting-engines/trace-event-python.c    |  3 +-
>  tools/perf/util/stat-display.c                     |  7 +++--
>  tools/perf/util/stat.c                             |  7 +++--
>  tools/perf/util/svghelper.c                        |  1 +
>  tools/perf/util/thread_map.c                       |  4 +--
>  tools/perf/util/thread_map.h                       | 10 -------
>  47 files changed, 155 insertions(+), 113 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
