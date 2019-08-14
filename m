Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4605FC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 05:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 164382084D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 05:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="SJyMuRjs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbfHNF2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 01:28:37 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:61254 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725263AbfHNF2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 01:28:37 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 467dR73hPVz9tysX;
        Wed, 14 Aug 2019 07:28:35 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=SJyMuRjs; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Emf7ZwD-8uSz; Wed, 14 Aug 2019 07:28:35 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 467dR72Wgqz9tysW;
        Wed, 14 Aug 2019 07:28:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1565760515; bh=cBLCcGqZYtPFnQ97sG88gUvqoP0qZ97rvAj0rE6pSks=;
        h=From:Subject:To:Cc:Date:From;
        b=SJyMuRjslWkUbJFg1pNT8CdaiFoiuf/pZlvJ48iRmVZg1OrtgYda2dXfwEw6T5Dle
         VaC0GFZxrDuy7QAsYlM21BPatf+5FHDgsKV6fqR6WKasa1ITTeyRjpCRrNDwn5i6nt
         fTJq/9vJXUsebUihn5XXaOFBHm3WzXiBmw/zar+8=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 42B778B780;
        Wed, 14 Aug 2019 07:28:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 79kopmmf8McE; Wed, 14 Aug 2019 07:28:36 +0200 (CEST)
Received: from pc17473vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.101])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2612A8B761;
        Wed, 14 Aug 2019 07:28:36 +0200 (CEST)
Received: by pc17473vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id EEEDB69635; Wed, 14 Aug 2019 05:28:35 +0000 (UTC)
Message-Id: <8c83a4e1237658ed1acfb9a9891048a15f9ca36b.1565760495.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/32s: fix boot failure with DEBUG_PAGEALLOC without
 KASAN.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, j.neuschaefer@gmx.net
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 14 Aug 2019 05:28:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When KASAN is selected, the definitive hash table has to be
set up later, but there is already an early temporary one.

When KASAN is not selected, there is no early hash table,
so the setup of the definitive hash table cannot be delayed.

Reported-by: Jonathan Neuschafer <j.neuschaefer@gmx.net>
Fixes: 72f208c6a8f7 ("powerpc/32s: move hash code patching out of MMU_init_hw()")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_32.S  | 2 ++
 arch/powerpc/mm/book3s32/mmu.c | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index f255e22184b4..c8b4f7ed318c 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -897,9 +897,11 @@ start_here:
 	bl	machine_init
 	bl	__save_cpu_setup
 	bl	MMU_init
+#ifdef CONFIG_KASAN
 BEGIN_MMU_FTR_SECTION
 	bl	MMU_init_hw_patch
 END_MMU_FTR_SECTION_IFSET(MMU_FTR_HPTE_TABLE)
+#endif
 
 /*
  * Go back to running unmapped so we can load up new values
diff --git a/arch/powerpc/mm/book3s32/mmu.c b/arch/powerpc/mm/book3s32/mmu.c
index e249fbf6b9c3..6ddcbfad5c9e 100644
--- a/arch/powerpc/mm/book3s32/mmu.c
+++ b/arch/powerpc/mm/book3s32/mmu.c
@@ -358,6 +358,11 @@ void __init MMU_init_hw(void)
 	hash_mb2 = hash_mb = 32 - LG_HPTEG_SIZE - lg_n_hpteg;
 	if (lg_n_hpteg > 16)
 		hash_mb2 = 16 - LG_HPTEG_SIZE;
+
+	if (IS_ENABLED(CONFIG_KASAN))
+		return;
+
+	MMU_init_hw_patch();
 }
 
 void __init MMU_init_hw_patch(void)
-- 
2.13.3

