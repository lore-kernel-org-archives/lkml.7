Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1342AFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0E68206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573240394;
	bh=gaaJ8b3ZfHjytfh+NG/YwqsMU1/VL4hgRLftpVuGPLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kkjSYRq6qiq7rlfcRoFGPVsiZ2ddc0FmEz3RJJDB0VEjLLfDXYA8j8kenzK8ucn1F
	 diQ4I1jsdySMhXSCplMWl57zYL6Xmwygp8tU6J7xWfuPoA5WhSiOpxMAnoieW+HhDb
	 hJH2a+E7FSxogN5etWMjioLFMbDiag4xeOU+oQmQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391521AbfKHTH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:07:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:38708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391510AbfKHTHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:07:53 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9A7B222C4;
        Fri,  8 Nov 2019 19:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573240072;
        bh=gaaJ8b3ZfHjytfh+NG/YwqsMU1/VL4hgRLftpVuGPLw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1zhIbAI4300oUfAiC5wyIci7+wzI4JyRvLJvt6n83rQKdSgsZpQiD9NRTY1Vg7A5R
         5SRA1KQ97W3kvrD33Kzu7cpS0Ddj/S6iH6V1Z8pD3qEyRrp3Gxhk0kb1MhFcOF4NvI
         33azqJqJ2lyan7ZqgP0qVynInfxnDERO1SZv1xSg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Raju Rangoju <rajur@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.3 080/140] cxgb4: request the TX CIDX updates to status page
Date:   Fri,  8 Nov 2019 19:50:08 +0100
Message-Id: <20191108174910.158668196@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174900.189064908@linuxfoundation.org>
References: <20191108174900.189064908@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raju Rangoju <rajur@chelsio.com>

[ Upstream commit 7c3bebc3d8688b84795c11848c314a2fbfe045e0 ]

For adapters which support the SGE Doorbell Queue Timer facility,
we configured the Ethernet TX Queues to send CIDX Updates to the
Associated Ethernet RX Response Queue with CPL_SGE_EGR_UPDATE
messages to allow us to respond more quickly to the CIDX Updates.
But, this was adding load to PCIe Link RX bandwidth and,
potentially, resulting in higher CPU Interrupt load.

This patch requests the HW to deliver the CIDX updates to the TX
queue status page rather than generating an ingress queue message
(as an interrupt). With this patch, the load on RX bandwidth is
reduced and a substantial improvement in BW is noticed at lower
IO sizes.

Fixes: d429005fdf2c ("cxgb4/cxgb4vf: Add support for SGE doorbell queue timer")
Signed-off-by: Raju Rangoju <rajur@chelsio.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/chelsio/cxgb4/sge.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

--- a/drivers/net/ethernet/chelsio/cxgb4/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/sge.c
@@ -3791,15 +3791,11 @@ int t4_sge_alloc_eth_txq(struct adapter
 	 * write the CIDX Updates into the Status Page at the end of the
 	 * TX Queue.
 	 */
-	c.autoequiqe_to_viid = htonl((dbqt
-				      ? FW_EQ_ETH_CMD_AUTOEQUIQE_F
-				      : FW_EQ_ETH_CMD_AUTOEQUEQE_F) |
+	c.autoequiqe_to_viid = htonl(FW_EQ_ETH_CMD_AUTOEQUEQE_F |
 				     FW_EQ_ETH_CMD_VIID_V(pi->viid));
 
 	c.fetchszm_to_iqid =
-		htonl(FW_EQ_ETH_CMD_HOSTFCMODE_V(dbqt
-						 ? HOSTFCMODE_INGRESS_QUEUE_X
-						 : HOSTFCMODE_STATUS_PAGE_X) |
+		htonl(FW_EQ_ETH_CMD_HOSTFCMODE_V(HOSTFCMODE_STATUS_PAGE_X) |
 		      FW_EQ_ETH_CMD_PCIECHN_V(pi->tx_chan) |
 		      FW_EQ_ETH_CMD_FETCHRO_F | FW_EQ_ETH_CMD_IQID_V(iqid));
 


