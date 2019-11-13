Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0D6C17448
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAE862245A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573610250;
	bh=ZbNF/HOQmAyS7qUPtr8/B5e3AqtF1X/+pA8iO8KsUvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HC7RdqvUBfLh8qEKzIj80nF5x94n0TT8goaAI1pjp7sfltjP8+GW7aT2fPNGI/lsX
	 IRE9Fgjzd++1neaQVRfTrLE4QH+dSoO6oUQ7SLPRBRmcSLOwdRbILOu3bhjMvJa1pN
	 8zoueEyHHnv73ZRySNfOwK7WRPT53XcmonGxWAb4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729826AbfKMB53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 20:57:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:50624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729782AbfKMB5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:57:25 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 845B4222CF;
        Wed, 13 Nov 2019 01:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573610245;
        bh=ZbNF/HOQmAyS7qUPtr8/B5e3AqtF1X/+pA8iO8KsUvY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M6pdmhnoheEkdMLfBMWFWh3jDKr7wA1ZctEMvaQED0cwTZ95HXJd8a8AEVmN54u6z
         CaQHPkarmvDsoF8Ods18C/4Amo1VQnXJQEw+CMm5K78H0x1bEp+/l1TQ4Hm6BrO15j
         POWbWXONvYGbgs7zu4tYnK7W1FWP5LVUhG3OQ6d8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Radoslaw Tyl <radoslawx.tyl@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 044/115] ixgbe: Fix crash with VFs and flow director on interface flap
Date:   Tue, 12 Nov 2019 20:55:11 -0500
Message-Id: <20191113015622.11592-44-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015622.11592-1-sashal@kernel.org>
References: <20191113015622.11592-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Radoslaw Tyl <radoslawx.tyl@intel.com>

[ Upstream commit 5d826d209164b0752c883607be4cdbbcf7cab494 ]

This patch fix crash when we have restore flow director filters after reset
adapter. In ixgbe_fdir_filter_restore() filter->action is outside of the
rx_ring array, as it has a VF identifier in the upper 32 bits.

Signed-off-by: Radoslaw Tyl <radoslawx.tyl@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index d1472727ef882..4801d96c4fa91 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -5129,6 +5129,7 @@ static void ixgbe_fdir_filter_restore(struct ixgbe_adapter *adapter)
 	struct ixgbe_hw *hw = &adapter->hw;
 	struct hlist_node *node2;
 	struct ixgbe_fdir_filter *filter;
+	u64 action;
 
 	spin_lock(&adapter->fdir_perfect_lock);
 
@@ -5137,12 +5138,17 @@ static void ixgbe_fdir_filter_restore(struct ixgbe_adapter *adapter)
 
 	hlist_for_each_entry_safe(filter, node2,
 				  &adapter->fdir_filter_list, fdir_node) {
+		action = filter->action;
+		if (action != IXGBE_FDIR_DROP_QUEUE && action != 0)
+			action =
+			(action >> ETHTOOL_RX_FLOW_SPEC_RING_VF_OFF) - 1;
+
 		ixgbe_fdir_write_perfect_filter_82599(hw,
 				&filter->filter,
 				filter->sw_idx,
-				(filter->action == IXGBE_FDIR_DROP_QUEUE) ?
+				(action == IXGBE_FDIR_DROP_QUEUE) ?
 				IXGBE_FDIR_DROP_QUEUE :
-				adapter->rx_ring[filter->action]->reg_idx);
+				adapter->rx_ring[action]->reg_idx);
 	}
 
 	spin_unlock(&adapter->fdir_perfect_lock);
-- 
2.20.1

