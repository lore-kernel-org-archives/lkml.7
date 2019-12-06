Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166D2C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 03:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A3122525
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 03:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575601914;
	bh=ygisAbywNNJp+p3FW0CP0VYzP7nARfH6UtkN6FtRDHg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=PpsyHNNkXYZ6MfzOjrfcOJ1nRXYxSDzzoklFPtz5dF5Z3xxRCTJwSUuc6r7lpBqXy
	 1rIbzNlu072wYQ5+5wkFzITed9/EeNrbGiHNMxrmmn+8FPQ1OQwtchlYbt1PRA2Ab/
	 Dt5IkN+Yq1QaJYijOCukScP7jD3GEbdRq02PqReI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfLFDLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 22:11:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:32996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbfLFDLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 22:11:53 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D214E22525;
        Fri,  6 Dec 2019 03:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575601911;
        bh=ygisAbywNNJp+p3FW0CP0VYzP7nARfH6UtkN6FtRDHg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=mZkV+FO1I33/YSDut2aEfBwRscQ9rLY/yoZ+dCXwUFdZ43/ofZohFbOzUBFlIwfQq
         jAiSa3MDBQgZijLH0gfg+nTIbQ18wjBEfKS7yilNHKkP5/sj4c8dNKjW9EoK6JMnn1
         diLcoxHU2yGnmt0jLJiURRcazar2Q7SX1yNhGlhE=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A18573522782; Thu,  5 Dec 2019 19:11:51 -0800 (PST)
Date:   Thu, 5 Dec 2019 19:11:51 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -tip] kprobes: Lock rcu_read_lock() while searching kprobe
Message-ID: <20191206031151.GY2889@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <157527193358.11113.14859628506665612104.stgit@devnote2>
 <20191202210854.GD17234@google.com>
 <20191203071329.GC115767@gmail.com>
 <20191203175712.GI2889@paulmck-ThinkPad-P72>
 <20191204100549.GB114697@gmail.com>
 <20191204161239.GL2889@paulmck-ThinkPad-P72>
 <20191206011137.GB142442@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191206011137.GB142442@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2019 at 08:11:37PM -0500, Joel Fernandes wrote:
> On Wed, Dec 04, 2019 at 08:12:39AM -0800, Paul E. McKenney wrote:
> > On Wed, Dec 04, 2019 at 11:05:50AM +0100, Ingo Molnar wrote:
> > > 
> > > * Paul E. McKenney <paulmck@kernel.org> wrote:
> > > 
> > > > >  * This list-traversal primitive may safely run concurrently with
> > > > >  * the _rcu list-mutation primitives such as hlist_add_head_rcu()
> > > > >  * as long as the traversal is guarded by rcu_read_lock().
> > > > >  */
> > > > > #define hlist_for_each_entry_rcu(pos, head, member, cond...)            \
> > > > > 
> > > > > is actively harmful. Why is it there?
> > > > 
> > > > For cases where common code might be invoked both from the reader
> > > > (with RCU protection) and from the updater (protected by some
> > > > lock).  This common code can then use the optional argument to
> > > > hlist_for_each_entry_rcu() to truthfully tell lockdep that it might be
> > > > called with either form of protection in place.
> > > > 
> > > > This also combines with the __rcu tag used to mark RCU-protected
> > > > pointers, in which case sparse complains when a non-RCU API is applied
> > > > to these pointers, to get back to your earlier question about use of
> > > > hlist_for_each_entry_rcu() within the update-side lock.
> > > > 
> > > > But what are you seeing as actively harmful about all of this?
> > > > What should we be doing instead?
> > > 
> > > Yeah, so basically in the write-locked path hlist_for_each_entry() 
> > > generates (slightly) more efficient code than hlist_for_each_entry_rcu(), 
> > > correct?
> > 
> > Potentially yes, if the READ_ONCE() constrains the compiler.  Or not,
> > depending of course on the compiler and the surrounding code.
> > 
> > > Also, the principle of passing warning flags around is problematic - but 
> > > I can see the point in this specific case.
> > 
> > Would it help to add an hlist_for_each_entry_protected() that expected
> > RCU-protected pointers and write-side protection, analogous to
> > rcu_dereference_protected()?  Or would that expansion of the RCU API
> > outweigh any benefits?
> 
> Personally, I like keeping the same API and using the optional argument like
> we did thus preventing too many APIs / new APIs.

Would you be willing to put together a prototype patch so that people
can see exactly how it would look?

							Thanx, Paul
