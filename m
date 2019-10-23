Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1E3CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 23:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D912F2064B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 23:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392805AbfJWXwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 19:52:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51360 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389801AbfJWXwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 19:52:40 -0400
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iNQQc-0002uz-NX; Thu, 24 Oct 2019 01:52:34 +0200
Date:   Thu, 24 Oct 2019 01:52:33 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Will Deacon <will@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-arch@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [patch V2 07/17] x86/entry/64: Remove redundant interrupt
 disable
In-Reply-To: <20191023220618.qsmog2k5oaagj27v@treble>
Message-ID: <alpine.DEB.2.21.1910240146200.1852@nanos.tec.linutronix.de>
References: <20191023122705.198339581@linutronix.de> <20191023123118.296135499@linutronix.de> <20191023220618.qsmog2k5oaagj27v@treble>
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

On Wed, 23 Oct 2019, Josh Poimboeuf wrote:

> On Wed, Oct 23, 2019 at 02:27:12PM +0200, Thomas Gleixner wrote:
> > Now that the trap handlers return with interrupts disabled, the
> > unconditional disabling of interrupts in the low level entry code can be
> > removed along with the trace calls.
> > 
> > Add debug checks where appropriate.
> 
> This seems a little scary.  Does anybody other than Andy actually run
> with CONFIG_DEBUG_ENTRY?

I do.

> What happens if somebody accidentally leaves irqs enabled?  How do we
> know you found all the leaks?

For the DO_ERROR() ones that's trivial:

 #define DO_ERROR(trapnr, signr, sicode, addr, str, name)                  \
 dotraplinkage void do_##name(struct pt_regs *regs, long error_code)	   \
 {									   \
 	do_error_trap(regs, error_code, str, trapnr, signr, sicode, addr); \
+	lockdep_assert_irqs_disabled();					   \
 }
 
 DO_ERROR(X86_TRAP_DE,     SIGFPE,  FPE_INTDIV,   IP, "divide error",        divide_error)

Now for the rest we surely could do:

dotraplinkage void do_bounds(struct pt_regs *regs, long error_code)
{
	__do_bounds(regs, error_code);
	lockdep_assert_irqs_disabled();
}

and move the existing body into a static function so independent of any
(future) return path there the lockdep assert will be invoked.

Thanks,

	tglx

