Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFD8C18E7D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 09:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C0E02075B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 09:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbfEVJ0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 05:26:54 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:58228 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728584AbfEVJ0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 05:26:53 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07611752|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.136347-0.00582676-0.857826;FP=0|0|0|0|0|-1|-1|-1;HT=e01l07447;MF=han_mao@c-sky.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.EbUK8s2_1558517210;
Received: from localhost(mailfrom:han_mao@c-sky.com fp:SMTPD_---.EbUK8s2_1558517210)
          by smtp.aliyun-inc.com(10.147.42.135);
          Wed, 22 May 2019 17:26:50 +0800
From:   Mao Han <han_mao@c-sky.com>
To:     linux-kernel@vger.kernel.org
Cc:     Guo Ren <ren_guo@c-sky.com>, Mao Han <han_mao@c-sky.com>,
        Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org
Subject: [PATCH 5/5] csky: Fixup some error count in 810 & 860.
Date:   Wed, 22 May 2019 17:25:32 +0800
Message-Id: <b6bcb805f569441a04776e24f20d5121ad762d91.1558516765.git.han_mao@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1558516765.git.han_mao@c-sky.com>
References: <cover.1558516765.git.han_mao@c-sky.com>
In-Reply-To: <cover.1558516765.git.han_mao@c-sky.com>
References: <cover.1558516765.git.han_mao@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

ck810 pmu only support event with index 0-8 and 0xd; ck860 only
support event 1~4, 0xa~0x1b. So do not register unsupport event
to hardware cache event, which may leader to unknown behavior.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Signed-off-by: Mao Han <han_mao@c-sky.com>
CC: Guo Ren <guoren@kernel.org>
CC: linux-csky@vger.kernel.org
---
 arch/csky/kernel/perf_event.c | 60 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 54 insertions(+), 6 deletions(-)

diff --git a/arch/csky/kernel/perf_event.c b/arch/csky/kernel/perf_event.c
index 2ea9083..b105d55 100644
--- a/arch/csky/kernel/perf_event.c
+++ b/arch/csky/kernel/perf_event.c
@@ -735,6 +735,20 @@ static const int csky_pmu_hw_map[PERF_COUNT_HW_MAX] = {
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
@@ -744,9 +758,10 @@ static const int csky_pmu_cache_map[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
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
@@ -763,6 +778,20 @@ static const int csky_pmu_cache_map[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
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
@@ -772,29 +801,48 @@ static const int csky_pmu_cache_map[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
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

