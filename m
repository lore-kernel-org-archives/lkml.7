Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD965C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA5C620857
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Cw1FdnRy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730559AbfCZGWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:22:52 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:48420 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726042AbfCZGWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:22:50 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44T1Jm2r4qz9v25c;
        Tue, 26 Mar 2019 07:22:48 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=Cw1FdnRy; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id NbAEM5Jsbpcq; Tue, 26 Mar 2019 07:22:48 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44T1Jm1mY5z9v08b;
        Tue, 26 Mar 2019 07:22:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1553581368; bh=8IItZYW8vabpMo1rG9cZhGmKmuBvkmGJgF2kWvvF/bc=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=Cw1FdnRyDUu564rZJy34OSIXMVjupHT0qjyiR3BIdzSSDW2eAW6XWAWrrji3upcaM
         hA/0QhAN8RqRhpEjxr8Q5hX8UgwvZwtTEpO+ZOB5paf4kETq7usSwmUWEAVV5kGiNn
         B+9J5Vv7L+t96pxirYc8xXgcpfKhNCdo1k6DM3gI=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 115208B77C;
        Tue, 26 Mar 2019 07:22:49 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id u6Sml1DhczSp; Tue, 26 Mar 2019 07:22:49 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E515B8B74C;
        Tue, 26 Mar 2019 07:22:48 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
        id BA2E369D61; Tue, 26 Mar 2019 06:22:48 +0000 (UTC)
Message-Id: <9f61800c337739978e27573eecf131232653253b.1553581290.git.christophe.leroy@c-s.fr>
In-Reply-To: <670fb3e35793383652b961458c47ce865736a65f.1553581290.git.christophe.leroy@c-s.fr>
References: <670fb3e35793383652b961458c47ce865736a65f.1553581290.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 2/3] powerpc/32s: don't try to print hash table address.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 26 Mar 2019 06:22:48 +0000 (UTC)
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

 arch/powerpc/mm/ppc_mmu_32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
index 302409fcfbc7..088f14d57cce 100644
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

