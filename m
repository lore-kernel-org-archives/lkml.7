Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980DCC10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA59214C6
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="ITY3mhlD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfDHOtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 10:49:36 -0400
Received: from mail.efficios.com ([167.114.142.138]:34450 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfDHOtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 10:49:35 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id CB43AA8FD2;
        Mon,  8 Apr 2019 10:49:33 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id EpahjnQfbYlL; Mon,  8 Apr 2019 10:49:33 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 2CF42A8FCC;
        Mon,  8 Apr 2019 10:49:33 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 2CF42A8FCC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1554734973;
        bh=feejfPQ/Ge/kjrKa5H3ETUXcPDuvsU20wcpc0+qavkc=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=ITY3mhlDCrgPM5iftQHNnWIYYexNAecRs8Kb+lnWq/HFdO3EprfuMCtT7m4er9hL/
         +OxmQChbOjejDcByE8bS/p5efJ7Ls5C7VBCXqArsPNwMvBgTym0XdD4YlipZPbqQ57
         Ey3IsrISr8OW22gaLsK4Qf8pbbslP0He0ONsSRIe9He8Rmboz42ne8kdtaDOm+5hKN
         y/MLclVYDwwxRoPPLsjJT2Tz853y+R+zURCqE0/5xT0Ej3kDF40ncSURmIAorBRwLP
         Z5uPwBdF/Xybm5uT4cxuRsFQZsoThEqnECbMj9n7lbX0McKU+vMBQy7JVzZ9hApBx8
         ZgOG1WWJtykMQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id Zl0xl9BXEPRL; Mon,  8 Apr 2019 10:49:33 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 07FBEA8FC2;
        Mon,  8 Apr 2019 10:49:33 -0400 (EDT)
Date:   Mon, 8 Apr 2019 10:49:32 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     paulmck <paulmck@linux.ibm.com>
Cc:     "Joel Fernandes, Google" <joel@joelfernandes.org>,
        rcu <rcu@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        dipankar <dipankar@in.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        rostedt <rostedt@goodmis.org>,
        David Howells <dhowells@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        fweisbec <fweisbec@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx <amd-gfx@lists.freedesktop.org>
Message-ID: <1447252022.1166.1554734972823.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190408142230.GJ14111@linux.ibm.com>
References: <20190402142816.GA13084@linux.ibm.com> <134026717.535.1554665176677.JavaMail.zimbra@efficios.com> <20190407193202.GA30934@localhost> <1632568795.549.1554669696728.JavaMail.zimbra@efficios.com> <20190407210718.GA6656@localhost> <20190408022728.GF14111@linux.ibm.com> <1504296005.857.1554728734661.JavaMail.zimbra@efficios.com> <20190408142230.GJ14111@linux.ibm.com>
Subject: Re: [PATCH RFC tip/core/rcu 0/4] Forbid static SRCU use in modules
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF66 (Linux)/8.8.12_GA_3794)
Thread-Topic: Forbid static SRCU use in modules
Thread-Index: Bi90Yb+GAblaGMOyW07Dk7U5rTULHw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 8, 2019, at 10:22 AM, paulmck paulmck@linux.ibm.com wrote:

