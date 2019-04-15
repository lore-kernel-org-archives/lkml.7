Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE25C282DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 13:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3888020833
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 13:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbfDONtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 09:49:55 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6189 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727179AbfDONtz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 09:49:55 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C9A99D6D436EC20BE98D;
        Mon, 15 Apr 2019 21:49:49 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.408.0; Mon, 15 Apr 2019 21:49:42 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Jian Shen <shenjian15@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 1/2] net: hns3: fix sparse: warning when calling hclge_set_vlan_filter_hw()
Date:   Mon, 15 Apr 2019 21:48:38 +0800
Message-ID: <1555336119-8418-2-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555336119-8418-1-git-send-email-tanhuazhong@huawei.com>
References: <1555336119-8418-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

The input parameter "proto" in function hclge_set_vlan_filter_hw()
is asked to be __be16, but got u16 when calling it in function
hclge_update_port_base_vlan_cfg().

This patch fixes it by converting it with htons().

Reported-by: kbuild test robot <lkp@intel.com>
Fixes: 21e043cd8124 ("net: hns3: fix set port based VLAN for PF")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index d2fb548..7dba3b4 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -6964,7 +6964,8 @@ int hclge_update_port_base_vlan_cfg(struct hclge_vport *vport, u16 state,
 
 	if (state == HNAE3_PORT_BASE_VLAN_MODIFY) {
 		/* add new VLAN tag */
-		ret = hclge_set_vlan_filter_hw(hdev, vlan_info->vlan_proto,
+		ret = hclge_set_vlan_filter_hw(hdev,
+					       htons(vlan_info->vlan_proto),
 					       vport->vport_id,
 					       vlan_info->vlan_tag,
 					       vlan_info->qos, false);
@@ -6972,7 +6973,8 @@ int hclge_update_port_base_vlan_cfg(struct hclge_vport *vport, u16 state,
 			return ret;
 
 		/* remove old VLAN tag */
-		ret = hclge_set_vlan_filter_hw(hdev, old_vlan_info->vlan_proto,
+		ret = hclge_set_vlan_filter_hw(hdev,
+					       htons(old_vlan_info->vlan_proto),
 					       vport->vport_id,
 					       old_vlan_info->vlan_tag,
 					       old_vlan_info->qos, true);
-- 
2.7.4

