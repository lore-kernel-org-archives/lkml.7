Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF72C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 03:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1037921736
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 03:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbfDSDHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 23:07:14 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53336 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727215AbfDSDHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 23:07:12 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BE9295763ED1566F757A;
        Fri, 19 Apr 2019 11:07:09 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Fri, 19 Apr 2019 11:07:00 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <nhorman@redhat.com>,
        Weihang Li <liweihang@hisilicon.com>,
        Peng Li <lipeng321@huawei.com>
Subject: [PATCH net-next 10/12] net: hns3: Add handling of MAC tunnel interruption
Date:   Fri, 19 Apr 2019 11:05:45 +0800
Message-ID: <1555643147-52407-11-git-send-email-tanhuazhong@huawei.com>
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

From: Weihang Li <liweihang@hisilicon.com>

MAC tnl interruptions are different from other type of RAS and MSI-X
errors, because some bits, such as OVF/LR/RF will occur during link up
and down.

The drivers should clear status of all MAC tnl interruption bits but
shouldn't print any message that would mislead the users.

In case that link down and re-up in a short time because of some reasons,
we record when they occurred, and users can query them by debugfs.

Signed-off-by: Weihang Li <liweihang@hisilicon.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c |  1 +
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h |  3 ++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c | 22 ++++++++++
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c | 51 ++++++++++++++++++++++
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h |  4 ++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  4 ++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    | 11 +++++
 7 files changed, 96 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index 5ccb701..1532906 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -249,6 +249,7 @@ static void hns3_dbg_help(struct hnae3_handle *h)
 	dev_info(&h->pdev->dev, "dump mng tbl\n");
 	dev_info(&h->pdev->dev, "dump reset info\n");
 	dev_info(&h->pdev->dev, "dump ncl_config <offset> <length>(in hex)\n");
+	dev_info(&h->pdev->dev, "dump mac tnl status\n");
 
 	memset(printf_buf, 0, HNS3_DBG_BUF_LEN);
 	strncat(printf_buf, "dump reg [[bios common] [ssu <prt_id>]",
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
index 124d78e..d01f93e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
@@ -109,6 +109,9 @@ enum hclge_opcode_type {
 	HCLGE_OPC_QUERY_LINK_STATUS	= 0x0307,
 	HCLGE_OPC_CONFIG_MAX_FRM_SIZE	= 0x0308,
 	HCLGE_OPC_CONFIG_SPEED_DUP	= 0x0309,
+	HCLGE_OPC_QUERY_MAC_TNL_INT	= 0x0310,
+	HCLGE_OPC_MAC_TNL_INT_EN	= 0x0311,
+	HCLGE_OPC_CLEAR_MAC_TNL_INT	= 0x0312,
 	HCLGE_OPC_SERDES_LOOPBACK       = 0x0315,
 
 	/* PFC/Pause commands */
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
index 6a774cc..a9ffb57 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
@@ -984,6 +984,26 @@ static void hclge_dbg_dump_ncl_config(struct hclge_dev *hdev, char *cmd_buf)
 	}
 }
 
