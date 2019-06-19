Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F684C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 01:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D768921479
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 01:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560906700;
	bh=cCLF6K6FQ3FcTT774CCrJNrNFM6jLvOhU6dCYKbghcE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=u1Q4UvBRBOnk4qJnhZbWJ94iAFKLIzpLvXXOhFITt8dfLozcpD41KUzlSy1YJFezD
	 JmOb65xXsJwTssYs74zsuje6VJeX3WH15cnYQMoI2K4H1NU0rW4jYiPbVcK0XiskEM
	 orDFFg8s51AOmiesKDnENWCNM26YCsyO8qYSLits=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729689AbfFSBLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 21:11:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:44382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbfFSBLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 21:11:39 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C9692085A;
        Wed, 19 Jun 2019 01:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560906697;
        bh=cCLF6K6FQ3FcTT774CCrJNrNFM6jLvOhU6dCYKbghcE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qMOAk/EBl04SON3xurLy888U+L1ftFG74OMjHcN818LgQZ9+Jkb7rWz4LiWOEqLg7
         YflD9UPQWYeX5Iz3tS/04IFlQM1ZWPwcpqHbSFVqxOPCd4P/j/O7mlsYdboHfe9b5F
         yXzcoJ0OMB8DVl67rce5O1obdZ7SvRdJtxTiexSk=
Date:   Wed, 19 Jun 2019 10:11:33 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 10/21] tracing/probe: Split trace_event related data
 from trace_probe
Message-Id: <20190619101133.f5aa78eac7a1cce4c24ae802@kernel.org>
In-Reply-To: <20190618122322.6875b643@gandalf.local.home>
References: <155931578555.28323.16360245959211149678.stgit@devnote2>
        <155931589667.28323.6107724588059072406.stgit@devnote2>
        <20190617215643.05a33541@oasis.local.home>
        <20190619011409.1a459906c14b8c851a5eb518@kernel.org>
        <20190618122322.6875b643@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jun 2019 12:23:22 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 19 Jun 2019 01:14:09 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > On Mon, 17 Jun 2019 21:56:43 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> 
> > > > +static nokprobe_inline struct trace_kprobe *
> > > > +trace_kprobe_primary_from_call(struct trace_event_call *call)
> > > > +{
> > > > +	struct trace_probe *tp = trace_probe_primary_from_call(call);
> > > > +
> > > > +	return container_of(tp, struct trace_kprobe, tp);  
> > > 
> > > 
> > > Hmm, is there a possibility that trace_probe_primary_from_call() may
> > > not have a primary?  
> > 
> > Good question! Of course if given event_call is not a kprobe event,
> > it doesn't have primary (or any) trace_probe. But that must not happen
> > unless user misuses it.
> > And that list never be the empty, when the last trace probe is released,
> > the event_call also unregistered and released. See unregister_trace_kprobe()
> > for details. If there is no siblings on the list, the event_call is also
> > unregistered before unregistering kprobes, and after unregistering kprobes
> > the list is unlinked.
> >  (Note that unregister_kprobe() will wait a quiescence period
> > before return. This means all probe handlers are done before that.)
> 
> Yeah, I thought something like that. But perhaps the
> trace_probe_primary_from_call() code should add a WARN_ON() is the list
> is empty.

OK, I'll add that, and check in all callers.

> > > >  
> > > > -	ret = __enable_trace_kprobe(tk);
> > > > -	if (ret) {
> > > > +	enabled = false;
> > > > +	list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
> > > > +		tk = container_of(pos, struct trace_kprobe, tp);
> > > > +		ecode = __enable_trace_kprobe(tk);
> > > > +		if (ecode)
> > > > +			ret = ecode;	/* Save the last error code */
> > > > +		else
> > > > +			enabled = true;  
> > > 
> > > So, if we have some enabled but return an error code, what should a
> > > caller think of that? Wouldn't it be an inconsistent state?  
> > 
> > Oops, good catch!
> > This part is related to caller (ftrace/perf) so should be more careful.
> > Usually, kprobe enablement should not fail. If one of them has
> > gone (like a probe on unloaded module), it can be fail but that
> > should be ignored. I would like to add some additional check so that
> > - If all kprobes are on the module which is unloaded, enablement
> >   must be failed and return error.
> > - If any kprobe is enabled, and others are on non-exist modules,
> >   it should succeeded and return OK.
> > - If any kprobe caused an error not because of unloaded module,
> >   all other enablement should be canceled and return error.
> > 
> > Is that OK for you?
> > 
> 
> Sounds good to me.

Thank you!


-- 
Masami Hiramatsu <mhiramat@kernel.org>
