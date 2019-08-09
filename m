Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629FDC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 14:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3150D20B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 14:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="cnHUmmtn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407167AbfHIO6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 10:58:14 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:16594 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406596AbfHIO6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 10:58:14 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 464pJf4gQhz9vBKs;
        Fri,  9 Aug 2019 16:58:10 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=cnHUmmtn; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id d-XYHNiLXOJe; Fri,  9 Aug 2019 16:58:10 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 464pJf3fRFz9v0kX;
        Fri,  9 Aug 2019 16:58:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1565362690; bh=MWqbG02vkZmNYQgLQGkfZFOAvx7JkFoLhh24LWW8kCI=;
        h=From:Subject:To:Cc:Date:From;
        b=cnHUmmtnQbPBPQSeAw7VzlG/HjuXIb6T4LFfn3QG4/hyBgFr5oe4zH76K8HLt49cd
         bh5fUeZzNAYFw9rtBT71q9d5bM4iZl4VbhqHdNmXw5ejFeEMnf4PEH9Yv7qrwwBbrY
         mwd9QTzWWi3506wCtdtSh3dDVzvetF9FRZkG08GI=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0C99B8B8C0;
        Fri,  9 Aug 2019 16:58:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id P_yhTTF5u-0A; Fri,  9 Aug 2019 16:58:11 +0200 (CEST)
Received: from pc17473vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.101])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D231A8B8BB;
        Fri,  9 Aug 2019 16:58:11 +0200 (CEST)
Received: by pc17473vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id D524369641; Fri,  9 Aug 2019 14:58:11 +0000 (UTC)
Message-Id: <f1d777d5f287a87bc74580091a9b6a856eb77244.1565361885.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/ptdump: fix addresses display on PPC32
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri,  9 Aug 2019 14:58:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 453d87f6a8ae ("powerpc/mm: Warn if W+X pages found on boot")
wrongly changed KERN_VIRT_START from 0 to PAGE_OFFSET, leading to a
shift in the displayed addresses.

Lets revert that change to resync walk_pagetables()'s addr val and
pgd_t pointer for PPC32.

Fixes: 453d87f6a8ae ("powerpc/mm: Warn if W+X pages found on boot")
Cc: stable@vger.kernel.org
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/ptdump/ptdump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/ptdump/ptdump.c b/arch/powerpc/mm/ptdump/ptdump.c
index 6a88a9f585d4..3ad64fc11419 100644
--- a/arch/powerpc/mm/ptdump/ptdump.c
+++ b/arch/powerpc/mm/ptdump/ptdump.c
@@ -27,7 +27,7 @@
 #include "ptdump.h"
 
 #ifdef CONFIG_PPC32
-#define KERN_VIRT_START	PAGE_OFFSET
+#define KERN_VIRT_START	0
 #endif
 
 /*
-- 
2.13.3

