Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1609BC76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 07:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF36A2229C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 07:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbfGVHwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 03:52:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45842 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbfGVHwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 03:52:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1176F86668;
        Mon, 22 Jul 2019 07:52:15 +0000 (UTC)
Received: from redhat.com (ovpn-120-233.rdu2.redhat.com [10.10.120.233])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5B9085C221;
        Mon, 22 Jul 2019 07:52:06 +0000 (UTC)
Date:   Mon, 22 Jul 2019 03:52:05 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Matthew Wilcox <willy@infradead.org>, aarcange@redhat.com,
        akpm@linux-foundation.org, christian@brauner.io,
        davem@davemloft.net, ebiederm@xmission.com,
        elena.reshetova@intel.com, guro@fb.com, hch@infradead.org,
        james.bottomley@hansenpartnership.com, jasowang@redhat.com,
        jglisse@redhat.com, keescook@chromium.org, ldv@altlinux.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-parisc@vger.kernel.org,
        luto@amacapital.net, mhocko@suse.com, mingo@kernel.org,
        namit@vmware.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        wad@chromium.org
Subject: Re: RFC: call_rcu_outstanding (was Re: WARNING in __mmdrop)
Message-ID: <20190722035042-mutt-send-email-mst@kernel.org>
References: <0000000000008dd6bb058e006938@google.com>
 <000000000000964b0d058e1a0483@google.com>
 <20190721044615-mutt-send-email-mst@kernel.org>
 <20190721081933-mutt-send-email-mst@kernel.org>
 <20190721131725.GR14271@linux.ibm.com>
 <20190721210837.GC363@bombadil.infradead.org>
 <20190721233113.GV14271@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190721233113.GV14271@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 22 Jul 2019 07:52:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 21, 2019 at 04:31:13PM -0700, Paul E. McKenney wrote:
> On Sun, Jul 21, 2019 at 02:08:37PM -0700, Matthew Wilcox wrote:
> > On Sun, Jul 21, 2019 at 06:17:25AM -0700, Paul E. McKenney wrote:
> > > Also, the overhead is important.  For example, as far as I know,
> > > current RCU gracefully handles close(open(...)) in a tight userspace
> > > loop.  But there might be trouble due to tight userspace loops around
> > > lighter-weight operations.
> > 
> > I thought you believed that RCU was antifragile, in that it would scale
> > better as it was used more heavily?
> 
> You are referring to this?  https://paulmck.livejournal.com/47933.html
> 
> If so, the last few paragraphs might be worth re-reading.   ;-)
> 
> And in this case, the heuristics RCU uses to decide when to schedule
> invocation of the callbacks needs some help.  One component of that help
> is a time-based limit to the number of consecutive callback invocations
> (see my crude prototype and Eric Dumazet's more polished patch).  Another
> component is an overload warning.
> 
> Why would an overload warning be needed if RCU's callback-invocation
> scheduling heurisitics were upgraded?  Because someone could boot a
> 100-CPU system with the rcu_nocbs=0-99, bind all of the resulting
> rcuo kthreads to (say) CPU 0, and then run a callback-heavy workload
> on all of the CPUs.  Given the constraints, CPU 0 cannot keep up.
> 
> So warnings are required as well.
> 
> > Would it make sense to have call_rcu() check to see if there are many
> > outstanding requests on this CPU and if so process them before returning?
> > That would ensure that frequent callers usually ended up doing their
> > own processing.
> 
> Unfortunately, no.  Here is a code fragment illustrating why:
> 
> 	void my_cb(struct rcu_head *rhp)
> 	{
> 		unsigned long flags;
> 
> 		spin_lock_irqsave(&my_lock, flags);
> 		handle_cb(rhp);
> 		spin_unlock_irqrestore(&my_lock, flags);
> 	}
> 
> 	. . .
> 
> 	spin_lock_irqsave(&my_lock, flags);
> 	p = look_something_up();
> 	remove_that_something(p);
> 	call_rcu(p, my_cb);
> 	spin_unlock_irqrestore(&my_lock, flags);
> 
> Invoking the extra callbacks directly from call_rcu() would thus result
> in self-deadlock.  Documentation/RCU/UP.txt contains a few more examples
> along these lines.

We could add an option that simply fails if overloaded, right?
Have caller recover...

-- 
MST
