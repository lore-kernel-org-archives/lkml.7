Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC71C3A5A4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 18:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 853D4217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 18:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730366AbfH0S0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 14:26:40 -0400
Received: from gate.crashing.org ([63.228.1.57]:43069 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727064AbfH0S0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 14:26:40 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x7RIQHbP000982;
        Tue, 27 Aug 2019 13:26:17 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x7RIQGDG000979;
        Tue, 27 Aug 2019 13:26:16 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Tue, 27 Aug 2019 13:26:16 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] powerpc: cleanup hw_irq.h
Message-ID: <20190827182616.GB31406@gate.crashing.org>
References: <0f7e164afb5d1b022441559fe5a999bb6d3c0a23.1566893505.git.christophe.leroy@c-s.fr> <81f39fa06ae582f4a783d26abd2b310204eba8f4.1566893505.git.christophe.leroy@c-s.fr> <1566909844.x4jee1jjda.astroid@bobo.none> <20190827172909.GA31406@gate.crashing.org> <1410046b-e1a3-b892-2add-6c1d353cb781@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1410046b-e1a3-b892-2add-6c1d353cb781@c-s.fr>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 07:36:35PM +0200, Christophe Leroy wrote:
> Le 27/08/2019 à 19:29, Segher Boessenkool a écrit :
> >On Tue, Aug 27, 2019 at 10:48:24PM +1000, Nicholas Piggin wrote:
> >>Christophe Leroy's on August 27, 2019 6:13 pm:
> >>>+#define wrtee(val)	asm volatile("wrtee %0" : : "r" (val) : "memory")
> >>>+#define wrteei(val)	asm volatile("wrteei %0" : : "i" (val) : 
> >>>"memory")
> >>
> >>Can you implement just one macro that uses __builtin_constant_p to
> >>select between the imm and reg versions? I forgot if there's some
> >>corner cases that prevent that working with inline asm i constraints.
> >
> >static inline void wrtee(long val)
> >{
> >	asm volatile("wrtee%I0 %0" : : "n"(val) : "memory");
> >}
> 
> Great, didn't know that possibility.
> 
> Can it be used with any insn, for instance with add/addi ?
> Or with mr/li ?

Any instruction, yes.  %I<n> simply outputs an "i" if operand n is a
constant integer, and nothing otherwise.

So
  asm("add%I2 %0,%1,%2" : "=r"(dst) : "r"(src1), "ri"(src1));
works well.  I don't see how you would use it for li/mr...  You can do
  asm("add%I1 %0,0,%1" : "=r"(dst) : "ri"(src));
I suppose, but that is not really an mr.

> >(This output modifier goes back to the dark ages, some 2.4 or something).
> 
> Hope Clang support it ...

I don't know, sorry.  But it is used all over the place, see sfp-machine.h
for example, so maybe?


Segher
