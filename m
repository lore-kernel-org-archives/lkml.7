Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E200C04E87
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 331C320656
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sflEPPU6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732917AbfETLcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 07:32:43 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37751 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732770AbfETLcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 07:32:43 -0400
Received: by mail-pl1-f196.google.com with SMTP id p15so6602468pll.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 04:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=SH6bOeq9QaZcFruKHetHjcR5Vxn/cn2SAhXtcAspD6Q=;
        b=sflEPPU61og2VFcVypItpwuhuRDg9RrZEU06pKHkq2dyUELMdFIRetA3Amp70Gtasf
         LhfWjt1c9cmf+TG5FSEfkVz+lZS0jhnu+radx8ygtiMy6DUBV6VY/q7zmVwRrpmQQgY2
         B9Dc9sKeRreukolUt81y2EoSpDcHlDSNm3QhtmO5fmJhtkfyi6KzETanmpcUjlCFpOcf
         Q26N+Ofg3YiM4/uR0pX24XqD7mW/EcgeKAO2TfSrLASTOTfUwr2snO69Ns6Zc+0XQf1M
         LBwZV3ZxwK9YX1i7P0cXIqNlvHWZPbknS8ZDFw4g+tubEeoIjZHWwcDoF3THlN+Gxy0Y
         vhJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=SH6bOeq9QaZcFruKHetHjcR5Vxn/cn2SAhXtcAspD6Q=;
        b=D2b0CuvdIDkfSX3oBTDsZLChrHOi3c+flA5k+zH8OhtCv9uIV83qEKJHJoCmgR7z0N
         SJVKmg44UzL5pqSJnDr6dMfjFT6SEPgyjzwhiiMHRI5FXLd16rJdrp1mZ8W9zJupZECd
         UIKmxTU1AdF3hrdoPU+6KS9Nw16qPYFxtDmoCA301PdlEKTfJJzmK7+tsBgQp6ekjRS3
         QbZH3ALaOJhHnMFmLE1Yv32g/JJHgXM5HrFktt2aheMo1auB4XtuSHucCGD/KlVxYqt1
         ve6SsOmAYtWR7jW8g1CsBByWhyg0OW1WYuZboNIq/njnUwo7gv1uh1HqJApoY1Hri5Kp
         gyJA==
X-Gm-Message-State: APjAAAVX36Mj1EpPiO10PEkad2NdnWKggwSKAtP7ruN0b9e5Wk/eCjC5
        FPG5+h7M/KIpvu4mBa1xejUnaw==
X-Google-Smtp-Source: APXvYqw5fPKlpPwCDX8Prno12aw6CFqlLCWkN1e77syboLkhzA1LnbIZ14RetfpmMHPjpaxnXWlwXw==
X-Received: by 2002:a17:902:a81:: with SMTP id 1mr29319466plp.287.1558351962410;
        Mon, 20 May 2019 04:32:42 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id z124sm21310020pfz.116.2019.05.20.04.32.37
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 04:32:42 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, wsa+renesas@sang-engineering.com,
        jroedel@suse.de, vincent.guittot@linaro.org,
        baolin.wang@linaro.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/8] soc: tegra: fuse: Use dma_request_channel instead of __dma_request_channel()
Date:   Mon, 20 May 2019 19:32:15 +0800
Message-Id: <f1dc31b78b6852bc12a126380816ee32cf78a3f5.1558351667.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1558351667.git.baolin.wang@linaro.org>
References: <cover.1558351667.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1558351667.git.baolin.wang@linaro.org>
References: <cover.1558351667.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __dma_request_channel() prototype has been changed to help to do
device node validation, thus we can use dma_request_channel() instead
of __dma_request_channel() to keep kernel bisectable.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/soc/tegra/fuse/fuse-tegra20.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra20.c b/drivers/soc/tegra/fuse/fuse-tegra20.c
index 49ff017..f40a06f 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra20.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra20.c
@@ -110,7 +110,7 @@ static int tegra20_fuse_probe(struct tegra_fuse *fuse)
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
 
-	fuse->apbdma.chan = __dma_request_channel(&mask, dma_filter, NULL);
+	fuse->apbdma.chan = dma_request_channel(mask, dma_filter, NULL);
 	if (!fuse->apbdma.chan)
 		return -EPROBE_DEFER;
 
-- 
1.7.9.5

