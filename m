Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACA9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59AB420C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551367698;
	bh=Z5+rDUULjVujJ0pOmcJhH2eynq6PMvgP+zIvZu7OM10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ceueiATFxbGx2/Np1dD8Hu/sSXBCybzENWMaFJOKnkxrclA7gSOh1TDbfK2OBwmHm
	 pO8xRDALK+QnRwb7NdlqPW/BGVMTwdAQhVDFiVVegAiAe7U8vBte95cELiYfnXQDvw
	 OC3hlkMlqOyrq47VihoEQH57f5ll5uw9naHvU1sk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388754AbfB1P2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:28:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:43970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387852AbfB1PLC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:11:02 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4300B218D8;
        Thu, 28 Feb 2019 15:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366661;
        bh=Z5+rDUULjVujJ0pOmcJhH2eynq6PMvgP+zIvZu7OM10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WcUDCzD61npLXcEhc4THy/lBmV79efc9ObSfw8xJ5pP1H1lrQZoGDVtR51Yi47EGs
         DCrayiZMie48omHLXHxZ35Onwx0kTXvxkYB7vZ40a/wNsqJLDfgnc7PhLQR19YaSGB
         AKn02etk+hVb4748KFoOoqpEDehptZMiBrdcT3Qs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sudarsana Reddy Kalluru <skalluru@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        xdp-newbies@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 79/81] qed: Consider TX tcs while deriving the max num_queues for PF.
Date:   Thu, 28 Feb 2019 10:08:11 -0500
Message-Id: <20190228150813.10256-79-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228150813.10256-1-sashal@kernel.org>
References: <20190228150813.10256-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sudarsana Reddy Kalluru <skalluru@marvell.com>

[ Upstream commit fb1faab74ddef9ec2d841d54e5d0912a097b3abe ]

Max supported queues is derived incorrectly in the case of multi-CoS.
Need to consider TCs while calculating num_queues for PF.

Signed-off-by: Sudarsana Reddy Kalluru <skalluru@marvell.com>
Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_l2.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_l2.c b/drivers/net/ethernet/qlogic/qed/qed_l2.c
index 67c02ea939062..bde6f5f3bf8f7 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_l2.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_l2.c
@@ -2207,7 +2207,7 @@ static int qed_fill_eth_dev_info(struct qed_dev *cdev,
 			u16 num_queues = 0;
 
 			/* Since the feature controls only queue-zones,
-			 * make sure we have the contexts [rx, tx, xdp] to
+			 * make sure we have the contexts [rx, xdp, tcs] to
 			 * match.
 			 */
 			for_each_hwfn(cdev, i) {
@@ -2217,7 +2217,8 @@ static int qed_fill_eth_dev_info(struct qed_dev *cdev,
 				u16 cids;
 
 				cids = hwfn->pf_params.eth_pf_params.num_cons;
-				num_queues += min_t(u16, l2_queues, cids / 3);
+				cids /= (2 + info->num_tc);
+				num_queues += min_t(u16, l2_queues, cids);
 			}
 
 			/* queues might theoretically be >256, but interrupts'
-- 
2.19.1

