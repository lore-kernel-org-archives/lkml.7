Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE88BC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80C3021BE3
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388101AbfHGND6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 09:03:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45336 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387476AbfHGND6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 09:03:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 97E423082B13;
        Wed,  7 Aug 2019 13:03:57 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-112-25.phx2.redhat.com [10.3.112.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A65065D721;
        Wed,  7 Aug 2019 13:03:56 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id 7F6E428C; Wed,  7 Aug 2019 10:03:44 -0300 (BRT)
Date:   Wed, 7 Aug 2019 10:03:44 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf record: Add an option to take an AUX snapshot on
 exit
Message-ID: <20190807130344.GB2460@redhat.com>
References: <20190806144101.62892-1-alexander.shishkin@linux.intel.com>
 <0541bee6-7bdf-2dbc-998d-5df3ddf18208@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0541bee6-7bdf-2dbc-998d-5df3ddf18208@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 07 Aug 2019 13:03:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Aug 07, 2019 at 10:40:39AM +0300, Adrian Hunter escreveu:
> On 6/08/19 5:41 PM, Alexander Shishkin wrote:
> > It is sometimes useful to generate a snapshot when perf record exits;
> > I've been using a wrapper script around the workload that would do a
> > killall -USR2 perf when the workload exits.
> > 
> > This patch makes it easier and also works when perf record is attached
> > to a pre-existing task. A new snapshot option 'e' can be specified in
> > -S to enable this behavior:
> > 
> > root@elsewhere:~# perf record -e intel_pt// -Se sleep 1
> > [ perf record: Woken up 2 times to write data ]
> > [ perf record: Captured and wrote 0.085 MB perf.data ]
> > 
> > Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Co-developed-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> checkpatch says:
> WARNING: Co-developed-by: must be immediately followed by Signed-off-by

I can fix this.

- Arnaldo
 
> > ---
> >  tools/perf/Documentation/perf-record.txt | 11 +++++---
> >  tools/perf/builtin-record.c              | 34 +++++++++++++++++++++---
> >  tools/perf/perf.h                        |  1 +
> >  tools/perf/util/auxtrace.c               | 14 ++++++++--
> >  tools/perf/util/auxtrace.h               |  2 +-
> >  5 files changed, 52 insertions(+), 10 deletions(-)
> > 
> > diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> > index 15e0fa87241b..d5e58e0a2bca 100644
> > --- a/tools/perf/Documentation/perf-record.txt
> > +++ b/tools/perf/Documentation/perf-record.txt
> > @@ -422,9 +422,14 @@ CLOCK_BOOTTIME, CLOCK_REALTIME and CLOCK_TAI.
> >  -S::
> >  --snapshot::
> >  Select AUX area tracing Snapshot Mode. This option is valid only with an
> > -AUX area tracing event. Optionally the number of bytes to capture per
> > -snapshot can be specified. In Snapshot Mode, trace data is captured only when
> > -signal SIGUSR2 is received.
> > +AUX area tracing event. Optionally, certain snapshot capturing parameters
> > +can be specified in a string that follows this option:
> > +  'e': take one last snapshot on exit; guarantees that there is at least one
> > +       snapshot in the output file;
> > +  <size>: if the PMU supports this, specify the desired snapshot size.
> > +
> > +In Snapshot Mode trace data is captured only when signal SIGUSR2 is received
> > +and on exit if the above 'e' option is given.
> >  
> >  --proc-map-timeout::
> >  When processing pre-existing threads /proc/XXX/mmap, it may take a long time,
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index d31d7a5a1be3..e9a2525ecfcc 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -613,19 +613,35 @@ static int record__auxtrace_read_snapshot_all(struct record *rec)
> >  	return rc;
> >  }
> >  
> > -static void record__read_auxtrace_snapshot(struct record *rec)
> > +static void record__read_auxtrace_snapshot(struct record *rec, bool on_exit)
> >  {
> >  	pr_debug("Recording AUX area tracing snapshot\n");
> >  	if (record__auxtrace_read_snapshot_all(rec) < 0) {
> >  		trigger_error(&auxtrace_snapshot_trigger);
> >  	} else {
> > -		if (auxtrace_record__snapshot_finish(rec->itr))
> > +		if (auxtrace_record__snapshot_finish(rec->itr, on_exit))
> >  			trigger_error(&auxtrace_snapshot_trigger);
> >  		else
> >  			trigger_ready(&auxtrace_snapshot_trigger);
> >  	}
> >  }
> >  
> > +static int record__auxtrace_snapshot_exit(struct record *rec)
> > +{
> > +	if (trigger_is_error(&auxtrace_snapshot_trigger))
> > +		return 0;
> > +
> > +	if (!auxtrace_record__snapshot_started &&
> > +	    auxtrace_record__snapshot_start(rec->itr))
> > +		return -1;
> > +
> > +	record__read_auxtrace_snapshot(rec, true);
> 
> Buffers can get un-mapped earlier as tasks exit.  Refer
> perf_evlist__filter_pollfd() -> perf_evlist__munmap_filtered().
> Maybe we should prevent that for this case.
> e.g. do perf_mmap__get()'s on the mmaps at the start, and then 'put' them
> all here.
> 
> > +	if (trigger_is_error(&auxtrace_snapshot_trigger))
> > +		return -1;
> > +
> > +	return 0;
> > +}
> > +
> >  static int record__auxtrace_init(struct record *rec)
> >  {
> >  	int err;
> > @@ -654,7 +670,7 @@ int record__auxtrace_mmap_read(struct record *rec __maybe_unused,
> >  }
> >  
> >  static inline
> > -void record__read_auxtrace_snapshot(struct record *rec __maybe_unused)
> > +void record__read_auxtrace_snapshot(struct record *rec __maybe_unused, bool on_exit)
> >  {
> >  }
> >  
> > @@ -664,6 +680,12 @@ int auxtrace_record__snapshot_start(struct auxtrace_record *itr __maybe_unused)
> >  	return 0;
> >  }
> >  
> > +static inline
> > +int record__auxtrace_snapshot_exit(struct record *rec)
> > +{
> > +	return 0;
> > +}
> > +
> >  static int record__auxtrace_init(struct record *rec __maybe_unused)
> >  {
> >  	return 0;
> > @@ -1536,7 +1558,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
> >  		if (auxtrace_record__snapshot_started) {
> >  			auxtrace_record__snapshot_started = 0;
> >  			if (!trigger_is_error(&auxtrace_snapshot_trigger))
> > -				record__read_auxtrace_snapshot(rec);
> > +				record__read_auxtrace_snapshot(rec, false);
> >  			if (trigger_is_error(&auxtrace_snapshot_trigger)) {
> >  				pr_err("AUX area tracing snapshot failed\n");
> >  				err = -1;
> > @@ -1609,9 +1631,13 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
> >  			disabled = true;
> >  		}
> >  	}
> > +
> >  	trigger_off(&auxtrace_snapshot_trigger);
> >  	trigger_off(&switch_output_trigger);
> >  
> > +	if (opts->auxtrace_snapshot_on_exit)
> > +		record__auxtrace_snapshot_exit(rec);
> > +
> >  	if (forks && workload_exec_errno) {
> >  		char msg[STRERR_BUFSIZE];
> >  		const char *emsg = str_error_r(workload_exec_errno, msg, sizeof(msg));
> > diff --git a/tools/perf/perf.h b/tools/perf/perf.h
> > index 74d0124d38f3..dc0a7a237887 100644
> > --- a/tools/perf/perf.h
> > +++ b/tools/perf/perf.h
> > @@ -57,6 +57,7 @@ struct record_opts {
> >  	bool	     running_time;
> >  	bool	     full_auxtrace;
> >  	bool	     auxtrace_snapshot_mode;
> > +	bool	     auxtrace_snapshot_on_exit;
> >  	bool	     record_namespaces;
> >  	bool	     record_switch_events;
> >  	bool	     all_kernel;
> > diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> > index 65728cdeefb6..72ce4c5e7c78 100644
> > --- a/tools/perf/util/auxtrace.c
> > +++ b/tools/perf/util/auxtrace.c
> > @@ -539,9 +539,9 @@ int auxtrace_record__snapshot_start(struct auxtrace_record *itr)
> >  	return 0;
> >  }
> >  
> > -int auxtrace_record__snapshot_finish(struct auxtrace_record *itr)
> > +int auxtrace_record__snapshot_finish(struct auxtrace_record *itr, bool on_exit)
> >  {
> > -	if (itr && itr->snapshot_finish)
> > +	if (!on_exit && itr && itr->snapshot_finish)
> 
> You are assuming you know what every ->snapshot_finish() does.  It would be
> better to pass on_exit to ->snapshot_finish().
> 
> >  		return itr->snapshot_finish(itr);
> >  	return 0;
> >  }
> > @@ -577,6 +577,16 @@ int auxtrace_parse_snapshot_options(struct auxtrace_record *itr,
> >  	if (!str)
> >  		return 0;
> >  
> > +	/* PMU-agnostic options */
> > +	switch (*str) {
> > +	case 'e':
> > +		opts->auxtrace_snapshot_on_exit = true;
> > +		str++;
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +
> >  	if (itr)
> >  		return itr->parse_snapshot_options(itr, opts, str);
> >  
> > diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
> > index 17eb04a1da4d..8ccabacd0b11 100644
> > --- a/tools/perf/util/auxtrace.h
> > +++ b/tools/perf/util/auxtrace.h
> > @@ -499,7 +499,7 @@ int auxtrace_record__info_fill(struct auxtrace_record *itr,
> >  			       size_t priv_size);
> >  void auxtrace_record__free(struct auxtrace_record *itr);
> >  int auxtrace_record__snapshot_start(struct auxtrace_record *itr);
> > -int auxtrace_record__snapshot_finish(struct auxtrace_record *itr);
> > +int auxtrace_record__snapshot_finish(struct auxtrace_record *itr, bool on_exit);
> >  int auxtrace_record__find_snapshot(struct auxtrace_record *itr, int idx,
> >  				   struct auxtrace_mmap *mm,
> >  				   unsigned char *data, u64 *head, u64 *old);
> > 
