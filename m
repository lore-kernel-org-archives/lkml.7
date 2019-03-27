Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED8CC10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8062F2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553712199;
	bh=G/+DMr02VI8AhEGqoHUj/zm3muQzTzc9wDXbs38iUps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OwUf4kdbPX0FKiI1gzfSJvfpZ8zkIz1wburAenq0C2y9e49TgMqUHEEvDUR6RtBLI
	 ouC4FL2V7zLh4gT/UhahU4ucAQ5Bq0OEQOZAwEvmlB5lw7iWUVbbdQ29do3M/yBLEz
	 dFBEyD7zeaUaAPhWq+VqVvdK+9pzHWxpwchk+QbU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391218AbfC0SVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:21:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:39484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390309AbfC0SVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:21:35 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB4A820651;
        Wed, 27 Mar 2019 18:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710894;
        bh=G/+DMr02VI8AhEGqoHUj/zm3muQzTzc9wDXbs38iUps=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fon10k/8jWknEliLsX1EZqgVSKqQK6hZT0iw51KBt7P/c6nNfkOW1v7WePVon0Yi6
         UNd2fLIkHDpbYbixllmlZaXLWSJXgHw0lBPW9LXL9GoRmUcqhacjIHXmf/5mYdo7XF
         37xfVwq6i5+bmjLgdOvHMCvD24CHcfPLMSHvSseY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 32/87] e1000e: Fix -Wformat-truncation warnings
Date:   Wed, 27 Mar 2019 14:19:45 -0400
Message-Id: <20190327182040.17444-32-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327182040.17444-1-sashal@kernel.org>
References: <20190327182040.17444-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

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
index 6855b3380a83..f56f8b6e2378 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -2121,7 +2121,7 @@ static int e1000_request_msix(struct e1000_adapter *adapter)
 	if (strlen(netdev->name) < (IFNAMSIZ - 5))
 		snprintf(adapter->rx_ring->name,
 			 sizeof(adapter->rx_ring->name) - 1,
-			 "%s-rx-0", netdev->name);
+			 "%.14s-rx-0", netdev->name);
 	else
 		memcpy(adapter->rx_ring->name, netdev->name, IFNAMSIZ);
 	err = request_irq(adapter->msix_entries[vector].vector,
@@ -2137,7 +2137,7 @@ static int e1000_request_msix(struct e1000_adapter *adapter)
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

