Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C95C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B456205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387942AbfDYMoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:44:44 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6697 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731420AbfDYMoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 08:44:18 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4D801C9D683CF5B5B4DF;
        Thu, 25 Apr 2019 20:44:14 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Thu, 25 Apr 2019 20:44:04 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <nhorman@redhat.com>,
        Huazhong Tan <tanhuazhong@huawei.com>,
        Peng Li <lipeng321@huawei.com>
Subject: [PATCH V3 net-next 06/11] net: hns3: use a reserved byte to identify need_resp flag
Date:   Thu, 25 Apr 2019 20:42:50 +0800
Message-ID: <1556196175-65389-7-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556196175-65389-1-git-send-email-tanhuazhong@huawei.com>
References: <1556196175-65389-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch uses a reserved byte in the hclge_mbx_vf_to_pf_cmd
to save the need_resp flag, so when PF received the mailbox,
it can use it to decise whether send a response to VF.

For hclge_set_vf_uc_mac_addr(), it should use mbx_need_resp flag
to decide whether send response to VF.

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h          | 5 ++++-
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c   | 7 +++----
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c | 2 ++
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h b/drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h
index 8b6191f..83e19c6 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h
@@ -84,12 +84,15 @@ struct hclgevf_mbx_resp_status {
 struct hclge_mbx_vf_to_pf_cmd {
 	u8 rsv;
 	u8 mbx_src_vfid; /* Auto filled by IMP */
-	u8 rsv1[2];
+	u8 mbx_need_resp;
+	u8 rsv1[1];
 	u8 msg_len;
 	u8 rsv2[3];
 	u8 msg[HCLGE_MBX_MAX_MSG_SIZE];
 };
 
+#define HCLGE_MBX_NEED_RESP_BIT		BIT(0)
+
 struct hclge_mbx_pf_to_vf_cmd {
 	u8 dest_vfid;
 	u8 rsv[3];
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
index 24386bd..fe48c56 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
@@ -212,8 +212,7 @@ static int hclge_set_vf_promisc_mode(struct hclge_vport *vport,
 }
 
 static int hclge_set_vf_uc_mac_addr(struct hclge_vport *vport,
-				    struct hclge_mbx_vf_to_pf_cmd *mbx_req,
-				    bool gen_resp)
+				    struct hclge_mbx_vf_to_pf_cmd *mbx_req)
 {
 	const u8 *mac_addr = (const u8 *)(&mbx_req->msg[2]);
 	struct hclge_dev *hdev = vport->back;
@@ -249,7 +248,7 @@ static int hclge_set_vf_uc_mac_addr(struct hclge_vport *vport,
 		return -EIO;
 	}
 
-	if (gen_resp)
+	if (mbx_req->mbx_need_resp & HCLGE_MBX_NEED_RESP_BIT)
 		hclge_gen_resp_to_vf(vport, mbx_req, status, NULL, 0);
 
 	return 0;
@@ -597,7 +596,7 @@ void hclge_mbx_handler(struct hclge_dev *hdev)
 					ret);
 			break;
 		case HCLGE_MBX_SET_UNICAST:
-			ret = hclge_set_vf_uc_mac_addr(vport, req, true);
+			ret = hclge_set_vf_uc_mac_addr(vport, req);
 			if (ret)
 				dev_err(&hdev->pdev->dev,
 					"PF fail(%d) to set VF UC MAC Addr\n",
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c
index 3c22639..30f2e93 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c
@@ -98,6 +98,8 @@ int hclgevf_send_mbx_msg(struct hclgevf_dev *hdev, u16 code, u16 subcode,
 	}
 
 	hclgevf_cmd_setup_basic_desc(&desc, HCLGEVF_OPC_MBX_VF_TO_PF, false);
+	req->mbx_need_resp |= need_resp ? HCLGE_MBX_NEED_RESP_BIT :
+					  ~HCLGE_MBX_NEED_RESP_BIT;
 	req->msg[0] = code;
 	req->msg[1] = subcode;
 	memcpy(&req->msg[2], msg_data, msg_len);
-- 
2.7.4

