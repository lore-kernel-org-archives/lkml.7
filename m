Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DBCC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD6242070B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570121546;
	bh=OUugZjslnsj6bkH8Kgibo54v4RZVPhAyJAsWjicMKWc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=w+jTupuYHfkeLmzJ+eLx+H2BC7kD+JrzGcEk9AnWLagx7QDFqtE+GCcbGEaXqlqSK
	 eOd0hc4+Nm6mnGA1C9gGk1U4wvB1xlrJRLrEiEnaLHXTKFlvQo6hrS03rvWz35mf9Q
	 v7/rBCPfO7K6Cr9N+OUd15nKG+O7MeYrNWhMJft4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406182AbfJCQwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:52:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:39992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406168AbfJCQwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:52:23 -0400
Received: from paulmck-ThinkPad-P72 (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 126022086A;
        Thu,  3 Oct 2019 16:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570121542;
        bh=OUugZjslnsj6bkH8Kgibo54v4RZVPhAyJAsWjicMKWc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=gXknnOx7unn5OX2+O0PII4w/o0Y6zfk6Sw2Pzd0mn64eTX/j6hX4Zf/O4Ws08jyOm
         KJ1JEmDOw4MY3Gwacm5ajON64GSO2MR5RRwK7Rx5BiznSUOQSrKlBjrlMVIVXsJ0/p
         Bi1KN9Ig1sCDE4iutxF7M9qBA7HiWRge3F5FLJTM=
Date:   Thu, 3 Oct 2019 09:52:20 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     rcu <rcu@vger.kernel.org>,
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
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Shane M Seymour <shane.seymour@hpe.com>,
        Martin <martin.petersen@oracle.com>
Subject: Re: [PATCH tip/core/rcu 1/9] rcu: Upgrade rcu_swap_protected() to
 rcu_replace()
Message-ID: <20191003165220.GZ2689@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191003014153.GA13156@paulmck-ThinkPad-P72>
 <20191003014310.13262-1-paulmck@kernel.org>
 <644598334.955.1570120530976.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <644598334.955.1570120530976.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 12:35:30PM -0400, Mathieu Desnoyers wrote:
> ----- On Oct 2, 2019, at 9:43 PM, paulmck paulmck@kernel.org wrote:
> 
> > From: "Paul E. McKenney" <paulmck@kernel.org>
> > 
> > Although the rcu_swap_protected() macro follows the example of swap(),
> > the interactions with RCU make its update of its argument somewhat
> > counter-intuitive.  This commit therefore introduces an rcu_replace()
> > that returns the old value of the RCU pointer instead of doing the
> > argument update.  Once all the uses of rcu_swap_protected() are updated
> > to instead use rcu_replace(), rcu_swap_protected() will be removed.
> 
> We expose the rcu_xchg_pointer() API in liburcu (Userspace RCU) project.
> Any reason for not going that way and keep the kernel and user-space RCU
> APIs alike ?
> 
> It's of course fine if they diverge, but we might want to at least consider
> if using the same API name would be OK.

Different semantics.  An rcu_xchg_pointer() allows concurrent updates,
and rcu_replace() does not.

But yes, if someone needs the concurrent updates, rcu_xchg_pointer()
would certainly be my choice for the name.

							Thanx, Paul

> Thanks,
> 
> Mathieu
> 
> 
> > 
> > Link:
> > https://lore.kernel.org/lkml/CAHk-=wiAsJLw1egFEE=Z7-GGtM6wcvtyytXZA1+BHqta4gg6Hw@mail.gmail.com/
> > Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Bart Van Assche <bart.vanassche@wdc.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Hannes Reinecke <hare@suse.de>
> > Cc: Johannes Thumshirn <jthumshirn@suse.de>
> > Cc: Shane M Seymour <shane.seymour@hpe.com>
> > Cc: Martin K. Petersen <martin.petersen@oracle.com>
> > ---
> > include/linux/rcupdate.h | 18 ++++++++++++++++++
> > 1 file changed, 18 insertions(+)
> > 
> > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > index 75a2ede..3b73287 100644
> > --- a/include/linux/rcupdate.h
> > +++ b/include/linux/rcupdate.h
> > @@ -383,6 +383,24 @@ do {									      \
> > } while (0)
> > 
> > /**
> > + * rcu_replace() - replace an RCU pointer, returning its old value
> > + * @rcu_ptr: RCU pointer, whose old value is returned
> > + * @ptr: regular pointer
> > + * @c: the lockdep conditions under which the dereference will take place
> > + *
> > + * Perform a replacement, where @rcu_ptr is an RCU-annotated
> > + * pointer and @c is the lockdep argument that is passed to the
> > + * rcu_dereference_protected() call used to read that pointer.  The old
> > + * value of @rcu_ptr is returned, and @rcu_ptr is set to @ptr.
> > + */
> > +#define rcu_replace(rcu_ptr, ptr, c)					\
> > +({									\
> > +	typeof(ptr) __tmp = rcu_dereference_protected((rcu_ptr), (c));	\
> > +	rcu_assign_pointer((rcu_ptr), (ptr));				\
> > +	__tmp;								\
> > +})
> > +
> > +/**
> >  * rcu_swap_protected() - swap an RCU and a regular pointer
> >  * @rcu_ptr: RCU pointer
> >  * @ptr: regular pointer
> > --
> > 2.9.5
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
