Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B882C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 21:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E63B3218D2
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 21:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbfDWVJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 17:09:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35460 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfDWVJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 17:09:52 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A2B2D81245;
        Tue, 23 Apr 2019 21:09:51 +0000 (UTC)
Received: from treble (ovpn-123-99.rdu2.redhat.com [10.10.123.99])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 850CF1001DD2;
        Tue, 23 Apr 2019 21:09:49 +0000 (UTC)
Date:   Tue, 23 Apr 2019 16:09:47 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Raphael Gault <raphael.gault@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        peterz@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com,
        julien.thierry@arm.com
Subject: Re: [PATCH 0/6] objtool: Add support for Arm64
Message-ID: <20190423210947.b2qomzj3qb4pzfr5@treble>
References: <20190409135243.12424-1-raphael.gault@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190409135243.12424-1-raphael.gault@arm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 23 Apr 2019 21:09:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 02:52:37PM +0100, Raphael Gault wrote:
> Hi,
> 
> As of now, objtool only supports the x86_64 architecture but the
> groundwork has already been done in order to add support for other
> architecture without too much effort.
> 
> This series of patches adds support for the arm64 architecture
> based on the Armv8.5 Architecture Reference Manual.
> 
> * Patch 1 adapts the existing code to be able to add support for other
>   architecture.
> * Patch 2 provide implementation of the required function for the arm64
>   architecture.
> * Patch 3 adapts the checking of the stack state for the arm64
>   architecture.
> * Patch 4 & 5 fix some warning objtool raised in some particular
>   functions of ~/arch/arm64/kernel/sleep.S. Patch 4 add a macro to
>   signal that some function should be ignored by objtool. 
> * Patch 6 enables stack validation for arm64.
> 
> Theses patches should provide support for the main cases and behaviour.
> However a few corner cases are not yet handled by objtool:
> 
> * In the `~/arch/arm64/crypto/` directory, I noticed that some plain
>   data are sometimes stored in the `.text` section causing objtool to mistake
>   this for instructions and trying (and failing) to interprete them.  If someone
>   could explain to me why we store data directly in the .text section I would
>   appreciate it.

I haven't looked, but it should probably be moved to .rodata.  We had
cases like that for x86.

> * In the support for arm32 architecture such as in `~/arch/arm64/kernel/kuser32.S`
>   some A32 instructions are used but such instructions are not understood by
>   objtool causing a warning.
> 
> I also have a few unclear points I would like to bring to your
> attention:
> 
> * For x86_64, when looking for a symbol relocation with explicit
>   addend, objtool systematically adds a +4 offset to the addend.
>   I don't understand why even if I have a feeling it is related
>   to the type of relacation.

This is because of how relative call/jump addresses are implemented on
x86.  It calculates the call/jump destination by adding the encoded offset
to the *ending* address of the instruction, rather than to the address
of the encoded offset itself.

For example:

  119ca0:       e8 00 00 00 00          callq  119ca5 <__ia32_sys_sched_rr_get_interval+0x5>
                        119ca1: R_X86_64_PC32   __fentry__-0x4

This instruction is a call to the __fentry__ function.  The rela addend
is the address of the destination function (__fentry__) minus 4.  After
applying the relocation, it resolves to:

ffffffff81002010:       e8 eb f7 9f 00          callq  ffffffff81a01800 <__fentry__>

The destination address is "0x9ff7eb", which is indeed __fentry__ - 4.

x86 expects it to be that way, because the x86 CPU adds the offset to
the *end* of the instruction: ffffffff81002015 (last digit is 5, not 0).

0xffffffff81002015 + 0x9ff7eb = 0xfffffff81a01800, which is indeed the
address of __fentry__.

And there's always a 4-byte gap between the relocation target and the
end of the instruction, so the rela addend always has the -4.  So when
reading the relocation we have to add the 4 bytes back to get the actual
destination address.

> * I currently don't have a clear understanding about how switch-tables
>   are generated on arm64 and how to retrieve them (based on relocations).

This is indeed a bit tricky on x86.

> Please provide me with any feedback and comments as well on the content
> than the style of these patches.

Overall it looks like a great start.  I added some per-patch comments.

Has the cross-compile path been tested?  Specifically, compiling for a
arm64 target on an x86 host?  In other words, objtool would be an x86
binary which reads arm64 objects.  I imagine that will be a semi-common
use case.  Objtool already supports cross-compiling for an x86-64 target
on an x86-32 host (and also a powerpc host IIRC), so it should be
do-able in theory, and it might "just work".

For the next version, please base it on the -tip tree, as that's where
all the latest objtool changes are.  Peter refactored some code which
has some minor conflicts with yours.

-- 
Josh
