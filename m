Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25809C04AAD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 06:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBAEE206A3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 06:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="PJbQIC0x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbfEFGVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 02:21:06 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:62162 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbfEFGVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 02:21:02 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44yCKh6glrz9v0Rr;
        Mon,  6 May 2019 08:20:56 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=PJbQIC0x; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id tS-ONuM12wYz; Mon,  6 May 2019 08:20:56 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44yCKh5ZRWz9v0Rp;
        Mon,  6 May 2019 08:20:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1557123656; bh=y5ptx3mBFIGJB7xCn9foWCh+QyM5ysNRdLKrp+77p+c=;
        h=From:Subject:To:Cc:Date:From;
        b=PJbQIC0xi+KkN/vSOW4aoXiHkt7bZYKsoHWyYM/s2vBQ5uVBNXM1E7m38ooRnSqo+
         WMJuqpTsJ/F16yH/EVZRmfa7vvj+K5Ln5LX9WL6YRAKs7Eou7SYQPjjpsDnINag1zL
         ZJI0ZeMw+cTknlmLzYXv93QcjQI53H/xPXN1PE10=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 48F588B7F7;
        Mon,  6 May 2019 08:21:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id WMrlp5asfNfV; Mon,  6 May 2019 08:21:01 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.6])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2CA0A8B74F;
        Mon,  6 May 2019 08:21:01 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 382F26728F; Mon,  6 May 2019 06:21:01 +0000 (UTC)
Message-Id: <502da34ded576b9869b0f49146d465207fbd98ac.1557123466.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/mm: Fix makefile for KASAN
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon,  6 May 2019 06:21:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 17312f258cf6 ("powerpc/mm: Move book3s32 specifics in
subdirectory mm/book3s64"), ppc_mmu_32.c was moved and renamed.

This patch fixes Makefiles to disable KASAN instrumentation on
the new name and location.

Fixes: f072015c7b74 ("powerpc: disable KASAN instrumentation on early/critical files.")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/Makefile          | 6 ------
 arch/powerpc/mm/book3s32/Makefile | 6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index d8c0ce9b2557..7a7527116c3a 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -5,12 +5,6 @@
 
 ccflags-$(CONFIG_PPC64)	:= $(NO_MINIMAL_TOC)
 
-KASAN_SANITIZE_ppc_mmu_32.o := n
-
-ifdef CONFIG_KASAN
-CFLAGS_ppc_mmu_32.o  		+= -DDISABLE_BRANCH_PROFILING
-endif
-
 obj-y				:= fault.o mem.o pgtable.o mmap.o \
 				   init_$(BITS).o pgtable_$(BITS).o \
 				   pgtable-frag.o \
diff --git a/arch/powerpc/mm/book3s32/Makefile b/arch/powerpc/mm/book3s32/Makefile
index a4e217d0f3b7..1732eaa740a9 100644
--- a/arch/powerpc/mm/book3s32/Makefile
+++ b/arch/powerpc/mm/book3s32/Makefile
@@ -1,3 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
 
+KASAN_SANITIZE_mmu.o := n
+
+ifdef CONFIG_KASAN
+CFLAGS_mmu.o  		+= -DDISABLE_BRANCH_PROFILING
+endif
+
 obj-y += mmu.o hash_low.o mmu_context.o tlb.o
-- 
2.13.3

