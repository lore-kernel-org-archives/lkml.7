Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05665C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 21:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1F2321D79
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 21:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfKGVcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 16:32:24 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49680 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfKGVcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 16:32:24 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iSpO4-0006A0-GZ; Thu, 07 Nov 2019 22:32:16 +0100
Date:   Thu, 7 Nov 2019 22:32:15 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Brian Gerst <brgerst@gmail.com>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch 5/9] x86/ioport: Reduce ioperm impact for sane usage
 further
In-Reply-To: <CAMzpN2gt4qM41=96GpNHL-kbgBsjD-zphq+5oK0BXqoCFN4F4Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1911072223000.27903@nanos.tec.linutronix.de>
References: <20191106193459.581614484@linutronix.de> <20191106202806.241007755@linutronix.de> <CAMzpN2juuUyLuQ-tiV7hKZvG4agsHKP=rRAt_V4sZhpZW7cv9g@mail.gmail.com> <CAHk-=wiGO=+mmEb-sfCsD5mxmL5++gdwkFj_aXcfz1R41MJnEg@mail.gmail.com>
 <CAMzpN2gt4qM41=96GpNHL-kbgBsjD-zphq+5oK0BXqoCFN4F4Q@mail.gmail.com>
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

On Thu, 7 Nov 2019, Brian Gerst wrote:
> On Thu, Nov 7, 2019 at 2:54 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Thu, Nov 7, 2019 at 11:24 AM Brian Gerst <brgerst@gmail.com> wrote:
> > >
> > > Here is a different idea:  We already map the TSS virtually in
> > > cpu_entry_area.  Why not page-align the IO bitmap and remap it to the
> > > task's bitmap on task switch?  That would avoid all copying on task
> > > switch.
> >
> > We map the tss _once_, statically, percpu, without ever changing it,
> > and then we just (potentially) change a couple of fields in it on
> > process switch.
> >
> > Your idea isn't horrible, but it would involve a TLB flush for the
> > page when the io bitmap changes. Which is almost certainly more
> > expensive than just copying the bitmap intelligently.
> >
> > Particularly since I do think that the copy can basically be done
> > effectively never, assuming there really aren't multiple concurrent
> > users of ioperm() (and iopl).
> 
> There wouldn't have to be a flush on every task switch.  If we make it
> so that tasks that don't use a bitmap just unmap the pages in the
> cpu_entry_area and set tss.io_bitmap_base to outside the segment
> limit, we would only have to flush when switching from a task using
> the bitmap (because the next task uses a different bitmap or we are
> unmapping it).  If the previous task doesn't have a bitmap the pages
> in cpu_entry_area were unmapped and can't be in the TLB, so no flush
> is needed.

Funny. I was just debating exactly this with Peter Ziljstra over IRC :)
 
> Going a step further, we could track which task is mapped to the
> current cpu like proposed above, and only flush when a different task
> needs the IO bitmap, or when the bitmap is being freed on task exit.

Yes.

But, we really should check what aside of DoSemu is using this still. None
of my machines I checked have a single instance of ioperm()/iopl() usage.

So the real question is whether it's worth the trouble or if we are just
better off to copy if there is an actual user and the sequence count of the
bitmap is different than the one which was active last time.

Thanks,

	tglx




