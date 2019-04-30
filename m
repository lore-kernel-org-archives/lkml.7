Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F81DC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8EC021734
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556624881;
	bh=yge4E7KebFg2Quye//YHCc98uYDAOoFCwRnlY9Uh2dw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oKKidspIrBD7/4YqWdSsj0qt99vzwAFefCASvt9e5u/PFP0GW2eE+CJDwBLuLEF+b
	 x3CxI3Z2SbF5e1lDhK/Q/CWPebFNkRCnibEa13Jg6lPG/Tsjrvc5Oc2vopnxOKCYiV
	 uSEBAoza2nzZUeXYkfkh1+uK65nE6WPMNGEGNnrI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730781AbfD3LsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:48:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:33752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730772AbfD3Lr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:47:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2510E2054F;
        Tue, 30 Apr 2019 11:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556624875;
        bh=yge4E7KebFg2Quye//YHCc98uYDAOoFCwRnlY9Uh2dw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=htdQ6KY5tN52tz+9B6MQ2wb61xNYIqiZz+uxWAb7Vz3a1+fvndfEPrLAaZyH0YnMr
         opofe0DO+Y1onQO/yEvG86jj8tYGZgLXUNLODMh4MOey3gy5niCJ3HNkWk50V4qDfz
         rlFknkB9FxrZtRDdbKzweHonLTbmp9zREr3Zy/MA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yonglong Liu <liuyonglong@huawei.com>,
        Jun Xiao <xiaojun2@hisilicon.com>
Subject: [PATCH 4.19 094/100] net: hns: Fix WARNING when hns modules installed
Date:   Tue, 30 Apr 2019 13:39:03 +0200
Message-Id: <20190430113613.268465382@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190430113608.616903219@linuxfoundation.org>
References: <20190430113608.616903219@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jun Xiao <xiaojun2@hisilicon.com>

Commit dfdf26babc98 upstream

this patch need merge to 4.19.y stable kernel

Fix Conflict:already fixed the confilct dfdf26babc98 with Yonglong Liu

stable candidate:user cannot connect to the internet via hns dev
by default setting without this patch

we have already verified this patch on kunpeng916 platform,
and it works well.

Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Jun Xiao <xiaojun2@hisilicon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/hisilicon/hns/hns_enet.c |   15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
@@ -1169,6 +1169,12 @@ int hns_nic_init_phy(struct net_device *
 	if (!h->phy_dev)
 		return 0;
 
+	phy_dev->supported &= h->if_support;
+	phy_dev->advertising = phy_dev->supported;
+
+	if (h->phy_if == PHY_INTERFACE_MODE_XGMII)
+		phy_dev->autoneg = false;
+
 	if (h->phy_if != PHY_INTERFACE_MODE_XGMII) {
 		phy_dev->dev_flags = 0;
 
@@ -1180,15 +1186,6 @@ int hns_nic_init_phy(struct net_device *
 	if (unlikely(ret))
 		return -ENODEV;
 
-	phy_dev->supported &= h->if_support;
-	phy_dev->advertising = phy_dev->supported;
-
-	if (h->phy_if == PHY_INTERFACE_MODE_XGMII)
-		phy_dev->autoneg = false;
-
-	if (h->phy_if == PHY_INTERFACE_MODE_SGMII)
-		phy_stop(phy_dev);
-
 	return 0;
 }
 


