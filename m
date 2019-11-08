Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB1DC17441
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 23:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0F7F215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 23:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730379AbfKHXpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 18:45:55 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52813 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfKHXpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 18:45:54 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iTDwq-0005lm-Bj; Sat, 09 Nov 2019 00:45:49 +0100
Date:   Sat, 9 Nov 2019 00:45:47 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch 4/9] x86/io: Speedup schedule out of I/O bitmap user
In-Reply-To: <c753068f-adae-92a1-a6a9-bcb1e74829c2@kernel.org>
Message-ID: <alpine.DEB.2.21.1911090043430.2605@nanos.tec.linutronix.de>
References: <20191106193459.581614484@linutronix.de> <20191106202806.133597409@linutronix.de> <20191107091231.GA4131@hirez.programming.kicks-ass.net> <alpine.DEB.2.21.1911071502350.4256@nanos.tec.linutronix.de> <alpine.DEB.2.21.1911071508020.4256@nanos.tec.linutronix.de>
 <c753068f-adae-92a1-a6a9-bcb1e74829c2@kernel.org>
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

On Fri, 8 Nov 2019, Andy Lutomirski wrote:
> On 11/7/19 6:08 AM, Thomas Gleixner wrote:
> > On Thu, 7 Nov 2019, Thomas Gleixner wrote:
> >> Just that I can't add the storage to tss_struct due to the VMX insanity of
> >> setting TSS limit hard to 0x67 on vmexit instead of restoring the host
> >> value.
> > 
> > Well, I can. The build bugon in vmx.c is just bogus.
> 
> SDM vol 3 27.5.2 says the BUILD_BUG_ON is right.  Or am I
> misunderstanding you?
> 
> I'm reasonably confident that the TSS limit is indeed 0x67 after VM
> exit, and I wrote the existing code that tries to optimize this to avoid
> LTR when not needed.

The BUILD_BUG_ON(IO_BITMAP_OFFSET - 1 == 0x67) in the VMX code is bogus in
two aspects:

1) This wants to be in generic x86 code

2) The IO_BITMAP_OFFSET is not the right thing to check because it makes
   asssumptions about the layout of tss_struct. Nothing requires that the
   I/O bitmap is placed right after x86_tss, which is the hardware mandated
   tss structure. It pointlessly makes restrictions on the struct
   tss_struct layout.

The proper thing to check is:

    - Offset of x86_tss in tss_struct is 0
    - Size of x86_tss == 0x68

We already have the page alignment sanity check off TSS in
cpu_entry_area.c. That's where this should have gone into in the first
place.

Thanks,

	tglx
