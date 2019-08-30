Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F4AC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25AA023427
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567177770;
	bh=Ei+UUuI2bjs9MCSyFZ3sjrySi931/9VchlR6vlNSp5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MtIwKEv72FV/ZkChB6c4+xTZBq3rSXWH0b1tTcLXSaQQQDK6p2SqeoUw5fxjg7mpR
	 0Z+psOX5KyVUhEu4zSPGqTOE5mlTAKAAqNN7Ie3+MsmKsk4DJdtwcTIiV/SmPthCzc
	 YHoVI/RD2xNtZ+AzERcQfgTKx0OQtGG1VcWiOYoU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbfH3PJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 11:09:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:42532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728195AbfH3PJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 11:09:27 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 765FC2342A;
        Fri, 30 Aug 2019 15:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567177766;
        bh=Ei+UUuI2bjs9MCSyFZ3sjrySi931/9VchlR6vlNSp5E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B1CKzGdB4sF99gq98msmqUSBmQuG0RmHrf8M4uvLeAH6qzKDqLaMZSsAOCvzd4Pv2
         N6OW+6++0D8JjgLbfu7nEpuIAFmD4kZsj4OxTl30XBLg+gayj4S6CxuFhk4M6vqHFl
         VvTKMNM07iYuoZ9MtxB00lpeENkYDzR4EHl2A4EU=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 07/12] clk: fixed-rate: Add clk flags for parent accuracy
Date:   Fri, 30 Aug 2019 08:09:18 -0700
Message-Id: <20190830150923.259497-8-sboyd@kernel.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190830150923.259497-1-sboyd@kernel.org>
References: <20190830150923.259497-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some clk providers want to use the accuracy of the parent clk and use
the fixed rate basic type clk to do that. This requires getting the
parent clk and extracting the accuracy before registering the fixed rate
clk. Let's add a flag for this and update the clk_ops to support this.

Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk-fixed-rate.c | 7 ++++++-
 include/linux/clk-provider.h | 6 ++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-fixed-rate.c b/drivers/clk/clk-fixed-rate.c
index 6ee25e2dae76..f6d9eb982c20 100644
--- a/drivers/clk/clk-fixed-rate.c
+++ b/drivers/clk/clk-fixed-rate.c
@@ -35,7 +35,12 @@ static unsigned long clk_fixed_rate_recalc_rate(struct clk_hw *hw,
 static unsigned long clk_fixed_rate_recalc_accuracy(struct clk_hw *hw,
 		unsigned long parent_accuracy)
 {
-	return to_clk_fixed_rate(hw)->fixed_accuracy;
+	struct clk_fixed_rate *fixed = to_clk_fixed_rate(hw);
+
+	if (fixed->flags & CLK_FIXED_RATE_PARENT_ACCURACY)
+		return parent_accuracy;
+
+	return fixed->fixed_accuracy;
 }
 
 const struct clk_ops clk_fixed_rate_ops = {
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 9acafd9de216..b1ed4b840476 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -322,6 +322,10 @@ struct clk_hw {
  * @fixed_rate:	constant frequency of clock
  * @fixed_accuracy: constant accuracy of clock in ppb (parts per billion)
  * @flags:	hardware specific flags
+ *
+ * Flags:
+ * CLK_FIXED_RATE_PARENT_ACCURACY - Use the accuracy of the parent clk
+ * 	instead of what's set in @fixed_accuracy.
  */
 struct clk_fixed_rate {
 	struct		clk_hw hw;
@@ -330,6 +334,8 @@ struct clk_fixed_rate {
 	unsigned long	flags;
 };
 
+#define CLK_FIXED_RATE_PARENT_ACCURACY		BIT(0)
+
 extern const struct clk_ops clk_fixed_rate_ops;
 struct clk_hw *__clk_hw_register_fixed_rate(struct device *dev,
 		struct device_node *np, const char *name,
-- 
Sent by a computer through tubes

