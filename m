Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1365DC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 10:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D57AA20675
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 10:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="jIEsWsNr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbfD2Kn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 06:43:28 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:61147 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727621AbfD2Kn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 06:43:28 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44t1Tj49xNz9v0KF;
        Mon, 29 Apr 2019 12:43:21 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=jIEsWsNr; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id h6P2FVo-9-Er; Mon, 29 Apr 2019 12:43:21 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44t1Tj31N8z9v0KD;
        Mon, 29 Apr 2019 12:43:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1556534601; bh=LdoI2qT2aaRj/eKoZVF9HzfAiu1O/6qZbR/YCdBfHpw=;
        h=From:Subject:To:Cc:Date:From;
        b=jIEsWsNrnFHt8xpb23J3uqys7xSTOshMZ5puFweZYkxfqU03ZR3cMcXicleTjn07s
         jRYeKbA0uCKYoSkgxQqyX678USkfDryn6T/JxhkGMj8oioaaAkc4F8BgvLCwqhx3fT
         YByhpH00SdJHOf9wEnjWMlr1KxNd9JbZin2yTbiA=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 37DBF8B8AE;
        Mon, 29 Apr 2019 12:43:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id mGYo9Qa2Q9VL; Mon, 29 Apr 2019 12:43:26 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.6])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1424C8B7FB;
        Mon, 29 Apr 2019 12:43:26 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 0767466702; Mon, 29 Apr 2019 10:43:26 +0000 (UTC)
Message-Id: <23167861f6095456b4ba3b52c55a514201ca738f.1556534520.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 1/3] powerpc: Move PPC_HA() PPC_HI() and PPC_LO() to
 ppc-opcode.h
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 29 Apr 2019 10:43:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PPC_HA() PPC_HI() and PPC_LO() macros are nice macros. Move them
from module64.c to ppc-opcode.h in order to use them in other places.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/ppc-opcode.h | 7 +++++++
 arch/powerpc/kernel/module_64.c       | 7 -------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index 23f7ed796f38..c5ff44400d4d 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -412,6 +412,13 @@
 #define __PPC_SPR(r)	((((r) & 0x1f) << 16) | ((((r) >> 5) & 0x1f) << 11))
 #define __PPC_RC21	(0x1 << 10)
 
+/* Both low and high 16 bits are added as SIGNED additions, so if low
+   16 bits has high bit set, high 16 bits must be adjusted.  These
+   macros do that (stolen from binutils). */
+#define PPC_LO(v) ((v) & 0xffff)
+#define PPC_HI(v) (((v) >> 16) & 0xffff)
+#define PPC_HA(v) PPC_HI ((v) + 0x8000)
+
 /*
  * Only use the larx hint bit on 64bit CPUs. e500v1/v2 based CPUs will treat a
  * larx with EH set as an illegal instruction.
diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index 8661eea78503..c2e1b06253b8 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -400,13 +400,6 @@ static inline unsigned long my_r2(const Elf64_Shdr *sechdrs, struct module *me)
 	return (sechdrs[me->arch.toc_section].sh_addr & ~0xfful) + 0x8000;
 }
 
-/* Both low and high 16 bits are added as SIGNED additions, so if low
-   16 bits has high bit set, high 16 bits must be adjusted.  These
-   macros do that (stolen from binutils). */
-#define PPC_LO(v) ((v) & 0xffff)
-#define PPC_HI(v) (((v) >> 16) & 0xffff)
-#define PPC_HA(v) PPC_HI ((v) + 0x8000)
-
 /* Patch stub to reference function and correct r2 value. */
 static inline int create_stub(const Elf64_Shdr *sechdrs,
 			      struct ppc64_stub_entry *entry,
-- 
2.13.3

