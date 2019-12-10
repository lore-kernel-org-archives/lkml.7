Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717C1C00454
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 16:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4800D2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 16:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="cVx/lvVL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbfLJQzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 11:55:52 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:42170 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbfLJQzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 11:55:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1575996950; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=dBLD8wu+LU+fa0Q8NCkOMXq4149Z7QPNmkNtchW0JrE=;
        b=cVx/lvVL88OudDGRMlmEqxNRjjwkI0QxMqiqidefEYCtmYSv0K67iAX/ZM1owgizU5ovBF
        TIrTE//zYIPdHU0+8IqqSxSoGevHvHipriqTFSaBqLDj5gGuMlLSudog+T0rZGSgKF7b0I
        sUXQUG6Fit/wpLubrYmfkusJ0XhpNJU=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     od@zcrc.me, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        stable@vger.kernel.org
Subject: [PATCH] dmaengine: dma-jz4780: Also break descriptor chains on JZ4725B
Date:   Tue, 10 Dec 2019 17:55:45 +0100
Message-Id: <20191210165545.59690-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out that the JZ4725B displays the same buggy behaviour as the
JZ4740 that was described in commit f4c255f1a747 ("dmaengine: dma-jz4780:
Break descriptor chains on JZ4740").

Work around it by using the same workaround previously used for the
JZ4740.

Fixes commit f4c255f1a747 ("dmaengine: dma-jz4780: Break descriptor
chains on JZ4740")

Cc: <stable@vger.kernel.org>
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/dma/dma-jz4780.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index fa626acdc9b9..44af435628f8 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -999,7 +999,8 @@ static const struct jz4780_dma_soc_data jz4740_dma_soc_data = {
 static const struct jz4780_dma_soc_data jz4725b_dma_soc_data = {
 	.nb_channels = 6,
 	.transfer_ord_max = 5,
-	.flags = JZ_SOC_DATA_PER_CHAN_PM | JZ_SOC_DATA_NO_DCKES_DCKEC,
+	.flags = JZ_SOC_DATA_PER_CHAN_PM | JZ_SOC_DATA_NO_DCKES_DCKEC |
+		 JZ_SOC_DATA_BREAK_LINKS,
 };
 
 static const struct jz4780_dma_soc_data jz4770_dma_soc_data = {
-- 
2.24.0

