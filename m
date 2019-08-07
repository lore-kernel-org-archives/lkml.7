Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3558C19759
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 07:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6971217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 07:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbfHGHlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 03:41:47 -0400
Received: from mga04.intel.com ([192.55.52.120]:24656 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727190AbfHGHlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 03:41:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2019 00:41:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,356,1559545200"; 
   d="scan'208";a="203093384"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.122]) ([10.237.72.122])
  by fmsmga002.fm.intel.com with ESMTP; 07 Aug 2019 00:41:45 -0700
Subject: Re: [PATCH v1] perf record: Add an option to take an AUX snapshot on
 exit
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
References: <20190806144101.62892-1-alexander.shishkin@linux.intel.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <0541bee6-7bdf-2dbc-998d-5df3ddf18208@intel.com>
Date:   Wed, 7 Aug 2019 10:40:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190806144101.62892-1-alexander.shishkin@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/08/19 5:41 PM, Alexander Shishkin wrote:
> It is sometimes useful to generate a snapshot when perf record exits;
> I've been using a wrapper script around the workload that would do a
> killall -USR2 perf when the workload exits.
> 
> This patch makes it easier and also works when perf record is attached
> to a pre-existing task. A new snapshot option 'e' can be specified in
> -S to enable this behavior:
> 
> root@elsewhere:~# perf record -e intel_pt// -Se sleep 1
> [ perf record: Woken up 2 times to write data ]
> [ perf record: Captured and wrote 0.085 MB perf.data ]
> 
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Co-developed-by: Adrian Hunter <adrian.hunter@intel.com>

checkpatch says:
WARNING: Co-developed-by: must be immediately followed by Signed-off-by

