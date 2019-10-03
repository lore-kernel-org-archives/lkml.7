Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C6BC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 13:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B7822133F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 13:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730371AbfJCNIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 09:08:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:37810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729763AbfJCNIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 09:08:54 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B1A221D71;
        Thu,  3 Oct 2019 13:08:52 +0000 (UTC)
Date:   Thu, 3 Oct 2019 09:08:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     David Howells <dhowells@redhat.com>
Cc:     paulmck@kernel.org, rcu@vger.kernel.org,
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
Message-ID: <20191003090850.1e2561b3@gandalf.local.home>
In-Reply-To: <25408.1570091957@warthog.procyon.org.uk>
References: <20191003014310.13262-1-paulmck@kernel.org>
        <20191003014153.GA13156@paulmck-ThinkPad-P72>
        <25408.1570091957@warthog.procyon.org.uk>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Oct 2019 09:39:17 +0100
David Howells <dhowells@redhat.com> wrote:

> paulmck@kernel.org wrote:
> 
> > +#define rcu_replace(rcu_ptr, ptr, c)					\
> > +({									\
> > +	typeof(ptr) __tmp = rcu_dereference_protected((rcu_ptr), (c));	\
> > +	rcu_assign_pointer((rcu_ptr), (ptr));				\
> > +	__tmp;								\
> > +})  
> 
> Does it make sense to actually use xchg() if that's supported by the arch?
> 

Hmm, is there really any arch that doesn't support xchg()? It would be
very hard to do any kind of atomic operations without it.

cmpxchg() is the one that I understand is optional by the arch.

-- Steve

