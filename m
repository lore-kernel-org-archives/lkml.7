Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391F8C31E50
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 22:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C93120679
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 22:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfFPW0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 18:26:18 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42137 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727238AbfFPW0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 18:26:18 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hcdbC-0000Te-W9; Mon, 17 Jun 2019 00:26:07 +0200
Date:   Mon, 17 Jun 2019 00:26:01 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Kees Cook <keescook@chromium.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] x86/asm: Pin sensitive CR4 bits
In-Reply-To: <201906142012.C18377C5@keescook>
Message-ID: <alpine.DEB.2.21.1906170008580.1760@nanos.tec.linutronix.de>
References: <20190604234422.29391-1-keescook@chromium.org> <20190604234422.29391-2-keescook@chromium.org> <alpine.DEB.2.21.1906141646320.1722@nanos.tec.linutronix.de> <201906142012.C18377C5@keescook>
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

On Fri, 14 Jun 2019, Kees Cook wrote:

> On Fri, Jun 14, 2019 at 04:57:36PM +0200, Thomas Gleixner wrote:
> > Wouldn't it make sense to catch situations where a regular caller provides
> > @val with pinned bits unset? I.e. move the OR into this code path after
> > storing bits_missing.
> 
> I mentioned this in the commit log, but maybe I wasn't very clear:
> 
> > > Since these bits are global state (once established by the boot CPU
> > > and kernel boot parameters), they are safe to write to secondary CPUs
> > > before those CPUs have finished feature detection. As such, the bits are
> > > written with an "or" performed before the register write as that is both
> > > easier and uses a few bytes less storage of a location we don't have:
> > > read-only per-CPU data. (Note that initialization via cr4_init_shadow()
> > > isn't early enough to avoid early native_write_cr4() calls.)

Right, I know, but I was really aiming for the extra benefit of catching
legit kernel callers which feed crap into that function. I'm not so fond of
silently papering over crap.

> Basically, there are calls of native_write_cr4() made very early in
> secondary CPU init that would hit the "eek missing bit" case, and using
> the cr4_init_shadow() trick mentioned by Linus still wasn't early
> enough. So, since feature detection for these bits is "done" (i.e.
> secondary CPUs will match the boot CPU's for these bits), it's safe to
> set them "early". To avoid this, we'd need a per-cpu "am I ready to set
> these bits?" state, and it'd need to be read-only-after-init, which is
> not a section that exists and seems wasteful to create (4095 bytes
> unused) for this feature alone.
> 
> > Something like this:
> > 
> > 	unsigned long bits_missing = 0;
> > 
> > again:
> > 	asm volatile("mov %0,%%cr4": "+r" (val), "+m" (cr4_pinned_bits));
> > 
> > 	if (static_branch_likely(&cr_pinning)) {
> > 		if (unlikely((val & cr4_pinned_bits) != cr4_pinned_bits)) {
> > 			bits_missing = ~val & cr4_pinned_bits;
> > 			val |= cr4_pinned_bits;
> > 			goto again;
> > 		}
> > 		/* Warn after we've set the missing bits. */
> > 		WARN_ONCE(bits_missing, "CR4 bits went missing: %lx!?\n",
> > 			  bits_missing);
> > 	}
> 
> Yup, that's actually exactly what I had tried. Should I try to track down
> the very early callers and OR in the bits at the call sites instead? (This
> had occurred to me also, but it seemed operationally equivalent to ORing
> at the start of native_write_cr4(), so I didn't even bother trying it).

Nah. The straight forward approach is to do right when the secondary CPU
comes into life, before it does any cr4 write (except for the code in
entry_64.S), something like the below.

Thanks,

	tglx
	
8<-------------

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 362dd8953f48..f9304b356a83 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -205,13 +205,17 @@ static int enable_start_cpu0;
  */
 static void notrace start_secondary(void *unused)
 {
+	unsigned long cr4 = __read_cr4();
+
 	/*
 	 * Don't put *anything* except direct CPU state initialization
 	 * before cpu_init(), SMP booting is too fragile that we want to
 	 * limit the things done here to the most necessary things.
 	 */
 	if (boot_cpu_has(X86_FEATURE_PCID))
-		__write_cr4(__read_cr4() | X86_CR4_PCIDE);
+		cr4 |= X86_CR4_PCIDE;
+
+	__write_cr4(cr4 | cr4_pinned_bits)
 
 #ifdef CONFIG_X86_32
 	/* switch away from the initial page table */


    
