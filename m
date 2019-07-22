Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE63EC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 23:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94CF121951
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 23:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfGVXV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 19:21:59 -0400
Received: from ozlabs.org ([203.11.71.1]:58339 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbfGVXV7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 19:21:59 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45syLF0b78z9s4Y;
        Tue, 23 Jul 2019 09:21:57 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v2] powerpc: slightly improve cache helpers
In-Reply-To: <20190722151801.GC20882@gate.crashing.org>
References: <45hnfp6SlLz9sP0@ozlabs.org> <20190708191416.GA21442@archlinux-threadripper> <a5864549-40c3-badd-8c41-d5b7bf3c4f3c@c-s.fr> <20190709064952.GA40851@archlinux-threadripper> <20190719032456.GA14108@archlinux-threadripper> <20190719152303.GA20882@gate.crashing.org> <20190719160455.GA12420@archlinux-threadripper> <20190721075846.GA97701@archlinux-threadripper> <20190721180150.GN20882@gate.crashing.org> <87imru74ul.fsf@concordia.ellerman.id.au> <20190722151801.GC20882@gate.crashing.org>
Date:   Tue, 23 Jul 2019 09:21:53 +1000
Message-ID: <875znt7izy.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Segher Boessenkool <segher@kernel.crashing.org> writes:
> On Mon, Jul 22, 2019 at 08:15:14PM +1000, Michael Ellerman wrote:
>> Segher Boessenkool <segher@kernel.crashing.org> writes:
>> > On Sun, Jul 21, 2019 at 12:58:46AM -0700, Nathan Chancellor wrote:
>> >> 0000017c clear_user_page:
>> >>      17c: 94 21 ff f0                  	stwu 1, -16(1)
>> >>      180: 38 80 00 80                  	li 4, 128
>> >>      184: 38 63 ff e0                  	addi 3, 3, -32
>> >>      188: 7c 89 03 a6                  	mtctr 4
>> >>      18c: 38 81 00 0f                  	addi 4, 1, 15
>> >>      190: 8c c3 00 20                  	lbzu 6, 32(3)
>> >>      194: 98 c1 00 0f                  	stb 6, 15(1)
>> >>      198: 7c 00 27 ec                  	dcbz 0, 4
>> >>      19c: 42 00 ff f4                  	bdnz .+65524
>> >
>> > Uh, yeah, well, I have no idea what clang tried here, but that won't
>> > work.  It's copying a byte from each target cache line to the stack,
>> > and then does clears the cache line containing that byte on the stack.
>> 
>> So it seems like this is a clang bug.
>> 
>> None of the distros we support use clang, but we would still like to
>> keep it working if we can.
>
> Which version?  Which versions *are* broken?

AFAIK clang 8 is the first version that we could build with, without
hacks.

>> Looking at the original patch, the only upside is that the compiler
>> can use both RA and RB to compute the address, rather than us forcing RA
>> to 0.
>> 
>> But at least with my compiler here (GCC 8 vintage) I don't actually see
>> GCC ever using both GPRs even with the patch. Or at least, there's no
>> difference before/after the patch as far as I can see.
>
> The benefit is small, certainly.

Zero is small, but I guess some things are smaller? :P

>> So my inclination is to revert the original patch. We can try again in a
>> few years :D
>> 
>> Thoughts?
>
> I think you should give the clang people time to figure out what is
> going on.

Yeah fair enough, will wait and see what their diagnosis is.

cheers
