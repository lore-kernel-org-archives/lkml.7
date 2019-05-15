Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCD3C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E5C420881
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Ca4D5IFN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfEOMe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 08:34:59 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:49167 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfEOMe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 08:34:58 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190515123456euoutp013c6a3845879dd66b2c0ea73f8b0ab283~e21kJPPpK2210422104euoutp01P;
        Wed, 15 May 2019 12:34:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190515123456euoutp013c6a3845879dd66b2c0ea73f8b0ab283~e21kJPPpK2210422104euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1557923696;
        bh=Qnc23u7sMOYVD9w4XZQHqBtnLf6RMaImcgtoqnr+UJE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Ca4D5IFNANt47KOQ7kKOlfWK5NeYRBNYSN+sh99L7hyBHgJfcQvGfzLNM30mIWdYA
         gPyHS9cGAv58iPYrFqjBxqkwy+4Gd3SUYd1fOkfVinaPulRWZ8FrNy4MeO3TWpZbXh
         lDN4/b0WhJleknnL6QqqP6zm8yoXwY9uMc4C4tN4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190515123455eucas1p1bd676b6aaf2b86d4acf79b15e442086e~e21jfJXjr1125211252eucas1p1c;
        Wed, 15 May 2019 12:34:55 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 61.9D.04377.F670CDC5; Wed, 15
        May 2019 13:34:55 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190515123455eucas1p2901074694b5835e16ca0b2916d2e4139~e21i44Gdb3078930789eucas1p2F;
        Wed, 15 May 2019 12:34:55 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-09-5cdc076f558b
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E6.09.04140.E670CDC5; Wed, 15
        May 2019 13:34:54 +0100 (BST)
Received: from AMDC2765.DIGITAL.local ([106.120.51.73]) by
        eusync4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PRJ00AQZPLAG360@eusync4.samsung.com>;
        Wed, 15 May 2019 13:34:54 +0100 (BST)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>
Subject: [PATCH/RFC] ARM: Add workaround for I-Cache line size mismatch
 between CPU cores
