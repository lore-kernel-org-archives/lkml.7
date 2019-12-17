Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB49C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 11:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A72512082E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 11:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576582137;
	bh=H1Usfbnc/z9GOxmO4yip1S8q3QkWhX1bz0rg9MsJ2xw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EzBYqih0tk0Yd/QuVC8zeedbwMrogsAyg1qyxY9SG6BCxJRifT69vbrMO84U8TrXq
	 7LFugNRYEziSFqv7w2qQ0fLmHvOjWF9KNGc1JSii2B8iOtDon8jvM1//yXhNC/tc3u
	 eGJSjchIn2nmesLXWLqJQIz2n+nMw/QIpsrV+AGs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfLQL24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 06:28:56 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32870 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfLQL24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 06:28:56 -0500
Received: by mail-wr1-f66.google.com with SMTP id b6so10928068wrq.0;
        Tue, 17 Dec 2019 03:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yOj+oQ+bzgrim3CcL28Naf6EscmKWDj1ENE8p1q7KM4=;
        b=fluUU5mGylckLX67l+8ENvQpi44pa12x3aw2Y4V+3gVgAV496uJE2iKPGPk7Dx445V
         WAcvZGQmpTeexUZL9tJf73lPtdKKWyqPIYHVTmMED5PXqHTBuC4MFqnsMu8FjgDvmE3r
         HkqyTgHcuwj0dg9GEOpDKWwMbPgwvnxBGQnSigAEMsMtKrAcO0AI6SNY6k4iD/pED/I8
         nxfDNyAw4dkOhxGZKmtDeqdCLcjYgXz75SDSly2SJnOKvjuyTHlENVGIR+rG6zJNUy3g
         4ZgrVfbJgUBexKEfCPP84kR5fWgm+2I3nO4YOwoj7LKXaZLiZb+POQA6qGn7o8zcEpD0
         0fxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=yOj+oQ+bzgrim3CcL28Naf6EscmKWDj1ENE8p1q7KM4=;
        b=hvFukgtjYgJULmXxySpxrLmfthMAV4k1mnpO7rKbzxDuifNAhP0apiD5EFNiZQ1+dJ
         JKGIpVT/tCGADPZh6v8gaZKfujBj0YxJlgy1eOhG7fjSVSwRKlZBDwHxj5BIyOXUDbkS
         2L8er/JGX55DZRrEc2hJ3UTqRg7E2rUkJQaB5owYXCfcen1kSW2Ed+JfvylczRasc9fs
         EA6dSLj+EJI/8bktudE6OJd/yZsdMNJ6I6EB9SGwsxQzPrXz0Den+0VtByxPbnI+lRRR
         yO+JAO+wuRD5jof08b9w+RGVC5Wr4z61jDj/qij+dmz7G9IG9Hv0pTRNGJAPiZekhd6h
         ktMw==
X-Gm-Message-State: APjAAAV/HQzRsCnw78iL0l9gvruJwdDeba7lV5GzhEJfgb0vbmO9nUhj
        QfP9H8FxD2azYcM4HHMZFPo=
X-Google-Smtp-Source: APXvYqxJ7pYriwi4bf9VR0abVuRkDPgnSjlNM89uOJY54CV+7sH+KlZyKBzWLbLZ5MmxDEwBnVlb5g==
X-Received: by 2002:a5d:5044:: with SMTP id h4mr35297618wrt.4.1576582133344;
        Tue, 17 Dec 2019 03:28:53 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id t8sm25102093wrp.69.2019.12.17.03.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 03:28:52 -0800 (PST)
