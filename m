Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354ACC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06C8B206BF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557919551;
	bh=JDCjz2uejUGz1Wl/+wSooTpOrcmdF/YYT9dMSQKOIF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XdsulC/NESy2Ht/0ButuR0YXoYRIkgQK0jClDiOCQ8CEWNtxW3zgMg+sdUgngEdrn
	 3VzQnuNWn0ZifO542p6KGDwzZLnvENgNhavOaRiUcsUuk5qsmqv1trJd10AoRjTeVw
	 rZvBjdcKhtfLF23kpYntU6h0p9KuO/OabWsfG9bw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732053AbfEOLZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:25:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:36540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732039AbfEOLZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:25:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45F90206BF;
        Wed, 15 May 2019 11:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557919543;
        bh=JDCjz2uejUGz1Wl/+wSooTpOrcmdF/YYT9dMSQKOIF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s40kOWwPflBqEnDHrp/CUExCnxGwkOoAAc2D+0UwwF9K9bOm1YFi9lfCldGuDv679
         /ISYl7JlTOwP4+sea/9sYwTTLSGY3MxBBewGO0KDNJg/i3946IKitkTTzOlG8o03T4
         35U1HdWehz1iP42Scy9nS0MV4Eito3qNGcUUxmiE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 090/113] dpaa_eth: fix SG frame cleanup
Date:   Wed, 15 May 2019 12:56:21 +0200
Message-Id: <20190515090700.466456129@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090652.640988966@linuxfoundation.org>
References: <20190515090652.640988966@linuxfoundation.org>
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


