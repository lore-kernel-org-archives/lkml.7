Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF02C49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 16:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFB962053B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 16:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404178AbfISQMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 12:12:22 -0400
Received: from foss.arm.com ([217.140.110.172]:33430 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404165AbfISQMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 12:12:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C7611570;
        Thu, 19 Sep 2019 09:12:21 -0700 (PDT)
Received: from localhost.localdomain (entos-thunderx2-02.shanghai.arm.com [10.169.40.54])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CCC063F575;
        Thu, 19 Sep 2019 09:12:16 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Suzuki Poulose <Suzuki.Poulose@arm.com>
Cc:     Punit Agrawal <punitagrawal@gmail.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Alex Van Brunt <avanbrunt@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>, hejianet@gmail.com,
        Kaly Xin <Kaly.Xin@arm.com>, Jia He <justin.he@arm.com>
Subject: [PATCH v5 1/3] arm64: cpufeature: introduce helper cpu_has_hw_af()
Date:   Fri, 20 Sep 2019 00:12:02 +0800
Message-Id: <20190919161204.142796-2-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190919161204.142796-1-justin.he@arm.com>
References: <20190919161204.142796-1-justin.he@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We unconditionally set the HW_AFDBM capability and only enable it on
CPUs which really have the feature. But sometimes we need to know
whether this cpu has the capability of HW AF. So decouple AF from
DBM by new helper cpu_has_hw_af().

Reported-by: kbuild test robot <lkp@intel.com>
Suggested-by: Suzuki Poulose <Suzuki.Poulose@arm.com>
Signed-off-by: Jia He <justin.he@arm.com>
---
 arch/arm64/include/asm/cpufeature.h |  1 +
 arch/arm64/kernel/cpufeature.c      | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index c96ffa4722d3..206b6e3954cf 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -390,6 +390,7 @@ extern DECLARE_BITMAP(boot_capabilities, ARM64_NPATCHABLE);
 	for_each_set_bit(cap, cpu_hwcaps, ARM64_NCAPS)
 
 bool this_cpu_has_cap(unsigned int cap);
+bool cpu_has_hw_af(void);
 void cpu_set_feature(unsigned int num);
 bool cpu_have_feature(unsigned int num);
 unsigned long cpu_get_elf_hwcap(void);
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index b1fdc486aed8..fb0e9425d286 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1141,6 +1141,16 @@ static bool has_hw_dbm(const struct arm64_cpu_capabilities *cap,
 	return true;
 }
 
+/* Decouple AF from AFDBM. */
+bool cpu_has_hw_af(void)
+{
+	return (read_cpuid(ID_AA64MMFR1_EL1) & 0xf);
+}
+#else /* CONFIG_ARM64_HW_AFDBM */
+bool cpu_has_hw_af(void)
+{
+	return false;
+}
 #endif
 
 #ifdef CONFIG_ARM64_VHE
-- 
2.17.1

