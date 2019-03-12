Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46616C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 051B0205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552414202;
	bh=jN45d+dQiiwXoTJQ2S7EGXD8rkxxC81GntU3relK228=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KT+N0guAFt5cW/SEDTeQLPrCKYk8m834EFHWoHG4JzNyKlJrwtA8fMgQitKjWQDPG
	 cmfti7QeHt/xJOVaa5z9LLXTU5rtMgESWJmqbVYty8qlpRUybsfoIcXeOhK9HjDqxr
	 D9o4DMRuQTW3DCFNu8wQR6reAHOBlb9esn9PdOHE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbfCLSKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:10:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:46232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727226AbfCLRL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:11:58 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E511A214AE;
        Tue, 12 Mar 2019 17:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410718;
        bh=jN45d+dQiiwXoTJQ2S7EGXD8rkxxC81GntU3relK228=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qgp9yaZB2X0+qp/0G56pvJjAs+eF5GqB1cXZAus9nfQuwN5aBZNDS9jUdtglZ85YH
         kOhQEm3uRELNh6Z1jW9lLJlX3JWK5xK9k9J0CxaddTqUrEI+ERijusrqClMOHho6Lb
         2DD124XmqAT6PphFOtZP9WAo91xDTObDuA/37k2c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yonglong Liu <liuyonglong@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 033/171] net: hns: Restart autoneg need return failed when autoneg off
Date:   Tue, 12 Mar 2019 10:06:53 -0700
Message-Id: <20190312170350.886109893@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
index 774beda040a1..e2710ff48fb0 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
@@ -1157,16 +1157,18 @@ static int hns_get_regs_len(struct net_device *net_dev)
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



