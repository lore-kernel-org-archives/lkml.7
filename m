Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879D6C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DA3020665
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563997879;
	bh=Y1nqmQ4xUMzB9/IdK+W47PHTspZupZm48fazF7jivv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HRBqofdXZsbvZwO2cFTxd3RV4SjUbXzn3gYOfllj8LOkdcplq5y5gySQanhEkAnfo
	 9MrtQ53sqxF6NuR7gSK6dm+zUIul1aR/Sv+bN0KCSKO0s9joUJsdlHnNIiQgsXykDI
	 hKRh1nE+VYyWPEB8uQq7OfGsDtuNxaMJPdiUNflE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391359AbfGXTvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:51:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:60430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391636AbfGXTvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:51:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EB5F20665;
        Wed, 24 Jul 2019 19:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563997873;
        bh=Y1nqmQ4xUMzB9/IdK+W47PHTspZupZm48fazF7jivv4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SYFrhTDoD02qsyD50KNmzF6QNKxAMARlAGgM2JeC/k3hEM0aKtlJCpgi1WzZbRyoG
         PoT5lrjANgcMvAri6UenzXTD/ydEFOwJNi5HX+n9pArl7HiQbnHHu3KHimEcS5yEPs
         FKItdIiv8/CWoGaL7c4VECdGxHdLLz7SAYyHkurg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yunsheng Lin <linyunsheng@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 174/371] net: hns3: add some error checking in hclge_tm module
Date:   Wed, 24 Jul 2019 21:18:46 +0200
Message-Id: <20190724191738.348152371@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191724.382593077@linuxfoundation.org>
References: <20190724191724.382593077@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 04f25edb48c441fc278ecc154c270f16966cbb90 ]

When hdev->tx_sch_mode is HCLGE_FLAG_VNET_BASE_SCH_MODE, the
hclge_tm_schd_mode_vnet_base_cfg calls hclge_tm_pri_schd_mode_cfg
with vport->vport_id as pri_id, which is used as index for
hdev->tm_info.tc_info, it will cause out of bound access issue
if vport_id is equal to or larger than HNAE3_MAX_TC.

Also hardware only support maximum speed of HCLGE_ETHER_MAX_RATE.

So this patch adds two checks for above cases.

Fixes: 848440544b41 ("net: hns3: Add support of TX Scheduler & Shaper to HNS3 driver")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
index a7bbb6d3091a..0d53062f7bb5 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
@@ -54,7 +54,8 @@ static int hclge_shaper_para_calc(u32 ir, u8 shaper_level,
 	u32 tick;
 
 	/* Calc tick */
-	if (shaper_level >= HCLGE_SHAPER_LVL_CNT)
+	if (shaper_level >= HCLGE_SHAPER_LVL_CNT ||
+	    ir > HCLGE_ETHER_MAX_RATE)
 		return -EINVAL;
 
 	tick = tick_array[shaper_level];
@@ -1124,6 +1125,9 @@ static int hclge_tm_schd_mode_vnet_base_cfg(struct hclge_vport *vport)
 	int ret;
 	u8 i;
 
+	if (vport->vport_id >= HNAE3_MAX_TC)
+		return -EINVAL;
+
 	ret = hclge_tm_pri_schd_mode_cfg(hdev, vport->vport_id);
 	if (ret)
 		return ret;
-- 
2.20.1



