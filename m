Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F0CC10F05
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B11C72146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="ZpUU6kNE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbfCTIGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 04:06:40 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:25205 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727438AbfCTIGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 04:06:40 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44PMvL16Slz9v0sH;
        Wed, 20 Mar 2019 09:06:38 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=ZpUU6kNE; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id KlrkXiYREPx0; Wed, 20 Mar 2019 09:06:38 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44PMvK75DBz9v0sF;
        Wed, 20 Mar 2019 09:06:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1553069198; bh=ojpYivvnzd/xdpAwdvwKku22o+9yC4Pjbi1/EclCr8U=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=ZpUU6kNEhxF+MHjv4DGccRhPqTByXAcdFfRkVY4WTtSNyf8GW1O60A4z7f4jTx3H6
         JAfffYCBhQYirDzVGNyj1b+UizgvlKKvJm+iQs8/8FbTEit/o7hee21GtjMv/tZdnN
         WSdkz1YIZoZU+JqDhsGe7mLvkj23SdoHXXe+/bYk=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E66A08B8FE;
        Wed, 20 Mar 2019 09:06:38 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id uVY4vAfYH4uB; Wed, 20 Mar 2019 09:06:38 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CA6928B8F8;
        Wed, 20 Mar 2019 09:06:38 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id B73EE63AF9; Wed, 20 Mar 2019 08:06:38 +0000 (UTC)
Message-Id: <d781ed8028f6c4284bd81bd292bb9c5b67bd22ac.1553069097.git.christophe.leroy@c-s.fr>
In-Reply-To: <67ed3a31a16b9ece870ec55139e83c86d4d9ce60.1553069097.git.christophe.leroy@c-s.fr>
References: <67ed3a31a16b9ece870ec55139e83c86d4d9ce60.1553069097.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 2/3] powerpc/32s: don't try to print hash table address.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 20 Mar 2019 08:06:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to %p, (ptrval) is printed in lieu of the hash table address.

showing the hash table address isn't an operationnal need so just
don't print it.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
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

