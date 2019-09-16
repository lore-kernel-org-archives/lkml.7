Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CA6C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 06:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0D7520830
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 06:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="fWp/Sd3E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbfIPGm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 02:42:57 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:8149 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729949AbfIPGm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 02:42:57 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46WxWb43F5z9ttgV;
        Mon, 16 Sep 2019 08:42:51 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=fWp/Sd3E; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id pyJyMyAc_DYU; Mon, 16 Sep 2019 08:42:51 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46WxWb2kGXz9ttgK;
        Mon, 16 Sep 2019 08:42:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1568616171; bh=7yOhcbQ3kkJvXHAKpVB1ac6bJmwMGcGUBxtNLWRyWBU=;
        h=From:Subject:To:Cc:Date:From;
        b=fWp/Sd3E5hLYs5tiZttauQJnA02xxckK6mzUfwoSY1HVKTWEPG6oLUjKwI+9ARc1W
         ironm4ki2c3v3d3rsd9aDtTmyu9THr913xbD4OY/da6Jt+rzIa+VpJEf8gpQI3RiNc
         OV9aUplfXG+ceKL5/lZdYMCTIWwYsYOVWtBq28RA=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EE09C8B7CA;
        Mon, 16 Sep 2019 08:42:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id BqLszcFm49l2; Mon, 16 Sep 2019 08:42:55 +0200 (CEST)
Received: from pc16032vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B16638B752;
        Mon, 16 Sep 2019 08:42:55 +0200 (CEST)
Received: by pc16032vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 45C046B763; Mon, 16 Sep 2019 06:42:55 +0000 (UTC)
Message-Id: <966e6d6a226f9786098d296239a6c65064e73a41.1568616151.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 1/2] powerpc/32s: automatically allocate BAT in setbat()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, oss@buserror.net,
        galak@kernel.crashing.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 16 Sep 2019 06:42:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If no BAT is given to setbat(), select an available BAT.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

---
v2: no change
---
 arch/powerpc/mm/book3s32/mmu.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/book3s32/mmu.c b/arch/powerpc/mm/book3s32/mmu.c
index 84d5fab94f8f..69b2419accef 100644
--- a/arch/powerpc/mm/book3s32/mmu.c
+++ b/arch/powerpc/mm/book3s32/mmu.c
@@ -251,9 +251,18 @@ void __init setbat(int index, unsigned long virt, phys_addr_t phys,
 {
 	unsigned int bl;
 	int wimgxpp;
-	struct ppc_bat *bat = BATS[index];
+	struct ppc_bat *bat;
 	unsigned long flags = pgprot_val(prot);
 
+	if (index == -1)
+		index = find_free_bat();
+	if (index == -1) {
+		pr_err("%s: no BAT available for mapping 0x%llx\n", __func__,
+		       (unsigned long long)phys);
+		return;
+	}
+	bat = BATS[index];
+
 	if ((flags & _PAGE_NO_CACHE) ||
 	    (cpu_has_feature(CPU_FTR_NEED_COHERENT) == 0))
 		flags &= ~_PAGE_COHERENT;
-- 
2.13.3

