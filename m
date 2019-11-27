Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0A7C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 15:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB41C20665
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 15:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfK0PAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 10:00:24 -0500
Received: from gate.crashing.org ([63.228.1.57]:47841 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbfK0PAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 10:00:24 -0500
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id xARF00sE025427;
        Wed, 27 Nov 2019 09:00:00 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id xARExxVi025420;
        Wed, 27 Nov 2019 08:59:59 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Wed, 27 Nov 2019 08:59:58 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 2/2] powerpc/irq: inline call_do_irq() and call_do_softirq()
Message-ID: <20191127145958.GG9491@gate.crashing.org>
References: <f12fb9a6cc52d83ee9ddf15a36ee12ac77e6379f.1570684298.git.christophe.leroy@c-s.fr> <5ca6639b7c1c21ee4b4138b7cfb31d6245c4195c.1570684298.git.christophe.leroy@c-s.fr> <877e3tbvsa.fsf@mpe.ellerman.id.au> <20191121101552.GR16031@gate.crashing.org> <87y2w49rgo.fsf@mpe.ellerman.id.au> <20191125142556.GU9491@gate.crashing.org> <5fdb1c92-8bf4-01ca-f81c-214870c33be3@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fdb1c92-8bf4-01ca-f81c-214870c33be3@c-s.fr>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 02:50:30PM +0100, Christophe Leroy wrote:
> So what do we do ? We just drop the "r2" clobber ?

You have to make sure your asm code works for all ABIs.  This is quite
involved if you do a call to an external function.  The compiler does
*not* see this call, so you will have to make sure that all that the
compiler and linker do will work, or prevent some of those things (say,
inlining of the function containing the call).

> Otherwise, to be on the safe side we can just save r2 in a local var 
> before the bl and restore it after. I guess it won't collapse CPU time 
> on a performant PPC64.

That does not fix everything.  The called function requires a specific
value in r2 on entry.

So all this needs verification.  Hopefully you can get away with just
not clobbering r2 (and not adding a nop after the bl), sure.  But this
needs to be checked.

Changing control flow inside inline assembler always is problematic.
Another problem in this case (on all ABIs) is that the compiler does
not see you call __do_irq.  Again, you can probably get away with that
too, but :-)


Segher
