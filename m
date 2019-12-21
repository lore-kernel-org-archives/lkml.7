Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDACC2D0C0
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 08:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 315F521655
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 08:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="X/CC3zVj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbfLUIcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 03:32:25 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:29373 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbfLUIcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 03:32:25 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47fzPd2RhCz9v1Kt;
        Sat, 21 Dec 2019 09:32:21 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=X/CC3zVj; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 9CZTJWpIb3oz; Sat, 21 Dec 2019 09:32:21 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47fzPd0n8yz9v1Ks;
        Sat, 21 Dec 2019 09:32:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1576917141; bh=E9RKebUP1SppGa2SP1hXCPrAmxC2lQWVebR4woXcBx4=;
        h=From:Subject:To:Cc:Date:From;
        b=X/CC3zVji3J7DK/g7Rrz/AyTo0Y5CoJMc25c7ql5rHqSRlTGaSqbTh4XA6EWt4SON
         g8dx7mQjw0IIqrUJTPNqMqOKZEn1YAyfja8qRjAHISFddOuN4hWvU9bO+610hzQw4x
         lGCJEXigJhDEI6ZgPMcq/MuxAcrBh5X+DBf1P/2c=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 02CFC8B77C;
        Sat, 21 Dec 2019 09:32:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id jxdAh1n2NAhk; Sat, 21 Dec 2019 09:32:21 +0100 (CET)
Received: from localhost.localdomain (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id ACFFE8B752;
        Sat, 21 Dec 2019 09:32:21 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
        id 4B883637B6; Sat, 21 Dec 2019 08:32:21 +0000 (UTC)
Message-Id: <cover.1576916812.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v5 00/17] Enable CONFIG_VMAP_STACK on PPC32
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, dja@axtens.net
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org
Date:   Sat, 21 Dec 2019 08:32:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of this serie is to enable CONFIG_VMAP_STACK on PPC32.

rfc v1: initial support on 8xx

rfc v2: added stack overflow detection.

v3:
- Stack overflow detection works, tested with LKDTM STACK_EXHAUST test
- Support for book3s32 added

v4:
- Fixed build failure with CONFIG_KVM (patch 14)
- Fixed boot failure with pmac32_defconfig+VMAP_STACK+KVM (new patch 15)
- Fixed crash with altivec and fpu (patch 16)

v5:
- Reduced ifdefs around tophys/tovirt by using macros (patch 5)
- Reorganised stack overflow handling, making it independent of the existing one which could go away in another series (patch 7)
- Added vmapped stacks for interrupts (new patch 8)

Christophe Leroy (17):
  powerpc/32: replace MTMSRD() by mtmsr
  powerpc/32: Add EXCEPTION_PROLOG_0 in head_32.h
  powerpc/32: save DEAR/DAR before calling handle_page_fault
  powerpc/32: move MSR_PR test into EXCEPTION_PROLOG_0
  powerpc/32: add a macro to get and/or save DAR and DSISR on stack.
  powerpc/32: prepare for CONFIG_VMAP_STACK
  powerpc: align stack to 2 * THREAD_SIZE with VMAP_STACK
  powerpc/32: Add early stack overflow detection with VMAP stack.
  powerpc/32: Use vmapped stacks for interrupts
  powerpc/8xx: Use alternative scratch registers in DTLB miss handler
  powerpc/8xx: drop exception entries for non-existing exceptions
  powerpc/8xx: move DataStoreTLBMiss perf handler
  powerpc/8xx: split breakpoint exception
  powerpc/8xx: Enable CONFIG_VMAP_STACK
  powerpc/32s: reorganise DSI handler.
  powerpc/32s: avoid crossing page boundary while changing SRR0/1.
  powerpc/32s: Enable CONFIG_VMAP_STACK

 arch/powerpc/include/asm/processor.h   |   6 ++
 arch/powerpc/include/asm/thread_info.h |  18 ++++
 arch/powerpc/kernel/asm-offsets.c      |   6 ++
 arch/powerpc/kernel/entry_32.S         |  29 +++---
 arch/powerpc/kernel/fpu.S              |   3 +
 arch/powerpc/kernel/head_32.S          |  61 ++++++-----
 arch/powerpc/kernel/head_32.h          | 178 +++++++++++++++++++++++++++----
 arch/powerpc/kernel/head_40x.S         |   2 +
 arch/powerpc/kernel/head_8xx.S         | 184 +++++++++++++++------------------
 arch/powerpc/kernel/head_booke.h       |   2 +
 arch/powerpc/kernel/head_fsl_booke.S   |   1 +
 arch/powerpc/kernel/irq.c              |  22 ++++
 arch/powerpc/kernel/setup.h            |   2 +-
 arch/powerpc/kernel/setup_32.c         |  17 ++-
 arch/powerpc/kernel/setup_64.c         |   2 +-
 arch/powerpc/kernel/traps.c            |   9 ++
 arch/powerpc/kernel/vector.S           |   3 +
 arch/powerpc/kernel/vmlinux.lds.S      |   2 +-
 arch/powerpc/mm/book3s32/hash_low.S    |  46 ++++++---
 arch/powerpc/mm/book3s32/mmu.c         |   9 +-
 arch/powerpc/perf/8xx-pmu.c            |  12 ++-
 arch/powerpc/platforms/Kconfig.cputype |   3 +
 22 files changed, 435 insertions(+), 182 deletions(-)

-- 
2.13.3