Date:   Wed, 15 May 2019 14:33:56 +0200
Message-id: <20190515123356.31924-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsWy7djPc7r57HdiDL6sV7VYMe8no8XfScfY
        LTbOWM9q8X5ZD6PF+fMb2C02Pb7GanF51xw2ixnn9zFZrD1yl91i6fWLTBaX+icyWcyY/JLN
        4uXHEywOvB5r5q1h9Lh87SKzx+9fkxg9Nq3qZPPYvKTeo2/LKkaPz5vkAtijuGxSUnMyy1KL
        9O0SuDIm7zjEUrBfveJF027WBsa1Cl2MnBwSAiYSW1YvYO9i5OIQEljBKHF381w2COczo8TU
        uRdYYKrm/P3NDJFYxijx+uAtqJb/jBIrL2xkAqliEzCU6HrbxQZiiwi4SfxbdwhsFLPASWaJ
        NzuawEYJC0RLTPw9nxnEZhFQlXjx4ShYM6+ArcSbn8/ZIdbJS6zecABsnYTACjaJL01roe5w
        kTh37TczhC0jcXlyNwtEUTOjxMNza9khnB5GictNMxghqqwlDh+/yApiMwvwSUzaNh2omwMo
        zivR0SYEUeIhMe/1fUaQsJBArMTUG/kTGMUXMDKsYhRPLS3OTU8tNspLLdcrTswtLs1L10vO
        z93ECIzQ0/+Of9nBuOtP0iFGAQ5GJR5eix+3Y4RYE8uKK3MPMUpwMCuJ8G54DxTiTUmsrEot
        yo8vKs1JLT7EKM3BoiTOW83wIFpIID2xJDU7NbUgtQgmy8TBKdXAaLO/QLXu8K8T/hkTHp1c
        bhAQ0sjmynRrSdOMuU91ujIVzzmenj5HQWj13l75Ekmth+crms+UmbvEc/m8sLnyZRrrJIGZ
        gZmfs/+vzFZccHPfjU0/1NZvYc67ciL2WeicR4JVG1b/Tvfel5LqUJAt+fmRxDXVKe9MurfH
        dvywjt0hvcrTYsJTFSWW4oxEQy3mouJEAJMccMjMAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOLMWRmVeSWpSXmKPExsVy+t/xa7p57HdiDCbctrJYMe8no8XfScfY
        LTbOWM9q8X5ZD6PF+fMb2C02Pb7GanF51xw2ixnn9zFZrD1yl91i6fWLTBaX+icyWcyY/JLN
        4uXHEywOvB5r5q1h9Lh87SKzx+9fkxg9Nq3qZPPYvKTeo2/LKkaPz5vkAtijuGxSUnMyy1KL
        9O0SuDIm7zjEUrBfveJF027WBsa1Cl2MnBwSAiYSc/7+Zu5i5OIQEljCKPFo7SwWCKeRSeLC
        g2nMIFVsAoYSXW+72EBsEQE3iX/rDrGBFDELnGSW+NDTywiSEBaIlnjX+oYdxGYRUJV48eEo
        E4jNK2Ar8ebnc3aIdfISqzccYJ7AyLWAkWEVo0hqaXFuem6xkV5xYm5xaV66XnJ+7iZGYHBt
        O/Zzyw7GrnfBhxgFOBiVeHgn/LodI8SaWFZcmXuIUYKDWUmEd8N7oBBvSmJlVWpRfnxRaU5q
        8SFGaQ4WJXHeDoGDMUIC6YklqdmpqQWpRTBZJg5OqQbGaZlXNgoHbjBQfMcjfPGThQDTG2EG
        kefB0ge2dz6K1s36IWo7dVXJF77OZMY3oZ+XLdRIklVfqndQ+n2pi+VpwZkSa2LeL4g7UGG0
        7+7ZS9Lzd9dcZLa/phleP7/O9W5m/DkhKed9l+wvLbuxjcd81u+t/wuVo3uZ722KyRN1tvn0
        O+nsPt8mJZbijERDLeai4kQAVxS/yCoCAAA=
X-CMS-MailID: 20190515123455eucas1p2901074694b5835e16ca0b2916d2e4139
CMS-TYPE: 201P
X-CMS-RootMailID: 20190515123455eucas1p2901074694b5835e16ca0b2916d2e4139
References: <CGME20190515123455eucas1p2901074694b5835e16ca0b2916d2e4139@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some big.LITTLE systems have mismatch of I-Cache line size between
LITTLE and big cores. This patch adds workaround for proper I-Cache
support on such systems. Without it, some kind of userspace code
(typically self-modifying) might suffer from random SIGILL failures.