+/* hclge_dbg_dump_mac_tnl_status: print message about mac tnl interrupt
+ * @hdev: pointer to struct hclge_dev
+ */
+static void hclge_dbg_dump_mac_tnl_status(struct hclge_dev *hdev)
+{
+#define HCLGE_BILLION_NANO_SECONDS 1000000000
+
+	struct hclge_mac_tnl_stats stats;
+	unsigned long rem_nsec;
+
+	dev_info(&hdev->pdev->dev, "Recently generated mac tnl interruption:\n");
+
+	while (kfifo_get(&hdev->mac_tnl_log, &stats)) {
+		rem_nsec = do_div(stats.time, HCLGE_BILLION_NANO_SECONDS);
+		dev_info(&hdev->pdev->dev, "[%07lu.%03lu]status = 0x%x\n",
+			 (unsigned long)stats.time, rem_nsec / 1000,
+			 stats.status);
+	}
+}
+
 int hclge_dbg_run_cmd(struct hnae3_handle *handle, char *cmd_buf)
 {
 	struct hclge_vport *vport = hclge_get_vport(handle);
@@ -1012,6 +1032,8 @@ int hclge_dbg_run_cmd(struct hnae3_handle *handle, char *cmd_buf)
 	} else if (strncmp(cmd_buf, "dump ncl_config", 15) == 0) {
 		hclge_dbg_dump_ncl_config(hdev,
 					  &cmd_buf[sizeof("dump ncl_config")]);
+	} else if (strncmp(cmd_buf, "dump mac tnl status", 19) == 0) {
+		hclge_dbg_dump_mac_tnl_status(hdev);
 	} else {
 		dev_info(&hdev->pdev->dev, "unknown command\n");
 		return -EINVAL;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
index 62ef161..804c870 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
@@ -692,6 +692,16 @@ static int hclge_cmd_query_error(struct hclge_dev *hdev,
 	return ret;
 }
 
+static int hclge_clear_mac_tnl_int(struct hclge_dev *hdev)
+{
+	struct hclge_desc desc;
+
+	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_CLEAR_MAC_TNL_INT, false);
+	desc.data[0] = cpu_to_le32(HCLGE_MAC_TNL_INT_CLR);
+
+	return hclge_cmd_send(&hdev->hw, &desc, 1);
+}
+
 static int hclge_config_common_hw_err_int(struct hclge_dev *hdev, bool en)
 {
 	struct device *dev = &hdev->pdev->dev;
@@ -911,6 +921,21 @@ static int hclge_config_mac_err_int(struct hclge_dev *hdev, bool en)
 	return ret;
 }
 
