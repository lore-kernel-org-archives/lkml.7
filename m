Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9EFC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 12:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 650082173E
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 12:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="LAoNsyoT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394519AbfHWMuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 08:50:22 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:19363 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391624AbfHWMuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 08:50:20 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46FLpd4cyxz9txM0;
        Fri, 23 Aug 2019 14:50:17 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=LAoNsyoT; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id SfhwT4Mbyq1G; Fri, 23 Aug 2019 14:50:17 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46FLpd3bh2z9txLw;
        Fri, 23 Aug 2019 14:50:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1566564617; bh=4cukybuxYzyKh4osdIe5zLMQPeJ6BNChd4Ex1TqwbvQ=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=LAoNsyoTy/Uy/TxiLZs39kyssTYThEDlkklrbs8dyKpjOEBfYoGCIa57RhK1nAicq
         0t7DH2XkOxAmEsWyrGNJdU7vfSM/HHBbVZdn7ffytF2jdWJ7K6QohNrWzAjJn+q7Mq
         9ym0Zv7t3Jsn72G5EuwnnBwy8U5Zeqd64JdjrKx8=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E53A38B87B;
        Fri, 23 Aug 2019 14:50:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 7gNk9FgxzWR6; Fri, 23 Aug 2019 14:50:18 +0200 (CEST)
Received: from pc16032vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C8D298B866;
        Fri, 23 Aug 2019 14:50:18 +0200 (CEST)
Received: by pc16032vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id B688B639BC; Fri, 23 Aug 2019 12:50:18 +0000 (UTC)
Message-Id: <331759c1bcba5797d30f8eace74afb16ac5f3c36.1566564560.git.christophe.leroy@c-s.fr>
In-Reply-To: <b51b96090138aba1920d2cf7c0e0e348667f9a69.1566564560.git.christophe.leroy@c-s.fr>
References: <b51b96090138aba1920d2cf7c0e0e348667f9a69.1566564560.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 2/2] powerpc/83xx: map IMMR with a BAT.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, oss@buserror.net,
        galak@kernel.crashing.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 23 Aug 2019 12:50:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On mpc83xx with a QE, IMMR is 2Mbytes.
On mpc83xx without a QE, IMMR is 1Mbytes.
Each driver will map a part of it to access the registers it needs.
Some driver will map the same part of IMMR as other drivers.

In order to reduce TLB misses, map the full IMMR with a BAT.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/platforms/83xx/misc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/powerpc/platforms/83xx/misc.c b/arch/powerpc/platforms/83xx/misc.c
index f46d7bf3b140..1e395b01c535 100644
--- a/arch/powerpc/platforms/83xx/misc.c
+++ b/arch/powerpc/platforms/83xx/misc.c
@@ -18,6 +18,8 @@
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 
+#include <mm/mmu_decl.h>
+
 #include "mpc83xx.h"
 
 static __be32 __iomem *restart_reg_base;
@@ -145,6 +147,14 @@ void __init mpc83xx_setup_arch(void)
 	if (ppc_md.progress)
 		ppc_md.progress("mpc83xx_setup_arch()", 0);
 
+	if (!__map_without_bats) {
+		int immrsize = IS_ENABLED(CONFIG_QUICC_ENGINE) ? SZ_2M : SZ_1M;
+
+		ioremap_bot = ALIGN_DOWN(ioremap_bot - immrsize, immrsize);
+		setbat(-1, ioremap_bot, get_immrbase(), immrsize, PAGE_KERNEL_NCG);
+		update_bats();
+	}
+
 	mpc83xx_setup_pci();
 }
 
-- 
2.13.3

