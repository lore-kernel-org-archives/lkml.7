Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA206C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 10:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69BC12070C
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 10:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569149222;
	bh=6a0x1ZwfDAMzV7h1tedkMs+pXYrL6ukUXbFgkLRH8GE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HirFW/kntMlb0NBEC6kfBIAKbwVIOm3tOBB+NQ2hIv2SQTEC86F5H4mO1EOzlFEpt
	 KeHGcItSISh38+WIqwu9bMcuBNHTHeX/ynyPi8lnvxIHVPp9NBpycU0k1EWWcyyp6n
	 IX5j4taQBaBviWAf0DulI0JrJvf/UZywOqLWqxqw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbfIVKqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 06:46:34 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37527 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbfIVKqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 06:46:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id i1so10891259wro.4;
        Sun, 22 Sep 2019 03:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f+9ts0Pf9SftCkxyP0Cf6l+REihHpWsd6Tg+u+62LJA=;
        b=IXN+Z8YrnaVeuc/N7lJlsUVBTJ/1MKKbLZssvSZNHv4bafoEYawOw45Iu3MXlJKsmn
         b6ACP6nnk5T4qOCIkJ6F0sMCFAYK+GjgBxyjvXg5b1AKDaR2vbqAGQakwE985prNsGhc
         52JaaAc+BQjUNxnMLXPZXghVnukZlk1wzZWBzAPr5oQiAwI6y/+mH/jf4142qKtXI9Kl
         x6QHbgopB1xcZwJ5YBZDIVNPP24v+cwuZA6P2wjl0gLadj1ya6CCvQt8gJS6MNgyjGGw
         goVNtWeGkwIofS8yGVQ6feMDUDzc1HnUbVYQKpJWmC/n2dNEI0kQREbBomak9TZcF3Ff
         5wfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=f+9ts0Pf9SftCkxyP0Cf6l+REihHpWsd6Tg+u+62LJA=;
        b=Sa19qtakYMajFJjzgrjgxexpGfG5kHsJFQThjj08RKfpHAGndGz36pXJWxMrL/kBKs
         zIhjqUMS+c0r95TTUNfMG6BE3ow5LdaV01svd2lYuw4xzls6U7Bw1OWE1CqIkL1cuqjz
         nHpzuFkztnAI4GNWm9igmAfyRAx3uXpUoH1M4vvBzuufv8LXj1BeLQIrLR2N5WSiL+fr
         vkD/FhhlvxEiN6DNU3mAtIABgqeKSSDUTMWV9ko8BmBEUA39RGS0XJ50YDlazyEltFdI
         zx78p8kYER/KZZ3L1xs3Dtf3Cb47hY8L59z8g3rO/2kJPO2XPLSo1610gAuKytWIcoD9
         nFHQ==
X-Gm-Message-State: APjAAAXCCcZlxDQ3ZC+joMADupAR9DjVNkCVgDEUYfMqHzFAZXDcOHog
        3UK2CFyGCMDkWDM1yu6KStI=
X-Google-Smtp-Source: APXvYqzfugc014quZ9sU4Z9pMPMEFwqzpM7THLbteMsmFEh2H7GZ5q3nPJoiU/pZHvAbKuNyDDkI4w==
X-Received: by 2002:a5d:63ca:: with SMTP id c10mr17664940wrw.314.1569149190902;
        Sun, 22 Sep 2019 03:46:30 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id l9sm6828578wme.45.2019.09.22.03.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2019 03:46:30 -0700 (PDT)
Date:   Sun, 22 Sep 2019 12:46:28 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>,
        Roy Ben Shlomo <royb@sentinelone.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL] perf/urgent fixes