+int hclge_config_mac_tnl_int(struct hclge_dev *hdev, bool en)
+{
+	struct hclge_desc desc;
+
+	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_MAC_TNL_INT_EN, false);
+	if (en)
+		desc.data[0] = cpu_to_le32(HCLGE_MAC_TNL_INT_EN);
+	else
+		desc.data[0] = 0;
+
+	desc.data[1] = cpu_to_le32(HCLGE_MAC_TNL_INT_EN_MASK);
+
+	return hclge_cmd_send(&hdev->hw, &desc, 1);
+}
+
 static int hclge_config_ppu_error_interrupts(struct hclge_dev *hdev, u32 cmd,
 					     bool en)
 {
@@ -1611,6 +1636,7 @@ pci_ers_result_t hclge_handle_hw_ras_error(struct hnae3_ae_dev *ae_dev)
 int hclge_handle_hw_msix_error(struct hclge_dev *hdev,
 			       unsigned long *reset_requests)
 {
+	struct hclge_mac_tnl_stats mac_tnl_stats;
 	struct device *dev = &hdev->pdev->dev;
 	u32 mpf_bd_num, pf_bd_num, bd_num;
 	enum hnae3_reset_type reset_level;
@@ -1745,6 +1771,31 @@ int hclge_handle_hw_msix_error(struct hclge_dev *hdev,
 		set_bit(HNAE3_GLOBAL_RESET, reset_requests);
 	}
 
+	/* query and clear mac tnl interruptions */
+	hclge_cmd_setup_basic_desc(&desc[0], HCLGE_OPC_QUERY_MAC_TNL_INT,
+				   true);
+	ret = hclge_cmd_send(&hdev->hw, &desc[0], 1);
+	if (ret) {
+		dev_err(dev, "query mac tnl int cmd failed (%d)\n", ret);
+		goto msi_error;
+	}
+
+	status = le32_to_cpu(desc->data[0]);
+	if (status) {
+		/* When mac tnl interrupt occurs, we record current time and
+		 * register status here in a fifo, then clear the status. So
+		 * that if link status changes suddenly at some time, we can
+		 * query them by debugfs.
+		 */
+		mac_tnl_stats.time = local_clock();
+		mac_tnl_stats.status = status;
+		kfifo_put(&hdev->mac_tnl_log, mac_tnl_stats);
+		ret = hclge_clear_mac_tnl_int(hdev);
+		if (ret)
+			dev_err(dev, "clear mac tnl int failed (%d)\n", ret);
+		set_bit(HNAE3_NONE_RESET, reset_requests);
+	}
+
 msi_error:
 	kfree(desc);
 out:
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h
index 4a2e82f..9645590 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h
@@ -47,6 +47,9 @@
 #define HCLGE_NCSI_ERR_INT_TYPE	0x9
 #define HCLGE_MAC_COMMON_ERR_INT_EN		0x107FF
 #define HCLGE_MAC_COMMON_ERR_INT_EN_MASK	0x107FF
+#define HCLGE_MAC_TNL_INT_EN			GENMASK(7, 0)
+#define HCLGE_MAC_TNL_INT_EN_MASK		GENMASK(7, 0)
+#define HCLGE_MAC_TNL_INT_CLR			GENMASK(7, 0)
 #define HCLGE_PPU_MPF_ABNORMAL_INT0_EN		GENMASK(31, 0)
 #define HCLGE_PPU_MPF_ABNORMAL_INT0_EN_MASK	GENMASK(31, 0)
 #define HCLGE_PPU_MPF_ABNORMAL_INT1_EN		GENMASK(31, 0)
@@ -115,6 +118,7 @@ struct hclge_hw_error {
 	enum hnae3_reset_type reset_level;
 };
 
+int hclge_config_mac_tnl_int(struct hclge_dev *hdev, bool en);
 int hclge_hw_error_set_state(struct hclge_dev *hdev, bool state);
 pci_ers_result_t hclge_handle_hw_ras_error(struct hnae3_ae_dev *ae_dev);
 int hclge_handle_hw_msix_error(struct hclge_dev *hdev,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 3741c47..4d5568e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -2248,6 +2248,7 @@ static void hclge_update_link_status(struct hclge_dev *hdev)
 		for (i = 0; i < hdev->num_vmdq_vport + 1; i++) {
 			handle = &hdev->vport[i].nic;
 			client->ops->link_status_change(handle, state);
+			hclge_config_mac_tnl_int(hdev, state);
 			rhandle = &hdev->vport[i].roce;
 			if (rclient && rclient->ops->link_status_change)
 				rclient->ops->link_status_change(rhandle,
@@ -7963,6 +7964,8 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
 		goto err_mdiobus_unreg;
 	}
 
+	INIT_KFIFO(hdev->mac_tnl_log);
+
 	hclge_dcb_ops_set(hdev);
 
 	timer_setup(&hdev->service_timer, hclge_service_timer, 0);
@@ -8116,6 +8119,7 @@ static void hclge_uninit_ae_dev(struct hnae3_ae_dev *ae_dev)
 	hclge_enable_vector(&hdev->misc_vector, false);
 	synchronize_irq(hdev->misc_vector.vector_irq);
 
+	hclge_config_mac_tnl_int(hdev, false);
 	hclge_hw_error_set_state(hdev, false);
 	hclge_cmd_uninit(hdev);
 	hclge_misc_irq_uninit(hdev);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index 6726b01..4aba624 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -7,6 +7,7 @@
 #include <linux/types.h>
 #include <linux/phy.h>
 #include <linux/if_vlan.h>
+#include <linux/kfifo.h>
 
 #include "hclge_cmd.h"
 #include "hnae3.h"
@@ -660,6 +661,12 @@ struct hclge_rst_stats {
 	u32 reset_cnt;		/* the number of reset */
 };
 
+/* time and register status when mac tunnel interruption occur */
+struct hclge_mac_tnl_stats {
+	u64 time;
+	u32 status;
+};
+
 /* For each bit of TCAM entry, it uses a pair of 'x' and
  * 'y' to indicate which value to match, like below:
  * ----------------------------------
@@ -686,6 +693,7 @@ struct hclge_rst_stats {
 		(y) = (_k_ ^ ~_v_) & (_k_); \
 	} while (0)
 
+#define HCLGE_MAC_TNL_LOG_SIZE	8
 #define HCLGE_VPORT_NUM 256
 struct hclge_dev {
 	struct pci_dev *pdev;
@@ -802,6 +810,9 @@ struct hclge_dev {
 	struct mutex umv_mutex; /* protect share_umv_size */
 
 	struct mutex vport_cfg_mutex;   /* Protect stored vf table */
+
+	DECLARE_KFIFO(mac_tnl_log, struct hclge_mac_tnl_stats,
+		      HCLGE_MAC_TNL_LOG_SIZE);
 };
 
 /* VPort level vlan tag configuration for TX direction */
-- 
2.7.4

