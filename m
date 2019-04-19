Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B3EC10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 03:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC7A221736
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 03:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbfDSDHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 23:07:08 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55080 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727231AbfDSDHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 23:07:07 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id AA3FE171DB94BF18428C;
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
Subject: [PATCH net-next 01/12] net: hns3: add reset statistics info for PF
Date:   Fri, 19 Apr 2019 11:05:36 +0800
Message-ID: <1555643147-52407-2-git-send-email-tanhuazhong@huawei.com>
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

This patch adds statistics for PF's reset information,
also, provides a debugfs command to dump these statistics.

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c |  1 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c | 22 ++++++++++++++++++++++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 12 ++++++++++--
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    | 13 ++++++++++++-
 4 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index 0de543f..c46da81 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -247,6 +247,7 @@ static void hns3_dbg_help(struct hnae3_handle *h)
 	dev_info(&h->pdev->dev, "dump qos pri map\n");
 	dev_info(&h->pdev->dev, "dump qos buf cfg\n");
 	dev_info(&h->pdev->dev, "dump mng tbl\n");
+	dev_info(&h->pdev->dev, "dump reset info\n");
 
 	memset(printf_buf, 0, HNS3_DBG_BUF_LEN);
 	strncat(printf_buf, "dump reg [[bios common] [ssu <prt_id>]",
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
index 1192cf6..d9782c7 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
@@ -901,6 +901,26 @@ static void hclge_dbg_fd_tcam(struct hclge_dev *hdev)
 	}
 }
 
+static void hclge_dbg_dump_rst_info(struct hclge_dev *hdev)
+{
+	dev_info(&hdev->pdev->dev, "PF reset count: %d\n",
+		 hdev->rst_stats.pf_rst_cnt);
+	dev_info(&hdev->pdev->dev, "FLR reset count: %d\n",
+		 hdev->rst_stats.flr_rst_cnt);
+	dev_info(&hdev->pdev->dev, "CORE reset count: %d\n",
+		 hdev->rst_stats.core_rst_cnt);
+	dev_info(&hdev->pdev->dev, "GLOBAL reset count: %d\n",
+		 hdev->rst_stats.global_rst_cnt);
+	dev_info(&hdev->pdev->dev, "IMP reset count: %d\n",
+		 hdev->rst_stats.imp_rst_cnt);
+	dev_info(&hdev->pdev->dev, "reset done count: %d\n",
+		 hdev->rst_stats.reset_done_cnt);
+	dev_info(&hdev->pdev->dev, "HW reset done count: %d\n",
+		 hdev->rst_stats.hw_reset_done_cnt);
+	dev_info(&hdev->pdev->dev, "reset count: %d\n",
+		 hdev->rst_stats.reset_cnt);
+}
+
 int hclge_dbg_run_cmd(struct hnae3_handle *handle, char *cmd_buf)
 {
 	struct hclge_vport *vport = hclge_get_vport(handle);
@@ -924,6 +944,8 @@ int hclge_dbg_run_cmd(struct hnae3_handle *handle, char *cmd_buf)
 		hclge_dbg_dump_mng_table(hdev);
 	} else if (strncmp(cmd_buf, "dump reg", 8) == 0) {
 		hclge_dbg_dump_reg_cmd(hdev, cmd_buf);
+	} else if (strncmp(cmd_buf, "dump reset info", 15) == 0) {
+		hclge_dbg_dump_rst_info(hdev);
 	} else {
 		dev_info(&hdev->pdev->dev, "unknown command\n");
 		return -EINVAL;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 7dba3b4..2748c2f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -2360,6 +2360,7 @@ static u32 hclge_check_event_cause(struct hclge_dev *hdev, u32 *clearval)
 		set_bit(HNAE3_IMP_RESET, &hdev->reset_pending);
 		set_bit(HCLGE_STATE_CMD_DISABLE, &hdev->state);
 		*clearval = BIT(HCLGE_VECTOR0_IMPRESET_INT_B);
+		hdev->rst_stats.imp_rst_cnt++;
 		return HCLGE_VECTOR0_EVENT_RST;
 	}
 
@@ -2368,6 +2369,7 @@ static u32 hclge_check_event_cause(struct hclge_dev *hdev, u32 *clearval)
 		set_bit(HCLGE_STATE_CMD_DISABLE, &hdev->state);
 		set_bit(HNAE3_GLOBAL_RESET, &hdev->reset_pending);
 		*clearval = BIT(HCLGE_VECTOR0_GLOBALRESET_INT_B);
+		hdev->rst_stats.global_rst_cnt++;
 		return HCLGE_VECTOR0_EVENT_RST;
 	}
 
