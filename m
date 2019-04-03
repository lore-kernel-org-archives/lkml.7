Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFEAC10F00
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A8DA2084A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbfDCDJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 23:09:26 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33874 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728482AbfDCDJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 23:09:22 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [10.3.19.211])
        by Forcepoint Email with ESMTP id 32C60A925C80A682F709;
        Wed,  3 Apr 2019 11:09:18 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.408.0; Wed, 3 Apr 2019 11:09:08 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, liuzhongzhu <liuzhongzhu@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 03/12] net: hns3: modify the VF network port media type acquisition method
Date:   Wed, 3 Apr 2019 11:07:52 +0800
Message-ID: <1554260881-44948-4-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554260881-44948-1-git-send-email-tanhuazhong@huawei.com>
References: <1554260881-44948-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: liuzhongzhu <liuzhongzhu@huawei.com>

Method for obtaining the media type of the VF network port periodically,
regular tasks will not run until the network port UP. When the network
port is DOWN, the network port cannot obtain the media type.
Modifies the madie type obtained when initializing the VF network port.

Signed-off-by: liuzhongzhu <liuzhongzhu@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h    |  1 +
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c | 23 ++++++++++++++++++----
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  | 23 ++++++++++++++++++++++
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c   |  1 -
 4 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h b/drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h
index 299b277..9d3d45f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h
@@ -43,6 +43,7 @@ enum HCLGE_MBX_OPCODE {
 	HCLGE_MBX_GET_QID_IN_PF,	/* (VF -> PF) get queue id in pf */
 	HCLGE_MBX_LINK_STAT_MODE,	/* (PF -> VF) link mode has changed */
 	HCLGE_MBX_GET_LINK_MODE,	/* (VF -> PF) get the link mode of pf */
+	HCLGE_MBX_GET_MEDIA_TYPE,       /* (VF -> PF) get media type */
 
 	HCLGE_MBX_GET_VF_FLR_STATUS = 200, /* (M7 -> PF) get vf reset status */
 };
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
index 306a23e..9aa9c64 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
@@ -385,24 +385,32 @@ static int hclge_get_vf_queue_depth(struct hclge_vport *vport,
 				    HCLGE_TQPS_DEPTH_INFO_LEN);
 }
 
+static int hclge_get_vf_media_type(struct hclge_vport *vport,
+				   struct hclge_mbx_vf_to_pf_cmd *mbx_req)
+{
+	struct hclge_dev *hdev = vport->back;
+	u8 resp_data;
+
+	resp_data = hdev->hw.mac.media_type;
+	return hclge_gen_resp_to_vf(vport, mbx_req, 0, &resp_data,
+				    sizeof(resp_data));
+}
+
 static int hclge_get_link_info(struct hclge_vport *vport,
 			       struct hclge_mbx_vf_to_pf_cmd *mbx_req)
 {
 	struct hclge_dev *hdev = vport->back;
 	u16 link_status;
-	u8 msg_data[10];
-	u16 media_type;
+	u8 msg_data[8];
 	u8 dest_vfid;
 	u16 duplex;
 
 	/* mac.link can only be 0 or 1 */
 	link_status = (u16)hdev->hw.mac.link;
 	duplex = hdev->hw.mac.duplex;
-	media_type = hdev->hw.mac.media_type;
 	memcpy(&msg_data[0], &link_status, sizeof(u16));
 	memcpy(&msg_data[2], &hdev->hw.mac.speed, sizeof(u32));
 	memcpy(&msg_data[6], &duplex, sizeof(u16));
-	memcpy(&msg_data[8], &media_type, sizeof(u16));
 	dest_vfid = mbx_req->mbx_src_vfid;
 
 	/* send this requested info to VF */
@@ -662,6 +670,13 @@ void hclge_mbx_handler(struct hclge_dev *hdev)
 			hclge_rm_vport_all_vlan_table(vport, true);
 			mutex_unlock(&hdev->vport_cfg_mutex);
 			break;
+		case HCLGE_MBX_GET_MEDIA_TYPE:
+			ret = hclge_get_vf_media_type(vport, req);
+			if (ret)
+				dev_err(&hdev->pdev->dev,
+					"PF fail(%d) to media type for VF\n",
+					ret);
+			break;
 		default:
 			dev_err(&hdev->pdev->dev,
 				"un-supported mailbox message, code = %d\n",
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 65bdc68..509ff93 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -307,6 +307,25 @@ static u16 hclgevf_get_qid_global(struct hnae3_handle *handle, u16 queue_id)
 	return qid_in_pf;
 }
 
+static int hclgevf_get_pf_media_type(struct hclgevf_dev *hdev)
+{
+	u8 resp_msg;
+	int ret;
+
+	ret = hclgevf_send_mbx_msg(hdev, HCLGE_MBX_GET_MEDIA_TYPE, 0, NULL, 0,
+				   true, &resp_msg, sizeof(resp_msg));
+	if (ret) {
+		dev_err(&hdev->pdev->dev,
+			"VF request to get the pf port media type failed %d",
+			ret);
+		return ret;
+	}
+
+	hdev->hw.mac.media_type = resp_msg;
+
+	return 0;
+}
+
 static int hclgevf_alloc_tqps(struct hclgevf_dev *hdev)
 {
 	struct hclgevf_tqp *tqp;
@@ -1824,6 +1843,10 @@ static int hclgevf_configure(struct hclgevf_dev *hdev)
 	if (ret)
 		return ret;
 
+	ret = hclgevf_get_pf_media_type(hdev);
+	if (ret)
+		return ret;
+
 	/* get tc configuration from PF */
 	return hclgevf_get_tc_info(hdev);
 }
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c
index 7dc3c9f..3bcf49b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c
@@ -272,7 +272,6 @@ void hclgevf_mbx_async_handler(struct hclgevf_dev *hdev)
 			link_status = le16_to_cpu(msg_q[1]);
 			memcpy(&speed, &msg_q[2], sizeof(speed));
 			duplex = (u8)le16_to_cpu(msg_q[4]);
-			hdev->hw.mac.media_type = (u8)le16_to_cpu(msg_q[5]);
 
 			/* update upper layer with new link link status */
 			hclgevf_update_link_status(hdev, link_status);
-- 
2.7.4

