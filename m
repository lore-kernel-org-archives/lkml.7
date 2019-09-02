Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06BFC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 07:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95869214AE
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 07:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567408447;
	bh=j9rVBeHQTaREZ2ZOpOC2Pm60nG07vIYTNqximjGp4jk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=l5jG+k/93LXiu87tOxG0qiyEPdJfZyF2YNIPhgw1LhYdWzwtwlvkfxU/Al/ROVjAf
	 nuOSJ5t1HHM8mCPVzxjiu37TTbW5RHh8mi6PIuzLnhUVPiJmatkF7DlC1q3VsiiXrv
	 gtfLYyIKZjQ+ENMo3rWxH6X4+7Pj7pBkJwaveGws=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbfIBHOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 03:14:06 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45837 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729330AbfIBHOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 03:14:06 -0400
Received: by mail-wr1-f67.google.com with SMTP id q12so12765452wrj.12;
        Mon, 02 Sep 2019 00:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vO5d4cUFChe2VbGlXdRGPJ0XS7QEzsDvpAdUCkuFtKY=;
        b=KDmP2ERCP25zRiqICNZoWSnbqHI+rqOKL+N7wlxg5v3Cz/gn8E1FpQqB5TUnW3rnHT
         GPFV13k+9w6RxQp0MJDSR7un5HdzsMEGZb+OP7SY+onBaHq5TJrD6xRFDxyoEah0kca1
         OmXgdVAMx8syk5kNcT1Fyz/tZmpTh3IMOifejXjqyO89nY8yyOI1EXXyGAoJB4On4oMw
         zBSdMgMxTVJ07kKzcY5kPFAix4QO1NPJWAp4H5aiPjzycDge5nV7PVW16Zl6JdSppZHf
         igW4WFPZqzzC9PgEONBBgfeISDYMu4DUxKJ9PZADL2kPiA2jlFUspxzk4XqtYOVydY7o
         i6WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=vO5d4cUFChe2VbGlXdRGPJ0XS7QEzsDvpAdUCkuFtKY=;
        b=k6GTGUNHkKoSy1mXMV79O4bZpiiyjJ3CGlxaznpDpQDsV6dr7UNHKZoFtrFPxpU/Oy
         r/I/hVFe50OYNh6oEANPnhNuD0UrZoWVDzzQGyOHCc4/jlpTsr+tYXbctTKqvCzokNR7
         Hh9+9y0qfwrNq6OSHNgiL6HZO07qZNEyZPXYIZ0/4RmC3PDqJWFxK2UFCquJ7QsO65rz
         NyJmBespHWrGl6P1DbBUyw6rQGhQh3isd6pA/lyuyqoNJEds2xgbLypyW2x2bTIFRKGp
         NWNcNvcfKF/747Hd5c0SUd3NbNClh16/CFs8kJUv3M/AnStfZwLm+uxnUKkpHhZqKqVm
         NL1g==
X-Gm-Message-State: APjAAAXq+xVLurA1APrGQyra3rlI/oIG84z6kUWXjTKSRd8IWlLYDn2H
        q1BTsJX1gU+5dVA98xtplcs=
X-Google-Smtp-Source: APXvYqw/czmUQgvSXxWGhLskf3qiYfTq16lVVMs2yElfsmPUaQCsBSr5mkW0ASArzJEQmz7++IL8gA==
X-Received: by 2002:adf:bace:: with SMTP id w14mr35954703wrg.283.1567408443535;
        Mon, 02 Sep 2019 00:14:03 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id o8sm732332wmc.30.2019.09.02.00.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 00:14:02 -0700 (PDT)
Date:   Mon, 2 Sep 2019 09:14:00 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jin Yao <yao.jin@linux.intel.com>,
        Joe Mario <jmario@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kyle Meyer <kyle.meyer@hpe.com>,
        Patrick McLean <chutzpah@gentoo.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL] perf/core improvements and fixes