Message-ID: <20190922104628.GA122003@gmail.com>
References: <20190921124240.15741-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190921124240.15741-1-acme@kernel.org>
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
> The following changes since commit 351a1f5c8afa13ea5cfcdae543f6596ef8ebdbd9:
> 
>   Merge tag 'perf-core-for-mingo-5.4-20190920-2' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2019-09-20 18:16:42 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-5.4-20190921
> 
> for you to fetch changes up to 9f014e3a66bc936412b6614304a4e6c70c70230e:
> 
>   perf/core: Fix several typos in comments (2019-09-20 16:05:20 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes
> 
> perf tests:
> 
>   Jiri Olsa:
> 
>   - Fix 'make -C tools/perf build-test' static build entry.
> 
> perf record:
> 
>   Jiri Olsa:
> 
>   - Fix segfault in cpu_cache_level__read() when reading CPU topology.
> 
> session:
> 
>   Mamatha Inamdar:
> 
>   - Properly propagate error when reading a perf.data file, it may
>     not exist or the user may not have permissions, etc.
> 
> perf probe:
> 
>   Masami Hiramatsu:
> 
>   - Skip same probe address for a given line.
> 
>   - Clear tev->nargs in clear_probe_trace_event(), fixing segfault.
> 
> tools headers UAPI:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Sync headers, among them prctl.h, that introduces two new options
>     that are now supported in the 'perf trace' prctl syscall args
>     beautifiers.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (4):
>       tools headers uapi: Sync prctl.h with the kernel sources
>       tools uapi asm-generic: Sync unistd.h with the kernel sources
>       tools arch x86 uapi: Synch asm/unistd.h with the kernel sources
>       tools arch x86: Sync asm/cpufeatures.h with the kernel sources
> 
> Jiri Olsa (2):
>       perf tests: Fix static build test
>       perf tools: Fix segfault in cpu_cache_level__read()
> 
> Mamatha Inamdar (1):
>       perf session: Return error code for perf_session__new() function on failure
> 
> Masami Hiramatsu (2):
>       perf probe: Skip same probe address for a given line
>       perf probe: Fix to clear tev->nargs in clear_probe_trace_event()
> 
> Roy Ben Shlomo (1):
>       perf/core: Fix several typos in comments
> 
>  kernel/events/core.c                     |  6 +++---
>  tools/arch/x86/include/asm/cpufeatures.h |  3 +++
>  tools/arch/x86/include/uapi/asm/unistd.h |  2 +-
>  tools/include/uapi/asm-generic/unistd.h  |  2 +-
>  tools/include/uapi/linux/prctl.h         |  7 ++++++-
>  tools/perf/builtin-annotate.c            |  5 +++--
>  tools/perf/builtin-buildid-cache.c       |  5 +++--
>  tools/perf/builtin-buildid-list.c        |  5 +++--
>  tools/perf/builtin-c2c.c                 |  6 ++++--
>  tools/perf/builtin-diff.c                |  9 +++++----
>  tools/perf/builtin-evlist.c              |  5 +++--
>  tools/perf/builtin-inject.c              |  5 +++--
>  tools/perf/builtin-kmem.c                |  5 +++--
>  tools/perf/builtin-kvm.c                 |  9 +++++----
>  tools/perf/builtin-lock.c                |  5 +++--
>  tools/perf/builtin-mem.c                 |  5 +++--
>  tools/perf/builtin-record.c              |  5 +++--
>  tools/perf/builtin-report.c              |  4 ++--
>  tools/perf/builtin-sched.c               | 11 ++++++-----
>  tools/perf/builtin-script.c              |  9 +++++----
>  tools/perf/builtin-stat.c                | 11 ++++++-----
>  tools/perf/builtin-timechart.c           |  5 +++--
>  tools/perf/builtin-top.c                 |  5 +++--
>  tools/perf/builtin-trace.c               |  4 ++--
>  tools/perf/tests/make                    |  2 +-
>  tools/perf/tests/topology.c              |  5 +++--
>  tools/perf/util/data-convert-bt.c        |  5 ++++-
>  tools/perf/util/header.c                 |  2 +-
>  tools/perf/util/probe-event.c            |  1 +
>  tools/perf/util/probe-finder.c           | 19 +++++++++++++++++++
>  tools/perf/util/session.c                | 15 +++++++++++----
>  31 files changed, 122 insertions(+), 65 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
