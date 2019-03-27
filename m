Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C473AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 921FF2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553709899;
	bh=qLE6wMW9Dd6jz7vBfau9ZKcVJD4ZqBR3agDqBjjAWrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rwajrTyYlY2tsCdLCFteXcb3uRc/dGLfTREUTB8eWVzknu+hFLevuYVk2OL7z98MB
	 CU6zTDfhUQS5WG750URjuxaivfqrCrUN9Fr5u9mDNArOyCyx2OdM4uj7ef/M69Hb/k
	 ui/N8wadHWbSjza9mi4dDMNrlMBUDjxjq/3Rn1wY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732054AbfC0SE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:04:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:45808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731431AbfC0SEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:04:55 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 853522075C;
        Wed, 27 Mar 2019 18:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553709894;
        bh=qLE6wMW9Dd6jz7vBfau9ZKcVJD4ZqBR3agDqBjjAWrs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NOVmpA5Yv1nd2aWyuvYMFG18dEFiO2o3Q0ePfDvSbuCdad1/92kxEweKD1nHlE3Kz
         fO+WTUeH4U6DXGCAiOVFmjz2XOdSlznvqIeTkeydRwaytLhOq6K72wXCwZUypz/WK+
         MghLZL6SrBgSYwvsF5lQIlPP6Mv36jkfaNEE0W18=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shiju Jose <shiju.jose@huawei.com>, Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 094/262] net: hns3: fix setting of the hns reset_type for rdma hw errors
Date:   Wed, 27 Mar 2019 13:59:09 -0400
Message-Id: <20190327180158.10245-94-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shiju Jose <shiju.jose@huawei.com>

[ Upstream commit eb4c2ccbad6c688be791e0c08640a40124558c03 ]

Presently the hns reset_type for the roce errors is set
in the hclge_log_and_clear_rocee_ras_error function.
This function is also called to detect and clear roce errors
while enabling the rdma error interrupts. However there is no hns
reset requested for this case. This can cause issue of wrong
reset_type used with subsequent hns reset as the
reset_type set in the above case was not cleared.

This patch moves setting of hns reset_type for the roce errors from
hclge_log_and_clear_rocee_ras_error function
to hclge_handle_rocee_ras_error.

Fixes: 630ba007f475 ("net: hns3: add handling of RDMA RAS errors")
Reported-by: Huazhong Tan <tanhuazhong@huawei.com>
Reported-by: Xiaofei Tan <tanxiaofei@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../hisilicon/hns3/hns3pf/hclge_err.c         | 36 ++++++++++---------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
index efb6c1a25171..3ea72e4d9dc4 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
@@ -1094,10 +1094,10 @@ static int hclge_log_rocee_ovf_error(struct hclge_dev *hdev)
 	return 0;
 }
 
-static int hclge_log_and_clear_rocee_ras_error(struct hclge_dev *hdev)
+static enum hnae3_reset_type
+hclge_log_and_clear_rocee_ras_error(struct hclge_dev *hdev)
 {
-	enum hnae3_reset_type reset_type = HNAE3_FUNC_RESET;
-	struct hnae3_ae_dev *ae_dev = hdev->ae_dev;
+	enum hnae3_reset_type reset_type = HNAE3_NONE_RESET;
 	struct device *dev = &hdev->pdev->dev;
 	struct hclge_desc desc[2];
 	unsigned int status;
@@ -1110,17 +1110,20 @@ static int hclge_log_and_clear_rocee_ras_error(struct hclge_dev *hdev)
 	if (ret) {
 		dev_err(dev, "failed(%d) to query ROCEE RAS INT SRC\n", ret);
 		/* reset everything for now */
-		HCLGE_SET_DEFAULT_RESET_REQUEST(HNAE3_GLOBAL_RESET);
-		return ret;
+		return HNAE3_GLOBAL_RESET;
 	}
 
 	status = le32_to_cpu(desc[0].data[0]);
 
-	if (status & HCLGE_ROCEE_RERR_INT_MASK)
+	if (status & HCLGE_ROCEE_RERR_INT_MASK) {
 		dev_warn(dev, "ROCEE RAS AXI rresp error\n");
+		reset_type = HNAE3_FUNC_RESET;
+	}
 
-	if (status & HCLGE_ROCEE_BERR_INT_MASK)
+	if (status & HCLGE_ROCEE_BERR_INT_MASK) {
 		dev_warn(dev, "ROCEE RAS AXI bresp error\n");
+		reset_type = HNAE3_FUNC_RESET;
+	}
 
 	if (status & HCLGE_ROCEE_ECC_INT_MASK) {
 		dev_warn(dev, "ROCEE RAS 2bit ECC error\n");
@@ -1132,9 +1135,9 @@ static int hclge_log_and_clear_rocee_ras_error(struct hclge_dev *hdev)
 		if (ret) {
 			dev_err(dev, "failed(%d) to process ovf error\n", ret);
 			/* reset everything for now */
-			HCLGE_SET_DEFAULT_RESET_REQUEST(HNAE3_GLOBAL_RESET);
-			return ret;
+			return HNAE3_GLOBAL_RESET;
 		}
+		reset_type = HNAE3_FUNC_RESET;
 	}
 
 	/* clear error status */
@@ -1143,12 +1146,10 @@ static int hclge_log_and_clear_rocee_ras_error(struct hclge_dev *hdev)
 	if (ret) {
 		dev_err(dev, "failed(%d) to clear ROCEE RAS error\n", ret);
 		/* reset everything for now */
-		reset_type = HNAE3_GLOBAL_RESET;
+		return HNAE3_GLOBAL_RESET;
 	}
 
-	HCLGE_SET_DEFAULT_RESET_REQUEST(reset_type);
-
-	return ret;
+	return reset_type;
 }
 
 static int hclge_config_rocee_ras_interrupt(struct hclge_dev *hdev, bool en)
@@ -1178,15 +1179,18 @@ static int hclge_config_rocee_ras_interrupt(struct hclge_dev *hdev, bool en)
 	return ret;
 }
 
-static int hclge_handle_rocee_ras_error(struct hnae3_ae_dev *ae_dev)
+static void hclge_handle_rocee_ras_error(struct hnae3_ae_dev *ae_dev)
 {
+	enum hnae3_reset_type reset_type = HNAE3_NONE_RESET;
 	struct hclge_dev *hdev = ae_dev->priv;
 
 	if (test_bit(HCLGE_STATE_RST_HANDLING, &hdev->state) ||
 	    hdev->pdev->revision < 0x21)
-		return HNAE3_NONE_RESET;
+		return;
 
-	return hclge_log_and_clear_rocee_ras_error(hdev);
+	reset_type = hclge_log_and_clear_rocee_ras_error(hdev);
+	if (reset_type != HNAE3_NONE_RESET)
+		HCLGE_SET_DEFAULT_RESET_REQUEST(reset_type);
 }
 
 static const struct hclge_hw_blk hw_blk[] = {
-- 
2.19.1