Message-ID: <20190902071400.GA78337@gmail.com>
References: <20190901122326.5793-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190901122326.5793-1-acme@kernel.org>
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
> The following changes since commit 39c2ca43465e0f52ebba3ee96fd03436367c1880:
> 
>   Merge tag 'perf-core-for-mingo-5.4-20190829' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2019-08-29 20:56:32 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.4-20190901
> 
> for you to fetch changes up to ae31a514a134d9e4ca1d7b0f0a19b5934747d79f:
> 
>   objtool: Ignore intentional differences for the x86 insn decoder (2019-08-31 22:27:52 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> objtool:
> 
>   Josh Poimboeuf:
> 
>   - Move x86 insn decoder to a common location.
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Ignore intentional differences for the x86 insn decoder.
> 
> build:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Ignore intentional differences for the x86 insn decoder.
> 
> Intel PT:
> 
>   Josh Poimboeuf:
> 
>   - Use shared x86 insn decoder.
> 
> metric groups:
> 
>   Jin Yao:
> 
>   - Scale the metric result.
> 
>   - Support multiple events.
> 
> perf c2c:
> 
>   Jiri Olsa:
> 
>   - Display proper cpu count in nodes column.
> 
> Miscellaneous:
> 
>   Kyle Meyer:
> 
>   - Replace MAX_NR_CPUS with perf_env::nr_cpus_online, i.e. with
>     the number of online CPUs as detected at tool start and/or
>     recorded in the perf.data file.
> 
> libtraceevent:
> 
>   Tzvetomir Stoyanov:
> 
>   - Simplify the tep_print_event_* APIs.
> 
>   - Remove tep_register_trace_clock().
> 
>   - Change users plugin directory.
> 
> Cleanups:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Continue taming the includes hell: remove needless include directives, fix
>     the fallout, rinse, repeat.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (29):
>       perf tools: Remove needless libtraceevent include directives
>       perf header: Move CPUINFO_PROC to the only file where it is used
>       perf tools: Move everything related to sys_perf_event_open() to perf-sys.h
>       perf time-utils: Adopt rdclock() from perf.h
>       perf tools: Remove needless perf.h include directive from headers
>       perf tools: Remove perf.h from source files not needing it
>       perf tools: Remove debug.h from header files not needing it
>       perf debug: Remove needless include directives from debug.h
>       perf env: Remove env.h from other headers where just a fwd decl is needed
>       perf event: Remove needless include directives from event.h
>       perf dso: Adopt DSO related macros from symbol.h
>       perf symbol: Move C++ demangle defines to the only file using it
>       perf symbols: Add missing linux/refcount.h to symbol.h
>       perf symbols: Move symsrc prototypes to a separate header
>       perf dsos: Move the dsos struct and its methods to separate source files
>       perf hist: Remove needless ui/progress.h from hist.h
>       perf tools: Move 'struct events_stats' and prototypes to separate header
>       perf tools: Remove needless sort.h include directives
>       perf probe: No need for symbol.h, symbol_conf is enough
>       perf tools: Remove needless map.h include directives
>       perf tools: Remove needless thread.h include directives
>       perf tools: Remove needless thread_map.h include directives
>       perf tools: Remove needless evlist.h include directives
>       perf tools: Remove needless evlist.h include directives
>       perf auxtrace: Uninline functions that touch perf_session
>       perf symbols: Move mem_info and branch_info out of symbol.h
>       perf build: Ignore intentional differences for the x86 insn decoder
>       objtool: Update sync-check.sh from perf's check-headers.sh
>       objtool: Ignore intentional differences for the x86 insn decoder
> 
> Jin Yao (3):
>       perf pmu: Change convert_scale from static to global
>       perf metricgroup: Scale the metric result
>       perf metricgroup: Support multiple events for metricgroup
> 
> Jiri Olsa (1):
>       perf c2c: Display proper cpu count in nodes column
> 
> Josh Poimboeuf (4):
>       objtool: Move x86 insn decoder to a common location
>       perf: Update .gitignore file
>       perf intel-pt: Remove inat.c from build dependency list
>       perf intel-pt: Use shared x86 insn decoder
> 
> Kyle Meyer (7):
>       perf timechart: Refactor svg_build_topology_map()
>       perf svghelper: Replace MAX_NR_CPUS with perf_env::nr_cpus_online
>       perf stat: Replace MAX_NR_CPUS with cpu__max_cpu()
>       perf session: Replace MAX_NR_CPUS with perf_env::nr_cpus_online
>       perf machine: Replace MAX_NR_CPUS with perf_env::nr_cpus_online
>       perf header: Replace MAX_NR_CPUS with cpu__max_cpu()
>       libperf: Warn when exceeding MAX_NR_CPUS in cpumap
> 
> Tzvetomir Stoyanov (3):
>       libtraceevent, perf tools: Changes in tep_print_event_* APIs
>       libtraceevent: Remove tep_register_trace_clock()
>       libtraceevent: Change users plugin directory
> 
>  267 files changed, 1319 insertions(+), 3578 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
