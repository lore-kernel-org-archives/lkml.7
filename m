Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DD5C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 15:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22F5C21951
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 15:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="keb9meS4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbfGXPZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 11:25:48 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44423 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfGXPZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 11:25:47 -0400
Received: by mail-qt1-f193.google.com with SMTP id 44so14853843qtg.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 08:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qm34SsZmiLnEifiHnyLej5sckE8m4e+bvQCg8tBQEIE=;
        b=keb9meS4LfsmR9GlqiTbj8fsSDY2aHs+bd5q5hv2wgLyGzGyLGuR/VE4vV5eIV7Fgw
         dMiWLa7b7Brs7nWHhh6ZkLKEaf3vhtBSod4PhC0nG/7DgXxT8FeEwz96bT3qXjLpnqDK
         NQ8ymkRSKwlpbgVncZNd7bVcEeubf6H+zpV8QiRoUc+zD/a8DV9I5GSFNyReWfdweugW
         cJLAwKoz4wFSO9rKWbslPU2y+HOCWn/WeXpAMXdbkxp60tglBHwhtiKUhZyBiLDCUR6r
         0RZoFuw8VkfYGnSel2kpZIvWS0dRb4RxYi/8VQvQIQDX/mDRf1v9UnL21KKll7P4n7cT
         NcpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qm34SsZmiLnEifiHnyLej5sckE8m4e+bvQCg8tBQEIE=;
        b=WkVh6KCxsRzx5o1xD9jHYCPeO2x8DGpk6lrqhjpCCC61BbkC3RFv+84F4Xbf/yvhei
         hxuqZ99PjKtC3ONbGvbLunk9cv/hgMJIx7eK5OYD0q2pgy+QstKKPIXCcbIzdVKW4WHW
         tzkFvwObr4kJhWya3d18DQ9qjvgpZN9Jepu+mS2GmTzVp+74rpb6i0obR3Ec8JGS3ZV3
         zFoDfUiFhi66ynkq26mJcaIEwBiDEtvl6svxjCUTj9G14PdEr8KG6RvPFlXnQUijyOWS
         6noTMoGdNAjoHEwViVuxOCZgdyFGnSu8zhpK+UgHJYzmDlVz6nfD64yRPD4IyJgmbh1V
         3fpg==
X-Gm-Message-State: APjAAAUEya8v7lnh8R7FwFQG1EuXg0RJK9HOlrEqVgFa/JT5mbm3I9r8
        aKjoRon6/jBcgmCGo5fFOfW7Guwo
X-Google-Smtp-Source: APXvYqw94XiV7ZpP5AGzWyT7fzXLqfvdlqa9QNtFRM/L9mPlxhcAm7RyxBk9UJMzSpBs72UeSu3RDw==
X-Received: by 2002:ac8:19ac:: with SMTP id u41mr56685720qtj.46.1563981940672;
        Wed, 24 Jul 2019 08:25:40 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id y14sm20634500qkb.109.2019.07.24.08.25.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 08:25:39 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8E08340340; Wed, 24 Jul 2019 12:25:25 -0300 (-03)
Date:   Wed, 24 Jul 2019 12:25:25 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 42/79] libperf: Add attr to perf_evsel
Message-ID: <20190724152525.GB5727@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
 <20190721112506.12306-43-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190721112506.12306-43-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Jul 21, 2019 at 01:24:29PM +0200, Jiri Olsa escreveu:
> Moving perf_event_attr struct into perf_evsel struct.

Fixed up these:

     tools/perf/arch/arm/util/auxtrace.c
     tools/perf/arch/arm/util/cs-etm.c
     tools/perf/arch/arm64/util/arm-spe.c
     tools/perf/arch/s390/util/auxtrace.c
     tools/perf/util/cs-etm.c

I'm now building one by one with these:

[perfbuilder@quaco ~]$ podman ps | grep -- -x-
218b378829bc  localhost/acmel/linux-perf-tools-build-ubuntu:18.04-x-sparc64    /bin/sh  14 minutes ago  Up 14 minutes ago  hardcore_wilson
ab3bae9193c9  localhost/acmel/linux-perf-tools-build-ubuntu:18.04-x-powerpc    /bin/sh  26 minutes ago  Up 26 minutes ago  happy_mcclintock
99284251237b  localhost/acmel/linux-perf-tools-build-ubuntu:18.04-x-powerpc64  /bin/sh  28 minutes ago  Up 28 minutes ago  boring_bell
f5ea4fcc2319  localhost/acmel/linux-perf-tools-build-ubuntu:18.04-x-s390       /bin/sh  28 minutes ago  Up 28 minutes ago  nostalgic_germain
7c190a6e7539  localhost/acmel/linux-perf-tools-build-fedora:30-x-ARC-glibc     /bin/sh  32 minutes ago  Up 32 minutes ago  pensive_clarke
126d7858f5b2  localhost/acmel/linux-perf-tools-build-ubuntu:19.04-x-arm64      /bin/sh  35 minutes ago  Up 35 minutes ago  jovial_allen
[perfbuilder@quaco ~]$