@@ -2376,6 +2378,7 @@ static u32 hclge_check_event_cause(struct hclge_dev *hdev, u32 *clearval)
 		set_bit(HCLGE_STATE_CMD_DISABLE, &hdev->state);
 		set_bit(HNAE3_CORE_RESET, &hdev->reset_pending);
 		*clearval = BIT(HCLGE_VECTOR0_CORERESET_INT_B);
+		hdev->rst_stats.core_rst_cnt++;
 		return HCLGE_VECTOR0_EVENT_RST;
 	}
 
@@ -2873,6 +2876,7 @@ static int hclge_reset_prepare_wait(struct hclge_dev *hdev)
 		 * after hclge_cmd_init is called.
 		 */
 		set_bit(HCLGE_STATE_CMD_DISABLE, &hdev->state);
+		hdev->rst_stats.pf_rst_cnt++;
 		break;
 	case HNAE3_FLR_RESET:
 		/* There is no mechanism for PF to know if VF has stopped IO
@@ -2881,6 +2885,7 @@ static int hclge_reset_prepare_wait(struct hclge_dev *hdev)
 		msleep(100);
 		set_bit(HCLGE_STATE_CMD_DISABLE, &hdev->state);
 		set_bit(HNAE3_FLR_DOWN, &hdev->flr_state);
+		hdev->rst_stats.flr_rst_cnt++;
 		break;
 	case HNAE3_IMP_RESET:
 		reg_val = hclge_read_dev(&hdev->hw, HCLGE_PF_OTHER_INT_REG);
@@ -2961,7 +2966,7 @@ static void hclge_reset(struct hclge_dev *hdev)
 	 * know if device is undergoing reset
 	 */
 	ae_dev->reset_type = hdev->reset_type;
-	hdev->reset_count++;
+	hdev->rst_stats.reset_cnt++;
 	/* perform reset of the stack & ae device for a client */
 	ret = hclge_notify_roce_client(hdev, HNAE3_DOWN_CLIENT);
 	if (ret)
@@ -2987,6 +2992,8 @@ static void hclge_reset(struct hclge_dev *hdev)
 		goto err_reset;
 	}
 
+	hdev->rst_stats.hw_reset_done_cnt++;
+
 	ret = hclge_notify_roce_client(hdev, HNAE3_UNINIT_CLIENT);
 	if (ret)
 		goto err_reset;
@@ -3030,6 +3037,7 @@ static void hclge_reset(struct hclge_dev *hdev)
 
 	hdev->last_reset_time = jiffies;
 	hdev->reset_fail_cnt = 0;
+	hdev->rst_stats.reset_done_cnt++;
 	ae_dev->reset_type = HNAE3_NONE_RESET;
 	del_timer(&hdev->reset_timer);
 
@@ -5224,7 +5232,7 @@ static unsigned long hclge_ae_dev_reset_cnt(struct hnae3_handle *handle)
 	struct hclge_vport *vport = hclge_get_vport(handle);
 	struct hclge_dev *hdev = vport->back;
 
-	return hdev->reset_count;
+	return hdev->rst_stats.hw_reset_done_cnt;
 }
 
 static void hclge_enable_fd(struct hnae3_handle *handle, bool enable)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index e736030..6726b01 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -649,6 +649,17 @@ struct hclge_vport_vlan_cfg {
 	u16 vlan_id;
 };
 
+struct hclge_rst_stats {
+	u32 reset_done_cnt;	/* the number of reset has completed */
+	u32 hw_reset_done_cnt;	/* the number of HW reset has completed */
+	u32 pf_rst_cnt;		/* the number of PF reset */
+	u32 flr_rst_cnt;	/* the number of FLR */
+	u32 core_rst_cnt;	/* the number of CORE reset */
+	u32 global_rst_cnt;	/* the number of GLOBAL */
+	u32 imp_rst_cnt;	/* the number of IMP reset */
+	u32 reset_cnt;		/* the number of reset */
+};
+
 /* For each bit of TCAM entry, it uses a pair of 'x' and
  * 'y' to indicate which value to match, like below:
  * ----------------------------------
@@ -691,7 +702,7 @@ struct hclge_dev {
 	unsigned long default_reset_request;
 	unsigned long reset_request;	/* reset has been requested */
 	unsigned long reset_pending;	/* client rst is pending to be served */
-	unsigned long reset_count;	/* the number of reset has been done */
+	struct hclge_rst_stats rst_stats;
 	u32 reset_fail_cnt;
 	u32 fw_version;
 	u16 num_vmdq_vport;		/* Num vmdq vport this PF has set up */
-- 
2.7.4

