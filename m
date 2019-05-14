Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B70EC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 09:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ACC920879
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 09:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="mdOi1sJi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfENJFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 05:05:17 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:49380 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbfENJFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 05:05:16 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 453BbZ2zKtz9v0Yc;
        Tue, 14 May 2019 11:05:14 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=mdOi1sJi; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id z1ItiGX7jjRG; Tue, 14 May 2019 11:05:14 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 453BbZ1p8Cz9v0YY;
        Tue, 14 May 2019 11:05:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1557824714; bh=gnFTCMPfHpZ6URgcdmLkrXdWzWsJFnvLthyYOc0ikJo=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=mdOi1sJimj2hgwSH13FcvRt7WCSMroOKp4HOv7u4YhmRGlgTCQY81XoEl2/e/iaI3
         oiBBDJC8OUakIO8v5X4pwBT8SdEjmjMX/BhfFhmx7/K9P1+I0iaSaGyp1z66TAZ5VI
         ldNABvyC076uIY6FigfdjvEoaOSU2yt5nbhfiuQ4=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 57A8E8B8BE;
        Tue, 14 May 2019 11:05:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id diQDik9w2xOK; Tue, 14 May 2019 11:05:15 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0AF4F8B8BD;
        Tue, 14 May 2019 11:05:15 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id CC7656742D; Tue, 14 May 2019 09:05:14 +0000 (UTC)
Message-Id: <0e779b35cf66fd4aa5ec0ec09fb7820f6c518cb3.1557824379.git.christophe.leroy@c-s.fr>
In-Reply-To: <239d1c8f15b8bedc161a234f9f1a22a07160dbdf.1557824379.git.christophe.leroy@c-s.fr>
References: <239d1c8f15b8bedc161a234f9f1a22a07160dbdf.1557824379.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 2/4] powerpc/32: activate ARCH_HAS_PMEM_API and
 ARCH_HAS_UACCESS_FLUSHCACHE
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Oliver O'Halloran <oohall@gmail.com>,
        Segher Boessenkool <segher@kernel.crashing.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 14 May 2019 09:05:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PPC32 also have flush_dcache_range() so it can also support
ARCH_HAS_PMEM_API and ARCH_HAS_UACCESS_FLUSHCACHE without changes.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index d7996cfaceca..cf6e30f637be 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -127,13 +127,13 @@ config PPC
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_MMIOWB			if PPC64
 	select ARCH_HAS_PHYS_TO_DMA
-	select ARCH_HAS_PMEM_API                if PPC64
+	select ARCH_HAS_PMEM_API
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_MEMBARRIER_CALLBACKS
 	select ARCH_HAS_SCALED_CPUTIME		if VIRT_CPU_ACCOUNTING_NATIVE && PPC64
 	select ARCH_HAS_STRICT_KERNEL_RWX	if ((PPC_BOOK3S_64 || PPC32) && !RELOCATABLE && !HIBERNATION)
 	select ARCH_HAS_TICK_BROADCAST		if GENERIC_CLOCKEVENTS_BROADCAST
-	select ARCH_HAS_UACCESS_FLUSHCACHE	if PPC64
+	select ARCH_HAS_UACCESS_FLUSHCACHE
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARCH_HAS_ZONE_DEVICE		if PPC_BOOK3S_64
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
-- 
2.13.3

