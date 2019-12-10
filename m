Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC5BC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 10:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D20542053B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 10:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfLJKSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 05:18:12 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:38158 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727225AbfLJKSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 05:18:12 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9A84CF59EDAA5FFC5A7D;
        Tue, 10 Dec 2019 18:18:09 +0800 (CST)
Received: from localhost.localdomain (10.90.53.225) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Tue, 10 Dec 2019 18:18:02 +0800
From:   Chen Wandun <chenwandun@huawei.com>
To:     <claudiu.manoil@nxp.com>, <davem@davemloft.net>, <po.liu@nxp.com>,
        <vladimir.oltean@nxp.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <chenwandun@huawei.com>
Subject: [PATCH] enetc: remove variable 'tc_max_sized_frame' set but not used
Date:   Tue, 10 Dec 2019 18:24:50 +0800
Message-ID: <1575973490-88354-1-git-send-email-chenwandun@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/net/ethernet/freescale/enetc/enetc_qos.c: In function enetc_setup_tc_cbs:
drivers/net/ethernet/freescale/enetc/enetc_qos.c:195:6: warning: variable tc_max_sized_frame set but not used [-Wunused-but-set-variable]

Fixes: c431047c4efe ("enetc: add support Credit Based Shaper(CBS) for hardware offload")
Signed-off-by: Chen Wandun <chenwandun@huawei.com>
---
 drivers/net/ethernet/freescale/enetc/enetc_qos.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_qos.c b/drivers/net/ethernet/freescale/enetc/enetc_qos.c
index 2e99438..9190ffc 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_qos.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_qos.c
@@ -192,7 +192,6 @@ int enetc_setup_tc_cbs(struct net_device *ndev, void *type_data)
 	u32 hi_credit_bit, hi_credit_reg;
 	u32 max_interference_size;
 	u32 port_frame_max_size;
-	u32 tc_max_sized_frame;
 	u8 tc = cbs->queue;
 	u8 prio_top, prio_next;
 	int bw_sum = 0;
@@ -250,7 +249,7 @@ int enetc_setup_tc_cbs(struct net_device *ndev, void *type_data)
 		return -EINVAL;
 	}
 
-	tc_max_sized_frame = enetc_port_rd(&si->hw, ENETC_PTCMSDUR(tc));
+	enetc_port_rd(&si->hw, ENETC_PTCMSDUR(tc));
 
 	/* For top prio TC, the max_interfrence_size is maxSizedFrame.
 	 *
-- 
2.7.4

