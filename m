Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC64C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D33E92147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413371;
	bh=nQOUdwdAk69hdFflZvnSvJe01/S9R+aquBYJTR95SaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uc8pqtOYDCMZuhG17d5MFvth0C/FhMx8AQcIQdgKLJWNAhpUpN1lXRQatVJ2RtPDN
	 rKcGYyp6ZYmQuN2jwGdo+TjNyTlfaDCaLcTzNRigCUzNA9+kkitlz3CxSo1a9LW8ej
	 lG40uVAc4KfPKsKh5HCgBs4FtpVGDvu8vhneDMq4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbfCLR4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:56:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:51848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727882AbfCLRN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:13:58 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DD1D2173C;
        Tue, 12 Mar 2019 17:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410837;
        bh=nQOUdwdAk69hdFflZvnSvJe01/S9R+aquBYJTR95SaU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1Hqxddx+SnSgC22UF5uQ1z1wyg+3YplUIniv7ZDOECQgOTOdvhgoGlPM5XVoAgAlg
         XSReJmXQHLKG64GwNOQlqGarOyTISHG9qnFtv2N8M40fELxzFrVYajpCOMLm40dRJN
         8qcDrgxMytvFb6wtio4sKp0Fm/041yVRYw2cOFQ4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yonglong Liu <liuyonglong@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 027/149] net: hns: Restart autoneg need return failed when autoneg off
Date:   Tue, 12 Mar 2019 10:07:25 -0700
Message-Id: <20190312170351.991777693@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170349.421581206@linuxfoundation.org>
References: <20190312170349.421581206@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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



