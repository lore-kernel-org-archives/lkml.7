Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93838C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 17:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72AF820679
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 17:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfKLRIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 12:08:34 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35003 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfKLRIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 12:08:34 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iUZeW-00088p-Ox; Tue, 12 Nov 2019 18:08:29 +0100
Date:   Tue, 12 Nov 2019 18:08:27 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch V2 06/16] x86/io: Speedup schedule out of I/O bitmap
 user
In-Reply-To: <CALCETrUcY_DhZC8CH0NhoRp_r6mh4v1Z2dmhsdErV8wx6FsLaw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1911121807260.1833@nanos.tec.linutronix.de>
References: <20191111220314.519933535@linutronix.de> <20191111223052.086299881@linutronix.de> <CALCETrUcY_DhZC8CH0NhoRp_r6mh4v1Z2dmhsdErV8wx6FsLaw@mail.gmail.com>
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

On Tue, 12 Nov 2019, Andy Lutomirski wrote:
> On Mon, Nov 11, 2019 at 2:35 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > @@ -50,6 +48,11 @@ long ksys_ioperm(unsigned long from, uns
> >                  * limit correct.
> >                  */
> >                 preempt_disable();
> > +               t->io_bitmap_ptr = bitmap;
> > +               set_thread_flag(TIF_IO_BITMAP);
> > +               /* Make the bitmap base in the TSS valid */
> > +               tss = this_cpu_ptr(&cpu_tss_rw);
> > +               tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_VALID;
> >                 refresh_tss_limit();
> >                 preempt_enable();
> >         }
> 
> It's not shown in the diff, but the very next line of code turns
> preemption back off.  This means that we might schedule right here
> with TIF_IO_BITMAP set, the base set to VALID, but the wrong data in
> the bitmap.  I *think* this will actually end up being okay, but it
> certainly makes understanding the code harder.  Can you adjust the
> code so that preemption stays off?
> 
> More importantly, the code below this modifies the TSS copy in place
> instead of writing a whole new copy.  But now that you've added your
> optimization, the TSS copy might be *someone else's* IO bitmap.  So I
> think you might end up with more io ports allowed than you intended.
> For example:
> 
> Task A uses ioperm() to enable all ports.
> Switch to task B.  Now the TSS base is INVALID but all bitmap bits are still 0.
> Task B calls ioperm().
> 
> The code will set the base to VALID and will correctly set up the
> thread's copy of the bitmap, but I think the copy will only update the
> bits 0 through whatever ioperm() touched and not the bits above that
> in the TSS.

Yeah, you are right. Did not think about that. Will fix that up.
 
> I would believe that this is fixed later in your patch set.  If so,
> perhaps you should just memcpy() the whole thing without trying to
> optimize in this patch and then let the changes later re-optimize it
> as appropriate.  IOW change memcpy(tss->io_bitmap, t->io_bitmap_ptr,
> bytes_updated); to memcpy(..., BYTES_PER_LONG * IO_BITMAP_LONGS) or
> similar.

Right.

Thanks for spotting that!

       tglx
