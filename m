Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEDDC3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E549227BF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578004179;
	bh=5SA/MWKEaTJ9HLmwGdbvndUTwoKDc5JGScTKHVKqJ/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1yH8VSUm5UdFMmpk29ev1yeh2ypw/9IYgWLx8M6VD8jzych2pmuhLp0LUtznFF1Sf
	 +QvQCFhXaniwDgi5ss7O9ipP0hfUDr6puVKR8GLJ4HvgZGErF/i6tlyVxauxP3Wgx/
	 hzhnE7uIZHRlW3r6Laava/b+64Ngbd8GVQjwsvQA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730073AbgABW3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:29:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:60608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729869AbgABW3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:29:30 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 179EF24650;
        Thu,  2 Jan 2020 22:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578004169;
        bh=5SA/MWKEaTJ9HLmwGdbvndUTwoKDc5JGScTKHVKqJ/U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dKrVqSv8St9eMq1fm46VeyjnR3Wef85cj5rfQ/EXL5YLrJmbAjxRVAB6G8SaIbr33
         IQ1a/VP4zkl3q3zQBDYKb2Kmr6BTCvaWBCTK3iwIcVtWPzDbnPoAQVom2lBOlNdZoi
         9YWezIWEUsptlNNntBhYECNZj03bIWbyxdP56SrI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 066/171] spi: pxa2xx: Add missed security checks
Date:   Thu,  2 Jan 2020 23:06:37 +0100
Message-Id: <20200102220556.044450236@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220546.960200039@linuxfoundation.org>
References: <20200102220546.960200039@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 6dd195b94c57..2f84d7653afd 100644
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



