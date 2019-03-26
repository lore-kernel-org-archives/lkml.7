Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9326EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 582852087E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="W4DHT3b6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730133AbfCZGWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:22:49 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:4358 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726042AbfCZGWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:22:49 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44T1Jl4BCLz9v25X;
        Tue, 26 Mar 2019 07:22:47 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=W4DHT3b6; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id NdcXtlL4QN6z; Tue, 26 Mar 2019 07:22:47 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44T1Jl2pyRz9v08b;
        Tue, 26 Mar 2019 07:22:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1553581367; bh=ZbeUJFNcmgAwdVqoLlYvxGMo2fvfK5NdEsuuEIPc5Qw=;
        h=From:Subject:To:Cc:Date:From;
        b=W4DHT3b67zKJPFRbwa+83Qi7Hg+tNGRVrH12bCklb392yiTS+UQUey4p2tgTETfGp
         VHMNrhgaVuO8+zxvrzsPAATdEfTQlbOCft33shdBB/IjmsA/wa1alkyapUOPydURAv
         byWTMb2YBmv3hxXZm8W5SF0CsYzE3rZnaKlJ78xg=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3775D8B77C;
        Tue, 26 Mar 2019 07:22:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id vfVjAI5P02Rd; Tue, 26 Mar 2019 07:22:48 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 07A328B74C;
        Tue, 26 Mar 2019 07:22:48 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
        id AAC6A69D61; Tue, 26 Mar 2019 06:22:47 +0000 (UTC)
Message-Id: <670fb3e35793383652b961458c47ce865736a65f.1553581290.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 1/3] powerpc/32s: drop Hash_end
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 26 Mar 2019 06:22:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hash_end has never been used, drop it.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
v2: no change

 arch/powerpc/mm/mmu_decl.h   | 2 +-
 arch/powerpc/mm/ppc_mmu_32.c | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index 74ff61dabcb1..f7f1374ba3ee 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -104,7 +104,7 @@ extern int __map_without_bats;
 extern unsigned int rtas_data, rtas_size;
 
 struct hash_pte;
-extern struct hash_pte *Hash, *Hash_end;
+extern struct hash_pte *Hash;
 extern unsigned long Hash_size, Hash_mask;
 
 #endif /* CONFIG_PPC32 */
diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
index f29d2f118b44..302409fcfbc7 100644
--- a/arch/powerpc/mm/ppc_mmu_32.c
+++ b/arch/powerpc/mm/ppc_mmu_32.c
@@ -36,7 +36,7 @@
 
 #include "mmu_decl.h"
 
-struct hash_pte *Hash, *Hash_end;
+struct hash_pte *Hash;
 unsigned long Hash_size, Hash_mask;
 unsigned long _SDR1;
 
@@ -345,8 +345,6 @@ void __init MMU_init_hw(void)
 		      __func__, Hash_size, Hash_size);
 	_SDR1 = __pa(Hash) | SDR1_LOW_BITS;
 
-	Hash_end = (struct hash_pte *) ((unsigned long)Hash + Hash_size);
-
 	printk("Total memory = %lldMB; using %ldkB for hash table (at %p)\n",
 	       (unsigned long long)(total_memory >> 20), Hash_size >> 10, Hash);
 
-- 
2.13.3

