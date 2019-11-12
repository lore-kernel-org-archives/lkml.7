Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23C3C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 17:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B465A20659
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 17:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfKLRUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 12:20:18 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35065 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfKLRUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 12:20:18 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iUZpu-0008Q4-Ut; Tue, 12 Nov 2019 18:20:15 +0100
Date:   Tue, 12 Nov 2019 18:20:14 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch V2 09/16] x86/ioperm: Move TSS bitmap update to exit to
 user work
In-Reply-To: <CALCETrU1i4_N8M0o=8hxxPFYisLsxpmDqM-GTsymORp9UeZYSg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1911121811150.1833@nanos.tec.linutronix.de>
References: <20191111220314.519933535@linutronix.de> <20191111223052.400498664@linutronix.de> <CALCETrU1i4_N8M0o=8hxxPFYisLsxpmDqM-GTsymORp9UeZYSg@mail.gmail.com>
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
> >
> > There is no point to update the TSS bitmap for tasks which use I/O bitmaps
> > on every context switch. It's enough to update it right before exiting to
> > user space.
> +
> > +static inline void switch_to_bitmap(unsigned long tifp)
> > +{
> > +       /*
> > +        * Invalidate I/O bitmap if the previous task used it. If the next
> > +        * task has an I/O bitmap it will handle it on exit to user mode.
> > +        */
> > +       if (tifp & _TIF_IO_BITMAP)
> > +               tss_invalidate_io_bitmap(this_cpu_ptr(&cpu_tss_rw));
> > +}
> 
> Shouldn't you be invalidating the io bitmap if the *next* task doesn't
> use?  Or is the rule that, when a non-io-bitmap-using task is running,
> even in kernel mode, the io bitmap is always invalid.

Well it does not make much of a difference whether we do the above or
!(tifn & _TIF_IO_BITMAP). We always end up in that code when one of the
involved tasks has TIF_IO_BITMAP set. I decided to use the sched out check
because that makes it clear that this is the end of the valid I/O
bitmap. If the next task has TIF_IO_BITMAP set as well, then it will anyway
end up in the exit to user mode update code. Clearing it here ensures that
even if the exit to user mode malfunctions the bitmap cannot be leaked.

> As it stands, you need exit_thread() to invalidate the bitmap.  I
> assume it does, but I can't easily see it in the middle of the series
> like this.

It does.
 
> IOW your code might be fine, but it could at least use some comments
> in appropriate places (exit_to_usermode_loop()?) that we guarantee
> that, if the bit is *clear*, then the TSS has the io bitmap marked
> invalid.  And add an assertion under CONFIG_DEBUG_ENTRY.
> 
> Also, do you need to update EXIT_TO_USERMODE_LOOP_FLAGS?

No, the TIF_IO_BITMAP check is done once after the loop has run and it
would not make any sense in the loop as TIF_IO_BITMAP cannot be cleared
there and we'd loop forever. The other usermode loop flags are transient.

Thanks,

	tglx


