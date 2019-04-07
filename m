Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FD8C10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 09:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB3932087F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 09:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbfDGJef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 05:34:35 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50730 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfDGJee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 05:34:34 -0400
Received: from p5492ee6e.dip0.t-ipconnect.de ([84.146.238.110] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hD4C4-0000Fi-DE; Sun, 07 Apr 2019 11:34:28 +0200
Date:   Sun, 7 Apr 2019 11:34:27 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@amacapital.net>
cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [patch V2 28/29] x86/irq/64: Remap the IRQ stack with guard
 pages
In-Reply-To: <50F7A079-11F5-45EA-B378-7527B5920A7C@amacapital.net>
Message-ID: <alpine.DEB.2.21.1904071132120.1840@nanos.tec.linutronix.de>
References: <20190405150658.237064784@linutronix.de> <20190405150930.967389183@linutronix.de> <CALCETrWF_YgQODJ=Rpm2MnhFxJXCfoo4H792hUQni0GS9on7og@mail.gmail.com> <alpine.DEB.2.21.1904070803200.1840@nanos.tec.linutronix.de>
 <50F7A079-11F5-45EA-B378-7527B5920A7C@amacapital.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-134637912-1554629668=:1840"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-134637912-1554629668=:1840
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Sun, 7 Apr 2019, Andy Lutomirski wrote:
> > On Apr 6, 2019, at 11:08 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > 
> >> On Sat, 6 Apr 2019, Andy Lutomirski wrote:
> >>> On Fri, Apr 5, 2019 at 8:11 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >>> 
> >>> From: Andy Lutomirski <luto@kernel.org>
> >>> 
> >>> The IRQ stack lives in percpu space, so an IRQ handler that overflows it
> >>> will overwrite other data structures.
> >>> 
> >>> Use vmap() to remap the IRQ stack so that it will have the usual guard
> >>> pages that vmap/vmalloc allocations have. With this the kernel will panic
> >>> immediately on an IRQ stack overflow.
> >> 
> >> The 0day bot noticed that this dies with DEBUG_PAGEALLOC on.  This is
> >> because the store_stackinfo() function is utter garbage and this patch
> >> correctly detects just how broken it is.  The attached patch "fixes"
> >> it.  (It also contains a reliability improvement that should probably
> >> get folded in, but is otherwise unrelated.)
> >> 
> >> A real fix would remove the generic kstack_end() function entirely
> >> along with __HAVE_ARCH_KSTACK_END and would optionally replace
> >> store_stackinfo() with something useful.  Josh, do we have a generic
> >> API to do a little stack walk like this?  Otherwise, I don't think it
> >> would be the end of the world to just remove the offending code.
> > 
> > Yes, I found the same yesterday before heading out. It's already broken
> > with the percpu stack because there is no guarantee that the per cpu stack
> > is thread size aligned. It's guaranteed to be page aligned not more.
> > 
> > I'm all for removing that nonsense, but the real question is whether there
> > is more code which assumes THREAD_SIZE aligned stacks aside of the thread
> > stack itself.
> > 
> > 
> Well, any code like this is already busted, since the stacks alignment
> doesn’t really change with these patches applied.

It does. The existing code has it aligned by chance because the irq stack
is the first entry in the per cpu area. But yes, there is no reason to require
that alignment for irqstacks.

Thanks,

	tglx

--8323329-134637912-1554629668=:1840--
