Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D5AC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 18:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9E702178F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 18:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbfKGSCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 13:02:36 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48969 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbfKGSCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 13:02:36 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iSm77-0002uf-C2; Thu, 07 Nov 2019 19:02:33 +0100
Date:   Thu, 7 Nov 2019 19:02:27 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ingo Molnar <mingo@kernel.org>
cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch 5/9] x86/ioport: Reduce ioperm impact for sane usage
 further
In-Reply-To: <20191107081635.GE30739@gmail.com>
Message-ID: <alpine.DEB.2.21.1911071856420.27903@nanos.tec.linutronix.de>
References: <20191106193459.581614484@linutronix.de> <20191106202806.241007755@linutronix.de> <20191107081635.GE30739@gmail.com>
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

On Thu, 7 Nov 2019, Ingo Molnar wrote:
> * Thomas Gleixner <tglx@linutronix.de> wrote:
> This might seem like a small detail, but since we do the range tracking 
> and copying at byte granularity anyway, why not do the zero range search 
> at byte granularity as well?
> 
> I bet it's faster and simpler as well than the bit-searching.

Not necessarily. The bitmap search uses unsigned long internally at least
to the point where it finds a zero bit.

But probably we should just ditch that optimization and rather have the
sequence number to figure out whether something needs to be copied at all.

> > +	if (first >= IO_BITMAP_BITS) {
> > +		/*
> > +		 * If the resulting bitmap has all permissions dropped, clear
> > +		 * TIF_IO_BITMAP and set the IO bitmap offset in the TSS to
> > +		 * invalid. Deallocate both the new and the thread's bitmap.
> > +		 */
> > +		clear_thread_flag(TIF_IO_BITMAP);
> > +		tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_INVALID;
> > +		tofree = bitmap;
> > +		bitmap = NULL;
> 
> BTW., wouldn't it be simpler to just say that if a thread uses IO ops 
> even once, it gets a bitmap and that's it? I.e. we could further simplify 
> this seldom used piece of code.

Maybe.
 
> > +	} else {
> >  		/*
> > +		 * I/O bitmap contains zero bits. Set TIF_IO_BITMAP, make
> > +		 * the bitmap offset valid and make sure that the TSS limit
> > +		 * is correct. It might have been wreckaged by a VMEXiT.
> >  		 */
> > +		set_thread_flag(TIF_IO_BITMAP);
> > +		tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_VALID;
> >  		refresh_tss_limit();
> >  	}
> 
> I'm wondering, shouldn't we call refresh_tss_limit() in both branches, or 
> is a VMEXIT-wreckaged TSS limit harmless if we otherwise have 
> io_bitmap_base set to IO_BITMAP_OFFSET_INVALID?

Yes. because the VMEXIT wreckage restricts TSS limit to 0x67 which is the
end of the hardware tss struct. As the invalid offset points in any case
outside the TSS limit it does not matter. It always #GP's when an I/O
access happens in user space.

Thanks,

	tglx
