Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CF8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7754A204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553711675;
	bh=d3T5jnxGDrJ1sLpQMQthl0IVFJCcODFk9WKpcP39bmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FwTJs7b7sh/xfjZd89fm0ilpKpcOBNQDkW3vHj3SLrQkLXJtQN7v4gi7Ii+tllHzO
	 QI8bZVkil0cQX7UnrFKtMk3CGh3rqIN20nO8KpZu8inkrRV9h54sPVGPmhXhQ8AC7F
	 blJOjO++4pHdNU85/LhNFvX6R5v01ncDeLpoCbjg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbfC0Sed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:34:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:43820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404048AbfC0SYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:24:47 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC6DF20651;
        Wed, 27 Mar 2019 18:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553711086;
        bh=d3T5jnxGDrJ1sLpQMQthl0IVFJCcODFk9WKpcP39bmM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qBohA5w8E6a8sV/lmZIe3oBtE/lk5IfKgfmtaSp+asrj4rlxYzHgYbQpu5B181nKb
         LjmXFECUIFALmvee/D4R8eQuDk/daE7t99FGEiO4r5TuRKmVfOYAgZp+UTmpTRCS8+
         PvCq5bTbsCD7AV6JDNTnqxWh2LBNbbMZbL1KWhkA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 47/63] soc: qcom: gsbi: Fix error handling in gsbi_probe()
Date:   Wed, 27 Mar 2019 14:23:07 -0400
Message-Id: <20190327182323.18577-47-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327182323.18577-1-sashal@kernel.org>
References: <20190327182323.18577-1-sashal@kernel.org>
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

