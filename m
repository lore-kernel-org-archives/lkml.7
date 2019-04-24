Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDCEC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA57B218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126230;
	bh=ru91uAHNXH6vOCQdT+KClw2BtfjQqRbLn5RcvRsPPeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dP3Wfl7Dg1uNF094S0/dqccnoT4Jf9HyAFEy6t3bPPYGnF1kWMdXl8LIytE/EttBt
	 moCpRH0KDwfludSVf9IGjRxX4FDM4O0hamQJYTFcJAHFLoQcC6HVFg1GWafxn5LKoA
	 hOea5gorbHKy2YC0OdBNTNqGPEPQfBE7gGtfxKoY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388557AbfDXRRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:17:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:41746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388538AbfDXRRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:17:02 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35FBF21905;
        Wed, 24 Apr 2019 17:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126221;
        bh=ru91uAHNXH6vOCQdT+KClw2BtfjQqRbLn5RcvRsPPeA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OH4eNbjEhOQquLti87bFiN30iZ+dy324AAxGuB2QWDfAi8CGJy1C977VtV2JLx20J
         jGzGPcS47UV0bvOZtvH5Gkxiwao5SC14jxYFleP4coMokyuE1HHrFQva9Y5+Wl6Cwy
         /Zl+lRQFFS4gkDY2/OtGqRVz/brJHtAUTd5Jsl2s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 033/168] e1000e: Fix -Wformat-truncation warnings
Date:   Wed, 24 Apr 2019 19:07:57 +0200
Message-Id: <20190424170925.686197565@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170923.452349382@linuxfoundation.org>
References: <20190424170923.452349382@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 135e7245479addc6b1f5d031e3d7e2ddb3d2b109 ]

Provide precision hints to snprintf() since we know the destination
buffer size of the RX/TX ring names are IFNAMSIZ + 5 - 1. This fixes the
following warnings:

drivers/net/ethernet/intel/e1000e/netdev.c: In function
'e1000_request_msix':
drivers/net/ethernet/intel/e1000e/netdev.c:2109:13: warning: 'snprintf'
output may be truncated before the last format character
[-Wformat-truncation=]
     "%s-rx-0", netdev->name);
             ^
drivers/net/ethernet/intel/e1000e/netdev.c:2107:3: note: 'snprintf'
output between 6 and 21 bytes into a destination of size 20
   snprintf(adapter->rx_ring->name,
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     sizeof(adapter->rx_ring->name) - 1,
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     "%s-rx-0", netdev->name);
     ~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/e1000e/netdev.c:2125:13: warning: 'snprintf'
output may be truncated before the last format character
[-Wformat-truncation=]
     "%s-tx-0", netdev->name);
             ^
drivers/net/ethernet/intel/e1000e/netdev.c:2123:3: note: 'snprintf'
output between 6 and 21 bytes into a destination of size 20
   snprintf(adapter->tx_ring->name,
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     sizeof(adapter->tx_ring->name) - 1,
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     "%s-tx-0", netdev->name);
     ~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 6369d88b81c1..6b1cacd86c6e 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -2131,7 +2131,7 @@ static int e1000_request_msix(struct e1000_adapter *adapter)
 	if (strlen(netdev->name) < (IFNAMSIZ - 5))
 		snprintf(adapter->rx_ring->name,
 			 sizeof(adapter->rx_ring->name) - 1,
-			 "%s-rx-0", netdev->name);
+			 "%.14s-rx-0", netdev->name);
 	else
 		memcpy(adapter->rx_ring->name, netdev->name, IFNAMSIZ);
 	err = request_irq(adapter->msix_entries[vector].vector,
@@ -2147,7 +2147,7 @@ static int e1000_request_msix(struct e1000_adapter *adapter)
 	if (strlen(netdev->name) < (IFNAMSIZ - 5))
 		snprintf(adapter->tx_ring->name,
 			 sizeof(adapter->tx_ring->name) - 1,
-			 "%s-tx-0", netdev->name);
+			 "%.14s-tx-0", netdev->name);
 	else
 		memcpy(adapter->tx_ring->name, netdev->name, IFNAMSIZ);
 	err = request_irq(adapter->msix_entries[vector].vector,
-- 
2.19.1



