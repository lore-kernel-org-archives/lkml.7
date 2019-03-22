Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5C5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B46B7204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="VzTkpQzK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbfCVIIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 04:08:42 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:4816 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbfCVIIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 04:08:41 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44Qbrl4s4gz9v9vJ;
        Fri, 22 Mar 2019 09:08:39 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=VzTkpQzK; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id aIZLQCmG-dlv; Fri, 22 Mar 2019 09:08:39 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44Qbrl1Hypz9v9vG;
        Fri, 22 Mar 2019 09:08:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1553242119; bh=QYIgq5s3l/KmIW7pSyl/Y5gI2CGzi1RN0maTBRyqLko=;
        h=From:Subject:To:Cc:Date:From;
        b=VzTkpQzKE1QsnsG00Eo126PFnVs2QS34Zfg3LgFr4oUIQ8JPhUj4aSVbH0ArpWmYU
         45wBHHcXFTpKYZJ0mVILCus9TpVO8XLwKDlWg2XWQzEWe/6KBNI7m24D/enkiKWd0d
         T4q4CjH7EKcBOl/cU96nbMhWQiZiaDI5hsqb39Wc=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 21D988B845;
        Fri, 22 Mar 2019 09:08:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id N3ZIohavqxMC; Fri, 22 Mar 2019 09:08:40 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 00DE68B844;
        Fri, 22 Mar 2019 09:08:39 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id BD52C6CD85; Fri, 22 Mar 2019 08:08:39 +0000 (UTC)
Message-Id: <a2ac33258063682558fe0cac8eedcbd28aa4a141.1553242059.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 1/7] powerpc/fadump: define an empty fadump_cleanup()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 22 Mar 2019 08:08:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid #ifdefs, define an static inline fadump_cleanup() function
when CONFIG_FADUMP is not selected

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/fadump.h  | 1 +
 arch/powerpc/kernel/setup-common.c | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/fadump.h b/arch/powerpc/include/asm/fadump.h
index 188776befaf9..e2099c0a15c3 100644
--- a/arch/powerpc/include/asm/fadump.h
+++ b/arch/powerpc/include/asm/fadump.h
@@ -219,5 +219,6 @@ extern void fadump_cleanup(void);
 static inline int is_fadump_active(void) { return 0; }
 static inline int should_fadump_crash(void) { return 0; }
 static inline void crash_fadump(struct pt_regs *regs, const char *str) { }
+static inline void fadump_cleanup(void) { }
 #endif
 #endif
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 2e5dfb6e0823..971f50d99d87 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -133,13 +133,11 @@ int crashing_cpu = -1;
 /* also used by kexec */
 void machine_shutdown(void)
 {
-#ifdef CONFIG_FA_DUMP
 	/*
 	 * if fadump is active, cleanup the fadump registration before we
 	 * shutdown.
 	 */
 	fadump_cleanup();
-#endif
 
 	if (ppc_md.machine_shutdown)
 		ppc_md.machine_shutdown();
-- 
2.13.3

