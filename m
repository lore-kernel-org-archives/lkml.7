Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9EEC2D0DB
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 18:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50DD0207E0
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 18:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577642964;
	bh=NNF78YitIhww+624FtHYFBETyGKdGJ4DoOC56pLn3/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sHWLWwf4haSPgS4HXN8SzfjpgXzWcEI/89Z8YzDtTw0EU+FWPAaUS18h9P9C+X6NY
	 VDtTnGDwVDp09fZDVzeslfzHuPHhRDjVuVZr4BL5/G12jg2Rwwk9abRbegwNhkVIs+
	 +UVS0jGLWkiKZjZen3wrUjKNaAU5FnriA7q3hUs0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730977AbfL2Rpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:45:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:55120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730680AbfL2Rps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:45:48 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C1F52465A;
        Sun, 29 Dec 2019 17:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577641547;
        bh=NNF78YitIhww+624FtHYFBETyGKdGJ4DoOC56pLn3/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ti8bMO/20pIh8m4cIcln+MwRSXem8QLZ3T8me4V1nmcO1duqE57c74acFHepRI5dP
         IQ3B06vrPvre1bSpjYCh2tdQOgd33LM4/GPvaX2dIESzgfXfcybQoz9CLWR17mcKen
         A2gsSaFuOcpYL7x4oB6A3n4HS3CmcDRPoCZHXR9U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
        linux-mips@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 112/434] MIPS: syscall: Emit Loongson3 sync workarounds within asm
Date:   Sun, 29 Dec 2019 18:22:45 +0100
Message-Id: <20191229172709.098659255@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Burton <paul.burton@mips.com>

[ Upstream commit e84957e6ae043bb83ad6ae7e949a1ce97b6bbfef ]

Generate the sync instructions required to workaround Loongson3 LL/SC
errata within inline asm blocks, which feels a little safer than doing
it from C where strictly speaking the compiler would be well within its
rights to insert a memory access between the separate asm statements we
previously had, containing sync & ll instructions respectively.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: linux-mips@vger.kernel.org
Cc: Huacai Chen <chenhc@lemote.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/kernel/syscall.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/syscall.c b/arch/mips/kernel/syscall.c
index 3f16f3823031..c333e5788664 100644
--- a/arch/mips/kernel/syscall.c
+++ b/arch/mips/kernel/syscall.c
@@ -37,6 +37,7 @@
 #include <asm/signal.h>
 #include <asm/sim.h>
 #include <asm/shmparam.h>
+#include <asm/sync.h>
 #include <asm/sysmips.h>
 #include <asm/switch_to.h>
 
@@ -133,12 +134,12 @@ static inline int mips_atomic_set(unsigned long addr, unsigned long new)
 		  [efault] "i" (-EFAULT)
 		: "memory");
 	} else if (cpu_has_llsc) {
-		loongson_llsc_mb();
 		__asm__ __volatile__ (
 		"	.set	push					\n"
 		"	.set	"MIPS_ISA_ARCH_LEVEL"			\n"
 		"	li	%[err], 0				\n"
 		"1:							\n"
+		"	" __SYNC(full, loongson3_war) "			\n"
 		user_ll("%[old]", "(%[addr])")
 		"	move	%[tmp], %[new]				\n"
 		"2:							\n"
-- 
2.20.1