Date:   Tue, 17 Dec 2019 12:28:50 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Ed Maste <emaste@freebsd.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Sudipm Mukherjee <sudipm.mukherjee@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 0/9] perf/urgent fixes
Message-ID: <20191217112850.GA72342@gmail.com>
References: <20191216204738.12107-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216204738.12107-1-acme@kernel.org>
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
> 
> The following changes since commit 761bfc33dd7504de951aa7b9db27a3cc5df1fde6:
> 
>   Merge remote-tracking branch 'torvalds/master' into perf/urgent (2019-12-11 09:58:16 -0300)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-5.5-20191216
> 
> for you to fetch changes up to 58b3bafff8257c6946df5d6aeb215b8ac839ed2a:
> 
>   perf vendor events s390: Remove name from L1D_RO_EXCL_WRITES description (2019-12-16 13:40:26 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> perf top:
> 
>  Arnaldo Carvalho de Melo:
> 
>  - Do not bail out when perf_env__read_cpuid() returns ENOSYS, which
>    has been reported happening on aarch64.
> 
> perf metricgroup:
> 
>   Kajol Jain:
> 
>   - Fix printing event names of metric group with multiple events
> 
> vendor events:
> 
> x86:
> 
>   Ravi Bangoria:
> 
>   - Fix Kernel_Utilization metric.
> 
> s390:
> 
>   Ed Maste:
> 
>   - Fix counter long description for DTLB1_GPAGE_WRITES and L1D_RO_EXCL_WRITES.
> 
> perf header:
> 
>   Michael Petlan:
> 
>   - Fix false warning when there are no duplicate cache entries
> 
> libtraceevent:
> 
>   Sudip Mukherjee:
> 
>   - Allow custom libdir path
> 
> API headers:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Sync linux/kvm.h with the kernel sources.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (3):
>       tools headers kvm: Sync linux/kvm.h with the kernel sources
>       perf arch: Make the default get_cpuid() return compatible error
>       perf top: Do not bail out when perf_env__read_cpuid() returns ENOSYS
> 
> Ed Maste (2):
>       perf vendor events s390: Fix counter long description for DTLB1_GPAGE_WRITES
>       perf vendor events s390: Remove name from L1D_RO_EXCL_WRITES description
> 
> Kajol Jain (1):
>       perf metricgroup: Fix printing event names of metric group with multiple events
> 
> Michael Petlan (1):
>       perf header: Fix false warning when there are no duplicate cache entries
> 
> Ravi Bangoria (1):
>       perf/x86/pmu-events: Fix Kernel_Utilization metric
> 
> Sudip Mukherjee (1):
>       libtraceevent: Allow custom libdir path
> 
>  tools/include/uapi/linux/kvm.h                     |  1 +
>  tools/lib/traceevent/Makefile                      |  5 +++--
>  tools/lib/traceevent/plugins/Makefile              |  5 +++--
>  tools/perf/builtin-top.c                           | 10 +++++++---
>  .../perf/pmu-events/arch/s390/cf_z13/extended.json |  2 +-
>  .../perf/pmu-events/arch/s390/cf_z14/extended.json |  2 +-
>  .../pmu-events/arch/x86/broadwell/bdw-metrics.json |  2 +-
>  .../arch/x86/broadwellde/bdwde-metrics.json        |  2 +-
>  .../arch/x86/broadwellx/bdx-metrics.json           |  2 +-
>  .../arch/x86/cascadelakex/clx-metrics.json         |  2 +-
>  .../pmu-events/arch/x86/haswell/hsw-metrics.json   |  2 +-
>  .../pmu-events/arch/x86/haswellx/hsx-metrics.json  |  2 +-
>  .../pmu-events/arch/x86/ivybridge/ivb-metrics.json |  2 +-
>  .../pmu-events/arch/x86/ivytown/ivt-metrics.json   |  2 +-
>  .../pmu-events/arch/x86/jaketown/jkt-metrics.json  |  2 +-
>  .../arch/x86/sandybridge/snb-metrics.json          |  2 +-
>  .../pmu-events/arch/x86/skylake/skl-metrics.json   |  2 +-
>  .../pmu-events/arch/x86/skylakex/skx-metrics.json  |  2 +-
>  tools/perf/util/header.c                           | 23 +++++++---------------
>  tools/perf/util/metricgroup.c                      |  7 +++++--
>  20 files changed, 40 insertions(+), 39 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
