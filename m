Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D6CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C2472171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551338901;
	bh=4TT7ey46HF4S36pvNj5XW0jgXOhQ/HEp/vPsQOJnExM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=R06wkiNMpJgfHOv5jz4Iw4V3oQpiyOvvpmNdTCvv3IA4JYCTQcLMA0D7rlCLvhwa3
	 YeNpbDjIHuY/O5DsT7dv0azlBupd/TD6EbNnxfUVPEWXAN0VNAkoV3r+uRSw0MAK39
	 EtmNtS52d7NDhf6Q2OXzezpujuwcPLmse9ZZXCck=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731628AbfB1H2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 02:28:19 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54784 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730263AbfB1H2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 02:28:19 -0500
Received: by mail-wm1-f68.google.com with SMTP id a62so8196166wmh.4;
        Wed, 27 Feb 2019 23:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4LIRyTw78t/w4KjR7B1HFKexn77bP27Fx0yC3PljeZ4=;
        b=lOAdXl0iHRfbtmZs4mPA7yTlEPxZ1QWKqKwGRMcD8y7sG8Si5hwx2Qr9i3pCI/NEe0
         K13/jQyvNytm+2xINxXZXB+WUkUBkY+pAXLasqQq+DgsJVOWB2+F7vAfx07Tg6RARdv0
         /mAMHVcHiFs3Oj8HZoWDK0UPdAhekZnlcbw5ROprlIFdK1OGlyRrAwHjvMaQyo0X3tP5
         gDw+4/b53OTcvssNba6teVi2Br1dipWLsIPQWE1ueUMl5B+Cpzpdoi/inCxWtI4hR9DL
         uVD3gybTWwgPeQZHhpiXrVTYnc/RIwjcgeg9z1lDkXWsY+CCSCRMZ0ItQ78kMu3QI117
         TUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=4LIRyTw78t/w4KjR7B1HFKexn77bP27Fx0yC3PljeZ4=;
        b=d4DCVXqM2mJOtSvxra8pRytAadLOXhrvXNuXkjD8goKFmK36rmJJZejRtUQ/+RPpdx
         OcU7TrhocvK0sVIp38RW7piGE7qQTXAcQY9NR+GPgOmp4cuLeqRvLPiRS2XjTSsM3gpL
         SakK4ulzNEZ81IsBynSzUUTebOFEc5vUtR6oKBJpyoE+n9eL2eQoiCUgTgHtbZiS1MZH
         7aXV0ZzL/k7asmwUkM5GrFLQPiJO9JNQJXVb9OUhj/EUV2ojmOaHKs+ml+Stx5RvgFt/
         5pMdLAuNIyN83rjksANG20+v+W1AI/EF5Y8upT+Cvq5tgadEzwRJW1+lXXXlnzcxWTcn
         80mg==
X-Gm-Message-State: AHQUAuZkxBI+6XU8WEOmUQjBqkEBzCiyGtZk7gepZO3LDSE+4HcPhsgH
        wQSqKCcHJyZoarGMm4vrApKS5Oyr
X-Google-Smtp-Source: APXvYqxIpJTa729OndJv2PEJ0Xc9yrwtfkhZPl3LbARSouEf1hX0XTJlDxzr5nfBomjLdL1IUmwgRw==
X-Received: by 2002:a7b:cb48:: with SMTP id v8mr1796698wmj.138.1551338895479;
        Wed, 27 Feb 2019 23:28:15 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id y1sm13086605wrh.65.2019.02.27.23.28.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Feb 2019 23:28:14 -0800 (PST)
