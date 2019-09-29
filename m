Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701DBC4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 14:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4556021906
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 14:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569765674;
	bh=Zhqt+ijLdkbbOgVShEyuhIXfz7EmFYOouXSeyX7XA3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GcU8kaOggm/qycOD2SqzdrFno+d348rLjCyim9cuzwj0g+ZSlE1ipmxNeem0uPFhR
	 Zwa2mCg4ZeaNNrX6v0P5FqENEpke4Cm3R+tlsE4dUq3pPoQfXrJVvZqpt24Gch3x4I
	 ryhnteCo/HvhOS7bo79BGo0fnGA5ktu1vLnRx1YQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbfI2OBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 10:01:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:43326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729975AbfI2OBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 10:01:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA990218DE;
        Sun, 29 Sep 2019 14:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569765670;
        bh=Zhqt+ijLdkbbOgVShEyuhIXfz7EmFYOouXSeyX7XA3c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=je4IbyuiDYUea4mreWGyERf7cLAOWaNLlycV8MpiaSNcCgq1Li4QtjYZUSyQiQkBY
         VyBMa3f40yFz6VLOSzY+3wGUNm9rlv9gQyJu4bkCOz/Fv6Q6SaQ5n0sDBbC7NaTY31
         vrv7noM2HCLQziq5eyhINCkEGR2l8iRcp7/Ab8qM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Yonglong Liu <liuyonglong@huawei.com>
Subject: [PATCH 5.2 11/45] Revert "net: hns: fix LED configuration for marvell phy"
Date:   Sun, 29 Sep 2019 15:55:39 +0200
Message-Id: <20190929135027.883053256@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190929135024.387033930@linuxfoundation.org>
References: <20190929135024.387033930@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David S. Miller <davem@davemloft.net>

commit b3e487c0cf425369a48049251af75593a5652dc1 upstream.

This reverts commit f4e5f775db5a4631300dccd0de5eafb50a77c131.

Andrew Lunn says this should be handled another way.

Signed-off-by: David S. Miller <davem@davemloft.net>
Cc: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/hisilicon/hns/hns_enet.c |   23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
@@ -11,7 +11,6 @@
 #include <linux/io.h>
 #include <linux/ip.h>
 #include <linux/ipv6.h>
-#include <linux/marvell_phy.h>
 #include <linux/module.h>
 #include <linux/phy.h>
 #include <linux/platform_device.h>
@@ -1150,13 +1149,6 @@ static void hns_nic_adjust_link(struct n
 	}
 }
 
-static int hns_phy_marvell_fixup(struct phy_device *phydev)
-{
-	phydev->dev_flags |= MARVELL_PHY_LED0_LINK_LED1_ACTIVE;
-
-	return 0;
-}
-
 /**
  *hns_nic_init_phy - init phy
  *@ndev: net device
@@ -1182,16 +1174,6 @@ int hns_nic_init_phy(struct net_device *
 	if (h->phy_if != PHY_INTERFACE_MODE_XGMII) {
 		phy_dev->dev_flags = 0;
 
-		/* register the PHY fixup (for Marvell 88E1510) */
-		ret = phy_register_fixup_for_uid(MARVELL_PHY_ID_88E1510,
-						 MARVELL_PHY_ID_MASK,
-						 hns_phy_marvell_fixup);
-		/* we can live without it, so just issue a warning */
-		if (ret)
-			netdev_warn(ndev,
-				    "Cannot register PHY fixup, ret=%d\n",
-				    ret);
-
 		ret = phy_connect_direct(ndev, phy_dev, hns_nic_adjust_link,
 					 h->phy_if);
 	} else {
@@ -2447,11 +2429,8 @@ static int hns_nic_dev_remove(struct pla
 		hns_nic_uninit_ring_data(priv);
 	priv->ring_data = NULL;
 
-	if (ndev->phydev) {
-		phy_unregister_fixup_for_uid(MARVELL_PHY_ID_88E1510,
-					     MARVELL_PHY_ID_MASK);
+	if (ndev->phydev)
 		phy_disconnect(ndev->phydev);
-	}
 
 	if (!IS_ERR_OR_NULL(priv->ae_handle))
 		hnae_put_handle(priv->ae_handle);


