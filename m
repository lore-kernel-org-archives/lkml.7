Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34827C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 15:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 152D1204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 15:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbfGVPS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 11:18:28 -0400
Received: from gate.crashing.org ([63.228.1.57]:35288 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726443AbfGVPS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 11:18:28 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x6MFI3ra026871;
        Mon, 22 Jul 2019 10:18:03 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x6MFI1aA026870;
        Mon, 22 Jul 2019 10:18:01 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 22 Jul 2019 10:18:01 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v2] powerpc: slightly improve cache helpers
Message-ID: <20190722151801.GC20882@gate.crashing.org>
References: <45hnfp6SlLz9sP0@ozlabs.org> <20190708191416.GA21442@archlinux-threadripper> <a5864549-40c3-badd-8c41-d5b7bf3c4f3c@c-s.fr> <20190709064952.GA40851@archlinux-threadripper> <20190719032456.GA14108@archlinux-threadripper> <20190719152303.GA20882@gate.crashing.org> <20190719160455.GA12420@archlinux-threadripper> <20190721075846.GA97701@archlinux-threadripper> <20190721180150.GN20882@gate.crashing.org> <87imru74ul.fsf@concordia.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87imru74ul.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 08:15:14PM +1000, Michael Ellerman wrote:
> Segher Boessenkool <segher@kernel.crashing.org> writes:
> > On Sun, Jul 21, 2019 at 12:58:46AM -0700, Nathan Chancellor wrote:
> >> 0000017c clear_user_page:
> >>      17c: 94 21 ff f0                  	stwu 1, -16(1)
> >>      180: 38 80 00 80                  	li 4, 128
> >>      184: 38 63 ff e0                  	addi 3, 3, -32
> >>      188: 7c 89 03 a6                  	mtctr 4
> >>      18c: 38 81 00 0f                  	addi 4, 1, 15
> >>      190: 8c c3 00 20                  	lbzu 6, 32(3)
> >>      194: 98 c1 00 0f                  	stb 6, 15(1)
> >>      198: 7c 00 27 ec                  	dcbz 0, 4
> >>      19c: 42 00 ff f4                  	bdnz .+65524
> >
> > Uh, yeah, well, I have no idea what clang tried here, but that won't
> > work.  It's copying a byte from each target cache line to the stack,
> > and then does clears the cache line containing that byte on the stack.
> 
> So it seems like this is a clang bug.
> 
> None of the distros we support use clang, but we would still like to
> keep it working if we can.

Which version?  Which versions *are* broken?

> Looking at the original patch, the only upside is that the compiler
> can use both RA and RB to compute the address, rather than us forcing RA
> to 0.
> 
> But at least with my compiler here (GCC 8 vintage) I don't actually see
> GCC ever using both GPRs even with the patch. Or at least, there's no
> difference before/after the patch as far as I can see.

The benefit is small, certainly.

> So my inclination is to revert the original patch. We can try again in a
> few years :D
> 
> Thoughts?

I think you should give the clang people time to figure out what is
going on.


Segher
