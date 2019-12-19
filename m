Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BDBC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 01:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F19FD218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 01:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfLSBhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 20:37:01 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:58530 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726463AbfLSBhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 20:37:01 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8CAE8E6E34F961F4045C;
        Thu, 19 Dec 2019 09:36:58 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Thu, 19 Dec 2019 09:36:48 +0800
From:   Mao Wenan <maowenan@huawei.com>
To:     <davem@davemloft.net>, <maowenan@huawei.com>,
        <edumazet@google.com>, <willemb@google.com>,
        <maximmi@mellanox.com>, <pabeni@redhat.com>,
        <yuehaibing@huawei.com>, <nhorman@tuxdriver.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH net] af_packet: refactoring code for prb_calc_retire_blk_tmo
Date:   Thu, 19 Dec 2019 09:33:44 +0800
Message-ID: <20191219013344.34603-1-maowenan@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If __ethtool_get_link_ksettings() is failed and with
non-zero value, prb_calc_retire_blk_tmo() should return
DEFAULT_PRB_RETIRE_TOV firstly. Refactoring code and make
it more readable.

Fixes: b43d1f9f7067 ("af_packet: set defaule value for tmo")
Signed-off-by: Mao Wenan <maowenan@huawei.com>
---
 net/packet/af_packet.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 118cd66..843ebf8 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -520,7 +520,7 @@ static int prb_calc_retire_blk_tmo(struct packet_sock *po,
 				int blk_size_in_bytes)
 {
 	struct net_device *dev;
-	unsigned int mbits = 0, msec = 0, div = 0, tmo = 0;
+	unsigned int mbits = 0, msec = 1, div = 0, tmo = 0;
 	struct ethtool_link_ksettings ecmd;
 	int err;
 
@@ -532,21 +532,17 @@ static int prb_calc_retire_blk_tmo(struct packet_sock *po,
 	}
 	err = __ethtool_get_link_ksettings(dev, &ecmd);
 	rtnl_unlock();
-	if (!err) {
-		/*
-		 * If the link speed is so slow you don't really
-		 * need to worry about perf anyways
-		 */
-		if (ecmd.base.speed < SPEED_1000 ||
-		    ecmd.base.speed == SPEED_UNKNOWN) {
-			return DEFAULT_PRB_RETIRE_TOV;
-		} else {
-			msec = 1;
-			div = ecmd.base.speed / 1000;
-		}
-	} else
+	if (err)
+		return DEFAULT_PRB_RETIRE_TOV;
+
+	/* If the link speed is so slow you don't really
+	 * need to worry about perf anyways
+	 */
+	if (ecmd.base.speed < SPEED_1000 ||
+	    ecmd.base.speed == SPEED_UNKNOWN)
 		return DEFAULT_PRB_RETIRE_TOV;
 
+	div = ecmd.base.speed / 1000;
 	mbits = (blk_size_in_bytes * 8) / (1024 * 1024);
 
 	if (div)
@@ -555,7 +551,7 @@ static int prb_calc_retire_blk_tmo(struct packet_sock *po,
 	tmo = mbits * msec;
 
 	if (div)
-		return tmo+1;
+		return tmo + 1;
 	return tmo;
 }
 
-- 
2.7.4

