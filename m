Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC91C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFD5B20661
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552050227;
	bh=MUsjROpha4a5IieCGGkY6SYex2+gnrfKbuowhPxHLEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q4nbW3OYqIEvs+7PFNV+U4Q+1zEryLUV9RiidxcHnjAMNgFxAMckfzwkXKSqfkMKl
	 5FwKEpo2UN0tFaUdOFH8w8n9ZwRQVPBvEpsWUCPOV8X2hwdVhfYp9YXkuV+ZlbOsUd
	 aNVeql0TeZsDEaYVOS/4RAdsBREerA2++KF92/wM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbfCHNDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 08:03:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:35070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726825AbfCHM6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:58:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A08BB20449;
        Fri,  8 Mar 2019 12:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049919;
        bh=MUsjROpha4a5IieCGGkY6SYex2+gnrfKbuowhPxHLEA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K0cypEOSBUxskg52xdir/Be2p2j7AS07eziRKcTxvlFjnY8aLkM5XplOHTK9m++YZ
         KOZDLRdzXCFjwBrg+cdiY5qudHplOiJAeaDzQdVdfsgWqIifeRTNMd0DQR1JEmVVcn
         QcRqOK2CroOkfClKUoVR16sv+OzY8piW/c/0ZGrI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bryan Whitehead <Bryan.Whitehead@microchip.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 27/68] lan743x: Fix TX Stall Issue
Date:   Fri,  8 Mar 2019 13:49:57 +0100
Message-Id: <20190308124912.134848400@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124910.696595153@linuxfoundation.org>
References: <20190308124910.696595153@linuxfoundation.org>
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

From: Bryan Whitehead <Bryan.Whitehead@microchip.com>

[ Upstream commit 90490ef7269906423a1c1b917fc24be8b1602658 ]

It has been observed that tx queue stalls while downloading
from certain web sites (example www.speedtest.net)

The cause has been tracked down to a corner case where
dma descriptors where not setup properly. And there for a tx
completion interrupt was not signaled.

This fix corrects the problem by properly marking the end of
a multi descriptor transmission.

Fixes: 23f0703c125b ("lan743x: Add main source files for new lan743x driver")
Signed-off-by: Bryan Whitehead <Bryan.Whitehead@microchip.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/microchip/lan743x_main.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -1403,7 +1403,8 @@ static int lan743x_tx_frame_start(struct
 }
 
 static void lan743x_tx_frame_add_lso(struct lan743x_tx *tx,
-				     unsigned int frame_length)
+				     unsigned int frame_length,
+				     int nr_frags)
 {
 	/* called only from within lan743x_tx_xmit_frame.
 	 * assuming tx->ring_lock has already been acquired.
@@ -1413,6 +1414,10 @@ static void lan743x_tx_frame_add_lso(str
 
 	/* wrap up previous descriptor */
 	tx->frame_data0 |= TX_DESC_DATA0_EXT_;
+	if (nr_frags <= 0) {
+		tx->frame_data0 |= TX_DESC_DATA0_LS_;
+		tx->frame_data0 |= TX_DESC_DATA0_IOC_;
+	}
 	tx_descriptor = &tx->ring_cpu_ptr[tx->frame_tail];
 	tx_descriptor->data0 = tx->frame_data0;
 
@@ -1517,8 +1522,11 @@ static void lan743x_tx_frame_end(struct
 	u32 tx_tail_flags = 0;
 
 	/* wrap up previous descriptor */
-	tx->frame_data0 |= TX_DESC_DATA0_LS_;
-	tx->frame_data0 |= TX_DESC_DATA0_IOC_;
+	if ((tx->frame_data0 & TX_DESC_DATA0_DTYPE_MASK_) ==
+	    TX_DESC_DATA0_DTYPE_DATA_) {
+		tx->frame_data0 |= TX_DESC_DATA0_LS_;
+		tx->frame_data0 |= TX_DESC_DATA0_IOC_;
+	}
 
 	tx_descriptor = &tx->ring_cpu_ptr[tx->frame_tail];
 	buffer_info = &tx->buffer_info[tx->frame_tail];
@@ -1603,7 +1611,7 @@ static netdev_tx_t lan743x_tx_xmit_frame
 	}
 
 	if (gso)
-		lan743x_tx_frame_add_lso(tx, frame_length);
+		lan743x_tx_frame_add_lso(tx, frame_length, nr_frags);
 
 	if (nr_frags <= 0)
 		goto finish;


