Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07314C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D84BE20716
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbfLQM1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 07:27:19 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7695 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726383AbfLQM1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 07:27:19 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 868097557868119F8E09;
        Tue, 17 Dec 2019 20:27:17 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Tue, 17 Dec 2019
 20:27:10 +0800
To:     <jeffrey.t.kirsher@intel.com>, <davem@davemloft.net>,
        <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "hushiyuan@huawei.com" <hushiyuan@huawei.com>,
        "linfeilong@huawei.com" <linfeilong@huawei.com>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Subject: [PATCH] e100: remove unused varibale err in e100_diag_test()
Message-ID: <b0cf9969-bb56-2ccb-cf16-025eb700a24e@huawei.com>
Date:   Tue, 17 Dec 2019 20:26:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.251.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fix following warning:
drivers/net/ethernet/intel/e100.c: In function ‘e100_diag_test’:
drivers/net/ethernet/intel/e100.c:2600:9: warning: variable ‘err’ set
but not used [-Wunused-but-set-variable]
  int i, err;
         ^~~

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
---
 drivers/net/ethernet/intel/e100.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
index a65d5a9ba7db..f1cb493a811f 100644
--- a/drivers/net/ethernet/intel/e100.c
+++ b/drivers/net/ethernet/intel/e100.c
@@ -2597,7 +2597,7 @@ static void e100_diag_test(struct net_device *netdev,
 {
 	struct ethtool_cmd cmd;
 	struct nic *nic = netdev_priv(netdev);
-	int i, err;
+	int i;

 	memset(data, 0, E100_TEST_LEN * sizeof(u64));
 	data[0] = !mii_link_ok(&nic->mii);
@@ -2605,7 +2605,7 @@ static void e100_diag_test(struct net_device *netdev,
 	if (test->flags & ETH_TEST_FL_OFFLINE) {

 		/* save speed, duplex & autoneg settings */
-		err = mii_ethtool_gset(&nic->mii, &cmd);
+		mii_ethtool_gset(&nic->mii, &cmd);

 		if (netif_running(netdev))
 			e100_down(nic);
@@ -2614,7 +2614,7 @@ static void e100_diag_test(struct net_device *netdev,
 		data[4] = e100_loopback_test(nic, lb_phy);

 		/* restore speed, duplex & autoneg settings */
-		err = mii_ethtool_sset(&nic->mii, &cmd);
+		mii_ethtool_sset(&nic->mii, &cmd);

 		if (netif_running(netdev))
 			e100_up(nic);
-- 
2.7.4

