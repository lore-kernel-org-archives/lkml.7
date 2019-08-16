Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10784C3A59F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 05:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCA8E205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 05:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Ss7r/3Um"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfHPFlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 01:41:47 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:5748 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbfHPFlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 01:41:45 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 468sdM5YMtz9tyNF;
        Fri, 16 Aug 2019 07:41:43 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=Ss7r/3Um; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id IZ7b_pcq_bh4; Fri, 16 Aug 2019 07:41:43 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 468sdM4X3mz9tyN5;
        Fri, 16 Aug 2019 07:41:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1565934103; bh=7s8jVKSKP+mpm0O7YdWUQnf6EkvBTK/qKccC9rAQ2FE=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=Ss7r/3Umd+bYpvjlI+83xh4kVSSwYr/4zlkScCXPj7YvYvp7DVe3mAovOTns4UXzS
         GBg40LwJu4RHCtKaWFogE/Q4it+6+MghzkgrpNVKdtY+B1sjJ6KFFxsTGJoiYAUu6f
         iIP8sgpPGj/KMjKs+5OQDmnQLN7CDr4KC9F43RvQ=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 902438B776;
        Fri, 16 Aug 2019 07:41:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id BMt9LnyIvktb; Fri, 16 Aug 2019 07:41:44 +0200 (CEST)
Received: from pc17473vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.101])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 776468B754;
        Fri, 16 Aug 2019 07:41:44 +0200 (CEST)
Received: by pc17473vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 6A67C6B6CC; Fri, 16 Aug 2019 05:41:44 +0000 (UTC)
Message-Id: <6133e0f115d955fac4061536dab0fa7480a1c433.1565933217.git.christophe.leroy@c-s.fr>
In-Reply-To: <668aba4db6b9af6d8a151174e11a4289f1a6bbcd.1565933217.git.christophe.leroy@c-s.fr>
References: <668aba4db6b9af6d8a151174e11a4289f1a6bbcd.1565933217.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 5/5] powerpc/mm: ppc 603 doesn't need update_mmu_cache()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 16 Aug 2019 05:41:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On powerpc 603, there is no hash table so get out of
update_mmu_cache() early.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/book3s32/mmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/mm/book3s32/mmu.c b/arch/powerpc/mm/book3s32/mmu.c
index 3a62bf99f93f..c20269be79ec 100644
--- a/arch/powerpc/mm/book3s32/mmu.c
+++ b/arch/powerpc/mm/book3s32/mmu.c
@@ -319,6 +319,8 @@ void hash_preload(struct mm_struct *mm, unsigned long ea)
 void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
 		      pte_t *ptep)
 {
+	if (!mmu_has_feature(MMU_FTR_HPTE_TABLE))
+		return;
 	/*
 	 * We don't need to worry about _PAGE_PRESENT here because we are
 	 * called with either mm->page_table_lock held or ptl lock held
-- 
2.13.3

