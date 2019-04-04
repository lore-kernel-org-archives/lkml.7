Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECABCC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6D6E20652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369116;
	bh=8lO5gEy46eNd8G05r3dccYthC+fYHJPP3jfMgxv/3WE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SzqTXEfjdwUxBWgRmrIC8Kg1UBjhgmpVrpaEXoAo1mS7noSCdBhsf2Aj9QrK2BEjz
	 eeJHSG5es139vTcrohi1HcX9AbMp/R/vE1od2YyJSd7CRMMz53xrRc4OOETeIy3vO4
	 R4LZtR/l/R7RA6bMXukA2O3Cq0g8Sf2ALQ3ystL4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733237AbfDDJLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:11:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:51798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733221AbfDDJLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:11:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F41FF2075E;
        Thu,  4 Apr 2019 09:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369111;
        bh=8lO5gEy46eNd8G05r3dccYthC+fYHJPP3jfMgxv/3WE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J+2/glC12DLVlUMn/vz/IdOSzC2CLAfM66weFxP3g7Dh/FfziXj5heacI4rcv0IAQ
         BistmHuu8S0bIglc+FNYJB+iMjfMevJ/u8Ec4QXAEvjgXZRZ26VyDyI65eL7N4qzo/
         MpVpuRqX3MekucOr9j50DCqaVDCMJ9rfh7vltriI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Huazhong Tan <tanhuazhong@huawei.com>,
        Xiaofei Tan <tanxiaofei@huawei.com>,
        Shiju Jose <shiju.jose@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 088/246] net: hns3: fix setting of the hns reset_type for rdma hw errors
Date:   Thu,  4 Apr 2019 10:46:28 +0200
Message-Id: <20190404084622.223619925@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

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



