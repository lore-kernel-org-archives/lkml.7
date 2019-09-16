Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39403C4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 13:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19CF921848
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 13:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387989AbfIPNnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 09:43:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:59850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387955AbfIPNnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 09:43:18 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55C0B216C8;
        Mon, 16 Sep 2019 13:43:16 +0000 (UTC)
Date:   Mon, 16 Sep 2019 09:43:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        John Ogness <john.ogness@linutronix.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Andrea Parri <parri.andrea@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
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
Message-ID: <20190916094314.6053f988@gandalf.local.home>
In-Reply-To: <20190916104624.n3jh363z37ah2kxa@pathway.suse.cz>
References: <20190807222634.1723-1-john.ogness@linutronix.de>
        <20190904123531.GA2369@hirez.programming.kicks-ass.net>
        <20190905130513.4fru6yvjx73pjx7p@pathway.suse.cz>
        <20190905143118.GP2349@hirez.programming.kicks-ass.net>
        <alpine.DEB.2.21.1909051736410.1902@nanos.tec.linutronix.de>
        <20190905121101.60c78422@oasis.local.home>
        <alpine.DEB.2.21.1909091507540.1791@nanos.tec.linutronix.de>
        <87k1acz5rx.fsf@linutronix.de>
        <cfc7b1fa-e629-19a6-154b-0dd4f5604aa7@I-love.SAKURA.ne.jp>
        <20190916104624.n3jh363z37ah2kxa@pathway.suse.cz>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Sep 2019 12:46:24 +0200
Petr Mladek <pmladek@suse.com> wrote:

> On Mon 2019-09-16 13:30:17, Tetsuo Handa wrote:
> > On 2019/09/13 22:26, John Ogness wrote:  
> > > 6. A new may-sleep function pr_flush() will be made available to wait
> > > for all previously printk'd messages to be output on all consoles before
> > > proceeding. For example:
> > > 
> > >     pr_cont("Running test ABC... ");
> > >     pr_flush();
> > > 
> > >     do_test();
> > > 
> > >     pr_cont("PASSED\n");
> > >     pr_flush();  
> > 
> > Don't we need to allow printk() callers to know the sequence number which
> > the printk() has queued? Something like
> > 
> >   u64 seq;
> >   pr_info(...);
> >   pr_info(...);
> >   pr_info(...);
> >   seq = pr_current_seq();
> >   pr_wait_seq(seq);
> > 
> > in case concurrently executed printk() flooding keeps adding a lot of
> > pending output?  
> 
> My expectation is that pr_flush() would wait only until the current
> message appears on all consoles. It will not wait for messages that
> would get added later.

Right, I believe we agreed that pr_flush() would take care of all this.

> 
> 
> > By the way, do we need to keep printk() return bytes like printf() ?
> > Maybe we can make printk() return "void", for almost nobody can do
> > meaningful things with the return value.  
> 
> It is true that I have never seen anyone checking the return value.
> On the other hand, it is a minor detail. And I would prefer to stay
> compatible with the userland printf() as much as possible.

I understand your wanting to keep compatibility with printf(), but I
would suggest that we only do so if it doesn't complicate any of the
design. I'm actually leaning on recommending that we remove the return
value, to prevent there becoming a dependency on it. I don't see any
reason to have the "number of bytes processed" as the return value
being useful within the kernel.

> 
> 
> > > 9. Support for printk dictionaries will be discontinued. I will look
> > > into who is using this and why. If printk dictionaries are important for
> > > you, speak up now!  
> > 
> > I think that dev_printk() is using "const char *dict, size_t dictlen," part
> > via create_syslog_header(). Some userspace programs might depend on
> > availability of such information.  
> 
> Yeah, but it seems to be the only dictionary writer. There were doubts
> (during the meeting) whether anyone was actually using the information.
> 
> Hmm, it seems that journalctl is able to filer device specific
> information, for example, I get:
> 
> $> journalctl _KERNEL_DEVICE=+usb:2-1  
> -- Logs begin at Tue 2019-08-13 09:00:03 CEST, end at Mon 2019-09-16 12:32:58 CEST. --
> Aug 13 09:00:04 linux-qszd kernel: usb 2-1: new high-speed USB device number 2 using ehci-pci
> 
> One question is if anyone is using this filtering. Simple grep is
> enough. Another question is whether it really needs to get passed
> this way.
> 

If worse comes to worse, perhaps we let the console decide what to do
with it. Where all consoles but the "kmsg" one ignores it?

Then journalctl should work as normal.

Or will this break one of our other changes?

-- Steve