Similar workaround exists for ARM64 architecture, added by commit
116c81f427ff ("arm64: Work around systems with mismatched cache line
sizes").

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
This workaround is needed on all supported Exynos big.LITTLE SoCs: 5420,
5422 and 5800.
---
 arch/arm/configs/exynos_defconfig |  1 +
 arch/arm/include/asm/cacheflush.h |  7 +++++++
 arch/arm/kernel/smp.c             |  1 +
 arch/arm/mm/Kconfig               |  8 ++++++++
 arch/arm/mm/cache-v7.S            | 13 +++++++++++++
 arch/arm/mm/init.c                | 16 ++++++++++++++++
 arch/arm/mm/mm.h                  |  2 ++
 7 files changed, 48 insertions(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index c95c54284da2..9b959afaaa12 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -9,6 +9,7 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_ARCH_EXYNOS=y
 CONFIG_ARCH_EXYNOS3=y
+CONFIG_CPU_ICACHE_MISMATCH_WORKAROUND=y
 CONFIG_SMP=y
 CONFIG_BIG_LITTLE=y
 CONFIG_NR_CPUS=8
diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index ec1a5fd0d294..ec4fd2e2dd60 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -479,4 +479,11 @@ static inline void __sync_cache_range_r(volatile void *p, size_t size)
 void flush_uprobe_xol_access(struct page *page, unsigned long uaddr,
 			     void *kaddr, unsigned long len);
 
+
+#ifdef CONFIG_CPU_ICACHE_MISMATCH_WORKAROUND
+void check_cpu_icache_size(int cpuid);
+#else
+static inline void check_cpu_icache_size(int cpuid) { }
+#endif
+
 #endif
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 8687d619260f..261be0e5bc03 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -373,6 +373,7 @@ static void smp_store_cpu_info(unsigned int cpuid)
 	cpu_info->cpuid = read_cpuid_id();
 
 	store_cpu_topology(cpuid);
+	check_cpu_icache_size(cpuid);
 }
 
 /*
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index b169e580bf82..d4733e086f2b 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -780,6 +780,14 @@ config CPU_ICACHE_DISABLE
 	  Say Y here to disable the processor instruction cache. Unless
 	  you have a reason not to or are unsure, say N.
 
+config CPU_ICACHE_MISMATCH_WORKAROUND
+	bool "Workaround for I-Cache line size mismatch between CPU cores"
+	depends on SMP && CPU_V7
+	help
+	  Some big.LITTLE systems have mismatch of I-Cache line size between
+	  LITTLE and big cores.  Say Y here to enable workaround for proper
+	  I-Cache support on such systems.  If unsure, say N.
+
 config CPU_DCACHE_DISABLE
 	bool "Disable D-Cache (C-bit)"
 	depends on (CPU_CP15 && !SMP) || CPU_V7M
diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
index 2149b47a0c5a..db3986708c8a 100644
--- a/arch/arm/mm/cache-v7.S
+++ b/arch/arm/mm/cache-v7.S
@@ -19,6 +19,14 @@
 
 #include "proc-macros.S"
 
+#ifdef CONFIG_CPU_ICACHE_MISMATCH_WORKAROUND
+.globl icache_size
+	.data
+	.align	2
+icache_size:
+	.long	64
+	.text
+#endif
 /*
  * The secondary kernel init calls v7_flush_dcache_all before it enables
  * the L1; however, the L1 comes out of reset in an undefined state, so
@@ -284,7 +292,12 @@ ENTRY(v7_coherent_user_range)
 	cmp	r12, r1
 	blo	1b
 	dsb	ishst
+#ifdef CONFIG_CPU_ICACHE_MISMATCH_WORKAROUND
+	ldr	r3, =icache_size
+	ldr	r2, [r3, #0]
+#else
 	icache_line_size r2, r3
+#endif
 	sub	r3, r2, #1
 	bic	r12, r0, r3
 2:
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index be0b42937888..1a66af5bd259 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -242,6 +242,22 @@ static void __init arm_initrd_init(void)
 #endif
 }
 
+#ifdef CONFIG_CPU_ICACHE_MISMATCH_WORKAROUND
+void check_cpu_icache_size(int cpuid)
+{
+	u32 size, ctr;
+
+	asm("mrc p15, 0, %0, c0, c0, 1" : "=r" (ctr));
+
+	size = 1 << ((ctr & 0xf) + 2);
+	if (cpuid != 0 && icache_size != size)
+		pr_info("CPU%u: detected I-Cache line size mismatch, workaround enabled\n",
+			cpuid);
+	if (icache_size > size)
+		icache_size = size;
+}
+#endif
+
 void __init arm_memblock_init(const struct machine_desc *mdesc)
 {
 	/* Register the kernel text, kernel data and initrd with memblock. */
diff --git a/arch/arm/mm/mm.h b/arch/arm/mm/mm.h
index 6b045c6653ea..941356d95a67 100644
--- a/arch/arm/mm/mm.h
+++ b/arch/arm/mm/mm.h
@@ -8,6 +8,8 @@
 /* the upper-most page table pointer */
 extern pmd_t *top_pmd;
 
+extern int icache_size;
+
 /*
  * 0xffff8000 to 0xffffffff is reserved for any ARM architecture
  * specific hacks for copying pages efficiently, while 0xffff4000
-- 
2.17.1

