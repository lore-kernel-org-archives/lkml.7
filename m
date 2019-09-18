Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80EDAC4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 16:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 623CD218AF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 16:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387700AbfIRQl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 12:41:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:43250 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387625AbfIRQl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 12:41:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 196B6AE40;
        Wed, 18 Sep 2019 16:41:56 +0000 (UTC)
Date:   Wed, 18 Sep 2019 18:41:55 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Andrea Parri <parri.andrea@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Paul Turner <pjt@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Prarit Bhargava <prarit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: printk meeting at LPC
Message-ID: <20190918164155.ymyuro6u442fa22j@pathway.suse.cz>
References: <alpine.DEB.2.21.1909091507540.1791@nanos.tec.linutronix.de>
 <87k1acz5rx.fsf@linutronix.de>
 <20190918012546.GA12090@jagdpanzerIV>
 <20190917220849.17a1226a@oasis.local.home>
 <20190918023654.GB15380@jagdpanzerIV>
 <20190918051933.GA220683@jagdpanzerIV>
 <87h85anj85.fsf@linutronix.de>
 <20190918081012.GB37041@jagdpanzerIV>
 <20190918081012.GB37041@jagdpanzerIV>
 <877e66nfdz.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877e66nfdz.fsf@linutronix.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2019-09-18 11:05:28, John Ogness wrote:
> On 2019-09-18, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
> >> Each console has its own iterator. This iterators will need to
> >> advance, regardless if the message was printed via write() or
> >> write_atomic().
> >
> > Great.
> >
> > ->atomic_write() path will make sure that kthread is parked or will
> > those compete for uart port?
> 
> A cpu-lock (probably per-console) will be used to synchronize the
> two. Unlike my RFCv1, we want to keep the cpu-lock out of the console
> drivers and we want it to be less aggressive (using trylock's instead of
> spinning). This should make the cpu-lock less "dangerous". I talked with
> PeterZ, Thomas, and PetrM about how this can be implemented, but there
> may still be some corner cases.

If we take cpu_lock() only in non-preemptive context and the system is
normally working then try_lock() should be pretty reliable. I mean
that try_lock() would either succeed or the other CPU would be able
to flush the messages.

We might need to be more aggressive in panic(). But then it should be
easier because only one CPU can be running panic. This CPU would try
to stop the other CPUs and flush the consoles.

I though also about reusing the console-waiter logic in panic()
We could try to steel the cpu_lock() a more safe way. We would only
need to limit the busy waiting to 1 sec or so.

Regarding SysRq. I could imagine introducing another SysRq that
would just call panic(). I mean that it would try to flush the
logs and reboot in the most safe way.

I am not completely sure what to do with suspend, halt, and other
operations where we could not rely on the kthread. I would prefer to
allow only atomic consoles there in the beginning.

These are just some ideas. I do not think that everything needs to be
done immediately. I am sure that we will break some scenarios. We
should not complicate the code too much proactively because of
scenarios that are not much reliable even now.


> I would like to put everything together now so that we can run and test
> if the decisions made in that meeting hold up for all the cases. I think
> it will be easier to identify/add the missing pieces, once we have it
> coded.

Make sense. Just please, do not hold the entire series until all
details are solved.

It is always easier to review small pieces. Also it is a big pain
to rework/rebase huge series. IMHO, we need to reasonably handle
normal state and panic() at the beginning. All the other special
situations can be solved by follow up patches.

Best Regards,
Petr
