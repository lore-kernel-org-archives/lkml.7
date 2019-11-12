Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A7DC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 09:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64222206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 09:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfKLJz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 04:55:29 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33033 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfKLJz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 04:55:28 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iUStR-0007OB-Pn; Tue, 12 Nov 2019 10:55:25 +0100
Date:   Tue, 12 Nov 2019 10:55:24 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [patch V2 08/16] x86/ioperm: Add bitmap sequence numberc
In-Reply-To: <20191112092246.GY4131@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1911121051490.1833@nanos.tec.linutronix.de>
References: <20191111220314.519933535@linutronix.de> <20191111223052.292300453@linutronix.de> <20191112092246.GY4131@hirez.programming.kicks-ass.net>
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

On Tue, 12 Nov 2019, Peter Zijlstra wrote:
> On Mon, Nov 11, 2019 at 11:03:22PM +0100, Thomas Gleixner wrote:
> > Add a globally unique sequence number which is incremented when ioperm() is
> > changing the I/O bitmap of a task. Store the new sequence number in the
> > io_bitmap structure and compare it along with the actual struct pointer
> > with the one which was last loaded on a CPU. Only update the bitmap if
> > either of the two changes. That should further reduce the overhead of I/O
> > bitmap scheduling when there are only a few I/O bitmap users on the system.
> 
> > +	/* Update the sequence number to force an update in switch_to() */
> > +	iobm->sequence = atomic64_add_return(1, &io_bitmap_sequence);
> 
> > +		if (tss->last_bitmap != iobm ||
> > +		    tss->last_sequence != iobm->sequence)
> > +			switch_to_update_io_bitmap(tss, iobm);
> 
> Initially I wondered why we need a globally unique sequence number if we
> already check the struct iobitmap pointer. That ought to make the
> sequence number per-object.
> 
> However, that breaks for memory re-use. So yes, we need that thing to be
> global.

Actually with a global 64bit wide counter we can just avoid the pointer
comparison. Assumed a ioperm() syscall every nanosecond it takes about 584
years of uptime to wrap around. :)

Thanks,

	tglx

