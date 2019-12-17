Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4197C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 14:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 840482465E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 14:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576594769;
	bh=X1PiVxcDVotj0DhdvGj1bIfqqxEYbzQbmZ7rzefwzlI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=nUsCYf0meCk0+ezCqnoLA5SC3mWZrqUGCNBROnJnczuIJmxR6vRqrFI0bz3amLyeO
	 ben3ONXIvrsHMp3H/t9Eo4Cym/fHVjEfAS9bsyW476veeaaUPMelubos8SD3gqOzTP
	 mhSctZt6wcTXEomiSezvxWiWjAwZfdUpYNsStVFE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbfLQO72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 09:59:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:45918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726560AbfLQO72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 09:59:28 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C1432146E;
        Tue, 17 Dec 2019 14:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576594766;
        bh=X1PiVxcDVotj0DhdvGj1bIfqqxEYbzQbmZ7rzefwzlI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nr0K06QNQmm1n9qx+9jVB2d+Ydzi4sALusD8JzCqB3ntD3yvFbLJNuPHAptIVLsF+
         PDs806kXbdNEAiy/H7HLANWQHb4WI5T2N345xg8/syBy4SMsutm/n6ctLJ9sEI3da3
         HgtLDZWf/zydqfQ+j3AHA3IguZqFxvBe8fuWClG4=
Date:   Tue, 17 Dec 2019 23:59:21 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     paulmck@kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -tip] kprobes: Lock rcu_read_lock() while searching
 kprobe
Message-Id: <20191217235921.01cecb379e5e58493a0815af@kernel.org>
In-Reply-To: <20191209033910.GD2889@paulmck-ThinkPad-P72>
References: <157527193358.11113.14859628506665612104.stgit@devnote2>
        <20191202210854.GD17234@google.com>
        <20191203071329.GC115767@gmail.com>
        <20191203175712.GI2889@paulmck-ThinkPad-P72>
        <20191204100549.GB114697@gmail.com>
        <20191204161239.GL2889@paulmck-ThinkPad-P72>
        <20191206011137.GB142442@google.com>
        <20191206031151.GY2889@paulmck-ThinkPad-P72>
        <20191208000842.GA62607@google.com>
        <20191209033910.GD2889@paulmck-ThinkPad-P72>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 8 Dec 2019 19:39:11 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> On Sat, Dec 07, 2019 at 07:08:42PM -0500, Joel Fernandes wrote:
> > On Thu, Dec 05, 2019 at 07:11:51PM -0800, Paul E. McKenney wrote:
> > > On Thu, Dec 05, 2019 at 08:11:37PM -0500, Joel Fernandes wrote:
> > > > On Wed, Dec 04, 2019 at 08:12:39AM -0800, Paul E. McKenney wrote:
> > > > > On Wed, Dec 04, 2019 at 11:05:50AM +0100, Ingo Molnar wrote:
> > > > > > 
> > > > > > * Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > > 
> > > > > > > >  * This list-traversal primitive may safely run concurrently with
> > > > > > > >  * the _rcu list-mutation primitives such as hlist_add_head_rcu()
> > > > > > > >  * as long as the traversal is guarded by rcu_read_lock().
> > > > > > > >  */
> > > > > > > > #define hlist_for_each_entry_rcu(pos, head, member, cond...)            \
> > > > > > > > 
> > > > > > > > is actively harmful. Why is it there?
> > > > > > > 
> > > > > > > For cases where common code might be invoked both from the reader
> > > > > > > (with RCU protection) and from the updater (protected by some
> > > > > > > lock).  This common code can then use the optional argument to
> > > > > > > hlist_for_each_entry_rcu() to truthfully tell lockdep that it might be
> > > > > > > called with either form of protection in place.
> > > > > > > 
> > > > > > > This also combines with the __rcu tag used to mark RCU-protected
> > > > > > > pointers, in which case sparse complains when a non-RCU API is applied
> > > > > > > to these pointers, to get back to your earlier question about use of
> > > > > > > hlist_for_each_entry_rcu() within the update-side lock.
> > > > > > > 
> > > > > > > But what are you seeing as actively harmful about all of this?
> > > > > > > What should we be doing instead?
> > > > > > 
> > > > > > Yeah, so basically in the write-locked path hlist_for_each_entry() 
> > > > > > generates (slightly) more efficient code than hlist_for_each_entry_rcu(), 
> > > > > > correct?
> > > > > 
> > > > > Potentially yes, if the READ_ONCE() constrains the compiler.  Or not,
> > > > > depending of course on the compiler and the surrounding code.
> > > > > 
> > > > > > Also, the principle of passing warning flags around is problematic - but 
> > > > > > I can see the point in this specific case.
> > > > > 
> > > > > Would it help to add an hlist_for_each_entry_protected() that expected
> > > > > RCU-protected pointers and write-side protection, analogous to
> > > > > rcu_dereference_protected()?  Or would that expansion of the RCU API
> > > > > outweigh any benefits?
> > > > 
> > > > Personally, I like keeping the same API and using the optional argument like
> > > > we did thus preventing too many APIs / new APIs.
> > > 
> > > Would you be willing to put together a prototype patch so that people
> > > can see exactly how it would look?
> > 
> > Hi Paul,
> > 
> > I was referring to the same API we have at the moment (that is
> > hlist_for_each_entry_rcu() with the additional cond parameter). I was saying
> > let us keep that and not add a hlist_for_each_entry_protected() instead, so
> > as to not proliferate the number of APIs.
> > 
> > Or did I miss the point?
> 
> This would work for me.  The only concern would be inefficiency, but we
> have heard from people saying that the unnecessary inefficiency is only
> on code paths that they do not care about, so we should be good.

So, what will be the conclusion here, Ingo?

I faced other warnings in tracing subsystem, so I need to add more
lockdep_is_held()s there to suppress warnings.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
