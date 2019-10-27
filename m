Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2748CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A47C421726
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572210175;
	bh=IsBStTCkeWmqdWA0ZgIgVTI6Qu3UtzZL3iN49SUkrIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bUBSMVmX4PtmcNTBU0wVUEIFcoVxY5m7Z0eWsdJTJaShNOHtIsiL0w7qYWqA+PbMJ
	 XxEtXnMLkJmomw4jAypuQ623bIprv6evAu0kL2/EcqmwEQBvNou3Ua0vqQG3ie8Ea8
	 ZzaoG8HrSOsgYebTKEfK/WFe3ap5zQJ0Pbg8KFGY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbfJ0VCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:02:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:47890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728139AbfJ0VCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:02:48 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1729D2064A;
        Sun, 27 Oct 2019 21:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572210166;
        bh=IsBStTCkeWmqdWA0ZgIgVTI6Qu3UtzZL3iN49SUkrIM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CNU8yWwaYZbwr0ZLewIURVpTPm/4AXUkvt60lnS0y9wMKKZZi/xtCXcmsToCL+c5D
         FFql6RXknx6t2Ca+i7S8BcbBNiz1oyELwFpMXcgfezzbTyx1AtaZxTuKHuPtNyiosr
         qK2TJdCCu3FBsMWxi8LZ6aIqDdQ4rin+CUuJ34oM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Doug Berger <opendmb@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 14/41] net: bcmgenet: Set phydev->dev_flags only for internal PHYs
Date:   Sun, 27 Oct 2019 22:00:52 +0100
Message-Id: <20191027203111.748185407@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203056.220821342@linuxfoundation.org>
References: <20191027203056.220821342@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit 92696286f3bb37ba50e4bd8d1beb24afb759a799 ]

phydev->dev_flags is entirely dependent on the PHY device driver which
is going to be used, setting the internal GENET PHY revision in those
bits only makes sense when drivers/net/phy/bcm7xxx.c is the PHY driver
being used.

Fixes: 487320c54143 ("net: bcmgenet: communicate integrated PHY revision to PHY driver")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Acked-by: Doug Berger <opendmb@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/genet/bcmmii.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -346,11 +346,12 @@ int bcmgenet_mii_probe(struct net_device
 	struct bcmgenet_priv *priv = netdev_priv(dev);
 	struct device_node *dn = priv->pdev->dev.of_node;
 	struct phy_device *phydev;
-	u32 phy_flags;
+	u32 phy_flags = 0;
 	int ret;
 
 	/* Communicate the integrated PHY revision */
-	phy_flags = priv->gphy_rev;
+	if (priv->internal_phy)
+		phy_flags = priv->gphy_rev;
 
 	/* Initialize link state variables that bcmgenet_mii_setup() uses */
 	priv->old_link = -1;


