Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AEDC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9CC92053B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575413753;
	bh=X6vTzpowZmATaq3N5YPTSWrjBYpQFFtRixxK+r2C46s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fal0gxyncXd6zZvtMgXNKlA8O8lLcHMKU+M2LfNGwnilK8/wZyNRTL+nHV0ggXNa9
	 574BzDtpqjfxckaC0F3qjhGAaeaiO5eVhyeHQZq5tLhyCgB8c4RRoXm+0w8/7IM5wP
	 UvtaqQ9jxQ94oVCYFLXObyG9BxBy4f8Rum9bjrUk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbfLCWzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:55:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:50310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730191AbfLCWzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:55:47 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6286020656;
        Tue,  3 Dec 2019 22:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413746;
        bh=X6vTzpowZmATaq3N5YPTSWrjBYpQFFtRixxK+r2C46s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mxGGHAa5nnTASBiKO4CQQrVlWZiZXW1BbkkBoztywrTlDygYGs4ssCfjrQI1H1dXE
         2CbsGw5WEkXXrfY9MaLncTv5ICQA9zrEGt9cKKcU3qvSWhy4FK8dwq3rVAG6cpcE+N
         a7k+TaMl/dXBwaj9HEqCyielCSeC2SKUFob9PhoU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yunsheng Lin <linyunsheng@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 245/321] net: hns3: fix PFC not setting problem for DCB module
Date:   Tue,  3 Dec 2019 23:35:11 +0100
Message-Id: <20191203223439.885488392@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203223427.103571230@linuxfoundation.org>
References: <20191203223427.103571230@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

[ Upstream commit d3ad430ac531e65f29c9737f86744c425c9173ef ]

The PFC enabling is based on user priority, currently it is
based on TC, which may cause PFC not setting correctly when pri
to TC mapping is not one to one relation.

This patch adds pfc_en in tm_info to fix it.

Fixes: cacde272dd00 ("net: hns3: Add hclge_dcb module for the support of DCB feature")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c  | 7 ++++---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h | 1 +
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c   | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
index 92f19384e2585..a75d7c826fc2b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
@@ -245,6 +245,9 @@ static int hclge_ieee_setpfc(struct hnae3_handle *h, struct ieee_pfc *pfc)
 	    hdev->flag & HCLGE_FLAG_MQPRIO_ENABLE)
 		return -EINVAL;
 
+	if (pfc->pfc_en == hdev->tm_info.pfc_en)
+		return 0;
+
 	prio_tc = hdev->tm_info.prio_tc;
 	pfc_map = 0;
 
@@ -257,10 +260,8 @@ static int hclge_ieee_setpfc(struct hnae3_handle *h, struct ieee_pfc *pfc)
 		}
 	}
 
-	if (pfc_map == hdev->tm_info.hw_pfc_map)
-		return 0;
-
 	hdev->tm_info.hw_pfc_map = pfc_map;
+	hdev->tm_info.pfc_en = pfc->pfc_en;
 
 	return hclge_pause_setup_hw(hdev);
 }
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index 1528fb3fa6be6..260b1e7796908 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -249,6 +249,7 @@ struct hclge_tm_info {
 	struct hclge_tc_info tc_info[HNAE3_MAX_TC];
 	enum hclge_fc_mode fc_mode;
 	u8 hw_pfc_map; /* Allow for packet drop or not on this TC */
+	u8 pfc_en;	/* PFC enabled or not for user priority */
 };
 
 struct hclge_comm_stats_str {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
index 0d45d045706c7..3180ae4528895 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
@@ -1162,7 +1162,7 @@ static int hclge_pfc_setup_hw(struct hclge_dev *hdev)
 				HCLGE_RX_MAC_PAUSE_EN_MSK;
 
 	return hclge_pfc_pause_en_cfg(hdev, enable_bitmap,
-				      hdev->tm_info.hw_pfc_map);
+				      hdev->tm_info.pfc_en);
 }
 
 /* Each Tc has a 1024 queue sets to backpress, it divides to
-- 
2.20.1



