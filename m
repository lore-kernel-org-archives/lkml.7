Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A43C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 14:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D272622CED
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 14:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfH1O0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 10:26:38 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5234 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726691AbfH1OZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 10:25:40 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1825CCC0AA225B890167;
        Wed, 28 Aug 2019 22:25:36 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Wed, 28 Aug 2019 22:25:30 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 03/12] net: hns3: modify base parameter of kstrtouint in hclge_dbg_dump_tm_map
Date:   Wed, 28 Aug 2019 22:23:07 +0800
Message-ID: <1567002196-63242-4-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567002196-63242-1-git-send-email-tanhuazhong@huawei.com>
References: <1567002196-63242-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces kstrtouint()'s patameter base with 0 in the
hclge_dbg_dump_tm_mac(), which makes it more flexible. Also
uses a macro to replace string "dump tm map", since it has been
used multiple times.

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
index 3b4cd23..0639250 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
@@ -564,7 +564,7 @@ static void hclge_dbg_dump_tm_map(struct hclge_dev *hdev,
 	int pri_id, ret;
 	u32 i;
 
-	ret = kstrtouint(&cmd_buf[12], 10, &queue_id);
+	ret = kstrtouint(cmd_buf, 0, &queue_id);
 	queue_id = (ret != 0) ? 0 : queue_id;
 
 	cmd = HCLGE_OPC_TM_NQ_TO_QS_LINK;
@@ -1099,6 +1099,7 @@ static void hclge_dbg_dump_mac_tnl_status(struct hclge_dev *hdev)
 int hclge_dbg_run_cmd(struct hnae3_handle *handle, const char *cmd_buf)
 {
 #define DUMP_REG	"dump reg"
+#define DUMP_TM_MAP	"dump tm map"
 
 	struct hclge_vport *vport = hclge_get_vport(handle);
 	struct hclge_dev *hdev = vport->back;
@@ -1107,8 +1108,8 @@ int hclge_dbg_run_cmd(struct hnae3_handle *handle, const char *cmd_buf)
 		hclge_dbg_fd_tcam(hdev);
 	} else if (strncmp(cmd_buf, "dump tc", 7) == 0) {
 		hclge_dbg_dump_tc(hdev);
-	} else if (strncmp(cmd_buf, "dump tm map", 11) == 0) {
-		hclge_dbg_dump_tm_map(hdev, cmd_buf);
+	} else if (strncmp(cmd_buf, DUMP_TM_MAP, strlen(DUMP_TM_MAP)) == 0) {
+		hclge_dbg_dump_tm_map(hdev, &cmd_buf[sizeof(DUMP_TM_MAP)]);
 	} else if (strncmp(cmd_buf, "dump tm", 7) == 0) {
 		hclge_dbg_dump_tm(hdev);
 	} else if (strncmp(cmd_buf, "dump qos pause cfg", 18) == 0) {
-- 
2.7.4

