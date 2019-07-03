Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0E0C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F75D218A3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562162143;
	bh=xmL2zXrAJPwlaYnqU4CvTDXgTMYRkNwfWA7ZT8xFwyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=l+37SrPfPqn3jtmntAw1peo21vOpJy0bddLIbmXuLLkEL0A+jVYmD0PCoEXaChmgQ
	 4wIOAL21UOtRw1OPDWobQF6TJS+zgZePpIqJ1ZfASnbKPWKCRlO21zbvlwBNGCYvk4
	 j4g10G1rTOx01DTIp/0sY6bb6dva0Glj6ilSu8jE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfGCNzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 09:55:42 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43845 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfGCNzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 09:55:40 -0400
Received: by mail-wr1-f68.google.com with SMTP id p13so2908552wru.10;
        Wed, 03 Jul 2019 06:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dV/apJukwwlJZis67vr8Q5Y+3wSOWPj4g9jnhmYeQKY=;
        b=fGsuPfSHacVFWOnmc8mWgZ+/hHTiW3inIAYhVjuOmlfI2VvOCzWsoZgnsQAotXxtfv
         U7+RbTnTM76c3s4rifZAsegdQijL9LetHqEj8lXpaoEOqUMEg6mqcwyXh2SUTkuLkZXS
         XUzZoyR+PDXCfqETF6WVAJM8Bek2kcf9RV5r1Ab+7eaRMW4lDZodJatvAlBj/4Bw1Jgs
         lkHj8fIVoaLM3MSji8N6OEjegqSXMXP0ZKmSseJjixmZT09FqX5bghtnjg8+aD9pNvGg
         DIIzaIcjh36/rmEyR2tRMW3EJhy6To0Lbxdm+MuhTknOLkbymRumYAMh6FBRcirqaidC
         iGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=dV/apJukwwlJZis67vr8Q5Y+3wSOWPj4g9jnhmYeQKY=;
        b=bxKR+AwheTYK/SZ0Q8YLMpwRIVWBO2E9nlRBWvRFWwbmptAWUq2gWlp+XnCVKQl+eO
         PFofAf+Rjt4PZJWUR07ePTSeDNYCNOrfomu43qnOlvw48EMV11CHv5DQPpw/R9APUyoi
         okki893iBZRsqM3vsVgFcx8s5Eauj14uEhEs2tYw6GpTmeMtDuQ9D9B5x6wL28hM/FA3
         LpWqgJlVeYIW5I0hNoxXfXZyIVQoU8csBlefF4iCV/4aMvg4lwwbqMrNvms3I6fiUQF+
         LWm99VTQnS26eX/F1EBoRC6LEymIemDdFBid+cXU6k62NGhE0DXr2V8mlWi++6pOKouf
         S5AA==
X-Gm-Message-State: APjAAAVkid+hQVFWVxhlHg+MURB7qiHFHy4OaFNb68Kz85SnkxiKME7d
        4i5sxEntlmsCCLE742x5czE=
X-Google-Smtp-Source: APXvYqzhC0mYAzp7qhnh+IU7/PMxrwT3GktuaacZkVlIIBdVvP82PYVveYAAs6KRuJvTdkQuwQcX7Q==
X-Received: by 2002:a5d:43d0:: with SMTP id v16mr27960432wrr.252.1562162138139;
        Wed, 03 Jul 2019 06:55:38 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id l11sm2411156wrw.97.2019.07.03.06.55.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 06:55:37 -0700 (PDT)
Date:   Wed, 3 Jul 2019 15:55:34 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kyle Meyer <kyle.meyer@hpe.com>,
        Luke Mujica <lukemujica@google.com>,
        Mao Han <han_mao@c-sky.com>,
        Numfor Mbiziwo-Tiapo <nums@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL] perf/core improvements and fixes
