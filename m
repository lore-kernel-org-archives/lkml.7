Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71ED7C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 15:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 432DC214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 15:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="NzqGAvxs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfF1Psh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 11:48:37 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:44786 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbfF1Prz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 11:47:55 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45b1PN540LzB09ZS;
        Fri, 28 Jun 2019 17:47:52 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=NzqGAvxs; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id jIDfCeUKZQ4E; Fri, 28 Jun 2019 17:47:52 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45b1PN3sqGzB09ZN;
        Fri, 28 Jun 2019 17:47:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1561736872; bh=550P1CoXgG6ywMpcxaUOSrNayar1hHXACatHa7PwUDQ=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=NzqGAvxsE54Z2woHZ+SUPok9D8ZkgU3mB2YPF/pWL7DxaT/V4wNJWi+C5mzqqzxWF
         /27PL9BOX19m91/Y+ZOsVmv/XLC9eiWuAob+cknxLwfQ4/SXLFI71XF5OQ6aPw9OL6
         kPnqFRohz6kORRMR8PHba6KDs3Xd3BLw7Rjz4ywM=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DC0C48B955;
        Fri, 28 Jun 2019 17:47:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id jbLOjUbh2oYv; Fri, 28 Jun 2019 17:47:53 +0200 (CEST)
Received: from localhost.localdomain (po15451.idsi0.si.c-s.fr [172.25.230.101])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 00D5E8B978;
        Fri, 28 Jun 2019 17:47:52 +0200 (CEST)
Received: by localhost.localdomain (Postfix, from userid 0)
        id B01FD68DD7; Fri, 28 Jun 2019 15:47:52 +0000 (UTC)
Message-Id: <c308b286e4fac4bea6544079b450aef7d3510dc8.1561735587.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1561735587.git.christophe.leroy@c-s.fr>
References: <cover.1561735587.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v2 03/12] powerpc/ptrace: drop PARAMETER_SAVE_AREA_OFFSET
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, mikey@neuling.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 28 Jun 2019 15:47:52 +0000 (UTC)
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

