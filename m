Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB841C32751
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 717AD2067D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565010432;
	bh=fEYuSV/F6Tk531Y+E5CEhoOWgFZOxHEEEMG54SyEPDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HShI6WefIStILnH2CiQenCmve614jK09lh+I43qJE6G7DMBNgxEhA0ar4WjHm3POc
	 knrTtwuChbFXLYwKPnvcpOpUfqFDAj3JHJYG2UpgXX8Q8N+kXn7QqkolEgTwb29y3M
	 9yFvxIlETXaiJ6VJla3vb9JqRQTJvMVtRE6oNp+A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729758AbfHENHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 09:07:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728468AbfHENHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:07:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D56AE2075B;
        Mon,  5 Aug 2019 13:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565010425;
        bh=fEYuSV/F6Tk531Y+E5CEhoOWgFZOxHEEEMG54SyEPDs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n97k+AiN6LIQR9Hb4CxGiTfrppl3uWhdO4FbdedTiFnzHD4YxLc4b86L+nDUrSLV6
         ly6pw2jSYCgNGoSZrv3rd6LtOYoEpQoKe22+SMUZoMNrGkElS1JZYXu8Q5q4+3MjUW
         eTdzxNStKKxhEOc8AzKkRM58kVoIgrkhjg8LFVzM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Benjamin Poirier <bpoirier@suse.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 19/53] be2net: Signal that the device cannot transmit during reconfiguration
Date:   Mon,  5 Aug 2019 15:02:44 +0200
Message-Id: <20190805124930.241063403@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190805124927.973499541@linuxfoundation.org>
References: <20190805124927.973499541@linuxfoundation.org>
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
index 39f399741647f..cabeb1790db76 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -4600,8 +4600,12 @@ int be_update_queues(struct be_adapter *adapter)
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



