Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4A0C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 561DB2089E
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732895AbfHFOeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 10:34:10 -0400
Received: from mga14.intel.com ([192.55.52.115]:8709 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728756AbfHFOeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 10:34:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2019 07:34:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,353,1559545200"; 
   d="scan'208";a="185665611"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.183])
  by orsmga002.jf.intel.com with ESMTP; 06 Aug 2019 07:34:07 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@infradead.org>,
        adrian.hunter@intel.com
Cc:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf record: Add an option to take an AUX snapshot on exit
In-Reply-To: <20170511131943.23850-1-alexander.shishkin@linux.intel.com>
References: <20170511131943.23850-1-alexander.shishkin@linux.intel.com>
Date:   Tue, 06 Aug 2019 17:34:06 +0300
Message-ID: <87o9122wip.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Shishkin <alexander.shishkin@linux.intel.com> writes:

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
> ---
>  tools/perf/Documentation/perf-record.txt | 11 ++++++++---
>  tools/perf/builtin-record.c              |  4 ++++
>  tools/perf/perf.h                        |  1 +
>  tools/perf/util/auxtrace.c               | 10 ++++++++++
>  4 files changed, 23 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> index ea3789d05e..164ffce680 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -387,9 +387,14 @@ CLOCK_BOOTTIME, CLOCK_REALTIME and CLOCK_TAI.
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
> index 70340ff200..42d1b7aeee 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1136,6 +1136,10 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  			disabled = true;
>  		}
>  	}
> +
> +	if (opts->auxtrace_snapshot_on_exit)
> +		record__read_auxtrace_snapshot(rec);
> +
>  	trigger_off(&auxtrace_snapshot_trigger);
>  	trigger_off(&switch_output_trigger);
>  
> diff --git a/tools/perf/perf.h b/tools/perf/perf.h
> index 806c216a10..b79c57485b 100644
> --- a/tools/perf/perf.h
> +++ b/tools/perf/perf.h
> @@ -50,6 +50,7 @@ struct record_opts {
>  	bool	     running_time;
>  	bool	     full_auxtrace;
>  	bool	     auxtrace_snapshot_mode;
> +	bool	     auxtrace_snapshot_on_exit;
>  	bool	     record_namespaces;
>  	bool	     record_switch_events;
>  	bool	     all_kernel;
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index 0daf63b9ee..25ad4445b0 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -564,6 +564,16 @@ int auxtrace_parse_snapshot_options(struct auxtrace_record *itr,
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
> -- 
> 2.11.0
