Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E61FC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 294E6206C0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="M5Pxf4lV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbfDDMUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 08:20:09 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:38109 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727039AbfDDMUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 08:20:09 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44Zhps1vMKz9v0gQ;
        Thu,  4 Apr 2019 14:20:05 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=M5Pxf4lV; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id lvE3JP5egYrE; Thu,  4 Apr 2019 14:20:05 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44Zhps0bWfz9v0gP;
        Thu,  4 Apr 2019 14:20:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1554380405; bh=qVAsrHjgcFhyoqX0iHv0EYygZp1BM3I6QKY+IS8H7mA=;
        h=From:Subject:To:Cc:Date:From;
        b=M5Pxf4lVxJCK7gy+lp6kuokyNnDe49B9TFT4Odp3Fa8Up6CE/gdx1AOCrz2fIxcwD
         xjgGmffz1Snavb6TXa9fFYzwfXcnQ9Z6HHCw6fcrR00lmDsseaUyxkv4IFdYABckWN
         47Lm/19pVFz8EypeknfK9C8S5o8PXshdjg2gSaB0=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 620278B920;
        Thu,  4 Apr 2019 14:20:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id HK5_7w3khueB; Thu,  4 Apr 2019 14:20:06 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.204.43])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 07EF58B917;
        Thu,  4 Apr 2019 14:20:06 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id B1D8166280; Thu,  4 Apr 2019 12:20:05 +0000 (UTC)
Message-Id: <0d8c9cb7fb43bde8663333bb6a69d16380a219a5.1554380255.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/vdso32: fix CLOCK_MONOTONIC on PPC64
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christian Zigotzky <chzigotzky@xenosoft.de>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu,  4 Apr 2019 12:20:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b5b4453e7912 ("powerpc/vdso64: Fix CLOCK_MONOTONIC
inconsistencies across Y2038") changed the type of wtom_clock_sec
to s64 on PPC64. Therefore, VDSO32 needs to read it with a 4 bytes
shift in order to retrieve the lower part of it.

Fixes: b5b4453e7912 ("powerpc/vdso64: Fix CLOCK_MONOTONIC inconsistencies across Y2038")
Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/vdso32/gettimeofday.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/vdso32/gettimeofday.S b/arch/powerpc/kernel/vdso32/gettimeofday.S
index 1e0bc5955a40..afd516b572f8 100644
--- a/arch/powerpc/kernel/vdso32/gettimeofday.S
+++ b/arch/powerpc/kernel/vdso32/gettimeofday.S
@@ -98,7 +98,7 @@ V_FUNCTION_BEGIN(__kernel_clock_gettime)
 	 * can be used, r7 contains NSEC_PER_SEC.
 	 */
 
-	lwz	r5,WTOM_CLOCK_SEC(r9)
+	lwz	r5,(WTOM_CLOCK_SEC+LOPART)(r9)
 	lwz	r6,WTOM_CLOCK_NSEC(r9)
 
 	/* We now have our offset in r5,r6. We create a fake dependency
-- 
2.13.3

