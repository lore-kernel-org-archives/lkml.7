Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C4FC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 14:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C5CD22ADA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 14:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="px+1KWzK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387527AbfGXOK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 10:10:58 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56974 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbfGXOK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 10:10:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=peX7w0IHZmmNWGkQS7oFrjlTuMLY4e+Bl3q2bETnND4=; b=px+1KWzK31nDTPo1BKsXH9fgm
        +fbyZQR5E+7OVTNCsicikdHFL4zSeTgToYPFx3vztOK4nhri7vr8Qw+r+BMmGOOx7Cu1TkbGnfFrS
        8hdU8NfG+xZcQN+UQ5VZ0pNkel0v0m2u+NPQX3qTuwLBpAcurjBP1piRKDecFoTEaNFXU0dj5Fu0q
        R64WZYV0A1W4WSUMwe7ZJAHeIcwNTN51VnwIdUP58YqNR8zZenoYYKNXWpfd/fhx87JVzGTwe+bKL
        SvhdAh7rHRciFY8QrAs9p0FylNrh5E8g43mBb2z6AAILQDcCvx+o8HfX8wLTKleyJnwvfVSMMQzi8
        tN84/ITrg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hqHye-0005Jv-5Q; Wed, 24 Jul 2019 14:10:44 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DBE0E2026E809; Wed, 24 Jul 2019 16:10:40 +0200 (CEST)
Date:   Wed, 24 Jul 2019 16:10:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: x86 - clang / objtool status
Message-ID: <20190724141040.GA31425@hirez.programming.kicks-ass.net>
References: <alpine.DEB.2.21.1907182223560.1785@nanos.tec.linutronix.de>
 <20190724023946.yxsz5im22fz4zxrn@treble>
 <20190724074732.GJ3402@hirez.programming.kicks-ass.net>
 <20190724125525.kgybu3nnpvwlcz2c@treble>
 <20190724133516.GB31381@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724133516.GB31381@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 03:35:16PM +0200, Peter Zijlstra wrote:
> On Wed, Jul 24, 2019 at 07:55:25AM -0500, Josh Poimboeuf wrote:

> > b) why doesn't objtool detect the case I found?
> 
> With GCC you mean? Yes, that is really really weird.
> 
> Let me go stare at objdump output for this file (which doesn't build
> with:
> 
>    make O=defconfig-build/ drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o
> )

0000 0000000000000240 <eb_copy_relocations.isra.34>:
0000      240:	41 57                	push   %r15
0002      242:	41 56                	push   %r14
0004      244:	41 55                	push   %r13
0006      246:	41 54                	push   %r12
0008      248:	55                   	push   %rbp
0009      249:	53                   	push   %rbx
000a      24a:	48 83 ec 20          	sub    $0x20,%rsp
000e      24e:	85 f6                	test   %esi,%esi
0010      250:	74 39                	je     28b <eb_copy_relocations.isra.34+0x4b>
0012      252:	89 74 24 14          	mov    %esi,0x14(%rsp)
0016      256:	45 31 f6             	xor    %r14d,%r14d
0019      259:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
0020      260:	00 
0021      261:	48 89 7c 24 08       	mov    %rdi,0x8(%rsp)
0026      266:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
002b      26b:	48 8b 34 24          	mov    (%rsp),%rsi
002f      26f:	48 03 30             	add    (%rax),%rsi
0032      272:	44 8b 46 04          	mov    0x4(%rsi),%r8d
0036      276:	45 85 c0             	test   %r8d,%r8d
0039      279:	75 23                	jne    29e <eb_copy_relocations.isra.34+0x5e>
003b      27b:	41 83 c6 01          	add    $0x1,%r14d
003f      27f:	48 83 04 24 38       	addq   $0x38,(%rsp)
0044      284:	44 3b 74 24 14       	cmp    0x14(%rsp),%r14d
0049      289:	75 db                	jne    266 <eb_copy_relocations.isra.34+0x26>
004b      28b:	31 db                	xor    %ebx,%ebx
004d      28d:	48 83 c4 20          	add    $0x20,%rsp
0051      291:	89 d8                	mov    %ebx,%eax
0053      293:	5b                   	pop    %rbx
0054      294:	5d                   	pop    %rbp
0055      295:	41 5c                	pop    %r12
0057      297:	41 5d                	pop    %r13
0059      299:	41 5e                	pop    %r14
005b      29b:	41 5f                	pop    %r15
005d      29d:	c3                   	retq   

