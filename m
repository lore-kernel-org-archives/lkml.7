Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5D6C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 15:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9653C20665
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 15:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="bI7NTUW8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405411AbfFKPrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 11:47:23 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:39280 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389302AbfFKPrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 11:47:23 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45NZBc2NN5z9v0FR;
        Tue, 11 Jun 2019 17:47:20 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=bI7NTUW8; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id B7h4bXuV-81Y; Tue, 11 Jun 2019 17:47:20 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45NZBc0hwjz9v0FQ;
        Tue, 11 Jun 2019 17:47:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1560268040; bh=1fnYeG8GbpjnYF6TrsfmDTOmxu5dgndNejmbugqQbx8=;
        h=From:Subject:To:Cc:Date:From;
        b=bI7NTUW88Vx5QZFajwgZyStnlVOl6u4+b+RdZ95JenYNvgDN462Dclzmdg+Ob4seQ
         nR9EWjUxHij/lbqFk2OpzV6SRucW26gHJ4nhgaegJvU36t82qnh+8q3JE5NNSkS3JY
         JXpI+yxyVdLmrGD0cghtcOglJUQaFKID6V7MNUoA=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 587AA8B7F8;
        Tue, 11 Jun 2019 17:47:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id qgv5iWZpPYN7; Tue, 11 Jun 2019 17:47:21 +0200 (CEST)
Received: from po16838vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E5E578B7F7;
        Tue, 11 Jun 2019 17:47:20 +0200 (CEST)
Received: by po16838vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id B4CAB68D05; Tue, 11 Jun 2019 15:47:20 +0000 (UTC)
Message-Id: <be07403806abc56ec027f6d47468411876e18bb5.1560267983.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/32s: fix initial setup of segment registers on
 secondary CPU
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, erhard_f@mailbox.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 11 Jun 2019 15:47:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch referenced below moved the loading of segment registers
out of load_up_mmu() in order to do it earlier in the boot sequence.
However, the secondary CPU still needs it to be done when loading up
the MMU.

Reported-by: Erhard F. <erhard_f@mailbox.org>
Fixes: 215b823707ce ("powerpc/32s: set up an early static hash table for KASAN")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_32.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 1d5f1bd0dacd..f255e22184b4 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -752,6 +752,7 @@ __secondary_start:
 	stw	r0,0(r3)
 
 	/* load up the MMU */
+	bl	load_segment_registers
 	bl	load_up_mmu
 
 	/* ptr to phys current thread */
-- 
2.13.3

