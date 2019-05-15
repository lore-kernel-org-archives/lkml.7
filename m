Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84498C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E8CD2084A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557919831;
	bh=JDCjz2uejUGz1Wl/+wSooTpOrcmdF/YYT9dMSQKOIF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t0F2oQL18KG8h9SOrPCLel+47j21wYYtZ14dnkmBfPO6biW/oDHVCE601OupakTY6
	 aWauidiiYn9m1uzHlASs+2M3zrOmqq6nIZdZ7R9UZ5iVlTzjGqyCsjiqRpU9mtbpxF
	 Fw8zApIrTRcO688R5QQDOoEjOdAwcetpiARyb03M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732404AbfEOLaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:30:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:41990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732722AbfEOLa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:30:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D10E20843;
        Wed, 15 May 2019 11:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557919825;
        bh=JDCjz2uejUGz1Wl/+wSooTpOrcmdF/YYT9dMSQKOIF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qJphTH4aw5YX6A6+kZFVtmY2WKcFGDCbVYHTZ73EDeBiSAD5Rl/tNIx4YIVRKDg77
         kIKRZ0TZWOX501za6V7OY5HgU+U0TfmgS2jyPf5nz/Bmap58LbglIEZ1aSl1HRkdsr
         XzYqS4eSck6yKDrFz9QDwedLKZRjvlR89A8LOgJw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 107/137] dpaa_eth: fix SG frame cleanup
Date:   Wed, 15 May 2019 12:56:28 +0200
Message-Id: <20190515090701.337352286@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090651.633556783@linuxfoundation.org>
References: <20190515090651.633556783@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

[ Upstream commit 17170e6570c082717c142733d9a638bcd20551f8 ]

Fix issue with the entry indexing in the sg frame cleanup code being
off-by-1. This problem showed up when doing some basic iperf tests and
manifested in traffic coming to a halt.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Acked-by: Madalin Bucur <madalin.bucur@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -1648,7 +1648,7 @@ static struct sk_buff *dpaa_cleanup_tx_f
 				 qm_sg_entry_get_len(&sgt[0]), dma_dir);
 
 		/* remaining pages were mapped with skb_frag_dma_map() */
-		for (i = 1; i < nr_frags; i++) {
+		for (i = 1; i <= nr_frags; i++) {
 			WARN_ON(qm_sg_entry_is_ext(&sgt[i]));
 
 			dma_unmap_page(dev, qm_sg_addr(&sgt[i]),


