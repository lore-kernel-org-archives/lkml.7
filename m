Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33658C17441
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02550222CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573609927;
	bh=r8hnijHJ0SYL+qyAwyuyhR0Z1cWediu4nKfrfBcM7Z8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X6wZsKwdRII3qwIqyUf6B8ttHr7+GzeYsS7DwWOr48VLQEw2PiKPGipLQ7SIDEFBz
	 B9es5Tqj879FJ8KeMOP10f6BgQ3BzRp3CFg2Wvw53WL7AM7a4QQWb4CRbJTTYMB6j3
	 mbaX5xyeACW7qwfhSUAzSOxdF2YW72PMZgfl8rQ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbfKMBwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 20:52:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:40378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728093AbfKMBwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:52:00 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7952820674;
        Wed, 13 Nov 2019 01:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573609920;
        bh=r8hnijHJ0SYL+qyAwyuyhR0Z1cWediu4nKfrfBcM7Z8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gfjo+XwXI8EUxKXfZzQHNGqxBUUE+Wcj1PkXPC3YJ2rFzdVk4whajbR0Z1x9jJE7w
         DoVSkMyvoBuSth2/D6DEzkqZeSNC5VH3QiT0S3dE3jJZAxezA8j3PBrbjyWfl4D2ZW
         vD76y9kK0oCvSF607PBjxSIk5oSsIZN5veTV9GeU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Radoslaw Tyl <radoslawx.tyl@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 068/209] ixgbe: Fix ixgbe TX hangs with XDP_TX beyond queue limit
Date:   Tue, 12 Nov 2019 20:48:04 -0500
Message-Id: <20191113015025.9685-68-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015025.9685-1-sashal@kernel.org>
References: <20191113015025.9685-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Radoslaw Tyl <radoslawx.tyl@intel.com>

[ Upstream commit 8d7179b1e2d64b3493c0114916486fe92e6109a9 ]

We have Tx hang when number Tx and XDP queues are more than 64.
In XDP always is MTQC == 0x0 (64TxQs). We need more space for Tx queues.

Signed-off-by: Radoslaw Tyl <radoslawx.tyl@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 85280765d793d..f3e21de3b1f0b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -3582,12 +3582,18 @@ static void ixgbe_setup_mtqc(struct ixgbe_adapter *adapter)
 		else
 			mtqc |= IXGBE_MTQC_64VF;
 	} else {
-		if (tcs > 4)
+		if (tcs > 4) {
 			mtqc = IXGBE_MTQC_RT_ENA | IXGBE_MTQC_8TC_8TQ;
-		else if (tcs > 1)
+		} else if (tcs > 1) {
 			mtqc = IXGBE_MTQC_RT_ENA | IXGBE_MTQC_4TC_4TQ;
-		else
-			mtqc = IXGBE_MTQC_64Q_1PB;
+		} else {
+			u8 max_txq = adapter->num_tx_queues +
+				adapter->num_xdp_queues;
+			if (max_txq > 63)
+				mtqc = IXGBE_MTQC_RT_ENA | IXGBE_MTQC_4TC_4TQ;
+			else
+				mtqc = IXGBE_MTQC_64Q_1PB;
+		}
 	}
 
 	IXGBE_WRITE_REG(hw, IXGBE_MTQC, mtqc);
-- 
2.20.1

