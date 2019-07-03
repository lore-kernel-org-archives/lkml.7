Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE42C06511
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 02:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5711421873
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 02:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562120398;
	bh=Lw5L80tcOz518E5hRMNalGGXYCC5VJkfv3FH93/cP2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KLhwQhzqWQEH4FVWx3A6M1eXloHy4unW/O8QGK55Gz5F40b1iRQ+vL6Y1n326ZKIE
	 +x180yt1/vfT09wU2z6wop7veqq5qapNlxfocgdSrowNpt27DKg4v2oRYhCGVul+I8
	 BhpAvwdn9wy3nSC2eoQCoMHREvC42Yw+UTQ4Fm+M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbfGCCS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 22:18:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:56746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728136AbfGCCSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 22:18:53 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA16321880;
        Wed,  3 Jul 2019 02:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562120332;
        bh=Lw5L80tcOz518E5hRMNalGGXYCC5VJkfv3FH93/cP2Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=urc2+kGtSX9f8CfKXYItPCvchs+Mj1XAeeVM8jdh6/MYWUlbNPMMurzOEvNQEKVIO
         8t0zGLMDVZ/fzsXpAxX/wV6qXXBsl1aKNFhDifhd+bzPKdge+KHhjnb0MQBPCXf6V4
         QHj1pqt1pYvvZ9v8JdJUo5lslEE85p/SM+//P1cw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Petr Oros <poros@redhat.com>, Ivan Vecera <ivecera@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 3/8] be2net: fix link failure after ethtool offline test
Date:   Tue,  2 Jul 2019 22:18:42 -0400
Message-Id: <20190703021847.18542-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190703021847.18542-1-sashal@kernel.org>
References: <20190703021847.18542-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Oros <poros@redhat.com>

[ Upstream commit 2e5db6eb3c23e5dc8171eb8f6af7a97ef9fcf3a9 ]

Certain cards in conjunction with certain switches need a little more
time for link setup that results in ethtool link test failure after
offline test. Patch adds a loop that waits for a link setup finish.

Changes in v2:
- added fixes header

Fixes: 4276e47e2d1c ("be2net: Add link test to list of ethtool self tests.")
Signed-off-by: Petr Oros <poros@redhat.com>
Reviewed-by: Ivan Vecera <ivecera@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/emulex/benet/be_ethtool.c    | 28 +++++++++++++++----
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/emulex/benet/be_ethtool.c b/drivers/net/ethernet/emulex/benet/be_ethtool.c
index 345818193de9..56db37d92937 100644
--- a/drivers/net/ethernet/emulex/benet/be_ethtool.c
+++ b/drivers/net/ethernet/emulex/benet/be_ethtool.c
@@ -898,7 +898,7 @@ static void be_self_test(struct net_device *netdev, struct ethtool_test *test,
 			 u64 *data)
 {
 	struct be_adapter *adapter = netdev_priv(netdev);
-	int status;
+	int status, cnt;
 	u8 link_status = 0;
 
 	if (adapter->function_caps & BE_FUNCTION_CAPS_SUPER_NIC) {
@@ -909,6 +909,9 @@ static void be_self_test(struct net_device *netdev, struct ethtool_test *test,
 
 	memset(data, 0, sizeof(u64) * ETHTOOL_TESTS_NUM);
 
+	/* check link status before offline tests */
+	link_status = netif_carrier_ok(netdev);
+
 	if (test->flags & ETH_TEST_FL_OFFLINE) {
 		if (be_loopback_test(adapter, BE_MAC_LOOPBACK, &data[0]) != 0)
 			test->flags |= ETH_TEST_FL_FAILED;
@@ -929,13 +932,26 @@ static void be_self_test(struct net_device *netdev, struct ethtool_test *test,
 		test->flags |= ETH_TEST_FL_FAILED;
 	}
 
-	status = be_cmd_link_status_query(adapter, NULL, &link_status, 0);
-	if (status) {
-		test->flags |= ETH_TEST_FL_FAILED;
-		data[4] = -1;
-	} else if (!link_status) {
+	/* link status was down prior to test */
+	if (!link_status) {
 		test->flags |= ETH_TEST_FL_FAILED;
 		data[4] = 1;
+		return;
+	}
+
+	for (cnt = 10; cnt; cnt--) {
+		status = be_cmd_link_status_query(adapter, NULL, &link_status,
+						  0);
+		if (status) {
+			test->flags |= ETH_TEST_FL_FAILED;
+			data[4] = -1;
+			break;
+		}
+
+		if (link_status)
+			break;
+
+		msleep_interruptible(500);
 	}
 }
 
-- 
2.20.1

