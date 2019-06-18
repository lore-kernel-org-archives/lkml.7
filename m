Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C0FC31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 16:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4316720673
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 16:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729845AbfFRQX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 12:23:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:55646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729308AbfFRQXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 12:23:25 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B2A82054F;
        Tue, 18 Jun 2019 16:23:24 +0000 (UTC)
Date:   Tue, 18 Jun 2019 12:23:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 10/21] tracing/probe: Split trace_event related data
 from trace_probe
Message-ID: <20190618122322.6875b643@gandalf.local.home>
In-Reply-To: <20190619011409.1a459906c14b8c851a5eb518@kernel.org>
References: <155931578555.28323.16360245959211149678.stgit@devnote2>
        <155931589667.28323.6107724588059072406.stgit@devnote2>
        <20190617215643.05a33541@oasis.local.home>
        <20190619011409.1a459906c14b8c851a5eb518@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jun 2019 01:14:09 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Mon, 17 Jun 2019 21:56:43 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 

> > > +static nokprobe_inline struct trace_kprobe *
> > > +trace_kprobe_primary_from_call(struct trace_event_call *call)
> > > +{
> > > +	struct trace_probe *tp = trace_probe_primary_from_call(call);
> > > +
> > > +	return container_of(tp, struct trace_kprobe, tp);  
> > 
> > 
> > Hmm, is there a possibility that trace_probe_primary_from_call() may
> > not have a primary?  
> 
> Good question! Of course if given event_call is not a kprobe event,
> it doesn't have primary (or any) trace_probe. But that must not happen
> unless user misuses it.
> And that list never be the empty, when the last trace probe is released,
> the event_call also unregistered and released. See unregister_trace_kprobe()
> for details. If there is no siblings on the list, the event_call is also
> unregistered before unregistering kprobes, and after unregistering kprobes
> the list is unlinked.
>  (Note that unregister_kprobe() will wait a quiescence period
> before return. This means all probe handlers are done before that.)

Yeah, I thought something like that. But perhaps the
trace_probe_primary_from_call() code should add a WARN_ON() is the list
is empty.

> 


> > >  
> > > -	ret = __enable_trace_kprobe(tk);
> > > -	if (ret) {
> > > +	enabled = false;
> > > +	list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
> > > +		tk = container_of(pos, struct trace_kprobe, tp);
> > > +		ecode = __enable_trace_kprobe(tk);
> > > +		if (ecode)
> > > +			ret = ecode;	/* Save the last error code */
> > > +		else
> > > +			enabled = true;  
> > 
> > So, if we have some enabled but return an error code, what should a
> > caller think of that? Wouldn't it be an inconsistent state?  
> 
> Oops, good catch!
> This part is related to caller (ftrace/perf) so should be more careful.
> Usually, kprobe enablement should not fail. If one of them has
> gone (like a probe on unloaded module), it can be fail but that
> should be ignored. I would like to add some additional check so that
> - If all kprobes are on the module which is unloaded, enablement
>   must be failed and return error.
> - If any kprobe is enabled, and others are on non-exist modules,
>   it should succeeded and return OK.
> - If any kprobe caused an error not because of unloaded module,
>   all other enablement should be canceled and return error.
> 
> Is that OK for you?
> 

Sounds good to me.

-- Steve
