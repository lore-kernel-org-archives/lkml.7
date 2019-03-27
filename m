Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B19FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDFA02177E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553710098;
	bh=d3T5jnxGDrJ1sLpQMQthl0IVFJCcODFk9WKpcP39bmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wcXUx8P6r0Ut3+VlZmZSmFyhpc/EV/jtKiho2DyKvkJVcN6SnpYv+ktMiVRiDI3E1
	 z/yGuh1dWm8tSJRa/ylLkyYRzYqFjBGWg+ObRwvvZX9vFncwga0n7cAV3pGUv85MUA
	 Z9CNuJhWMJj6VlOrCzuGoRYFbgTWN4nd0L4VZzX0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387866AbfC0SIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:08:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:50112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387844AbfC0SIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:08:11 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0D672183F;
        Wed, 27 Mar 2019 18:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710090;
        bh=d3T5jnxGDrJ1sLpQMQthl0IVFJCcODFk9WKpcP39bmM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VT1pKcaoxv4boeyty3L5n4KwjQyUaIFyxOEowhUWumh6UvttPRpTHvmwpqu7tFFkQ
         lGyjDh586GNfWe+5XpYNaaFnqkP75yyhboRURAa8vJFBrbrMjMcq3y20Eo2nRqMtUQ
         mINjcVaEo1vJMfnIZjMPmGsKlKnuqS74axo6rDC4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 193/262] soc: qcom: gsbi: Fix error handling in gsbi_probe()
Date:   Wed, 27 Mar 2019 14:00:48 -0400
Message-Id: <20190327180158.10245-193-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Khoroshilov <khoroshilov@ispras.ru>

[ Upstream commit 8cd09a3dd3e176c62da67efcd477a44a8d87185e ]

If of_platform_populate() fails in gsbi_probe(),
gsbi->hclk is left undisabled.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Andy Gross <andy.gross@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/qcom/qcom_gsbi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/qcom_gsbi.c b/drivers/soc/qcom/qcom_gsbi.c
index 09c669e70d63..038abc377fdb 100644
--- a/drivers/soc/qcom/qcom_gsbi.c
+++ b/drivers/soc/qcom/qcom_gsbi.c
@@ -138,7 +138,7 @@ static int gsbi_probe(struct platform_device *pdev)
 	struct resource *res;
 	void __iomem *base;
 	struct gsbi_info *gsbi;
-	int i;
+	int i, ret;
 	u32 mask, gsbi_num;
 	const struct crci_config *config = NULL;
 
@@ -221,7 +221,10 @@ static int gsbi_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, gsbi);
 
-	return of_platform_populate(node, NULL, NULL, &pdev->dev);
+	ret = of_platform_populate(node, NULL, NULL, &pdev->dev);
+	if (ret)
+		clk_disable_unprepare(gsbi->hclk);
+	return ret;
 }
 
 static int gsbi_remove(struct platform_device *pdev)
-- 
2.19.1

