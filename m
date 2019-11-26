Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0506C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAAB72075C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="uAldGN5+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbfKZNQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 08:16:58 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:22502 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728218AbfKZNQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 08:16:55 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47MkvP6XmTz9tyb0;
        Tue, 26 Nov 2019 14:16:49 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=uAldGN5+; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 3B3y0eiynEqK; Tue, 26 Nov 2019 14:16:49 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47MkvP5C1Jz9tyZy;
        Tue, 26 Nov 2019 14:16:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1574774209; bh=o2KMmBr8sAjZnQ9mvPFWAsTD5BcQbsNwgSyjJYicEh0=;
        h=From:Subject:To:Cc:Date:From;
        b=uAldGN5+ZXRCqSv1nfztzsOCw5Ut+Y5Nwcm9pRg8PB+YPZjNaSy7N/WKxvUREbWKA
         ATcAVyLMc7dccwY+fW7CSdt1DpvMaVPnl4QIahjWf0K1e6cDxJb6u8b8+62+RvqDXB
         GQ9iymhNFtxUYy3/YE4/FVWwF+991EBIyaTpF5JE=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EDF658B803;
        Tue, 26 Nov 2019 14:16:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id KTSDcJ2b34ju; Tue, 26 Nov 2019 14:16:50 +0100 (CET)
Received: from po16098vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BD6798B801;
        Tue, 26 Nov 2019 14:16:50 +0100 (CET)
Received: by po16098vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 7A4D06B76A; Tue, 26 Nov 2019 13:16:50 +0000 (UTC)
Message-Id: <45f4f414bcd7198b0755cf4287ff216fbfc24b9d.1574774187.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2] powerpc/8xx: Fix permanently mapped IMMR region.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 26 Nov 2019 13:16:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When not using large TLBs, the IMMR region is still
mapped as a whole block in the FIXMAP area.

Properly report that the IMMR region is block-mapped even
when not using large TLBs.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

---
v2: rebased on today's powerpc/next (this drops the change to mem.c which is already merged)
---
 arch/powerpc/mm/nohash/8xx.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/mm/nohash/8xx.c b/arch/powerpc/mm/nohash/8xx.c
index 090af2d2d3e4..2c98078d2ede 100644
--- a/arch/powerpc/mm/nohash/8xx.c
+++ b/arch/powerpc/mm/nohash/8xx.c
@@ -21,33 +21,34 @@ extern int __map_without_ltlbs;
 static unsigned long block_mapped_ram;
 
 /*
- * Return PA for this VA if it is in an area mapped with LTLBs.
+ * Return PA for this VA if it is in an area mapped with LTLBs or fixmap.
  * Otherwise, returns 0
  */
 phys_addr_t v_block_mapped(unsigned long va)
 {
 	unsigned long p = PHYS_IMMR_BASE;
 
-	if (__map_without_ltlbs)
-		return 0;
 	if (va >= VIRT_IMMR_BASE && va < VIRT_IMMR_BASE + IMMR_SIZE)
 		return p + va - VIRT_IMMR_BASE;
+	if (__map_without_ltlbs)
+		return 0;
 	if (va >= PAGE_OFFSET && va < PAGE_OFFSET + block_mapped_ram)
 		return __pa(va);
 	return 0;
 }
 
 /*
- * Return VA for a given PA mapped with LTLBs or 0 if not mapped
+ * Return VA for a given PA mapped with LTLBs or fixmap
+ * Return 0 if not mapped
  */
 unsigned long p_block_mapped(phys_addr_t pa)
 {
 	unsigned long p = PHYS_IMMR_BASE;
 
-	if (__map_without_ltlbs)
-		return 0;
 	if (pa >= p && pa < p + IMMR_SIZE)
 		return VIRT_IMMR_BASE + pa - p;
+	if (__map_without_ltlbs)
+		return 0;
 	if (pa < block_mapped_ram)
 		return (unsigned long)__va(pa);
 	return 0;
-- 
2.13.3

