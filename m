Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA41C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B841B206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563510823;
	bh=Q2SEaEAU3FeOtqv5GUeAciOTGA6J81HutJNlYGYF0XQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j3BTvZnxrSX97lqwWuSSoSKTPNFTXuDnuUCkvV4vPT1hdYp6TBDzkOPgCdpOz2YXp
	 9dAGDCWa2J/3Iyl1cPv8RF5/pXiDFuanP9jcfnoL194b5E2nyBROYs6lpiSugZ0SxN
	 U/xoaQGBoIlQXmnMtgwHu8CiTjZ62uc6sYhsJqrE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732301AbfGSEdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:33:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:34904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728763AbfGSECy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 00:02:54 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E0C321873;
        Fri, 19 Jul 2019 04:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563508973;
        bh=Q2SEaEAU3FeOtqv5GUeAciOTGA6J81HutJNlYGYF0XQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bme/rG9xwWXhZ9TkNM3JRvXlwu3r7RhpmDD76aKXMHyCt8wCgbJVmquYfAd7zx2UE
         BKwzxxcSKxPHDsxC2nqnWPgE1kGxfpo3uZ+NFlzNZDXYLlK0iLgMJcxHG9UVJ3qVXV
         NzzN3EM7rP24lN094OtFWaIAr/Y0jcDjyjgYy7Wc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Fabien Dessenne <fabien.dessenne@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>, linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 003/141] iio: adc: stm32-dfsdm: missing error case during probe
Date:   Fri, 19 Jul 2019 00:00:28 -0400
Message-Id: <20190719040246.15945-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719040246.15945-1-sashal@kernel.org>
References: <20190719040246.15945-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabien Dessenne <fabien.dessenne@st.com>

[ Upstream commit d2fc0156963cae8f1eec8e2dd645fbbf1e1c1c8e ]

During probe, check the devm_ioremap_resource() error value.
Also return the devm_clk_get() error value instead of -EINVAL.

Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
Acked-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/stm32-dfsdm-core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-core.c b/drivers/iio/adc/stm32-dfsdm-core.c
index bf089f5d6225..941630615e88 100644
--- a/drivers/iio/adc/stm32-dfsdm-core.c
+++ b/drivers/iio/adc/stm32-dfsdm-core.c
@@ -213,6 +213,8 @@ static int stm32_dfsdm_parse_of(struct platform_device *pdev,
 	}
 	priv->dfsdm.phys_base = res->start;
 	priv->dfsdm.base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(priv->dfsdm.base))
+		return PTR_ERR(priv->dfsdm.base);
 
 	/*
 	 * "dfsdm" clock is mandatory for DFSDM peripheral clocking.
@@ -222,8 +224,10 @@ static int stm32_dfsdm_parse_of(struct platform_device *pdev,
 	 */
 	priv->clk = devm_clk_get(&pdev->dev, "dfsdm");
 	if (IS_ERR(priv->clk)) {
-		dev_err(&pdev->dev, "No stm32_dfsdm_clk clock found\n");
-		return -EINVAL;
+		ret = PTR_ERR(priv->clk);
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Failed to get clock (%d)\n", ret);
+		return ret;
 	}
 
 	priv->aclk = devm_clk_get(&pdev->dev, "audio");
-- 
2.20.1

