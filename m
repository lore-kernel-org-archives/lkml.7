Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A9AC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 14:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADEDE20640
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 14:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yRaz5Oe1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfJJOLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 10:11:13 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60406 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfJJOLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 10:11:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lHcR3GT2gEihOKAOsow8gcz96aZQETHMSxuDKwuvrVM=; b=yRaz5Oe1zvS46erwkCGhw7XNU
        VTTQqHGkSpKC1mXRKEkURLrrXHLF6Gz/Vw7d7/L6VT/3BVGY595Hsyrv6lrYw4jNpBpWWNGFhP5p+
        dFp1aj2i14Z4VhxR6pbTMuNYWuy/K3TEFoxWqYpl2PvTR09TVTATtyq3GKbbiIdsyCqzLfaoxeJS8
        mKvsq31Vuv1ijktfpHpWWZI+3tEm2OnftG0Ar5HgB2mHsMRXM07Zh+tKGXrO+au6WoZfTJCaeTEK1
        SYcABSBvtlwq0M4YT/0jpDSXdE+gTIexSHX1bRLYjRlTpmF8ULcUIYfh+H81OKX8QoOJZo39U/dWf
        wnMHLx25g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iIZ9p-0008JS-Qq; Thu, 10 Oct 2019 14:11:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A3F7B3008C1;
        Thu, 10 Oct 2019 16:10:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B027D202BC5A1; Thu, 10 Oct 2019 16:11:07 +0200 (CEST)
Date:   Thu, 10 Oct 2019 16:11:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] ftrace/module: Allow ftrace to make only loaded module
 text read-write
Message-ID: <20191010141107.GU2311@hirez.programming.kicks-ass.net>
References: <20191009223638.60b78727@oasis.local.home>
 <20191010073121.GN2311@hirez.programming.kicks-ass.net>
 <20191010093329.GI2359@hirez.programming.kicks-ass.net>
 <20191010093650.GJ2359@hirez.programming.kicks-ass.net>
 <20191010085011.3734d87b@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010085011.3734d87b@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 08:50:11AM -0400, Steven Rostedt wrote:
> On Thu, 10 Oct 2019 11:36:50 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:

> > > load_module()
> > >   ...
> > >   complete_formation()
> > >     mutex_lock(&module_mutex);
> > >     ...
> > >     module_enable_ro();
> > >     module_enable_nx();
> > >     module_enable_x();
> > > 
> > >     mod->state = MODULE_STATE_COMING;
> > >     mutex_unlock(&module_mutex);
> > > 
> > >   prepare_coming_module()
> > >     ftrace_module_enable();
> > >     ...
> > > 
> > > IOW, we're doing ftrace_module_enable() immediately after we flip it
> > > RO+X. There is nothing in between that we can possibly rely on.
> 
> One reason for the above is the module_mutex. The lock order is that
> module_mutex may be called inside the ftrace_lock, but not vice-versa.
> 
> The ftrace_module_init() was called due to the setting of all modules
> rw when registering a ftrace function while a module was being loaded.
> We may have eliminated this issue on x86 but other archs still call
> set_all_modules_text_rw/ro() when enabling function tracing. Thus, the
> race will still exist there.
> 
> See commit a949ae560a511 for the description of it.
> 
> After implementing that commit, I found it a bit cleaner to handle
> modules in general by breaking it up into setting nops first, and then
> determining if we need to trace that module.

I still don't get it. So you do both, the initial NOPs and the CALL
patching from ftrace_module_init().

> > > I was going to put:
> > > 
> > >   blocking_notifier_call_chain(&module_notify_list,
> > > 			       MODULE_STATE_UNFORMED, mod);
> > > 
> > > right before module_enable_ro(), in complete_formation(), for jump_label
> > > and static_call. It looks like ftrace (and possibly klp) want that too.  
> > 
> > Also, you already have ftrace_module_init() right before that. The only
> > thing inbetween ftrace_module_init() and ftrace_module_enable() is
> > verify_exported_symbols() and module_bug_finalize().
> 
> Yep, see commit a949ae560a511 about that too.
> 
> > 
> > Do you really need that for patching stuff?
> 
> Because arm and nds32 still use the set_all_modules_text_rw(), this
> patch would at least remove that for all archs, and only modify the
> text of a module that isn't running yet. Which I thought was a plus.
> 
> Just need to be careful about other archs, or we need to at least make
> sure they change too.

They call that from ftrace_arch_code_modofy_prepare(), and the patch I
just send makes that unused. So all should be good ;-)
