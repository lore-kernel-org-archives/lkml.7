Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F06DC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 17:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E0012196E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 17:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbfKLRLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 12:11:01 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35030 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbfKLRLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 12:11:00 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iUZgv-0008Dy-2g; Tue, 12 Nov 2019 18:10:57 +0100
Date:   Tue, 12 Nov 2019 18:10:56 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [patch V2 08/16] x86/ioperm: Add bitmap sequence number
In-Reply-To: <CALCETrXcBpxwvoPtqa1-c+SF+4K9oeebUA_JFNaN2Yn2USwVNA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1911121809020.1833@nanos.tec.linutronix.de>
References: <20191111220314.519933535@linutronix.de> <20191111223052.292300453@linutronix.de> <CALCETrXcBpxwvoPtqa1-c+SF+4K9oeebUA_JFNaN2Yn2USwVNA@mail.gmail.com>
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
> >         /*
> > +        * The bitmap pointer and the sequence number of the last active
> > +        * bitmap. last_bitmap cannot be dereferenced. It's solely for
> > +        * comparison.
> > +        */
> > +       struct io_bitmap        *last_bitmap;
> > +       u64                     last_sequence;
> > +
> > +       /*
> >          * Store the dirty size of the last io bitmap offender. The next
> >          * one will have to do the cleanup as the switch out to a non io
> >          * bitmap user will just set x86_tss.io_bitmap_base to a value
> 
> Why is all this stuff in the TSS?  Would it make more sense in a
> percpu variable tss_state?  By putting it in the TSS, you're putting
> it in cpu_entry_area, which is at least a bit odd if not an actual
> security problem.
> 
> And why do you need a last_bitmap pointer?  I thin that comparing just
> last_sequence should be enough.  Keeping last_bitmap around at all is
> asking for trouble, since it might point to freed memory.

The bitmap pointer is pointless as I said in an earlier reply to Peter. It
will go away. The sequence number and the dirty size are surely not a
problem leakage wise, but yes, we could put it into a per cpu variable as
well. Not sure whether it buys much.
 
> > -               memcpy(tss->io_bitmap_bytes, iobm->bitmap_bytes,
> > -                      max(tss->io_bitmap_prev_max, iobm->io_bitmap_max));
> > +               if (tss->last_bitmap != iobm ||
> > +                   tss->last_sequence != iobm->sequence)
> 
> As above, I think this could just be if (tss->last_sequence !=
> iobm->sequence) or even if (this_cpu_read(cpu_tss_state.iobm_sequence)
> != iobm->sequence).

Already fixed as per Peter's comments.

Thanks,

	tglx
