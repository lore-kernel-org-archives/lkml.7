Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B0CCC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 06:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E90822082F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 06:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="ehWHs0Fv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbfEFGr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 02:47:58 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:6640 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbfEFGr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 02:47:57 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44yCwl3zzfz9tyfk;
        Mon,  6 May 2019 08:47:51 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=ehWHs0Fv; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id L6RKIRyhBNiy; Mon,  6 May 2019 08:47:51 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44yCwl2w1gz9tyfj;
        Mon,  6 May 2019 08:47:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1557125271; bh=igwDhWLswk58Ekrh/smeT3jyFCd7faNWM1HhbOhpVEU=;
        h=From:Subject:To:Cc:Date:From;
        b=ehWHs0Fv4Nt5isF2Jzpfy9wn0WCyCmMMkP7UK4T+/hT1wRMz9s1jOD9OH+fFzN1GF
         ATdDRQmWTPGYLoBknw/ehsGHlhCm0ELguMd6WlRocytOZDslw9YXl3Sd560xhSTwHs
         bE3vUQLem7bS0y5PqopTtkoDbIGIFaNuZYrPTpMQ=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D50678B824;
        Mon,  6 May 2019 08:47:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Q5XfMSvK9bY9; Mon,  6 May 2019 08:47:55 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.6])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9E78E8B74F;
        Mon,  6 May 2019 08:47:55 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 9D7716728F; Mon,  6 May 2019 06:47:55 +0000 (UTC)
Message-Id: <c37bcf93f1e661ba2a5ee69d67786d9ae6520ccd.1557125247.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/mm: fix redundant inclusion of pgtable-frag.o in
 Makefile
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon,  6 May 2019 06:47:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch identified below added pgtable-frag.o to obj-y
but some merge witchery kept it also for obj-CONFIG_PPC_BOOK3S_64

This patch clears the duplication.

Fixes: 737b434d3d55 ("powerpc/mm: convert Book3E 64 to pte_fragment")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index 7a7527116c3a..0f499db315d6 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -12,7 +12,6 @@ obj-y				:= fault.o mem.o pgtable.o mmap.o \
 obj-$(CONFIG_PPC_MMU_NOHASH)	+= nohash/
 obj-$(CONFIG_PPC_BOOK3S_32)	+= book3s32/
 obj-$(CONFIG_PPC_BOOK3S_64)	+= book3s64/
-obj-$(CONFIG_PPC_BOOK3S_64)	+= pgtable-frag.o
 obj-$(CONFIG_NEED_MULTIPLE_NODES) += numa.o
 obj-$(CONFIG_PPC_MM_SLICES)	+= slice.o
 obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
-- 
2.13.3

