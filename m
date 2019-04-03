Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7703C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 747A821734
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="SD1lRnGg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbfDCUHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 16:07:20 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:8856 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726775AbfDCUGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 16:06:19 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44ZHCG5gyjz9v3pr;
        Wed,  3 Apr 2019 22:06:18 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=SD1lRnGg; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id iHb_j0jQSX14; Wed,  3 Apr 2019 22:06:18 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44ZHCG3xLkz9v3pp;
        Wed,  3 Apr 2019 22:06:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1554321978; bh=5yd1NAIr8P/S/pElfFeAqs29R+LkuX1lKFh0+n0sXbw=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=SD1lRnGgmSRo8zB79u3lH+VASY58E01ml01ozLHJj6tZe79U+juyL5xbZxqL7LsYf
         iB0eV+xhbbkv2a3JKBQO6Mx22w+Az++UHCTHeQr53HfekBYhh42Eikl1aCgC1QoOTc
         y2fGx7tkC7sNcNeyUIkugMMuut8pLSczx4Ra/nRg=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A7BB78B905;
        Wed,  3 Apr 2019 22:06:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id uvCkvxyeJRCo; Wed,  3 Apr 2019 22:06:18 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7DB928B902;
        Wed,  3 Apr 2019 22:06:18 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 600E3655EC; Wed,  3 Apr 2019 20:06:18 +0000 (UTC)
Message-Id: <2cd783f6975b126f024ee0965047342b6c36bded.1554321743.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1554321743.git.christophe.leroy@c-s.fr>
References: <cover.1554321743.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 06/15] powerpc/Kconfig: select PPC_MM_SLICES from subarch
 type
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed,  3 Apr 2019 20:06:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lets select PPC_MM_SLICES from the subarch config item instead of
doing it via defaults declaration in the PPC_MM_SLICES item itself.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/platforms/Kconfig.cputype | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 842b2c7e156a..a46a0adb634d 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -34,6 +34,7 @@ config PPC_8xx
 	bool "Freescale 8xx"
 	select FSL_SOC
 	select SYS_SUPPORTS_HUGETLBFS
+	select PPC_MM_SLICES if HUGETLB_PAGE
 
 config 40x
 	bool "AMCC 40x"
@@ -75,6 +76,7 @@ config PPC_BOOK3S_64
 	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
 	select ARCH_SUPPORTS_NUMA_BALANCING
 	select IRQ_WORK
+	select PPC_MM_SLICES
 
 config PPC_BOOK3E_64
 	bool "Embedded processors"
@@ -360,8 +362,6 @@ config PPC_BOOK3E_MMU
 
 config PPC_MM_SLICES
 	bool
-	default y if PPC_BOOK3S_64
-	default y if PPC_8xx && HUGETLB_PAGE
 
 config PPC_HAVE_PMU_SUPPORT
        bool
-- 
2.13.3

