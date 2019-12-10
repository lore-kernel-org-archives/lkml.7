Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2C9C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C986720637
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576015740;
	bh=jwr300KW8QE/HYvugLKsTz1MxMFAEbQvblOCRvrZNgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sLLTzU7fL249OXYwQER3IwFPfHjbelqfxQqSF5FVmwQGUpcJc7Qe/cWanygsOh+Mt
	 3mVKBzMSG+01TOeJfxL4sdhmdtt0lbqrz8P5wlgvoDDGnwUMePZqdWxixati84q1lN
	 EExkr8K1dHpAmyvEwaZ6l+LAMoQmjel0HtDIgeGg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbfLJWI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 17:08:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:35544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728979AbfLJWEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 17:04:35 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B9DA2053B;
        Tue, 10 Dec 2019 22:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576015474;
        bh=jwr300KW8QE/HYvugLKsTz1MxMFAEbQvblOCRvrZNgw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dKwu9sIM34yRPnbLkrCu9hm+F23i4tvlVlTshUQMjX+x3ZIbWUP7/iR7BQL4mygIz
         tSX357Je2meAk2cTPviW0bHtrQIccu+pdZoXCfeBQ7LZkDL0cDQ3xs+mrBlgboS7Xp
         AJQw620e4DduRCMa1mKhVfHIh5V4PJM9L4fxmY68=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Pan Bian <bianpan2016@163.com>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 079/130] spi: img-spfi: fix potential double release
Date:   Tue, 10 Dec 2019 17:02:10 -0500
Message-Id: <20191210220301.13262-79-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210220301.13262-1-sashal@kernel.org>
References: <20191210220301.13262-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 7a37090dabbea..2e65b70c78792 100644
--- a/drivers/spi/spi-img-spfi.c
+++ b/drivers/spi/spi-img-spfi.c
@@ -673,6 +673,8 @@ static int img_spfi_probe(struct platform_device *pdev)
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

