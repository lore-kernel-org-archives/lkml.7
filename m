Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D906C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2415220840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbfCGLCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 06:02:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51610 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726250AbfCGLCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 06:02:34 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9648880F91;
        Thu,  7 Mar 2019 11:02:33 +0000 (UTC)
Received: from krava (unknown [10.43.17.112])
        by smtp.corp.redhat.com (Postfix) with SMTP id DE6AB1001E70;
        Thu,  7 Mar 2019 11:02:31 +0000 (UTC)
Date:   Thu, 7 Mar 2019 12:02:31 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Andi Kleen <andi@firstfloor.org>, acme@kernel.org,
        jolsa@kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v4 03/15] perf tools script: Filter COMM/FORK/.. events
 by CPU
Message-ID: <20190307110231.GB8979@krava>
References: <20190305144758.12397-1-andi@firstfloor.org>
 <20190305144758.12397-4-andi@firstfloor.org>
 <6d837d6b-da67-9878-dcc5-a2b0f2dc6826@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d837d6b-da67-9878-dcc5-a2b0f2dc6826@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 07 Mar 2019 11:02:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 04:23:40PM +0200, Adrian Hunter wrote:
> On 5/03/19 4:47 PM, Andi Kleen wrote:
> > From: Andi Kleen <ak@linux.intel.com>
> > 
> > The --cpu option only filtered samples. Filter other perf events,
> > such as COMM, FORK, SWITCH by the CPU too.
> 
> Because tasks can migrate from cpu to cpu, we probably need to process most
> of the events anyway, even if they are not printed.

agreed, I wonder we could just make the perf_event__fprintf conditional

jirka

> 
> > 
> > Reported-by: Jiri Olsa <jolsa@kernel.org>
> > Signed-off-by: Andi Kleen <ak@linux.intel.com>
> > ---
> >  tools/perf/builtin-script.c | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> > 
> > diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> > index fbc440bdf880..3813f60d1dc0 100644
> > --- a/tools/perf/builtin-script.c
> > +++ b/tools/perf/builtin-script.c
> > @@ -2038,6 +2038,9 @@ static int process_comm_event(struct perf_tool *tool,
> >  	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
> >  	int ret = -1;
> >  
> > +	if (cpu_list && !test_bit(sample->cpu, cpu_bitmap))
> > +		return 0;
> > +
> >  	thread = machine__findnew_thread(machine, event->comm.pid, event->comm.tid);
> >  	if (thread == NULL) {
> >  		pr_debug("problem processing COMM event, skipping it.\n");
> > @@ -2073,6 +2076,9 @@ static int process_namespaces_event(struct perf_tool *tool,
> >  	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
> >  	int ret = -1;
> >  
> > +	if (cpu_list && !test_bit(sample->cpu, cpu_bitmap))
> > +		return 0;
> > +
> >  	thread = machine__findnew_thread(machine, event->namespaces.pid,
> >  					 event->namespaces.tid);
> >  	if (thread == NULL) {
> > @@ -2108,6 +2114,9 @@ static int process_fork_event(struct perf_tool *tool,
> >  	struct perf_session *session = script->session;
> >  	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
> >  
> > +	if (cpu_list && !test_bit(sample->cpu, cpu_bitmap))
> > +		return 0;
> > +
> >  	if (perf_event__process_fork(tool, event, sample, machine) < 0)
> >  		return -1;
> >  
> > @@ -2141,6 +2150,9 @@ static int process_exit_event(struct perf_tool *tool,
> >  	struct perf_session *session = script->session;
> >  	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
> >  
> > +	if (cpu_list && !test_bit(sample->cpu, cpu_bitmap))
> > +		return 0;
> > +
> >  	thread = machine__findnew_thread(machine, event->fork.pid, event->fork.tid);
> >  	if (thread == NULL) {
> >  		pr_debug("problem processing EXIT event, skipping it.\n");
> > @@ -2174,6 +2186,9 @@ static int process_mmap_event(struct perf_tool *tool,
> >  	struct perf_session *session = script->session;
> >  	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
> >  
> > +	if (cpu_list && !test_bit(sample->cpu, cpu_bitmap))
> > +		return 0;
> > +
> >  	if (perf_event__process_mmap(tool, event, sample, machine) < 0)
> >  		return -1;
> >  
> > @@ -2206,6 +2221,9 @@ static int process_mmap2_event(struct perf_tool *tool,
> >  	struct perf_session *session = script->session;
> >  	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
> >  
> > +	if (cpu_list && !test_bit(sample->cpu, cpu_bitmap))
> > +		return 0;
> > +
> >  	if (perf_event__process_mmap2(tool, event, sample, machine) < 0)
> >  		return -1;
> >  
> > @@ -2238,6 +2256,9 @@ static int process_switch_event(struct perf_tool *tool,
> >  	struct perf_session *session = script->session;
> >  	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
> >  
> > +	if (cpu_list && !test_bit(sample->cpu, cpu_bitmap))
> > +		return 0;
> > +
> >  	if (perf_event__process_switch(tool, event, sample, machine) < 0)
> >  		return -1;
> >  
> > @@ -2266,6 +2287,9 @@ process_lost_event(struct perf_tool *tool,
> >  	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
> >  	struct thread *thread;
> >  
> > +	if (cpu_list && !test_bit(sample->cpu, cpu_bitmap))
> > +		return 0;
> > +
> >  	thread = machine__findnew_thread(machine, sample->pid,
> >  					 sample->tid);
> >  	if (thread == NULL)
> > 
> 
