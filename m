Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19412C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 10:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3B4C20644
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 10:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="kdCXnxKA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732254AbfFYK6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 06:58:15 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:63100 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732210AbfFYK6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 06:58:11 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45Y36S1hYCz9v17j;
        Tue, 25 Jun 2019 12:58:08 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=kdCXnxKA; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id GNAp56f9BcNv; Tue, 25 Jun 2019 12:58:08 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45Y36S0G90z9v17d;
        Tue, 25 Jun 2019 12:58:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1561460288; bh=550P1CoXgG6ywMpcxaUOSrNayar1hHXACatHa7PwUDQ=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=kdCXnxKATeLqn+p0n6suz3hNb7xtTSKSYf+FTiyg8WNLF5AOwtbG0iCtAHstQdj2u
         hEtQnz2jH54Cp01VuF/641PBrrZ3aUwNT3zD6szYuWqoq9DZM/wjRVAOOXfcFZDYpr
         pI7IH1eCt9I188EdI74ATwueSqBBTzjXIzLfMFCI=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 40B738B879;
        Tue, 25 Jun 2019 12:58:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id CdDTF4WuAbyJ; Tue, 25 Jun 2019 12:58:09 +0200 (CEST)
Received: from pc17473vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0FFEC8B874;
        Tue, 25 Jun 2019 12:58:09 +0200 (CEST)
Received: by pc17473vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id E011F68E1B; Tue, 25 Jun 2019 10:58:08 +0000 (UTC)
Message-Id: <4bcbcdd159d0b2c0326d03f2d6f8fd7f514e0be3.1561459984.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1561459983.git.christophe.leroy@c-s.fr>
References: <cover.1561459983.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v1 03/13] powerpc/ptrace: drop PARAMETER_SAVE_AREA_OFFSET
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, mikey@neuling.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 25 Jun 2019 10:58:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PARAMETER_SAVE_AREA_OFFSET is not used, drop it.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/ptrace/ptrace.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace/ptrace.c b/arch/powerpc/kernel/ptrace/ptrace.c
index 0afb223c4d57..cc8efcb404d6 100644
--- a/arch/powerpc/kernel/ptrace/ptrace.c
+++ b/arch/powerpc/kernel/ptrace/ptrace.c
@@ -48,16 +48,6 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/syscalls.h>
 
-/*
- * The parameter save area on the stack is used to store arguments being passed
- * to callee function and is located at fixed offset from stack pointer.
- */
-#ifdef CONFIG_PPC32
-#define PARAMETER_SAVE_AREA_OFFSET	24  /* bytes */
-#else /* CONFIG_PPC32 */
-#define PARAMETER_SAVE_AREA_OFFSET	48  /* bytes */
-#endif
-
 struct pt_regs_offset {
 	const char *name;
 	int offset;
-- 
2.13.3

