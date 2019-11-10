Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A491BC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 12:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79DE820869
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 12:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfKJMgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 07:36:15 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54541 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbfKJMgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 07:36:14 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iTmRr-0005NX-EL; Sun, 10 Nov 2019 13:36:07 +0100
Date:   Sun, 10 Nov 2019 13:36:04 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch 2/9] x86/process: Unify copy_thread_tls()
In-Reply-To: <alpine.DEB.2.21.1911090040520.2605@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1911101332490.12583@nanos.tec.linutronix.de>
References: <20191106193459.581614484@linutronix.de> <20191106202805.948064985@linutronix.de> <53a6f346-fca1-ac04-ee34-6d472a0d4408@kernel.org> <alpine.DEB.2.21.1911090040520.2605@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Nov 2019, Thomas Gleixner wrote:
> On Fri, 8 Nov 2019, Andy Lutomirski wrote:
> > On 11/6/19 11:35 AM, Thomas Gleixner wrote:
> > > +static inline int copy_io_bitmap(struct task_struct *tsk)
> > > +{
> > > +	if (likely(!test_tsk_thread_flag(current, TIF_IO_BITMAP)))
> > > +		return 0;
> > > +
> > > +	tsk->thread.io_bitmap_ptr = kmemdup(current->thread.io_bitmap_ptr,
> > > +					    IO_BITMAP_BYTES, GFP_KERNEL);
> > 
> > tsk->thread.io_bitmap_max = current->thread.io_bitmap_max?
> > 
> > I realize you inherited this from the code you're refactoring, but it
> > does seem to be missing.
> 
> It already got copied with the task struct :)
>  
> > > +#ifdef CONFIG_X86_64
> > > +	savesegment(gs, p->thread.gsindex);
> > > +	p->thread.gsbase = p->thread.gsindex ? 0 : current->thread.gsbase;
> > > +	savesegment(fs, p->thread.fsindex);
> > > +	p->thread.fsbase = p->thread.fsindex ? 0 : current->thread.fsbase;
> > > +	savesegment(es, p->thread.es);
> > > +	savesegment(ds, p->thread.ds);
> > > +#else
> > > +	/* Clear all status flags including IF and set fixed bit. */
> > > +	frame->flags = X86_EFLAGS_FIXED;
> > > +#endif
> > 
> > Want to do another commit to make the eflags fixup unconditional?  I'm
> > wondering if we have a bug.
> 
> Let me look at that.

64bit does not have flags in the inactive_task_frame ...

Thanks,

	tglx
