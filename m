Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC7EC2D0C0
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 08:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 607B221927
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 08:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="qTms3eIk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfLUIcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 03:32:51 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:19172 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726885AbfLUIck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 03:32:40 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47fzPx461nz9txh9;
        Sat, 21 Dec 2019 09:32:37 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=qTms3eIk; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id teNqOt-k_Vr5; Sat, 21 Dec 2019 09:32:37 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47fzPx33Gvz9txh8;
        Sat, 21 Dec 2019 09:32:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1576917157; bh=s9tlncPBPF5ltYj2UYw1kqY6LrypIxcWu7hdOtJZAuk=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=qTms3eIk2zKkMN/kwQc1BnM/S7KR4OnLEdLMCb4yf03SSme6S5LkKlrAUuX1wiDlK
         9Scyfud9umGbrASJBaEzLlXZTRfeEZg08j/qP5eZfwrr73IARVTNbhgG2mj1FF9g9/
         BzTRFv4lRtu2XEqwgwaybdGe1QWVB/jRiEIgudFY=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4E21B8B77C;
        Sat, 21 Dec 2019 09:32:38 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id kNRebGGzUM1g; Sat, 21 Dec 2019 09:32:38 +0100 (CET)
Received: from localhost.localdomain (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1762D8B752;
        Sat, 21 Dec 2019 09:32:38 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
        id D4AED637B6; Sat, 21 Dec 2019 08:32:37 +0000 (UTC)
Message-Id: <30d2cda111b7977227fff067fa7e358440e2b3a4.1576916812.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1576916812.git.christophe.leroy@c-s.fr>
References: <cover.1576916812.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v5 16/17] powerpc/32s: avoid crossing page boundary while
 changing SRR0/1.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, dja@axtens.net
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org
Date:   Sat, 21 Dec 2019 08:32:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trying VMAP_STACK with KVM, vmlinux was not starting.
This was due to SRR0 and SRR1 clobbered by an ISI due to
the rfi being in a different page than the mtsrr0/1:

c0003fe0 <mmu_off>:
c0003fe0:       38 83 00 54     addi    r4,r3,84
c0003fe4:       7c 60 00 a6     mfmsr   r3
c0003fe8:       70 60 00 30     andi.   r0,r3,48
c0003fec:       4d 82 00 20     beqlr
c0003ff0:       7c 63 00 78     andc    r3,r3,r0
c0003ff4:       7c 9a 03 a6     mtsrr0  r4
c0003ff8:       7c 7b 03 a6     mtsrr1  r3
c0003ffc:       7c 00 04 ac     hwsync
c0004000:       4c 00 00 64     rfi

Align the 4 instruction block used to deactivate MMU to order 4,
so that the block never crosses a page boundary.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_32.S | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 7ec780858299..90ef355e958b 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -917,6 +917,8 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_HPTE_TABLE)
 	ori	r4,r4,2f@l
 	tophys(r4,r4)
 	li	r3,MSR_KERNEL & ~(MSR_IR|MSR_DR)
+
+	.align	4
 	mtspr	SPRN_SRR0,r4
 	mtspr	SPRN_SRR1,r3
 	SYNC
@@ -1058,6 +1060,8 @@ _ENTRY(update_bats)
 	rlwinm	r0, r6, 0, ~MSR_RI
 	rlwinm	r0, r0, 0, ~MSR_EE
 	mtmsr	r0
+
+	.align	4
 	mtspr	SPRN_SRR0, r4
 	mtspr	SPRN_SRR1, r3
 	SYNC
@@ -1097,6 +1101,8 @@ mmu_off:
 	andi.	r0,r3,MSR_DR|MSR_IR		/* MMU enabled? */
 	beqlr
 	andc	r3,r3,r0
+
+	.align	4
 	mtspr	SPRN_SRR0,r4
 	mtspr	SPRN_SRR1,r3
 	sync
-- 
2.13.3

