Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC60C04AAE
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 06:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B566D2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 06:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfEFGzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 02:55:36 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:58252 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725710AbfEFGzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 02:55:36 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6C6F98BBE9FC15A36768;
        Mon,  6 May 2019 14:55:33 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Mon, 6 May 2019 14:55:27 +0800
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <qiuzhenfa@hisilicon.com>, <john.garry@huawei.com>,
        <guohanjun@huawei.com>, Shaokun Zhang <zhangshaokun@hisilicon.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "Sudeep Holla" <sudeep.holla@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v2 2/2] arm64: cacheinfo: Update cache_line_size detected from DT or PPTT
Date:   Mon, 6 May 2019 14:53:57 +0800
Message-ID: <1557125637-9558-2-git-send-email-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557125637-9558-1-git-send-email-zhangshaokun@hisilicon.com>
References: <1557125637-9558-1-git-send-email-zhangshaokun@hisilicon.com>
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
Reported-by: Zhenfa Qiu <qiuzhenfa@hisilicon.com>
Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 arch/arm64/include/asm/cache.h |  6 +-----
 arch/arm64/kernel/cacheinfo.c  | 10 ++++++++++
 2 files changed, 11 insertions(+), 5 deletions(-)

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
index 0bf0a835122f..6ffe908d476c 100644
--- a/arch/arm64/kernel/cacheinfo.c
+++ b/arch/arm64/kernel/cacheinfo.c
@@ -28,6 +28,16 @@
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
+
 static inline enum cache_type get_cache_type(int level)
 {
 	u64 clidr;
-- 
2.7.4