(<- from +39)

005e      29e:	48 83 c6 08          	add    $0x8,%rsi
0062      2a2:	44 89 c7             	mov    %r8d,%edi
0065      2a5:	e8 26 ff ff ff       	callq  1d0 <check_relocations.isra.32>
006a      2aa:	85 c0                	test   %eax,%eax
006c      2ac:	0f 85 35 01 00 00    	jne    3e7 <eb_copy_relocations.isra.34+0x1a7>
0072      2b2:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
0077      2b7:	48 8b 0c 24          	mov    (%rsp),%rcx
007b      2bb:	ba ff ff ff ff       	mov    $0xffffffff,%edx
0080      2c0:	be c0 0c 00 00       	mov    $0xcc0,%esi
0085      2c5:	48 8b 00             	mov    (%rax),%rax
0088      2c8:	4c 8b 6c 08 08       	mov    0x8(%rax,%rcx,1),%r13
008d      2cd:	44 89 c0             	mov    %r8d,%eax
0090      2d0:	49 89 c4             	mov    %rax,%r12
0093      2d3:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
0098      2d8:	49 c1 e4 05          	shl    $0x5,%r12
009c      2dc:	4c 89 e7             	mov    %r12,%rdi
009f      2df:	e8 00 00 00 00       	callq  2e4 <eb_copy_relocations.isra.34+0xa4>
00a0 			2e0: R_X86_64_PLT32	kvmalloc_node-0x4
00a4      2e4:	49 89 c7             	mov    %rax,%r15
00a7      2e7:	48 85 c0             	test   %rax,%rax
00aa      2ea:	0f 84 e8 00 00 00    	je     3d8 <eb_copy_relocations.isra.34+0x198>
00b0      2f0:	31 ed                	xor    %ebp,%ebp
00b2      2f2:	eb 08                	jmp    2fc <eb_copy_relocations.isra.34+0xbc>

(<- from +e0)

00b4      2f4:	48 01 dd             	add    %rbx,%rbp
00b7      2f7:	49 39 ec             	cmp    %rbp,%r12
00ba      2fa:	76 73                	jbe    36f <eb_copy_relocations.isra.34+0x12f>

(<- from +b2)

00bc      2fc:	4c 89 e3             	mov    %r12,%rbx
00bf      2ff:	b8 00 00 00 80       	mov    $0x80000000,%eax
00c4      304:	49 8d 3c 2f          	lea    (%r15,%rbp,1),%rdi
00c8      308:	48 29 eb             	sub    %rbp,%rbx
00cb      30b:	49 8d 74 2d 00       	lea    0x0(%r13,%rbp,1),%rsi
00d0      310:	48 39 c3             	cmp    %rax,%rbx
00d3      313:	48 0f 47 d8          	cmova  %rax,%rbx
00d7      317:	89 da                	mov    %ebx,%edx
00d9      319:	e8 00 00 00 00       	callq  31e <eb_copy_relocations.isra.34+0xde>
00da 			31a: R_X86_64_PLT32	copy_user_generic_unrolled-0x4
00de      31e:	85 c0                	test   %eax,%eax
00e0      320:	74 d2                	je     2f4 <eb_copy_relocations.isra.34+0xb4>
00e2      322:	4c 89 f8             	mov    %r15,%rax
00e5      325:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
00ea      32a:	90                   	nop
00eb      32b:	90                   	nop
00ec      32c:	90                   	nop

					^^^ CLAC

And that most certainly should trigger...

Let me gdb that objtool thing.
