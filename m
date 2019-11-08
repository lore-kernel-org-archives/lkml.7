Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE21FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91F9321848
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573215018;
	bh=L5ZKUrc/TBLLpyooRleWyieQNY5ylLKmZ/vovfO3UOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hrBz8STd2wLlTdJrGkKmN3SKXeCNAV4tr8cTBs0TG8WAe8WDqIn8WHOsVyXRG37Vf
	 WcJjVr8jUHp5E2h7Id9/sGu/gyoOBVDJiPZid3B7kR7j6Dj3VLUfcKQjRBamqIURo3
	 PMc8P1y5/OukgP8aWd0R++wGuj3VWHvoMuFh/6qw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387983AbfKHLjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:39:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:52468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730616AbfKHLjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:39:35 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8562C20869;
        Fri,  8 Nov 2019 11:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213175;
        bh=L5ZKUrc/TBLLpyooRleWyieQNY5ylLKmZ/vovfO3UOc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tM7whB751xtK/0CVLtvrZ2F3vewXmn9e79a/6qEBVcPRd47UY0mcAyUd2dQrPyUUS
         +VIuV6qd/NC9kXYp4uvRtik12qMjAbBRtuSGI3AbqWr3W35H4vYnchKM3IS26WZmr2
         IVT6sBt9R9vDXDrDXC3bbG37AmuZy1MXw5snyvy8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Huazhong Tan <tanhuazhong@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 071/205] net: hns3: Fix for multicast failure
Date:   Fri,  8 Nov 2019 06:35:38 -0500
Message-Id: <20191108113752.12502-71-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108113752.12502-1-sashal@kernel.org>
References: <20191108113752.12502-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huazhong Tan <tanhuazhong@huawei.com>

[ Upstream commit fd5f9da3f6583046215d614a87792b46e55785e2 ]

When the lower 24 bits of the IPV6 link-local addresses at both
ends are the same, the multicast MAC address for Neigbour Discovery
is the same. The multicast for Neigbour Discovery will fail.

This patch fixes it by including the bonding uplink port in the
multicast group.

Fixes: 46a3df9f9718("net: hns3: Add HNS3 Acceleration Engine & Compatibility Layer Support")
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 89ca69fa2b97b..44d0cb3f73a44 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -4374,7 +4374,7 @@ int hclge_add_mc_addr_common(struct hclge_vport *vport,
 	hnae3_set_bit(req.flags, HCLGE_MAC_VLAN_BIT0_EN_B, 1);
 	hnae3_set_bit(req.entry_type, HCLGE_MAC_VLAN_BIT0_EN_B, 0);
 	hnae3_set_bit(req.entry_type, HCLGE_MAC_VLAN_BIT1_EN_B, 1);
-	hnae3_set_bit(req.mc_mac_en, HCLGE_MAC_VLAN_BIT0_EN_B, 0);
+	hnae3_set_bit(req.mc_mac_en, HCLGE_MAC_VLAN_BIT0_EN_B, 1);
 	hclge_prepare_mac_addr(&req, addr);
 	status = hclge_lookup_mac_vlan_tbl(vport, &req, desc, true);
 	if (!status) {
@@ -4441,7 +4441,7 @@ int hclge_rm_mc_addr_common(struct hclge_vport *vport,
 	hnae3_set_bit(req.flags, HCLGE_MAC_VLAN_BIT0_EN_B, 1);
 	hnae3_set_bit(req.entry_type, HCLGE_MAC_VLAN_BIT0_EN_B, 0);
 	hnae3_set_bit(req.entry_type, HCLGE_MAC_VLAN_BIT1_EN_B, 1);
-	hnae3_set_bit(req.mc_mac_en, HCLGE_MAC_VLAN_BIT0_EN_B, 0);
+	hnae3_set_bit(req.mc_mac_en, HCLGE_MAC_VLAN_BIT0_EN_B, 1);
 	hclge_prepare_mac_addr(&req, addr);
 	status = hclge_lookup_mac_vlan_tbl(vport, &req, desc, true);
 	if (!status) {
-- 
2.20.1

