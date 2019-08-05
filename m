Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5E8C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13E832087B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565011413;
	bh=slPhW+cS7Y86XUp7U1zQP7EBHHao90W69mRJF/7wRxQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BZCWoWWuQS3+Xw7edookEM2RFN2B6yhtVNopFAzsukpy8duLQpBfZe6we7PZwdOev
	 8T44jk8fkQ3HAu5dDVi6/qYnLWee8CrMAD6qRqcTVU11lJjyB9stOms/m4xRcIclAP
	 PdDIXBpFYoYeNJ+VIqrhp6PwZvP0Tc29dy7O5Y6Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730846AbfHENXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 09:23:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:60126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730595AbfHENXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:23:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DCC420880;
        Mon,  5 Aug 2019 13:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565011409;
        bh=slPhW+cS7Y86XUp7U1zQP7EBHHao90W69mRJF/7wRxQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aCL8OmOj3hBu3yjWhFakNzjB0oW3Wj5cPrD3BtC25jYQYCwEo7pTEeVlq6qmSaP7Y
         9K8g3Vv4FC8DUkyvDvgCUnZyXh4C52ZlphbdiN/vvFRQ+r6cvVCYjBkrP0ndmiHRrM
         /ITDTZclyXEUHQ1pPCTRFongi+86b3ExWeCZQPp0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Benjamin Poirier <bpoirier@suse.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 046/131] be2net: Signal that the device cannot transmit during reconfiguration
Date:   Mon,  5 Aug 2019 15:02:13 +0200
Message-Id: <20190805124954.519140959@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190805124951.453337465@linuxfoundation.org>
References: <20190805124951.453337465@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 82015c8a5ed73..b7a246b335990 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -4697,8 +4697,12 @@ int be_update_queues(struct be_adapter *adapter)
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



