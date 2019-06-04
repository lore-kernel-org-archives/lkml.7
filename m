Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FADC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 10:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B21F24A1D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 10:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfFDK4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 06:56:13 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:35773 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727509AbfFDK4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 06:56:11 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07611556|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.136347-0.00582676-0.857826;FP=11371346456618404203|2|2|3|0|-1|-1|-1;HT=e01a16368;MF=han_mao@c-sky.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.EhJMHgY_1559645768;
Received: from localhost(mailfrom:han_mao@c-sky.com fp:SMTPD_---.EhJMHgY_1559645768)
          by smtp.aliyun-inc.com(10.147.42.197);
          Tue, 04 Jun 2019 18:56:08 +0800
From:   Mao Han <han_mao@c-sky.com>
To:     linux-kernel@vger.kernel.org
Cc:     Guo Ren <ren_guo@c-sky.com>, linux-csky@vger.kernel.org,
        Mao Han <han_mao@c-sky.com>, Guo Ren <guoren@kernel.org>
Subject: [PATCH V5 5/6] csky: Fixup some error count in 810 & 860.
Date:   Tue,  4 Jun 2019 18:54:48 +0800
Message-Id: <e8c6c15b69147780880f0e8345d3aebce3d952ea.1559644961.git.han_mao@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1559644961.git.han_mao@c-sky.com>
References: <cover.1559644961.git.han_mao@c-sky.com>
In-Reply-To: <cover.1559644961.git.han_mao@c-sky.com>
References: <cover.1559644961.git.han_mao@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

CK810 pmu only support event with index 0-8 and 0xd; CK860 only
support event 1~4, 0xa~0x1b. So do not register unsupport event
to hardware cache event, which may leader to unknown behavior.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Signed-off-by: Mao Han <han_mao@c-sky.com>
Cc: Guo Ren <guoren@kernel.org>
Cc: linux-csky@vger.kernel.org
---
 arch/csky/kernel/perf_event.c | 60 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 54 insertions(+), 6 deletions(-)

diff --git a/arch/csky/kernel/perf_event.c b/arch/csky/kernel/perf_event.c
index 8d4547e..499427e 100644
--- a/arch/csky/kernel/perf_event.c
+++ b/arch/csky/kernel/perf_event.c
@@ -734,6 +734,20 @@ static const int csky_pmu_hw_map[PERF_COUNT_HW_MAX] = {
 #define CACHE_OP_UNSUPPORTED	0xffff
 static const int csky_pmu_cache_map[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
 	[C(L1D)] = {
+#ifdef CONFIG_CPU_CK810
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)]	= 0x5,
+			[C(RESULT_MISS)]	= 0x6,
+		},
+#else
 		[C(OP_READ)] = {
 			[C(RESULT_ACCESS)]	= 0x14,
 			[C(RESULT_MISS)]	= 0x15,
@@ -743,9 +757,10 @@ static const int csky_pmu_cache_map[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
 			[C(RESULT_MISS)]	= 0x17,
 		},
 		[C(OP_PREFETCH)] = {
-			[C(RESULT_ACCESS)]	= 0x5,
-			[C(RESULT_MISS)]	= 0x6,
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
 		},
+#endif
 	},
 	[C(L1I)] = {
 		[C(OP_READ)] = {
@@ -762,6 +777,20 @@ static const int csky_pmu_cache_map[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
 		},
 	},
 	[C(LL)] = {
+#ifdef CONFIG_CPU_CK810
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)]	= 0x7,
+			[C(RESULT_MISS)]	= 0x8,
+		},
+#else
 		[C(OP_READ)] = {
 			[C(RESULT_ACCESS)]	= 0x18,
 			[C(RESULT_MISS)]	= 0x19,
@@ -771,29 +800,48 @@ static const int csky_pmu_cache_map[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
 			[C(RESULT_MISS)]	= 0x1b,
 		},
 		[C(OP_PREFETCH)] = {
-			[C(RESULT_ACCESS)]	= 0x7,
-			[C(RESULT_MISS)]	= 0x8,
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
 		},
+#endif
 	},
 	[C(DTLB)] = {
+#ifdef CONFIG_CPU_CK810
 		[C(OP_READ)] = {
-			[C(RESULT_ACCESS)]	= 0x5,
-			[C(RESULT_MISS)]	= 0xb,
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
 		},
 		[C(OP_WRITE)] = {
 			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
 			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
 		},
+#else
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]	= 0x14,
+			[C(RESULT_MISS)]	= 0xb,
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]	= 0x16,
+			[C(RESULT_MISS)]	= 0xb,
+		},
+#endif
 		[C(OP_PREFETCH)] = {
 			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
 			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
 		},
 	},
 	[C(ITLB)] = {
+#ifdef CONFIG_CPU_CK810
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+#else
 		[C(OP_READ)] = {
 			[C(RESULT_ACCESS)]	= 0x3,
 			[C(RESULT_MISS)]	= 0xa,
 		},
+#endif
 		[C(OP_WRITE)] = {
 			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
 			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
-- 
2.7.4

