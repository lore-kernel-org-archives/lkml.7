Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B616C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 03:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E422221736
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 03:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfDSDHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 23:07:07 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55082 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727205AbfDSDHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 23:07:06 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B023CDBB5F06B90EC48A;
        Fri, 19 Apr 2019 11:07:04 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Fri, 19 Apr 2019 11:06:57 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <nhorman@redhat.com>,
        Huazhong Tan <tanhuazhong@huawei.com>,
        Peng Li <lipeng321@huawei.com>
Subject: [PATCH net-next 02/12] net: hns3: add reset statistics for VF
Date:   Fri, 19 Apr 2019 11:05:37 +0800
Message-ID: <1555643147-52407-3-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555643147-52407-1-git-send-email-tanhuazhong@huawei.com>
References: <1555643147-52407-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds some statistics for VF reset.

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 10 ++++++++--
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h | 11 ++++++++++-
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 2e277c9..ff2cdf9 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -1415,9 +1415,11 @@ static int hclgevf_reset_prepare_wait(struct hclgevf_dev *hdev)
 	case HNAE3_VF_FUNC_RESET:
 		ret = hclgevf_send_mbx_msg(hdev, HCLGE_MBX_RESET, 0, NULL,
 					   0, true, NULL, sizeof(u8));
+		hdev->rst_stats.vf_func_rst_cnt++;
 		break;
 	case HNAE3_FLR_RESET:
 		set_bit(HNAE3_FLR_DOWN, &hdev->flr_state);
+		hdev->rst_stats.flr_rst_cnt++;
 		break;
 	default:
 		break;
@@ -1440,7 +1442,7 @@ static int hclgevf_reset(struct hclgevf_dev *hdev)
 	 * know if device is undergoing reset
 	 */
 	ae_dev->reset_type = hdev->reset_type;
-	hdev->reset_count++;
+	hdev->rst_stats.rst_cnt++;
 	rtnl_lock();
 
 	/* bring down the nic to stop any ongoing TX/RX */
@@ -1466,6 +1468,8 @@ static int hclgevf_reset(struct hclgevf_dev *hdev)
 		goto err_reset;
 	}
 
+	hdev->rst_stats.hw_rst_done_cnt++;
+
 	rtnl_lock();
 
 	/* now, re-initialize the nic client and ae device*/
@@ -1484,6 +1488,7 @@ static int hclgevf_reset(struct hclgevf_dev *hdev)
 
 	hdev->last_reset_time = jiffies;
 	ae_dev->reset_type = HNAE3_NONE_RESET;
+	hdev->rst_stats.rst_done_cnt++;
 
 	return ret;
 err_reset_lock:
@@ -1803,6 +1808,7 @@ static enum hclgevf_evt_cause hclgevf_check_evt_cause(struct hclgevf_dev *hdev,
 		set_bit(HCLGEVF_STATE_CMD_DISABLE, &hdev->state);
 		cmdq_src_reg &= ~BIT(HCLGEVF_VECTOR0_RST_INT_B);
 		*clearval = cmdq_src_reg;
+		hdev->rst_stats.vf_rst_cnt++;
 		return HCLGEVF_VECTOR0_EVENT_RST;
 	}
 
@@ -2737,7 +2743,7 @@ static unsigned long hclgevf_ae_dev_reset_cnt(struct hnae3_handle *handle)
 {
 	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
 
-	return hdev->reset_count;
+	return hdev->rst_stats.hw_rst_done_cnt;
 }
 
 static void hclgevf_get_link_mode(struct hnae3_handle *handle,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
index 49e5bec..d39c032 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
@@ -210,6 +210,15 @@ struct hclgevf_misc_vector {
 	int vector_irq;
 };
 
+struct hclgevf_rst_stats {
+	u32 rst_cnt;			/* the number of reset */
+	u32 vf_func_rst_cnt;		/* the number of VF function reset */
+	u32 flr_rst_cnt;		/* the number of FLR */
+	u32 vf_rst_cnt;			/* the number of VF reset */
+	u32 rst_done_cnt;		/* the number of reset completed */
+	u32 hw_rst_done_cnt;		/* the number of HW reset completed */
+};
+
 struct hclgevf_dev {
 	struct pci_dev *pdev;
 	struct hnae3_ae_dev *ae_dev;
@@ -227,7 +236,7 @@ struct hclgevf_dev {
 #define HCLGEVF_RESET_REQUESTED		0
 #define HCLGEVF_RESET_PENDING		1
 	unsigned long reset_state;	/* requested, pending */
-	unsigned long reset_count;	/* the number of reset has been done */
+	struct hclgevf_rst_stats rst_stats;
 	u32 reset_attempts;
 
 	u32 fw_version;
-- 
2.7.4

