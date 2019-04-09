Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEAF8C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0E102133D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfDIQlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 12:41:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39466 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726606AbfDIQlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 12:41:05 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x39Gf0Wg100449
        for <linux-kernel@vger.kernel.org>; Tue, 9 Apr 2019 12:41:04 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rrwty47j6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 12:41:03 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 9 Apr 2019 17:40:37 +0100
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 9 Apr 2019 17:40:32 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x39GeVcX33882264
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Apr 2019 16:40:31 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0CD68B2068;
        Tue,  9 Apr 2019 16:40:31 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C3BE0B2064;
        Tue,  9 Apr 2019 16:40:30 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  9 Apr 2019 16:40:30 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id D9F1216C36AE; Tue,  9 Apr 2019 09:40:31 -0700 (PDT)
Date:   Tue, 9 Apr 2019 09:40:31 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
Subject: Re: [PATCH RFC tip/core/rcu 0/4] Forbid static SRCU use in modules
Reply-To: paulmck@linux.ibm.com
References: <20190402142816.GA13084@linux.ibm.com>
 <20190408022728.GF14111@linux.ibm.com>
 <1504296005.857.1554728734661.JavaMail.zimbra@efficios.com>
 <20190408142230.GJ14111@linux.ibm.com>
 <1447252022.1166.1554734972823.JavaMail.zimbra@efficios.com>
 <20190408154616.GO14111@linux.ibm.com>
 <1489474416.1465.1554744287985.JavaMail.zimbra@efficios.com>
 <20190409154012.GC248418@google.com>
 <534133139.2374.1554825363211.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <534133139.2374.1554825363211.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19040916-0072-0000-0000-000004178F6C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010896; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01186660; UDB=6.00621518; IPR=6.00967420;
 MB=3.00026365; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-09 16:40:36
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040916-0073-0000-0000-00004BC3DA96
Message-Id: <20190409164031.GE14111@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-09_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904090106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 11:56:03AM -0400, Mathieu Desnoyers wrote:
> ----- On Apr 9, 2019, at 11:40 AM, Joel Fernandes, Google joel@joelfernandes.org wrote:
> 
> > On Mon, Apr 08, 2019 at 01:24:47PM -0400, Mathieu Desnoyers wrote:
> >> ----- On Apr 8, 2019, at 11:46 AM, paulmck paulmck@linux.ibm.com wrote:
> >> 
> >> > On Mon, Apr 08, 2019 at 10:49:32AM -0400, Mathieu Desnoyers wrote:
> >> >> ----- On Apr 8, 2019, at 10:22 AM, paulmck paulmck@linux.ibm.com wrote:
> >> >> 
> >> >> > On Mon, Apr 08, 2019 at 09:05:34AM -0400, Mathieu Desnoyers wrote:
> >> >> >> ----- On Apr 7, 2019, at 10:27 PM, paulmck paulmck@linux.ibm.com wrote:
> >> >> >> 
> >> >> >> > On Sun, Apr 07, 2019 at 09:07:18PM +0000, Joel Fernandes wrote:
> >> >> >> >> On Sun, Apr 07, 2019 at 04:41:36PM -0400, Mathieu Desnoyers wrote:
> >> >> >> >> > 
> >> >> >> >> > ----- On Apr 7, 2019, at 3:32 PM, Joel Fernandes, Google joel@joelfernandes.org
> >> >> >> >> > wrote:
> >> >> >> >> > 
> >> >> >> >> > > On Sun, Apr 07, 2019 at 03:26:16PM -0400, Mathieu Desnoyers wrote:
> >> >> >> >> > >> ----- On Apr 7, 2019, at 9:59 AM, paulmck paulmck@linux.ibm.com wrote:
> >> >> >> >> > >> 
> >> >> >> >> > >> > On Sun, Apr 07, 2019 at 06:39:41AM -0700, Paul E. McKenney wrote:
> >> >> >> >> > >> >> On Sat, Apr 06, 2019 at 07:06:13PM -0400, Joel Fernandes wrote:
> >> >> >> >> > >> > 
> >> >> >> >> > >> > [ . . . ]
> >> >> >> >> > >> > 
> >> >> >> >> > >> >> > > diff --git a/include/asm-generic/vmlinux.lds.h
> >> >> >> >> > >> >> > > b/include/asm-generic/vmlinux.lds.h
> >> >> >> >> > >> >> > > index f8f6f04c4453..c2d919a1566e 100644
> >> >> >> >> > >> >> > > --- a/include/asm-generic/vmlinux.lds.h
> >> >> >> >> > >> >> > > +++ b/include/asm-generic/vmlinux.lds.h
> >> >> >> >> > >> >> > > @@ -338,6 +338,10 @@
> >> >> >> >> > >> >> > >  		KEEP(*(__tracepoints_ptrs)) /* Tracepoints: pointer array */ \
> >> >> >> >> > >> >> > >  		__stop___tracepoints_ptrs = .;				\
> >> >> >> >> > >> >> > >  		*(__tracepoints_strings)/* Tracepoints: strings */	\
> >> >> >> >> > >> >> > > +		. = ALIGN(8);						\
> >> >> >> >> > >> >> > > +		__start___srcu_struct = .;				\
> >> >> >> >> > >> >> > > +		*(___srcu_struct_ptrs)					\
> >> >> >> >> > >> >> > > +		__end___srcu_struct = .;				\
> >> >> >> >> > >> >> > >  	}								\
> >> >> >> >> > >> >> > 
> >> >> >> >> > >> >> > This vmlinux linker modification is not needed. I tested without it and srcu
> >> >> >> >> > >> >> > torture works fine with rcutorture built as a module. Putting further prints
> >> >> >> >> > >> >> > in kernel/module.c verified that the kernel is able to find the srcu structs
> >> >> >> >> > >> >> > just fine. You could squash the below patch into this one or apply it on top
> >> >> >> >> > >> >> > of the dev branch.
> >> >> >> >> > >> >> 
> >> >> >> >> > >> >> Good point, given that otherwise FORTRAN named common blocks would not
> >> >> >> >> > >> >> work.
> >> >> >> >> > >> >> 
> >> >> >> >> > >> >> But isn't one advantage of leaving that stuff in the RO_DATA_SECTION()
> >> >> >> >> > >> >> macro that it can be mapped read-only?  Or am I suffering from excessive
> >> >> >> >> > >> >> optimism?
> >> >> >> >> > >> > 
> >> >> >> >> > >> > And to answer the other question, in the case where I am suffering from
> >> >> >> >> > >> > excessive optimism, it should be a separate commit.  Please see below
> >> >> >> >> > >> > for the updated original commit thus far.
> >> >> >> >> > >> > 
> >> >> >> >> > >> > And may I have your Tested-by?
> >> >> >> >> > >> 
> >> >> >> >> > >> Just to confirm: does the cleanup performed in the modules going
> >> >> >> >> > >> notifier end up acting as a barrier first before freeing the memory ?
> >> >> >> >> > >> If not, is it explicitly stated that a barrier must be issued before
> >> >> >> >> > >> module unload ?
> >> >> >> >> > >> 
> >> >> >> >> > > 
> >> >> >> >> > > You mean rcu_barrier? It is mentioned in the documentation that this is the
> >> >> >> >> > > responsibility of the module writer to prevent delays for all modules.
> >> >> >> >> > 
> >> >> >> >> > It's a srcu barrier yes. Considering it would be a barrier specific to the
> >> >> >> >> > srcu domain within that module, I don't see how it would cause delays for
> >> >> >> >> > "all" modules if we implicitly issue the barrier on module unload. What
> >> >> >> >> > am I missing ?
> >> >> >> >> 
> >> >> >> >> Yes you are right. I thought of this after I just sent my email. I think it
> >> >> >> >> makes sense for srcu case to do and could avoid a class of bugs.
> >> >> >> > 
> >> >> >> > If there are call_srcu() callbacks outstanding, the module writer still
> >> >> >> > needs the srcu_barrier() because otherwise callbacks arrive after
> >> >> >> > the module text has gone, which will be disappoint the CPU when it
> >> >> >> > tries fetching instructions that are no longer mapped.  If there are
> >> >> >> > no call_srcu() callbacks from that module, then there is no need for
> >> >> >> > srcu_barrier() either way.
> >> >> >> > 
> >> >> >> > So if an srcu_barrier() is needed, the module developer needs to
> >> >> >> > supply it.
> >> >> >> 
> >> >> >> When you say "callbacks arrive after the module text has gone",
> >> >> >> I think you assume that free_module() is invoked before the
> >> >> >> MODULE_STATE_GOING notifiers are called. But it's done in the
> >> >> >> opposite order: going notifiers are called first, and then
> >> >> >> free_module() is invoked.
> >> >> >> 
> >> >> >> So AFAIU it would be safe to issue the srcu_barrier() from the module
> >> >> >> going notifier.
> >> >> >> 
> >> >> >> Or am I missing something ?
> >> >> > 
> >> >> > We do seem to be talking past each other.  ;-)
> >> >> > 
> >> >> > This has nothing to do with the order of events at module-unload time.
> >> >> > 
> >> >> > So please let me try again.
> >> >> > 
> >> >> > If a given srcu_struct in a module never has call_srcu() invoked, there
> >> >> > is no need to invoke rcu_barrier() at any time, whether at module-unload
> >> >> > time or not.  Adding rcu_barrier() in this case adds overhead and latency
> >> >> > for no good reason.
> >> >> 
> >> >> Not if we invoke srcu_barrier() for that specific domain. If
> >> >> call_srcu was never invoked for a srcu domain, I don't see why
> >> >> srcu_barrier() should be more expensive than a simple check that
> >> >> the domain does not have any srcu work queued.
> >> > 
> >> > But that simple check does involve a cache miss for each possible CPU (not
> >> > just each online CPU), so it is non-trivial, especially on large systems.
> >> > 
> >> >> > If a given srcu_struct in a module does have at least one call_srcu()
> >> >> > invoked, it is already that module's responsibility to make sure that
> >> >> > the code sticks around long enough for the callback to be invoked.
> >> >> 
> >> >> I understand that when users do explicit dynamic allocation/cleanup of
> >> >> srcu domains, they indeed need to take care of doing explicit srcu_barrier().
> >> >> However, if they do static definition of srcu domains, it would be nice
> >> >> if we can handle the barriers under the hood.
> >> > 
> >> > All else being equal, of course.  But...
> >> > 
> >> >> > This means that correct SRCU users that invoke call_srcu() already
> >> >> > have srcu_barrier() at module-unload time.  Incorrect SRCU users, with
> >> >> > reasonable probability, now get a WARN_ON() at module-unload time, with
> >> >> > the per-CPU state getting leaked.  Before this change, they would (also
> >> >> > with reasonable probability) instead get an instruction-fetch fault when
> >> >> > the SRCU callback was invoked after the completion of the module unload.
> >> >> > Furthermore, in all cases where they would previously have gotten the
> >> >> > instruction-fetch fault, they now get the WARN_ON(), like this:
> >> >> > 
> >> >> >	if (WARN_ON(rcu_segcblist_n_cbs(&sdp->srcu_cblist)))
> >> >> >		return; /* Forgot srcu_barrier(), so just leak it! */
> >> >> > 
> >> >> > So this change already represents an improvement in usability.
> >> >> 
> >> >> Considering that we can do a srcu_barrier() for the specific domain,
> >> >> and that it should add no noticeable overhead if there is no queued
> >> >> callbacks, I don't see a good reason for leaving the srcu_barrier
> >> >> invocation to the user rather than implicitly doing it from the
> >> >> module going notifier.
> >> > 
> >> > Now, I could automatically add an indicator of whether or not a
> >> > call_srcu() had happened, but then again, that would either add a
> >> > call_srcu() scalability bottleneck or again require a scan of all possible
> >> > CPUs...  to figure out if it was necessary to scan all possible CPUs.
> >> > 
> >> > Or is scanning all possible CPUs down in the noise in this case?  Or
> >> > am I missing a trick that would reduce the overhead?
> >> 
> >> Module unloading implicitly does a synchronize_rcu (for RCU-sched), and
> >> a stop_machine. So I would be tempted to say that overhead of iteration
> >> over all CPUs might not matter that much considering the rest.
> >> 
> >> About notifying that a call_srcu has happened for the srcu domain in a
> >> scalable fashion, let's see... We could have a flag "call_srcu_used"
> >> for each call_srcu domain. Whenever call_srcu is invoked, it would
> >> load that flag. It sets it on first use.
> >> 
> >> The idea here is to only use that flag when srcu_barrier is performed
> >> right before the srcu domain cleanup (it could become part of that
> >> cleanup). Else, using it in all srcu_barrier() might be tricky, because
> >> we may then need to add memory barriers or locking to the call_srcu
> >> fast-path, which is an overhead we try to avoid.
> >> 
> >> However, if we only use that flag as part of the srcu domain cleanup,
> >> it's already prohibited to invoke call_srcu concurrently with the
> >> cleanup of the same domain, so I don't think we would need any
> >> memory barriers in call_srcu.
> > 
> > About the last part of your email, it seems to that if after call_srcu has
> > returned, if the module could be unloaded on some other CPU - then it would
> > need to see the flag stored by the preceding call_srcu, so I believe there
> > would be a memory barrier between the two opreations (call_srcu and module
> > unload).
> 
> In order for the module unload not to race against module execution, it needs
> to happen after the call_srcu in a way that is already ordered by other means,
> else module unload races against the module code.
> 
> > 
> > Also about doing the unconditional srcu_barrier, since a module could be
> > unloaded at any time - don't all SRCU using modules need to invoke
> > srcu_barrier() during their clean up anyway so we are incurring the barrier
> > overhead anyway? Or, am I missing a design pattern here? It seems to me
> > rcutorture module definitely calls srcu_barrier() before it is unloaded.
> 
> I think a valid approach which is even simpler might be: if a module statically
> defines a SRCU domain, it should be expected to use it. So adding a srcu_barrier()
> to its module going notifier should not hurt. The rare case where a module defines
> a static SRCU domain *and* does not actually use it with call_srcu() does not
> seem that usual, and not worth optimizing for.
> 
> Thoughts ?

Most SRCU users use only synchronize_srcu(), and don't ever use
call_srcu().  Which is not too surprising given that call_srcu() showed
up late in the game.

But something still bothers me about this, and I am not yet sure
what.  One thing that seems to reduce anxiety somewhat is doing the
srcu_barrier() on all calls to cleanup_srcu_struct() rather than just
those invoked from the modules infrastructure, but I don't see why at
the moment.

							Thanx, Paul

> Thanks,
> 
> Mathieu
> 
> 
> > 
> > thanks,
> > 
> > - Joel
> > 
> >> Thoughts ?
> >> 
> >> Thanks,
> >> 
> >> Mathieu
> >> 
> >> --
> >> Mathieu Desnoyers
> >> EfficiOS Inc.
> > > http://www.efficios.com
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
> 

