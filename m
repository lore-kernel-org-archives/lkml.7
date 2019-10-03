Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F78C4CED1
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 13:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FC10215EA
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 13:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570111087;
	bh=l1Q8lHXuoN3TJqBllSFbScMN9RwGTZhbVho5omx4P/0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=XuD8WR0fTybmWz4Y0GFTQRiYWAh5kCm7J/2CqDlZpz3zWKk9FYAn2Rz4NotDdEpJV
	 K4VRJwRvl+XrdB/Cg9A4+V0/IVbC+99vJBKCcI8nJDPpfl8EuVqseFTPApWnpLzsbK
	 GaPVREeBJCPQJm/j7n4oTVrzW6q9xDKydKEeAPPs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729950AbfJCN6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 09:58:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:59618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbfJCN6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 09:58:06 -0400
Received: from paulmck-ThinkPad-P72 (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A73020865;
        Thu,  3 Oct 2019 13:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570111085;
        bh=l1Q8lHXuoN3TJqBllSFbScMN9RwGTZhbVho5omx4P/0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=LA26TD21ueBZ3XwCFg+wA8fztaYSGZU2is/9B+0cZxU6cnA16Zl9z4pmd7gqO+izz
         DN/tmGHUX/6DzwTPV8RIYhIovfAkcfZi2odqadsQ5vFgrFF1J8o2LNyklJ3IRAm3zd
         gBjEfEE30Gd72478SVO2c+M6l9HuU6cW0TjnjOcE=
Date:   Thu, 3 Oct 2019 06:58:04 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        David Howells <dhowells@redhat.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Shane M Seymour <shane.seymour@hpe.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH tip/core/rcu 1/9] rcu: Upgrade rcu_swap_protected() to
 rcu_replace()
Message-ID: <20191003135804.GU2689@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191003014310.13262-1-paulmck@kernel.org>
 <20191003014153.GA13156@paulmck-ThinkPad-P72>
 <25408.1570091957@warthog.procyon.org.uk>
 <20191003090850.1e2561b3@gandalf.local.home>
 <20191003133315.GN2689@paulmck-ThinkPad-P72>
 <20191003134131.GS4536@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003134131.GS4536@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 03:41:31PM +0200, Peter Zijlstra wrote:
> On Thu, Oct 03, 2019 at 06:33:15AM -0700, Paul E. McKenney wrote:
> > On Thu, Oct 03, 2019 at 09:08:50AM -0400, Steven Rostedt wrote:
> > > On Thu, 03 Oct 2019 09:39:17 +0100
> > > David Howells <dhowells@redhat.com> wrote:
> > > 
> > > > paulmck@kernel.org wrote:
> > > > 
> > > > > +#define rcu_replace(rcu_ptr, ptr, c)					\
> > > > > +({									\
> > > > > +	typeof(ptr) __tmp = rcu_dereference_protected((rcu_ptr), (c));	\
> > > > > +	rcu_assign_pointer((rcu_ptr), (ptr));				\
> > > > > +	__tmp;								\
> > > > > +})  
> > > > 
> > > > Does it make sense to actually use xchg() if that's supported by the arch?
> > 
> > Historically, xchg() has been quite a bit slower than a pair of assignment
> > statements, in part due to the strong memory ordering guaranteed by
> > xchg().  Has that changed?  If so, then, agreed, it might make sense to
> > use xchg().
> 
> Nope, still the case. xchg() is an atomic op with full ordering.

OK, let's stick with the pair of assignments, then.  ;-)

							Thanx, Paul
