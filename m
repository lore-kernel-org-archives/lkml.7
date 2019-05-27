Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1520C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 06:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B035321721
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 06:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfE0G6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 02:58:33 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:36797 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726150AbfE0G6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 02:58:30 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07472639|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.482592-0.0157801-0.501628;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03275;MF=han_mao@c-sky.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.Edg0gGb_1558940307;
Received: from localhost(mailfrom:han_mao@c-sky.com fp:SMTPD_---.Edg0gGb_1558940307)
          by smtp.aliyun-inc.com(10.147.40.233);
          Mon, 27 May 2019 14:58:27 +0800
From:   Mao Han <han_mao@c-sky.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mao Han <han_mao@c-sky.com>, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org
Subject: [PATCH V2 2/5] csky: Add reg-io-width property for csky pmu
Date:   Mon, 27 May 2019 14:57:18 +0800
Message-Id: <f7bfa540fb7492883c54b4e4a8c226fec69bc7fa.1558939831.git.han_mao@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1558939831.git.han_mao@c-sky.com>
References: <cover.1558939831.git.han_mao@c-sky.com>
In-Reply-To: <cover.1558939831.git.han_mao@c-sky.com>
References: <cover.1558939831.git.han_mao@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

csky pmu counter may have different io width. When the counter is smaller
then 64 bits and counter value is smaller than the old value, it will
result to a extremely large delta value. So the sampled value should be
extend to 64 bits to avoid this, the extension bits base on the
reg-io-width property from dts.

Signed-off-by: Mao Han <han_mao@c-sky.com>
CC: Guo Ren <guoren@kernel.org>
CC: linux-csky@vger.kernel.org
---
 arch/csky/kernel/perf_event.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/csky/kernel/perf_event.c b/arch/csky/kernel/perf_event.c
index c022acc..f1b3cdf 100644
--- a/arch/csky/kernel/perf_event.c
+++ b/arch/csky/kernel/perf_event.c
@@ -18,6 +18,7 @@ static void (*hw_raw_write_mapping[CSKY_PMU_MAX_EVENTS])(uint64_t val);
 
 struct csky_pmu_t {
 	struct pmu	pmu;
+	uint32_t	sign_extend;
 	uint32_t	hpcr;
 } csky_pmu;
 
@@ -806,7 +807,13 @@ static void csky_perf_event_update(struct perf_event *event,
 				   struct hw_perf_event *hwc)
 {
 	uint64_t prev_raw_count = local64_read(&hwc->prev_count);
-	uint64_t new_raw_count = hw_raw_read_mapping[hwc->idx]();
+	/*
+	 * Extend count value to 64bit, otherwise delta calculation would
+	 * be incorrect when overflow occurs.
+	 */
+	uint64_t new_raw_count = ((int64_t)hw_raw_read_mapping[hwc->idx]()
+				   << csky_pmu.sign_extend)
+				   >> csky_pmu.sign_extend;
 	int64_t delta = new_raw_count - prev_raw_count;
 
 	/*
@@ -1037,6 +1044,7 @@ int csky_pmu_device_probe(struct platform_device *pdev,
 	const struct of_device_id *of_id;
 	csky_pmu_init init_fn;
 	struct device_node *node = pdev->dev.of_node;
+	int cnt_width;
 	int ret = -ENODEV;
 
 	of_id = of_match_node(of_table, pdev->dev.of_node);
@@ -1045,6 +1053,12 @@ int csky_pmu_device_probe(struct platform_device *pdev,
 		ret = init_fn(&csky_pmu);
 	}
 
+	if (!of_property_read_u32(node, "reg-io-width", &cnt_width)) {
+		csky_pmu.sign_extend = 64 - cnt_width;
+	} else {
+		csky_pmu.sign_extend = 16;
+	}
+
 	if (ret) {
 		pr_notice("[perf] failed to probe PMU!\n");
 		return ret;
-- 
2.7.4

