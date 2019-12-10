Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6711C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA24207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576017581;
	bh=c96UM0jcU18or907lSHue/ak1btM61d24pnrAmvpJf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K0QBDF5y0FinKWrjPpLZsJK+uR/DuqEKR6+TsK9mZwkBZe0VjaTTOBEJjDMktklpo
	 NdsRHbY4rbtxb6c86tkwoRVpMjuX42A7qwN3J66O6suMsEAzcqUkYXQUDQtS+357Un
	 QygSvdwie/ihW3TVNfMHC3tbBgSVsuMGdqS2UvVk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfLJWcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 17:32:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:52164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729019AbfLJWb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 17:31:56 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B82624654;
        Tue, 10 Dec 2019 22:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576017116;
        bh=c96UM0jcU18or907lSHue/ak1btM61d24pnrAmvpJf0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ALo06PvFGTBKHQ1iSShcrI0sbGYVAkErCzV7r7E0ZzI1ViU6H6xbWTj1QunzOKGI9
         j793ePvCxonIDHsT5hfLjNtNtTqMUObAo2ZN3+g9cl9F9WTEkW/R+jDCUS2cXV7q7j
         IPgiJqswQ8gDdsqSDms1HcdKNTpuxKEktsPe3JRs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chuhong Yuan <hslester96@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 68/91] spi: pxa2xx: Add missed security checks
Date:   Tue, 10 Dec 2019 17:30:12 -0500
Message-Id: <20191210223035.14270-68-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210223035.14270-1-sashal@kernel.org>
References: <20191210223035.14270-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuhong Yuan <hslester96@gmail.com>

[ Upstream commit 5eb263ef08b5014cfc2539a838f39d2fd3531423 ]

pxa2xx_spi_init_pdata misses checks for devm_clk_get and
platform_get_irq.
Add checks for them to fix the bugs.

Since ssp->clk and ssp->irq are used in probe, they are mandatory here.
So we cannot use _optional() for devm_clk_get and platform_get_irq.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Link: https://lore.kernel.org/r/20191109080943.30428-1-hslester96@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-pxa2xx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 6dd195b94c578..2f84d7653afd4 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1529,7 +1529,13 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 	}
 
 	ssp->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(ssp->clk))
+		return NULL;
+
 	ssp->irq = platform_get_irq(pdev, 0);
+	if (ssp->irq < 0)
+		return NULL;
+
 	ssp->type = type;
 	ssp->pdev = pdev;
 	ssp->port_id = pxa2xx_spi_get_port_id(adev);
-- 
2.20.1