Date:   Thu, 28 Feb 2019 08:28:12 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        He Kuang <hekuang@huawei.com>,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tommi Rantala <tommi.t.rantala@nokia.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 00/17] perf/core improvements and fixes
Message-ID: <20190228072812.GA59852@gmail.com>
References: <20190221012549.4069-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221012549.4069-1-acme@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 43f4e6279f05eefac058a3524e184cecae463bfe:
> 
>   Merge tag 'perf-core-for-mingo-5.1-20190214' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2019-02-15 10:19:11 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.1-20190220
> 
> for you to fetch changes up to b4409ae112caa6315f6ee678e953b9fc93e6919c:
> 
>   perf tools: Make rm_rf() remove single file (2019-02-20 17:09:28 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> perf report:
> 
>   He Kuang:
> 
>   - Don't shadow inlined symbol with different addr range.
> 
> perf script:
> 
>   Jiri Olsa:
> 
>   - Allow +- operator to ask for -F to add/remove fields to
>     the default set, for instance to ask for the removal of the
>     'cpu' field in tracepoint events, adding 'period' to that
>     kind of events, etc.
> 
> perf test:
> 
>   Thomas Richter:
> 
>   - Fix scheduler tracepoint signedness of COMM fields failure of
>     'evsel-tp-sched' test on s390 and other arches.
> 
>   Tommi Rantala:
> 
>   - Skip trace+probe_vfs_getname.sh when 'perf trace' is not built.
> 
> perf trace:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Add initial BPF map dumper, initially just for the current, minimal
>     needs of the augmented_raw_syscalls BPF example used to collect
>     pointer args payloads that uses BPF maps for pid and syscall filtering,
>     but will in time have features similar to 'perf stat' --interval-print,
>     --interval-clear, ways to signal from a BPF event that a specific
>     map (or range of that map) should be printed, optionally as a
>     histogram, etc.
> 
> General:
> 
>   Jiri Olsa:
> 
>   - Add cpu and numa topologies classes for further reuse, fixing some
>     issues in the process.
> 
>   - Fixup some warnings and debug levels.
> 
>   - Make rm_rf() remove single file, not just directories.
> 
> Documentation:
> 
>   Jonas Rabenstein:
> 
>   - Fix HEADER_CMDLINE description in perf.data documentation.
> 
>   - Fix documentation of the Flags section in perf.data.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (2):
>       perf bpf: Add bpf_map dumper
>       perf trace: Allow dumping a BPF map after setting up BPF events
> 
> He Kuang (1):
>       perf report: Don't shadow inlined symbol with different addr range
> 
> Jiri Olsa (10):
>       perf header: Fix wrong node write in NUMA_TOPOLOGY feature
>       perf tools: Add cpu_topology object
>       perf tools: Add numa_topology object
>       perf tools: Use sysfs__mountpoint() when reading cpu topology
>       perf session: Don't report zero period samples for slave events
>       perf evsel: Force sample_type for slave events
>       perf script: Allow +- operator for type specific fields option
>       perf bpf-event: Add missing new line into pr_debug call
>       perf cpumap: Increase debug level for cpu_map__snprint verbose output
>       perf tools: Make rm_rf() remove single file
> 
> Jonas Rabenstein (2):
>       perf doc: Fix HEADER_CMDLINE description in perf.data documentation
>       perf doc: Fix documentation of the Flags section in perf.data
> 
> Thomas Richter (1):
>       perf test: Fix failure of 'evsel-tp-sched' test on s390
> 
> Tommi Rantala (1):
>       perf tests shell: Skip trace+probe_vfs_getname.sh if built without trace support
> 
>  tools/perf/Documentation/perf-script.txt           |   6 +
>  tools/perf/Documentation/perf-trace.txt            |   8 +
>  tools/perf/Documentation/perf.data-file-format.txt |  11 +-
>  tools/perf/builtin-script.c                        |   8 +
>  tools/perf/builtin-trace.c                         |  19 ++
>  tools/perf/tests/evsel-tp-sched.c                  |   6 +-
>  tools/perf/tests/shell/lib/probe.sh                |   5 +
>  tools/perf/tests/shell/trace+probe_vfs_getname.sh  |   1 +
>  tools/perf/util/Build                              |   2 +
>  tools/perf/util/bpf-event.c                        |   2 +-
>  tools/perf/util/bpf_map.c                          |  72 ++++++
>  tools/perf/util/bpf_map.h                          |  22 ++
>  tools/perf/util/cpumap.c                           |   2 +-
>  tools/perf/util/cputopo.c                          | 277 +++++++++++++++++++++
>  tools/perf/util/cputopo.h                          |  33 +++
>  tools/perf/util/evsel.c                            |   8 +
>  tools/perf/util/header.c                           | 269 +++-----------------
>  tools/perf/util/session.c                          |   7 +
>  tools/perf/util/sort.c                             |  10 +-
>  tools/perf/util/srcline.c                          |   2 +-
>  tools/perf/util/util.c                             |  16 +-
>  21 files changed, 530 insertions(+), 256 deletions(-)
>  create mode 100644 tools/perf/util/bpf_map.c
>  create mode 100644 tools/perf/util/bpf_map.h
>  create mode 100644 tools/perf/util/cputopo.c
>  create mode 100644 tools/perf/util/cputopo.h

Pulled, thanks a lot Arnaldo!

	Ingo
