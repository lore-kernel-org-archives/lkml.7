Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D999FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0E8E218AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552411052;
	bh=j9MS3CBbMyplD2+Mz90uoi3jgbTzQXgQJIeM5Ft355A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Vi5JDzmP4QtR0RfqixKsotohfXpFyHb/15EAwmoGjGYW9EznwUdZB+35OMFRNt6MD
	 2gPlGgo15qHIaaWnsq3KkWSh74PDMiShL1YZuvx5FZNgiMR70tcZ4wn1GG2kckUnbl
	 HGUjrDQtT9sWbUk7zu4tQrc4sRPDFed7no59IWD0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729641AbfCLRRb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:17:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:58374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729109AbfCLRQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:16:23 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2C36206DF;
        Tue, 12 Mar 2019 17:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410982;
        bh=j9MS3CBbMyplD2+Mz90uoi3jgbTzQXgQJIeM5Ft355A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mBv8Pjr/c2Ko76w4sQjrcn5FT/P5kKAk/wbxSEM1RlV0oh3a+TkOV4R+UOLaPi0I9
         vE1Or8NgrVcAN2ePjkaUR4WhT0B6RYJSVLfSPbkxD4igwpljadDcUpXBSoZjPQ6DoS
         jGNILv2tXhODS2Yl35Ulbt1zRjep0QsPOZi8ER+8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yonglong Liu <liuyonglong@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 060/135] net: hns: Restart autoneg need return failed when autoneg off
Date:   Tue, 12 Mar 2019 10:08:27 -0700
Message-Id: <20190312170346.831849010@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170341.127810985@linuxfoundation.org>
References: <20190312170341.127810985@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit ed29ca8b9592562559c64d027fb5eb126e463e2c ]

The hns driver of earlier devices, when autoneg off, restart autoneg
will return -EINVAL, so make the hns driver for the latest devices
do the same.

Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c b/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
index c1e947bb852f..14df03f60e05 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
@@ -1154,16 +1154,18 @@ static int hns_get_regs_len(struct net_device *net_dev)
  */
 static int hns_nic_nway_reset(struct net_device *netdev)
 {
-	int ret = 0;
 	struct phy_device *phy = netdev->phydev;
 
-	if (netif_running(netdev)) {
-		/* if autoneg is disabled, don't restart auto-negotiation */
-		if (phy && phy->autoneg == AUTONEG_ENABLE)
-			ret = genphy_restart_aneg(phy);
-	}
+	if (!netif_running(netdev))
+		return 0;
 
-	return ret;
+	if (!phy)
+		return -EOPNOTSUPP;
+
+	if (phy->autoneg != AUTONEG_ENABLE)
+		return -EINVAL;
+
+	return genphy_restart_aneg(phy);
 }
 
 static u32
-- 
2.19.1



