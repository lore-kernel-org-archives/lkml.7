Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CE5C76194
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 16:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB86F21955
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 16:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730686AbfGVQNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 12:13:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59380 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728972AbfGVQNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 12:13:51 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BAFB030B8DE2;
        Mon, 22 Jul 2019 16:13:50 +0000 (UTC)
Received: from redhat.com (ovpn-124-54.rdu2.redhat.com [10.10.124.54])
        by smtp.corp.redhat.com (Postfix) with SMTP id AE2A260BEC;
        Mon, 22 Jul 2019 16:13:42 +0000 (UTC)
Date:   Mon, 22 Jul 2019 12:13:40 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Matthew Wilcox <willy@infradead.org>, aarcange@redhat.com,
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
Message-ID: <20190722120011-mutt-send-email-mst@kernel.org>
References: <0000000000008dd6bb058e006938@google.com>
 <000000000000964b0d058e1a0483@google.com>
 <20190721044615-mutt-send-email-mst@kernel.org>
 <20190721081933-mutt-send-email-mst@kernel.org>
 <20190721131725.GR14271@linux.ibm.com>
 <20190721210837.GC363@bombadil.infradead.org>
 <20190721233113.GV14271@linux.ibm.com>
 <20190722151439.GA247639@google.com>
 <20190722114612-mutt-send-email-mst@kernel.org>
 <20190722155534.GG14271@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722155534.GG14271@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 22 Jul 2019 16:13:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 08:55:34AM -0700, Paul E. McKenney wrote:
> On Mon, Jul 22, 2019 at 11:47:24AM -0400, Michael S. Tsirkin wrote:
> > On Mon, Jul 22, 2019 at 11:14:39AM -0400, Joel Fernandes wrote:
> > > [snip]
> > > > > Would it make sense to have call_rcu() check to see if there are many
> > > > > outstanding requests on this CPU and if so process them before returning?
> > > > > That would ensure that frequent callers usually ended up doing their
> > > > > own processing.
> > > 
> > > Other than what Paul already mentioned about deadlocks, I am not sure if this
> > > would even work for all cases since call_rcu() has to wait for a grace
> > > period.
> > > 
> > > So, if the number of outstanding requests are higher than a certain amount,
> > > then you *still* have to wait for some RCU configurations for the grace
> > > period duration and cannot just execute the callback in-line. Did I miss
> > > something?
> > > 
> > > Can waiting in-line for a grace period duration be tolerated in the vhost case?
> > > 
> > > thanks,
> > > 
> > >  - Joel
> > 
> > No, but it has many other ways to recover (try again later, drop a
> > packet, use a slower copy to/from user).
> 
> True enough!  And your idea of taking recovery action based on the number
> of callbacks seems like a good one while we are getting RCU's callback
> scheduling improved.
> 
> By the way, was this a real problem that you could make happen on real
> hardware?


>  If not, I would suggest just letting RCU get improved over
> the next couple of releases.


So basically use kfree_rcu but add a comment saying e.g. "WARNING:
in the future callers of kfree_rcu might need to check that
not too many callbacks get queued. In that case, we can
disable the optimization, or recover in some other way.
Watch this space."


> If it is something that you actually made happen, please let me know
> what (if anything) you need from me for your callback-counting EBUSY
> scheme.
> 
> 							Thanx, Paul

If you mean kfree_rcu causing OOM then no, it's all theoretical.
If you mean synchronize_rcu stalling to the point where guest will OOPs,
then yes, that's not too hard to trigger.

