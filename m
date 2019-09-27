Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1325C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 03:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A706420835
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 03:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O9bMdKw8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbfI0DaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 23:30:07 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37252 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfI0DaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 23:30:06 -0400
Received: by mail-pf1-f196.google.com with SMTP id y5so711092pfo.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 20:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=3fUQ2wevxoVB9of7yE52sU9E/NILQiAovPtEjfDhHSI=;
        b=O9bMdKw8cO5Q2wlyIDHcAUhYNbgKrh+mR8kF3DArk29wCYuc0N+J3CVrMKS1hjGqJe
         cfx2wihV5CmxVYMWcpBqDg3wYYYnfONcnOthmS2ymzXwjWZb8SC59d8/y02jfFjMdcQI
         rnn4HNNSvgyOXUmy+frN+luqQrpKGYKKeE5v5Hl8PupLPqHcLEUo0Ip1zA6LHsUZlBZ6
         WVi6CTQwmrq+bAld5FeSH/xLRqR96x94t1ZtC7myJz46FcVQeSkDafn0HYQa958B5Mx6
         bcFSjDnsCEWadfn4yEtZdp90b/PG0WDBCN6SiwN3OHMcR+UZifTjMohaIFMt09hCMF8i
         hWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3fUQ2wevxoVB9of7yE52sU9E/NILQiAovPtEjfDhHSI=;
        b=k1kgGPCV/kqe5hnaBR51d2XaeTUjWUrhD2GA38yPllEv4jJIlUBWc6oXEI1paDh249
         1LIDpVzAqC32N4u4DNFJgHqd8JuR4NoX7Dr3aQn4uIF6iubyNpZCs/dUXhfE8Y65o2Ik
         O4k8+PMxsBYZwVkeehzmPejG/WxlpXVABT6wX/WYwx6vTQVkKrUtOn6W8tAjdT7VLpbi
         6pJy4uq5pvVA4/XCxeHq3j6I5xw93xsSPGCj/8tT1u84ZDpivux5m2JgFlZRo+T8oS+R
         8xHX9qATStlvZ66VYrFNX7E/+Iq3g3dqb5hnlcmi9xtbSFoMsTHblA+kulHubeMhNQwb
         QFfw==
X-Gm-Message-State: APjAAAXdjRuj0pqFdqaikQtlwuW8RnASaDzTlxT7RaRKYAuEbNiUDXD/
        2Vl+/HAclthpgo7Ql5uvBejQyA==
X-Google-Smtp-Source: APXvYqxKLdRaPcT++pt/WrvbpfM7lnJxg+XwLfQhQzjCfkYtKVCt8f0XzxpgGcR03nk93tHTblJRfA==
X-Received: by 2002:a63:cf4a:: with SMTP id b10mr6916116pgj.276.1569555003985;
        Thu, 26 Sep 2019 20:30:03 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id a11sm674857pfo.165.2019.09.26.20.30.00
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 26 Sep 2019 20:30:03 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     vkoul@kernel.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, baolin.wang@linaro.org
Subject: [PATCH] dmaengine: sprd: Change to use devm_platform_ioremap_resource()
Date:   Fri, 27 Sep 2019 11:29:43 +0800
Message-Id: <1af3efdac3b217203cace090c8947386854c0144.1569554639.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together, which can simpify the code.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/dma/sprd-dma.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index a4a91f2..60d2c6b 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -1065,7 +1065,6 @@ static int sprd_dma_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct sprd_dma_dev *sdev;
 	struct sprd_dma_chn *dma_chn;
-	struct resource *res;
 	u32 chn_count;
 	int ret, i;
 
@@ -1111,8 +1110,7 @@ static int sprd_dma_probe(struct platform_device *pdev)
 		dev_warn(&pdev->dev, "no interrupts for the dma controller\n");
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	sdev->glb_base = devm_ioremap_resource(&pdev->dev, res);
+	sdev->glb_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(sdev->glb_base))
 		return PTR_ERR(sdev->glb_base);
 
-- 
1.7.9.5

