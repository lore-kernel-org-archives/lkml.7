Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF51C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 03:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E76320B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 03:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="xm48M3KR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731572AbfDWDXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 23:23:33 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:57801 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731351AbfDWDWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 23:22:48 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x3N3L8LJ031384;
        Tue, 23 Apr 2019 12:21:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x3N3L8LJ031384
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1555989678;
        bh=dlukBYO6sgrMJOkaTgBisXwB5sU3qv4thlZ8O2ehfGY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xm48M3KRfOyJ5kQVTw4Ovn149SHzUzjXnB91gR/MwjfLF0ptp5BEUN0KLVknYLbrp
         2X/icDCYfRB9UYEbC3NAUGKwCdyo8dDDhGSx5tTGtY5HP4wqmdSP34dZKju4n+Gge+
         49so/3DvgiDJ/GVfMURchnCnlw9DNnZeiui7LkTskHswqEbB0x2gtSC2rxId3AjZBR
         GGo7gUXhxNWh5yHM3nD+kCXE9yK+n2f0qxD3hgG6HSsvsfV/vYDp6FrtitJ2VYs22S
         56kVXNRMf3PkQZYnDbPEP33MV+F6/q6okJweuR2UIDtfb+ST3kPAUvQaC9zZcF4djh
         8B1WciaXUL4Dw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>
Cc:     linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Mathieu Malaterre <malat@debian.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v3 08/10] powerpc/mm/radix: mark __radix__flush_tlb_range_psize() as __always_inline
Date:   Tue, 23 Apr 2019 12:21:04 +0900
Message-Id: <20190423032106.11960-9-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190423032106.11960-1-yamada.masahiro@socionext.com>
References: <20190423032106.11960-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This prepares to move CONFIG_OPTIMIZE_INLINING from x86 to a common
place. We need to eliminate potential issues beforehand.

If it is enabled for powerpc, the following error is reported:

arch/powerpc/mm/tlb-radix.c: In function '__radix__flush_tlb_range_psize':
arch/powerpc/mm/tlb-radix.c:104:2: error: asm operand 3 probably doesn't match constraints [-Werror]
  asm volatile(PPC_TLBIEL(%0, %4, %3, %2, %1)
  ^~~
arch/powerpc/mm/tlb-radix.c:104:2: error: impossible constraint in 'asm'

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3: None
Changes in v2:
  - split into a separate patch

 arch/powerpc/mm/tlb-radix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index 6a23b9ebd2a1..a2b2848f0ae3 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -928,7 +928,7 @@ void radix__tlb_flush(struct mmu_gather *tlb)
 	tlb->need_flush_all = 0;
 }
 
-static inline void __radix__flush_tlb_range_psize(struct mm_struct *mm,
+static __always_inline void __radix__flush_tlb_range_psize(struct mm_struct *mm,
 				unsigned long start, unsigned long end,
 				int psize, bool also_pwc)
 {
-- 
2.17.1

