Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DE9C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C7C24482
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559185821;
	bh=MbN0Gjltzp8CmPfQZSiyn81eybuXFk4Chh1qol6L8EA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JAQT+u8hJ9VXMyNJ/4Pu1jRv0X5DzzkMGX6ClrevbbX9WJ4az6DAJwnLdaUg7Gq0T
	 Ecu6KX62HIWgNtZ0K2w2gI4BUvq96lYUuWCAz4BtlRL8MrYlkAG8vA88rC9DPxe3Jd
	 1iKOmdF9L9BLipnlk5quJ6J0y6DjUnA9Mj+xXseE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbfE3DKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:10:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:45426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727793AbfE3DJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:09:50 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1185724490;
        Thu, 30 May 2019 03:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185789;
        bh=MbN0Gjltzp8CmPfQZSiyn81eybuXFk4Chh1qol6L8EA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VN3EsqZGMcoHS8wMucaPZ14hNNQ5A9lSxaRPypU8nI0hc0yNrAMn6zNw+U7e8Ad/3
         KnHRIN03ieZrwI9y3DQL9CDEr8la1AOykvbRGPlF9BLRfbo3vRdrXVZRrA1VIlDmiY
         BeoHvayGop1L5gHbBzuCpw6Y5nJh0GbF9dXA2poo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
        Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 059/405] ice: Separate if conditions for ice_set_features()
Date:   Wed, 29 May 2019 20:00:57 -0700
Message-Id: <20190530030543.931314010@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 8f529ff912073f778e3cd74e87fb69a36499fc2f ]

Set features can have multiple features turned on|off in a single
call.  Grouping these all in an if/else means after one condition
is met, other conditions/features will not be evaluated.  Break
the if/else statements by feature to ensure all features will be
handled properly.

Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 47cc3f905b7ff..ac30288720f71 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2545,6 +2545,9 @@ static int ice_set_features(struct net_device *netdev,
 	struct ice_vsi *vsi = np->vsi;
 	int ret = 0;
 
+	/* Multiple features can be changed in one call so keep features in
+	 * separate if/else statements to guarantee each feature is checked
+	 */
 	if (features & NETIF_F_RXHASH && !(netdev->features & NETIF_F_RXHASH))
 		ret = ice_vsi_manage_rss_lut(vsi, true);
 	else if (!(features & NETIF_F_RXHASH) &&
@@ -2557,8 +2560,9 @@ static int ice_set_features(struct net_device *netdev,
 	else if (!(features & NETIF_F_HW_VLAN_CTAG_RX) &&
 		 (netdev->features & NETIF_F_HW_VLAN_CTAG_RX))
 		ret = ice_vsi_manage_vlan_stripping(vsi, false);
-	else if ((features & NETIF_F_HW_VLAN_CTAG_TX) &&
-		 !(netdev->features & NETIF_F_HW_VLAN_CTAG_TX))
+
+	if ((features & NETIF_F_HW_VLAN_CTAG_TX) &&
+	    !(netdev->features & NETIF_F_HW_VLAN_CTAG_TX))
 		ret = ice_vsi_manage_vlan_insertion(vsi);
 	else if (!(features & NETIF_F_HW_VLAN_CTAG_TX) &&
 		 (netdev->features & NETIF_F_HW_VLAN_CTAG_TX))
-- 
2.20.1



