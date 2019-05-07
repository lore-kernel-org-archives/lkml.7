Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9D9C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 08:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92B4320C01
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 08:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfEGISD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 04:18:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35270 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbfEGISD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 04:18:03 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D9BDC3082A24;
        Tue,  7 May 2019 08:18:02 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with SMTP id BA6131001DDE;
        Tue,  7 May 2019 08:18:00 +0000 (UTC)
Date:   Tue, 7 May 2019 10:18:00 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 10/12] perf script: Add --show-bpf-events to show eBPF
 related events
Message-ID: <20190507081759.GB17416@krava>
References: <20190503081841.1908-1-jolsa@kernel.org>
 <20190503081841.1908-11-jolsa@kernel.org>
 <7A338906-850D-430B-A558-93C409A03842@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7A338906-850D-430B-A558-93C409A03842@fb.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 07 May 2019 08:18:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2019 at 09:42:44PM +0000, Song Liu wrote:

SNIP

> > +static int
> > +process_bpf_events(struct perf_tool *tool __maybe_unused,
> > +		   union perf_event *event,
> > +		   struct perf_sample *sample,
> > +		   struct machine *machine)
> > +{
> > +	struct thread *thread;
> > +	struct perf_script *script = container_of(tool, struct perf_script, tool);
> > +	struct perf_session *session = script->session;
> > +	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
> > +
> > +	if (machine__process_ksymbol(machine, event, sample) < 0)
> > +		return -1;
> > +
> > +	if (!evsel->attr.sample_id_all) {
> > +		perf_event__fprintf(event, stdout);
> > +		return 0;
> > +	}
> > +
> > +	thread = machine__findnew_thread(machine, sample->pid, sample->tid);
> > +	if (thread == NULL) {
> > +		pr_debug("problem processing MMAP event, skipping it.\n");
> > +		return -1;
> > +	}
> > +
> > +	if (!filter_cpu(sample)) {
> > +		perf_sample__fprintf_start(sample, thread, evsel,
> > +					   event->header.type, stdout);
> > +		perf_event__fprintf(event, stdout);
> > +	}
> > +
> > +	thread__put(thread);
> > +	return 0;
> > +}
> > +
> > static void sig_handler(int sig __maybe_unused)
> > {
> > 	session_done = 1;
> > @@ -2420,6 +2456,10 @@ static int __cmd_script(struct perf_script *script)
> > 		script->tool.ordered_events = false;
> > 		script->tool.finished_round = process_finished_round_event;
> > 	}
> > +	if (script->show_bpf_events) {
> > +		script->tool.ksymbol   = process_bpf_events;
> > +		script->tool.bpf_event = process_bpf_events;
> 
> Why do we need both set to process_bpf_events?

--show-*-events option is there to display all the related events for given '*'

we want to display both ksymbol and bpf_event in here,
process_bpf_events takes care of it for both of them

thanks,
jirka
