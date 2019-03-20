Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D53C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCE6C2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="UXQAx9tl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbfCTKGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 06:06:41 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:44331 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbfCTKGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 06:06:39 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44PQYm4ywgz9vC02;
        Wed, 20 Mar 2019 11:06:36 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=UXQAx9tl; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id PBIsXpi5yepw; Wed, 20 Mar 2019 11:06:36 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44PQYm3k2Rz9vC01;
        Wed, 20 Mar 2019 11:06:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1553076396; bh=gH27Q+wsMPSBaRBEw7DzthC9Zw2X1H7Bu5deFN9OacU=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=UXQAx9tl7EM9OIGIDgu/eIn5tMey1OCmB5J0sC4bAcSzbJxRKJMNZzGMqHqxHtb+m
         JEk5A/lP5JKj8pKMA1PwZlc2AxX1gWgGe0gGlyNJKW7QsGSjTzMNjhwPEOgfvMH534
         PasXKf3SgaSsLaZUjdRwDR/qQV2ndiZwa9VSJykI=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9FDC38B91B;
        Wed, 20 Mar 2019 11:06:37 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id r7mFnrvyGixu; Wed, 20 Mar 2019 11:06:37 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8570D8B919;
        Wed, 20 Mar 2019 11:06:37 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 7AF1163AEF; Wed, 20 Mar 2019 10:06:37 +0000 (UTC)
Message-Id: <02e312b13129a9bf96f0cd4a30b1802be0644900.1553076180.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1553076180.git.christophe.leroy@c-s.fr>
References: <cover.1553076180.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 02/27] powerpc/mm: don't BUG in add_huge_page_size()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 20 Mar 2019 10:06:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No reason to BUG() in add_huge_page_size(). Just WARN and
reject the add.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/hugetlbpage.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 9e732bb2c84a..cf2978e235f3 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -634,7 +634,8 @@ static int __init add_huge_page_size(unsigned long long size)
 	}
 #endif
 
-	BUG_ON(mmu_psize_defs[mmu_psize].shift != shift);
+	if (WARN_ON(mmu_psize_defs[mmu_psize].shift != shift))
+		return -EINVAL;
 
 	/* Return if huge page size has already been setup */
 	if (size_to_hstate(size))
-- 
2.13.3

