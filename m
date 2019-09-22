Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBC4C3A5A6
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C69CE2054F
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569180593;
	bh=HlnVsCceNYZyYai/sxKuhEPWoP8UASBPHV6OlRRXLRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pDt1jX53eIHlF5f2s7mzhsZ9IDxDapzyAS1tc7OZdr9UzCoxD35cPkAI6YCGI81IF
	 pnbfpdTob38mFqUAmDxWPecgk58/FzSxA/0rb8XZ/7ruQAF5f5i4wop3csMIDXjg1+
	 2+0ja3rRxorJ0SWc58SQi3cB17P39dlX9GvYWTyw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731836AbfIVT3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 15:29:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:46570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392417AbfIVStd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 14:49:33 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC3B921A4C;
        Sun, 22 Sep 2019 18:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178172;
        bh=HlnVsCceNYZyYai/sxKuhEPWoP8UASBPHV6OlRRXLRg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fhmv5FT4IqX8/Rn+E5x1sgf2sCNxHshmSe8mQLKHCLa3aG8XSM5XtaUFTB8lJi80a
         Eytuvv5XJI1eb6Kou+qp649qUlItZJuwemuIdEzv9UD62ITR/E2omgvwmq7Ekh73VK
         3v/eP6QTYHw9JGLEXMSXnw+8V0J5A/fHw69MGixc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 005/185] spi: dw-mmio: Clock should be shut when error occurs
Date:   Sun, 22 Sep 2019 14:46:23 -0400
Message-Id: <20190922184924.32534-5-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922184924.32534-1-sashal@kernel.org>
References: <20190922184924.32534-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 3da9834d9381dd99273f2ad4e6d096c9187dc4f2 ]

When optional clock requesting fails, the main clock is still up and running,
we should shut it down in such caee.

Fixes: 560ee7e91009 ("spi: dw: Add support for an optional interface clock")
Cc: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Gareth Williams <gareth.williams.jx@renesas.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Gareth Williams <gareth.williams.jx@renesas.com>
Link: https://lore.kernel.org/r/20190710114243.30101-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-dw-mmio.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 18c06568805e7..86789dbaf5771 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -172,8 +172,10 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 
 	/* Optional clock needed to access the registers */
 	dwsmmio->pclk = devm_clk_get_optional(&pdev->dev, "pclk");
-	if (IS_ERR(dwsmmio->pclk))
-		return PTR_ERR(dwsmmio->pclk);
+	if (IS_ERR(dwsmmio->pclk)) {
+		ret = PTR_ERR(dwsmmio->pclk);
+		goto out_clk;
+	}
 	ret = clk_prepare_enable(dwsmmio->pclk);
 	if (ret)
 		goto out_clk;
-- 
2.20.1

