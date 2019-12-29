Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8277BC2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E1A9206A4
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577641308;
	bh=C0v7IH0031QkX7O7pvr24lnK8odf+kGcl0ARp38Hr1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PQVhKxu7kVVDdnsxxLtE+eZIN7F1UcunwPV9igfZt4S1zKUtspRxtuRLJWC7TCbBs
	 Gj8+h1iWc74otUrUS+sCnDNp/mZTd+JUxZfExjbAcfiDaZilmMiUQUbnf6OBAJBjeY
	 ILFyWPvvOTeSvXDwTn3ADK6kHXCnzCw5K6Avc8+g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbfL2Rcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:32:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:32774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729049AbfL2RcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:32:25 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C4D620409;
        Sun, 29 Dec 2019 17:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577640745;
        bh=C0v7IH0031QkX7O7pvr24lnK8odf+kGcl0ARp38Hr1s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zv1TqWu0LRPjEC8/2M4uDZBokhIGqi0Fd/e3hzX8Ovr0TByEp3Kvk9F891Z6toXRZ
         3nIRDDe+PK6jbbzt58B4kwlW7MUHsMGsaAimSrn6PYqOfrgLOwVc46O5XAnYNTkwTi
         KzX/jYRpi0e2X6O5IVbKnQ/gEHNFYqxqml8dQp1c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pan Bian <bianpan2016@163.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 120/219] spi: img-spfi: fix potential double release
Date:   Sun, 29 Dec 2019 18:18:42 +0100
Message-Id: <20191229162526.712509302@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229162508.458551679@linuxfoundation.org>
References: <20191229162508.458551679@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pan Bian <bianpan2016@163.com>

[ Upstream commit e9a8ba9769a0e354341bc6cc01b98aadcea1dfe9 ]

The channels spfi->tx_ch and spfi->rx_ch are not set to NULL after they
are released. As a result, they will be released again, either on the
error handling branch in the same function or in the corresponding
remove function, i.e. img_spfi_remove(). This patch fixes the bug by
setting the two members to NULL.

Signed-off-by: Pan Bian <bianpan2016@163.com>
Link: https://lore.kernel.org/r/1573007769-20131-1-git-send-email-bianpan2016@163.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-img-spfi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-img-spfi.c b/drivers/spi/spi-img-spfi.c
index e6eb979f1b8a..e4b31d6e6e33 100644
--- a/drivers/spi/spi-img-spfi.c
+++ b/drivers/spi/spi-img-spfi.c
@@ -676,6 +676,8 @@ static int img_spfi_probe(struct platform_device *pdev)
 			dma_release_channel(spfi->tx_ch);
 		if (spfi->rx_ch)
 			dma_release_channel(spfi->rx_ch);
+		spfi->tx_ch = NULL;
+		spfi->rx_ch = NULL;
 		dev_warn(spfi->dev, "Failed to get DMA channels, falling back to PIO mode\n");
 	} else {
 		master->dma_tx = spfi->tx_ch;
-- 
2.20.1



