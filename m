Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B78C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E2602075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbfDOQ7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 12:59:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37452 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727447AbfDOQ7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 12:59:09 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7BBA4309265A;
        Mon, 15 Apr 2019 16:59:09 +0000 (UTC)
Received: from treble (ovpn-120-105.rdu2.redhat.com [10.10.120.105])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C684C5D9C9;
        Mon, 15 Apr 2019 16:59:02 +0000 (UTC)
Date:   Mon, 15 Apr 2019 11:58:59 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kairui Song <kasong@redhat.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>
Subject: Re: [RFC PATCH v2] perf/x86: make perf callchain work without
 CONFIG_FRAME_POINTER
Message-ID: <20190415165859.ul7i2w3lai3umgik@treble>
References: <20190408165942.23640-1-kasong@redhat.com>
 <20190415153622.GG12232@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190415153622.GG12232@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 15 Apr 2019 16:59:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 05:36:22PM +0200, Peter Zijlstra wrote:
> 
> I'll mostly defer to Josh on unwinding, but a few comments below.
> 
> On Tue, Apr 09, 2019 at 12:59:42AM +0800, Kairui Song wrote:
> > diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> > index e2b1447192a8..6075a4f94376 100644
> > --- a/arch/x86/events/core.c
> > +++ b/arch/x86/events/core.c
> > @@ -2355,6 +2355,12 @@ void arch_perf_update_userpage(struct perf_event *event,
> >  	cyc2ns_read_end();
> >  }
> >  
> > +static inline int
> > +valid_perf_registers(struct pt_regs *regs)
> > +{
> > +	return (regs->ip && regs->bp && regs->sp);
> > +}
> 
> I'm unconvinced by this, with both guess and orc having !bp is perfectly
> valid.
> 
> >  void
> >  perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs)
> >  {
> > @@ -2366,11 +2372,17 @@ perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *re
> >  		return;
> >  	}
> >  
> > -	if (perf_callchain_store(entry, regs->ip))
> > +	if (valid_perf_registers(regs)) {
> > +		if (perf_callchain_store(entry, regs->ip))
> > +			return;
> > +		unwind_start(&state, current, regs, NULL);
> > +	} else if (regs->sp) {
> > +		unwind_start(&state, current, NULL, (unsigned long *)regs->sp);
> > +	} else {
> >  		return;
> > +	}
> 
> AFAICT if we, by pure accident, end up with !bp for ORC, then we
> initialize the unwind wrong.
> 
> Note that @regs is mostly trivially correct, except for that tracepoint
> case. So I don't think we should magic here.

Ah, I didn't quite understand this code before, and I still don't
really, but I guess the issue is that @regs can be either real or fake.

In the real @regs case, we just want to always unwind starting from
regs->sp.

But in the fake @regs case, we should instead unwind from the current
frame, skipping all frames until we hit the fake regs->sp.  Because
starting from fake/incomplete regs is most likely going to cause
problems with ORC (or DWARF for other arches).

The idea of a fake regs is fragile and confusing.  Is it possible to
just pass in the "skip" stack pointer directly instead?  That should
work for both FP and non-FP.  And I _think_ there's no need to ever
capture regs->bp anyway -- the stack pointer should be sufficient.

In other words, either regs should be "real", and skip_sp is NULL; or
regs should be NULL and skip_sp should have a value.

-- 
Josh