> Link: http://lkml.kernel.org/n/tip-f2ww887pbv1h11eei05vhxh4@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/arch/x86/tests/perf-time-to-tsc.c  |   6 +-
>  tools/perf/arch/x86/util/auxtrace.c           |   4 +-
>  tools/perf/arch/x86/util/intel-bts.c          |  16 +-
>  tools/perf/arch/x86/util/intel-pt.c           |  40 +-
>  tools/perf/builtin-evlist.c                   |   2 +-
>  tools/perf/builtin-inject.c                   |  14 +-
>  tools/perf/builtin-kvm.c                      |   2 +-
>  tools/perf/builtin-record.c                   |   2 +-
>  tools/perf/builtin-script.c                   |  52 +-
>  tools/perf/builtin-stat.c                     |   2 +-
>  tools/perf/builtin-timechart.c                |   2 +-
>  tools/perf/builtin-top.c                      |   2 +-
>  tools/perf/builtin-trace.c                    |  32 +-
>  tools/perf/lib/evsel.c                        |   3 +-
>  tools/perf/lib/include/internal/evsel.h       |   4 +
>  tools/perf/lib/include/perf/evsel.h           |   4 +-
>  tools/perf/tests/code-reading.c               |   6 +-
>  tools/perf/tests/event-times.c                |   8 +-
>  tools/perf/tests/keep-tracking.c              |   6 +-
>  tools/perf/tests/mmap-basic.c                 |   2 +-
>  tools/perf/tests/parse-events.c               | 872 +++++++++---------
>  tools/perf/tests/sample-parsing.c             |   6 +-
>  tools/perf/tests/switch-tracking.c            |   8 +-
>  tools/perf/tests/task-exit.c                  |  14 +-
>  tools/perf/ui/browsers/res_sample.c           |   2 +-
>  tools/perf/ui/browsers/scripts.c              |   2 +-
>  tools/perf/util/auxtrace.c                    |   2 +-
>  tools/perf/util/bpf-loader.c                  |   2 +-
>  tools/perf/util/data-convert-bt.c             |  14 +-
>  tools/perf/util/db-export.c                   |   4 +-
>  tools/perf/util/evlist.c                      |  50 +-
>  tools/perf/util/evsel.c                       | 167 ++--
>  tools/perf/util/evsel.h                       |  17 +-
>  tools/perf/util/evsel_fprintf.c               |   8 +-
>  tools/perf/util/header.c                      |  28 +-
>  tools/perf/util/hist.c                        |   2 +-
>  tools/perf/util/intel-bts.c                   |  18 +-
>  tools/perf/util/intel-pt.c                    |  50 +-
>  tools/perf/util/jitdump.c                     |   4 +-
>  tools/perf/util/machine.c                     |   4 +-
>  tools/perf/util/parse-events.c                |  40 +-
>  tools/perf/util/python.c                      |   6 +-
>  tools/perf/util/record.c                      |  16 +-
>  tools/perf/util/s390-cpumsf.c                 |   2 +-
>  tools/perf/util/s390-sample-raw.c             |   2 +-
>  .../util/scripting-engines/trace-event-perl.c |   6 +-
>  .../scripting-engines/trace-event-python.c    |  14 +-
>  tools/perf/util/session.c                     |  20 +-
>  tools/perf/util/sort.c                        |  12 +-
>  tools/perf/util/stat-display.c                |   8 +-
>  tools/perf/util/stat-shadow.c                 |  30 +-
>  tools/perf/util/stat.c                        |   2 +-
>  tools/perf/util/top.c                         |   2 +-
>  tools/perf/util/trace-event-info.c            |   6 +-
>  54 files changed, 827 insertions(+), 822 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/tests/perf-time-to-tsc.c b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
> index 8b70e9ee341a..07129e007eb0 100644
> --- a/tools/perf/arch/x86/tests/perf-time-to-tsc.c
> +++ b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
> @@ -79,9 +79,9 @@ int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe
>  
>  	evsel = perf_evlist__first(evlist);
>  
> -	evsel->attr.comm = 1;
> -	evsel->attr.disabled = 1;
> -	evsel->attr.enable_on_exec = 0;
> +	evsel->core.attr.comm = 1;
> +	evsel->core.attr.disabled = 1;
> +	evsel->core.attr.enable_on_exec = 0;
>  
>  	CHECK__(evlist__open(evlist));
>  
> diff --git a/tools/perf/arch/x86/util/auxtrace.c b/tools/perf/arch/x86/util/auxtrace.c
> index 6b3ad5c826fd..96f4a2c11893 100644
> --- a/tools/perf/arch/x86/util/auxtrace.c
> +++ b/tools/perf/arch/x86/util/auxtrace.c
> @@ -29,9 +29,9 @@ struct auxtrace_record *auxtrace_record__init_intel(struct evlist *evlist,
>  	intel_bts_pmu = perf_pmu__find(INTEL_BTS_PMU_NAME);
>  
>  	evlist__for_each_entry(evlist, evsel) {
> -		if (intel_pt_pmu && evsel->attr.type == intel_pt_pmu->type)
> +		if (intel_pt_pmu && evsel->core.attr.type == intel_pt_pmu->type)
>  			found_pt = true;
> -		if (intel_bts_pmu && evsel->attr.type == intel_bts_pmu->type)
> +		if (intel_bts_pmu && evsel->core.attr.type == intel_bts_pmu->type)
>  			found_bts = true;
>  	}
>  
> diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
> index 8b0a53d748c9..d8a091266185 100644
> --- a/tools/perf/arch/x86/util/intel-bts.c
> +++ b/tools/perf/arch/x86/util/intel-bts.c
> @@ -113,13 +113,13 @@ static int intel_bts_recording_options(struct auxtrace_record *itr,
>  	btsr->snapshot_mode = opts->auxtrace_snapshot_mode;
>  
>  	evlist__for_each_entry(evlist, evsel) {
> -		if (evsel->attr.type == intel_bts_pmu->type) {
> +		if (evsel->core.attr.type == intel_bts_pmu->type) {
>  			if (intel_bts_evsel) {
>  				pr_err("There may be only one " INTEL_BTS_PMU_NAME " event\n");
>  				return -EINVAL;
>  			}
> -			evsel->attr.freq = 0;
> -			evsel->attr.sample_period = 1;
> +			evsel->core.attr.freq = 0;
> +			evsel->core.attr.sample_period = 1;
>  			intel_bts_evsel = evsel;
>  			opts->full_auxtrace = true;
>  		}
> @@ -231,8 +231,8 @@ static int intel_bts_recording_options(struct auxtrace_record *itr,
>  
>  		perf_evlist__set_tracking_event(evlist, tracking_evsel);
>  
> -		tracking_evsel->attr.freq = 0;
> -		tracking_evsel->attr.sample_period = 1;
> +		tracking_evsel->core.attr.freq = 0;
> +		tracking_evsel->core.attr.sample_period = 1;
>  	}
>  
>  	return 0;
> @@ -316,7 +316,7 @@ static int intel_bts_snapshot_start(struct auxtrace_record *itr)
>  	struct evsel *evsel;
>  
>  	evlist__for_each_entry(btsr->evlist, evsel) {
> -		if (evsel->attr.type == btsr->intel_bts_pmu->type)
> +		if (evsel->core.attr.type == btsr->intel_bts_pmu->type)
>  			return evsel__disable(evsel);
>  	}
>  	return -EINVAL;
> @@ -329,7 +329,7 @@ static int intel_bts_snapshot_finish(struct auxtrace_record *itr)
>  	struct evsel *evsel;
>  
>  	evlist__for_each_entry(btsr->evlist, evsel) {
> -		if (evsel->attr.type == btsr->intel_bts_pmu->type)
> +		if (evsel->core.attr.type == btsr->intel_bts_pmu->type)
>  			return evsel__enable(evsel);
>  	}
>  	return -EINVAL;
> @@ -411,7 +411,7 @@ static int intel_bts_read_finish(struct auxtrace_record *itr, int idx)
>  	struct evsel *evsel;
>  
>  	evlist__for_each_entry(btsr->evlist, evsel) {
> -		if (evsel->attr.type == btsr->intel_bts_pmu->type)
> +		if (evsel->core.attr.type == btsr->intel_bts_pmu->type)
>  			return perf_evlist__enable_event_idx(btsr->evlist,
>  							     evsel, idx);
>  	}
> diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
> index 4ce157a4e5e2..aada6a2c456a 100644
> --- a/tools/perf/arch/x86/util/intel-pt.c
> +++ b/tools/perf/arch/x86/util/intel-pt.c
> @@ -122,8 +122,8 @@ static int intel_pt_read_config(struct perf_pmu *intel_pt_pmu, const char *str,
>  		return -EINVAL;
>  
>  	evlist__for_each_entry(evlist, evsel) {
> -		if (evsel->attr.type == intel_pt_pmu->type) {
> -			*res = intel_pt_masked_bits(mask, evsel->attr.config);
> +		if (evsel->core.attr.type == intel_pt_pmu->type) {
> +			*res = intel_pt_masked_bits(mask, evsel->core.attr.config);
>  			return 0;
>  		}
>  	}
> @@ -274,7 +274,7 @@ static const char *intel_pt_find_filter(struct evlist *evlist,
>  	struct evsel *evsel;
>  
>  	evlist__for_each_entry(evlist, evsel) {
> -		if (evsel->attr.type == intel_pt_pmu->type)
> +		if (evsel->core.attr.type == intel_pt_pmu->type)
>  			return evsel->filter;
>  	}
>  
> @@ -526,26 +526,26 @@ static int intel_pt_validate_config(struct perf_pmu *intel_pt_pmu,
>  	 * sets pt=0, which avoids senseless kernel errors.
>  	 */
>  	if (perf_pmu__scan_file(intel_pt_pmu, "format/pt", "%c", &c) == 1 &&
> -	    !(evsel->attr.config & 1)) {
> +	    !(evsel->core.attr.config & 1)) {
>  		pr_warning("pt=0 doesn't make sense, forcing pt=1\n");
> -		evsel->attr.config |= 1;
> +		evsel->core.attr.config |= 1;
>  	}
>  
>  	err = intel_pt_val_config_term(intel_pt_pmu, "caps/cycle_thresholds",
>  				       "cyc_thresh", "caps/psb_cyc",
> -				       evsel->attr.config);
> +				       evsel->core.attr.config);
>  	if (err)
>  		return err;
>  
>  	err = intel_pt_val_config_term(intel_pt_pmu, "caps/mtc_periods",
>  				       "mtc_period", "caps/mtc",
> -				       evsel->attr.config);
> +				       evsel->core.attr.config);
>  	if (err)
>  		return err;
>  
>  	return intel_pt_val_config_term(intel_pt_pmu, "caps/psb_periods",
>  					"psb_period", "caps/psb_cyc",
> -					evsel->attr.config);
> +					evsel->core.attr.config);
>  }
>  
>  static int intel_pt_recording_options(struct auxtrace_record *itr,
> @@ -566,13 +566,13 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
>  	ptr->snapshot_mode = opts->auxtrace_snapshot_mode;
>  
>  	evlist__for_each_entry(evlist, evsel) {
> -		if (evsel->attr.type == intel_pt_pmu->type) {
> +		if (evsel->core.attr.type == intel_pt_pmu->type) {
>  			if (intel_pt_evsel) {
>  				pr_err("There may be only one " INTEL_PT_PMU_NAME " event\n");
>  				return -EINVAL;
>  			}
> -			evsel->attr.freq = 0;
> -			evsel->attr.sample_period = 1;
> +			evsel->core.attr.freq = 0;
> +			evsel->core.attr.sample_period = 1;
>  			intel_pt_evsel = evsel;
>  			opts->full_auxtrace = true;
>  		}
> @@ -670,7 +670,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
>  
>  	intel_pt_parse_terms(&intel_pt_pmu->format, "tsc", &tsc_bit);
>  
> -	if (opts->full_auxtrace && (intel_pt_evsel->attr.config & tsc_bit))
> +	if (opts->full_auxtrace && (intel_pt_evsel->core.attr.config & tsc_bit))
>  		have_timing_info = true;
>  	else
>  		have_timing_info = false;
> @@ -693,9 +693,9 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
>  
>  				switch_evsel = perf_evlist__last(evlist);
>  
> -				switch_evsel->attr.freq = 0;
> -				switch_evsel->attr.sample_period = 1;
> -				switch_evsel->attr.context_switch = 1;
> +				switch_evsel->core.attr.freq = 0;
> +				switch_evsel->core.attr.sample_period = 1;
> +				switch_evsel->core.attr.context_switch = 1;
>  
>  				switch_evsel->system_wide = true;
>  				switch_evsel->no_aux_samples = true;
> @@ -753,8 +753,8 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
>  
>  		perf_evlist__set_tracking_event(evlist, tracking_evsel);
>  
> -		tracking_evsel->attr.freq = 0;
> -		tracking_evsel->attr.sample_period = 1;
> +		tracking_evsel->core.attr.freq = 0;
> +		tracking_evsel->core.attr.sample_period = 1;
>  
>  		tracking_evsel->no_aux_samples = true;
>  		if (need_immediate)
> @@ -787,7 +787,7 @@ static int intel_pt_snapshot_start(struct auxtrace_record *itr)
>  	struct evsel *evsel;
>  
>  	evlist__for_each_entry(ptr->evlist, evsel) {
> -		if (evsel->attr.type == ptr->intel_pt_pmu->type)
> +		if (evsel->core.attr.type == ptr->intel_pt_pmu->type)
>  			return evsel__disable(evsel);
>  	}
>  	return -EINVAL;
> @@ -800,7 +800,7 @@ static int intel_pt_snapshot_finish(struct auxtrace_record *itr)
>  	struct evsel *evsel;
>  
>  	evlist__for_each_entry(ptr->evlist, evsel) {
> -		if (evsel->attr.type == ptr->intel_pt_pmu->type)
> +		if (evsel->core.attr.type == ptr->intel_pt_pmu->type)
>  			return evsel__enable(evsel);
>  	}
>  	return -EINVAL;
> @@ -1073,7 +1073,7 @@ static int intel_pt_read_finish(struct auxtrace_record *itr, int idx)
>  	struct evsel *evsel;
>  
>  	evlist__for_each_entry(ptr->evlist, evsel) {
> -		if (evsel->attr.type == ptr->intel_pt_pmu->type)
> +		if (evsel->core.attr.type == ptr->intel_pt_pmu->type)
>  			return perf_evlist__enable_event_idx(ptr->evlist, evsel,
>  							     idx);
>  	}
> diff --git a/tools/perf/builtin-evlist.c b/tools/perf/builtin-evlist.c
> index e4cb61dc6315..238fa3876805 100644
> --- a/tools/perf/builtin-evlist.c
> +++ b/tools/perf/builtin-evlist.c
> @@ -36,7 +36,7 @@ static int __cmd_evlist(const char *file_name, struct perf_attr_details *details
>  	evlist__for_each_entry(session->evlist, pos) {
>  		perf_evsel__fprintf(pos, details, stdout);
>  
> -		if (pos->attr.type == PERF_TYPE_TRACEPOINT)
> +		if (pos->core.attr.type == PERF_TYPE_TRACEPOINT)
>  			has_tracepoint = true;
>  	}
>  
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index 4e56e399bbc8..040142581d20 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -530,8 +530,8 @@ static int perf_inject__sched_stat(struct perf_tool *tool,
>  
>  	sample_sw.period = sample->period;
>  	sample_sw.time	 = sample->time;
> -	perf_event__synthesize_sample(event_sw, evsel->attr.sample_type,
> -				      evsel->attr.read_format, &sample_sw);
> +	perf_event__synthesize_sample(event_sw, evsel->core.attr.sample_type,
> +				      evsel->core.attr.read_format, &sample_sw);
>  	build_id__mark_dso_hit(tool, event_sw, &sample_sw, evsel, machine);
>  	return perf_event__repipe(tool, event_sw, &sample_sw, machine);
>  }
> @@ -544,7 +544,7 @@ static void sig_handler(int sig __maybe_unused)
>  static int perf_evsel__check_stype(struct evsel *evsel,
>  				   u64 sample_type, const char *sample_msg)
>  {
> -	struct perf_event_attr *attr = &evsel->attr;
> +	struct perf_event_attr *attr = &evsel->core.attr;
>  	const char *name = perf_evsel__name(evsel);
>  
>  	if (!(attr->sample_type & sample_type)) {
> @@ -578,8 +578,8 @@ static void strip_init(struct perf_inject *inject)
>  
>  static bool has_tracking(struct evsel *evsel)
>  {
> -	return evsel->attr.mmap || evsel->attr.mmap2 || evsel->attr.comm ||
> -	       evsel->attr.task;
> +	return evsel->core.attr.mmap || evsel->core.attr.mmap2 || evsel->core.attr.comm ||
> +	       evsel->core.attr.task;
>  }
>  
>  #define COMPAT_MASK (PERF_SAMPLE_ID | PERF_SAMPLE_TID | PERF_SAMPLE_TIME | \
> @@ -603,8 +603,8 @@ static bool ok_to_remove(struct evlist *evlist,
>  	evlist__for_each_entry(evlist, evsel) {
>  		if (evsel->handler != drop_sample) {
>  			cnt += 1;
> -			if ((evsel->attr.sample_type & COMPAT_MASK) ==
> -			    (evsel_to_remove->attr.sample_type & COMPAT_MASK))
> +			if ((evsel->core.attr.sample_type & COMPAT_MASK) ==
> +			    (evsel_to_remove->core.attr.sample_type & COMPAT_MASK))
>  				ok = true;
>  		}
>  	}
> diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
> index 3370eba0d3f3..b9c58a5c1ba6 100644
> --- a/tools/perf/builtin-kvm.c
> +++ b/tools/perf/builtin-kvm.c
> @@ -1022,7 +1022,7 @@ static int kvm_live_open_events(struct perf_kvm_stat *kvm)
>  	 *       This command processes KVM tracepoints from host only
>  	 */
>  	evlist__for_each_entry(evlist, pos) {
> -		struct perf_event_attr *attr = &pos->attr;
> +		struct perf_event_attr *attr = &pos->core.attr;
>  
>  		/* make sure these *are* set */
>  		perf_evsel__set_sample_bit(pos, TID);
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 778e46417f6b..b7d2c27c4164 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -732,7 +732,7 @@ static int record__open(struct record *rec)
>  		pos->tracking = 0;
>  		pos = perf_evlist__last(evlist);
>  		pos->tracking = 1;
> -		pos->attr.enable_on_exec = 1;
> +		pos->core.attr.enable_on_exec = 1;
>  	}
>  
>  	perf_evlist__config(evlist, opts, &callchain_param);
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index d741c0aa2750..69133b35bbc1 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -345,7 +345,7 @@ static int perf_evsel__do_check_stype(struct evsel *evsel,
>  				      enum perf_output_field field,
>  				      bool allow_user_set)
>  {
> -	struct perf_event_attr *attr = &evsel->attr;
> +	struct perf_event_attr *attr = &evsel->core.attr;
>  	int type = output_type(attr->type);
>  	const char *evname;
>  
> @@ -383,7 +383,7 @@ static int perf_evsel__check_stype(struct evsel *evsel,
>  static int perf_evsel__check_attr(struct evsel *evsel,
>  				  struct perf_session *session)
>  {
> -	struct perf_event_attr *attr = &evsel->attr;
> +	struct perf_event_attr *attr = &evsel->core.attr;
>  	bool allow_user_set;
>  
>  	if (perf_header__has_feat(&session->header, HEADER_STAT))
> @@ -418,7 +418,7 @@ static int perf_evsel__check_attr(struct evsel *evsel,
>  		return -EINVAL;
>  
>  	if (PRINT_FIELD(SYM) &&
> -		!(evsel->attr.sample_type & (PERF_SAMPLE_IP|PERF_SAMPLE_ADDR))) {
> +		!(evsel->core.attr.sample_type & (PERF_SAMPLE_IP|PERF_SAMPLE_ADDR))) {
>  		pr_err("Display of symbols requested but neither sample IP nor "
>  			   "sample address\navailable. Hence, no addresses to convert "
>  		       "to symbols.\n");
> @@ -430,7 +430,7 @@ static int perf_evsel__check_attr(struct evsel *evsel,
>  		return -EINVAL;
>  	}
>  	if (PRINT_FIELD(DSO) &&
> -		!(evsel->attr.sample_type & (PERF_SAMPLE_IP|PERF_SAMPLE_ADDR))) {
> +		!(evsel->core.attr.sample_type & (PERF_SAMPLE_IP|PERF_SAMPLE_ADDR))) {
>  		pr_err("Display of DSO requested but no address to convert.\n");
>  		return -EINVAL;
>  	}
> @@ -531,7 +531,7 @@ static int perf_session__check_output_opt(struct perf_session *session)
>  		if (evsel == NULL)
>  			continue;
>  
> -		set_print_ip_opts(&evsel->attr);
> +		set_print_ip_opts(&evsel->core.attr);
>  	}
>  
>  	if (!no_callchain) {
> @@ -558,7 +558,7 @@ static int perf_session__check_output_opt(struct perf_session *session)
>  		j = PERF_TYPE_TRACEPOINT;
>  
>  		evlist__for_each_entry(session->evlist, evsel) {
> -			if (evsel->attr.type != j)
> +			if (evsel->core.attr.type != j)
>  				continue;
>  
>  			if (evsel__has_callchain(evsel)) {
> @@ -566,7 +566,7 @@ static int perf_session__check_output_opt(struct perf_session *session)
>  				output[j].fields |= PERF_OUTPUT_SYM;
>  				output[j].fields |= PERF_OUTPUT_SYMOFFSET;
>  				output[j].fields |= PERF_OUTPUT_DSO;
> -				set_print_ip_opts(&evsel->attr);
> +				set_print_ip_opts(&evsel->core.attr);
>  				goto out;
>  			}
>  		}
> @@ -617,7 +617,7 @@ static int perf_sample__fprintf_start(struct perf_sample *sample,
>  				      struct evsel *evsel,
>  				      u32 type, FILE *fp)
>  {
> -	struct perf_event_attr *attr = &evsel->attr;
> +	struct perf_event_attr *attr = &evsel->core.attr;
>  	unsigned long secs;
>  	unsigned long long nsecs;
>  	int printed = 0;
> @@ -1168,7 +1168,7 @@ static const char *resolve_branch_sym(struct perf_sample *sample,
>  				      u64 *ip)
>  {
>  	struct addr_location addr_al;
> -	struct perf_event_attr *attr = &evsel->attr;
> +	struct perf_event_attr *attr = &evsel->core.attr;
>  	const char *name = NULL;
>  
>  	if (sample->flags & (PERF_IP_FLAG_CALL | PERF_IP_FLAG_TRACE_BEGIN)) {
> @@ -1195,7 +1195,7 @@ static int perf_sample__fprintf_callindent(struct perf_sample *sample,
>  					   struct thread *thread,
>  					   struct addr_location *al, FILE *fp)
>  {
> -	struct perf_event_attr *attr = &evsel->attr;
> +	struct perf_event_attr *attr = &evsel->core.attr;
>  	size_t depth = thread_stack__depth(thread, sample->cpu);
>  	const char *name = NULL;
>  	static int spacing;
> @@ -1290,7 +1290,7 @@ static int perf_sample__fprintf_bts(struct perf_sample *sample,
>  				    struct addr_location *al,
>  				    struct machine *machine, FILE *fp)
>  {
> -	struct perf_event_attr *attr = &evsel->attr;
> +	struct perf_event_attr *attr = &evsel->core.attr;
>  	unsigned int type = output_type(attr->type);
>  	bool print_srcline_last = false;
>  	int printed = 0;
> @@ -1322,7 +1322,7 @@ static int perf_sample__fprintf_bts(struct perf_sample *sample,
>  
>  	/* print branch_to information */
>  	if (PRINT_FIELD(ADDR) ||
> -	    ((evsel->attr.sample_type & PERF_SAMPLE_ADDR) &&
> +	    ((evsel->core.attr.sample_type & PERF_SAMPLE_ADDR) &&
>  	     !output[type].user_set)) {
>  		printed += fprintf(fp, " => ");
>  		printed += perf_sample__fprintf_addr(sample, thread, attr, fp);
> @@ -1595,7 +1595,7 @@ static int perf_sample__fprintf_synth_cbr(struct perf_sample *sample, FILE *fp)
>  static int perf_sample__fprintf_synth(struct perf_sample *sample,
>  				      struct evsel *evsel, FILE *fp)
>  {
> -	switch (evsel->attr.config) {
> +	switch (evsel->core.attr.config) {
>  	case PERF_SYNTH_INTEL_PTWRITE:
>  		return perf_sample__fprintf_synth_ptwrite(sample, fp);
>  	case PERF_SYNTH_INTEL_MWAIT:
> @@ -1793,7 +1793,7 @@ static void process_event(struct perf_script *script,
>  			  struct machine *machine)
>  {
>  	struct thread *thread = al->thread;
> -	struct perf_event_attr *attr = &evsel->attr;
> +	struct perf_event_attr *attr = &evsel->core.attr;
>  	unsigned int type = output_type(attr->type);
>  	struct evsel_script *es = evsel->priv;
>  	FILE *fp = es->fp;
> @@ -2046,18 +2046,18 @@ static int process_attr(struct perf_tool *tool, union perf_event *event,
>  		}
>  	}
>  
> -	if (evsel->attr.type >= PERF_TYPE_MAX &&
> -	    evsel->attr.type != PERF_TYPE_SYNTH)
> +	if (evsel->core.attr.type >= PERF_TYPE_MAX &&
> +	    evsel->core.attr.type != PERF_TYPE_SYNTH)
>  		return 0;
>  
>  	evlist__for_each_entry(evlist, pos) {
> -		if (pos->attr.type == evsel->attr.type && pos != evsel)
> +		if (pos->core.attr.type == evsel->core.attr.type && pos != evsel)
>  			return 0;
>  	}
>  
> -	set_print_ip_opts(&evsel->attr);
> +	set_print_ip_opts(&evsel->core.attr);
>  
> -	if (evsel->attr.sample_type)
> +	if (evsel->core.attr.sample_type)
>  		err = perf_evsel__check_attr(evsel, scr->session);
>  
>  	return err;
> @@ -2083,7 +2083,7 @@ static int process_comm_event(struct perf_tool *tool,
>  	if (perf_event__process_comm(tool, event, sample, machine) < 0)
>  		goto out;
>  
> -	if (!evsel->attr.sample_id_all) {
> +	if (!evsel->core.attr.sample_id_all) {
>  		sample->cpu = 0;
>  		sample->time = 0;
>  		sample->tid = event->comm.tid;
> @@ -2121,7 +2121,7 @@ static int process_namespaces_event(struct perf_tool *tool,
>  	if (perf_event__process_namespaces(tool, event, sample, machine) < 0)
>  		goto out;
>  
> -	if (!evsel->attr.sample_id_all) {
> +	if (!evsel->core.attr.sample_id_all) {
>  		sample->cpu = 0;
>  		sample->time = 0;
>  		sample->tid = event->namespaces.tid;
> @@ -2157,7 +2157,7 @@ static int process_fork_event(struct perf_tool *tool,
>  		return -1;
>  	}
>  
> -	if (!evsel->attr.sample_id_all) {
> +	if (!evsel->core.attr.sample_id_all) {
>  		sample->cpu = 0;
>  		sample->time = event->fork.time;
>  		sample->tid = event->fork.tid;
> @@ -2189,7 +2189,7 @@ static int process_exit_event(struct perf_tool *tool,
>  		return -1;
>  	}
>  
> -	if (!evsel->attr.sample_id_all) {
> +	if (!evsel->core.attr.sample_id_all) {
>  		sample->cpu = 0;
>  		sample->time = 0;
>  		sample->tid = event->fork.tid;
> @@ -2227,7 +2227,7 @@ static int process_mmap_event(struct perf_tool *tool,
>  		return -1;
>  	}
>  
> -	if (!evsel->attr.sample_id_all) {
> +	if (!evsel->core.attr.sample_id_all) {
>  		sample->cpu = 0;
>  		sample->time = 0;
>  		sample->tid = event->mmap.tid;
> @@ -2261,7 +2261,7 @@ static int process_mmap2_event(struct perf_tool *tool,
>  		return -1;
>  	}
>  
> -	if (!evsel->attr.sample_id_all) {
> +	if (!evsel->core.attr.sample_id_all) {
>  		sample->cpu = 0;
>  		sample->time = 0;
>  		sample->tid = event->mmap2.tid;
> @@ -2360,7 +2360,7 @@ process_bpf_events(struct perf_tool *tool __maybe_unused,
>  	if (machine__process_ksymbol(machine, event, sample) < 0)
>  		return -1;
>  
> -	if (!evsel->attr.sample_id_all) {
> +	if (!evsel->core.attr.sample_id_all) {
>  		perf_event__fprintf(event, stdout);
>  		return 0;
>  	}
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 3ba184f2e64f..8ad3643d61f9 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -391,7 +391,7 @@ static void workload_exec_failed_signal(int signo __maybe_unused, siginfo_t *inf
>  
>  static bool perf_evsel__should_store_id(struct evsel *counter)
>  {
> -	return STAT_RECORD || counter->attr.read_format & PERF_FORMAT_ID;
> +	return STAT_RECORD || counter->core.attr.read_format & PERF_FORMAT_ID;
>  }
>  
>  static bool is_target_alive(struct target *_target,
> diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
> index f5f70c83d304..7d6a6ecf4e02 100644
> --- a/tools/perf/builtin-timechart.c
> +++ b/tools/perf/builtin-timechart.c
> @@ -557,7 +557,7 @@ static int process_sample_event(struct perf_tool *tool,
>  {
>  	struct timechart *tchart = container_of(tool, struct timechart, tool);
>  
> -	if (evsel->attr.sample_type & PERF_SAMPLE_TIME) {
> +	if (evsel->core.attr.sample_type & PERF_SAMPLE_TIME) {
>  		if (!tchart->first_time || tchart->first_time > sample->time)
>  			tchart->first_time = sample->time;
>  		if (tchart->last_time < sample->time)
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index 3291eff13e28..54d06d271bfd 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -966,7 +966,7 @@ static int perf_top_overwrite_fallback(struct perf_top *top,
>  		return 0;
>  
>  	evlist__for_each_entry(evlist, counter)
> -		counter->attr.write_backward = false;
> +		counter->core.attr.write_backward = false;
>  	opts->overwrite = false;
>  	pr_debug2("fall back to non-overwrite mode\n");
>  	return 1;
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 16969a237a3f..fdd72aee7817 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -2058,8 +2058,8 @@ static int trace__resolve_callchain(struct trace *trace, struct evsel *evsel,
>  				    struct callchain_cursor *cursor)
>  {
>  	struct addr_location al;
> -	int max_stack = evsel->attr.sample_max_stack ?
> -			evsel->attr.sample_max_stack :
> +	int max_stack = evsel->core.attr.sample_max_stack ?
> +			evsel->core.attr.sample_max_stack :
>  			trace->max_stack;
>  	int err;
>  
> @@ -2474,7 +2474,7 @@ static int trace__pgfault(struct trace *trace,
>  	if (ttrace == NULL)
>  		goto out_put;
>  
> -	if (evsel->attr.config == PERF_COUNT_SW_PAGE_FAULTS_MAJ)
> +	if (evsel->core.attr.config == PERF_COUNT_SW_PAGE_FAULTS_MAJ)
>  		ttrace->pfmaj++;
>  	else
>  		ttrace->pfmin++;
> @@ -2487,7 +2487,7 @@ static int trace__pgfault(struct trace *trace,
>  	trace__fprintf_entry_head(trace, thread, 0, true, sample->time, trace->output);
>  
>  	fprintf(trace->output, "%sfault [",
> -		evsel->attr.config == PERF_COUNT_SW_PAGE_FAULTS_MAJ ?
> +		evsel->core.attr.config == PERF_COUNT_SW_PAGE_FAULTS_MAJ ?
>  		"maj" : "min");
>  
>  	print_location(trace->output, sample, &al, false, true);
> @@ -2535,7 +2535,7 @@ static void trace__set_base_time(struct trace *trace,
>  	 * appears in our event stream (vfs_getname comes to mind).
>  	 */
>  	if (trace->base_time == 0 && !trace->full_time &&
> -	    (evsel->attr.sample_type & PERF_SAMPLE_TIME))
> +	    (evsel->core.attr.sample_type & PERF_SAMPLE_TIME))
>  		trace->base_time = sample->time;
>  }
>  
> @@ -2694,7 +2694,7 @@ static void trace__handle_event(struct trace *trace, union perf_event *event, st
>  
>  	trace__set_base_time(trace, evsel, sample);
>  
> -	if (evsel->attr.type == PERF_TYPE_TRACEPOINT &&
> +	if (evsel->core.attr.type == PERF_TYPE_TRACEPOINT &&
>  	    sample->raw_data == NULL) {
>  		fprintf(trace->output, "%s sample with no payload for tid: %d, cpu %d, raw_size=%d, skipping...\n",
>  		       perf_evsel__name(evsel), sample->tid,
> @@ -2740,7 +2740,7 @@ static int trace__add_syscall_newtp(struct trace *trace)
>  		 * leading to the syscall, allow overriding that for
>  		 * debugging reasons using --kernel_syscall_callchains
>  		 */
> -		sys_exit->attr.exclude_callchain_kernel = 1;
> +		sys_exit->core.attr.exclude_callchain_kernel = 1;
>  	}
>  
>  	trace->syscalls.events.sys_enter = sys_enter;
> @@ -3413,18 +3413,18 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
>  
>  	trace->multiple_threads = thread_map__pid(evlist->threads, 0) == -1 ||
>  				  evlist->threads->nr > 1 ||
> -				  perf_evlist__first(evlist)->attr.inherit;
> +				  perf_evlist__first(evlist)->core.attr.inherit;
>  
>  	/*
> -	 * Now that we already used evsel->attr to ask the kernel to setup the
> -	 * events, lets reuse evsel->attr.sample_max_stack as the limit in
> +	 * Now that we already used evsel->core.attr to ask the kernel to setup the
> +	 * events, lets reuse evsel->core.attr.sample_max_stack as the limit in
>  	 * trace__resolve_callchain(), allowing per-event max-stack settings
>  	 * to override an explicitly set --max-stack global setting.
>  	 */
>  	evlist__for_each_entry(evlist, evsel) {
>  		if (evsel__has_callchain(evsel) &&
> -		    evsel->attr.sample_max_stack == 0)
> -			evsel->attr.sample_max_stack = trace->max_stack;
> +		    evsel->core.attr.sample_max_stack == 0)
> +			evsel->core.attr.sample_max_stack = trace->max_stack;
>  	}
>  again:
>  	before = trace->nr_events;
> @@ -3617,10 +3617,10 @@ static int trace__replay(struct trace *trace)
>  	}
>  
>  	evlist__for_each_entry(session->evlist, evsel) {
> -		if (evsel->attr.type == PERF_TYPE_SOFTWARE &&
> -		    (evsel->attr.config == PERF_COUNT_SW_PAGE_FAULTS_MAJ ||
> -		     evsel->attr.config == PERF_COUNT_SW_PAGE_FAULTS_MIN ||
> -		     evsel->attr.config == PERF_COUNT_SW_PAGE_FAULTS))
> +		if (evsel->core.attr.type == PERF_TYPE_SOFTWARE &&
> +		    (evsel->core.attr.config == PERF_COUNT_SW_PAGE_FAULTS_MAJ ||
> +		     evsel->core.attr.config == PERF_COUNT_SW_PAGE_FAULTS_MIN ||
> +		     evsel->core.attr.config == PERF_COUNT_SW_PAGE_FAULTS))
>  			evsel->handler = trace__pgfault;
>  	}
>  
> diff --git a/tools/perf/lib/evsel.c b/tools/perf/lib/evsel.c
> index 9a87e867a7ec..17cba35becc7 100644
> --- a/tools/perf/lib/evsel.c
> +++ b/tools/perf/lib/evsel.c
> @@ -3,7 +3,8 @@
>  #include <linux/list.h>
>  #include <internal/evsel.h>
>  
> -void perf_evsel__init(struct perf_evsel *evsel)
> +void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr)
>  {
>  	INIT_LIST_HEAD(&evsel->node);
> +	evsel->attr = *attr;
>  }
> diff --git a/tools/perf/lib/include/internal/evsel.h b/tools/perf/lib/include/internal/evsel.h
> index 690943d0408a..c2e0bd104c94 100644
> --- a/tools/perf/lib/include/internal/evsel.h
> +++ b/tools/perf/lib/include/internal/evsel.h
> @@ -2,8 +2,12 @@
>  #ifndef __LIBPERF_INTERNAL_EVSEL_H
>  #define __LIBPERF_INTERNAL_EVSEL_H
>  
> +#include <linux/types.h>
> +#include <linux/perf_event.h>
> +
>  struct perf_evsel {
>  	struct list_head	node;
> +	struct perf_event_attr	attr;
>  };
>  
>  #endif /* __LIBPERF_INTERNAL_EVSEL_H */
> diff --git a/tools/perf/lib/include/perf/evsel.h b/tools/perf/lib/include/perf/evsel.h
> index b4d074a3684b..1e6000b02819 100644
> --- a/tools/perf/lib/include/perf/evsel.h
> +++ b/tools/perf/lib/include/perf/evsel.h
> @@ -2,10 +2,12 @@
>  #ifndef __LIBPERF_EVSEL_H
>  #define __LIBPERF_EVSEL_H
>  
> +#include <linux/perf_event.h>
>  #include <perf/core.h>
>  
>  struct perf_evsel;
>  
> -LIBPERF_API void perf_evsel__init(struct perf_evsel *evsel);
> +LIBPERF_API void perf_evsel__init(struct perf_evsel *evsel,
> +				  struct perf_event_attr *attr);
>  
>  #endif /* __LIBPERF_EVSEL_H */
> diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
> index 7b26be1dfb47..131bbeec62d2 100644
> --- a/tools/perf/tests/code-reading.c
> +++ b/tools/perf/tests/code-reading.c
> @@ -642,9 +642,9 @@ static int do_test_code_reading(bool try_kcore)
>  
>  		evsel = perf_evlist__first(evlist);
>  
> -		evsel->attr.comm = 1;
> -		evsel->attr.disabled = 1;
> -		evsel->attr.enable_on_exec = 0;
> +		evsel->core.attr.comm = 1;
> +		evsel->core.attr.disabled = 1;
> +		evsel->core.attr.enable_on_exec = 0;
>  
>  		ret = evlist__open(evlist);
>  		if (ret < 0) {
> diff --git a/tools/perf/tests/event-times.c b/tools/perf/tests/event-times.c
> index 9238180416b0..165534f62036 100644
> --- a/tools/perf/tests/event-times.c
> +++ b/tools/perf/tests/event-times.c
> @@ -36,7 +36,7 @@ static int attach__enable_on_exec(struct evlist *evlist)
>  		return err;
>  	}
>  
> -	evsel->attr.enable_on_exec = 1;
> +	evsel->core.attr.enable_on_exec = 1;
>  
>  	err = evlist__open(evlist);
>  	if (err < 0) {
> @@ -68,7 +68,7 @@ static int attach__current_disabled(struct evlist *evlist)
>  		return -1;
>  	}
>  
> -	evsel->attr.disabled = 1;
> +	evsel->core.attr.disabled = 1;
>  
>  	err = perf_evsel__open_per_thread(evsel, threads);
>  	if (err) {
> @@ -121,7 +121,7 @@ static int attach__cpu_disabled(struct evlist *evlist)
>  		return -1;
>  	}
>  
> -	evsel->attr.disabled = 1;
> +	evsel->core.attr.disabled = 1;
>  
>  	err = perf_evsel__open_per_cpu(evsel, cpus);
>  	if (err) {
> @@ -179,7 +179,7 @@ static int test_times(int (attach)(struct evlist *),
>  	}
>  
>  	evsel = perf_evlist__last(evlist);
> -	evsel->attr.read_format |=
> +	evsel->core.attr.read_format |=
>  		PERF_FORMAT_TOTAL_TIME_ENABLED |
>  		PERF_FORMAT_TOTAL_TIME_RUNNING;
>  
> diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/keep-tracking.c
> index 830fb3d7ea2e..4fc7b3b4e153 100644
> --- a/tools/perf/tests/keep-tracking.c
> +++ b/tools/perf/tests/keep-tracking.c
> @@ -90,9 +90,9 @@ int test__keep_tracking(struct test *test __maybe_unused, int subtest __maybe_un
>  
>  	evsel = perf_evlist__first(evlist);
>  
> -	evsel->attr.comm = 1;
> -	evsel->attr.disabled = 1;
> -	evsel->attr.enable_on_exec = 0;
> +	evsel->core.attr.comm = 1;
> +	evsel->core.attr.disabled = 1;
> +	evsel->core.attr.enable_on_exec = 0;
>  
>  	if (evlist__open(evlist) < 0) {
>  		pr_debug("Unable to open dummy and cycles event\n");
> diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
> index 72fbf55f4fc3..9d8eb43b12cb 100644
> --- a/tools/perf/tests/mmap-basic.c
> +++ b/tools/perf/tests/mmap-basic.c
> @@ -79,7 +79,7 @@ int test__basic_mmap(struct test *test __maybe_unused, int subtest __maybe_unuse
>  			goto out_delete_evlist;
>  		}
>  
> -		evsels[i]->attr.wakeup_events = 1;
> +		evsels[i]->core.attr.wakeup_events = 1;
>  		perf_evsel__set_sample_id(evsels[i], false);
>  
>  		evlist__add(evlist, evsels[i]);
> diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
> index 878140501edf..5b4a5a3dac50 100644
> --- a/tools/perf/tests/parse-events.c
> +++ b/tools/perf/tests/parse-events.c
> @@ -50,10 +50,10 @@ static int test__checkevent_tracepoint(struct evlist *evlist)
>  
>  	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
>  	TEST_ASSERT_VAL("wrong number of groups", 0 == evlist->nr_groups);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_TRACEPOINT == evsel->attr.type);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_TRACEPOINT == evsel->core.attr.type);
>  	TEST_ASSERT_VAL("wrong sample_type",
> -		PERF_TP_SAMPLE_TYPE == evsel->attr.sample_type);
> -	TEST_ASSERT_VAL("wrong sample_period", 1 == evsel->attr.sample_period);
> +		PERF_TP_SAMPLE_TYPE == evsel->core.attr.sample_type);
> +	TEST_ASSERT_VAL("wrong sample_period", 1 == evsel->core.attr.sample_period);
>  	return 0;
>  }
>  
> @@ -66,11 +66,11 @@ static int test__checkevent_tracepoint_multi(struct evlist *evlist)
>  
>  	evlist__for_each_entry(evlist, evsel) {
>  		TEST_ASSERT_VAL("wrong type",
> -			PERF_TYPE_TRACEPOINT == evsel->attr.type);
> +			PERF_TYPE_TRACEPOINT == evsel->core.attr.type);
>  		TEST_ASSERT_VAL("wrong sample_type",
> -			PERF_TP_SAMPLE_TYPE == evsel->attr.sample_type);
> +			PERF_TP_SAMPLE_TYPE == evsel->core.attr.sample_type);
>  		TEST_ASSERT_VAL("wrong sample_period",
> -			1 == evsel->attr.sample_period);
> +			1 == evsel->core.attr.sample_period);
>  	}
>  	return 0;
>  }
> @@ -80,8 +80,8 @@ static int test__checkevent_raw(struct evlist *evlist)
>  	struct evsel *evsel = perf_evlist__first(evlist);
>  
>  	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->attr.type);
> -	TEST_ASSERT_VAL("wrong config", 0x1a == evsel->attr.config);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
> +	TEST_ASSERT_VAL("wrong config", 0x1a == evsel->core.attr.config);
>  	return 0;
>  }
>  
> @@ -90,8 +90,8 @@ static int test__checkevent_numeric(struct evlist *evlist)
>  	struct evsel *evsel = perf_evlist__first(evlist);
>  
>  	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
> -	TEST_ASSERT_VAL("wrong type", 1 == evsel->attr.type);
> -	TEST_ASSERT_VAL("wrong config", 1 == evsel->attr.config);
> +	TEST_ASSERT_VAL("wrong type", 1 == evsel->core.attr.type);
> +	TEST_ASSERT_VAL("wrong config", 1 == evsel->core.attr.config);
>  	return 0;
>  }
>  
> @@ -100,9 +100,9 @@ static int test__checkevent_symbolic_name(struct evlist *evlist)
>  	struct evsel *evsel = perf_evlist__first(evlist);
>  
>  	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->attr.type);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
>  	TEST_ASSERT_VAL("wrong config",
> -			PERF_COUNT_HW_INSTRUCTIONS == evsel->attr.config);
> +			PERF_COUNT_HW_INSTRUCTIONS == evsel->core.attr.config);
>  	return 0;
>  }
>  
> @@ -111,19 +111,19 @@ static int test__checkevent_symbolic_name_config(struct evlist *evlist)
>  	struct evsel *evsel = perf_evlist__first(evlist);
>  
>  	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->attr.type);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
>  	TEST_ASSERT_VAL("wrong config",
> -			PERF_COUNT_HW_CPU_CYCLES == evsel->attr.config);
> +			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
>  	/*
>  	 * The period value gets configured within perf_evlist__config,
>  	 * while this test executes only parse events method.
>  	 */
>  	TEST_ASSERT_VAL("wrong period",
> -			0 == evsel->attr.sample_period);
> +			0 == evsel->core.attr.sample_period);
>  	TEST_ASSERT_VAL("wrong config1",
> -			0 == evsel->attr.config1);
> +			0 == evsel->core.attr.config1);
>  	TEST_ASSERT_VAL("wrong config2",
> -			1 == evsel->attr.config2);
> +			1 == evsel->core.attr.config2);
>  	return 0;
>  }
>  
> @@ -132,9 +132,9 @@ static int test__checkevent_symbolic_alias(struct evlist *evlist)
>  	struct evsel *evsel = perf_evlist__first(evlist);
>  
>  	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_SOFTWARE == evsel->attr.type);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_SOFTWARE == evsel->core.attr.type);
>  	TEST_ASSERT_VAL("wrong config",
> -			PERF_COUNT_SW_PAGE_FAULTS == evsel->attr.config);
> +			PERF_COUNT_SW_PAGE_FAULTS == evsel->core.attr.config);
>  	return 0;
>  }
>  
> @@ -143,8 +143,8 @@ static int test__checkevent_genhw(struct evlist *evlist)
>  	struct evsel *evsel = perf_evlist__first(evlist);
>  
>  	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HW_CACHE == evsel->attr.type);
> -	TEST_ASSERT_VAL("wrong config", (1 << 16) == evsel->attr.config);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HW_CACHE == evsel->core.attr.type);
> +	TEST_ASSERT_VAL("wrong config", (1 << 16) == evsel->core.attr.config);
>  	return 0;
>  }
>  
> @@ -153,12 +153,12 @@ static int test__checkevent_breakpoint(struct evlist *evlist)
>  	struct evsel *evsel = perf_evlist__first(evlist);
>  
>  	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_BREAKPOINT == evsel->attr.type);
> -	TEST_ASSERT_VAL("wrong config", 0 == evsel->attr.config);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_BREAKPOINT == evsel->core.attr.type);
> +	TEST_ASSERT_VAL("wrong config", 0 == evsel->core.attr.config);
>  	TEST_ASSERT_VAL("wrong bp_type", (HW_BREAKPOINT_R | HW_BREAKPOINT_W) ==
> -					 evsel->attr.bp_type);
> +					 evsel->core.attr.bp_type);
>  	TEST_ASSERT_VAL("wrong bp_len", HW_BREAKPOINT_LEN_4 ==
> -					evsel->attr.bp_len);
> +					evsel->core.attr.bp_len);
>  	return 0;
>  }
>  
> @@ -167,11 +167,11 @@ static int test__checkevent_breakpoint_x(struct evlist *evlist)
>  	struct evsel *evsel = perf_evlist__first(evlist);
>  
>  	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_BREAKPOINT == evsel->attr.type);
> -	TEST_ASSERT_VAL("wrong config", 0 == evsel->attr.config);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_BREAKPOINT == evsel->core.attr.type);
> +	TEST_ASSERT_VAL("wrong config", 0 == evsel->core.attr.config);
>  	TEST_ASSERT_VAL("wrong bp_type",
> -			HW_BREAKPOINT_X == evsel->attr.bp_type);
> -	TEST_ASSERT_VAL("wrong bp_len", sizeof(long) == evsel->attr.bp_len);
> +			HW_BREAKPOINT_X == evsel->core.attr.bp_type);
> +	TEST_ASSERT_VAL("wrong bp_len", sizeof(long) == evsel->core.attr.bp_len);
>  	return 0;
>  }
>  
> @@ -181,12 +181,12 @@ static int test__checkevent_breakpoint_r(struct evlist *evlist)
>  
>  	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
>  	TEST_ASSERT_VAL("wrong type",
> -			PERF_TYPE_BREAKPOINT == evsel->attr.type);
> -	TEST_ASSERT_VAL("wrong config", 0 == evsel->attr.config);
> +			PERF_TYPE_BREAKPOINT == evsel->core.attr.type);
> +	TEST_ASSERT_VAL("wrong config", 0 == evsel->core.attr.config);
>  	TEST_ASSERT_VAL("wrong bp_type",
> -			HW_BREAKPOINT_R == evsel->attr.bp_type);
> +			HW_BREAKPOINT_R == evsel->core.attr.bp_type);
>  	TEST_ASSERT_VAL("wrong bp_len",
> -			HW_BREAKPOINT_LEN_4 == evsel->attr.bp_len);
> +			HW_BREAKPOINT_LEN_4 == evsel->core.attr.bp_len);
>  	return 0;
>  }
>  
> @@ -196,12 +196,12 @@ static int test__checkevent_breakpoint_w(struct evlist *evlist)
>  
>  	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
>  	TEST_ASSERT_VAL("wrong type",
> -			PERF_TYPE_BREAKPOINT == evsel->attr.type);
> -	TEST_ASSERT_VAL("wrong config", 0 == evsel->attr.config);
> +			PERF_TYPE_BREAKPOINT == evsel->core.attr.type);
> +	TEST_ASSERT_VAL("wrong config", 0 == evsel->core.attr.config);
>  	TEST_ASSERT_VAL("wrong bp_type",
> -			HW_BREAKPOINT_W == evsel->attr.bp_type);
> +			HW_BREAKPOINT_W == evsel->core.attr.bp_type);
>  	TEST_ASSERT_VAL("wrong bp_len",
> -			HW_BREAKPOINT_LEN_4 == evsel->attr.bp_len);
> +			HW_BREAKPOINT_LEN_4 == evsel->core.attr.bp_len);
>  	return 0;
>  }
>  
> @@ -211,12 +211,12 @@ static int test__checkevent_breakpoint_rw(struct evlist *evlist)
>  
>  	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
>  	TEST_ASSERT_VAL("wrong type",
> -			PERF_TYPE_BREAKPOINT == evsel->attr.type);
> -	TEST_ASSERT_VAL("wrong config", 0 == evsel->attr.config);
> +			PERF_TYPE_BREAKPOINT == evsel->core.attr.type);
> +	TEST_ASSERT_VAL("wrong config", 0 == evsel->core.attr.config);
>  	TEST_ASSERT_VAL("wrong bp_type",
> -		(HW_BREAKPOINT_R|HW_BREAKPOINT_W) == evsel->attr.bp_type);
> +		(HW_BREAKPOINT_R|HW_BREAKPOINT_W) == evsel->core.attr.bp_type);
>  	TEST_ASSERT_VAL("wrong bp_len",
> -			HW_BREAKPOINT_LEN_4 == evsel->attr.bp_len);
> +			HW_BREAKPOINT_LEN_4 == evsel->core.attr.bp_len);
>  	return 0;
>  }
>  
> @@ -224,10 +224,10 @@ static int test__checkevent_tracepoint_modifier(struct evlist *evlist)
>  {
>  	struct evsel *evsel = perf_evlist__first(evlist);
>  
> -	TEST_ASSERT_VAL("wrong exclude_user", evsel->attr.exclude_user);
> -	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->attr.exclude_kernel);
> -	TEST_ASSERT_VAL("wrong exclude_hv", evsel->attr.exclude_hv);
> -	TEST_ASSERT_VAL("wrong precise_ip", !evsel->attr.precise_ip);
> +	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
> +	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
> +	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
> +	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>  
>  	return test__checkevent_tracepoint(evlist);
>  }
> @@ -241,11 +241,11 @@ test__checkevent_tracepoint_multi_modifier(struct evlist *evlist)
>  
>  	evlist__for_each_entry(evlist, evsel) {
>  		TEST_ASSERT_VAL("wrong exclude_user",
> -				!evsel->attr.exclude_user);
> +				!evsel->core.attr.exclude_user);
>  		TEST_ASSERT_VAL("wrong exclude_kernel",
> -				evsel->attr.exclude_kernel);
> -		TEST_ASSERT_VAL("wrong exclude_hv", evsel->attr.exclude_hv);
> -		TEST_ASSERT_VAL("wrong precise_ip", !evsel->attr.precise_ip);
> +				evsel->core.attr.exclude_kernel);
> +		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
> +		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>  	}
>  
>  	return test__checkevent_tracepoint_multi(evlist);
> @@ -255,10 +255,10 @@ static int test__checkevent_raw_modifier(struct evlist *evlist)
>  {
>  	struct evsel *evsel = perf_evlist__first(evlist);
>  
> -	TEST_ASSERT_VAL("wrong exclude_user", evsel->attr.exclude_user);
> -	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->attr.exclude_kernel);
> -	TEST_ASSERT_VAL("wrong exclude_hv", evsel->attr.exclude_hv);
> -	TEST_ASSERT_VAL("wrong precise_ip", evsel->attr.precise_ip);
> +	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
> +	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
> +	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
> +	TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip);
>  
>  	return test__checkevent_raw(evlist);
>  }
> @@ -267,10 +267,10 @@ static int test__checkevent_numeric_modifier(struct evlist *evlist)
>  {
>  	struct evsel *evsel = perf_evlist__first(evlist);
>  
> -	TEST_ASSERT_VAL("wrong exclude_user", evsel->attr.exclude_user);
> -	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->attr.exclude_kernel);
> -	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->attr.exclude_hv);
> -	TEST_ASSERT_VAL("wrong precise_ip", evsel->attr.precise_ip);
> +	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
> +	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
> +	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
> +	TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip);
>  
>  	return test__checkevent_numeric(evlist);
>  }
> @@ -279,10 +279,10 @@ static int test__checkevent_symbolic_name_modifier(struct evlist *evlist)
>  {
>  	struct evsel *evsel = perf_evlist__first(evlist);
>  
> -	TEST_ASSERT_VAL("wrong exclude_user", evsel->attr.exclude_user);
> -	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->attr.exclude_kernel);
> -	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->attr.exclude_hv);
> -	TEST_ASSERT_VAL("wrong precise_ip", !evsel->attr.precise_ip);
> +	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
> +	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
> +	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
> +	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>  
>  	return test__checkevent_symbolic_name(evlist);
>  }
> @@ -291,8 +291,8 @@ static int test__checkevent_exclude_host_modifier(struct evlist *evlist)
>  {
>  	struct evsel *evsel = perf_evlist__first(evlist);
>  
> -	TEST_ASSERT_VAL("wrong exclude guest", !evsel->attr.exclude_guest);
> -	TEST_ASSERT_VAL("wrong exclude host", evsel->attr.exclude_host);
> +	TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
> +	TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
>  
>  	return test__checkevent_symbolic_name(evlist);
>  }
> @@ -301,8 +301,8 @@ static int test__checkevent_exclude_guest_modifier(struct evlist *evlist)
>  {
>  	struct evsel *evsel = perf_evlist__first(evlist);
>  
> -	TEST_ASSERT_VAL("wrong exclude guest", evsel->attr.exclude_guest);
> -	TEST_ASSERT_VAL("wrong exclude host", !evsel->attr.exclude_host);
> +	TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
> +	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
>  
>  	return test__checkevent_symbolic_name(evlist);
>  }
> @@ -311,10 +311,10 @@ static int test__checkevent_symbolic_alias_modifier(struct evlist *evlist)
>  {
>  	struct evsel *evsel = perf_evlist__first(evlist);
>  
> -	TEST_ASSERT_VAL("wrong exclude_user", !evsel->attr.exclude_user);
> -	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->attr.exclude_kernel);
> -	TEST_ASSERT_VAL("wrong exclude_hv", evsel->attr.exclude_hv);
> -	TEST_ASSERT_VAL("wrong precise_ip", !evsel->attr.precise_ip);
> +	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
> +	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
> +	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
> +	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>  
>  	return test__checkevent_symbolic_alias(evlist);
>  }
> @@ -323,10 +323,10 @@ static int test__checkevent_genhw_modifier(struct evlist *evlist)
>  {
>  	struct evsel *evsel = perf_evlist__first(evlist);
>  
> -	TEST_ASSERT_VAL("wrong exclude_user", evsel->attr.exclude_user);
> -	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->attr.exclude_kernel);
> -	TEST_ASSERT_VAL("wrong exclude_hv", evsel->attr.exclude_hv);
> -	TEST_ASSERT_VAL("wrong precise_ip", evsel->attr.precise_ip);
> +	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
> +	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
> +	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
> +	TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip);
>  
>  	return test__checkevent_genhw(evlist);
>  }
> @@ -335,13 +335,13 @@ static int test__checkevent_exclude_idle_modifier(struct evlist *evlist)
>  {
>  	struct evsel *evsel = perf_evlist__first(evlist);
>  
> -	TEST_ASSERT_VAL("wrong exclude idle", evsel->attr.exclude_idle);
> -	TEST_ASSERT_VAL("wrong exclude guest", !evsel->attr.exclude_guest);
> -	TEST_ASSERT_VAL("wrong exclude host", !evsel->attr.exclude_host);
> -	TEST_ASSERT_VAL("wrong exclude_user", !evsel->attr.exclude_user);
> -	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->attr.exclude_kernel);
> -	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->attr.exclude_hv);
> -	TEST_ASSERT_VAL("wrong precise_ip", !evsel->attr.precise_ip);
> +	TEST_ASSERT_VAL("wrong exclude idle", evsel->core.attr.exclude_idle);
> +	TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
> +	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
> +	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
> +	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
> +	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
> +	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>  
>  	return test__checkevent_symbolic_name(evlist);
>  }
> @@ -350,13 +350,13 @@ static int test__checkevent_exclude_idle_modifier_1(struct evlist *evlist)
>  {
>  	struct evsel *evsel = perf_evlist__first(evlist);
>  
> -	TEST_ASSERT_VAL("wrong exclude idle", evsel->attr.exclude_idle);
> -	TEST_ASSERT_VAL("wrong exclude guest", !evsel->attr.exclude_guest);
> -	TEST_ASSERT_VAL("wrong exclude host", evsel->attr.exclude_host);
> -	TEST_ASSERT_VAL("wrong exclude_user", evsel->attr.exclude_user);
> -	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->attr.exclude_kernel);
> -	TEST_ASSERT_VAL("wrong exclude_hv", evsel->attr.exclude_hv);
> -	TEST_ASSERT_VAL("wrong precise_ip", !evsel->attr.precise_ip);
> +	TEST_ASSERT_VAL("wrong exclude idle", evsel->core.attr.exclude_idle);
> +	TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
> +	TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
> +	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
> +	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
> +	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
> +	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>  
>  	return test__checkevent_symbolic_name(evlist);
>  }
> @@ -366,10 +366,10 @@ static int test__checkevent_breakpoint_modifier(struct evlist *evlist)
>  	struct evsel *evsel = perf_evlist__first(evlist);
>  
>  
> -	TEST_ASSERT_VAL("wrong exclude_user", !evsel->attr.exclude_user);
> -	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->attr.exclude_kernel);
> -	TEST_ASSERT_VAL("wrong exclude_hv", evsel->attr.exclude_hv);
> -	TEST_ASSERT_VAL("wrong precise_ip", !evsel->attr.precise_ip);
> +	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
> +	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
> +	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
> +	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>  	TEST_ASSERT_VAL("wrong name",
>  			!strcmp(perf_evsel__name(evsel), "mem:0:u"));
>  
> @@ -380,10 +380,10 @@ static int test__checkevent_breakpoint_x_modifier(struct evlist *evlist)
>  {
>  	struct evsel *evsel = perf_evlist__first(evlist);
>  
> -	TEST_ASSERT_VAL("wrong exclude_user", evsel->attr.exclude_user);
> -	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->attr.exclude_kernel);
> -	TEST_ASSERT_VAL("wrong exclude_hv", evsel->attr.exclude_hv);
> -	TEST_ASSERT_VAL("wrong precise_ip", !evsel->attr.precise_ip);
> +	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
> +	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
> +	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
> +	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>  	TEST_ASSERT_VAL("wrong name",
>  			!strcmp(perf_evsel__name(evsel), "mem:0:x:k"));
>  
> @@ -394,10 +394,10 @@ static int test__checkevent_breakpoint_r_modifier(struct evlist *evlist)
>  {
>  	struct evsel *evsel = perf_evlist__first(evlist);
>  
> -	TEST_ASSERT_VAL("wrong exclude_user", evsel->attr.exclude_user);
> -	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->attr.exclude_kernel);
> -	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->attr.exclude_hv);
> -	TEST_ASSERT_VAL("wrong precise_ip", evsel->attr.precise_ip);
> +	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
> +	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
> +	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
> +	TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip);
>  	TEST_ASSERT_VAL("wrong name",
>  			!strcmp(perf_evsel__name(evsel), "mem:0:r:hp"));
>  
> @@ -408,10 +408,10 @@ static int test__checkevent_breakpoint_w_modifier(struct evlist *evlist)
>  {
>  	struct evsel *evsel = perf_evlist__first(evlist);
>  
> -	TEST_ASSERT_VAL("wrong exclude_user", !evsel->attr.exclude_user);
> -	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->attr.exclude_kernel);
> -	TEST_ASSERT_VAL("wrong exclude_hv", evsel->attr.exclude_hv);
> -	TEST_ASSERT_VAL("wrong precise_ip", evsel->attr.precise_ip);
> +	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
> +	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
> +	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
> +	TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip);
>  	TEST_ASSERT_VAL("wrong name",
>  			!strcmp(perf_evsel__name(evsel), "mem:0:w:up"));
>  
> @@ -422,10 +422,10 @@ static int test__checkevent_breakpoint_rw_modifier(struct evlist *evlist)
>  {
>  	struct evsel *evsel = perf_evlist__first(evlist);
>  
> -	TEST_ASSERT_VAL("wrong exclude_user", evsel->attr.exclude_user);
> -	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->attr.exclude_kernel);
> -	TEST_ASSERT_VAL("wrong exclude_hv", evsel->attr.exclude_hv);
> -	TEST_ASSERT_VAL("wrong precise_ip", evsel->attr.precise_ip);
> +	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
> +	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
> +	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
> +	TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip);
>  	TEST_ASSERT_VAL("wrong name",
>  			!strcmp(perf_evsel__name(evsel), "mem:0:rw:kp"));
>  
> @@ -438,15 +438,15 @@ static int test__checkevent_pmu(struct evlist *evlist)
>  	struct evsel *evsel = perf_evlist__first(evlist);
>  
>  	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->attr.type);
> -	TEST_ASSERT_VAL("wrong config",    10 == evsel->attr.config);
> -	TEST_ASSERT_VAL("wrong config1",    1 == evsel->attr.config1);
> -	TEST_ASSERT_VAL("wrong config2",    3 == evsel->attr.config2);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
> +	TEST_ASSERT_VAL("wrong config",    10 == evsel->core.attr.config);
> +	TEST_ASSERT_VAL("wrong config1",    1 == evsel->core.attr.config1);
> +	TEST_ASSERT_VAL("wrong config2",    3 == evsel->core.attr.config2);
>  	/*
>  	 * The period value gets configured within perf_evlist__config,
>  	 * while this test executes only parse events method.
>  	 */
> -	TEST_ASSERT_VAL("wrong period",     0 == evsel->attr.sample_period);
> +	TEST_ASSERT_VAL("wrong period",     0 == evsel->core.attr.sample_period);
>  
>  	return 0;
>  }
> @@ -458,34 +458,34 @@ static int test__checkevent_list(struct evlist *evlist)
>  	TEST_ASSERT_VAL("wrong number of entries", 3 == evlist->core.nr_entries);
>  
>  	/* r1 */
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->attr.type);
> -	TEST_ASSERT_VAL("wrong config", 1 == evsel->attr.config);
> -	TEST_ASSERT_VAL("wrong config1", 0 == evsel->attr.config1);
> -	TEST_ASSERT_VAL("wrong config2", 0 == evsel->attr.config2);
> -	TEST_ASSERT_VAL("wrong exclude_user", !evsel->attr.exclude_user);
> -	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->attr.exclude_kernel);
> -	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->attr.exclude_hv);
> -	TEST_ASSERT_VAL("wrong precise_ip", !evsel->attr.precise_ip);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
> +	TEST_ASSERT_VAL("wrong config", 1 == evsel->core.attr.config);
> +	TEST_ASSERT_VAL("wrong config1", 0 == evsel->core.attr.config1);
> +	TEST_ASSERT_VAL("wrong config2", 0 == evsel->core.attr.config2);
> +	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
> +	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
> +	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
> +	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>  
>  	/* syscalls:sys_enter_openat:k */
>  	evsel = perf_evsel__next(evsel);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_TRACEPOINT == evsel->attr.type);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_TRACEPOINT == evsel->core.attr.type);
>  	TEST_ASSERT_VAL("wrong sample_type",
> -		PERF_TP_SAMPLE_TYPE == evsel->attr.sample_type);
> -	TEST_ASSERT_VAL("wrong sample_period", 1 == evsel->attr.sample_period);
> -	TEST_ASSERT_VAL("wrong exclude_user", evsel->attr.exclude_user);
> -	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->attr.exclude_kernel);
> -	TEST_ASSERT_VAL("wrong exclude_hv", evsel->attr.exclude_hv);
> -	TEST_ASSERT_VAL("wrong precise_ip", !evsel->attr.precise_ip);
> +		PERF_TP_SAMPLE_TYPE == evsel->core.attr.sample_type);
> +	TEST_ASSERT_VAL("wrong sample_period", 1 == evsel->core.attr.sample_period);
> +	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
> +	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
> +	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
> +	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>  
>  	/* 1:1:hp */
>  	evsel = perf_evsel__next(evsel);
> -	TEST_ASSERT_VAL("wrong type", 1 == evsel->attr.type);
> -	TEST_ASSERT_VAL("wrong config", 1 == evsel->attr.config);
> -	TEST_ASSERT_VAL("wrong exclude_user", evsel->attr.exclude_user);
> -	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->attr.exclude_kernel);
> -	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->attr.exclude_hv);
> -	TEST_ASSERT_VAL("wrong precise_ip", evsel->attr.precise_ip);
> +	TEST_ASSERT_VAL("wrong type", 1 == evsel->core.attr.type);
> +	TEST_ASSERT_VAL("wrong config", 1 == evsel->core.attr.config);
> +	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
> +	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
> +	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
> +	TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip);
>  
>  	return 0;
>  }
> @@ -496,15 +496,15 @@ static int test__checkevent_pmu_name(struct evlist *evlist)
>  
>  	/* cpu/config=1,name=krava/u */
>  	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->attr.type);
> -	TEST_ASSERT_VAL("wrong config",  1 == evsel->attr.config);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
> +	TEST_ASSERT_VAL("wrong config",  1 == evsel->core.attr.config);
>  	TEST_ASSERT_VAL("wrong name", !strcmp(perf_evsel__name(evsel), "krava"));
>  
>  	/* cpu/config=2/u" */
>  	evsel = perf_evsel__next(evsel);
>  	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->attr.type);
> -	TEST_ASSERT_VAL("wrong config",  2 == evsel->attr.config);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
> +	TEST_ASSERT_VAL("wrong config",  2 == evsel->core.attr.config);
>  	TEST_ASSERT_VAL("wrong name",
>  			!strcmp(perf_evsel__name(evsel), "cpu/config=2/u"));
>  
> @@ -517,29 +517,29 @@ static int test__checkevent_pmu_partial_time_callgraph(struct evlist *evlist)
>  
>  	/* cpu/config=1,call-graph=fp,time,period=100000/ */
>  	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->attr.type);
> -	TEST_ASSERT_VAL("wrong config",  1 == evsel->attr.config);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
> +	TEST_ASSERT_VAL("wrong config",  1 == evsel->core.attr.config);
>  	/*
>  	 * The period, time and callgraph value gets configured
>  	 * within perf_evlist__config,
>  	 * while this test executes only parse events method.
>  	 */
> -	TEST_ASSERT_VAL("wrong period",     0 == evsel->attr.sample_period);
> +	TEST_ASSERT_VAL("wrong period",     0 == evsel->core.attr.sample_period);
>  	TEST_ASSERT_VAL("wrong callgraph",  !evsel__has_callchain(evsel));
> -	TEST_ASSERT_VAL("wrong time",  !(PERF_SAMPLE_TIME & evsel->attr.sample_type));
> +	TEST_ASSERT_VAL("wrong time",  !(PERF_SAMPLE_TIME & evsel->core.attr.sample_type));
>  
>  	/* cpu/config=2,call-graph=no,time=0,period=2000/ */
>  	evsel = perf_evsel__next(evsel);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->attr.type);
> -	TEST_ASSERT_VAL("wrong config",  2 == evsel->attr.config);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
> +	TEST_ASSERT_VAL("wrong config",  2 == evsel->core.attr.config);
>  	/*
>  	 * The period, time and callgraph value gets configured
>  	 * within perf_evlist__config,
>  	 * while this test executes only parse events method.
>  	 */
> -	TEST_ASSERT_VAL("wrong period",     0 == evsel->attr.sample_period);
> +	TEST_ASSERT_VAL("wrong period",     0 == evsel->core.attr.sample_period);
>  	TEST_ASSERT_VAL("wrong callgraph",  !evsel__has_callchain(evsel));
> -	TEST_ASSERT_VAL("wrong time",  !(PERF_SAMPLE_TIME & evsel->attr.sample_type));
> +	TEST_ASSERT_VAL("wrong time",  !(PERF_SAMPLE_TIME & evsel->core.attr.sample_type));
>  
>  	return 0;
>  }
> @@ -549,14 +549,14 @@ static int test__checkevent_pmu_events(struct evlist *evlist)
>  	struct evsel *evsel = perf_evlist__first(evlist);
>  
>  	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->attr.type);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
>  	TEST_ASSERT_VAL("wrong exclude_user",
> -			!evsel->attr.exclude_user);
> +			!evsel->core.attr.exclude_user);
>  	TEST_ASSERT_VAL("wrong exclude_kernel",
> -			evsel->attr.exclude_kernel);
> -	TEST_ASSERT_VAL("wrong exclude_hv", evsel->attr.exclude_hv);
> -	TEST_ASSERT_VAL("wrong precise_ip", !evsel->attr.precise_ip);
> -	TEST_ASSERT_VAL("wrong pinned", !evsel->attr.pinned);
> +			evsel->core.attr.exclude_kernel);
> +	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
> +	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
> +	TEST_ASSERT_VAL("wrong pinned", !evsel->core.attr.pinned);
>  
>  	return 0;
>  }
> @@ -569,24 +569,24 @@ static int test__checkevent_pmu_events_mix(struct evlist *evlist)
>  	/* pmu-event:u */
>  	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
>  	TEST_ASSERT_VAL("wrong exclude_user",
> -			!evsel->attr.exclude_user);
> +			!evsel->core.attr.exclude_user);
>  	TEST_ASSERT_VAL("wrong exclude_kernel",
> -			evsel->attr.exclude_kernel);
> -	TEST_ASSERT_VAL("wrong exclude_hv", evsel->attr.exclude_hv);
> -	TEST_ASSERT_VAL("wrong precise_ip", !evsel->attr.precise_ip);
> -	TEST_ASSERT_VAL("wrong pinned", !evsel->attr.pinned);
> +			evsel->core.attr.exclude_kernel);
> +	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
> +	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
> +	TEST_ASSERT_VAL("wrong pinned", !evsel->core.attr.pinned);
>  
>  	/* cpu/pmu-event/u*/
>  	evsel = perf_evsel__next(evsel);
>  	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->attr.type);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
>  	TEST_ASSERT_VAL("wrong exclude_user",
> -			!evsel->attr.exclude_user);
> +			!evsel->core.attr.exclude_user);
>  	TEST_ASSERT_VAL("wrong exclude_kernel",
> -			evsel->attr.exclude_kernel);
> -	TEST_ASSERT_VAL("wrong exclude_hv", evsel->attr.exclude_hv);
> -	TEST_ASSERT_VAL("wrong precise_ip", !evsel->attr.precise_ip);
> -	TEST_ASSERT_VAL("wrong pinned", !evsel->attr.pinned);
> +			evsel->core.attr.exclude_kernel);
> +	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
> +	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
> +	TEST_ASSERT_VAL("wrong pinned", !evsel->core.attr.pinned);
>  
>  	return 0;
>  }
> @@ -643,15 +643,15 @@ static int test__group1(struct evlist *evlist)
>  
>  	/* instructions:k */
>  	evsel = leader = perf_evlist__first(evlist);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->attr.type);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
>  	TEST_ASSERT_VAL("wrong config",
> -			PERF_COUNT_HW_INSTRUCTIONS == evsel->attr.config);
> -	TEST_ASSERT_VAL("wrong exclude_user", evsel->attr.exclude_user);
> -	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->attr.exclude_kernel);
> -	TEST_ASSERT_VAL("wrong exclude_hv", evsel->attr.exclude_hv);
> -	TEST_ASSERT_VAL("wrong exclude guest", !evsel->attr.exclude_guest);
> -	TEST_ASSERT_VAL("wrong exclude host", !evsel->attr.exclude_host);
> -	TEST_ASSERT_VAL("wrong precise_ip", !evsel->attr.precise_ip);
> +			PERF_COUNT_HW_INSTRUCTIONS == evsel->core.attr.config);
> +	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
> +	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
> +	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
> +	TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
> +	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
> +	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>  	TEST_ASSERT_VAL("wrong leader", perf_evsel__is_group_leader(evsel));
>  	TEST_ASSERT_VAL("wrong nr_members", evsel->nr_members == 2);
>  	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 0);
> @@ -659,16 +659,16 @@ static int test__group1(struct evlist *evlist)
>  
>  	/* cycles:upp */
>  	evsel = perf_evsel__next(evsel);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->attr.type);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
>  	TEST_ASSERT_VAL("wrong config",
> -			PERF_COUNT_HW_CPU_CYCLES == evsel->attr.config);
> -	TEST_ASSERT_VAL("wrong exclude_user", !evsel->attr.exclude_user);
> -	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->attr.exclude_kernel);
> -	TEST_ASSERT_VAL("wrong exclude_hv", evsel->attr.exclude_hv);
> +			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
> +	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
> +	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
> +	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
>  	/* use of precise requires exclude_guest */
> -	TEST_ASSERT_VAL("wrong exclude guest", evsel->attr.exclude_guest);
> -	TEST_ASSERT_VAL("wrong exclude host", !evsel->attr.exclude_host);
> -	TEST_ASSERT_VAL("wrong precise_ip", evsel->attr.precise_ip == 2);
> +	TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
> +	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
> +	TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip == 2);
>  	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
>  	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 1);
>  	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
> @@ -685,15 +685,15 @@ static int test__group2(struct evlist *evlist)
>  
>  	/* faults + :ku modifier */
>  	evsel = leader = perf_evlist__first(evlist);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_SOFTWARE == evsel->attr.type);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_SOFTWARE == evsel->core.attr.type);
>  	TEST_ASSERT_VAL("wrong config",
> -			PERF_COUNT_SW_PAGE_FAULTS == evsel->attr.config);
> -	TEST_ASSERT_VAL("wrong exclude_user", !evsel->attr.exclude_user);
> -	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->attr.exclude_kernel);
> -	TEST_ASSERT_VAL("wrong exclude_hv", evsel->attr.exclude_hv);
> -	TEST_ASSERT_VAL("wrong exclude guest", !evsel->attr.exclude_guest);
> -	TEST_ASSERT_VAL("wrong exclude host", !evsel->attr.exclude_host);
> -	TEST_ASSERT_VAL("wrong precise_ip", !evsel->attr.precise_ip);
> +			PERF_COUNT_SW_PAGE_FAULTS == evsel->core.attr.config);
> +	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
> +	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
> +	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
> +	TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
> +	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
> +	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>  	TEST_ASSERT_VAL("wrong leader", perf_evsel__is_group_leader(evsel));
>  	TEST_ASSERT_VAL("wrong nr_members", evsel->nr_members == 2);
>  	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 0);
> @@ -701,30 +701,30 @@ static int test__group2(struct evlist *evlist)
>  
>  	/* cache-references + :u modifier */
>  	evsel = perf_evsel__next(evsel);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->attr.type);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
>  	TEST_ASSERT_VAL("wrong config",
> -			PERF_COUNT_HW_CACHE_REFERENCES == evsel->attr.config);
> -	TEST_ASSERT_VAL("wrong exclude_user", !evsel->attr.exclude_user);
> -	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->attr.exclude_kernel);
> -	TEST_ASSERT_VAL("wrong exclude_hv", evsel->attr.exclude_hv);
> -	TEST_ASSERT_VAL("wrong exclude guest", evsel->attr.exclude_guest);
> -	TEST_ASSERT_VAL("wrong exclude host", !evsel->attr.exclude_host);
> -	TEST_ASSERT_VAL("wrong precise_ip", !evsel->attr.precise_ip);
> +			PERF_COUNT_HW_CACHE_REFERENCES == evsel->core.attr.config);
> +	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
> +	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
> +	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
> +	TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
> +	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
> +	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>  	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
>  	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 1);
>  	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
>  
>  	/* cycles:k */
>  	evsel = perf_evsel__next(evsel);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->attr.type);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
>  	TEST_ASSERT_VAL("wrong config",
> -			PERF_COUNT_HW_CPU_CYCLES == evsel->attr.config);
> -	TEST_ASSERT_VAL("wrong exclude_user", evsel->attr.exclude_user);
> -	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->attr.exclude_kernel);
> -	TEST_ASSERT_VAL("wrong exclude_hv", evsel->attr.exclude_hv);
> -	TEST_ASSERT_VAL("wrong exclude guest", !evsel->attr.exclude_guest);
> -	TEST_ASSERT_VAL("wrong exclude host", !evsel->attr.exclude_host);
> -	TEST_ASSERT_VAL("wrong precise_ip", !evsel->attr.precise_ip);
> +			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
> +	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
> +	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
> +	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
> +	TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
> +	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
> +	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>  	TEST_ASSERT_VAL("wrong leader", perf_evsel__is_group_leader(evsel));
>  	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
>  
> @@ -740,16 +740,16 @@ static int test__group3(struct evlist *evlist __maybe_unused)
>  
>  	/* group1 syscalls:sys_enter_openat:H */
>  	evsel = leader = perf_evlist__first(evlist);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_TRACEPOINT == evsel->attr.type);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_TRACEPOINT == evsel->core.attr.type);
>  	TEST_ASSERT_VAL("wrong sample_type",
> -		PERF_TP_SAMPLE_TYPE == evsel->attr.sample_type);
> -	TEST_ASSERT_VAL("wrong sample_period", 1 == evsel->attr.sample_period);
> -	TEST_ASSERT_VAL("wrong exclude_user", !evsel->attr.exclude_user);
> -	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->attr.exclude_kernel);
> -	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->attr.exclude_hv);
> -	TEST_ASSERT_VAL("wrong exclude guest", evsel->attr.exclude_guest);
> -	TEST_ASSERT_VAL("wrong exclude host", !evsel->attr.exclude_host);
> -	TEST_ASSERT_VAL("wrong precise_ip", !evsel->attr.precise_ip);
> +		PERF_TP_SAMPLE_TYPE == evsel->core.attr.sample_type);
> +	TEST_ASSERT_VAL("wrong sample_period", 1 == evsel->core.attr.sample_period);
> +	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
> +	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
> +	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
> +	TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
> +	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
> +	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>  	TEST_ASSERT_VAL("wrong leader", perf_evsel__is_group_leader(evsel));
>  	TEST_ASSERT_VAL("wrong group name",
>  		!strcmp(leader->group_name, "group1"));
> @@ -759,16 +759,16 @@ static int test__group3(struct evlist *evlist __maybe_unused)
>  
>  	/* group1 cycles:kppp */
>  	evsel = perf_evsel__next(evsel);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->attr.type);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
>  	TEST_ASSERT_VAL("wrong config",
> -			PERF_COUNT_HW_CPU_CYCLES == evsel->attr.config);
> -	TEST_ASSERT_VAL("wrong exclude_user", evsel->attr.exclude_user);
> -	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->attr.exclude_kernel);
> -	TEST_ASSERT_VAL("wrong exclude_hv", evsel->attr.exclude_hv);
> +			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
> +	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
> +	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
> +	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
>  	/* use of precise requires exclude_guest */
> -	TEST_ASSERT_VAL("wrong exclude guest", evsel->attr.exclude_guest);
> -	TEST_ASSERT_VAL("wrong exclude host", !evsel->attr.exclude_host);
> -	TEST_ASSERT_VAL("wrong precise_ip", evsel->attr.precise_ip == 3);
> +	TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
> +	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
> +	TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip == 3);
>  	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
>  	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
>  	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 1);
> @@ -776,15 +776,15 @@ static int test__group3(struct evlist *evlist __maybe_unused)
>  
>  	/* group2 cycles + G modifier */
>  	evsel = leader = perf_evsel__next(evsel);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->attr.type);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
>  	TEST_ASSERT_VAL("wrong config",
> -			PERF_COUNT_HW_CPU_CYCLES == evsel->attr.config);
> -	TEST_ASSERT_VAL("wrong exclude_user", !evsel->attr.exclude_user);
> -	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->attr.exclude_kernel);
> -	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->attr.exclude_hv);
> -	TEST_ASSERT_VAL("wrong exclude guest", !evsel->attr.exclude_guest);
> -	TEST_ASSERT_VAL("wrong exclude host", evsel->attr.exclude_host);
> -	TEST_ASSERT_VAL("wrong precise_ip", !evsel->attr.precise_ip);
> +			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
> +	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
> +	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
> +	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
> +	TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
> +	TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
> +	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>  	TEST_ASSERT_VAL("wrong leader", perf_evsel__is_group_leader(evsel));
>  	TEST_ASSERT_VAL("wrong group name",
>  		!strcmp(leader->group_name, "group2"));
> @@ -794,29 +794,29 @@ static int test__group3(struct evlist *evlist __maybe_unused)
>  
>  	/* group2 1:3 + G modifier */
>  	evsel = perf_evsel__next(evsel);
> -	TEST_ASSERT_VAL("wrong type", 1 == evsel->attr.type);
> -	TEST_ASSERT_VAL("wrong config", 3 == evsel->attr.config);
> -	TEST_ASSERT_VAL("wrong exclude_user", !evsel->attr.exclude_user);
> -	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->attr.exclude_kernel);
> -	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->attr.exclude_hv);
> -	TEST_ASSERT_VAL("wrong exclude guest", !evsel->attr.exclude_guest);
> -	TEST_ASSERT_VAL("wrong exclude host", evsel->attr.exclude_host);
> -	TEST_ASSERT_VAL("wrong precise_ip", !evsel->attr.precise_ip);
> +	TEST_ASSERT_VAL("wrong type", 1 == evsel->core.attr.type);
> +	TEST_ASSERT_VAL("wrong config", 3 == evsel->core.attr.config);
> +	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
> +	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
> +	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
> +	TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
> +	TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
> +	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>  	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
>  	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 1);
>  	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
>  
>  	/* instructions:u */
>  	evsel = perf_evsel__next(evsel);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->attr.type);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
>  	TEST_ASSERT_VAL("wrong config",
> -			PERF_COUNT_HW_INSTRUCTIONS == evsel->attr.config);
> -	TEST_ASSERT_VAL("wrong exclude_user", !evsel->attr.exclude_user);
> -	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->attr.exclude_kernel);
> -	TEST_ASSERT_VAL("wrong exclude_hv", evsel->attr.exclude_hv);
> -	TEST_ASSERT_VAL("wrong exclude guest", !evsel->attr.exclude_guest);
> -	TEST_ASSERT_VAL("wrong exclude host", !evsel->attr.exclude_host);
> -	TEST_ASSERT_VAL("wrong precise_ip", !evsel->attr.precise_ip);
> +			PERF_COUNT_HW_INSTRUCTIONS == evsel->core.attr.config);
> +	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
> +	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
> +	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
> +	TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
> +	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
> +	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>  	TEST_ASSERT_VAL("wrong leader", perf_evsel__is_group_leader(evsel));
>  	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
>  
> @@ -832,16 +832,16 @@ static int test__group4(struct evlist *evlist __maybe_unused)
>  
>  	/* cycles:u + p */
>  	evsel = leader = perf_evlist__first(evlist);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->attr.type);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
>  	TEST_ASSERT_VAL("wrong config",
> -			PERF_COUNT_HW_CPU_CYCLES == evsel->attr.config);
> -	TEST_ASSERT_VAL("wrong exclude_user", !evsel->attr.exclude_user);
> -	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->attr.exclude_kernel);
> -	TEST_ASSERT_VAL("wrong exclude_hv", evsel->attr.exclude_hv);
> +			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
> +	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
> +	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
> +	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
>  	/* use of precise requires exclude_guest */
> -	TEST_ASSERT_VAL("wrong exclude guest", evsel->attr.exclude_guest);
> -	TEST_ASSERT_VAL("wrong exclude host", !evsel->attr.exclude_host);
> -	TEST_ASSERT_VAL("wrong precise_ip", evsel->attr.precise_ip == 1);
> +	TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
> +	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
> +	TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip == 1);
>  	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
>  	TEST_ASSERT_VAL("wrong leader", perf_evsel__is_group_leader(evsel));
>  	TEST_ASSERT_VAL("wrong nr_members", evsel->nr_members == 2);
> @@ -850,16 +850,16 @@ static int test__group4(struct evlist *evlist __maybe_unused)
>  
>  	/* instructions:kp + p */
>  	evsel = perf_evsel__next(evsel);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->attr.type);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
>  	TEST_ASSERT_VAL("wrong config",
> -			PERF_COUNT_HW_INSTRUCTIONS == evsel->attr.config);
> -	TEST_ASSERT_VAL("wrong exclude_user", evsel->attr.exclude_user);
> -	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->attr.exclude_kernel);
> -	TEST_ASSERT_VAL("wrong exclude_hv", evsel->attr.exclude_hv);
> +			PERF_COUNT_HW_INSTRUCTIONS == evsel->core.attr.config);
> +	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
> +	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
> +	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
>  	/* use of precise requires exclude_guest */
> -	TEST_ASSERT_VAL("wrong exclude guest", evsel->attr.exclude_guest);
> -	TEST_ASSERT_VAL("wrong exclude host", !evsel->attr.exclude_host);
> -	TEST_ASSERT_VAL("wrong precise_ip", evsel->attr.precise_ip == 2);
> +	TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
> +	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
> +	TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip == 2);
>  	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
>  	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 1);
>  	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
> @@ -876,15 +876,15 @@ static int test__group5(struct evlist *evlist __maybe_unused)
>  
>  	/* cycles + G */
>  	evsel = leader = perf_evlist__first(evlist);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->attr.type);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
>  	TEST_ASSERT_VAL("wrong config",
> -			PERF_COUNT_HW_CPU_CYCLES == evsel->attr.config);
> -	TEST_ASSERT_VAL("wrong exclude_user", !evsel->attr.exclude_user);
> -	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->attr.exclude_kernel);
> -	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->attr.exclude_hv);
> -	TEST_ASSERT_VAL("wrong exclude guest", !evsel->attr.exclude_guest);
> -	TEST_ASSERT_VAL("wrong exclude host", evsel->attr.exclude_host);
> -	TEST_ASSERT_VAL("wrong precise_ip", !evsel->attr.precise_ip);
> +			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
> +	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
> +	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
> +	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
> +	TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
> +	TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
> +	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>  	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
>  	TEST_ASSERT_VAL("wrong leader", perf_evsel__is_group_leader(evsel));
>  	TEST_ASSERT_VAL("wrong nr_members", evsel->nr_members == 2);
> @@ -893,30 +893,30 @@ static int test__group5(struct evlist *evlist __maybe_unused)
>  
>  	/* instructions + G */
>  	evsel = perf_evsel__next(evsel);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->attr.type);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
>  	TEST_ASSERT_VAL("wrong config",
> -			PERF_COUNT_HW_INSTRUCTIONS == evsel->attr.config);
> -	TEST_ASSERT_VAL("wrong exclude_user", !evsel->attr.exclude_user);
> -	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->attr.exclude_kernel);
> -	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->attr.exclude_hv);
> -	TEST_ASSERT_VAL("wrong exclude guest", !evsel->attr.exclude_guest);
> -	TEST_ASSERT_VAL("wrong exclude host", evsel->attr.exclude_host);
> -	TEST_ASSERT_VAL("wrong precise_ip", !evsel->attr.precise_ip);
> +			PERF_COUNT_HW_INSTRUCTIONS == evsel->core.attr.config);
> +	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
> +	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
> +	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
> +	TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
> +	TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
> +	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>  	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
>  	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 1);
>  	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
>  
>  	/* cycles:G */
>  	evsel = leader = perf_evsel__next(evsel);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->attr.type);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
>  	TEST_ASSERT_VAL("wrong config",
> -			PERF_COUNT_HW_CPU_CYCLES == evsel->attr.config);
> -	TEST_ASSERT_VAL("wrong exclude_user", !evsel->attr.exclude_user);
> -	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->attr.exclude_kernel);
> -	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->attr.exclude_hv);
> -	TEST_ASSERT_VAL("wrong exclude guest", !evsel->attr.exclude_guest);
> -	TEST_ASSERT_VAL("wrong exclude host", evsel->attr.exclude_host);
> -	TEST_ASSERT_VAL("wrong precise_ip", !evsel->attr.precise_ip);
> +			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
> +	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
> +	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
> +	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
> +	TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
> +	TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
> +	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>  	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
>  	TEST_ASSERT_VAL("wrong leader", perf_evsel__is_group_leader(evsel));
>  	TEST_ASSERT_VAL("wrong nr_members", evsel->nr_members == 2);
> @@ -925,29 +925,29 @@ static int test__group5(struct evlist *evlist __maybe_unused)
>  
>  	/* instructions:G */
>  	evsel = perf_evsel__next(evsel);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->attr.type);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
>  	TEST_ASSERT_VAL("wrong config",
> -			PERF_COUNT_HW_INSTRUCTIONS == evsel->attr.config);
> -	TEST_ASSERT_VAL("wrong exclude_user", !evsel->attr.exclude_user);
> -	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->attr.exclude_kernel);
> -	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->attr.exclude_hv);
> -	TEST_ASSERT_VAL("wrong exclude guest", !evsel->attr.exclude_guest);
> -	TEST_ASSERT_VAL("wrong exclude host", evsel->attr.exclude_host);
> -	TEST_ASSERT_VAL("wrong precise_ip", !evsel->attr.precise_ip);
> +			PERF_COUNT_HW_INSTRUCTIONS == evsel->core.attr.config);
> +	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
> +	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
> +	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
> +	TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
> +	TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
> +	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>  	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
>  	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 1);
>  
>  	/* cycles */
>  	evsel = perf_evsel__next(evsel);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->attr.type);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
>  	TEST_ASSERT_VAL("wrong config",
> -			PERF_COUNT_HW_CPU_CYCLES == evsel->attr.config);
> -	TEST_ASSERT_VAL("wrong exclude_user", !evsel->attr.exclude_user);
> -	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->attr.exclude_kernel);
> -	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->attr.exclude_hv);
> -	TEST_ASSERT_VAL("wrong exclude guest", evsel->attr.exclude_guest);
> -	TEST_ASSERT_VAL("wrong exclude host", !evsel->attr.exclude_host);
> -	TEST_ASSERT_VAL("wrong precise_ip", !evsel->attr.precise_ip);
> +			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
> +	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
> +	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
> +	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
> +	TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
> +	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
> +	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>  	TEST_ASSERT_VAL("wrong leader", perf_evsel__is_group_leader(evsel));
>  
>  	return 0;
> @@ -962,15 +962,15 @@ static int test__group_gh1(struct evlist *evlist)
>  
>  	/* cycles + :H group modifier */
>  	evsel = leader = perf_evlist__first(evlist);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->attr.type);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
>  	TEST_ASSERT_VAL("wrong config",
> -			PERF_COUNT_HW_CPU_CYCLES == evsel->attr.config);
> -	TEST_ASSERT_VAL("wrong exclude_user", !evsel->attr.exclude_user);
> -	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->attr.exclude_kernel);
> -	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->attr.exclude_hv);
> -	TEST_ASSERT_VAL("wrong exclude guest", evsel->attr.exclude_guest);
> -	TEST_ASSERT_VAL("wrong exclude host", !evsel->attr.exclude_host);
> -	TEST_ASSERT_VAL("wrong precise_ip", !evsel->attr.precise_ip);
> +			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
> +	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
> +	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
> +	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
> +	TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
> +	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
> +	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>  	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
>  	TEST_ASSERT_VAL("wrong leader", perf_evsel__is_group_leader(evsel));
>  	TEST_ASSERT_VAL("wrong nr_members", evsel->nr_members == 2);
> @@ -978,15 +978,15 @@ static int test__group_gh1(struct evlist *evlist)
>  
>  	/* cache-misses:G + :H group modifier */
>  	evsel = perf_evsel__next(evsel);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->attr.type);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
>  	TEST_ASSERT_VAL("wrong config",
> -			PERF_COUNT_HW_CACHE_MISSES == evsel->attr.config);
> -	TEST_ASSERT_VAL("wrong exclude_user", !evsel->attr.exclude_user);
> -	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->attr.exclude_kernel);
> -	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->attr.exclude_hv);
> -	TEST_ASSERT_VAL("wrong exclude guest", !evsel->attr.exclude_guest);
> -	TEST_ASSERT_VAL("wrong exclude host", !evsel->attr.exclude_host);
> -	TEST_ASSERT_VAL("wrong precise_ip", !evsel->attr.precise_ip);
> +			PERF_COUNT_HW_CACHE_MISSES == evsel->core.attr.config);
> +	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
> +	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
> +	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
> +	TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
> +	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
> +	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>  	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
>  	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 1);
>  
> @@ -1002,15 +1002,15 @@ static int test__group_gh2(struct evlist *evlist)
>  
>  	/* cycles + :G group modifier */
>  	evsel = leader = perf_evlist__first(evlist);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->attr.type);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
>  	TEST_ASSERT_VAL("wrong config",
> -			PERF_COUNT_HW_CPU_CYCLES == evsel->attr.config);
> -	TEST_ASSERT_VAL("wrong exclude_user", !evsel->attr.exclude_user);
> -	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->attr.exclude_kernel);
> -	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->attr.exclude_hv);
> -	TEST_ASSERT_VAL("wrong exclude guest", !evsel->attr.exclude_guest);
> -	TEST_ASSERT_VAL("wrong exclude host", evsel->attr.exclude_host);
> -	TEST_ASSERT_VAL("wrong precise_ip", !evsel->attr.precise_ip);
> +			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
> +	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
> +	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
> +	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
> +	TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
> +	TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
> +	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>  	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
>  	TEST_ASSERT_VAL("wrong leader", perf_evsel__is_group_leader(evsel));
>  	TEST_ASSERT_VAL("wrong nr_members", evsel->nr_members == 2);
> @@ -1018,15 +1018,15 @@ static int test__group_gh2(struct evlist *evlist)
>  
>  	/* cache-misses:H + :G group modifier */
>  	evsel = perf_evsel__next(evsel);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->attr.type);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
>  	TEST_ASSERT_VAL("wrong config",
> -			PERF_COUNT_HW_CACHE_MISSES == evsel->attr.config);
> -	TEST_ASSERT_VAL("wrong exclude_user", !evsel->attr.exclude_user);
> -	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->attr.exclude_kernel);
> -	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->attr.exclude_hv);
> -	TEST_ASSERT_VAL("wrong exclude guest", !evsel->attr.exclude_guest);
> -	TEST_ASSERT_VAL("wrong exclude host", !evsel->attr.exclude_host);
> -	TEST_ASSERT_VAL("wrong precise_ip", !evsel->attr.precise_ip);
> +			PERF_COUNT_HW_CACHE_MISSES == evsel->core.attr.config);
> +	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
> +	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
> +	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
> +	TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
> +	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
> +	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>  	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
>  	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 1);
>  
> @@ -1042,15 +1042,15 @@ static int test__group_gh3(struct evlist *evlist)
>  
>  	/* cycles:G + :u group modifier */
>  	evsel = leader = perf_evlist__first(evlist);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->attr.type);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
>  	TEST_ASSERT_VAL("wrong config",
> -			PERF_COUNT_HW_CPU_CYCLES == evsel->attr.config);
> -	TEST_ASSERT_VAL("wrong exclude_user", !evsel->attr.exclude_user);
> -	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->attr.exclude_kernel);
> -	TEST_ASSERT_VAL("wrong exclude_hv", evsel->attr.exclude_hv);
> -	TEST_ASSERT_VAL("wrong exclude guest", !evsel->attr.exclude_guest);
> -	TEST_ASSERT_VAL("wrong exclude host", evsel->attr.exclude_host);
> -	TEST_ASSERT_VAL("wrong precise_ip", !evsel->attr.precise_ip);
> +			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
> +	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
> +	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
> +	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
> +	TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
> +	TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
> +	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>  	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
>  	TEST_ASSERT_VAL("wrong leader", perf_evsel__is_group_leader(evsel));
>  	TEST_ASSERT_VAL("wrong nr_members", evsel->nr_members == 2);
> @@ -1058,15 +1058,15 @@ static int test__group_gh3(struct evlist *evlist)
>  
>  	/* cache-misses:H + :u group modifier */
>  	evsel = perf_evsel__next(evsel);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->attr.type);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
>  	TEST_ASSERT_VAL("wrong config",
> -			PERF_COUNT_HW_CACHE_MISSES == evsel->attr.config);
> -	TEST_ASSERT_VAL("wrong exclude_user", !evsel->attr.exclude_user);
> -	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->attr.exclude_kernel);
> -	TEST_ASSERT_VAL("wrong exclude_hv", evsel->attr.exclude_hv);
> -	TEST_ASSERT_VAL("wrong exclude guest", evsel->attr.exclude_guest);
> -	TEST_ASSERT_VAL("wrong exclude host", !evsel->attr.exclude_host);
> -	TEST_ASSERT_VAL("wrong precise_ip", !evsel->attr.precise_ip);
> +			PERF_COUNT_HW_CACHE_MISSES == evsel->core.attr.config);
> +	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
> +	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
> +	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
> +	TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
> +	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
> +	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>  	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
>  	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 1);
>  
> @@ -1082,15 +1082,15 @@ static int test__group_gh4(struct evlist *evlist)
>  
>  	/* cycles:G + :uG group modifier */
>  	evsel = leader = perf_evlist__first(evlist);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->attr.type);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
>  	TEST_ASSERT_VAL("wrong config",
> -			PERF_COUNT_HW_CPU_CYCLES == evsel->attr.config);
> -	TEST_ASSERT_VAL("wrong exclude_user", !evsel->attr.exclude_user);
> -	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->attr.exclude_kernel);
> -	TEST_ASSERT_VAL("wrong exclude_hv", evsel->attr.exclude_hv);
> -	TEST_ASSERT_VAL("wrong exclude guest", !evsel->attr.exclude_guest);
> -	TEST_ASSERT_VAL("wrong exclude host", evsel->attr.exclude_host);
> -	TEST_ASSERT_VAL("wrong precise_ip", !evsel->attr.precise_ip);
> +			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
> +	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
> +	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
> +	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
> +	TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
> +	TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
> +	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>  	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
>  	TEST_ASSERT_VAL("wrong leader", perf_evsel__is_group_leader(evsel));
>  	TEST_ASSERT_VAL("wrong nr_members", evsel->nr_members == 2);
> @@ -1098,15 +1098,15 @@ static int test__group_gh4(struct evlist *evlist)
>  
>  	/* cache-misses:H + :uG group modifier */
>  	evsel = perf_evsel__next(evsel);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->attr.type);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
>  	TEST_ASSERT_VAL("wrong config",
> -			PERF_COUNT_HW_CACHE_MISSES == evsel->attr.config);
> -	TEST_ASSERT_VAL("wrong exclude_user", !evsel->attr.exclude_user);
> -	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->attr.exclude_kernel);
> -	TEST_ASSERT_VAL("wrong exclude_hv", evsel->attr.exclude_hv);
> -	TEST_ASSERT_VAL("wrong exclude guest", !evsel->attr.exclude_guest);
> -	TEST_ASSERT_VAL("wrong exclude host", !evsel->attr.exclude_host);
> -	TEST_ASSERT_VAL("wrong precise_ip", !evsel->attr.precise_ip);
> +			PERF_COUNT_HW_CACHE_MISSES == evsel->core.attr.config);
> +	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
> +	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
> +	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
> +	TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
> +	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
> +	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>  	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
>  	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 1);
>  
> @@ -1121,44 +1121,44 @@ static int test__leader_sample1(struct evlist *evlist)
>  
>  	/* cycles - sampling group leader */
>  	evsel = leader = perf_evlist__first(evlist);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->attr.type);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
>  	TEST_ASSERT_VAL("wrong config",
> -			PERF_COUNT_HW_CPU_CYCLES == evsel->attr.config);
> -	TEST_ASSERT_VAL("wrong exclude_user", !evsel->attr.exclude_user);
> -	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->attr.exclude_kernel);
> -	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->attr.exclude_hv);
> -	TEST_ASSERT_VAL("wrong exclude guest", evsel->attr.exclude_guest);
> -	TEST_ASSERT_VAL("wrong exclude host", !evsel->attr.exclude_host);
> -	TEST_ASSERT_VAL("wrong precise_ip", !evsel->attr.precise_ip);
> +			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
> +	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
> +	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
> +	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
> +	TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
> +	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
> +	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>  	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
>  	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
>  	TEST_ASSERT_VAL("wrong sample_read", evsel->sample_read);
>  
>  	/* cache-misses - not sampling */
>  	evsel = perf_evsel__next(evsel);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->attr.type);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
>  	TEST_ASSERT_VAL("wrong config",
> -			PERF_COUNT_HW_CACHE_MISSES == evsel->attr.config);
> -	TEST_ASSERT_VAL("wrong exclude_user", !evsel->attr.exclude_user);
> -	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->attr.exclude_kernel);
> -	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->attr.exclude_hv);
> -	TEST_ASSERT_VAL("wrong exclude guest", evsel->attr.exclude_guest);
> -	TEST_ASSERT_VAL("wrong exclude host", !evsel->attr.exclude_host);
> -	TEST_ASSERT_VAL("wrong precise_ip", !evsel->attr.precise_ip);
> +			PERF_COUNT_HW_CACHE_MISSES == evsel->core.attr.config);
> +	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
> +	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
> +	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
> +	TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
> +	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
> +	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>  	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
>  	TEST_ASSERT_VAL("wrong sample_read", evsel->sample_read);
>  
>  	/* branch-misses - not sampling */
>  	evsel = perf_evsel__next(evsel);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->attr.type);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
>  	TEST_ASSERT_VAL("wrong config",
> -			PERF_COUNT_HW_BRANCH_MISSES == evsel->attr.config);
> -	TEST_ASSERT_VAL("wrong exclude_user", !evsel->attr.exclude_user);
> -	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->attr.exclude_kernel);
> -	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->attr.exclude_hv);
> -	TEST_ASSERT_VAL("wrong exclude guest", evsel->attr.exclude_guest);
> -	TEST_ASSERT_VAL("wrong exclude host", !evsel->attr.exclude_host);
> -	TEST_ASSERT_VAL("wrong precise_ip", !evsel->attr.precise_ip);
> +			PERF_COUNT_HW_BRANCH_MISSES == evsel->core.attr.config);
> +	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
> +	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
> +	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
> +	TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
> +	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
> +	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>  	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
>  	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
>  	TEST_ASSERT_VAL("wrong sample_read", evsel->sample_read);
> @@ -1174,30 +1174,30 @@ static int test__leader_sample2(struct evlist *evlist __maybe_unused)
>  
>  	/* instructions - sampling group leader */
>  	evsel = leader = perf_evlist__first(evlist);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->attr.type);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
>  	TEST_ASSERT_VAL("wrong config",
> -			PERF_COUNT_HW_INSTRUCTIONS == evsel->attr.config);
> -	TEST_ASSERT_VAL("wrong exclude_user", !evsel->attr.exclude_user);
> -	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->attr.exclude_kernel);
> -	TEST_ASSERT_VAL("wrong exclude_hv", evsel->attr.exclude_hv);
> -	TEST_ASSERT_VAL("wrong exclude guest", evsel->attr.exclude_guest);
> -	TEST_ASSERT_VAL("wrong exclude host", !evsel->attr.exclude_host);
> -	TEST_ASSERT_VAL("wrong precise_ip", !evsel->attr.precise_ip);
> +			PERF_COUNT_HW_INSTRUCTIONS == evsel->core.attr.config);
> +	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
> +	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
> +	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
> +	TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
> +	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
> +	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>  	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
>  	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
>  	TEST_ASSERT_VAL("wrong sample_read", evsel->sample_read);
>  
>  	/* branch-misses - not sampling */
>  	evsel = perf_evsel__next(evsel);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->attr.type);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
>  	TEST_ASSERT_VAL("wrong config",
> -			PERF_COUNT_HW_BRANCH_MISSES == evsel->attr.config);
> -	TEST_ASSERT_VAL("wrong exclude_user", !evsel->attr.exclude_user);
> -	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->attr.exclude_kernel);
> -	TEST_ASSERT_VAL("wrong exclude_hv", evsel->attr.exclude_hv);
> -	TEST_ASSERT_VAL("wrong exclude guest", evsel->attr.exclude_guest);
> -	TEST_ASSERT_VAL("wrong exclude host", !evsel->attr.exclude_host);
> -	TEST_ASSERT_VAL("wrong precise_ip", !evsel->attr.precise_ip);
> +			PERF_COUNT_HW_BRANCH_MISSES == evsel->core.attr.config);
> +	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
> +	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
> +	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
> +	TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
> +	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
> +	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>  	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
>  	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
>  	TEST_ASSERT_VAL("wrong sample_read", evsel->sample_read);
> @@ -1209,11 +1209,11 @@ static int test__checkevent_pinned_modifier(struct evlist *evlist)
>  {
>  	struct evsel *evsel = perf_evlist__first(evlist);
>  
> -	TEST_ASSERT_VAL("wrong exclude_user", !evsel->attr.exclude_user);
> -	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->attr.exclude_kernel);
> -	TEST_ASSERT_VAL("wrong exclude_hv", evsel->attr.exclude_hv);
> -	TEST_ASSERT_VAL("wrong precise_ip", evsel->attr.precise_ip);
> -	TEST_ASSERT_VAL("wrong pinned", evsel->attr.pinned);
> +	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
> +	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
> +	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
> +	TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip);
> +	TEST_ASSERT_VAL("wrong pinned", evsel->core.attr.pinned);
>  
>  	return test__checkevent_symbolic_name(evlist);
>  }
> @@ -1226,25 +1226,25 @@ static int test__pinned_group(struct evlist *evlist)
>  
>  	/* cycles - group leader */
>  	evsel = leader = perf_evlist__first(evlist);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->attr.type);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
>  	TEST_ASSERT_VAL("wrong config",
> -			PERF_COUNT_HW_CPU_CYCLES == evsel->attr.config);
> +			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
>  	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
>  	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
> -	TEST_ASSERT_VAL("wrong pinned", evsel->attr.pinned);
> +	TEST_ASSERT_VAL("wrong pinned", evsel->core.attr.pinned);
>  
>  	/* cache-misses - can not be pinned, but will go on with the leader */
>  	evsel = perf_evsel__next(evsel);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->attr.type);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
>  	TEST_ASSERT_VAL("wrong config",
> -			PERF_COUNT_HW_CACHE_MISSES == evsel->attr.config);
> -	TEST_ASSERT_VAL("wrong pinned", !evsel->attr.pinned);
> +			PERF_COUNT_HW_CACHE_MISSES == evsel->core.attr.config);
> +	TEST_ASSERT_VAL("wrong pinned", !evsel->core.attr.pinned);
>  
>  	/* branch-misses - ditto */
>  	evsel = perf_evsel__next(evsel);
>  	TEST_ASSERT_VAL("wrong config",
> -			PERF_COUNT_HW_BRANCH_MISSES == evsel->attr.config);
> -	TEST_ASSERT_VAL("wrong pinned", !evsel->attr.pinned);
> +			PERF_COUNT_HW_BRANCH_MISSES == evsel->core.attr.config);
> +	TEST_ASSERT_VAL("wrong pinned", !evsel->core.attr.pinned);
>  
>  	return 0;
>  }
> @@ -1254,12 +1254,12 @@ static int test__checkevent_breakpoint_len(struct evlist *evlist)
>  	struct evsel *evsel = perf_evlist__first(evlist);
>  
>  	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_BREAKPOINT == evsel->attr.type);
> -	TEST_ASSERT_VAL("wrong config", 0 == evsel->attr.config);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_BREAKPOINT == evsel->core.attr.type);
> +	TEST_ASSERT_VAL("wrong config", 0 == evsel->core.attr.config);
>  	TEST_ASSERT_VAL("wrong bp_type", (HW_BREAKPOINT_R | HW_BREAKPOINT_W) ==
> -					 evsel->attr.bp_type);
> +					 evsel->core.attr.bp_type);
>  	TEST_ASSERT_VAL("wrong bp_len", HW_BREAKPOINT_LEN_1 ==
> -					evsel->attr.bp_len);
> +					evsel->core.attr.bp_len);
>  
>  	return 0;
>  }
> @@ -1269,12 +1269,12 @@ static int test__checkevent_breakpoint_len_w(struct evlist *evlist)
>  	struct evsel *evsel = perf_evlist__first(evlist);
>  
>  	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_BREAKPOINT == evsel->attr.type);
> -	TEST_ASSERT_VAL("wrong config", 0 == evsel->attr.config);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_BREAKPOINT == evsel->core.attr.type);
> +	TEST_ASSERT_VAL("wrong config", 0 == evsel->core.attr.config);
>  	TEST_ASSERT_VAL("wrong bp_type", HW_BREAKPOINT_W ==
> -					 evsel->attr.bp_type);
> +					 evsel->core.attr.bp_type);
>  	TEST_ASSERT_VAL("wrong bp_len", HW_BREAKPOINT_LEN_2 ==
> -					evsel->attr.bp_len);
> +					evsel->core.attr.bp_len);
>  
>  	return 0;
>  }
> @@ -1284,10 +1284,10 @@ test__checkevent_breakpoint_len_rw_modifier(struct evlist *evlist)
>  {
>  	struct evsel *evsel = perf_evlist__first(evlist);
>  
> -	TEST_ASSERT_VAL("wrong exclude_user", !evsel->attr.exclude_user);
> -	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->attr.exclude_kernel);
> -	TEST_ASSERT_VAL("wrong exclude_hv", evsel->attr.exclude_hv);
> -	TEST_ASSERT_VAL("wrong precise_ip", !evsel->attr.precise_ip);
> +	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
> +	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
> +	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
> +	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>  
>  	return test__checkevent_breakpoint_rw(evlist);
>  }
> @@ -1297,9 +1297,9 @@ static int test__checkevent_precise_max_modifier(struct evlist *evlist)
>  	struct evsel *evsel = perf_evlist__first(evlist);
>  
>  	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_SOFTWARE == evsel->attr.type);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_SOFTWARE == evsel->core.attr.type);
>  	TEST_ASSERT_VAL("wrong config",
> -			PERF_COUNT_SW_TASK_CLOCK == evsel->attr.config);
> +			PERF_COUNT_SW_TASK_CLOCK == evsel->core.attr.config);
>  	return 0;
>  }
>  
> @@ -1360,9 +1360,9 @@ static int test__sym_event_slash(struct evlist *evlist)
>  {
>  	struct evsel *evsel = perf_evlist__first(evlist);
>  
> -	TEST_ASSERT_VAL("wrong type", evsel->attr.type == PERF_TYPE_HARDWARE);
> -	TEST_ASSERT_VAL("wrong config", evsel->attr.config == PERF_COUNT_HW_CPU_CYCLES);
> -	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->attr.exclude_kernel);
> +	TEST_ASSERT_VAL("wrong type", evsel->core.attr.type == PERF_TYPE_HARDWARE);
> +	TEST_ASSERT_VAL("wrong config", evsel->core.attr.config == PERF_COUNT_HW_CPU_CYCLES);
> +	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
>  	return 0;
>  }
>  
> @@ -1370,9 +1370,9 @@ static int test__sym_event_dc(struct evlist *evlist)
>  {
>  	struct evsel *evsel = perf_evlist__first(evlist);
>  
> -	TEST_ASSERT_VAL("wrong type", evsel->attr.type == PERF_TYPE_HARDWARE);
> -	TEST_ASSERT_VAL("wrong config", evsel->attr.config == PERF_COUNT_HW_CPU_CYCLES);
> -	TEST_ASSERT_VAL("wrong exclude_user", evsel->attr.exclude_user);
> +	TEST_ASSERT_VAL("wrong type", evsel->core.attr.type == PERF_TYPE_HARDWARE);
> +	TEST_ASSERT_VAL("wrong config", evsel->core.attr.config == PERF_COUNT_HW_CPU_CYCLES);
> +	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
>  	return 0;
>  }
>  
> diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
> index a8cd3ed3c116..3b422e76fc90 100644
> --- a/tools/perf/tests/sample-parsing.c
> +++ b/tools/perf/tests/sample-parsing.c
> @@ -155,7 +155,7 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
>  {
>  	struct evsel evsel = {
>  		.needs_swap = false,
> -		.attr = {
> +		.core.attr = {
>  			.sample_type = sample_type,
>  			.read_format = read_format,
>  		},
> @@ -221,10 +221,10 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
>  	int err, ret = -1;
>  
>  	if (sample_type & PERF_SAMPLE_REGS_USER)
> -		evsel.attr.sample_regs_user = sample_regs;
> +		evsel.core.attr.sample_regs_user = sample_regs;
>  
>  	if (sample_type & PERF_SAMPLE_REGS_INTR)
> -		evsel.attr.sample_regs_intr = sample_regs;
> +		evsel.core.attr.sample_regs_intr = sample_regs;
>  
>  	for (i = 0; i < sizeof(regs); i++)
>  		*(i + (u8 *)regs) = i & 0xfe;
> diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
> index 0935a5a1ecaa..dd07acced4af 100644
> --- a/tools/perf/tests/switch-tracking.c
> +++ b/tools/perf/tests/switch-tracking.c
> @@ -420,8 +420,8 @@ int test__switch_tracking(struct test *test __maybe_unused, int subtest __maybe_
>  
>  	perf_evlist__set_tracking_event(evlist, tracking_evsel);
>  
> -	tracking_evsel->attr.freq = 0;
> -	tracking_evsel->attr.sample_period = 1;
> +	tracking_evsel->core.attr.freq = 0;
> +	tracking_evsel->core.attr.sample_period = 1;
>  
>  	perf_evsel__set_sample_bit(tracking_evsel, TIME);
>  
> @@ -435,7 +435,7 @@ int test__switch_tracking(struct test *test __maybe_unused, int subtest __maybe_
>  	}
>  
>  	/* Check tracking event is tracking */
> -	if (!tracking_evsel->attr.mmap || !tracking_evsel->attr.comm) {
> +	if (!tracking_evsel->core.attr.mmap || !tracking_evsel->core.attr.comm) {
>  		pr_debug("Tracking event not tracking\n");
>  		goto out_err;
>  	}
> @@ -443,7 +443,7 @@ int test__switch_tracking(struct test *test __maybe_unused, int subtest __maybe_
>  	/* Check non-tracking events are not tracking */
>  	evlist__for_each_entry(evlist, evsel) {
>  		if (evsel != tracking_evsel) {
> -			if (evsel->attr.mmap || evsel->attr.comm) {
> +			if (evsel->core.attr.mmap || evsel->core.attr.comm) {
>  				pr_debug("Non-tracking event is tracking\n");
>  				goto out_err;
>  			}
> diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-exit.c
> index 24257285844b..b0192ea636a7 100644
> --- a/tools/perf/tests/task-exit.c
> +++ b/tools/perf/tests/task-exit.c
> @@ -84,16 +84,16 @@ int test__task_exit(struct test *test __maybe_unused, int subtest __maybe_unused
>  	}
>  
>  	evsel = perf_evlist__first(evlist);
> -	evsel->attr.task = 1;
> +	evsel->core.attr.task = 1;
>  #ifdef __s390x__
> -	evsel->attr.sample_freq = 1000000;
> +	evsel->core.attr.sample_freq = 1000000;
>  #else
> -	evsel->attr.sample_freq = 1;
> +	evsel->core.attr.sample_freq = 1;
>  #endif
> -	evsel->attr.inherit = 0;
> -	evsel->attr.watermark = 0;
> -	evsel->attr.wakeup_events = 1;
> -	evsel->attr.exclude_kernel = 1;
> +	evsel->core.attr.inherit = 0;
> +	evsel->core.attr.watermark = 0;
> +	evsel->core.attr.wakeup_events = 1;
> +	evsel->core.attr.exclude_kernel = 1;
>  
>  	err = evlist__open(evlist);
>  	if (err < 0) {
> diff --git a/tools/perf/ui/browsers/res_sample.c b/tools/perf/ui/browsers/res_sample.c
> index 7f3576deafd7..08897bd5eb0f 100644
> --- a/tools/perf/ui/browsers/res_sample.c
> +++ b/tools/perf/ui/browsers/res_sample.c
> @@ -66,7 +66,7 @@ int res_sample_browse(struct res_sample *res_samples, int num_res,
>  
>  	timestamp__scnprintf_nsec(r->time, tsample, sizeof tsample);
>  
> -	attr_to_script(extra_format, &evsel->attr);
> +	attr_to_script(extra_format, &evsel->core.attr);
>  
>  	if (asprintf(&cmd, "%s script %s%s --time %s %s%s %s%s --ns %s %s %s %s %s | less +/%s",
>  		     perf,
> diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/scripts.c
> index c0462457e9f9..04f9aff5621e 100644
> --- a/tools/perf/ui/browsers/scripts.c
> +++ b/tools/perf/ui/browsers/scripts.c
> @@ -100,7 +100,7 @@ static int list_scripts(char *script_name, bool *custom,
>  		return -1;
>  
>  	if (evsel)
> -		attr_to_script(scriptc.extra_format, &evsel->attr);
> +		attr_to_script(scriptc.extra_format, &evsel->core.attr);
>  	add_script_option("Show individual samples", "", &scriptc);
>  	add_script_option("Show individual samples with assembler", "-F +insn --xed",
>  			  &scriptc);
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index 9ec2841ddec4..843959f85d6f 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -2140,7 +2140,7 @@ static struct perf_pmu *perf_evsel__find_pmu(struct evsel *evsel)
>  	struct perf_pmu *pmu = NULL;
>  
>  	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
> -		if (pmu->type == evsel->attr.type)
> +		if (pmu->type == evsel->core.attr.type)
>  			break;
>  	}
>  
> diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
> index b0696726ab76..4df8bdea14ac 100644
> --- a/tools/perf/util/bpf-loader.c
> +++ b/tools/perf/util/bpf-loader.c
> @@ -1421,7 +1421,7 @@ apply_config_evsel_for_key(const char *name, int map_fd, void *pkey,
>  		return -BPF_LOADER_ERRNO__OBJCONF_MAP_EVTDIM;
>  	}
>  
> -	attr = &evsel->attr;
> +	attr = &evsel->core.attr;
>  	if (attr->inherit) {
>  		pr_debug("ERROR: Can't put inherit event into map %s\n", name);
>  		return -BPF_LOADER_ERRNO__OBJCONF_MAP_EVTINH;
> diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
> index ca30bb25b3c5..0c268449959c 100644
> --- a/tools/perf/util/data-convert-bt.c
> +++ b/tools/perf/util/data-convert-bt.c
> @@ -587,7 +587,7 @@ static int add_generic_values(struct ctf_writer *cw,
>  			      struct evsel *evsel,
>  			      struct perf_sample *sample)
>  {
> -	u64 type = evsel->attr.sample_type;
> +	u64 type = evsel->core.attr.sample_type;
>  	int ret;
>  
>  	/*
> @@ -757,7 +757,7 @@ static int get_sample_cpu(struct ctf_writer *cw, struct perf_sample *sample,
>  {
>  	int cpu = 0;
>  
> -	if (evsel->attr.sample_type & PERF_SAMPLE_CPU)
> +	if (evsel->core.attr.sample_type & PERF_SAMPLE_CPU)
>  		cpu = sample->cpu;
>  
>  	if (cpu > cw->stream_cnt) {
> @@ -795,7 +795,7 @@ static int process_sample_event(struct perf_tool *tool,
>  	struct bt_ctf_event_class *event_class;
>  	struct bt_ctf_event *event;
>  	int ret;
> -	unsigned long type = evsel->attr.sample_type;
> +	unsigned long type = evsel->core.attr.sample_type;
>  
>  	if (WARN_ONCE(!priv, "Failed to setup all events.\n"))
>  		return 0;
> @@ -820,7 +820,7 @@ static int process_sample_event(struct perf_tool *tool,
>  	if (ret)
>  		return -1;
>  
> -	if (evsel->attr.type == PERF_TYPE_TRACEPOINT) {
> +	if (evsel->core.attr.type == PERF_TYPE_TRACEPOINT) {
>  		ret = add_tracepoint_values(cw, event_class, event,
>  					    evsel, sample);
>  		if (ret)
> @@ -1087,7 +1087,7 @@ static int add_bpf_output_types(struct ctf_writer *cw,
>  static int add_generic_types(struct ctf_writer *cw, struct evsel *evsel,
>  			     struct bt_ctf_event_class *event_class)
>  {
> -	u64 type = evsel->attr.sample_type;
> +	u64 type = evsel->core.attr.sample_type;
>  
>  	/*
>  	 * missing:
> @@ -1157,7 +1157,7 @@ static int add_event(struct ctf_writer *cw, struct evsel *evsel)
>  	const char *name = perf_evsel__name(evsel);
>  	int ret;
>  
> -	pr("Adding event '%s' (type %d)\n", name, evsel->attr.type);
> +	pr("Adding event '%s' (type %d)\n", name, evsel->core.attr.type);
>  
>  	event_class = bt_ctf_event_class_create(name);
>  	if (!event_class)
> @@ -1167,7 +1167,7 @@ static int add_event(struct ctf_writer *cw, struct evsel *evsel)
>  	if (ret)
>  		goto err;
>  
> -	if (evsel->attr.type == PERF_TYPE_TRACEPOINT) {
> +	if (evsel->core.attr.type == PERF_TYPE_TRACEPOINT) {
>  		ret = add_tracepoint_types(cw, evsel, event_class);
>  		if (ret)
>  			goto err;
> diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
> index dc2d4de772e3..701e9f814313 100644
> --- a/tools/perf/util/db-export.c
> +++ b/tools/perf/util/db-export.c
> @@ -388,8 +388,8 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
>  		}
>  	}
>  
> -	if ((evsel->attr.sample_type & PERF_SAMPLE_ADDR) &&
> -	    sample_addr_correlates_sym(&evsel->attr)) {
> +	if ((evsel->core.attr.sample_type & PERF_SAMPLE_ADDR) &&
> +	    sample_addr_correlates_sym(&evsel->core.attr)) {
>  		struct addr_location addr_al;
>  
>  		thread__resolve(thread, &addr_al, sample);
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index d5505e620204..882f5b396d63 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -299,8 +299,8 @@ perf_evlist__find_tracepoint_by_id(struct evlist *evlist, int id)
>  	struct evsel *evsel;
>  
>  	evlist__for_each_entry(evlist, evsel) {
> -		if (evsel->attr.type   == PERF_TYPE_TRACEPOINT &&
> -		    (int)evsel->attr.config == id)
> +		if (evsel->core.attr.type   == PERF_TYPE_TRACEPOINT &&
> +		    (int)evsel->core.attr.config == id)
>  			return evsel;
>  	}
>  
> @@ -314,7 +314,7 @@ perf_evlist__find_tracepoint_by_name(struct evlist *evlist,
>  	struct evsel *evsel;
>  
>  	evlist__for_each_entry(evlist, evsel) {
> -		if ((evsel->attr.type == PERF_TYPE_TRACEPOINT) &&
> +		if ((evsel->core.attr.type == PERF_TYPE_TRACEPOINT) &&
>  		    (strcmp(evsel->name, name) == 0))
>  			return evsel;
>  	}
> @@ -529,13 +529,13 @@ int perf_evlist__id_add_fd(struct evlist *evlist,
>  	if (perf_evlist__read_format(evlist) & PERF_FORMAT_GROUP)
>  		return -1;
>  
> -	if (!(evsel->attr.read_format & PERF_FORMAT_ID) ||
> +	if (!(evsel->core.attr.read_format & PERF_FORMAT_ID) ||
>  	    read(fd, &read_data, sizeof(read_data)) == -1)
>  		return -1;
>  
> -	if (evsel->attr.read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
> +	if (evsel->core.attr.read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
>  		++id_idx;
> -	if (evsel->attr.read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
> +	if (evsel->core.attr.read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
>  		++id_idx;
>  
>  	id = read_data[id_idx];
> @@ -642,7 +642,7 @@ struct evsel *perf_evlist__event2evsel(struct evlist *evlist,
>  	if (evlist->core.nr_entries == 1)
>  		return first;
>  
> -	if (!first->attr.sample_id_all &&
> +	if (!first->core.attr.sample_id_all &&
>  	    event->header.type != PERF_RECORD_SAMPLE)
>  		return first;
>  
> @@ -747,7 +747,7 @@ static bool
>  perf_evlist__should_poll(struct evlist *evlist __maybe_unused,
>  			 struct evsel *evsel)
>  {
> -	if (evsel->attr.write_backward)
> +	if (evsel->core.attr.write_backward)
>  		return false;
>  	return true;
>  }
> @@ -767,7 +767,7 @@ static int perf_evlist__mmap_per_evsel(struct evlist *evlist, int idx,
>  		int cpu;
>  
>  		mp->prot = PROT_READ | PROT_WRITE;
> -		if (evsel->attr.write_backward) {
> +		if (evsel->core.attr.write_backward) {
>  			output = _output_overwrite;
>  			maps = evlist->overwrite_mmap;
>  
> @@ -818,7 +818,7 @@ static int perf_evlist__mmap_per_evsel(struct evlist *evlist, int idx,
>  			return -1;
>  		}
>  
> -		if (evsel->attr.read_format & PERF_FORMAT_ID) {
> +		if (evsel->core.attr.read_format & PERF_FORMAT_ID) {
>  			if (perf_evlist__id_add_fd(evlist, evsel, cpu, thread,
>  						   fd) < 0)
>  				return -1;
> @@ -1039,7 +1039,7 @@ int perf_evlist__mmap_ex(struct evlist *evlist, unsigned int pages,
>  				   auxtrace_pages, auxtrace_overwrite);
>  
>  	evlist__for_each_entry(evlist, evsel) {
> -		if ((evsel->attr.read_format & PERF_FORMAT_ID) &&
> +		if ((evsel->core.attr.read_format & PERF_FORMAT_ID) &&
>  		    evsel->sample_id == NULL &&
>  		    perf_evsel__alloc_id(evsel, cpu_map__nr(cpus), threads->nr) < 0)
>  			return -ENOMEM;
> @@ -1175,7 +1175,7 @@ int perf_evlist__set_tp_filter(struct evlist *evlist, const char *filter)
>  	int err = 0;
>  
>  	evlist__for_each_entry(evlist, evsel) {
> -		if (evsel->attr.type != PERF_TYPE_TRACEPOINT)
> +		if (evsel->core.attr.type != PERF_TYPE_TRACEPOINT)
>  			continue;
>  
>  		err = perf_evsel__set_filter(evsel, filter);
> @@ -1245,7 +1245,7 @@ u64 __perf_evlist__combined_sample_type(struct evlist *evlist)
>  		return evlist->combined_sample_type;
>  
>  	evlist__for_each_entry(evlist, evsel)
> -		evlist->combined_sample_type |= evsel->attr.sample_type;
> +		evlist->combined_sample_type |= evsel->core.attr.sample_type;
>  
>  	return evlist->combined_sample_type;
>  }
> @@ -1262,18 +1262,18 @@ u64 perf_evlist__combined_branch_type(struct evlist *evlist)
>  	u64 branch_type = 0;
>  
>  	evlist__for_each_entry(evlist, evsel)
> -		branch_type |= evsel->attr.branch_sample_type;
> +		branch_type |= evsel->core.attr.branch_sample_type;
>  	return branch_type;
>  }
>  
>  bool perf_evlist__valid_read_format(struct evlist *evlist)
>  {
>  	struct evsel *first = perf_evlist__first(evlist), *pos = first;
> -	u64 read_format = first->attr.read_format;
> -	u64 sample_type = first->attr.sample_type;
> +	u64 read_format = first->core.attr.read_format;
> +	u64 sample_type = first->core.attr.sample_type;
>  
>  	evlist__for_each_entry(evlist, pos) {
> -		if (read_format != pos->attr.read_format)
> +		if (read_format != pos->core.attr.read_format)
>  			return false;
>  	}
>  
> @@ -1289,7 +1289,7 @@ bool perf_evlist__valid_read_format(struct evlist *evlist)
>  u64 perf_evlist__read_format(struct evlist *evlist)
>  {
>  	struct evsel *first = perf_evlist__first(evlist);
> -	return first->attr.read_format;
> +	return first->core.attr.read_format;
>  }
>  
>  u16 perf_evlist__id_hdr_size(struct evlist *evlist)
> @@ -1299,10 +1299,10 @@ u16 perf_evlist__id_hdr_size(struct evlist *evlist)
>  	u64 sample_type;
>  	u16 size = 0;
>  
> -	if (!first->attr.sample_id_all)
> +	if (!first->core.attr.sample_id_all)
>  		goto out;
>  
> -	sample_type = first->attr.sample_type;
> +	sample_type = first->core.attr.sample_type;
>  
>  	if (sample_type & PERF_SAMPLE_TID)
>  		size += sizeof(data->tid) * 2;
> @@ -1330,7 +1330,7 @@ bool perf_evlist__valid_sample_id_all(struct evlist *evlist)
>  	struct evsel *first = perf_evlist__first(evlist), *pos = first;
>  
>  	evlist__for_each_entry_continue(evlist, pos) {
> -		if (first->attr.sample_id_all != pos->attr.sample_id_all)
> +		if (first->core.attr.sample_id_all != pos->core.attr.sample_id_all)
>  			return false;
>  	}
>  
> @@ -1340,7 +1340,7 @@ bool perf_evlist__valid_sample_id_all(struct evlist *evlist)
>  bool perf_evlist__sample_id_all(struct evlist *evlist)
>  {
>  	struct evsel *first = perf_evlist__first(evlist);
> -	return first->attr.sample_id_all;
> +	return first->core.attr.sample_id_all;
>  }
>  
>  void perf_evlist__set_selected(struct evlist *evlist,
> @@ -1620,14 +1620,14 @@ int perf_evlist__strerror_open(struct evlist *evlist,
>  		if (sysctl__read_int("kernel/perf_event_max_sample_rate", &max_freq) < 0)
>  			goto out_default;
>  
> -		if (first->attr.sample_freq < (u64)max_freq)
> +		if (first->core.attr.sample_freq < (u64)max_freq)
>  			goto out_default;
>  
>  		printed = scnprintf(buf, size,
>  				    "Error:\t%s.\n"
>  				    "Hint:\tCheck /proc/sys/kernel/perf_event_max_sample_rate.\n"
>  				    "Hint:\tThe current value is %d and %" PRIu64 " is being requested.",
> -				    emsg, max_freq, first->attr.sample_freq);
> +				    emsg, max_freq, first->core.attr.sample_freq);
>  		break;
>  	}
>  	default:
> @@ -1782,7 +1782,7 @@ bool perf_evlist__exclude_kernel(struct evlist *evlist)
>  	struct evsel *evsel;
>  
>  	evlist__for_each_entry(evlist, evsel) {
> -		if (!evsel->attr.exclude_kernel)
> +		if (!evsel->core.attr.exclude_kernel)
>  			return false;
>  	}
>  
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 172bcc2e198f..089582e644d7 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -170,15 +170,15 @@ static int __perf_evsel__calc_is_pos(u64 sample_type)
>  
>  void perf_evsel__calc_id_pos(struct evsel *evsel)
>  {
> -	evsel->id_pos = __perf_evsel__calc_id_pos(evsel->attr.sample_type);
> -	evsel->is_pos = __perf_evsel__calc_is_pos(evsel->attr.sample_type);
> +	evsel->id_pos = __perf_evsel__calc_id_pos(evsel->core.attr.sample_type);
> +	evsel->is_pos = __perf_evsel__calc_is_pos(evsel->core.attr.sample_type);
>  }
>  
>  void __perf_evsel__set_sample_bit(struct evsel *evsel,
>  				  enum perf_event_sample_format bit)
>  {
> -	if (!(evsel->attr.sample_type & bit)) {
> -		evsel->attr.sample_type |= bit;
> +	if (!(evsel->core.attr.sample_type & bit)) {
> +		evsel->core.attr.sample_type |= bit;
>  		evsel->sample_size += sizeof(u64);
>  		perf_evsel__calc_id_pos(evsel);
>  	}
> @@ -187,8 +187,8 @@ void __perf_evsel__set_sample_bit(struct evsel *evsel,
>  void __perf_evsel__reset_sample_bit(struct evsel *evsel,
>  				    enum perf_event_sample_format bit)
>  {
> -	if (evsel->attr.sample_type & bit) {
> -		evsel->attr.sample_type &= ~bit;
> +	if (evsel->core.attr.sample_type & bit) {
> +		evsel->core.attr.sample_type &= ~bit;
>  		evsel->sample_size -= sizeof(u64);
>  		perf_evsel__calc_id_pos(evsel);
>  	}
> @@ -203,7 +203,7 @@ void perf_evsel__set_sample_id(struct evsel *evsel,
>  	} else {
>  		perf_evsel__set_sample_bit(evsel, ID);
>  	}
> -	evsel->attr.read_format |= PERF_FORMAT_ID;
> +	evsel->core.attr.read_format |= PERF_FORMAT_ID;
>  }
>  
>  /**
> @@ -227,10 +227,9 @@ bool perf_evsel__is_function_event(struct evsel *evsel)
>  void evsel__init(struct evsel *evsel,
>  		 struct perf_event_attr *attr, int idx)
>  {
> -	perf_evsel__init(&evsel->core);
> +	perf_evsel__init(&evsel->core, attr);
>  	evsel->idx	   = idx;
>  	evsel->tracking	   = !idx;
> -	evsel->attr	   = *attr;
>  	evsel->leader	   = evsel;
>  	evsel->unit	   = "";
>  	evsel->scale	   = 1.0;
> @@ -259,9 +258,9 @@ struct evsel *perf_evsel__new_idx(struct perf_event_attr *attr, int idx)
>  	evsel__init(evsel, attr, idx);
>  
>  	if (perf_evsel__is_bpf_output(evsel)) {
> -		evsel->attr.sample_type |= (PERF_SAMPLE_RAW | PERF_SAMPLE_TIME |
> +		evsel->core.attr.sample_type |= (PERF_SAMPLE_RAW | PERF_SAMPLE_TIME |
>  					    PERF_SAMPLE_CPU | PERF_SAMPLE_PERIOD),
> -		evsel->attr.sample_period = 1;
> +		evsel->core.attr.sample_period = 1;
>  	}
>  
>  	if (perf_evsel__is_clock(evsel)) {
> @@ -387,7 +386,7 @@ static const char *__perf_evsel__hw_name(u64 config)
>  static int perf_evsel__add_modifiers(struct evsel *evsel, char *bf, size_t size)
>  {
>  	int colon = 0, r = 0;
> -	struct perf_event_attr *attr = &evsel->attr;
> +	struct perf_event_attr *attr = &evsel->core.attr;
>  	bool exclude_guest_default = false;
>  
>  #define MOD_PRINT(context, mod)	do {					\
> @@ -422,7 +421,7 @@ static int perf_evsel__add_modifiers(struct evsel *evsel, char *bf, size_t size)
>  
>  static int perf_evsel__hw_name(struct evsel *evsel, char *bf, size_t size)
>  {
> -	int r = scnprintf(bf, size, "%s", __perf_evsel__hw_name(evsel->attr.config));
> +	int r = scnprintf(bf, size, "%s", __perf_evsel__hw_name(evsel->core.attr.config));
>  	return r + perf_evsel__add_modifiers(evsel, bf + r, size - r);
>  }
>  
> @@ -448,7 +447,7 @@ static const char *__perf_evsel__sw_name(u64 config)
>  
>  static int perf_evsel__sw_name(struct evsel *evsel, char *bf, size_t size)
>  {
> -	int r = scnprintf(bf, size, "%s", __perf_evsel__sw_name(evsel->attr.config));
> +	int r = scnprintf(bf, size, "%s", __perf_evsel__sw_name(evsel->core.attr.config));
>  	return r + perf_evsel__add_modifiers(evsel, bf + r, size - r);
>  }
>  
> @@ -472,7 +471,7 @@ static int __perf_evsel__bp_name(char *bf, size_t size, u64 addr, u64 type)
>  
>  static int perf_evsel__bp_name(struct evsel *evsel, char *bf, size_t size)
>  {
> -	struct perf_event_attr *attr = &evsel->attr;
> +	struct perf_event_attr *attr = &evsel->core.attr;
>  	int r = __perf_evsel__bp_name(bf, size, attr->bp_addr, attr->bp_type);
>  	return r + perf_evsel__add_modifiers(evsel, bf + r, size - r);
>  }
> @@ -572,13 +571,13 @@ static int __perf_evsel__hw_cache_name(u64 config, char *bf, size_t size)
>  
>  static int perf_evsel__hw_cache_name(struct evsel *evsel, char *bf, size_t size)
>  {
> -	int ret = __perf_evsel__hw_cache_name(evsel->attr.config, bf, size);
> +	int ret = __perf_evsel__hw_cache_name(evsel->core.attr.config, bf, size);
>  	return ret + perf_evsel__add_modifiers(evsel, bf + ret, size - ret);
>  }
>  
>  static int perf_evsel__raw_name(struct evsel *evsel, char *bf, size_t size)
>  {
> -	int ret = scnprintf(bf, size, "raw 0x%" PRIx64, evsel->attr.config);
> +	int ret = scnprintf(bf, size, "raw 0x%" PRIx64, evsel->core.attr.config);
>  	return ret + perf_evsel__add_modifiers(evsel, bf + ret, size - ret);
>  }
>  
> @@ -598,7 +597,7 @@ const char *perf_evsel__name(struct evsel *evsel)
>  	if (evsel->name)
>  		return evsel->name;
>  
> -	switch (evsel->attr.type) {
> +	switch (evsel->core.attr.type) {
>  	case PERF_TYPE_RAW:
>  		perf_evsel__raw_name(evsel, bf, sizeof(bf));
>  		break;
> @@ -628,7 +627,7 @@ const char *perf_evsel__name(struct evsel *evsel)
>  
>  	default:
>  		scnprintf(bf, sizeof(bf), "unknown attr type: %d",
> -			  evsel->attr.type);
> +			  evsel->core.attr.type);
>  		break;
>  	}
>  
> @@ -682,7 +681,7 @@ static void __perf_evsel__config_callchain(struct evsel *evsel,
>  					   struct callchain_param *param)
>  {
>  	bool function = perf_evsel__is_function_event(evsel);
> -	struct perf_event_attr *attr = &evsel->attr;
> +	struct perf_event_attr *attr = &evsel->core.attr;
>  
>  	perf_evsel__set_sample_bit(evsel, CALLCHAIN);
>  
> @@ -748,7 +747,7 @@ static void
>  perf_evsel__reset_callgraph(struct evsel *evsel,
>  			    struct callchain_param *param)
>  {
> -	struct perf_event_attr *attr = &evsel->attr;
> +	struct perf_event_attr *attr = &evsel->core.attr;
>  
>  	perf_evsel__reset_sample_bit(evsel, CALLCHAIN);
>  	if (param->record_mode == CALLCHAIN_LBR) {
> @@ -767,7 +766,7 @@ static void apply_config_terms(struct evsel *evsel,
>  {
>  	struct perf_evsel_config_term *term;
>  	struct list_head *config_terms = &evsel->config_terms;
> -	struct perf_event_attr *attr = &evsel->attr;
> +	struct perf_event_attr *attr = &evsel->core.attr;
>  	/* callgraph default */
>  	struct callchain_param param = {
>  		.record_mode = callchain_param.record_mode,
> @@ -880,7 +879,7 @@ static void apply_config_terms(struct evsel *evsel,
>  			if (sample_address) {
>  				perf_evsel__set_sample_bit(evsel, ADDR);
>  				perf_evsel__set_sample_bit(evsel, DATA_SRC);
> -				evsel->attr.mmap_data = track;
> +				evsel->core.attr.mmap_data = track;
>  			}
>  			perf_evsel__config_callchain(evsel, opts, &param);
>  		}
> @@ -889,8 +888,8 @@ static void apply_config_terms(struct evsel *evsel,
>  
>  static bool is_dummy_event(struct evsel *evsel)
>  {
> -	return (evsel->attr.type == PERF_TYPE_SOFTWARE) &&
> -	       (evsel->attr.config == PERF_COUNT_SW_DUMMY);
> +	return (evsel->core.attr.type == PERF_TYPE_SOFTWARE) &&
> +	       (evsel->core.attr.config == PERF_COUNT_SW_DUMMY);
>  }
>  
>  /*
> @@ -925,7 +924,7 @@ void perf_evsel__config(struct evsel *evsel, struct record_opts *opts,
>  			struct callchain_param *callchain)
>  {
>  	struct evsel *leader = evsel->leader;
> -	struct perf_event_attr *attr = &evsel->attr;
> +	struct perf_event_attr *attr = &evsel->core.attr;
>  	int track = evsel->tracking;
>  	bool per_cpu = opts->target.default_per_cpu && !opts->target.per_thread;
>  
> @@ -986,14 +985,14 @@ void perf_evsel__config(struct evsel *evsel, struct record_opts *opts,
>  		 * event to follow the master sample_type to ease up
>  		 * report.
>  		 */
> -		attr->sample_type = leader->attr.sample_type;
> +		attr->sample_type = leader->core.attr.sample_type;
>  	}
>  
>  	if (opts->no_samples)
>  		attr->sample_freq = 0;
>  
>  	if (opts->inherit_stat) {
> -		evsel->attr.read_format |=
> +		evsel->core.attr.read_format |=
>  			PERF_FORMAT_TOTAL_TIME_ENABLED |
>  			PERF_FORMAT_TOTAL_TIME_RUNNING |
>  			PERF_FORMAT_ID;
> @@ -1011,7 +1010,7 @@ void perf_evsel__config(struct evsel *evsel, struct record_opts *opts,
>  	 * fault handler and its overall trickiness nature.
>  	 */
>  	if (perf_evsel__is_function_event(evsel))
> -		evsel->attr.exclude_callchain_user = 1;
> +		evsel->core.attr.exclude_callchain_user = 1;
>  
>  	if (callchain && callchain->enabled && !evsel->no_aux_samples)
>  		perf_evsel__config_callchain(evsel, opts, callchain);
> @@ -1080,7 +1079,7 @@ void perf_evsel__config(struct evsel *evsel, struct record_opts *opts,
>  		perf_evsel__set_sample_bit(evsel, TRANSACTION);
>  
>  	if (opts->running_time) {
> -		evsel->attr.read_format |=
> +		evsel->core.attr.read_format |=
>  			PERF_FORMAT_TOTAL_TIME_ENABLED |
>  			PERF_FORMAT_TOTAL_TIME_RUNNING;
>  	}
> @@ -1127,7 +1126,7 @@ void perf_evsel__config(struct evsel *evsel, struct record_opts *opts,
>  	}
>  
>  	if (evsel->own_cpus || evsel->unit)
> -		evsel->attr.read_format |= PERF_FORMAT_ID;
> +		evsel->core.attr.read_format |= PERF_FORMAT_ID;
>  
>  	/*
>  	 * Apply event specific term settings,
> @@ -1382,7 +1381,7 @@ void perf_counts_values__scale(struct perf_counts_values *count,
>  
>  static int perf_evsel__read_size(struct evsel *evsel)
>  {
> -	u64 read_format = evsel->attr.read_format;
> +	u64 read_format = evsel->core.attr.read_format;
>  	int entry = sizeof(u64); /* value */
>  	int size = 0;
>  	int nr = 1;
> @@ -1448,7 +1447,7 @@ static int
>  perf_evsel__process_group_data(struct evsel *leader,
>  			       int cpu, int thread, u64 *data)
>  {
> -	u64 read_format = leader->attr.read_format;
> +	u64 read_format = leader->core.attr.read_format;
>  	struct sample_read_value *v;
>  	u64 nr, ena = 0, run = 0, i;
>  
> @@ -1486,7 +1485,7 @@ static int
>  perf_evsel__read_group(struct evsel *leader, int cpu, int thread)
>  {
>  	struct perf_stat_evsel *ps = leader->stats;
> -	u64 read_format = leader->attr.read_format;
> +	u64 read_format = leader->core.attr.read_format;
>  	int size = perf_evsel__read_size(leader);
>  	u64 *data = ps->group_data;
>  
> @@ -1515,7 +1514,7 @@ perf_evsel__read_group(struct evsel *leader, int cpu, int thread)
>  
>  int perf_evsel__read_counter(struct evsel *evsel, int cpu, int thread)
>  {
> -	u64 read_format = evsel->attr.read_format;
> +	u64 read_format = evsel->core.attr.read_format;
>  
>  	if (read_format & PERF_FORMAT_GROUP)
>  		return perf_evsel__read_group(evsel, cpu, thread);
> @@ -1793,14 +1792,14 @@ static int perf_event_open(struct evsel *evsel,
>  			   pid_t pid, int cpu, int group_fd,
>  			   unsigned long flags)
>  {
> -	int precise_ip = evsel->attr.precise_ip;
> +	int precise_ip = evsel->core.attr.precise_ip;
>  	int fd;
>  
>  	while (1) {
>  		pr_debug2("sys_perf_event_open: pid %d  cpu %d  group_fd %d  flags %#lx",
>  			  pid, cpu, group_fd, flags);
>  
> -		fd = sys_perf_event_open(&evsel->attr, pid, cpu, group_fd, flags);
> +		fd = sys_perf_event_open(&evsel->core.attr, pid, cpu, group_fd, flags);
>  		if (fd >= 0)
>  			break;
>  
> @@ -1812,15 +1811,15 @@ static int perf_event_open(struct evsel *evsel,
>  		 * We tried all the precise_ip values, and it's
>  		 * still failing, so leave it to standard fallback.
>  		 */
> -		if (!evsel->attr.precise_ip) {
> -			evsel->attr.precise_ip = precise_ip;
> +		if (!evsel->core.attr.precise_ip) {
> +			evsel->core.attr.precise_ip = precise_ip;
>  			break;
>  		}
>  
>  		pr_debug2("\nsys_perf_event_open failed, error %d\n", -ENOTSUP);
> -		evsel->attr.precise_ip--;
> -		pr_debug2("decreasing precise_ip by one (%d)\n", evsel->attr.precise_ip);
> -		display_attr(&evsel->attr);
> +		evsel->core.attr.precise_ip--;
> +		pr_debug2("decreasing precise_ip by one (%d)\n", evsel->core.attr.precise_ip);
> +		display_attr(&evsel->core.attr);
>  	}
>  
>  	return fd;
> @@ -1834,7 +1833,7 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
>  	int pid = -1, err;
>  	enum { NO_CHANGE, SET_TO_MAX, INCREASED_MAX } set_rlimit = NO_CHANGE;
>  
> -	if (perf_missing_features.write_backward && evsel->attr.write_backward)
> +	if (perf_missing_features.write_backward && evsel->core.attr.write_backward)
>  		return -EINVAL;
>  
>  	if (cpus == NULL) {
> @@ -1877,31 +1876,31 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
>  
>  fallback_missing_features:
>  	if (perf_missing_features.clockid_wrong)
> -		evsel->attr.clockid = CLOCK_MONOTONIC; /* should always work */
> +		evsel->core.attr.clockid = CLOCK_MONOTONIC; /* should always work */
>  	if (perf_missing_features.clockid) {
> -		evsel->attr.use_clockid = 0;
> -		evsel->attr.clockid = 0;
> +		evsel->core.attr.use_clockid = 0;
> +		evsel->core.attr.clockid = 0;
>  	}
>  	if (perf_missing_features.cloexec)
>  		flags &= ~(unsigned long)PERF_FLAG_FD_CLOEXEC;
>  	if (perf_missing_features.mmap2)
> -		evsel->attr.mmap2 = 0;
> +		evsel->core.attr.mmap2 = 0;
>  	if (perf_missing_features.exclude_guest)
> -		evsel->attr.exclude_guest = evsel->attr.exclude_host = 0;
> +		evsel->core.attr.exclude_guest = evsel->core.attr.exclude_host = 0;
>  	if (perf_missing_features.lbr_flags)
> -		evsel->attr.branch_sample_type &= ~(PERF_SAMPLE_BRANCH_NO_FLAGS |
> +		evsel->core.attr.branch_sample_type &= ~(PERF_SAMPLE_BRANCH_NO_FLAGS |
>  				     PERF_SAMPLE_BRANCH_NO_CYCLES);
> -	if (perf_missing_features.group_read && evsel->attr.inherit)
> -		evsel->attr.read_format &= ~(PERF_FORMAT_GROUP|PERF_FORMAT_ID);
> +	if (perf_missing_features.group_read && evsel->core.attr.inherit)
> +		evsel->core.attr.read_format &= ~(PERF_FORMAT_GROUP|PERF_FORMAT_ID);
>  	if (perf_missing_features.ksymbol)
> -		evsel->attr.ksymbol = 0;
> +		evsel->core.attr.ksymbol = 0;
>  	if (perf_missing_features.bpf_event)
> -		evsel->attr.bpf_event = 0;
> +		evsel->core.attr.bpf_event = 0;
>  retry_sample_id:
>  	if (perf_missing_features.sample_id_all)
> -		evsel->attr.sample_id_all = 0;
> +		evsel->core.attr.sample_id_all = 0;
>  
> -	display_attr(&evsel->attr);
> +	display_attr(&evsel->core.attr);
>  
>  	for (cpu = 0; cpu < cpus->nr; cpu++) {
>  
> @@ -2008,23 +2007,23 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
>  	 * Must probe features in the order they were added to the
>  	 * perf_event_attr interface.
>  	 */
> -	if (!perf_missing_features.bpf_event && evsel->attr.bpf_event) {
> +	if (!perf_missing_features.bpf_event && evsel->core.attr.bpf_event) {
>  		perf_missing_features.bpf_event = true;
>  		pr_debug2("switching off bpf_event\n");
>  		goto fallback_missing_features;
> -	} else if (!perf_missing_features.ksymbol && evsel->attr.ksymbol) {
> +	} else if (!perf_missing_features.ksymbol && evsel->core.attr.ksymbol) {
>  		perf_missing_features.ksymbol = true;
>  		pr_debug2("switching off ksymbol\n");
>  		goto fallback_missing_features;
> -	} else if (!perf_missing_features.write_backward && evsel->attr.write_backward) {
> +	} else if (!perf_missing_features.write_backward && evsel->core.attr.write_backward) {
>  		perf_missing_features.write_backward = true;
>  		pr_debug2("switching off write_backward\n");
>  		goto out_close;
> -	} else if (!perf_missing_features.clockid_wrong && evsel->attr.use_clockid) {
> +	} else if (!perf_missing_features.clockid_wrong && evsel->core.attr.use_clockid) {
>  		perf_missing_features.clockid_wrong = true;
>  		pr_debug2("switching off clockid\n");
>  		goto fallback_missing_features;
> -	} else if (!perf_missing_features.clockid && evsel->attr.use_clockid) {
> +	} else if (!perf_missing_features.clockid && evsel->core.attr.use_clockid) {
>  		perf_missing_features.clockid = true;
>  		pr_debug2("switching off use_clockid\n");
>  		goto fallback_missing_features;
> @@ -2032,12 +2031,12 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
>  		perf_missing_features.cloexec = true;
>  		pr_debug2("switching off cloexec flag\n");
>  		goto fallback_missing_features;
> -	} else if (!perf_missing_features.mmap2 && evsel->attr.mmap2) {
> +	} else if (!perf_missing_features.mmap2 && evsel->core.attr.mmap2) {
>  		perf_missing_features.mmap2 = true;
>  		pr_debug2("switching off mmap2\n");
>  		goto fallback_missing_features;
>  	} else if (!perf_missing_features.exclude_guest &&
> -		   (evsel->attr.exclude_guest || evsel->attr.exclude_host)) {
> +		   (evsel->core.attr.exclude_guest || evsel->core.attr.exclude_host)) {
>  		perf_missing_features.exclude_guest = true;
>  		pr_debug2("switching off exclude_guest, exclude_host\n");
>  		goto fallback_missing_features;
> @@ -2046,15 +2045,15 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
>  		pr_debug2("switching off sample_id_all\n");
>  		goto retry_sample_id;
>  	} else if (!perf_missing_features.lbr_flags &&
> -			(evsel->attr.branch_sample_type &
> +			(evsel->core.attr.branch_sample_type &
>  			 (PERF_SAMPLE_BRANCH_NO_CYCLES |
>  			  PERF_SAMPLE_BRANCH_NO_FLAGS))) {
>  		perf_missing_features.lbr_flags = true;
>  		pr_debug2("switching off branch sample type no (cycles/flags)\n");
>  		goto fallback_missing_features;
>  	} else if (!perf_missing_features.group_read &&
> -		    evsel->attr.inherit &&
> -		   (evsel->attr.read_format & PERF_FORMAT_GROUP) &&
> +		    evsel->core.attr.inherit &&
> +		   (evsel->core.attr.read_format & PERF_FORMAT_GROUP) &&
>  		   perf_evsel__is_group_leader(evsel)) {
>  		perf_missing_features.group_read = true;
>  		pr_debug2("switching off group read\n");
> @@ -2100,7 +2099,7 @@ static int perf_evsel__parse_id_sample(const struct evsel *evsel,
>  				       const union perf_event *event,
>  				       struct perf_sample *sample)
>  {
> -	u64 type = evsel->attr.sample_type;
> +	u64 type = evsel->core.attr.sample_type;
>  	const u64 *array = event->sample.array;
>  	bool swapped = evsel->needs_swap;
>  	union u64_swap u;
> @@ -2189,7 +2188,7 @@ perf_event__check_size(union perf_event *event, unsigned int sample_size)
>  int perf_evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>  			     struct perf_sample *data)
>  {
> -	u64 type = evsel->attr.sample_type;
> +	u64 type = evsel->core.attr.sample_type;
>  	bool swapped = evsel->needs_swap;
>  	const u64 *array;
>  	u16 max_size = event->header.size;
> @@ -2205,14 +2204,14 @@ int perf_evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>  	memset(data, 0, sizeof(*data));
>  	data->cpu = data->pid = data->tid = -1;
>  	data->stream_id = data->id = data->time = -1ULL;
> -	data->period = evsel->attr.sample_period;
> +	data->period = evsel->core.attr.sample_period;
>  	data->cpumode = event->header.misc & PERF_RECORD_MISC_CPUMODE_MASK;
>  	data->misc    = event->header.misc;
>  	data->id = -1ULL;
>  	data->data_src = PERF_MEM_DATA_SRC_NONE;
>  
>  	if (event->header.type != PERF_RECORD_SAMPLE) {
> -		if (!evsel->attr.sample_id_all)
> +		if (!evsel->core.attr.sample_id_all)
>  			return 0;
>  		return perf_evsel__parse_id_sample(evsel, event, data);
>  	}
> @@ -2285,7 +2284,7 @@ int perf_evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>  	}
>  
>  	if (type & PERF_SAMPLE_READ) {
> -		u64 read_format = evsel->attr.read_format;
> +		u64 read_format = evsel->core.attr.read_format;
>  
>  		OVERFLOW_CHECK_u64(array);
>  		if (read_format & PERF_FORMAT_GROUP)
> @@ -2390,7 +2389,7 @@ int perf_evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>  		array++;
>  
>  		if (data->user_regs.abi) {
> -			u64 mask = evsel->attr.sample_regs_user;
> +			u64 mask = evsel->core.attr.sample_regs_user;
>  
>  			sz = hweight64(mask) * sizeof(u64);
>  			OVERFLOW_CHECK(array, sz, max_size);
> @@ -2446,7 +2445,7 @@ int perf_evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>  		array++;
>  
>  		if (data->intr_regs.abi != PERF_SAMPLE_REGS_ABI_NONE) {
> -			u64 mask = evsel->attr.sample_regs_intr;
> +			u64 mask = evsel->core.attr.sample_regs_intr;
>  
>  			sz = hweight64(mask) * sizeof(u64);
>  			OVERFLOW_CHECK(array, sz, max_size);
> @@ -2469,7 +2468,7 @@ int perf_evsel__parse_sample_timestamp(struct evsel *evsel,
>  				       union perf_event *event,
>  				       u64 *timestamp)
>  {
> -	u64 type = evsel->attr.sample_type;
> +	u64 type = evsel->core.attr.sample_type;
>  	const u64 *array;
>  
>  	if (!(type & PERF_SAMPLE_TIME))
> @@ -2480,7 +2479,7 @@ int perf_evsel__parse_sample_timestamp(struct evsel *evsel,
>  			.time = -1ULL,
>  		};
>  
> -		if (!evsel->attr.sample_id_all)
> +		if (!evsel->core.attr.sample_id_all)
>  			return -1;
>  		if (perf_evsel__parse_id_sample(evsel, event, &data))
>  			return -1;
> @@ -2866,8 +2865,8 @@ bool perf_evsel__fallback(struct evsel *evsel, int err,
>  	int paranoid;
>  
>  	if ((err == ENOENT || err == ENXIO || err == ENODEV) &&
> -	    evsel->attr.type   == PERF_TYPE_HARDWARE &&
> -	    evsel->attr.config == PERF_COUNT_HW_CPU_CYCLES) {
> +	    evsel->core.attr.type   == PERF_TYPE_HARDWARE &&
> +	    evsel->core.attr.config == PERF_COUNT_HW_CPU_CYCLES) {
>  		/*
>  		 * If it's cycles then fall back to hrtimer based
>  		 * cpu-clock-tick sw counter, which is always available even if
> @@ -2879,12 +2878,12 @@ bool perf_evsel__fallback(struct evsel *evsel, int err,
>  		scnprintf(msg, msgsize, "%s",
>  "The cycles event is not supported, trying to fall back to cpu-clock-ticks");
>  
> -		evsel->attr.type   = PERF_TYPE_SOFTWARE;
> -		evsel->attr.config = PERF_COUNT_SW_CPU_CLOCK;
> +		evsel->core.attr.type   = PERF_TYPE_SOFTWARE;
> +		evsel->core.attr.config = PERF_COUNT_SW_CPU_CLOCK;
>  
>  		zfree(&evsel->name);
>  		return true;
> -	} else if (err == EACCES && !evsel->attr.exclude_kernel &&
> +	} else if (err == EACCES && !evsel->core.attr.exclude_kernel &&
>  		   (paranoid = perf_event_paranoid()) > 1) {
>  		const char *name = perf_evsel__name(evsel);
>  		char *new_name;
> @@ -2903,7 +2902,7 @@ bool perf_evsel__fallback(struct evsel *evsel, int err,
>  		evsel->name = new_name;
>  		scnprintf(msg, msgsize,
>  "kernel.perf_event_paranoid=%d, trying to fall back to excluding kernel samples", paranoid);
> -		evsel->attr.exclude_kernel = 1;
> +		evsel->core.attr.exclude_kernel = 1;
>  
>  		return true;
>  	}
> @@ -3000,15 +2999,15 @@ int perf_evsel__open_strerror(struct evsel *evsel, struct target *target,
>  	 "No such device - did you specify an out-of-range profile CPU?");
>  		break;
>  	case EOPNOTSUPP:
> -		if (evsel->attr.sample_period != 0)
> +		if (evsel->core.attr.sample_period != 0)
>  			return scnprintf(msg, size,
>  	"%s: PMU Hardware doesn't support sampling/overflow-interrupts. Try 'perf stat'",
>  					 perf_evsel__name(evsel));
> -		if (evsel->attr.precise_ip)
> +		if (evsel->core.attr.precise_ip)
>  			return scnprintf(msg, size, "%s",
>  	"\'precise\' request may not be supported. Try removing 'p' modifier.");
>  #if defined(__i386__) || defined(__x86_64__)
> -		if (evsel->attr.type == PERF_TYPE_HARDWARE)
> +		if (evsel->core.attr.type == PERF_TYPE_HARDWARE)
>  			return scnprintf(msg, size, "%s",
>  	"No hardware sampling interrupt available.\n");
>  #endif
> @@ -3020,7 +3019,7 @@ int perf_evsel__open_strerror(struct evsel *evsel, struct target *target,
>  	"We found oprofile daemon running, please stop it and try again.");
>  		break;
>  	case EINVAL:
> -		if (evsel->attr.write_backward && perf_missing_features.write_backward)
> +		if (evsel->core.attr.write_backward && perf_missing_features.write_backward)
>  			return scnprintf(msg, size, "Reading from overwrite event is not supported by this kernel.");
>  		if (perf_missing_features.clockid)
>  			return scnprintf(msg, size, "clockid feature not supported.");
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index d74cac6fe306..43f66158de3b 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -103,7 +103,6 @@ struct bpf_object;
>  struct evsel {
>  	struct perf_evsel	core;
>  	struct evlist	*evlist;
> -	struct perf_event_attr	attr;
>  	char			*filter;
>  	struct xyarray		*fd;
>  	struct xyarray		*sample_id;
> @@ -327,21 +326,21 @@ u64 format_field__intval(struct tep_format_field *field, struct perf_sample *sam
>  struct tep_format_field *perf_evsel__field(struct evsel *evsel, const char *name);
>  
>  #define perf_evsel__match(evsel, t, c)		\
> -	(evsel->attr.type == PERF_TYPE_##t &&	\
> -	 evsel->attr.config == PERF_COUNT_##c)
> +	(evsel->core.attr.type == PERF_TYPE_##t &&	\
> +	 evsel->core.attr.config == PERF_COUNT_##c)
>  
>  static inline bool perf_evsel__match2(struct evsel *e1,
>  				      struct evsel *e2)
>  {
> -	return (e1->attr.type == e2->attr.type) &&
> -	       (e1->attr.config == e2->attr.config);
> +	return (e1->core.attr.type == e2->core.attr.type) &&
> +	       (e1->core.attr.config == e2->core.attr.config);
>  }
>  
>  #define perf_evsel__cmp(a, b)			\
>  	((a) &&					\
>  	 (b) &&					\
> -	 (a)->attr.type == (b)->attr.type &&	\
> -	 (a)->attr.config == (b)->attr.config)
> +	 (a)->core.attr.type == (b)->core.attr.type &&	\
> +	 (a)->core.attr.config == (b)->core.attr.config)
>  
>  int perf_evsel__read(struct evsel *evsel, int cpu, int thread,
>  		     struct perf_counts_values *count);
> @@ -490,12 +489,12 @@ for ((_evsel) = _leader; 							\
>  
>  static inline bool perf_evsel__has_branch_callstack(const struct evsel *evsel)
>  {
> -	return evsel->attr.branch_sample_type & PERF_SAMPLE_BRANCH_CALL_STACK;
> +	return evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_CALL_STACK;
>  }
>  
>  static inline bool evsel__has_callchain(const struct evsel *evsel)
>  {
> -	return (evsel->attr.sample_type & PERF_SAMPLE_CALLCHAIN) != 0;
> +	return (evsel->core.attr.sample_type & PERF_SAMPLE_CALLCHAIN) != 0;
>  }
>  
>  typedef int (*attr__fprintf_f)(FILE *, const char *, const char *, void *);
> diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
> index 1fddb7da4b51..3466eca34a00 100644
> --- a/tools/perf/util/evsel_fprintf.c
> +++ b/tools/perf/util/evsel_fprintf.c
> @@ -60,22 +60,22 @@ int perf_evsel__fprintf(struct evsel *evsel,
>  	printed += fprintf(fp, "%s", perf_evsel__name(evsel));
>  
>  	if (details->verbose) {
> -		printed += perf_event_attr__fprintf(fp, &evsel->attr,
> +		printed += perf_event_attr__fprintf(fp, &evsel->core.attr,
>  						    __print_attr__fprintf, &first);
>  	} else if (details->freq) {
>  		const char *term = "sample_freq";
>  
> -		if (!evsel->attr.freq)
> +		if (!evsel->core.attr.freq)
>  			term = "sample_period";
>  
>  		printed += comma_fprintf(fp, &first, " %s=%" PRIu64,
> -					 term, (u64)evsel->attr.sample_freq);
> +					 term, (u64)evsel->core.attr.sample_freq);
>  	}
>  
>  	if (details->trace_fields) {
>  		struct tep_format_field *field;
>  
> -		if (evsel->attr.type != PERF_TYPE_TRACEPOINT) {
> +		if (evsel->core.attr.type != PERF_TYPE_TRACEPOINT) {
>  			printed += comma_fprintf(fp, &first, " (not a tracepoint)");
>  			goto out;
>  		}
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index eacd241b70af..8dc3b9947295 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -488,13 +488,13 @@ static int write_event_desc(struct feat_fd *ff,
>  	/*
>  	 * size of perf_event_attr struct
>  	 */
> -	sz = (u32)sizeof(evsel->attr);
> +	sz = (u32)sizeof(evsel->core.attr);
>  	ret = do_write(ff, &sz, sizeof(sz));
>  	if (ret < 0)
>  		return ret;
>  
>  	evlist__for_each_entry(evlist, evsel) {
> -		ret = do_write(ff, &evsel->attr, sz);
> +		ret = do_write(ff, &evsel->core.attr, sz);
>  		if (ret < 0)
>  			return ret;
>  		/*
> @@ -1575,7 +1575,7 @@ static void free_event_desc(struct evsel *events)
>  	if (!events)
>  		return;
>  
> -	for (evsel = events; evsel->attr.size; evsel++) {
> +	for (evsel = events; evsel->core.attr.size; evsel++) {
>  		zfree(&evsel->name);
>  		zfree(&evsel->id);
>  	}
> @@ -1603,12 +1603,12 @@ static struct evsel *read_event_desc(struct feat_fd *ff)
>  	if (!buf)
>  		goto error;
>  
> -	/* the last event terminates with evsel->attr.size == 0: */
> +	/* the last event terminates with evsel->core.attr.size == 0: */
>  	events = calloc(nre + 1, sizeof(*events));
>  	if (!events)
>  		goto error;
>  
> -	msz = sizeof(evsel->attr);
> +	msz = sizeof(evsel->core.attr);
>  	if (sz < msz)
>  		msz = sz;
>  
> @@ -1625,7 +1625,7 @@ static struct evsel *read_event_desc(struct feat_fd *ff)
>  		if (ff->ph->needs_swap)
>  			perf_event__attr_swap(buf);
>  
> -		memcpy(&evsel->attr, buf, msz);
> +		memcpy(&evsel->core.attr, buf, msz);
>  
>  		if (do_read_u32(ff, &nr))
>  			goto error;
> @@ -1683,7 +1683,7 @@ static void print_event_desc(struct feat_fd *ff, FILE *fp)
>  		return;
>  	}
>  
> -	for (evsel = events; evsel->attr.size; evsel++) {
> +	for (evsel = events; evsel->core.attr.size; evsel++) {
>  		fprintf(fp, "# event : name = %s, ", evsel->name);
>  
>  		if (evsel->ids) {
> @@ -1696,7 +1696,7 @@ static void print_event_desc(struct feat_fd *ff, FILE *fp)
>  			fprintf(fp, " }");
>  		}
>  
> -		perf_event_attr__fprintf(fp, &evsel->attr, __desc_attr__fprintf, NULL);
> +		perf_event_attr__fprintf(fp, &evsel->core.attr, __desc_attr__fprintf, NULL);
>  
>  		fputc('\n', fp);
>  	}
> @@ -2138,7 +2138,7 @@ process_event_desc(struct feat_fd *ff, void *data __maybe_unused)
>  		ff->events = events;
>  	}
>  
> -	for (evsel = events; evsel->attr.size; evsel++)
> +	for (evsel = events; evsel->core.attr.size; evsel++)
>  		perf_evlist__set_event_name(session->evlist, evsel);
>  
>  	if (!session->data->is_pipe)
> @@ -3071,7 +3071,7 @@ int perf_session__write_header(struct perf_session *session,
>  
>  	evlist__for_each_entry(evlist, evsel) {
>  		f_attr = (struct perf_file_attr){
> -			.attr = evsel->attr,
> +			.attr = evsel->core.attr,
>  			.ids  = {
>  				.offset = evsel->id_offset,
>  				.size   = evsel->ids * sizeof(u64),
> @@ -3494,9 +3494,9 @@ static int perf_evsel__prepare_tracepoint_event(struct evsel *evsel,
>  		return -1;
>  	}
>  
> -	event = tep_find_event(pevent, evsel->attr.config);
> +	event = tep_find_event(pevent, evsel->core.attr.config);
>  	if (event == NULL) {
> -		pr_debug("cannot find event format for %d\n", (int)evsel->attr.config);
> +		pr_debug("cannot find event format for %d\n", (int)evsel->core.attr.config);
>  		return -1;
>  	}
>  
> @@ -3517,7 +3517,7 @@ static int perf_evlist__prepare_tracepoint_events(struct evlist *evlist,
>  	struct evsel *pos;
>  
>  	evlist__for_each_entry(evlist, pos) {
> -		if (pos->attr.type == PERF_TYPE_TRACEPOINT &&
> +		if (pos->core.attr.type == PERF_TYPE_TRACEPOINT &&
>  		    perf_evsel__prepare_tracepoint_event(pos, pevent))
>  			return -1;
>  	}
> @@ -3921,7 +3921,7 @@ int perf_event__synthesize_attrs(struct perf_tool *tool,
>  	int err = 0;
>  
>  	evlist__for_each_entry(evlist, evsel) {
> -		err = perf_event__synthesize_attr(tool, &evsel->attr, evsel->ids,
> +		err = perf_event__synthesize_attr(tool, &evsel->core.attr, evsel->ids,
>  						  evsel->id, process);
>  		if (err) {
>  			pr_debug("failed to create perf header attribute\n");
> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index bb5437f549b6..821e0fe6cf26 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -2638,7 +2638,7 @@ int __hists__scnprintf_title(struct hists *hists, char *bf, size_t size, bool sh
>  		enable_ref = true;
>  
>  	if (show_freq)
> -		scnprintf(sample_freq_str, sizeof(sample_freq_str), " %d Hz,", evsel->attr.sample_freq);
> +		scnprintf(sample_freq_str, sizeof(sample_freq_str), " %d Hz,", evsel->core.attr.sample_freq);
>  
>  	nr_samples = convert_unit(nr_samples, &unit);
>  	printed = scnprintf(bf, size,
> diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
> index 849a5b713b04..7eb9e6dc27dd 100644
> --- a/tools/perf/util/intel-bts.c
> +++ b/tools/perf/util/intel-bts.c
> @@ -768,7 +768,7 @@ static int intel_bts_synth_events(struct intel_bts *bts,
>  	int err;
>  
>  	evlist__for_each_entry(evlist, evsel) {
> -		if (evsel->attr.type == bts->pmu_type && evsel->ids) {
> +		if (evsel->core.attr.type == bts->pmu_type && evsel->ids) {
>  			found = true;
>  			break;
>  		}
> @@ -782,18 +782,18 @@ static int intel_bts_synth_events(struct intel_bts *bts,
>  	memset(&attr, 0, sizeof(struct perf_event_attr));
>  	attr.size = sizeof(struct perf_event_attr);
>  	attr.type = PERF_TYPE_HARDWARE;
> -	attr.sample_type = evsel->attr.sample_type & PERF_SAMPLE_MASK;
> +	attr.sample_type = evsel->core.attr.sample_type & PERF_SAMPLE_MASK;
>  	attr.sample_type |= PERF_SAMPLE_IP | PERF_SAMPLE_TID |
>  			    PERF_SAMPLE_PERIOD;
>  	attr.sample_type &= ~(u64)PERF_SAMPLE_TIME;
>  	attr.sample_type &= ~(u64)PERF_SAMPLE_CPU;
> -	attr.exclude_user = evsel->attr.exclude_user;
> -	attr.exclude_kernel = evsel->attr.exclude_kernel;
> -	attr.exclude_hv = evsel->attr.exclude_hv;
> -	attr.exclude_host = evsel->attr.exclude_host;
> -	attr.exclude_guest = evsel->attr.exclude_guest;
> -	attr.sample_id_all = evsel->attr.sample_id_all;
> -	attr.read_format = evsel->attr.read_format;
> +	attr.exclude_user = evsel->core.attr.exclude_user;
> +	attr.exclude_kernel = evsel->core.attr.exclude_kernel;
> +	attr.exclude_hv = evsel->core.attr.exclude_hv;
> +	attr.exclude_host = evsel->core.attr.exclude_host;
> +	attr.exclude_guest = evsel->core.attr.exclude_guest;
> +	attr.sample_id_all = evsel->core.attr.sample_id_all;
> +	attr.read_format = evsel->core.attr.read_format;
>  
>  	id = evsel->id[0] + 1000000000;
>  	if (!id)
> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> index c88e3d1ee9c7..4c52204868d8 100644
> --- a/tools/perf/util/intel-pt.c
> +++ b/tools/perf/util/intel-pt.c
> @@ -726,8 +726,8 @@ static bool intel_pt_exclude_kernel(struct intel_pt *pt)
>  	struct evsel *evsel;
>  
>  	evlist__for_each_entry(pt->session->evlist, evsel) {
> -		if (intel_pt_get_config(pt, &evsel->attr, NULL) &&
> -		    !evsel->attr.exclude_kernel)
> +		if (intel_pt_get_config(pt, &evsel->core.attr, NULL) &&
> +		    !evsel->core.attr.exclude_kernel)
>  			return false;
>  	}
>  	return true;
> @@ -742,7 +742,7 @@ static bool intel_pt_return_compression(struct intel_pt *pt)
>  		return true;
>  
>  	evlist__for_each_entry(pt->session->evlist, evsel) {
> -		if (intel_pt_get_config(pt, &evsel->attr, &config) &&
> +		if (intel_pt_get_config(pt, &evsel->core.attr, &config) &&
>  		    (config & pt->noretcomp_bit))
>  			return false;
>  	}
> @@ -755,7 +755,7 @@ static bool intel_pt_branch_enable(struct intel_pt *pt)
>  	u64 config;
>  
>  	evlist__for_each_entry(pt->session->evlist, evsel) {
> -		if (intel_pt_get_config(pt, &evsel->attr, &config) &&
> +		if (intel_pt_get_config(pt, &evsel->core.attr, &config) &&
>  		    (config & 1) && !(config & 0x2000))
>  			return false;
>  	}
> @@ -775,7 +775,7 @@ static unsigned int intel_pt_mtc_period(struct intel_pt *pt)
>  		config >>= 1;
>  
>  	evlist__for_each_entry(pt->session->evlist, evsel) {
> -		if (intel_pt_get_config(pt, &evsel->attr, &config))
> +		if (intel_pt_get_config(pt, &evsel->core.attr, &config))
>  			return (config & pt->mtc_freq_bits) >> shift;
>  	}
>  	return 0;
> @@ -791,9 +791,9 @@ static bool intel_pt_timeless_decoding(struct intel_pt *pt)
>  		return true;
>  
>  	evlist__for_each_entry(pt->session->evlist, evsel) {
> -		if (!(evsel->attr.sample_type & PERF_SAMPLE_TIME))
> +		if (!(evsel->core.attr.sample_type & PERF_SAMPLE_TIME))
>  			return true;
> -		if (intel_pt_get_config(pt, &evsel->attr, &config)) {
> +		if (intel_pt_get_config(pt, &evsel->core.attr, &config)) {
>  			if (config & pt->tsc_bit)
>  				timeless_decoding = false;
>  			else
> @@ -808,8 +808,8 @@ static bool intel_pt_tracing_kernel(struct intel_pt *pt)
>  	struct evsel *evsel;
>  
>  	evlist__for_each_entry(pt->session->evlist, evsel) {
> -		if (intel_pt_get_config(pt, &evsel->attr, NULL) &&
> -		    !evsel->attr.exclude_kernel)
> +		if (intel_pt_get_config(pt, &evsel->core.attr, NULL) &&
> +		    !evsel->core.attr.exclude_kernel)
>  			return true;
>  	}
>  	return false;
> @@ -825,7 +825,7 @@ static bool intel_pt_have_tsc(struct intel_pt *pt)
>  		return false;
>  
>  	evlist__for_each_entry(pt->session->evlist, evsel) {
> -		if (intel_pt_get_config(pt, &evsel->attr, &config)) {
> +		if (intel_pt_get_config(pt, &evsel->core.attr, &config)) {
>  			if (config & pt->tsc_bit)
>  				have_tsc = true;
>  			else
> @@ -1703,7 +1703,7 @@ static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
>  	union perf_event *event = ptq->event_buf;
>  	struct intel_pt *pt = ptq->pt;
>  	struct evsel *evsel = pt->pebs_evsel;
> -	u64 sample_type = evsel->attr.sample_type;
> +	u64 sample_type = evsel->core.attr.sample_type;
>  	u64 id = evsel->id[0];
>  	u8 cpumode;
>  
> @@ -1715,8 +1715,8 @@ static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
>  	sample.id = id;
>  	sample.stream_id = id;
>  
> -	if (!evsel->attr.freq)
> -		sample.period = evsel->attr.sample_period;
> +	if (!evsel->core.attr.freq)
> +		sample.period = evsel->core.attr.sample_period;
>  
>  	/* No support for non-zero CS base */
>  	if (items->has_ip)
> @@ -1757,7 +1757,7 @@ static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
>  	if (sample_type & PERF_SAMPLE_REGS_INTR &&
>  	    items->mask[INTEL_PT_GP_REGS_POS]) {
>  		u64 regs[sizeof(sample.intr_regs.mask)];
> -		u64 regs_mask = evsel->attr.sample_regs_intr;
> +		u64 regs_mask = evsel->core.attr.sample_regs_intr;
>  		u64 *pos;
>  
>  		sample.intr_regs.abi = items->is_32_bit ?
> @@ -2734,7 +2734,7 @@ static struct evsel *intel_pt_evsel(struct intel_pt *pt,
>  	struct evsel *evsel;
>  
>  	evlist__for_each_entry(evlist, evsel) {
> -		if (evsel->attr.type == pt->pmu_type && evsel->ids)
> +		if (evsel->core.attr.type == pt->pmu_type && evsel->ids)
>  			return evsel;
>  	}
>  
> @@ -2758,7 +2758,7 @@ static int intel_pt_synth_events(struct intel_pt *pt,
>  	memset(&attr, 0, sizeof(struct perf_event_attr));
>  	attr.size = sizeof(struct perf_event_attr);
>  	attr.type = PERF_TYPE_HARDWARE;
> -	attr.sample_type = evsel->attr.sample_type & PERF_SAMPLE_MASK;
> +	attr.sample_type = evsel->core.attr.sample_type & PERF_SAMPLE_MASK;
>  	attr.sample_type |= PERF_SAMPLE_IP | PERF_SAMPLE_TID |
>  			    PERF_SAMPLE_PERIOD;
>  	if (pt->timeless_decoding)
> @@ -2767,13 +2767,13 @@ static int intel_pt_synth_events(struct intel_pt *pt,
>  		attr.sample_type |= PERF_SAMPLE_TIME;
>  	if (!pt->per_cpu_mmaps)
>  		attr.sample_type &= ~(u64)PERF_SAMPLE_CPU;
> -	attr.exclude_user = evsel->attr.exclude_user;
> -	attr.exclude_kernel = evsel->attr.exclude_kernel;
> -	attr.exclude_hv = evsel->attr.exclude_hv;
> -	attr.exclude_host = evsel->attr.exclude_host;
> -	attr.exclude_guest = evsel->attr.exclude_guest;
> -	attr.sample_id_all = evsel->attr.sample_id_all;
> -	attr.read_format = evsel->attr.read_format;
> +	attr.exclude_user = evsel->core.attr.exclude_user;
> +	attr.exclude_kernel = evsel->core.attr.exclude_kernel;
> +	attr.exclude_hv = evsel->core.attr.exclude_hv;
> +	attr.exclude_host = evsel->core.attr.exclude_host;
> +	attr.exclude_guest = evsel->core.attr.exclude_guest;
> +	attr.sample_id_all = evsel->core.attr.sample_id_all;
> +	attr.read_format = evsel->core.attr.read_format;
>  
>  	id = evsel->id[0] + 1000000000;
>  	if (!id)
> @@ -2857,7 +2857,7 @@ static int intel_pt_synth_events(struct intel_pt *pt,
>  		id += 1;
>  	}
>  
> -	if (pt->synth_opts.pwr_events && (evsel->attr.config & 0x10)) {
> +	if (pt->synth_opts.pwr_events && (evsel->core.attr.config & 0x10)) {
>  		attr.config = PERF_SYNTH_INTEL_MWAIT;
>  		err = intel_pt_synth_event(session, "mwait", &attr, id);
>  		if (err)
> @@ -2913,7 +2913,7 @@ static bool intel_pt_find_switch(struct evlist *evlist)
>  	struct evsel *evsel;
>  
>  	evlist__for_each_entry(evlist, evsel) {
> -		if (evsel->attr.context_switch)
> +		if (evsel->core.attr.context_switch)
>  			return true;
>  	}
>  
> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index 8df60703411a..bbeac4f66402 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c
> @@ -124,7 +124,7 @@ jit_validate_events(struct perf_session *session)
>  	 * check that all events use CLOCK_MONOTONIC
>  	 */
>  	evlist__for_each_entry(session->evlist, evsel) {
> -		if (evsel->attr.use_clockid == 0 || evsel->attr.clockid != CLOCK_MONOTONIC)
> +		if (evsel->core.attr.use_clockid == 0 || evsel->core.attr.clockid != CLOCK_MONOTONIC)
>  			return -1;
>  	}
>  	return 0;
> @@ -779,7 +779,7 @@ jit_process(struct perf_session *session,
>  	 * perf sets the same sample type to all events as of now
>  	 */
>  	first = perf_evlist__first(session->evlist);
> -	jd.sample_type = first->attr.sample_type;
> +	jd.sample_type = first->core.attr.sample_type;
>  
>  	*nbytes = 0;
>  
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index ec0675b0caa8..f6ee7fbad3e4 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -2498,8 +2498,8 @@ static int thread__resolve_callchain_unwind(struct thread *thread,
>  					    int max_stack)
>  {
>  	/* Can we do dwarf post unwind? */
> -	if (!((evsel->attr.sample_type & PERF_SAMPLE_REGS_USER) &&
> -	      (evsel->attr.sample_type & PERF_SAMPLE_STACK_USER)))
> +	if (!((evsel->core.attr.sample_type & PERF_SAMPLE_REGS_USER) &&
> +	      (evsel->core.attr.sample_type & PERF_SAMPLE_STACK_USER)))
>  		return 0;
>  
>  	/* Bail out if nothing was captured. */
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 10efc33c56a1..ec7ce18b999a 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1590,16 +1590,16 @@ struct event_modifier {
>  static int get_event_modifier(struct event_modifier *mod, char *str,
>  			       struct evsel *evsel)
>  {
> -	int eu = evsel ? evsel->attr.exclude_user : 0;
> -	int ek = evsel ? evsel->attr.exclude_kernel : 0;
> -	int eh = evsel ? evsel->attr.exclude_hv : 0;
> -	int eH = evsel ? evsel->attr.exclude_host : 0;
> -	int eG = evsel ? evsel->attr.exclude_guest : 0;
> -	int eI = evsel ? evsel->attr.exclude_idle : 0;
> -	int precise = evsel ? evsel->attr.precise_ip : 0;
> +	int eu = evsel ? evsel->core.attr.exclude_user : 0;
> +	int ek = evsel ? evsel->core.attr.exclude_kernel : 0;
> +	int eh = evsel ? evsel->core.attr.exclude_hv : 0;
> +	int eH = evsel ? evsel->core.attr.exclude_host : 0;
> +	int eG = evsel ? evsel->core.attr.exclude_guest : 0;
> +	int eI = evsel ? evsel->core.attr.exclude_idle : 0;
> +	int precise = evsel ? evsel->core.attr.precise_ip : 0;
>  	int precise_max = 0;
>  	int sample_read = 0;
> -	int pinned = evsel ? evsel->attr.pinned : 0;
> +	int pinned = evsel ? evsel->core.attr.pinned : 0;
>  
>  	int exclude = eu | ek | eh;
>  	int exclude_GH = evsel ? evsel->exclude_GH : 0;
> @@ -1717,20 +1717,20 @@ int parse_events__modifier_event(struct list_head *list, char *str, bool add)
>  		if (add && get_event_modifier(&mod, str, evsel))
>  			return -EINVAL;
>  
> -		evsel->attr.exclude_user   = mod.eu;
> -		evsel->attr.exclude_kernel = mod.ek;
> -		evsel->attr.exclude_hv     = mod.eh;
> -		evsel->attr.precise_ip     = mod.precise;
> -		evsel->attr.exclude_host   = mod.eH;
> -		evsel->attr.exclude_guest  = mod.eG;
> -		evsel->attr.exclude_idle   = mod.eI;
> +		evsel->core.attr.exclude_user   = mod.eu;
> +		evsel->core.attr.exclude_kernel = mod.ek;
> +		evsel->core.attr.exclude_hv     = mod.eh;
> +		evsel->core.attr.precise_ip     = mod.precise;
> +		evsel->core.attr.exclude_host   = mod.eH;
> +		evsel->core.attr.exclude_guest  = mod.eG;
> +		evsel->core.attr.exclude_idle   = mod.eI;
>  		evsel->exclude_GH          = mod.exclude_GH;
>  		evsel->sample_read         = mod.sample_read;
>  		evsel->precise_max         = mod.precise_max;
>  		evsel->weak_group	   = mod.weak;
>  
>  		if (perf_evsel__is_group_leader(evsel))
> -			evsel->attr.pinned = mod.pinned;
> +			evsel->core.attr.pinned = mod.pinned;
>  	}
>  
>  	return 0;
> @@ -2071,7 +2071,7 @@ static int set_filter(struct evsel *evsel, const void *arg)
>  		return -1;
>  	}
>  
> -	if (evsel->attr.type == PERF_TYPE_TRACEPOINT) {
> +	if (evsel->core.attr.type == PERF_TYPE_TRACEPOINT) {
>  		if (perf_evsel__append_tp_filter(evsel, str) < 0) {
>  			fprintf(stderr,
>  				"not enough memory to hold filter string\n");
> @@ -2082,7 +2082,7 @@ static int set_filter(struct evsel *evsel, const void *arg)
>  	}
>  
>  	while ((pmu = perf_pmu__scan(pmu)) != NULL)
> -		if (pmu->type == evsel->attr.type) {
> +		if (pmu->type == evsel->core.attr.type) {
>  			found = true;
>  			break;
>  		}
> @@ -2120,7 +2120,7 @@ static int add_exclude_perf_filter(struct evsel *evsel,
>  {
>  	char new_filter[64];
>  
> -	if (evsel == NULL || evsel->attr.type != PERF_TYPE_TRACEPOINT) {
> +	if (evsel == NULL || evsel->core.attr.type != PERF_TYPE_TRACEPOINT) {
>  		fprintf(stderr,
>  			"--exclude-perf option should follow a -e tracepoint option\n");
>  		return -1;
> @@ -2331,7 +2331,7 @@ static bool is_event_supported(u8 type, unsigned config)
>  			 * by default as some ARM machines do not support it.
>  			 *
>  			 */
> -			evsel->attr.exclude_kernel = 1;
> +			evsel->core.attr.exclude_kernel = 1;
>  			ret = evsel__open(evsel, NULL, tmap) >= 0;
>  		}
>  		evsel__delete(evsel);
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index cf0a18d49018..23a4fa13b92d 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -337,7 +337,7 @@ static PyObject *pyrf_sample_event__repr(struct pyrf_event *pevent)
>  
>  static bool is_tracepoint(struct pyrf_event *pevent)
>  {
> -	return pevent->evsel->attr.type == PERF_TYPE_TRACEPOINT;
> +	return pevent->evsel->core.attr.type == PERF_TYPE_TRACEPOINT;
>  }
>  
>  static PyObject*
> @@ -389,7 +389,7 @@ get_tracepoint_field(struct pyrf_event *pevent, PyObject *attr_name)
>  	if (!evsel->tp_format) {
>  		struct tep_event *tp_format;
>  
> -		tp_format = trace_event__tp_format_id(evsel->attr.config);
> +		tp_format = trace_event__tp_format_id(evsel->core.attr.config);
>  		if (!tp_format)
>  			return NULL;
>  
> @@ -812,7 +812,7 @@ static PyObject *pyrf_evsel__open(struct pyrf_evsel *pevsel,
>  	if (pcpus != NULL)
>  		cpus = ((struct pyrf_cpu_map *)pcpus)->cpus;
>  
> -	evsel->attr.inherit = inherit;
> +	evsel->core.attr.inherit = inherit;
>  	/*
>  	 * This will group just the fds for this single evsel, to group
>  	 * multiple events, use evlist.open().
> diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
> index 3d3d732498e1..445788819969 100644
> --- a/tools/perf/util/record.c
> +++ b/tools/perf/util/record.c
> @@ -29,7 +29,7 @@ static int perf_do_probe_api(setup_probe_fn_t fn, int cpu, const char *str)
>  	evsel = perf_evlist__first(evlist);
>  
>  	while (1) {
> -		fd = sys_perf_event_open(&evsel->attr, pid, cpu, -1, flags);
> +		fd = sys_perf_event_open(&evsel->core.attr, pid, cpu, -1, flags);
>  		if (fd < 0) {
>  			if (pid == -1 && errno == EACCES) {
>  				pid = 0;
> @@ -43,7 +43,7 @@ static int perf_do_probe_api(setup_probe_fn_t fn, int cpu, const char *str)
>  
>  	fn(evsel);
>  
> -	fd = sys_perf_event_open(&evsel->attr, pid, cpu, -1, flags);
> +	fd = sys_perf_event_open(&evsel->core.attr, pid, cpu, -1, flags);
>  	if (fd < 0) {
>  		if (errno == EINVAL)
>  			err = -EINVAL;
> @@ -80,17 +80,17 @@ static bool perf_probe_api(setup_probe_fn_t fn)
>  
>  static void perf_probe_sample_identifier(struct evsel *evsel)
>  {
> -	evsel->attr.sample_type |= PERF_SAMPLE_IDENTIFIER;
> +	evsel->core.attr.sample_type |= PERF_SAMPLE_IDENTIFIER;
>  }
>  
>  static void perf_probe_comm_exec(struct evsel *evsel)
>  {
> -	evsel->attr.comm_exec = 1;
> +	evsel->core.attr.comm_exec = 1;
>  }
>  
>  static void perf_probe_context_switch(struct evsel *evsel)
>  {
> -	evsel->attr.context_switch = 1;
> +	evsel->core.attr.context_switch = 1;
>  }
>  
>  bool perf_can_sample_identifier(void)
> @@ -155,7 +155,7 @@ void perf_evlist__config(struct evlist *evlist, struct record_opts *opts,
>  	evlist__for_each_entry(evlist, evsel) {
>  		perf_evsel__config(evsel, opts, callchain);
>  		if (evsel->tracking && use_comm_exec)
> -			evsel->attr.comm_exec = 1;
> +			evsel->core.attr.comm_exec = 1;
>  	}
>  
>  	if (opts->full_auxtrace) {
> @@ -170,7 +170,7 @@ void perf_evlist__config(struct evlist *evlist, struct record_opts *opts,
>  		struct evsel *first = perf_evlist__first(evlist);
>  
>  		evlist__for_each_entry(evlist, evsel) {
> -			if (evsel->attr.sample_type == first->attr.sample_type)
> +			if (evsel->core.attr.sample_type == first->core.attr.sample_type)
>  				continue;
>  			use_sample_identifier = perf_can_sample_identifier();
>  			break;
> @@ -284,7 +284,7 @@ bool perf_evlist__can_select_event(struct evlist *evlist, const char *str)
>  	}
>  
>  	while (1) {
> -		fd = sys_perf_event_open(&evsel->attr, pid, cpu, -1,
> +		fd = sys_perf_event_open(&evsel->core.attr, pid, cpu, -1,
>  					 perf_event_open_cloexec_flag());
>  		if (fd < 0) {
>  			if (pid == -1 && errno == EACCES) {
> diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
> index 59d78a9fe703..d078ae8353c8 100644
> --- a/tools/perf/util/s390-cpumsf.c
> +++ b/tools/perf/util/s390-cpumsf.c
> @@ -935,7 +935,7 @@ s390_cpumsf_process_event(struct perf_session *session,
>  		/* Handle event with raw data */
>  		ev_bc000 = perf_evlist__event2evsel(session->evlist, event);
>  		if (ev_bc000 &&
> -		    ev_bc000->attr.config == PERF_EVENT_CPUM_CF_DIAG)
> +		    ev_bc000->core.attr.config == PERF_EVENT_CPUM_CF_DIAG)
>  			err = s390_cpumcf_dumpctr(sf, sample);
>  		return err;
>  	}
> diff --git a/tools/perf/util/s390-sample-raw.c b/tools/perf/util/s390-sample-raw.c
> index 6c709647cd8e..d311c81464e5 100644
> --- a/tools/perf/util/s390-sample-raw.c
> +++ b/tools/perf/util/s390-sample-raw.c
> @@ -210,7 +210,7 @@ void perf_evlist__s390_sample_raw(struct evlist *evlist, union perf_event *event
>  
>  	ev_bc000 = perf_evlist__event2evsel(evlist, event);
>  	if (ev_bc000 == NULL ||
> -	    ev_bc000->attr.config != PERF_EVENT_CPUM_CF_DIAG)
> +	    ev_bc000->core.attr.config != PERF_EVENT_CPUM_CF_DIAG)
>  		return;
>  
>  	/* Display raw data on screen */
> diff --git a/tools/perf/util/scripting-engines/trace-event-perl.c b/tools/perf/util/scripting-engines/trace-event-perl.c
> index 98dcdb9a79a4..01ebf10b8bf4 100644
> --- a/tools/perf/util/scripting-engines/trace-event-perl.c
> +++ b/tools/perf/util/scripting-engines/trace-event-perl.c
> @@ -353,11 +353,11 @@ static void perl_process_tracepoint(struct perf_sample *sample,
>  
>  	dSP;
>  
> -	if (evsel->attr.type != PERF_TYPE_TRACEPOINT)
> +	if (evsel->core.attr.type != PERF_TYPE_TRACEPOINT)
>  		return;
>  
>  	if (!event) {
> -		pr_debug("ug! no event found for type %" PRIu64, (u64)evsel->attr.config);
> +		pr_debug("ug! no event found for type %" PRIu64, (u64)evsel->core.attr.config);
>  		return;
>  	}
>  
> @@ -442,7 +442,7 @@ static void perl_process_event_generic(union perf_event *event,
>  	SAVETMPS;
>  	PUSHMARK(SP);
>  	XPUSHs(sv_2mortal(newSVpvn((const char *)event, event->header.size)));
> -	XPUSHs(sv_2mortal(newSVpvn((const char *)&evsel->attr, sizeof(evsel->attr))));
> +	XPUSHs(sv_2mortal(newSVpvn((const char *)&evsel->core.attr, sizeof(evsel->core.attr))));
>  	XPUSHs(sv_2mortal(newSVpvn((const char *)sample, sizeof(*sample))));
>  	XPUSHs(sv_2mortal(newSVpvn((const char *)sample->raw_data, sample->raw_size)));
>  	PUTBACK;
> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
> index 106aec31c07c..78b40c1d688e 100644
> --- a/tools/perf/util/scripting-engines/trace-event-python.c
> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> @@ -636,7 +636,7 @@ static void set_sample_read_in_dict(PyObject *dict_sample,
>  					 struct perf_sample *sample,
>  					 struct evsel *evsel)
>  {
> -	u64 read_format = evsel->attr.read_format;
> +	u64 read_format = evsel->core.attr.read_format;
>  	PyObject *values;
>  	unsigned int i;
>  
> @@ -707,7 +707,7 @@ static void set_regs_in_dict(PyObject *dict,
>  			     struct perf_sample *sample,
>  			     struct evsel *evsel)
>  {
> -	struct perf_event_attr *attr = &evsel->attr;
> +	struct perf_event_attr *attr = &evsel->core.attr;
>  	char bf[512];
>  
>  	regs_map(&sample->intr_regs, attr->sample_regs_intr, bf, sizeof(bf));
> @@ -737,7 +737,7 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
>  		Py_FatalError("couldn't create Python dictionary");
>  
>  	pydict_set_item_string_decref(dict, "ev_name", _PyUnicode_FromString(perf_evsel__name(evsel)));
> -	pydict_set_item_string_decref(dict, "attr", _PyBytes_FromStringAndSize((const char *)&evsel->attr, sizeof(evsel->attr)));
> +	pydict_set_item_string_decref(dict, "attr", _PyBytes_FromStringAndSize((const char *)&evsel->core.attr, sizeof(evsel->core.attr)));
>  
>  	pydict_set_item_string_decref(dict_sample, "pid",
>  			_PyLong_FromLong(sample->pid));
> @@ -809,7 +809,7 @@ static void python_process_tracepoint(struct perf_sample *sample,
>  
>  	if (!event) {
>  		snprintf(handler_name, sizeof(handler_name),
> -			 "ug! no event found for type %" PRIu64, (u64)evsel->attr.config);
> +			 "ug! no event found for type %" PRIu64, (u64)evsel->core.attr.config);
>  		Py_FatalError(handler_name);
>  	}
>  
> @@ -1163,7 +1163,7 @@ static void python_export_synth(struct db_export *dbe, struct export_sample *es)
>  	t = tuple_new(3);
>  
>  	tuple_set_u64(t, 0, es->db_id);
> -	tuple_set_u64(t, 1, es->evsel->attr.config);
> +	tuple_set_u64(t, 1, es->evsel->core.attr.config);
>  	tuple_set_bytes(t, 2, es->sample->raw_data, es->sample->raw_size);
>  
>  	call_object(tables->synth_handler, t, "synth_data");
> @@ -1178,7 +1178,7 @@ static int python_export_sample(struct db_export *dbe,
>  
>  	python_export_sample_table(dbe, es);
>  
> -	if (es->evsel->attr.type == PERF_TYPE_SYNTH && tables->synth_handler)
> +	if (es->evsel->core.attr.type == PERF_TYPE_SYNTH && tables->synth_handler)
>  		python_export_synth(dbe, es);
>  
>  	return 0;
> @@ -1316,7 +1316,7 @@ static void python_process_event(union perf_event *event,
>  {
>  	struct tables *tables = &tables_global;
>  
> -	switch (evsel->attr.type) {
> +	switch (evsel->core.attr.type) {
>  	case PERF_TYPE_TRACEPOINT:
>  		python_process_tracepoint(sample, evsel, al);
>  		break;
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 62d37440cbee..1f3dc7a8cee6 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -154,7 +154,7 @@ static bool perf_session__has_comm_exec(struct perf_session *session)
>  	struct evsel *evsel;
>  
>  	evlist__for_each_entry(session->evlist, evsel) {
> -		if (evsel->attr.comm_exec)
> +		if (evsel->core.attr.comm_exec)
>  			return true;
>  	}
>  
> @@ -1210,7 +1210,7 @@ static void dump_sample(struct evsel *evsel, union perf_event *event,
>  	       event->header.misc, sample->pid, sample->tid, sample->ip,
>  	       sample->period, sample->addr);
>  
> -	sample_type = evsel->attr.sample_type;
> +	sample_type = evsel->core.attr.sample_type;
>  
>  	if (evsel__has_callchain(evsel))
>  		callchain__printf(evsel, sample);
> @@ -1240,7 +1240,7 @@ static void dump_sample(struct evsel *evsel, union perf_event *event,
>  		printf("... transaction: %" PRIx64 "\n", sample->transaction);
>  
>  	if (sample_type & PERF_SAMPLE_READ)
> -		sample_read__printf(sample, evsel->attr.read_format);
> +		sample_read__printf(sample, evsel->core.attr.read_format);
>  }
>  
>  static void dump_read(struct evsel *evsel, union perf_event *event)
> @@ -1258,7 +1258,7 @@ static void dump_read(struct evsel *evsel, union perf_event *event)
>  	if (!evsel)
>  		return;
>  
> -	read_format = evsel->attr.read_format;
> +	read_format = evsel->core.attr.read_format;
>  
>  	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
>  		printf("... time enabled : %" PRIu64 "\n", read_event->time_enabled);
> @@ -1355,8 +1355,8 @@ static int
>  			     struct machine *machine)
>  {
>  	/* We know evsel != NULL. */
> -	u64 sample_type = evsel->attr.sample_type;
> -	u64 read_format = evsel->attr.read_format;
> +	u64 sample_type = evsel->core.attr.sample_type;
> +	u64 read_format = evsel->core.attr.read_format;
>  
>  	/* Standard sample delivery. */
>  	if (!(sample_type & PERF_SAMPLE_READ))
> @@ -1709,7 +1709,7 @@ perf_session__warn_order(const struct perf_session *session)
>  	bool should_warn = true;
>  
>  	evlist__for_each_entry(session->evlist, evsel) {
> -		if (evsel->attr.write_backward)
> +		if (evsel->core.attr.write_backward)
>  			should_warn = false;
>  	}
>  
> @@ -2186,7 +2186,7 @@ bool perf_session__has_traces(struct perf_session *session, const char *msg)
>  	struct evsel *evsel;
>  
>  	evlist__for_each_entry(session->evlist, evsel) {
> -		if (evsel->attr.type == PERF_TYPE_TRACEPOINT)
> +		if (evsel->core.attr.type == PERF_TYPE_TRACEPOINT)
>  			return true;
>  	}
>  
> @@ -2263,7 +2263,7 @@ struct evsel *perf_session__find_first_evtype(struct perf_session *session,
>  	struct evsel *pos;
>  
>  	evlist__for_each_entry(session->evlist, pos) {
> -		if (pos->attr.type == type)
> +		if (pos->core.attr.type == type)
>  			return pos;
>  	}
>  	return NULL;
> @@ -2282,7 +2282,7 @@ int perf_session__cpu_bitmap(struct perf_session *session,
>  		if (!evsel)
>  			continue;
>  
> -		if (!(evsel->attr.sample_type & PERF_SAMPLE_CPU)) {
> +		if (!(evsel->core.attr.sample_type & PERF_SAMPLE_CPU)) {
>  			pr_err("File does not contain CPU events. "
>  			       "Remove -C option to proceed.\n");
>  			return -1;
> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index fa3cc2112b82..f9a38a1dd4d1 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c
> @@ -726,7 +726,7 @@ sort__trace_cmp(struct hist_entry *left, struct hist_entry *right)
>  	struct evsel *evsel;
>  
>  	evsel = hists_to_evsel(left->hists);
> -	if (evsel->attr.type != PERF_TYPE_TRACEPOINT)
> +	if (evsel->core.attr.type != PERF_TYPE_TRACEPOINT)
>  		return 0;
>  
>  	if (left->trace_output == NULL)
> @@ -743,7 +743,7 @@ static int hist_entry__trace_snprintf(struct hist_entry *he, char *bf,
>  	struct evsel *evsel;
>  
>  	evsel = hists_to_evsel(he->hists);
> -	if (evsel->attr.type != PERF_TYPE_TRACEPOINT)
> +	if (evsel->core.attr.type != PERF_TYPE_TRACEPOINT)
>  		return scnprintf(bf, size, "%-.*s", width, "N/A");
>  
>  	if (he->trace_output == NULL)
> @@ -2391,7 +2391,7 @@ static int add_all_dynamic_fields(struct evlist *evlist, bool raw_trace,
>  	struct evsel *evsel;
>  
>  	evlist__for_each_entry(evlist, evsel) {
> -		if (evsel->attr.type != PERF_TYPE_TRACEPOINT)
> +		if (evsel->core.attr.type != PERF_TYPE_TRACEPOINT)
>  			continue;
>  
>  		ret = add_evsel_fields(evsel, raw_trace, level);
> @@ -2409,7 +2409,7 @@ static int add_all_matching_fields(struct evlist *evlist,
>  	struct tep_format_field *field;
>  
>  	evlist__for_each_entry(evlist, evsel) {
> -		if (evsel->attr.type != PERF_TYPE_TRACEPOINT)
> +		if (evsel->core.attr.type != PERF_TYPE_TRACEPOINT)
>  			continue;
>  
>  		field = tep_find_any_field(evsel->tp_format, field_name);
> @@ -2470,7 +2470,7 @@ static int add_dynamic_entry(struct evlist *evlist, const char *tok,
>  		goto out;
>  	}
>  
> -	if (evsel->attr.type != PERF_TYPE_TRACEPOINT) {
> +	if (evsel->core.attr.type != PERF_TYPE_TRACEPOINT) {
>  		pr_debug("%s is not a tracepoint event\n", event_name);
>  		ret = -EINVAL;
>  		goto out;
> @@ -2728,7 +2728,7 @@ static const char *get_default_sort_order(struct evlist *evlist)
>  		goto out_no_evlist;
>  
>  	evlist__for_each_entry(evlist, evsel) {
> -		if (evsel->attr.type != PERF_TYPE_TRACEPOINT) {
> +		if (evsel->core.attr.type != PERF_TYPE_TRACEPOINT) {
>  			use_trace = false;
>  			break;
>  		}
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index b1a2571f7c8f..99bda99a1b2d 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -366,7 +366,7 @@ static void abs_printout(struct perf_stat_config *config,
>  static bool is_mixed_hw_group(struct evsel *counter)
>  {
>  	struct evlist *evlist = counter->evlist;
> -	u32 pmu_type = counter->attr.type;
> +	u32 pmu_type = counter->core.attr.type;
>  	struct evsel *pos;
>  
>  	if (counter->nr_members < 2)
> @@ -374,13 +374,13 @@ static bool is_mixed_hw_group(struct evsel *counter)
>  
>  	evlist__for_each_entry(evlist, pos) {
>  		/* software events can be part of any hardware group */
> -		if (pos->attr.type == PERF_TYPE_SOFTWARE)
> +		if (pos->core.attr.type == PERF_TYPE_SOFTWARE)
>  			continue;
>  		if (pmu_type == PERF_TYPE_SOFTWARE) {
> -			pmu_type = pos->attr.type;
> +			pmu_type = pos->core.attr.type;
>  			continue;
>  		}
> -		if (pmu_type != pos->attr.type)
> +		if (pmu_type != pos->core.attr.type)
>  			return true;
>  	}
>  
> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
> index d81bcab2e64c..2ed5e0066c70 100644
> --- a/tools/perf/util/stat-shadow.c
> +++ b/tools/perf/util/stat-shadow.c
> @@ -150,15 +150,15 @@ static int evsel_context(struct evsel *evsel)
>  {
>  	int ctx = 0;
>  
> -	if (evsel->attr.exclude_kernel)
> +	if (evsel->core.attr.exclude_kernel)
>  		ctx |= CTX_BIT_KERNEL;
> -	if (evsel->attr.exclude_user)
> +	if (evsel->core.attr.exclude_user)
>  		ctx |= CTX_BIT_USER;
> -	if (evsel->attr.exclude_hv)
> +	if (evsel->core.attr.exclude_hv)
>  		ctx |= CTX_BIT_HV;
> -	if (evsel->attr.exclude_host)
> +	if (evsel->core.attr.exclude_host)
>  		ctx |= CTX_BIT_HOST;
> -	if (evsel->attr.exclude_idle)
> +	if (evsel->core.attr.exclude_idle)
>  		ctx |= CTX_BIT_IDLE;
>  
>  	return ctx;
> @@ -829,8 +829,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>  		else
>  			print_metric(config, ctxp, NULL, NULL, "of all branches", 0);
>  	} else if (
> -		evsel->attr.type == PERF_TYPE_HW_CACHE &&
> -		evsel->attr.config ==  ( PERF_COUNT_HW_CACHE_L1D |
> +		evsel->core.attr.type == PERF_TYPE_HW_CACHE &&
> +		evsel->core.attr.config ==  ( PERF_COUNT_HW_CACHE_L1D |
>  					((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
>  					 ((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16))) {
>  
> @@ -839,8 +839,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>  		else
>  			print_metric(config, ctxp, NULL, NULL, "of all L1-dcache hits", 0);
>  	} else if (
> -		evsel->attr.type == PERF_TYPE_HW_CACHE &&
> -		evsel->attr.config ==  ( PERF_COUNT_HW_CACHE_L1I |
> +		evsel->core.attr.type == PERF_TYPE_HW_CACHE &&
> +		evsel->core.attr.config ==  ( PERF_COUNT_HW_CACHE_L1I |
>  					((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
>  					 ((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16))) {
>  
> @@ -849,8 +849,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>  		else
>  			print_metric(config, ctxp, NULL, NULL, "of all L1-icache hits", 0);
>  	} else if (
> -		evsel->attr.type == PERF_TYPE_HW_CACHE &&
> -		evsel->attr.config ==  ( PERF_COUNT_HW_CACHE_DTLB |
> +		evsel->core.attr.type == PERF_TYPE_HW_CACHE &&
> +		evsel->core.attr.config ==  ( PERF_COUNT_HW_CACHE_DTLB |
>  					((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
>  					 ((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16))) {
>  
> @@ -859,8 +859,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>  		else
>  			print_metric(config, ctxp, NULL, NULL, "of all dTLB cache hits", 0);
>  	} else if (
> -		evsel->attr.type == PERF_TYPE_HW_CACHE &&
> -		evsel->attr.config ==  ( PERF_COUNT_HW_CACHE_ITLB |
> +		evsel->core.attr.type == PERF_TYPE_HW_CACHE &&
> +		evsel->core.attr.config ==  ( PERF_COUNT_HW_CACHE_ITLB |
>  					((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
>  					 ((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16))) {
>  
> @@ -869,8 +869,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>  		else
>  			print_metric(config, ctxp, NULL, NULL, "of all iTLB cache hits", 0);
>  	} else if (
> -		evsel->attr.type == PERF_TYPE_HW_CACHE &&
> -		evsel->attr.config ==  ( PERF_COUNT_HW_CACHE_LL |
> +		evsel->core.attr.type == PERF_TYPE_HW_CACHE &&
> +		evsel->core.attr.config ==  ( PERF_COUNT_HW_CACHE_LL |
>  					((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
>  					 ((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16))) {
>  
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index 63f7815ceb4f..632bf72cf780 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -441,7 +441,7 @@ int create_perf_stat_counter(struct evsel *evsel,
>  			     struct perf_stat_config *config,
>  			     struct target *target)
>  {
> -	struct perf_event_attr *attr = &evsel->attr;
> +	struct perf_event_attr *attr = &evsel->core.attr;
>  	struct evsel *leader = evsel->leader;
>  
>  	attr->read_format = PERF_FORMAT_TOTAL_TIME_ENABLED |
> diff --git a/tools/perf/util/top.c b/tools/perf/util/top.c
> index 3bbbdac2c550..f533f1aac045 100644
> --- a/tools/perf/util/top.c
> +++ b/tools/perf/util/top.c
> @@ -73,7 +73,7 @@ size_t perf_top__header_snprintf(struct perf_top *top, char *bf, size_t size)
>  	if (top->evlist->core.nr_entries == 1) {
>  		struct evsel *first = perf_evlist__first(top->evlist);
>  		ret += SNPRINTF(bf + ret, size - ret, "%" PRIu64 "%s ",
> -				(uint64_t)first->attr.sample_period,
> +				(uint64_t)first->core.attr.sample_period,
>  				opts->freq ? "Hz" : "");
>  	}
>  
> diff --git a/tools/perf/util/trace-event-info.c b/tools/perf/util/trace-event-info.c
> index 7efdbb182ea1..2f8a0601a546 100644
> --- a/tools/perf/util/trace-event-info.c
> +++ b/tools/perf/util/trace-event-info.c
> @@ -409,7 +409,7 @@ get_tracepoints_path(struct list_head *pattrs)
>  	int nr_tracepoints = 0;
>  
>  	list_for_each_entry(pos, pattrs, core.node) {
> -		if (pos->attr.type != PERF_TYPE_TRACEPOINT)
> +		if (pos->core.attr.type != PERF_TYPE_TRACEPOINT)
>  			continue;
>  		++nr_tracepoints;
>  
> @@ -425,7 +425,7 @@ get_tracepoints_path(struct list_head *pattrs)
>  		}
>  
>  try_id:
> -		ppath->next = tracepoint_id_to_path(pos->attr.config);
> +		ppath->next = tracepoint_id_to_path(pos->core.attr.config);
>  		if (!ppath->next) {
>  error:
>  			pr_debug("No memory to alloc tracepoints list\n");
> @@ -444,7 +444,7 @@ bool have_tracepoints(struct list_head *pattrs)
>  	struct evsel *pos;
>  
>  	list_for_each_entry(pos, pattrs, core.node)
> -		if (pos->attr.type == PERF_TYPE_TRACEPOINT)
> +		if (pos->core.attr.type == PERF_TYPE_TRACEPOINT)
>  			return true;
>  
>  	return false;
> -- 
> 2.21.0

-- 

- Arnaldo
