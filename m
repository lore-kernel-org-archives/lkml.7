Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE41C0650E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 08:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E86520830
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 08:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfGGI1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 04:27:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37524 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbfGGI1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 04:27:41 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hk2WA-0002bP-AD; Sun, 07 Jul 2019 10:27:30 +0200
Date:   Sun, 7 Jul 2019 10:27:29 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Feng Tang <feng.tang@intel.com>
Subject: Re: [patch V2 04/25] x86/apic: Make apic_pending_intr_clear() more
 robust
In-Reply-To: <CALCETrXPX5CXOOVHhN2Npvxh=ZRSA4ttC+VaNekF1W13Z=FLkA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1907071025440.3648@nanos.tec.linutronix.de>
References: <20190704155145.617706117@linutronix.de> <20190704155608.636478018@linutronix.de> <958a67c2-4dc0-52e6-43b2-1ebd25a59232@citrix.com> <CALCETrVomGF-OmWxdaX9axih1kz345rEFop=vZtcKwGR8U-gwQ@mail.gmail.com> <alpine.DEB.2.21.1907052227140.3648@nanos.tec.linutronix.de>
 <CALCETrXPX5CXOOVHhN2Npvxh=ZRSA4ttC+VaNekF1W13Z=FLkA@mail.gmail.com>
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

On Fri, 5 Jul 2019, Andy Lutomirski wrote:
> On Fri, Jul 5, 2019 at 1:36 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > No. We can map the APIC into the user space visible page tables for PTI
> > without compromising the PTI isolation and it can be read very early on
> > before SWAPGS. All you need is a register to clobber not more. It the ISR
> > is set, then go into an error path, yell loudly, issue EOI and return.
> > The only issue I can see is: It's slow :)
> >
> I think this will be really extremely slow.  If we can restrict this
> to x2apic machines, then maybe it's not so awful.

x2apic machines have working iommu/interrupt remapping.

> FWIW, if we just patch up the GS thing, then we are still vulnerable:
> the bad guy can arrange for a privileged process to have register
> state corresponding to a dangerous syscall and then send an int $0x80
> via the APIC.

Right, that's why you want to read the APIC:ISR to check where that thing
came from.

Thanks,

	tglx


