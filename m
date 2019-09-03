Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADBAC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2446722CF8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729877AbfICQFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 12:05:03 -0400
Received: from gate.crashing.org ([63.228.1.57]:55972 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728571AbfICQFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:05:03 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x83G4HnT010981;
        Tue, 3 Sep 2019 11:04:17 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x83G4F0O010980;
        Tue, 3 Sep 2019 11:04:15 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Tue, 3 Sep 2019 11:04:15 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     "Alastair D'Silva" <alastair@au1.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Paul Mackerras <paulus@samba.org>, alastair@d-silva.org,
        Qian Cai <cai@lca.pw>, Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev@lists.ozlabs.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Allison Randal <allison@lohutok.net>
Subject: Re: [PATCH v2 3/6] powerpc: Convert flush_icache_range & friends to C
Message-ID: <20190903160415.GA9749@gate.crashing.org>
References: <20190903052407.16638-1-alastair@au1.ibm.com> <20190903052407.16638-4-alastair@au1.ibm.com> <20190903130430.GC31406@gate.crashing.org> <d268ee78-607e-5eb3-ed89-d5c07f672046@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d268ee78-607e-5eb3-ed89-d5c07f672046@c-s.fr>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 04:28:09PM +0200, Christophe Leroy wrote:
> Le 03/09/2019 à 15:04, Segher Boessenkool a écrit :
> >On Tue, Sep 03, 2019 at 03:23:57PM +1000, Alastair D'Silva wrote:
> >>+	asm volatile(
> >>+		"   mtctr %2;"
> >>+		"   mtmsr %3;"
> >>+		"   isync;"
> >>+		"0: dcbst   0, %0;"
> >>+		"   addi    %0, %0, %4;"
> >>+		"   bdnz    0b;"
> >>+		"   sync;"
> >>+		"   mtctr %2;"
> >>+		"1: icbi    0, %1;"
> >>+		"   addi    %1, %1, %4;"
> >>+		"   bdnz    1b;"
> >>+		"   sync;"
> >>+		"   mtmsr %5;"
> >>+		"   isync;"
> >>+		: "+r" (loop1), "+r" (loop2)
> >>+		: "r" (nb), "r" (msr), "i" (bytes), "r" (msr0)
> >>+		: "ctr", "memory");
> >
> >This outputs as one huge assembler statement, all on one line.  That's
> >going to be fun to read or debug.
> 
> Do you mean \n has to be added after the ; ?

Something like that.  There is no really satisfying way for doing huge
inline asm, and maybe that is a good thing ;-)

Often people write \n\t at the end of each line of inline asm.  This works
pretty well (but then there are labels, oh joy).

> >loop1 and/or loop2 can be assigned the same register as msr0 or nb.  They
> >need to be made earlyclobbers.  (msr is fine, all of its reads are before
> >any writes to loop1 or loop2; and bytes is fine, it's not a register).
> 
> Can you explicit please ? Doesn't '+r' means that they are input and 
> output at the same time ?

That is what + means, yes -- that this output is an input as well.  It is
the same to write

  asm("mov %1,%0 ; mov %0,42" : "+r"(x), "=r"(y));
or to write
  asm("mov %1,%0 ; mov %0,42" : "=r"(x), "=r"(y) : "0"(x));

(So not "at the same time" as in "in the same machine instruction", but
more loosely, as in "in the same inline asm statement").

> "to be made earlyclobbers", what does this means exactly ? How to do that ?

You write &, like "+&r" in this case.  It means the machine code writes
to this register before it has consumed all asm inputs (remember, GCC
does not understand (or even parse!) the assembler string).

So just

		: "+&r" (loop1), "+&r" (loop2)

will do.  (Why are they separate though?  It could just be one loop var).


Segher
