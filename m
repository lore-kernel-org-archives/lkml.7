Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51815C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 10:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26E2B24A1D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 10:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbfFDK4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 06:56:12 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:58686 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727486AbfFDK4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 06:56:09 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07517718|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.6789-0.00815059-0.31295;FP=0|0|0|0|0|-1|-1|-1;HT=e01l07447;MF=han_mao@c-sky.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.EhJOZAc_1559645766;
Received: from localhost(mailfrom:han_mao@c-sky.com fp:SMTPD_---.EhJOZAc_1559645766)
          by smtp.aliyun-inc.com(10.147.42.135);
          Tue, 04 Jun 2019 18:56:06 +0800
From:   Mao Han <han_mao@c-sky.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mao Han <han_mao@c-sky.com>, linux-csky@vger.kernel.org,
        Guo Ren <guoren@kernel.org>
Subject: [PATCH V5 2/6] csky: Add count-width property for csky pmu
Date:   Tue,  4 Jun 2019 18:54:45 +0800
Message-Id: <93df91a6bdd2fe46dcf71fdd996fa1e164a8adf4.1559644961.git.han_mao@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1559644961.git.han_mao@c-sky.com>
References: <cover.1559644961.git.han_mao@c-sky.com>
In-Reply-To: <cover.1559644961.git.han_mao@c-sky.com>
References: <cover.1559644961.git.han_mao@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The csky pmu counter may have different io width. When the counter is
smaller then 64 bits and counter value is smaller than the old value, it
will result to a extremely large delta value. So the sampled value should
be extend to 64 bits to avoid this, the extension bits base on the
count-width property from dts.

Signed-off-by: Mao Han <han_mao@c-sky.com>
Cc: Guo Ren <guoren@kernel.org>
---
 arch/csky/kernel/perf_event.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/csky/kernel/perf_event.c b/arch/csky/kernel/perf_event.c
index 2282554..a15b397 100644
--- a/arch/csky/kernel/perf_event.c
+++ b/arch/csky/kernel/perf_event.c
@@ -9,6 +9,7 @@
 #include <linux/platform_device.h>
 
 #define CSKY_PMU_MAX_EVENTS 32
+#define DEFAULT_COUNT_WIDTH 48
 
 #define HPCR		"<0, 0x0>"	/* PMU Control reg */
 #define HPCNTENR	"<0, 0x4>"	/* Count Enable reg */
@@ -18,6 +19,7 @@ static void (*hw_raw_write_mapping[CSKY_PMU_MAX_EVENTS])(uint64_t val);
 
 struct csky_pmu_t {
 	struct pmu	pmu;
+	uint32_t	count_width;
 	uint32_t	hpcr;
 } csky_pmu;
 
@@ -804,7 +806,12 @@ static void csky_perf_event_update(struct perf_event *event,
 				   struct hw_perf_event *hwc)
 {
 	uint64_t prev_raw_count = local64_read(&hwc->prev_count);
-	uint64_t new_raw_count = hw_raw_read_mapping[hwc->idx]();
+	/*
+	 * Sign extend count value to 64bit, otherwise delta calculation
+	 * would be incorrect when overflow occurs.
+	 */
+	uint64_t new_raw_count = sign_extend64(
+		hw_raw_read_mapping[hwc->idx](), csky_pmu.count_width - 1);
 	int64_t delta = new_raw_count - prev_raw_count;
 
 	/*
@@ -1032,6 +1039,7 @@ int init_hw_perf_events(void)
 int csky_pmu_device_probe(struct platform_device *pdev,
 			  const struct of_device_id *of_table)
 {
+	struct device_node *node = pdev->dev.of_node;
 	int ret;
 
 	ret = init_hw_perf_events();
@@ -1040,6 +1048,11 @@ int csky_pmu_device_probe(struct platform_device *pdev,
 		return ret;
 	}
 
+	if (of_property_read_u32(node, "count-width",
+				 &csky_pmu.count_width)) {
+		csky_pmu.count_width = DEFAULT_COUNT_WIDTH;
+	}
+
 	return ret;
 }
 
-- 
2.7.4

