Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B85EECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C0B720679
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbfJKOJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 10:09:57 -0400
Received: from foss.arm.com ([217.140.110.172]:33446 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728033AbfJKOJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 10:09:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0538E1570;
        Fri, 11 Oct 2019 07:09:56 -0700 (PDT)
Received: from localhost.localdomain (entos-thunderx2-02.shanghai.arm.com [10.169.40.54])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 734B63F68E;
        Fri, 11 Oct 2019 07:09:51 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Suzuki Poulose <Suzuki.Poulose@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>, hejianet@gmail.com,
        Kaly Xin <Kaly.Xin@arm.com>, nd@arm.com,
        Jia He <justin.he@arm.com>
Subject: [PATCH v12 1/4] arm64: cpufeature: introduce helper cpu_has_hw_af()
Date:   Fri, 11 Oct 2019 22:09:36 +0800
Message-Id: <20191011140939.6115-2-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011140939.6115-1-justin.he@arm.com>
References: <20191011140939.6115-1-justin.he@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We unconditionally set the HW_AFDBM capability and only enable it on
CPUs which really have the feature. But sometimes we need to know
whether this cpu has the capability of HW AF. So decouple AF from
DBM by a new helper cpu_has_hw_af().

If later we noticed a potential performance issue on this path, we can
turn it into a static label as with other CPU features.

Signed-off-by: Jia He <justin.he@arm.com>
Suggested-by: Suzuki Poulose <Suzuki.Poulose@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/cpufeature.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 9cde5d2e768f..4261d55e8506 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -659,6 +659,20 @@ static inline u32 id_aa64mmfr0_parange_to_phys_shift(int parange)
 	default: return CONFIG_ARM64_PA_BITS;
 	}
 }
+
+/* Check whether hardware update of the Access flag is supported */
+static inline bool cpu_has_hw_af(void)
+{
+	u64 mmfr1;
+
+	if (!IS_ENABLED(CONFIG_ARM64_HW_AFDBM))
+		return false;
+
+	mmfr1 = read_cpuid(ID_AA64MMFR1_EL1);
+	return cpuid_feature_extract_unsigned_field(mmfr1,
+						ID_AA64MMFR1_HADBS_SHIFT);
+}
+
 #endif /* __ASSEMBLY__ */
 
 #endif
-- 
2.17.1

