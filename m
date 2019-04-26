Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC1EC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BD7621479
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Sl9rI/oZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfDZQgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 12:36:43 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:10895 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbfDZQgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 12:36:39 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44rKSh50fqz9v0yn;
        Fri, 26 Apr 2019 18:36:36 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=Sl9rI/oZ; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id wuG5iaQirD7P; Fri, 26 Apr 2019 18:36:36 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44rKSh3x6Gz9v0yk;
        Fri, 26 Apr 2019 18:36:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1556296596; bh=Me8MRiBVBQiSLqO5pJxA3Rt0BYwIfdx8knhHIdMg09A=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=Sl9rI/oZbaame766iWQPPn7q/7KYZy7FiGJja/HNyN2FlteErmK0I+w+QHzWntPuA
         DJtfiH0xW0PCS/rB+lTB09g3KtecbF2mZrNSTZP+02UXMsdN789aCH2ZXWUTRJtA/D
         NV72UDEAnmtxYCFRtXe4pBtAELgn2y7gcBGPJ+YA=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 23C988B950;
        Fri, 26 Apr 2019 18:36:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id FVq9YcvIo3uZ; Fri, 26 Apr 2019 18:36:38 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.6])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0C6DE8B82F;
        Fri, 26 Apr 2019 18:36:38 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 02A48666FD; Fri, 26 Apr 2019 16:36:37 +0000 (UTC)
Message-Id: <bbb4d25d4c505a256bfab038dc69d173afb6b52f.1556296364.git.christophe.leroy@c-s.fr>
In-Reply-To: <809c41e209068baf1045edbf154cc8d25c520d1e.1556296364.git.christophe.leroy@c-s.fr>
References: <809c41e209068baf1045edbf154cc8d25c520d1e.1556296364.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 2/3] powerpc/32s: don't try to print hash table address.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 26 Apr 2019 16:36:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to %p, (ptrval) is printed in lieu of the hash table address.

showing the hash table address isn't an operationnal need so just
don't print it.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
v2: no change
v3: no change

 arch/powerpc/mm/ppc_mmu_32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
index 061feab884a6..c908538720ac 100644
--- a/arch/powerpc/mm/ppc_mmu_32.c
+++ b/arch/powerpc/mm/ppc_mmu_32.c
@@ -345,8 +345,8 @@ void __init MMU_init_hw(void)
 		      __func__, Hash_size, Hash_size);
 	_SDR1 = __pa(Hash) | SDR1_LOW_BITS;
 
-	printk("Total memory = %lldMB; using %ldkB for hash table (at %p)\n",
-	       (unsigned long long)(total_memory >> 20), Hash_size >> 10, Hash);
+	pr_info("Total memory = %lldMB; using %ldkB for hash table\n",
+		(unsigned long long)(total_memory >> 20), Hash_size >> 10);
 
 
 	/*
-- 
2.13.3

