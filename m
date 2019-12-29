Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01A3C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C76F20722
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577640823;
	bh=s3kHlEfWLRqEQXphT5lOEhV2MkeoF0X40YheoB6Xd+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZhOiN08JEPOm4p9Tmbv5Lq1g1mmiaQYHAA3gODfABbZUvZzK2+HvQ3m8sPqxNp9zB
	 scL+lf+ODr9PPGG3m/39MWNRGnBUiCylbVTKJKMAUEeSSfFEDbpiaMDv6pkkL5VWZ1
	 TvI7tRG5iLJ7BpW5QHN4Ui357E9AZZEZVJtAV+nk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbfL2Rdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:33:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:35558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729119AbfL2Rdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:33:36 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CB6720722;
        Sun, 29 Dec 2019 17:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577640815;
        bh=s3kHlEfWLRqEQXphT5lOEhV2MkeoF0X40YheoB6Xd+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Oa3a1eh8nMj1lFyc/E64s5krv/At30RRVj2ow5f+g/gP4fZWjAaGzU26tkqYqjELz
         VXRVhEBk9zLMEV+p3JC3jlO1AMJ5+FtplYeVaBHFAqI1tGBm9bfByn9nTJsgnq2gRC
         0EtE8ipGalBTSZfX6aOUDJlJs5HZ/Pw76SN9Twzo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 150/219] spi: pxa2xx: Add missed security checks
Date:   Sun, 29 Dec 2019 18:19:12 +0100
Message-Id: <20191229162531.123802505@linuxfoundation.org>
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
index f41333817c50..525388126e26 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1470,7 +1470,13 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
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



