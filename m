Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18464C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 06:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF0F02084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 06:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Jg6FRVjA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfDZF7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 01:59:42 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:38531 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbfDZF7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 01:59:39 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44r3Kh5zjMz9v1v8;
        Fri, 26 Apr 2019 07:59:36 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=Jg6FRVjA; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 3BihIFiSZerr; Fri, 26 Apr 2019 07:59:36 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44r3Kh4xH4z9v1tj;
        Fri, 26 Apr 2019 07:59:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1556258376; bh=TJnDwm+UkR7ne5GWLWogSs2op89RjaK7n1C4W7S+zpg=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=Jg6FRVjA+kqV+42o266wlWtnHHlNc8UEcJCV3d9S4RkZuOOMkBfgQxPQbWbKSNPZp
         BN60HIdv8DvUTsJVmspfPAtOxWXGYS8OIIvL6pp/JxLVKY7skV/UL5X06Flfihff6R
         n8G3DdtAiUZ8HpMLP+QATiiJNNUG/W6/aGA1VMJY=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8F3D38B807;
        Fri, 26 Apr 2019 07:59:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 8sMxq4GO65cU; Fri, 26 Apr 2019 07:59:37 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.6])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 73E6D8B74C;
        Fri, 26 Apr 2019 07:59:37 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 68B1866278; Fri, 26 Apr 2019 05:59:37 +0000 (UTC)
Message-Id: <f78719ab63fdb1dbc3a1df17dd0f7ee1cfb209cd.1556258135.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1556258134.git.christophe.leroy@c-s.fr>
References: <cover.1556258134.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 02/17] powerpc/mm: don't BUG in add_huge_page_size()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 26 Apr 2019 05:59:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use VM_BUG_ON() instead of BUG_ON(), as those BUG_ON()
are not there to catch runtime errors but to catch errors
during development cycle only.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/hugetlbpage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 9e732bb2c84a..6b9b6d747df3 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -634,7 +634,7 @@ static int __init add_huge_page_size(unsigned long long size)
 	}
 #endif
 
-	BUG_ON(mmu_psize_defs[mmu_psize].shift != shift);
+	VM_BUG_ON(mmu_psize_defs[mmu_psize].shift != shift);
 
 	/* Return if huge page size has already been setup */
 	if (size_to_hstate(size))
-- 
2.13.3

