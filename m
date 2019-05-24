Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88678C282E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E68E217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391110AbfEXLVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 07:21:23 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:17563 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390945AbfEXLVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 07:21:22 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id BD27095AC96796692112;
        Fri, 24 May 2019 19:21:20 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Fri, 24 May 2019 19:21:11 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Jian Shen <shenjian15@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 4/4] net: hns3: fix for FEC configuration
Date:   Fri, 24 May 2019 19:19:48 +0800
Message-ID: <1558696788-12944-5-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558696788-12944-1-git-send-email-tanhuazhong@huawei.com>
References: <1558696788-12944-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

The FEC capbility may be changed with port speed changes. Driver
needs to read the active FEC mode, and update FEC capability
when port speed changes.

Fixes: 7e6ec9148a1d ("net: hns3: add support for FEC encoding control")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 3ef5d09d..a3fba7b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -2512,6 +2512,9 @@ static void hclge_update_link_status(struct hclge_dev *hdev)
 
 static void hclge_update_port_capability(struct hclge_mac *mac)
 {
+	/* update fec ability by speed */
+	hclge_convert_setting_fec(mac);
+
 	/* firmware can not identify back plane type, the media type
 	 * read from configuration can help deal it
 	 */
@@ -2584,6 +2587,10 @@ static int hclge_get_sfp_info(struct hclge_dev *hdev, struct hclge_mac *mac)
 		mac->speed_ability = le32_to_cpu(resp->speed_ability);
 		mac->autoneg = resp->autoneg;
 		mac->support_autoneg = resp->autoneg_ability;
+		if (!resp->active_fec)
+			mac->fec_mode = 0;
+		else
+			mac->fec_mode = BIT(resp->active_fec);
 	} else {
 		mac->speed_type = QUERY_SFP_SPEED;
 	}
-- 
2.7.4

