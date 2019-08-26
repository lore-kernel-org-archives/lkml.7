Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FA9C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 434A1217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="F4HiHO09"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731698AbfHZPwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 11:52:16 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:53027 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730091AbfHZPwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 11:52:15 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46HGj53dmjz9v7Dm;
        Mon, 26 Aug 2019 17:52:09 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=F4HiHO09; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Onjx9NsiuY8B; Mon, 26 Aug 2019 17:52:09 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46HGj52Yyjz9v7Dl;
        Mon, 26 Aug 2019 17:52:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1566834729; bh=kt+CYoK4PGukDXYgVhxhNn93WidNLx35FNjgmxgzUro=;
        h=From:Subject:To:Cc:Date:From;
        b=F4HiHO09Hnl+Qa4+MNUIU8WW2D3FYQ5UR1EIwTfDHA7RJwVZ+Zt66BFQREA8cXdok
         kLP14vGG9vrZURNvwM+G3OLgJiOx4REgrSTHs/qx3IcI4DnwkJz0H38yVUNOB7rUYs
         wKf+kalw4m13bk+0CgrJ7Zt4+Raf1l+68Rs/cmfQ=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A87F08B7EF;
        Mon, 26 Aug 2019 17:52:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Sh8BbHsLWtL2; Mon, 26 Aug 2019 17:52:14 +0200 (CEST)
Received: from pc16032vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 307838B7E1;
        Mon, 26 Aug 2019 17:52:14 +0200 (CEST)
Received: by pc16032vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 03822696D5; Mon, 26 Aug 2019 15:52:13 +0000 (UTC)
Message-Id: <d644eaf7dff8cc149260066802af230bdf34fded.1566834712.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 1/6] powerpc/32s: add an option to exclusively select powerpc
 601
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 26 Aug 2019 15:52:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Powerpc 601 is rather old powerpc which as some important
limitations compared to other book3s/32 powerpcs:
- No Timebase.
- Common BATs for instruction and data.
- No execution protection in segment registers.
- No RI bit in MSR
- ...

It is starting to be difficult and cumbersome to maintain
kernels that are compatible both with 601 and other 6xx cores.

Create a compiletime option to exclusively select either powerpc 601
or other 6xx.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/platforms/Kconfig.cputype | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 56a7c814160d..68c5cc075bfc 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -6,6 +6,9 @@ config PPC64
 	  This option selects whether a 32-bit or a 64-bit kernel
 	  will be built.
 
+config PPC_BOOK3S_32
+	bool
+
 menu "Processor support"
 choice
 	prompt "Processor Type"
@@ -21,13 +24,20 @@ choice
 
 	  If unsure, select 52xx/6xx/7xx/74xx/82xx/83xx/86xx.
 
-config PPC_BOOK3S_32
-	bool "512x/52xx/6xx/7xx/74xx/82xx/83xx/86xx"
+config PPC_BOOK3S_6xx
+	bool "512x/52xx/6xx/7xx/74xx/82xx/83xx/86xx except 601"
+	select PPC_BOOK3S_32
 	select PPC_FPU
 	select PPC_HAVE_PMU_SUPPORT
 	select PPC_HAVE_KUEP
 	select PPC_HAVE_KUAP
 
+config PPC_BOOK3S_601
+	bool "PowerPC 601"
+	select PPC_BOOK3S_32
+	select PPC_FPU
+	select PPC_HAVE_KUAP
+
 config PPC_85xx
 	bool "Freescale 85xx"
 	select E500
-- 
2.13.3

