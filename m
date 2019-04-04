Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBDCC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B82032183E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368512;
	bh=858bbCwl64CoWtjXnTihhaeJHR1t1OlbGtsuwGH/MUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r3XRcRr2lxUpiqHeFuq41ZFiFPUhdIfpmKwSt8RVx3oTfo3hfgB70+xpR8EQ8gFNm
	 UbLiz7awCQifYDx7LkdmRKX5gXypzG61hKEMMOjTNWyrgGuGAImJdmEZjBDO8GMumW
	 iACais/zh443K+SooP+ETaqCyeQEjKkoKP8lZcss=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731058AbfDDJBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:01:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:39024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731007AbfDDJBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:01:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8591721741;
        Thu,  4 Apr 2019 09:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368508;
        bh=858bbCwl64CoWtjXnTihhaeJHR1t1OlbGtsuwGH/MUg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nbXEKyxmhfUIhspGo2GwfZTjFmXl2bFFMrgJld3VveN3XkWf3mozcJj/b11tYx6vE
         u0LjuxG+s6hSyBG4E/gc8K81XGmur+DPJ/G4rKIYnVnm+HsB+IPCOb7Cn+RETHBKxY
         /vy0ixERdcqDaoBsS/gIm8Vq5aHpcHcVQgZHysvU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 065/187] e1000e: Fix -Wformat-truncation warnings
Date:   Thu,  4 Apr 2019 10:46:42 +0200
Message-Id: <20190404084606.119052776@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084603.119654039@linuxfoundation.org>
References: <20190404084603.119654039@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index 3ba0c90e7055..e3945469b5c8 100644
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



