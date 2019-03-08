Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D389C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D47422087C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="leVQeg2Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfCHNjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 08:39:08 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33952 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbfCHNjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 08:39:08 -0500
Received: by mail-qk1-f194.google.com with SMTP id a15so11159264qkc.1;
        Fri, 08 Mar 2019 05:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A7/YaC34M9NfMNGYsHZsYeTh4s7eAhVmEz6CieAw1lk=;
        b=leVQeg2YjioMyCKcR8aCiIIoWC8W0kz7RBkMbTwLpEkKG6wSpr+VmXZ34bunlpRuXJ
         +d4rUpXSg5VtNsmFtN+m5QpX0kzl1Qg64lRfWMDAO615A4XreL3NrkqHdqePj29Uh+Kq
         sD+IwdMnwvwzeSp4zRsiiuYh5IGegQKiFMk4FhRg9+wQMc4LBmHzh5UbtSkvmPO7Khfm
         B3bK9koBVrdIO3fJ4hoJvWwyNuj5433J4eUsFpBysZKp7F3ZyjK7RA6Py2lQXup1TSeZ
         qLCWXfbOEagElyy50AhGVLjRvkHS6xHPZpGwFiQpGo+ZaaqkEZhVtfOU0dq4+YMLL3sZ
         Hrow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A7/YaC34M9NfMNGYsHZsYeTh4s7eAhVmEz6CieAw1lk=;
        b=knez4X3dg2R8KvWB6FM+G55H1Q4jL0MzSo1mT1+3WOVsanxXBQTpPdJvfLZ48eSMZp
         M6qpAZ9g56eLUs5xm3aWN6sQZvLju3GGj3eooAi9zt537nylmlkfA4UKRMWW19wprc0z
         CzGFqfdw/p/MGIn3g2AeFcHCSwuY2sLnwvfPWM5V3nDT2CC/Z2vPdau60g5cdeQk7KL/
         R3lAaNNO2t0LXXmJmxPzeu4EejWKVbvb4FGCXLHmH9bMlh0dOnLYAaydNuCdPkIabpIQ
         RqSMuacl8O8Vn+aZ7diJMaOfVKW9MHrrKxcFlMpYxkBxLFKUwW1FyMVmE7VtdZfCjp8x
         0H3A==
X-Gm-Message-State: APjAAAV6cZ94TMHCNZD/0pS3eA42IfCgofI8lIBb035zbtHFgu3JuCUZ
        AcRtTShMjkcIF+h10y8ZSRw=
X-Google-Smtp-Source: APXvYqx81hNHRFD8VpyZXBDqnpyXQnlEaGV/zjDABDJAhYSPsX5JU2428+wqjZ/FUDz5Et48Umhu+A==
X-Received: by 2002:a37:5887:: with SMTP id m129mr5614645qkb.264.1552052346389;
        Fri, 08 Mar 2019 05:39:06 -0800 (PST)
Received: from quaco.ghostprotocols.net (177-59-154-188.3g.claro.net.br. [177.59.154.188])
        by smtp.gmail.com with ESMTPSA id d80sm3845186qkg.83.2019.03.08.05.39.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Mar 2019 05:39:05 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 925A64039C; Fri,  8 Mar 2019 10:39:01 -0300 (-03)
Date:   Fri, 8 Mar 2019 10:39:01 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <andi@firstfloor.org>, jolsa@kernel.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v4 03/15] perf tools script: Filter COMM/FORK/.. events
 by CPU
Message-ID: <20190308133901.GB26260@kernel.org>
References: <20190305144758.12397-1-andi@firstfloor.org>
 <20190305144758.12397-4-andi@firstfloor.org>
 <6d837d6b-da67-9878-dcc5-a2b0f2dc6826@intel.com>
 <20190307110231.GB8979@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307110231.GB8979@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 07, 2019 at 12:02:31PM +0100, Jiri Olsa escreveu:
> On Wed, Mar 06, 2019 at 04:23:40PM +0200, Adrian Hunter wrote:
> > On 5/03/19 4:47 PM, Andi Kleen wrote:
> > > From: Andi Kleen <ak@linux.intel.com>
> > > 
> > > The --cpu option only filtered samples. Filter other perf events,
> > > such as COMM, FORK, SWITCH by the CPU too.
> > 
> > Because tasks can migrate from cpu to cpu, we probably need to process most
> > of the events anyway, even if they are not printed.
> 
> agreed, I wonder we could just make the perf_event__fprintf conditional

