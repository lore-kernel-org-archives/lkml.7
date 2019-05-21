Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC245C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 07:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91DD62173E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 07:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfEUHmc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 03:42:32 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:42413 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbfEUHmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 03:42:32 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 457SQs0PKRz9s55;
        Tue, 21 May 2019 17:42:29 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Paul Mackerras <paulus@samba.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] powerpc/mm: mark more tlb functions as __always_inline
In-Reply-To: <CAK7LNAQNp+wsvNK84oYcGwR24=Kf=_N8WJdyZ2aUL9T3qDsVsA@mail.gmail.com>
References: <20190521061659.6073-1-yamada.masahiro@socionext.com> <16d967dd-9f8f-4e9e-97fd-3f9761e5d97c@c-s.fr> <CAK7LNAQNp+wsvNK84oYcGwR24=Kf=_N8WJdyZ2aUL9T3qDsVsA@mail.gmail.com>
Date:   Tue, 21 May 2019 17:42:27 +1000
Message-ID: <87y3306yos.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro Yamada <yamada.masahiro@socionext.com> writes:
> On Tue, May 21, 2019 at 3:54 PM Christophe Leroy
> <christophe.leroy@c-s.fr> wrote:
>> Le 21/05/2019 à 08:16, Masahiro Yamada a écrit :
>> > With CONFIG_OPTIMIZE_INLINING enabled, Laura Abbott reported error
>> > with gcc 9.1.1:
>> >
>> >    arch/powerpc/mm/book3s64/radix_tlb.c: In function '_tlbiel_pid':
>> >    arch/powerpc/mm/book3s64/radix_tlb.c:104:2: warning: asm operand 3 probably doesn't match constraints
>> >      104 |  asm volatile(PPC_TLBIEL(%0, %4, %3, %2, %1)
>> >          |  ^~~
>> >    arch/powerpc/mm/book3s64/radix_tlb.c:104:2: error: impossible constraint in 'asm'
>> >
>> > Fixing _tlbiel_pid() is enough to address the warning above, but I
>> > inlined more functions to fix all potential issues.
>> >
>> > To meet the 'i' (immediate) constraint for the asm operands, functions
>> > propagating propagated 'ric' must be always inlined.
>> >
>> > Fixes: 9012d011660e ("compiler: allow all arches to enable CONFIG_OPTIMIZE_INLINING")
>> > Reported-by: Laura Abbott <labbott@redhat.com>
>> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> > ---
>> >
>> >   arch/powerpc/mm/book3s64/hash_native.c |  8 +++--
>> >   arch/powerpc/mm/book3s64/radix_tlb.c   | 44 +++++++++++++++-----------
>> >   2 files changed, 30 insertions(+), 22 deletions(-)
>> >
>> > diff --git a/arch/powerpc/mm/book3s64/hash_native.c b/arch/powerpc/mm/book3s64/hash_native.c
>> > index aaa28fd918fe..bc2c35c0d2b1 100644
>> > --- a/arch/powerpc/mm/book3s64/hash_native.c
>> > +++ b/arch/powerpc/mm/book3s64/hash_native.c
>> > @@ -60,9 +60,11 @@ static inline void tlbiel_hash_set_isa206(unsigned int set, unsigned int is)
>> >    * tlbiel instruction for hash, set invalidation
>> >    * i.e., r=1 and is=01 or is=10 or is=11
>> >    */
>> > -static inline void tlbiel_hash_set_isa300(unsigned int set, unsigned int is,
>> > -                                     unsigned int pid,
>> > -                                     unsigned int ric, unsigned int prs)
>> > +static __always_inline void tlbiel_hash_set_isa300(unsigned int set,
>> > +                                                unsigned int is,
>> > +                                                unsigned int pid,
>> > +                                                unsigned int ric,
>> > +                                                unsigned int prs)
>>
>> Please don't split the line more than it is.
>>
>> powerpc accepts lines up to 90 chars, see arch/powerpc/tools/checkpatch.pl
>
> Ugh, I did not know this. Horrible.
>
> The Linux coding style should be global in the kernel tree.
> No subsystem should adopts its own coding style.

Well that ship sailed long ago.

But we don't have our own coding style, we just don't enforce 80 columns
rigidly, there are cases where a slightly longer line (up to ~90) is
preferable to a split line.

In a case like this with a long attribute and function name I think this
is probably the least worst option:

static __always_inline
void tlbiel_hash_set_isa300(unsigned int set, unsigned int is, unsigned int pid,
			    unsigned int ric, unsigned int prs)
{
	...

cheers
