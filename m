Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E05C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88F02205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576013065;
	bh=u/TA5nCukRHIf1eZ2xTVzBsDtu7MZr78Wrzuy7Mx6ZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1t6MxIcey6VuyOW9iM+ZSLU1EUHJWqprvWPL8O1aROPk0/yDxFtYLjwH1BKB1snBT
	 6EJlpKvhvdFsLM0F+ID3sWrFjJv5LOx5Ehitx4UnzC5OP4Ql1YryXO61BsBm6Xr5nD
	 gVk/UD2FES+xgO5ZCK+j+7SMxa+jJ23yHFh9Xl2I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbfLJVYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:24:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:32972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728627AbfLJVKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:10:53 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6ABDA24697;
        Tue, 10 Dec 2019 21:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576012253;
        bh=u/TA5nCukRHIf1eZ2xTVzBsDtu7MZr78Wrzuy7Mx6ZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N6uqnIoUhdo2MvC4LH/L9AsCV3ErqKjwIsodv5koxBrvRgkzZH+2ZUkgC/SOqiRhK
         r1tB6Ncb6HY4WbN/3Ht9lTvTpdYtlqwJeQu36BtdNNt5m3zf/+BLsZGeDyNvYZ3xTT
         nf+KytQfrBNa63JbUXRVj5kk86o7aEibkVXFo460=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Manjunath Patil <manjunath.b.patil@oracle.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 200/350] ixgbe: protect TX timestamping from API misuse
Date:   Tue, 10 Dec 2019 16:05:05 -0500
Message-Id: <20191210210735.9077-161-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210210735.9077-1-sashal@kernel.org>
References: <20191210210735.9077-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manjunath Patil <manjunath.b.patil@oracle.com>

[ Upstream commit 07066d9dc3d2326fbad8f7b0cb0120cff7b7dedb ]

HW timestamping can only be requested for a packet if the NIC is first
setup via ioctl(SIOCSHWTSTAMP). If this step was skipped, then the ixgbe
driver still allowed TX packets to request HW timestamping. In this
situation, we see 'clearing Tx Timestamp hang' noise in the log.

Fix this by checking that the NIC is configured for HW TX timestamping
before accepting a HW TX timestamping request.

Similar-to:
   commit 26bd4e2db06b ("igb: protect TX timestamping from API misuse")
   commit 0a6f2f05a2f5 ("igb: Fix a test with HWTSTAMP_TX_ON")

Signed-off-by: Manjunath Patil <manjunath.b.patil@oracle.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 91b3780ddb040..1a7203fede12c 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -8639,7 +8639,8 @@ netdev_tx_t ixgbe_xmit_frame_ring(struct sk_buff *skb,
 
 	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) &&
 	    adapter->ptp_clock) {
-		if (!test_and_set_bit_lock(__IXGBE_PTP_TX_IN_PROGRESS,
+		if (adapter->tstamp_config.tx_type == HWTSTAMP_TX_ON &&
+		    !test_and_set_bit_lock(__IXGBE_PTP_TX_IN_PROGRESS,
 					   &adapter->state)) {
 			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
 			tx_flags |= IXGBE_TX_FLAGS_TSTAMP;
-- 
2.20.1