> ---
>  tools/perf/Documentation/perf-record.txt | 11 +++++---
>  tools/perf/builtin-record.c              | 34 +++++++++++++++++++++---
>  tools/perf/perf.h                        |  1 +
>  tools/perf/util/auxtrace.c               | 14 ++++++++--
>  tools/perf/util/auxtrace.h               |  2 +-
>  5 files changed, 52 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> index 15e0fa87241b..d5e58e0a2bca 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -422,9 +422,14 @@ CLOCK_BOOTTIME, CLOCK_REALTIME and CLOCK_TAI.
>  -S::
>  --snapshot::
>  Select AUX area tracing Snapshot Mode. This option is valid only with an
> -AUX area tracing event. Optionally the number of bytes to capture per
> -snapshot can be specified. In Snapshot Mode, trace data is captured only when
> -signal SIGUSR2 is received.
> +AUX area tracing event. Optionally, certain snapshot capturing parameters
> +can be specified in a string that follows this option:
> +  'e': take one last snapshot on exit; guarantees that there is at least one
> +       snapshot in the output file;
> +  <size>: if the PMU supports this, specify the desired snapshot size.
> +
> +In Snapshot Mode trace data is captured only when signal SIGUSR2 is received
> +and on exit if the above 'e' option is given.
>  
>  --proc-map-timeout::
>  When processing pre-existing threads /proc/XXX/mmap, it may take a long time,
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index d31d7a5a1be3..e9a2525ecfcc 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -613,19 +613,35 @@ static int record__auxtrace_read_snapshot_all(struct record *rec)
>  	return rc;
>  }
>  
> -static void record__read_auxtrace_snapshot(struct record *rec)
> +static void record__read_auxtrace_snapshot(struct record *rec, bool on_exit)
>  {
>  	pr_debug("Recording AUX area tracing snapshot\n");
>  	if (record__auxtrace_read_snapshot_all(rec) < 0) {
>  		trigger_error(&auxtrace_snapshot_trigger);
>  	} else {
> -		if (auxtrace_record__snapshot_finish(rec->itr))
> +		if (auxtrace_record__snapshot_finish(rec->itr, on_exit))
>  			trigger_error(&auxtrace_snapshot_trigger);
>  		else
>  			trigger_ready(&auxtrace_snapshot_trigger);
>  	}
>  }
>  
> +static int record__auxtrace_snapshot_exit(struct record *rec)
> +{
> +	if (trigger_is_error(&auxtrace_snapshot_trigger))
> +		return 0;
> +
> +	if (!auxtrace_record__snapshot_started &&
> +	    auxtrace_record__snapshot_start(rec->itr))
> +		return -1;
> +
> +	record__read_auxtrace_snapshot(rec, true);

Buffers can get un-mapped earlier as tasks exit.  Refer
perf_evlist__filter_pollfd() -> perf_evlist__munmap_filtered().
Maybe we should prevent that for this case.
e.g. do perf_mmap__get()'s on the mmaps at the start, and then 'put' them
all here.

> +	if (trigger_is_error(&auxtrace_snapshot_trigger))
> +		return -1;
> +
> +	return 0;
> +}
> +
>  static int record__auxtrace_init(struct record *rec)
>  {
>  	int err;
> @@ -654,7 +670,7 @@ int record__auxtrace_mmap_read(struct record *rec __maybe_unused,
>  }
>  
>  static inline
> -void record__read_auxtrace_snapshot(struct record *rec __maybe_unused)
> +void record__read_auxtrace_snapshot(struct record *rec __maybe_unused, bool on_exit)
>  {
>  }
>  
> @@ -664,6 +680,12 @@ int auxtrace_record__snapshot_start(struct auxtrace_record *itr __maybe_unused)
>  	return 0;
>  }
>  
> +static inline
> +int record__auxtrace_snapshot_exit(struct record *rec)
> +{
> +	return 0;
> +}
> +
>  static int record__auxtrace_init(struct record *rec __maybe_unused)
>  {
>  	return 0;
> @@ -1536,7 +1558,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  		if (auxtrace_record__snapshot_started) {
>  			auxtrace_record__snapshot_started = 0;
>  			if (!trigger_is_error(&auxtrace_snapshot_trigger))
> -				record__read_auxtrace_snapshot(rec);
> +				record__read_auxtrace_snapshot(rec, false);
>  			if (trigger_is_error(&auxtrace_snapshot_trigger)) {
>  				pr_err("AUX area tracing snapshot failed\n");
>  				err = -1;
> @@ -1609,9 +1631,13 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  			disabled = true;
>  		}
>  	}
> +
>  	trigger_off(&auxtrace_snapshot_trigger);
>  	trigger_off(&switch_output_trigger);
>  
> +	if (opts->auxtrace_snapshot_on_exit)
> +		record__auxtrace_snapshot_exit(rec);
> +
>  	if (forks && workload_exec_errno) {
>  		char msg[STRERR_BUFSIZE];
>  		const char *emsg = str_error_r(workload_exec_errno, msg, sizeof(msg));
> diff --git a/tools/perf/perf.h b/tools/perf/perf.h
> index 74d0124d38f3..dc0a7a237887 100644
> --- a/tools/perf/perf.h
> +++ b/tools/perf/perf.h
> @@ -57,6 +57,7 @@ struct record_opts {
>  	bool	     running_time;
>  	bool	     full_auxtrace;
>  	bool	     auxtrace_snapshot_mode;
> +	bool	     auxtrace_snapshot_on_exit;
>  	bool	     record_namespaces;
>  	bool	     record_switch_events;
>  	bool	     all_kernel;
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index 65728cdeefb6..72ce4c5e7c78 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -539,9 +539,9 @@ int auxtrace_record__snapshot_start(struct auxtrace_record *itr)
>  	return 0;
>  }
>  
> -int auxtrace_record__snapshot_finish(struct auxtrace_record *itr)
> +int auxtrace_record__snapshot_finish(struct auxtrace_record *itr, bool on_exit)
>  {
> -	if (itr && itr->snapshot_finish)
> +	if (!on_exit && itr && itr->snapshot_finish)

You are assuming you know what every ->snapshot_finish() does.  It would be
better to pass on_exit to ->snapshot_finish().

>  		return itr->snapshot_finish(itr);
>  	return 0;
>  }
> @@ -577,6 +577,16 @@ int auxtrace_parse_snapshot_options(struct auxtrace_record *itr,
>  	if (!str)
>  		return 0;
>  
> +	/* PMU-agnostic options */
> +	switch (*str) {
> +	case 'e':
> +		opts->auxtrace_snapshot_on_exit = true;
> +		str++;
> +		break;
> +	default:
> +		break;
> +	}
> +
>  	if (itr)
>  		return itr->parse_snapshot_options(itr, opts, str);
>  
> diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
> index 17eb04a1da4d..8ccabacd0b11 100644
> --- a/tools/perf/util/auxtrace.h
> +++ b/tools/perf/util/auxtrace.h
> @@ -499,7 +499,7 @@ int auxtrace_record__info_fill(struct auxtrace_record *itr,
>  			       size_t priv_size);
>  void auxtrace_record__free(struct auxtrace_record *itr);
>  int auxtrace_record__snapshot_start(struct auxtrace_record *itr);
> -int auxtrace_record__snapshot_finish(struct auxtrace_record *itr);
> +int auxtrace_record__snapshot_finish(struct auxtrace_record *itr, bool on_exit);
>  int auxtrace_record__find_snapshot(struct auxtrace_record *itr, int idx,
>  				   struct auxtrace_mmap *mm,
>  				   unsigned char *data, u64 *head, u64 *old);
> 

