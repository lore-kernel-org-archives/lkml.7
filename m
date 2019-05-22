Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C474C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 20:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 177982089E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 20:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558555408;
	bh=idBNmJyCcOWF+hYiiCxlIFLuk87I9x07+aCyWP6EuiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0nfcXL04yUNFcQzv4mqLTbRqa3kKHHg+XsJLW6rRhqQChEaaC8ubtCgnDzp/bya3W
	 XR9xK+viEq7+QX7H2KrWJ4glS78sTuj2Lde6USjS0R6XM3wfVvEUr9f7AFlAfJUHLh
	 dxcDi1Y2vUx0KiO3yBGkxlrnSevhCRiQcqCFQL6U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731587AbfEVUD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 16:03:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:42254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730020AbfEVTVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:21:39 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A43B21473;
        Wed, 22 May 2019 19:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558552899;
        bh=idBNmJyCcOWF+hYiiCxlIFLuk87I9x07+aCyWP6EuiA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MRi6ACFUa6BhWMDJGy66jG25P0NGxegYayl8rHkPUEz1kp/meTryiLWkowE18ncj2
         TqtMHLtnlKERknQFd6g0jOe9Z2tYaI+M092mPbvxkbwpdYdNGUVTMWbpjm+BhL1C4L
         Evcjiw3kZWL8uOCbqPfqXNa6R5lE+0WlREh14vIA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tony Nguyen <anthony.l.nguyen@intel.com>,
        Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 017/375] ice: Separate if conditions for ice_set_features()
Date:   Wed, 22 May 2019 15:15:17 -0400
Message-Id: <20190522192115.22666-17-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522192115.22666-1-sashal@kernel.org>
References: <20190522192115.22666-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Nguyen <anthony.l.nguyen@intel.com>

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

