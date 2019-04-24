Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA07BC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C283821900
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732762AbfDXQpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:45:44 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48822 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726935AbfDXQpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 12:45:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB505374;
        Wed, 24 Apr 2019 09:45:43 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A3D1C3F557;
        Wed, 24 Apr 2019 09:45:39 -0700 (PDT)
Date:   Wed, 24 Apr 2019 17:45:37 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH for 5.2 08/10] rseq/selftests: aarch64 code
 signature: handle big-endian environment
Message-ID: <20190424164536.GE21101@lakrids.cambridge.arm.com>
References: <20190424152502.14246-1-mathieu.desnoyers@efficios.com>
 <20190424152502.14246-9-mathieu.desnoyers@efficios.com>
 <20190424164032.GD21101@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424164032.GD21101@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 05:40:33PM +0100, Mark Rutland wrote:
> On Wed, Apr 24, 2019 at 11:25:00AM -0400, Mathieu Desnoyers wrote:
> > +/*
> > + * aarch64 -mbig-endian generates mixed endianness code vs data:
> > + * little-endian code and big-endian data. Ensure the RSEQ_SIG signature
> > + * matches code endianness.
> > + */
> > +#define RSEQ_SIG_CODE	0xd428bc00	/* BRK #0x45E0.  */
> > +
> > +#ifdef __AARCH64EB__
> > +#define RSEQ_SIG_DATA	0x00bc28d4	/* BRK #0x45E0.  */
> > +#else
> > +#define RSEQ_SIG_DATA	RSEQ_SIG_CODE
> > +#endif
> > +
> > +#define RSEQ_SIG	RSEQ_SIG_DATA
> >  
> >  #define rseq_smp_mb()	__asm__ __volatile__ ("dmb ish" ::: "memory")
> >  #define rseq_smp_rmb()	__asm__ __volatile__ ("dmb ishld" ::: "memory")
> > @@ -121,7 +134,7 @@ do {										\
> >  
> >  #define RSEQ_ASM_DEFINE_ABORT(label, abort_label)				\
> >  	"	b	222f\n"							\
> > -	"	.inst 	"	__rseq_str(RSEQ_SIG) "\n"			\
> > +	"	.inst 	"	__rseq_str(RSEQ_SIG_CODE) "\n"			\
> 
> I don't think this is right; the .inst directive _should_ emit the value
> in the instruction stream endianness (i.e. LE, regardless of the data
> endianness).

Now I see the RSEQ_CODE value isn't endian-swapped as teh RSEQ_DATA
value is, so the code above is fine.

Sory for the noise.

Thanks,
Mark.
