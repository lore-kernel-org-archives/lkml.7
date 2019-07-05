Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1284AC46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 20:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5B1C21670
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 20:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbfGEUZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 16:25:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36006 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbfGEUZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 16:25:44 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hjUm4-0007CQ-Oe; Fri, 05 Jul 2019 22:25:40 +0200
Date:   Fri, 5 Jul 2019 22:25:39 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Nadav Amit <namit@vmware.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Feng Tang <feng.tang@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [patch V2 04/25] x86/apic: Make apic_pending_intr_clear() more
 robust
In-Reply-To: <958a67c2-4dc0-52e6-43b2-1ebd25a59232@citrix.com>
Message-ID: <alpine.DEB.2.21.1907052213360.3648@nanos.tec.linutronix.de>
References: <20190704155145.617706117@linutronix.de> <20190704155608.636478018@linutronix.de> <958a67c2-4dc0-52e6-43b2-1ebd25a59232@citrix.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-737971544-1562358340=:3648"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-737971544-1562358340=:3648
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

Andrew,

On Fri, 5 Jul 2019, Andrew Cooper wrote:

> On 04/07/2019 16:51, Thomas Gleixner wrote:
> >   2) The loop termination logic is interesting at best.
> >
> >      If the machine has no TSC or cpu_khz is not known yet it tries 1
> >      million times to ack stale IRR/ISR bits. What?
> >
> >      With TSC it uses the TSC to calculate the loop termination. It takes a
> >      timestamp at entry and terminates the loop when:
> >
> >      	  (rdtsc() - start_timestamp) >= (cpu_hkz << 10)
> >
> >      That's roughly one second.
> >
> >      Both methods are problematic. The APIC has 256 vectors, which means
> >      that in theory max. 256 IRR/ISR bits can be set. In practice this is
> >      impossible as the first 32 vectors are reserved and not affected and
> >      the chance that more than a few bits are set is close to zero.
> 
> [Disclaimer.  I talked to Thomas in private first, and he asked me to
> post this publicly as the CVE is almost a decade old already.]

thanks for bringing this up!

> I'm afraid that this isn't quite true.
> 
> In terms of IDT vectors, the first 32 are reserved for exceptions, but
> only the first 16 are reserved in the LAPIC.  Vectors 16-31 are fair
> game for incoming IPIs (SDM Vol3, 10.5.2 Valid Interrupt Vectors).

Indeed.

> In practice, this makes Linux vulnerable to CVE-2011-1898 / XSA-3, which
> I'm disappointed to see wasn't shared with other software vendors at the
> time.

No comment.

> Because TPR is 0, an incoming IPI can trigger #AC, #CP, #VC or #SX
> without an error code on the stack, which results in a corrupt pt_regs
> in the exception handler, and a stack underflow on the way back out,
> most likely with a fault on IRET.
> 
> These can be addressed by setting TPR to 0x10, which will inhibit

Right, that's easy and obvious.

> delivery of any errant IPIs in this range, but some extra sanity logic
> may not go amiss.  An error code on a 64bit stack can be spotted with
> `testb $8, %spl` due to %rsp being aligned before pushing the exception
> frame.

The question is what we do with that information :)

> Another interesting problem is an IPI which its vector 0x80.  A cunning
> attacker can use this to simulate system calls from unsuspecting
> positions in userspace, or for interrupting kernel context.  At the very
> least the int0x80 path does an unconditional swapgs, so will try to run
> with the user gs, and I expect things will explode quickly from there.

Cute.

> One option here is to look at ISR and complain if it is found to be set.

That's sloooow, but could at least provide an option to do so.

> Another option, which I've only just remembered, is that AMD hardware
> has the Interrupt Enable Register in its extended APIC space, which may
> or may not be good enough to prohibit delivery of 0x80.  There isn't
> enough information in the APM to be clear, but the name suggests it is
> worth experimenting with.

I doubt it. Clearing a bit in the IER takes the interrupt out of the
priority decision logic. That's a SVM feature so interrupts directed
directly to guests cannot block other interrupts if they are not
serviced. It's grossly misnomed and won't help with the int80 issue.

The more interesting question is whether this is all relevant. If I
understood the issue correctly then this is mitigated by proper interrupt
remapping.

Is there any serious usage of virtualization w/o interrupt remapping left
or have the machines which are not capable been retired already?

Thanks,

	tglx
--8323329-737971544-1562358340=:3648--
