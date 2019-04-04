Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E713C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3394217D9
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369087;
	bh=0WXeNAMLB1hgpL40lwZaz85CPPxav5spiNlIed0E7OY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZSmyTBo3u6n+3lyUbpGM4RqhkDRhuuY6i8qEiVwrKsKJf6S7TmP2sSD1a4aRvF2PY
	 k8+HvqcQ4Lmj+i8TsO3b4pfFPAQuffcTFQDlgosHdhlES7JwI4RMPJe89/cC693jcN
	 vx9rjjihyovI0KC0TVEY04wZc5N5KLX3ZJhdcIeI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733154AbfDDJLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:11:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:51226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733138AbfDDJLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:11:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA8E92147C;
        Thu,  4 Apr 2019 09:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369081;
        bh=0WXeNAMLB1hgpL40lwZaz85CPPxav5spiNlIed0E7OY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=phQ2rPS31T4QRVzg91AwvaD6WkdvF0sOJeAwGwbv+I4LVyDMeuXQHwqDYzMlFS0/k
         0pjW/guiJfIb2RWqm2ns3nvI00uO9ks8b4EmYmszJ2Q35Pkg+wuizZR4rteHjutStP
         DomdyPXtijVH9SKB1dp7uqjkZ3m7T5BjMa0btn14=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 090/246] e1000e: Fix -Wformat-truncation warnings
Date:   Thu,  4 Apr 2019 10:46:30 +0200
Message-Id: <20190404084622.293378730@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 189f231075c2..23eae3df01a9 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -2106,7 +2106,7 @@ static int e1000_request_msix(struct e1000_adapter *adapter)
 	if (strlen(netdev->name) < (IFNAMSIZ - 5))
 		snprintf(adapter->rx_ring->name,
 			 sizeof(adapter->rx_ring->name) - 1,
-			 "%s-rx-0", netdev->name);
+			 "%.14s-rx-0", netdev->name);
 	else
 		memcpy(adapter->rx_ring->name, netdev->name, IFNAMSIZ);
 	err = request_irq(adapter->msix_entries[vector].vector,
@@ -2122,7 +2122,7 @@ static int e1000_request_msix(struct e1000_adapter *adapter)
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



