Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DA1C282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72AF0205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126417;
	bh=dm80or8pnW8oW9HXS0D9v35wts8kbx4gT5JpmdQSD/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BASt9QY1HRMCSXRTEAEpnp33WArxwPMlbqGKKF7a1RdS6qnWwTL4xYH61j443Qdoj
	 3slT/UMNZMyB3MjFObRRmiT4vySW+e7FVFOWRAf5wGbZ5S4JsVeX5zwOIMTtW+YLfV
	 DkC9PDuhBLP89z2j6Kf5++wUmNrFuVfffJAVHWZM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389118AbfDXRT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:19:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:45286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389100AbfDXRTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:19:54 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0799721905;
        Wed, 24 Apr 2019 17:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126393;
        bh=dm80or8pnW8oW9HXS0D9v35wts8kbx4gT5JpmdQSD/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hdy+ox4nvy8G4Dj6NW9YA+m6CXl+UnlYEsolodoL/i2s4vJlAYM2mj3t9aVKdLjuD
         9kU72HHSOEbZEmtmgNWJWTzUvUlV13HDATlokDy3ANTHZVL+RlwiHODJ7DqmJG3bBD
         yehUr90XN97dboSy0NJRvDnHHY2GCM6q7pkTOrxU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 053/168] soc: qcom: gsbi: Fix error handling in gsbi_probe()
Date:   Wed, 24 Apr 2019 19:08:17 +0200
Message-Id: <20190424170926.925542115@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170923.452349382@linuxfoundation.org>
References: <20190424170923.452349382@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



