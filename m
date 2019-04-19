Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64598C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 03:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3007B21736
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 03:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbfDSDHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 23:07:16 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53338 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727315AbfDSDHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 23:07:12 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C586AE69B40ABE53ED30;
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
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 09/12] net: hns3: add support for dump ncl config by debugfs
Date:   Fri, 19 Apr 2019 11:05:44 +0800
Message-ID: <1555643147-52407-10-git-send-email-tanhuazhong@huawei.com>
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

This patch allow users to dump content of NCL_CONFIG by using debugfs
command.
Command format:
	echo dump ncl_config <offset> <length> > cmd
It will print as follows:
	hns3 0000:7d:00.0: offset |    data
	hns3 0000:7d:00.0: 0x0000 | 0x00000020
	hns3 0000:7d:00.0: 0x0004 | 0x00000400
	hns3 0000:7d:00.0: 0x0008 | 0x08020401

Signed-off-by: Weihang Li <liweihang@hisilicon.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c |  1 +
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h |  3 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c | 66 ++++++++++++++++++++++
 3 files changed, 70 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index c46da81..5ccb701 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -248,6 +248,7 @@ static void hns3_dbg_help(struct hnae3_handle *h)
 	dev_info(&h->pdev->dev, "dump qos buf cfg\n");
 	dev_info(&h->pdev->dev, "dump mng tbl\n");
 	dev_info(&h->pdev->dev, "dump reset info\n");
+	dev_info(&h->pdev->dev, "dump ncl_config <offset> <length>(in hex)\n");
 
 	memset(printf_buf, 0, HNS3_DBG_BUF_LEN);
 	strncat(printf_buf, "dump reg [[bios common] [ssu <prt_id>]",
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
index 3714733..124d78e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
@@ -237,6 +237,9 @@ enum hclge_opcode_type {
 	/* Led command */
 	HCLGE_OPC_LED_STATUS_CFG	= 0xB000,
 
+	/* NCL config command */
+	HCLGE_OPC_QUERY_NCL_CONFIG	= 0x7011,
+
 	/* SFP command */
 	HCLGE_OPC_SFP_GET_SPEED		= 0x7104,
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
index d9782c7..6a774cc 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
@@ -921,6 +921,69 @@ static void hclge_dbg_dump_rst_info(struct hclge_dev *hdev)
 		 hdev->rst_stats.reset_cnt);
 }
 
+/* hclge_dbg_dump_ncl_config: print specified range of NCL_CONFIG file
+ * @hdev: pointer to struct hclge_dev
+ * @cmd_buf: string that contains offset and length
+ */
+static void hclge_dbg_dump_ncl_config(struct hclge_dev *hdev, char *cmd_buf)
+{
+#define HCLGE_MAX_NCL_CONFIG_OFFSET	4096
+#define HCLGE_MAX_NCL_CONFIG_LENGTH	(20 + 24 * 4)
+#define HCLGE_CMD_DATA_NUM		6
+
+	struct hclge_desc desc[5];
+	u32 byte_offset;
+	int bd_num = 5;
+	int offset;
+	int length;
+	int data0;
+	int ret;
+	int i;
+	int j;
+
+	ret = sscanf(cmd_buf, "%x %x", &offset, &length);
+	if (ret != 2 || offset >= HCLGE_MAX_NCL_CONFIG_OFFSET ||
+	    length > HCLGE_MAX_NCL_CONFIG_OFFSET - offset) {
+		dev_err(&hdev->pdev->dev, "Invalid offset or length.\n");
+		return;
+	}
+	if (offset < 0 || length <= 0) {
+		dev_err(&hdev->pdev->dev, "Non-positive offset or length.\n");
+		return;
+	}
+
+	dev_info(&hdev->pdev->dev, "offset |    data\n");
+
+	while (length > 0) {
+		data0 = offset;
+		if (length >= HCLGE_MAX_NCL_CONFIG_LENGTH)
+			data0 |= HCLGE_MAX_NCL_CONFIG_LENGTH << 16;
+		else
+			data0 |= length << 16;
+		ret = hclge_dbg_cmd_send(hdev, desc, data0, bd_num,
+					 HCLGE_OPC_QUERY_NCL_CONFIG);
+		if (ret)
+			return;
+
+		byte_offset = offset;
+		for (i = 0; i < bd_num; i++) {
+			for (j = 0; j < HCLGE_CMD_DATA_NUM; j++) {
+				if (i == 0 && j == 0)
+					continue;
+
+				dev_info(&hdev->pdev->dev, "0x%04x | 0x%08x\n",
+					 byte_offset,
+					 le32_to_cpu(desc[i].data[j]));
+				byte_offset += sizeof(u32);
+				length -= sizeof(u32);
+				if (length <= 0)
+					return;
+			}
+		}
+		offset += HCLGE_MAX_NCL_CONFIG_LENGTH;
+	}
+}
+
 int hclge_dbg_run_cmd(struct hnae3_handle *handle, char *cmd_buf)
 {
 	struct hclge_vport *vport = hclge_get_vport(handle);
@@ -946,6 +1009,9 @@ int hclge_dbg_run_cmd(struct hnae3_handle *handle, char *cmd_buf)
 		hclge_dbg_dump_reg_cmd(hdev, cmd_buf);
 	} else if (strncmp(cmd_buf, "dump reset info", 15) == 0) {
 		hclge_dbg_dump_rst_info(hdev);
+	} else if (strncmp(cmd_buf, "dump ncl_config", 15) == 0) {
+		hclge_dbg_dump_ncl_config(hdev,
+					  &cmd_buf[sizeof("dump ncl_config")]);
 	} else {
 		dev_info(&hdev->pdev->dev, "unknown command\n");
 		return -EINVAL;
-- 
2.7.4

