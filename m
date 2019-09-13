Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFA4C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 16:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1AA920693
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 16:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389568AbfIMQc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 12:32:58 -0400
Received: from foss.arm.com ([217.140.110.172]:46540 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387822AbfIMQc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 12:32:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD7C91570;
        Fri, 13 Sep 2019 09:32:56 -0700 (PDT)
Received: from localhost.localdomain (entos-thunderx2-02.shanghai.arm.com [10.169.40.54])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C82FE3F67D;
        Fri, 13 Sep 2019 09:32:52 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Punit Agrawal <punitagrawal@gmail.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Jun Yao <yaojun8558363@gmail.com>,
        Alex Van Brunt <avanbrunt@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>, hejianet@gmail.com,
        Jia He <justin.he@arm.com>
Subject: [PATCH v3 1/2] arm64: mm: implement arch_faults_on_old_pte() on arm64
Date:   Sat, 14 Sep 2019 00:32:38 +0800
Message-Id: <20190913163239.125108-2-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190913163239.125108-1-justin.he@arm.com>
References: <20190913163239.125108-1-justin.he@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On arm64 without hardware Access Flag, copying fromuser will fail because
the pte is old and cannot be marked young. So we always end up with zeroed
page after fork() + CoW for pfn mappings. we don't always have a
hardware-managed access flag on arm64.

Hence implement arch_faults_on_old_pte on arm64 to indicate that it might
cause page fault when accessing old pte.

Signed-off-by: Jia He <justin.he@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index e09760ece844..b41399d758df 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -868,6 +868,18 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
 #define phys_to_ttbr(addr)	(addr)
 #endif
 
+/*
+ * On arm64 without hardware Access Flag, copying fromuser will fail because
+ * the pte is old and cannot be marked young. So we always end up with zeroed
+ * page after fork() + CoW for pfn mappings. we don't always have a
+ * hardware-managed access flag on arm64.
+ */
+static inline bool arch_faults_on_old_pte(void)
+{
+	return true;
+}
+#define arch_faults_on_old_pte arch_faults_on_old_pte
+
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __ASM_PGTABLE_H */
-- 
2.17.1

