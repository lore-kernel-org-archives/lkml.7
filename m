Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7759DC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4441A22CEC
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564148757;
	bh=T+1JGxTwv5cgA4sBxreOfkkpahMOxT2F7QFlv3KlCAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w+gJC44OneJ6SAGf72gvjgS9wdClMvA9j0P9kaqKMq9ioljsbx9ZpXzsniA14irhT
	 2O6rsThCz6VXSyayWo54aM0k522Ep2Qhels4Spoykv/Rv/AbZ1btAgtswTfgUTQFO+
	 3foWl7nZ40JK4HOHR0Iz0+Jtj0JndmgzwADhD0C4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388600AbfGZNp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:45:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:55026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387482AbfGZNps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:45:48 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE4F222CF4;
        Fri, 26 Jul 2019 13:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564148747;
        bh=T+1JGxTwv5cgA4sBxreOfkkpahMOxT2F7QFlv3KlCAQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fF1N/XANpGkEgTFs3MGpnqUEBDwrfSlqJfneitr567Hc1keL4SuQuzr8uMq08O56W
         eed76A4+psadofCEhZe8gM5IZFO4lo/hnqYfgx5TcCOTNhz6z0VYzhqzxiGalPy9k5
         TJirIyCtW2PgqAE3uI7G5ZLzTUNQFqhwk8AfZSPE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Benjamin Poirier <bpoirier@suse.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 12/23] be2net: Signal that the device cannot transmit during reconfiguration
Date:   Fri, 26 Jul 2019 09:45:11 -0400
Message-Id: <20190726134522.13308-12-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726134522.13308-1-sashal@kernel.org>
References: <20190726134522.13308-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Poirier <bpoirier@suse.com>

[ Upstream commit 7429c6c0d9cb086d8e79f0d2a48ae14851d2115e ]

While changing the number of interrupt channels, be2net stops adapter
operation (including netif_tx_disable()) but it doesn't signal that it
cannot transmit. This may lead dev_watchdog() to falsely trigger during
that time.

Add the missing call to netif_carrier_off(), following the pattern used in
many other drivers. netif_carrier_on() is already taken care of in
be_open().

Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/emulex/benet/be_main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index 26255862d1cf..7524a33b7032 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -4307,8 +4307,12 @@ int be_update_queues(struct be_adapter *adapter)
 	struct net_device *netdev = adapter->netdev;
 	int status;
 
-	if (netif_running(netdev))
+	if (netif_running(netdev)) {
+		/* device cannot transmit now, avoid dev_watchdog timeouts */
+		netif_carrier_off(netdev);
+
 		be_close(netdev);
+	}
 
 	be_cancel_worker(adapter);
 
-- 
2.20.1

