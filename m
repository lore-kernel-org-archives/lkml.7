Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD5BC4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E75420693
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567947350;
	bh=t8vTz3bm7817MJk+R8f5YXtg/XCw3/+FCCFUyKitszE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CP6MZ7RbxLnM5flbcsTB40asPDH5yWnEbZU0fGvt6wHGJp8tB0eBOpAhpux/imETn
	 ZGV/MEHG3jlEYO9e/n4lxldq1uj6i8zO5P1wOd9/Pv7sTiqBFzz7rWQNKPtVyBv6Va
	 Z/RXZHjeTppovdQjfNCTBywik9oOa8Go0Qejat3Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732181AbfIHMug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 08:50:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:41332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732119AbfIHMu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 08:50:28 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3E752190F;
        Sun,  8 Sep 2019 12:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567947027;
        bh=t8vTz3bm7817MJk+R8f5YXtg/XCw3/+FCCFUyKitszE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SCvxVucCCWczsMl/hPhqMkeKhphExrOsuqT8oHI1suNXuJYHIRtcp+M2s+DwPf2p7
         AnoMs9A1K7gI1iPCmB8NXT7EMcJIFjtduE5CNiM4M0PfkxCDq3hZo37xCg3hd8+U5+
         CLG96OcY2eAY6RFWRttKjEBzarBet57nKdSw2yY8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Taehee Yoo <ap420073@gmail.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 33/94] ixgbe: fix possible deadlock in ixgbe_service_task()
Date:   Sun,  8 Sep 2019 13:41:29 +0100
Message-Id: <20190908121151.386928027@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190908121150.420989666@linuxfoundation.org>
References: <20190908121150.420989666@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 8b6381600d59871fbe44d36522272f961ab42410 ]

ixgbe_service_task() calls unregister_netdev() under rtnl_lock().
But unregister_netdev() internally calls rtnl_lock().
So deadlock would occur.

Fixes: 59dd45d550c5 ("ixgbe: firmware recovery mode")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 57fd9ee6de665..f7c049559c1a5 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -7893,11 +7893,8 @@ static void ixgbe_service_task(struct work_struct *work)
 		return;
 	}
 	if (ixgbe_check_fw_error(adapter)) {
-		if (!test_bit(__IXGBE_DOWN, &adapter->state)) {
-			rtnl_lock();
+		if (!test_bit(__IXGBE_DOWN, &adapter->state))
 			unregister_netdev(adapter->netdev);
-			rtnl_unlock();
-		}
 		ixgbe_service_event_complete(adapter);
 		return;
 	}
-- 
2.20.1