Message-ID: <20190703135534.GA108545@gmail.com>
References: <20190702022616.1259-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702022616.1259-1-acme@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling,
> 
> Best regards,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit fd7d55172d1e2e501e6da0a5c1de25f06612dc2e:
> 
>   perf/cgroups: Don't rotate events for cgroups unnecessarily (2019-06-24 19:30:04 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.3-20190701
> 
> for you to fetch changes up to 06c642c0e9fceafd16b1a4c80d44b1c09e282215:
> 
>   perf jevents: Use nonlocal include statements in pmu-events.c (2019-07-01 22:50:42 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> perf annotate:
> 
>   Mao Han:
> 
>   - Add support for the csky processor architecture.
> 
> perf stat:
> 
>   Andi Kleen:
> 
>   - Fix metrics with --no-merge.
> 
>   - Don't merge events in the same PMU.
> 
>   - Fix group lookup for metric group.
> 
> Intel PT:
> 
>   Adrian Hunter:
> 
>   - Improve CBR (Core to Bus Ratio) packets support.
> 
>   - Fix thread stack return from kernel for kernel only case.
> 
>   - Export power and ptwrite events to sqlite and postgresql.
> 
> core libraries:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Find routines in tools/perf/util/ that have implementations in the kernel
>     libraries (lib/*.c), such as strreplace(), strim(), skip_spaces() and reuse
>     them after making a copy into tools/lib and tools/include/.
> 
>     This continues the effort of having tools/ code looking as much as possible
>     like kernel source code, to help encourage people to work on both the kernel
>     and in tools hosted in the kernel sources.
> 
>     That in turn will help moving stuff that uses those routines to
>     tools/lib/perf/ where they will be made available for use in other tools.
> 
>     In the process ditch old cruft, remove unused variables and add missing
>     include directives for headers providing things used in places that were
>     building by sheer luck.
> 
>   Kyle Meyer:
> 
>   - Bump MAX_NR_CPUS and MAX_CACHES to get these tools to work on more machines.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Adrian Hunter (9):
>       perf thread-stack: Fix thread stack return from kernel for kernel-only case
>       perf thread-stack: Eliminate code duplicating thread_stack__pop_ks()
>       perf intel-pt: Decoder to output CBR changes immediately
>       perf intel-pt: Cater for CBR change in PSB+
>       perf intel-pt: Add CBR value to decoder state
>       perf intel-pt: Synthesize CBR events when last seen value changes
>       perf db-export: Export synth events
>       perf scripts python: export-to-sqlite.py: Export Intel PT power and ptwrite events
>       perf scripts python: export-to-postgresql.py: Export Intel PT power and ptwrite events
> 
> Andi Kleen (4):
>       perf stat: Make metric event lookup more robust
>       perf stat: Don't merge events in the same PMU
>       perf stat: Fix group lookup for metric group
>       perf stat: Fix metrics with --no-merge
> 
> Arnaldo Carvalho de Melo (26):
>       perf ctype: Remove unused 'graph_line' variable
>       perf ui stdio: No need to use 'spaces' to left align
>       perf ctype: Remove now unused 'spaces' variable
>       perf string: Move 'dots' and 'graph_dotted_line' out of sane_ctype.h
>       tools x86 machine: Add missing util.h to pick up 'page_size'
>       perf kallsyms: Adopt hex2u64 from tools/perf/util/util.h
>       perf symbols: We need util.h in symbol-elf.c for zfree()
>       perf tools: Remove old baggage that is util/include/linux/ctype.h
>       perf tools: Add missing util.h to pick up 'page_size' variable
>       tools perf: Move from sane_ctype.h obtained from git to the Linux's original
>       perf tools: Use linux/ctype.h in more places
>       tools lib: Adopt skip_spaces() from the kernel sources
>       perf stat: Use recently introduced skip_spaces()
>       perf header: Use skip_spaces() in __write_cpudesc()
>       perf time-utils: Use skip_spaces()
>       perf probe: Use skip_spaces() for argv handling
>       perf strfilter: Use skip_spaces()
>       perf metricgroup: Use strsep()
>       perf report: Use skip_spaces()
>       perf tools: Ditch rtrim(), use skip_spaces() to get closer to the kernel
>       tools lib: Adopt strim() from the kernel
>       perf tools: Remove trim() implementation, use tools/lib's strim()
>       perf tools: Ditch rtrim(), use strim() from tools/lib
>       tools lib: Adopt strreplace() from the kernel
>       perf tools: Drop strxfrchar(), use strreplace() equivalent from kernel
>       tools lib: Move argv_{split,free} from tools/perf/util/
> 
> Kyle Meyer (1):
>       perf tools: Increase MAX_NR_CPUS and MAX_CACHES
> 
> Luke Mujica (1):
>       perf jevents: Use nonlocal include statements in pmu-events.c
> 
> Mao Han (1):
>       perf annotate: Add csky support
> 
> Numfor Mbiziwo-Tiapo (1):
>       perf tools: Fix cache.h include directive
> 
>  tools/include/linux/ctype.h                        |  75 ++++++
>  tools/include/linux/string.h                       |  11 +-
>  tools/lib/argv_split.c                             | 100 ++++++++
>  tools/lib/ctype.c                                  |  35 +++
>  tools/lib/string.c                                 |  55 +++++
>  tools/lib/symbol/kallsyms.c                        |  14 +-
>  tools/lib/symbol/kallsyms.h                        |   2 +
>  tools/perf/MANIFEST                                |   2 +
>  tools/perf/arch/arm/util/cs-etm.c                  |   1 +
>  tools/perf/arch/csky/annotate/instructions.c       |  48 ++++
>  tools/perf/arch/s390/util/header.c                 |   2 +-
>  tools/perf/arch/x86/tests/intel-cqm.c              |   1 +
>  tools/perf/arch/x86/util/intel-pt.c                |   1 +
>  tools/perf/arch/x86/util/machine.c                 |   3 +-
>  tools/perf/builtin-kmem.c                          |   3 +-
>  tools/perf/builtin-report.c                        |   5 +-
>  tools/perf/builtin-sched.c                         |   3 +-
>  tools/perf/builtin-script.c                        |  14 +-
>  tools/perf/builtin-stat.c                          |   2 +-
>  tools/perf/builtin-top.c                           |   3 +-
>  tools/perf/builtin-trace.c                         |   2 +-
>  tools/perf/check-headers.sh                        |   2 +
>  tools/perf/perf.c                                  |   1 +
>  tools/perf/perf.h                                  |   2 +-
>  tools/perf/pmu-events/jevents.c                    |   4 +-
>  tools/perf/scripts/python/export-to-postgresql.py  | 251 +++++++++++++++++++++
>  tools/perf/scripts/python/export-to-sqlite.py      | 239 ++++++++++++++++++++
>  tools/perf/tests/builtin-test.c                    |   3 +-
>  tools/perf/tests/code-reading.c                    |   2 +-
>  tools/perf/ui/browser.c                            |   4 +-
>  tools/perf/ui/browsers/hists.c                     |  10 +-
>  tools/perf/ui/browsers/map.c                       |   2 +-
>  tools/perf/ui/gtk/hists.c                          |   5 +-
>  tools/perf/ui/progress.c                           |   2 +-
>  tools/perf/ui/stdio/hist.c                         |  16 +-
>  tools/perf/util/Build                              |   9 +
>  tools/perf/util/annotate.c                         |  20 +-
>  tools/perf/util/auxtrace.c                         |   2 +-
>  tools/perf/util/build-id.c                         |   2 +-
>  tools/perf/util/config.c                           |   2 +-
>  tools/perf/util/cpumap.c                           |   2 +-
>  tools/perf/util/ctype.c                            |  49 ----
>  tools/perf/util/data-convert-bt.c                  |   2 +-
>  tools/perf/util/debug.c                            |   2 +-
>  tools/perf/util/demangle-java.c                    |   2 +-
>  tools/perf/util/dso.c                              |   3 +-
>  tools/perf/util/env.c                              |   2 +-
>  tools/perf/util/event.c                            |   6 +-
>  tools/perf/util/evsel.c                            |   3 +-
>  tools/perf/util/header.c                           |  15 +-
>  tools/perf/util/include/linux/ctype.h              |   1 -
>  .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |  24 +-
>  .../perf/util/intel-pt-decoder/intel-pt-decoder.h  |   1 +
>  tools/perf/util/intel-pt.c                         |  65 ++++--
>  tools/perf/util/jitdump.c                          |   2 +-
>  tools/perf/util/machine.c                          |   3 +-
>  tools/perf/util/metricgroup.c                      |  52 +++--
>  tools/perf/util/pmu.c                              |   5 +-
>  tools/perf/util/print_binary.c                     |   2 +-
>  tools/perf/util/probe-event.c                      |   2 +-
>  tools/perf/util/probe-finder.h                     |   2 +-
>  tools/perf/util/python-ext-sources                 |   3 +-
>  tools/perf/util/python.c                           |   1 +
>  tools/perf/util/sane_ctype.h                       |  52 -----
>  .../util/scripting-engines/trace-event-python.c    |  46 +++-
>  tools/perf/util/srcline.c                          |   3 +-
>  tools/perf/util/stat-display.c                     |  14 +-
>  tools/perf/util/stat-shadow.c                      |  23 +-
>  tools/perf/util/strfilter.c                        |   6 +-
>  tools/perf/util/string.c                           | 169 +-------------
>  tools/perf/util/string2.h                          |  15 +-
>  tools/perf/util/symbol-elf.c                       |   3 +-
>  tools/perf/util/symbol.c                           |   2 +-
>  tools/perf/util/thread-stack.c                     |  48 ++--
>  tools/perf/util/thread_map.c                       |   3 +-
>  tools/perf/util/time-utils.c                       |   8 +-
>  tools/perf/util/trace-event-parse.c                |   2 +-
>  tools/perf/util/util.c                             |  13 --
>  tools/perf/util/util.h                             |   1 -
>  79 files changed, 1167 insertions(+), 450 deletions(-)
>  create mode 100644 tools/include/linux/ctype.h
>  create mode 100644 tools/lib/argv_split.c
>  create mode 100644 tools/lib/ctype.c
>  create mode 100644 tools/perf/arch/csky/annotate/instructions.c
>  delete mode 100644 tools/perf/util/ctype.c
>  delete mode 100644 tools/perf/util/include/linux/ctype.h
>  delete mode 100644 tools/perf/util/sane_ctype.h

Pulled, thanks a lot Arnaldo!

	Ingo
