Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F6AC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E699820843
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557919226;
	bh=VOzyVEwaHQ3QiLL2gypp87BN0AL/CMY/laDhtadXgN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wdH0yZUqI0o42ZGAwAoSgbVybx7SX/BFVYCKCAi+wwkuGvsZbJXXCdX0/YTVU2Boh
	 lHTo7JnMqoPE7YnIPNTiruH4cqtzeECYOCgsKrewgCbpuWfKXsWgIw3rN1x8lqvQ9/
	 s+9uxdb41wbtqUQuBxtV3oxtugw0OLL2njHq0er8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731087AbfEOLUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:20:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:58094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730701AbfEOLUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:20:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0016D206BF;
        Wed, 15 May 2019 11:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557919219;
        bh=VOzyVEwaHQ3QiLL2gypp87BN0AL/CMY/laDhtadXgN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z/PdCQB+hw0k4EhuHB4DnLiilUJoiiDYFv/mutTPh/CxxFgC+PZLc5nbaoKlkTG8P
         Wwpo9sV6MgXaF9iqB/xnll5JG8pjFtQYCopm4hN0P7EHc6yxjhvB1wPagbrSiYtip9
         3J2kll7NT+CG70JFLY7R/YZIxuNSpy5c8ewP9QQo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 101/115] dpaa_eth: fix SG frame cleanup
Date:   Wed, 15 May 2019 12:56:21 +0200
Message-Id: <20190515090706.461075029@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090659.123121100@linuxfoundation.org>
References: <20190515090659.123121100@linuxfoundation.org>
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
@@ -1639,7 +1639,7 @@ static struct sk_buff *dpaa_cleanup_tx_f
 				 qm_sg_entry_get_len(&sgt[0]), dma_dir);
 
 		/* remaining pages were mapped with skb_frag_dma_map() */
-		for (i = 1; i < nr_frags; i++) {
+		for (i = 1; i <= nr_frags; i++) {
 			WARN_ON(qm_sg_entry_is_ext(&sgt[i]));
 
 			dma_unmap_page(dev, qm_sg_addr(&sgt[i]),


