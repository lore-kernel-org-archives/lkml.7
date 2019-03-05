Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C90C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 21:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B39AE20842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 21:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="buK9qt5k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbfCEVSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 16:18:45 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:7459 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727253AbfCEVST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 16:18:19 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44DV9j1yQ3z9v6LV;
        Tue,  5 Mar 2019 22:18:17 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=buK9qt5k; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id pmbhqQvpZHN4; Tue,  5 Mar 2019 22:18:17 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44DV9j0Y8pz9v6LR;
        Tue,  5 Mar 2019 22:18:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1551820697; bh=J2snRjsJwZQgUxCze7YuCoxtC4D3rNW9vbqso4nGn0o=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=buK9qt5k8EZndPM+wO/mXVGwn8oNrps4QCJLijRYVBoBa+It4/sxNeY4Yz7lGdTIL
         VBz82rg1ZVnR2c6GsqLChPvfsGiCBwh5QjrHnqvprm1cVruW93ooXMLa+LLLz9RQEj
         59DOEv0OJdQ48qkZzDyPweLT3Q+/aiAXfi34s97Y=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3D8808B860;
        Tue,  5 Mar 2019 22:18:17 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id urgTIgCn6E3N; Tue,  5 Mar 2019 22:18:17 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 123BA8B83A;
        Tue,  5 Mar 2019 22:18:17 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
        id C95336F8CD; Tue,  5 Mar 2019 21:18:16 +0000 (UTC)
Message-Id: <ed5aaa7378db4145c3174148c30fa838be05166f.1551820475.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1551820474.git.christophe.leroy@c-s.fr>
References: <cover.1551820474.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 3/7] powerpc/8xx: Add Kernel Userspace Execution Prevention
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, ruscur@russell.cc
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue,  5 Mar 2019 21:18:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds Kernel Userspace Execution Prevention on the 8xx.

When a page is Executable, it is set Executable for Key 0 and NX
for Key 1.

Up to now, the User group is defined with Key 0 for both User and
Supervisor.

By changing the group to Key 0 for User and Key 1 for Supervisor,
this patch prevents the Kernel from being able to execute user code.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/nohash/32/mmu-8xx.h |  7 +++++++
 arch/powerpc/mm/8xx_mmu.c                    | 12 ++++++++++++
 arch/powerpc/platforms/Kconfig.cputype       |  1 +
 3 files changed, 20 insertions(+)

diff --git a/arch/powerpc/include/asm/nohash/32/mmu-8xx.h b/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
index fc5a653d5dd2..3cb743284e09 100644
--- a/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
@@ -41,6 +41,13 @@
  */
 #define MI_APG_INIT	0x4fffffff
 
+/*
+ * 0 => Kernel => 01 (all accesses performed according to page definition)
+ * 1 => User => 10 (all accesses performed according to swaped page definition)
+ * 2-16 => NA => 11 (all accesses performed as user iaw page definition)
+ */
+#define MI_APG_KUEP	0x6fffffff
+
 /* The effective page number register.  When read, contains the information
  * about the last instruction TLB miss.  When MI_RPN is written, bits in
  * this register are used to create the TLB entry.
diff --git a/arch/powerpc/mm/8xx_mmu.c b/arch/powerpc/mm/8xx_mmu.c
index fe1f6443d57f..e257a0c9bd08 100644
--- a/arch/powerpc/mm/8xx_mmu.c
+++ b/arch/powerpc/mm/8xx_mmu.c
@@ -213,3 +213,15 @@ void flush_instruction_cache(void)
 	mtspr(SPRN_IC_CST, IDC_INVALL);
 	isync();
 }
+
+#ifdef CONFIG_PPC_KUEP
+void __init setup_kuep(bool disabled)
+{
+	if (disabled)
+		return;
+
+	pr_info("Activating Kernel Userspace Execution Prevention\n");
+
+	mtspr(SPRN_MI_AP, MI_APG_KUEP);
+}
+#endif
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 5e53b9fd62aa..08966e3127bb 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -34,6 +34,7 @@ config PPC_8xx
 	bool "Freescale 8xx"
 	select FSL_SOC
 	select SYS_SUPPORTS_HUGETLBFS
+	select PPC_HAVE_KUEP
 
 config 40x
 	bool "AMCC 40x"
-- 
2.13.3