Humm, probably just do the filtering on PERF_RECORD_SAMPLE is enough?
I.e. having the other PERF_RECORD_{COMM,MMAP,} etc is required in face
of migration.

- Arnaldo
 
> jirka
> 
> > 
> > > 
> > > Reported-by: Jiri Olsa <jolsa@kernel.org>
> > > Signed-off-by: Andi Kleen <ak@linux.intel.com>
> > > ---
> > >  tools/perf/builtin-script.c | 24 ++++++++++++++++++++++++
> > >  1 file changed, 24 insertions(+)
> > > 
> > > diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> > > index fbc440bdf880..3813f60d1dc0 100644
> > > --- a/tools/perf/builtin-script.c
> > > +++ b/tools/perf/builtin-script.c
> > > @@ -2038,6 +2038,9 @@ static int process_comm_event(struct perf_tool *tool,
> > >  	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
> > >  	int ret = -1;
> > >  
> > > +	if (cpu_list && !test_bit(sample->cpu, cpu_bitmap))
> > > +		return 0;
> > > +
> > >  	thread = machine__findnew_thread(machine, event->comm.pid, event->comm.tid);
> > >  	if (thread == NULL) {
> > >  		pr_debug("problem processing COMM event, skipping it.\n");
> > > @@ -2073,6 +2076,9 @@ static int process_namespaces_event(struct perf_tool *tool,
> > >  	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
> > >  	int ret = -1;
> > >  
> > > +	if (cpu_list && !test_bit(sample->cpu, cpu_bitmap))
> > > +		return 0;
> > > +
> > >  	thread = machine__findnew_thread(machine, event->namespaces.pid,
> > >  					 event->namespaces.tid);
> > >  	if (thread == NULL) {
> > > @@ -2108,6 +2114,9 @@ static int process_fork_event(struct perf_tool *tool,
> > >  	struct perf_session *session = script->session;
> > >  	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
> > >  
> > > +	if (cpu_list && !test_bit(sample->cpu, cpu_bitmap))
> > > +		return 0;
> > > +
> > >  	if (perf_event__process_fork(tool, event, sample, machine) < 0)
> > >  		return -1;
> > >  
> > > @@ -2141,6 +2150,9 @@ static int process_exit_event(struct perf_tool *tool,
> > >  	struct perf_session *session = script->session;
> > >  	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
> > >  
> > > +	if (cpu_list && !test_bit(sample->cpu, cpu_bitmap))
> > > +		return 0;
> > > +
> > >  	thread = machine__findnew_thread(machine, event->fork.pid, event->fork.tid);
> > >  	if (thread == NULL) {
> > >  		pr_debug("problem processing EXIT event, skipping it.\n");
> > > @@ -2174,6 +2186,9 @@ static int process_mmap_event(struct perf_tool *tool,
> > >  	struct perf_session *session = script->session;
> > >  	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
> > >  
> > > +	if (cpu_list && !test_bit(sample->cpu, cpu_bitmap))
> > > +		return 0;
> > > +
> > >  	if (perf_event__process_mmap(tool, event, sample, machine) < 0)
> > >  		return -1;
> > >  
> > > @@ -2206,6 +2221,9 @@ static int process_mmap2_event(struct perf_tool *tool,
> > >  	struct perf_session *session = script->session;
> > >  	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
> > >  
> > > +	if (cpu_list && !test_bit(sample->cpu, cpu_bitmap))
> > > +		return 0;
> > > +
> > >  	if (perf_event__process_mmap2(tool, event, sample, machine) < 0)
> > >  		return -1;
> > >  
> > > @@ -2238,6 +2256,9 @@ static int process_switch_event(struct perf_tool *tool,
> > >  	struct perf_session *session = script->session;
> > >  	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
> > >  
> > > +	if (cpu_list && !test_bit(sample->cpu, cpu_bitmap))
> > > +		return 0;
> > > +
> > >  	if (perf_event__process_switch(tool, event, sample, machine) < 0)
> > >  		return -1;
> > >  
> > > @@ -2266,6 +2287,9 @@ process_lost_event(struct perf_tool *tool,
> > >  	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
> > >  	struct thread *thread;
> > >  
> > > +	if (cpu_list && !test_bit(sample->cpu, cpu_bitmap))
> > > +		return 0;
> > > +
> > >  	thread = machine__findnew_thread(machine, sample->pid,
> > >  					 sample->tid);
> > >  	if (thread == NULL)
> > > 
> > 

-- 

- Arnaldo
