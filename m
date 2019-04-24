Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E56AC282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26FD2218FC
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556117194;
	bh=6DehphqxxPwARWBE5ME3ZUahnLAKINS4KsfVTVCj/FM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aJCzfWjK/Z4L0q2O2IpVTZHJha29HsSjMTOcnKLaodZRJpaJcKTNLNC24qKq5ytS5
	 bn/zWVDY9ldZjn5Uz060IL1745n9VBHuie+RahIc9dOWwN1+fgpBbFTt0znZedmRr1
	 zutbIpiMOOXaXLDby3dHjeURtdYTiilDXQ1/JXSs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731048AbfDXOe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:34:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:38322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730968AbfDXOeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:34:25 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3F5F218FE;
        Wed, 24 Apr 2019 14:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556116464;
        bh=6DehphqxxPwARWBE5ME3ZUahnLAKINS4KsfVTVCj/FM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rA4YtURVoLh8tU8+MQnOPDe/RMCOiTq7dCTU0iKq1pRs+3P0wAGrwtRuu/bJw0wZg
         4AieL2fiS2NpMOBOWPhRLbwrF/aEOLMPzCyo+X30noTza4oT/u+B4RtmhILWIT0t1a
         w/W6u/nYmzHVP94sQ+JxpntSU67nHHXz5UUTuHa8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stefan Assmann <sassmann@kpanic.de>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 18/66] i40e: fix WoL support check
Date:   Wed, 24 Apr 2019 10:32:52 -0400
Message-Id: <20190424143341.27665-18-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424143341.27665-1-sashal@kernel.org>
References: <20190424143341.27665-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Assmann <sassmann@kpanic.de>

[ Upstream commit f669d24f3dd00beab452c0fc9257f6a942ffca9b ]

The current check for WoL on i40e is broken. Code comment says only
magic packet is supported, so only check for that.

Fixes: 540a152da762 (i40e/ixgbe/igb: fail on new WoL flag setting WAKE_MAGICSECURE)

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index a6bc7847346b..5d544e661445 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2378,8 +2378,7 @@ static int i40e_set_wol(struct net_device *netdev, struct ethtool_wolinfo *wol)
 		return -EOPNOTSUPP;
 
 	/* only magic packet is supported */
-	if (wol->wolopts && (wol->wolopts != WAKE_MAGIC)
-			  | (wol->wolopts != WAKE_FILTER))
+	if (wol->wolopts & ~WAKE_MAGIC)
 		return -EOPNOTSUPP;
 
 	/* is this a new value? */
-- 
2.19.1

