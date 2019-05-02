Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 368FFC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 16:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 058CD20449
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 16:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="fVxTzPSI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfEBQ1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 12:27:36 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:59473 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726321AbfEBQ1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 12:27:33 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44w0zP4mPdz9tycm;
        Thu,  2 May 2019 18:27:29 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=fVxTzPSI; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 8Emtp1vUq3LX; Thu,  2 May 2019 18:27:29 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44w0zP3fdjz9tyck;
        Thu,  2 May 2019 18:27:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1556814449; bh=2XvB/geiUYMUvPBRKdnnwkEaTU6dGWad8XFW+OQ9YYU=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=fVxTzPSIsBnP4pyL5v4uakzhbwcldG54jQM+YnQwY3IgDneyzvk+zSpkHJ90ThtIx
         G9w+seliyQJgBaxL8vLY6MNcHTCoQhIz6F6azrhUH6M0ybbuRrwTw0Jd1klvjmjq30
         Yd6pgL9hTD6J5lVWeavhhN0bjesIuTuXv+liOOwo=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2EEB28B8FE;
        Thu,  2 May 2019 18:27:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id kOM5NWQInaLu; Thu,  2 May 2019 18:27:31 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0838E8B899;
        Thu,  2 May 2019 18:27:31 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id D0904672AF; Thu,  2 May 2019 16:27:30 +0000 (UTC)
Message-Id: <b4c832e13b2e14c8f140644b9d0eadac1928675f.1556814003.git.christophe.leroy@c-s.fr>
In-Reply-To: <298f344bdb21ab566271f5d18c6782ed20f072b7.1556814003.git.christophe.leroy@c-s.fr>
References: <298f344bdb21ab566271f5d18c6782ed20f072b7.1556814003.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 2/3] powerpc/module32: Use symbolic instructions names.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu,  2 May 2019 16:27:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To increase readability/maintainability, replace hard coded
instructions values by symbolic names.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
v2: Remove the ENTRY_JMP0 and ENTRY_JMP1 macros ; left real instructions as a comment.

 arch/powerpc/kernel/module_32.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/module_32.c b/arch/powerpc/kernel/module_32.c
index 88d83771f462..9cf201111d6c 100644
--- a/arch/powerpc/kernel/module_32.c
+++ b/arch/powerpc/kernel/module_32.c
@@ -172,10 +172,12 @@ int module_frob_arch_sections(Elf32_Ehdr *hdr,
 
 static inline int entry_matches(struct ppc_plt_entry *entry, Elf32_Addr val)
 {
-	if (entry->jump[0] == 0x3d800000 + ((val + 0x8000) >> 16)
-	    && entry->jump[1] == 0x398c0000 + (val & 0xffff))
-		return 1;
-	return 0;
+	if (entry->jump[0] != (PPC_INST_ADDIS | __PPC_RT(R12) | PPC_HA(val)))
+		return 0;
+	if (entry->jump[1] != (PPC_INST_ADDI | __PPC_RT(R12) | __PPC_RA(R12) |
+			       PPC_LO(val)))
+		return 0;
+	return 1;
 }
 
 /* Set up a trampoline in the PLT to bounce us to the distant function */
@@ -200,10 +202,16 @@ static uint32_t do_plt_call(void *location,
 		entry++;
 	}
 
-	entry->jump[0] = 0x3d800000+((val+0x8000)>>16); /* lis r12,sym@ha */
-	entry->jump[1] = 0x398c0000 + (val&0xffff);     /* addi r12,r12,sym@l*/
-	entry->jump[2] = 0x7d8903a6;                    /* mtctr r12 */
-	entry->jump[3] = 0x4e800420;			/* bctr */
+	/*
+	 * lis r12, sym@ha
+	 * addi r12, r12, sym@l
+	 * mtctr r12
+	 * bctr
+	 */
+	entry->jump[0] = PPC_INST_ADDIS | __PPC_RT(R12) | PPC_HA(val);
+	entry->jump[1] = PPC_INST_ADDI | __PPC_RT(R12) | __PPC_RA(R12) | PPC_LO(val);
+	entry->jump[2] = PPC_INST_MTCTR | __PPC_RS(R12);
+	entry->jump[3] = PPC_INST_BCTR;
 
 	pr_debug("Initialized plt for 0x%x at %p\n", val, entry);
 	return (uint32_t)entry;
-- 
2.13.3

