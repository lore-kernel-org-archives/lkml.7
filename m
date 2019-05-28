Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5395EC04AB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 02:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 310DE208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 02:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbfE1CSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 22:18:40 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:17585 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727763AbfE1CSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 22:18:39 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9AEC4840B8F2F504D4EB;
        Tue, 28 May 2019 10:18:37 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Tue, 28 May 2019 10:18:30 +0800
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Zhenfa Qiu <qiuzhenfa@hisilicon.com>
Subject: [PATCH v4 2/2] arm64: cacheinfo: Update cache_line_size detected from DT or PPTT
Date:   Tue, 28 May 2019 10:16:54 +0800
Message-ID: <1559009814-17004-2-git-send-email-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559009814-17004-1-git-send-email-zhangshaokun@hisilicon.com>
References: <1559009814-17004-1-git-send-email-zhangshaokun@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cache_line_size is derived from CTR_EL0.CWG field and is called mostly
for I/O device drivers. For HiSilicon certain plantform, like the
Kunpeng920 server SoC, cache line sizes are different between L1/2
cache and L3 cache while L1 cache line size is 64-byte and L3 is 128-byte,
but CTR_EL0.CWG is misreporting using L1 cache line size.

We shall correct the right value which is important for I/O performance.
Let's update the cache line size if it is detected from DT or PPTT
information.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Jeremy Linton <jeremy.linton@arm.com>
Cc: Zhenfa Qiu <qiuzhenfa@hisilicon.com>
Reported-by: Zhenfa Qiu <qiuzhenfa@hisilicon.com>
Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 arch/arm64/include/asm/cache.h |  6 +-----
 arch/arm64/kernel/cacheinfo.c  | 11 +++++++++++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
index 926434f413fa..758af6340314 100644
--- a/arch/arm64/include/asm/cache.h
+++ b/arch/arm64/include/asm/cache.h
@@ -91,11 +91,7 @@ static inline u32 cache_type_cwg(void)
 
 #define __read_mostly __attribute__((__section__(".data..read_mostly")))
 
-static inline int cache_line_size(void)
-{
-	u32 cwg = cache_type_cwg();
-	return cwg ? 4 << cwg : ARCH_DMA_MINALIGN;
-}
+int cache_line_size(void);
 
 /*
  * Read the effective value of CTR_EL0.
diff --git a/arch/arm64/kernel/cacheinfo.c b/arch/arm64/kernel/cacheinfo.c
index 0bf0a835122f..0c0cd4d26b87 100644
--- a/arch/arm64/kernel/cacheinfo.c
+++ b/arch/arm64/kernel/cacheinfo.c
@@ -28,6 +28,17 @@
 #define CLIDR_CTYPE(clidr, level)	\
 	(((clidr) & CLIDR_CTYPE_MASK(level)) >> CLIDR_CTYPE_SHIFT(level))
 
+int cache_line_size(void)
+{
+	u32 cwg = cache_type_cwg();
+
+	if (coherency_max_size != 0)
+		return coherency_max_size;
+
+	return cwg ? 4 << cwg : ARCH_DMA_MINALIGN;
+}
+EXPORT_SYMBOL_GPL(cache_line_size);
+
 static inline enum cache_type get_cache_type(int level)
 {
 	u64 clidr;
-- 
2.7.4

