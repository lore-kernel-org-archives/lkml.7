Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C26C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 06:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 228AE2084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 06:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="LAmp+0u2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbfDZGB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 02:01:27 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:3025 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbfDZF7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 01:59:40 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44r3Kj618Qz9v1v9;
        Fri, 26 Apr 2019 07:59:37 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=LAmp+0u2; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 0NDLkTTRlirj; Fri, 26 Apr 2019 07:59:37 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44r3Kj50whz9v1tj;
        Fri, 26 Apr 2019 07:59:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1556258377; bh=S8etuLC7X/p2OUH3x+AL9pvAO7h9KMljg67WQLaUeRQ=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=LAmp+0u2+bB0FI2hGDJw3Ea/NngO+IEkPH+JxEe+McudB2QUIYS8yalRlhu8TUow2
         WJLqGUOXdGP9DnIY0taeXfdjgGQH/VGqu7tmDAQ7tHJzrcBwA6BPTvBysrSM8aJAPd
         irQxtvAxPDdfZpJY7BmfMilDOPIf9EPxqpCrCwFc=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 93AB58B807;
        Fri, 26 Apr 2019 07:59:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id wkRFJZBwGCxj; Fri, 26 Apr 2019 07:59:38 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.6])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7CBEF8B74C;
        Fri, 26 Apr 2019 07:59:38 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 6F9EB66278; Fri, 26 Apr 2019 05:59:38 +0000 (UTC)
Message-Id: <11addb677de7449523fd0023a9ca43b8898c207a.1556258135.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1556258134.git.christophe.leroy@c-s.fr>
References: <cover.1556258134.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 03/17] powerpc/book3e: drop mmu_get_tsize()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 26 Apr 2019 05:59:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is not used anymore, drop it.

Fixes: b42279f0165c ("powerpc/mm/nohash: MM_SLICE is only used by book3s 64")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/hugetlbpage-book3e.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/powerpc/mm/hugetlbpage-book3e.c b/arch/powerpc/mm/hugetlbpage-book3e.c
index f84ec46cdb26..c911fe9bfa0e 100644
--- a/arch/powerpc/mm/hugetlbpage-book3e.c
+++ b/arch/powerpc/mm/hugetlbpage-book3e.c
@@ -49,11 +49,6 @@ static inline int tlb1_next(void)
 #endif /* !PPC64 */
 #endif /* FSL */
 
-static inline int mmu_get_tsize(int psize)
-{
-	return mmu_psize_defs[psize].enc;
-}
-
 #if defined(CONFIG_PPC_FSL_BOOK3E) && defined(CONFIG_PPC64)
 #include <asm/paca.h>
 
-- 
2.13.3

