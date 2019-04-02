Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1874BC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA8D6207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="kmQnCQqC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729984AbfDBJJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 05:09:04 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:19094 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729880AbfDBJIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 05:08:42 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44YNfv2kdjz9v0Zp;
        Tue,  2 Apr 2019 11:08:39 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=kmQnCQqC; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Es3JDTTXk7Tb; Tue,  2 Apr 2019 11:08:39 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44YNfv1V4Dz9v0ZY;
        Tue,  2 Apr 2019 11:08:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1554196119; bh=oZVnBb9F8M23G0fBOCsT3v+mbLC89R0u6GvQYlqjZkI=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=kmQnCQqCkHLooK1iqlUtUstm8Tx8DoDTfvdeILyiJNxqsikIcFPBRx0sSdJzlOTdj
         C/Ta62VrdZ0wfpz9UebtivwVCgiRT590VX61HKxcYRwGVBBs5LCmsl40MoPBRbwII7
         B1OIXtrClaF2CD0E9CivyRAAdpqYm2sBYoBChZyY=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 497A48B8C4;
        Tue,  2 Apr 2019 11:08:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id aJtUAZGGgSan; Tue,  2 Apr 2019 11:08:40 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 143EA8B8C3;
        Tue,  2 Apr 2019 11:08:40 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id ECCA7661D9; Tue,  2 Apr 2019 09:08:39 +0000 (UTC)
Message-Id: <a3ba0b0f56ffedb380be0a7856dcbe9382112bfb.1554195798.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1554195798.git.christophe.leroy@c-s.fr>
References: <cover.1554195798.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 5/9] powerpc: convert to generic builtin command line
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, danielwa@cisco.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arch@vger.kernel.org
Date:   Tue,  2 Apr 2019 09:08:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This updates the powerpc code to use the new cmdline building function.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/prom_init.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index d4889ba04ddd..08f3db25b2f1 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -30,6 +30,7 @@
 #include <linux/delay.h>
 #include <linux/initrd.h>
 #include <linux/bitops.h>
+#include <linux/cmdline.h>
 #include <asm/prom.h>
 #include <asm/rtas.h>
 #include <asm/page.h>
@@ -155,7 +156,7 @@ static struct prom_t __prombss prom;
 static unsigned long __prombss prom_entry;
 
 static char __prombss of_stdout_device[256];
-static char __prombss prom_scratch[256];
+static char __prombss prom_scratch[COMMAND_LINE_SIZE];
 
 static unsigned long __prombss dt_header_start;
 static unsigned long __prombss dt_struct_start, dt_struct_end;
@@ -627,18 +628,14 @@ static unsigned long prom_memparse(const char *ptr, const char **retptr)
 static void __init early_cmdline_parse(void)
 {
 	const char *opt;
+	int l = 0;
 
-	char *p;
-	int l __maybe_unused = 0;
-
-	prom_cmd_line[0] = 0;
-	p = prom_cmd_line;
 	if ((long)prom.chosen > 0)
-		l = prom_getprop(prom.chosen, "bootargs", p, COMMAND_LINE_SIZE-1);
-#ifdef CONFIG_CMDLINE
-	if (l <= 0 || p[0] == '\0' || IS_ENABLED(CONFIG_CMDLINE_EXTEND)) /* dbl check */
-		strlcat(prom_cmd_line, CONFIG_CMDLINE, sizeof(prom_cmd_line));
-#endif /* CONFIG_CMDLINE */
+		l = prom_getprop(prom.chosen, "bootargs", prom_scratch,
+				 COMMAND_LINE_SIZE - 1);
+
+	cmdline_build(prom_cmd_line, l > 0 ? prom_scratch : NULL, sizeof(prom_scratch));
+
 	prom_printf("command line: %s\n", prom_cmd_line);
 
 #ifdef CONFIG_PPC64
-- 
2.13.3

