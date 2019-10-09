Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6208BC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 22:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39A8A206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 22:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="XvdFUi+Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732300AbfJIW1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 18:27:09 -0400
Received: from dc2-smtprelay2.synopsys.com ([198.182.61.142]:55084 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732216AbfJIW1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 18:27:08 -0400
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 259C4C03E9;
        Wed,  9 Oct 2019 22:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1570660027; bh=XxzbN0PHHliJ1GEgTBBhwhTwFL7gliZm+a80vwiducE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XvdFUi+ZLbje6h/k7NQ+34A51uDkE4f0v62XxLwgo5K4i6n/pQIc8QGF8929MXasd
         4dHo69SZnO+cf4qoy1n915cdiAwVb9PWQdgcqdkU1a7XPqLvspjhePiYVTWGIOKdpx
         10MtHWYcdFiGuS8ceKnSxwYF9ueaiHOmvC6eQ5fwPJzXEcpOD689UpJCANu55ZAGsv
         4Qwa2dTx5DSW/8pDRpIC8glXW///WreThFJZo2dwSGt6I+wtjggkOdrfE2wSpejs32
         pIA5UyCEwI5cDUS/1wxpFWQieMn/bz8qenl8YJsFQNwqs+Hk3Nvm2/ewIlZ4vV9qpx
         lxKnoQGk8Gcgw==
Received: from vineetg-Latitude-E7450.internal.synopsys.com (vineetg-latitude-e7450.internal.synopsys.com [10.10.161.61])
        by mailhost.synopsys.com (Postfix) with ESMTP id 9A5B7A0074;
        Wed,  9 Oct 2019 22:27:06 +0000 (UTC)
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     linux-mm@kvack.org
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 2/3] asm-generic/tlb: stub out p4d_free_tlb() if __PAGETABLE_P4D_FOLDED ...
Date:   Wed,  9 Oct 2019 15:26:57 -0700
Message-Id: <20191009222658.961-3-vgupta@synopsys.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191009222658.961-1-vgupta@synopsys.com>
References: <20191009222658.961-1-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

... independent of __ARCH_HAS_5LEVEL_HACK

This came up when removing __ARCH_HAS_5LEVEL_HACK for ARC as code bloat
from p4d_free_tlb() despite pud being folded (with 2 levels on ARC)

| bloat-o-meter2 vmlinux-C-elide-pud_free_tlb vmlinux-D-elide-p4d_free_tlb
| add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-104 (-104)
| function                                     old     new   delta
| free_pgd_range                               552     422    -130
| Total: Before=4137172, After=4137042, chg -1.000000%

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 include/asm-generic/5level-fixup.h | 2 --
 include/asm-generic/tlb.h          | 4 +++-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/5level-fixup.h b/include/asm-generic/5level-fixup.h
index f6947da70d71..c855b5cf4425 100644
--- a/include/asm-generic/5level-fixup.h
+++ b/include/asm-generic/5level-fixup.h
@@ -48,8 +48,6 @@ static inline int p4d_present(p4d_t p4d)
 #define __p4d(x)			__pgd(x)
 #define set_p4d(p4dp, p4d)		set_pgd(p4dp, p4d)
 
-#undef p4d_free_tlb
-#define p4d_free_tlb(tlb, x, addr)	do { } while (0)
 #define p4d_free(mm, x)			do { } while (0)
 #define __p4d_free_tlb(tlb, x, addr)	do { } while (0)
 
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 1f83188cb331..f3dad87f4ecc 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -598,7 +598,7 @@ static inline void tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vm
 #define pud_free_tlb(tlb, pudp, address)	do { } while (0)
 #endif
 
-#ifndef __ARCH_HAS_5LEVEL_HACK
+#ifndef __PAGETABLE_P4D_FOLDED
 #ifndef p4d_free_tlb
 #define p4d_free_tlb(tlb, pudp, address)			\
 	do {							\
@@ -607,6 +607,8 @@ static inline void tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vm
 		__p4d_free_tlb(tlb, pudp, address);		\
 	} while (0)
 #endif
+#else
+#define p4d_free_tlb(tlb, pudp, address)	do { } while (0)
 #endif
 
 #endif /* CONFIG_MMU */
-- 
2.20.1