> On Mon, Apr 08, 2019 at 09:05:34AM -0400, Mathieu Desnoyers wrote:
>> ----- On Apr 7, 2019, at 10:27 PM, paulmck paulmck@linux.ibm.com wrote:
>> 
>> > On Sun, Apr 07, 2019 at 09:07:18PM +0000, Joel Fernandes wrote:
>> >> On Sun, Apr 07, 2019 at 04:41:36PM -0400, Mathieu Desnoyers wrote:
>> >> > 
>> >> > ----- On Apr 7, 2019, at 3:32 PM, Joel Fernandes, Google joel@joelfernandes.org
>> >> > wrote:
>> >> > 
>> >> > > On Sun, Apr 07, 2019 at 03:26:16PM -0400, Mathieu Desnoyers wrote:
>> >> > >> ----- On Apr 7, 2019, at 9:59 AM, paulmck paulmck@linux.ibm.com wrote:
>> >> > >> 
>> >> > >> > On Sun, Apr 07, 2019 at 06:39:41AM -0700, Paul E. McKenney wrote:
>> >> > >> >> On Sat, Apr 06, 2019 at 07:06:13PM -0400, Joel Fernandes wrote:
>> >> > >> > 
>> >> > >> > [ . . . ]
>> >> > >> > 
>> >> > >> >> > > diff --git a/include/asm-generic/vmlinux.lds.h
>> >> > >> >> > > b/include/asm-generic/vmlinux.lds.h
>> >> > >> >> > > index f8f6f04c4453..c2d919a1566e 100644
>> >> > >> >> > > --- a/include/asm-generic/vmlinux.lds.h
>> >> > >> >> > > +++ b/include/asm-generic/vmlinux.lds.h
>> >> > >> >> > > @@ -338,6 +338,10 @@
>> >> > >> >> > >  		KEEP(*(__tracepoints_ptrs)) /* Tracepoints: pointer array */ \
>> >> > >> >> > >  		__stop___tracepoints_ptrs = .;				\
>> >> > >> >> > >  		*(__tracepoints_strings)/* Tracepoints: strings */	\
>> >> > >> >> > > +		. = ALIGN(8);						\
>> >> > >> >> > > +		__start___srcu_struct = .;				\
>> >> > >> >> > > +		*(___srcu_struct_ptrs)					\
>> >> > >> >> > > +		__end___srcu_struct = .;				\
>> >> > >> >> > >  	}								\
>> >> > >> >> > 
>> >> > >> >> > This vmlinux linker modification is not needed. I tested without it and srcu
>> >> > >> >> > torture works fine with rcutorture built as a module. Putting further prints
>> >> > >> >> > in kernel/module.c verified that the kernel is able to find the srcu structs
>> >> > >> >> > just fine. You could squash the below patch into this one or apply it on top
>> >> > >> >> > of the dev branch.
>> >> > >> >> 
>> >> > >> >> Good point, given that otherwise FORTRAN named common blocks would not
>> >> > >> >> work.
>> >> > >> >> 
>> >> > >> >> But isn't one advantage of leaving that stuff in the RO_DATA_SECTION()
>> >> > >> >> macro that it can be mapped read-only?  Or am I suffering from excessive
>> >> > >> >> optimism?
>> >> > >> > 
>> >> > >> > And to answer the other question, in the case where I am suffering from
>> >> > >> > excessive optimism, it should be a separate commit.  Please see below
>> >> > >> > for the updated original commit thus far.
>> >> > >> > 
>> >> > >> > And may I have your Tested-by?
>> >> > >> 
>> >> > >> Just to confirm: does the cleanup performed in the modules going
>> >> > >> notifier end up acting as a barrier first before freeing the memory ?
>> >> > >> If not, is it explicitly stated that a barrier must be issued before
>> >> > >> module unload ?
>> >> > >> 
>> >> > > 
>> >> > > You mean rcu_barrier? It is mentioned in the documentation that this is the
>> >> > > responsibility of the module writer to prevent delays for all modules.
>> >> > 
>> >> > It's a srcu barrier yes. Considering it would be a barrier specific to the
>> >> > srcu domain within that module, I don't see how it would cause delays for
>> >> > "all" modules if we implicitly issue the barrier on module unload. What
>> >> > am I missing ?
>> >> 
>> >> Yes you are right. I thought of this after I just sent my email. I think it
>> >> makes sense for srcu case to do and could avoid a class of bugs.
>> > 
>> > If there are call_srcu() callbacks outstanding, the module writer still
>> > needs the srcu_barrier() because otherwise callbacks arrive after
>> > the module text has gone, which will be disappoint the CPU when it
>> > tries fetching instructions that are no longer mapped.  If there are
>> > no call_srcu() callbacks from that module, then there is no need for
>> > srcu_barrier() either way.
>> > 
>> > So if an srcu_barrier() is needed, the module developer needs to
>> > supply it.
>> 
>> When you say "callbacks arrive after the module text has gone",
>> I think you assume that free_module() is invoked before the
>> MODULE_STATE_GOING notifiers are called. But it's done in the
>> opposite order: going notifiers are called first, and then
>> free_module() is invoked.
>> 
>> So AFAIU it would be safe to issue the srcu_barrier() from the module
>> going notifier.
>> 
>> Or am I missing something ?
> 
> We do seem to be talking past each other.  ;-)
> 
> This has nothing to do with the order of events at module-unload time.
> 
> So please let me try again.
> 
> If a given srcu_struct in a module never has call_srcu() invoked, there
> is no need to invoke rcu_barrier() at any time, whether at module-unload
> time or not.  Adding rcu_barrier() in this case adds overhead and latency
> for no good reason.

Not if we invoke srcu_barrier() for that specific domain. If
call_srcu was never invoked for a srcu domain, I don't see why
srcu_barrier() should be more expensive than a simple check that
the domain does not have any srcu work queued.

> 
> If a given srcu_struct in a module does have at least one call_srcu()
> invoked, it is already that module's responsibility to make sure that
> the code sticks around long enough for the callback to be invoked.

I understand that when users do explicit dynamic allocation/cleanup of
srcu domains, they indeed need to take care of doing explicit srcu_barrier().
However, if they do static definition of srcu domains, it would be nice
if we can handle the barriers under the hood.

> 
> This means that correct SRCU users that invoke call_srcu() already
> have srcu_barrier() at module-unload time.  Incorrect SRCU users, with
> reasonable probability, now get a WARN_ON() at module-unload time, with
> the per-CPU state getting leaked.  Before this change, they would (also
> with reasonable probability) instead get an instruction-fetch fault when
> the SRCU callback was invoked after the completion of the module unload.
> Furthermore, in all cases where they would previously have gotten the
> instruction-fetch fault, they now get the WARN_ON(), like this:
> 
>	if (WARN_ON(rcu_segcblist_n_cbs(&sdp->srcu_cblist)))
>		return; /* Forgot srcu_barrier(), so just leak it! */
> 
> So this change already represents an improvement in usability.

Considering that we can do a srcu_barrier() for the specific domain,
and that it should add no noticeable overhead if there is no queued
callbacks, I don't see a good reason for leaving the srcu_barrier
invocation to the user rather than implicitly doing it from the
module going notifier.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
