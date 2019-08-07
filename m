Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974FCC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 03:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 674C2216F4
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 03:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbfHGDEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 23:04:51 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52780 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726334AbfHGDEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 23:04:50 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 15F5F136A16E935206AE;
        Wed,  7 Aug 2019 10:48:46 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Wed, 7 Aug 2019
 10:48:38 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <j.vosburgh@gmail.com>, <vfalico@gmail.com>, <andy@greyhouse.net>,
        <davem@davemloft.net>, <jiri@resnulli.us>,
        <jay.vosburgh@canonical.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] team: Add vlan tx offload to hw_enc_features
Date:   Wed, 7 Aug 2019 10:38:08 +0800
Message-ID: <20190807023808.51976-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should also enable bonding's vlan tx offload in hw_enc_features,
pass the vlan packets to the slave devices with vlan tci, let them
to handle vlan tunneling offload implementation.

Fixes: 3268e5cb494d ("team: Advertise tunneling offload features")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/team/team.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index abfa0da..e8089de 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -1004,6 +1004,8 @@ static void __team_compute_features(struct team *team)
 
 	team->dev->vlan_features = vlan_features;
 	team->dev->hw_enc_features = enc_features | NETIF_F_GSO_ENCAP_ALL |
+				     NETIF_F_HW_VLAN_CTAG_TX |
+				     NETIF_F_HW_VLAN_STAG_TX |
 				     NETIF_F_GSO_UDP_L4;
 	team->dev->hard_header_len = max_hard_header_len;
 
-- 
2.7.4


