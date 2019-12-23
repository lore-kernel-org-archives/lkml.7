Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B77FC2D0D6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 15:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0BDC222C2
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 15:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="mb9cH2ZE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfLWP0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 10:26:12 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:29519 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726756AbfLWP0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 10:26:12 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47hNV60097z9vJyp;
        Mon, 23 Dec 2019 16:26:06 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=mb9cH2ZE; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id AMfTUWCOxQHb; Mon, 23 Dec 2019 16:26:05 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47hNV560H5z9vJyn;
        Mon, 23 Dec 2019 16:26:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1577114765; bh=XwT2bCOLWphD/sSJh9VwSsc95eI+wrP0sTiw3zw31v0=;
        h=From:Subject:To:Cc:Date:From;
        b=mb9cH2ZEAK/hU2LwwQQDycPlb295W0zc/5AOtP4sonsQhNJVeDG5RpB6CoBfGZCjm
         E9aFumiFyRKygt6kIJr1GpRZ0MxSw8y7dXP6U9IxXH68Vkv74is9J39/dZPi5AbOgl
         K/327GMTI2SNZr+tWK9TKEjAx0e2LDZp/+5jSCkI=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 058D58B7AB;
        Mon, 23 Dec 2019 16:26:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id wu9RLPM7jVpd; Mon, 23 Dec 2019 16:26:10 +0100 (CET)
Received: from po16098vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.100])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D3A6C8B7A1;
        Mon, 23 Dec 2019 16:26:10 +0100 (CET)
Received: by po16098vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id C82E6637D8; Mon, 23 Dec 2019 15:26:10 +0000 (UTC)
Message-Id: <cover.1577114567.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH 0/8] Accelarate IRQ entry
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 23 Dec 2019 15:26:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of this series is to accelerate IRQ entry by
avoiding unneccessary trampoline functions like call_do_irq()
and call_do_softirq() and by switching to IRQ stack
immediately in the exception handler.

For now, it is an RFC as it is still a bit messy.

Please provide feedback and I'll improve next year

Christophe Leroy (8):
  powerpc/32: drop ksp_limit based stack overflow detection
  powerpc/irq: inline call_do_irq() and call_do_softirq() on PPC32
  powerpc/irq: don't use current_stack_pointer() in do_IRQ()
  powerpc/irq: move set_irq_regs() closer to irq_enter/exit()
  powerpc/irq: move stack overflow verification
  powerpc/irq: cleanup check_stack_overflow() a bit
  powerpc/32: use IRQ stack immediately on IRQ exception
  powerpc/irq: drop softirq stack

 arch/powerpc/include/asm/asm-prototypes.h |  1 -
 arch/powerpc/include/asm/irq.h            |  3 +-
 arch/powerpc/include/asm/processor.h      |  3 --
 arch/powerpc/include/asm/reg.h            |  8 ++++
 arch/powerpc/kernel/asm-offsets.c         |  2 -
 arch/powerpc/kernel/entry_32.S            | 57 ------------------------
 arch/powerpc/kernel/head_32.S             |  2 +-
 arch/powerpc/kernel/head_32.h             | 32 +++++++++++--
 arch/powerpc/kernel/head_40x.S            |  4 +-
 arch/powerpc/kernel/head_8xx.S            |  2 +-
 arch/powerpc/kernel/head_booke.h          |  1 -
 arch/powerpc/kernel/irq.c                 | 74 +++++++++++++++++++++----------
 arch/powerpc/kernel/misc_32.S             | 39 ----------------
 arch/powerpc/kernel/process.c             |  7 ---
 arch/powerpc/kernel/setup_32.c            |  4 +-
 arch/powerpc/kernel/setup_64.c            |  4 +-
 arch/powerpc/kernel/traps.c               |  9 ----
 arch/powerpc/lib/sstep.c                  |  9 ----
 18 files changed, 95 insertions(+), 166 deletions(-)

-- 
2.13.3

