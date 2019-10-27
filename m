Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA29CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 19:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C459D20873
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 19:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbfJ0THu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 15:07:50 -0400
Received: from gate.crashing.org ([63.228.1.57]:57536 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbfJ0THu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 15:07:50 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x9RJ7Apj017967;
        Sun, 27 Oct 2019 14:07:10 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x9RJ79gY017964;
        Sun, 27 Oct 2019 14:07:09 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Sun, 27 Oct 2019 14:07:09 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>, luto@kernel.org,
        vincenzo.frascino@arm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH] powerpc/32: Switch VDSO to C implementation.
Message-ID: <20191027190709.GZ28442@gate.crashing.org>
References: <8ce3582f7f7da9ff0286ced857e5aa2e5ae6746e.1571662378.git.christophe.leroy@c-s.fr> <alpine.DEB.2.21.1910212312520.2078@nanos.tec.linutronix.de> <f4486e86-3c0c-0eec-1639-0e5956cdb8f1@c-s.fr> <95bd2367-8edc-29db-faa3-7729661e05f2@c-s.fr> <alpine.DEB.2.21.1910261751140.10190@nanos.tec.linutronix.de> <439bce37-9c2c-2afe-9c9e-2f500472f9f8@c-s.fr> <alpine.DEB.2.21.1910262026340.10190@nanos.tec.linutronix.de> <20191026230609.GY28442@gate.crashing.org> <8e4d0b82-a7a1-b7f1-308e-df871b32d317@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e4d0b82-a7a1-b7f1-308e-df871b32d317@c-s.fr>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 27, 2019 at 10:21:25AM +0100, Christophe Leroy wrote:
> Le 27/10/2019 à 01:06, Segher Boessenkool a écrit :
> >The hand-optimised asm code will pretty likely win handsomely, whatever
> >you do.  Especially on cores like the 885 (no branch prediction, single
> >issue, small caches, etc.: every instruction counts).
> >
> >Is there any reason to replace this hand-optimised code?  It was written
> >for exacty this reason?  These functions are critical and should be as
> >fast as possible.
> 
> Well, all this started with COARSE clocks not being supported by PPC32 
> VDSO. I first submitted a series with a set of optimisations including 
> the implementation of COARSE clocks 
> (https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=126779)
> 
> Then after a comment received on patch 4 of the series from Santosh 
> Sivaraj asking for a common implementation of it for PPC32 and PPC64, I 
> started looking into making the whole VDSO source code common to PPC32 
> and PPC64. Most functions are similar. Time functions are also rather 
> similar but unfortunately don't use the same registers. They also don't 
> cover all possible clocks. And getres() is also buggy, see series 
> https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=110321

That is all nice work :-)

> So instead of reworking the existing time functions, I started 
> investigating whether we could plug powerpc to the generic 
> implementation. One drawback of PPC is that we need to setup an ASM 
> trampoline to handle the SO bit as it can't be handled from C directly, 
> can it ?

There is no way to say what CR bits to return.  The ABI requires some of
those bits to be preserved, and some are volatile.  System calls use a
different ABI, one the compiler knows nothing about, so you cannot even
show system calls as calls to the compiler.

> How critical are these functions ? Although we have a slight degration 
> with the C implementation, they are still way faster than the 
> corresponding syscall.

"Slight":

	With current powerpc/32 ASM VDSO:

	gettimeofday:    vdso: 750 nsec/call
	clock-getres-realtime:    vdso: 382 nsec/call
	clock-gettime-realtime:    vdso: 928 nsec/call
	clock-getres-monotonic:    vdso: 382 nsec/call
	clock-gettime-monotonic:    vdso: 1033 nsec/call

	Once switched to C implementation:

	gettimeofday:    vdso: 1533 nsec/call
	clock-getres-realtime:    vdso: 853 nsec/call
	clock-gettime-realtime:    vdso: 1570 nsec/call
	clock-getres-monotonic:    vdso: 835 nsec/call
	clock-gettime-monotonic:    vdso: 1605 nsec/call


---> Those that are not more than two times slower are almost that. <---


This also needs measurements on more representative PowerPC cores, say
some G3 or G4; and on modern CPUs (Power7/8/9).

It also needs context with those measurements: what CPU core is it?
Running at what frequency clock?

> Another thing I was wondering, is it worth using the 64 bit timebase on 
> PPC32 ? As far as I understand, the timebase is there to calculate a 
> linear date update since last VDSO datapage update. How often is the 
> VDSO datapage updated ? On the 885 clocked at 132Mhz, the timebase is at 
> 8.25 Mhz, which means it needs more than 8 minutes to loop over 32 bits.

On most PowerPC cores the time base is incremented significantly faster.
Usual speeds for older cores are 50MHz to 100MHz, and for newer cores ten
times that.  Recommended frequency is currently 512MHz, so you'll wrap the
low 32 bits in 8s or so on those, and in about a minute on many powermac
etc. machines already.  How can you know this long hasn't passed since the
last time you read the high half of the time base?  Without reading that
high part?

The current (assembler) code already optimises converting this to some
other scale quite well, better than a compiler can (see __do_get_tspec).


Segher
