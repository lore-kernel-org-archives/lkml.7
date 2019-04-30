Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2FEC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 12:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFEED2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 12:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="a94U8JQh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbfD3Mi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 08:38:59 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:53029 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727599AbfD3Mi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 08:38:56 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44th0Y37T2z9vD37;
        Tue, 30 Apr 2019 14:38:53 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=a94U8JQh; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Zldjo-wUhghH; Tue, 30 Apr 2019 14:38:53 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44th0Y25glz9vD30;
        Tue, 30 Apr 2019 14:38:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1556627933; bh=fJwNdDqiAlgoT/1EYCI/ynpZSPt+QfYdJMVJTkDRues=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=a94U8JQhsfGHOwgZCFEyFb095ZF0o+BAYoYYbOQ51rNstYTIYRpGelTbZOqAuX3HT
         p6MNrhx3THhNUjOdVo1iqHDeEO/WZqk9O2xIzXcF8mZ7TAYYmL6+v7aLLwnZ9J69p8
         teBVMz3Kpcfm11cswGg4iqim66795081WBq4OpH8=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A852C8B8DF;
        Tue, 30 Apr 2019 14:38:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id sSmxUIjT8ufW; Tue, 30 Apr 2019 14:38:54 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7BA988B8C2;
        Tue, 30 Apr 2019 14:38:54 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 49E78666F8; Tue, 30 Apr 2019 12:38:54 +0000 (UTC)
Message-Id: <1a636829bc94403fbf939ad80f5b302f5e08f7e7.1556627571.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1556627571.git.christophe.leroy@c-s.fr>
References: <cover.1556627571.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 05/16] powerpc/40x: add exception frame marker
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 30 Apr 2019 12:38:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds STACK_FRAME_REGS_MARKER in the stack at exception entry
in order to see interrupts in call traces as below:

[    0.013964] Call Trace:
[    0.014014] [c0745db0] [c007a9d4] tick_periodic.constprop.5+0xd8/0x104 (unreliable)
[    0.014086] [c0745dc0] [c007aa20] tick_handle_periodic+0x20/0x9c
[    0.014181] [c0745de0] [c0009cd0] timer_interrupt+0xa0/0x264
[    0.014258] [c0745e10] [c000e484] ret_from_except+0x0/0x14
[    0.014390] --- interrupt: 901 at console_unlock.part.7+0x3f4/0x528
[    0.014390]     LR = console_unlock.part.7+0x3f0/0x528
[    0.014455] [c0745ee0] [c0050334] console_unlock.part.7+0x114/0x528 (unreliable)
[    0.014542] [c0745f30] [c00524e0] register_console+0x3d8/0x44c
[    0.014625] [c0745f60] [c0675aac] cpm_uart_console_init+0x18/0x2c
[    0.014709] [c0745f70] [c06614f4] console_init+0x114/0x1cc
[    0.014795] [c0745fb0] [c0658b68] start_kernel+0x300/0x3d8
[    0.014864] [c0745ff0] [c00022cc] start_here+0x44/0x98

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_40x.S | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
index f49b0278e995..cb95a5c17cea 100644
--- a/arch/powerpc/kernel/head_40x.S
+++ b/arch/powerpc/kernel/head_40x.S
@@ -132,6 +132,9 @@ _ENTRY(saved_ksp_limit)
 	tovirt(r1,r11);			/* set new kernel sp */	\
 	rlwinm	r9,r9,0,14,12;		/* clear MSR_WE (necessary?)	   */\
 	stw	r0,GPR0(r11);						     \
+	lis	r10, STACK_FRAME_REGS_MARKER@ha; /* exception frame marker */\
+	addi	r10, r10, STACK_FRAME_REGS_MARKER@l;			     \
+	stw	r10, 8(r11);						     \
 	SAVE_4GPRS(3, r11);						     \
 	SAVE_2GPRS(7, r11)
 
@@ -174,6 +177,9 @@ _ENTRY(saved_ksp_limit)
 	tovirt(r1,r11);							     \
 	rlwinm	r9,r9,0,14,12;		/* clear MSR_WE (necessary?)	   */\
 	stw	r0,GPR0(r11);						     \
+	lis	r10, STACK_FRAME_REGS_MARKER@ha; /* exception frame marker */\
+	addi	r10, r10, STACK_FRAME_REGS_MARKER@l;			     \
+	stw	r10, 8(r11);						     \
 	SAVE_4GPRS(3, r11);						     \
 	SAVE_2GPRS(7, r11)
 
-- 
2.13.3

