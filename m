Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C44C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2A4E2171F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552504578;
	bh=58iUumzmoTJ8TlNNB/2hbFfrCu7t1bhNWB71brZope0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aJnY62xNPfCGQMM11TEQhQAZdevyDiYVx9qF6AkkJlCmkcH7KVbcaU/3W97vGRdun
	 /jH1Lqss1IuuyG8iCb7KJUCn+Kx8sYLiq9MxLvqfvR0EwKHIBRPrv37fAG+o3+8Vfa
	 0Z0uQ5JnNynVGYL2+W4NUFbxbNu6FdF6CfFLZ8oo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbfCMTQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:16:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:46556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727124AbfCMTQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:16:13 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 433472075C;
        Wed, 13 Mar 2019 19:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504572;
        bh=58iUumzmoTJ8TlNNB/2hbFfrCu7t1bhNWB71brZope0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jscYBoK0mqvnuVRMQLQCTtfDsA9JwH4JdhlYsWyiSER2m2kmar90C2AnyNUZ/eSDW
         FF/LK2gp5fBHDEd5u3AYKL7qs/6ajKtJOu9/48hQl18WSVowP55R4BVIgkrOJX4Xuk
         v+ADLP1L3NKHh5vj0UlUm+IFTFFF4ksRjR0MyeN4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 23/33] ixgbe: fix older devices that do not support IXGBE_MRQC_L3L4TXSWEN
Date:   Wed, 13 Mar 2019 15:14:56 -0400
Message-Id: <20190313191506.159677-23-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191506.159677-1-sashal@kernel.org>
References: <20190313191506.159677-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

[ Upstream commit 156a67a9065e3339be85f811d1b13b920e50d73b ]

The enabling L3/L4 filtering for transmit switched packets for all
devices caused unforeseen issue on older devices when trying to send UDP
traffic in an ordered sequence.  This bit was originally intended for X550
devices, which supported this feature, so limit the scope of this bit to
only X550 devices.

Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 42183a8b649c..01c120d656c5 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -3827,8 +3827,11 @@ static void ixgbe_setup_mrqc(struct ixgbe_adapter *adapter)
 			else
 				mrqc = IXGBE_MRQC_VMDQRSS64EN;
 
-			/* Enable L3/L4 for Tx Switched packets */
-			mrqc |= IXGBE_MRQC_L3L4TXSWEN;
+			/* Enable L3/L4 for Tx Switched packets only for X550,
+			 * older devices do not support this feature
+			 */
+			if (hw->mac.type >= ixgbe_mac_X550)
+				mrqc |= IXGBE_MRQC_L3L4TXSWEN;
 		} else {
 			if (tcs > 4)
 				mrqc = IXGBE_MRQC_RTRSS8TCEN;
-- 
2.19.1

