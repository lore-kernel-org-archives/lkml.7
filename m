Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E584AC4CED1
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 13:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B035B215EA
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 13:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570109598;
	bh=x0CnYCCGf6FnkdtfGaZWMy93bevZ9ZOXNmc//+cTm4I=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=xanNjlqPyz+mMu3dEjA2JohTg2Hr0GAqewoxZ6AAsTJ2dX0Ur7ZOfvMXbFf+UvugO
	 5kjuyAwqzyodhk7IYaJLeyFPfboz0QPDeIX6Ak1Z2Feetxssu8bxxTANSrsWoOklPU
	 qjV/5hyuzON+sV+nj2X4bm7rl8Wyacmho9d+h3nY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730460AbfJCNdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 09:33:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:50296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729919AbfJCNdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 09:33:17 -0400
Received: from paulmck-ThinkPad-P72 (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CE8820700;
        Thu,  3 Oct 2019 13:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570109596;
        bh=x0CnYCCGf6FnkdtfGaZWMy93bevZ9ZOXNmc//+cTm4I=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=PKzGIIiNFbgxn1c/bqb5oeow07qPFQ6UU4mPYcFQJ90WoKzMR51u1ARJauNGb38ih
         iQc+N84WhQTP+xVgsxiJjNArI/Gnr5Bwp9dnZHWBpSIYBvhHuO2eYN2hvAA2NmjyKr
         XzVfSYNfdRXnWksL3jodJgDNZW9RqJHjEb9ItpsI=
Date:   Thu, 3 Oct 2019 06:33:15 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     David Howells <dhowells@redhat.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
        joel@joelfernandes.org, Bart Van Assche <bart.vanassche@wdc.com>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Shane M Seymour <shane.seymour@hpe.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH tip/core/rcu 1/9] rcu: Upgrade rcu_swap_protected() to
 rcu_replace()
Message-ID: <20191003133315.GN2689@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191003014310.13262-1-paulmck@kernel.org>
 <20191003014153.GA13156@paulmck-ThinkPad-P72>
 <25408.1570091957@warthog.procyon.org.uk>
 <20191003090850.1e2561b3@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003090850.1e2561b3@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 09:08:50AM -0400, Steven Rostedt wrote:
> On Thu, 03 Oct 2019 09:39:17 +0100
> David Howells <dhowells@redhat.com> wrote:
> 
> > paulmck@kernel.org wrote:
> > 
> > > +#define rcu_replace(rcu_ptr, ptr, c)					\
> > > +({									\
> > > +	typeof(ptr) __tmp = rcu_dereference_protected((rcu_ptr), (c));	\
> > > +	rcu_assign_pointer((rcu_ptr), (ptr));				\
> > > +	__tmp;								\
> > > +})  
> > 
> > Does it make sense to actually use xchg() if that's supported by the arch?

Historically, xchg() has been quite a bit slower than a pair of assignment
statements, in part due to the strong memory ordering guaranteed by
xchg().  Has that changed?  If so, then, agreed, it might make sense to
use xchg().

> Hmm, is there really any arch that doesn't support xchg()? It would be
> very hard to do any kind of atomic operations without it.
> 
> cmpxchg() is the one that I understand is optional by the arch.

To your point, even the old Sequent Symmetry platforms supported xchg()
back in the late 1980s and early 1990s, but only the later versions
(with 80486 and later) supported cmpxchg().

							Thanx, Paul
