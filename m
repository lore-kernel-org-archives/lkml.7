Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3557AC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E9742070D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfHSOh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 10:37:26 -0400
Received: from gate.crashing.org ([63.228.1.57]:59023 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbfHSOh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 10:37:26 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x7JEb1pp023153;
        Mon, 19 Aug 2019 09:37:01 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x7JEb09r023152;
        Mon, 19 Aug 2019 09:37:00 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 19 Aug 2019 09:37:00 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 3/3] powerpc: use __builtin_trap() in BUG/WARN macros.
Message-ID: <20190819143700.GK31406@gate.crashing.org>
References: <a6781075192afe0c909ce7d091de7931183a5d93.1566219503.git.christophe.leroy@c-s.fr> <20510ce03cc9463f1c9e743c1d93b939de501b53.1566219503.git.christophe.leroy@c-s.fr> <20190819132313.GH31406@gate.crashing.org> <dbafc03a-6eda-d9a3-c451-d242f03b01d9@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dbafc03a-6eda-d9a3-c451-d242f03b01d9@c-s.fr>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 04:08:43PM +0200, Christophe Leroy wrote:
> Le 19/08/2019 à 15:23, Segher Boessenkool a écrit :
> >On Mon, Aug 19, 2019 at 01:06:31PM +0000, Christophe Leroy wrote:
> >>Note that we keep using an assembly text using "twi 31, 0, 0" for
> >>inconditional traps because GCC drops all code after
> >>__builtin_trap() when the condition is always true at build time.
> >
> >As I said, it can also do this for conditional traps, if it can prove
> >the condition is always true.
> 
> But we have another branch for 'always true' and 'always false' using 
> __builtin_constant_p(), which don't use __builtin_trap(). Is there 
> anything wrong with that ?:

The compiler might not realise it is constant when it evaluates the
__builtin_constant_p, but only realises it later.  As the documentation
for the builtin says:
  A return of 0 does not indicate that the
  value is _not_ a constant, but merely that GCC cannot prove it is a
  constant with the specified value of the '-O' option.

(and there should be many more and more serious warnings here).

> #define BUG_ON(x) do {						\
> 	if (__builtin_constant_p(x)) {				\
> 		if (x)						\
> 			BUG();					\
> 	} else {						\
> 		if (x)						\
> 			__builtin_trap();			\
> 		BUG_ENTRY("", 0);				\
> 	}							\
> } while (0)

I think it may work if you do

#define BUG_ON(x) do {						\
	if (__builtin_constant_p(x)) {				\
		if (x)						\
			BUG();					\
	} else {						\
		BUG_ENTRY("", 0);				\
		if (x)						\
			__builtin_trap();			\
	}							\
} while (0)

or even just

#define BUG_ON(x) do {						\
	BUG_ENTRY("", 0);					\
	if (x)							\
		__builtin_trap();				\
	}							\
} while (0)

if BUG_ENTRY can work for the trap insn *after* it.

> >Can you put the bug table asm *before* the __builtin_trap maybe?  That
> >should make it all work fine...  If you somehow can tell what machine
> >instruction is that trap, anyway.
> 
> And how can I tell that ?

I don't know how BUG_ENTRY works exactly.


Segher
