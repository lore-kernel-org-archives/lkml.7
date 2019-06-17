Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC89C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9735420861
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q+s/96q0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbfFQMvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 08:51:14 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35073 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfFQMvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 08:51:11 -0400
Received: by mail-wr1-f67.google.com with SMTP id m3so9842675wrv.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 05:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2zuxNNJ4iuFL5CUgXXBK/C8GK/Wfm+gcHDg2NkvAFB8=;
        b=q+s/96q0GvL81bpISKq1BYq2qgGMpiINLYY94rSfeJIBgtJ0JASEtiXtDPecNFmtZL
         IVM+FA8aky8PBmnMLL4+Kt0aJ3tCYdUb9UEdfNN6lMqZIm32xgDsGAGZEN75E5BGglZ5
         O0qHpPxDxjps+O6mgY7ewWjzgrArHawuVqm5pgALhFmzbvj/vTigwdNoWTRq+QYjzbQW
         X4PP0kzs+r42vn1y/uQP2HCx+p4e6qaylctjsm4b3GGzN1UOWC+lSwN5UNNB59hZ9phn
         mt8/uuVdLmFh2bLj3JPXGKXcTYEITepZw7iCLKx8El0VEXOnDiwDYGwUZY8bVg2fGUtk
         a2Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2zuxNNJ4iuFL5CUgXXBK/C8GK/Wfm+gcHDg2NkvAFB8=;
        b=fZeyoS63QT1KSQGUEaDg5J0IK7xBTKRFcVf4r4OEnygq0TLMeLNKLorUIYyt4tRDid
         rXppTrerzoOuqK+gwxWigs/pblNHztaJrYN5UmOPmb+buxu6wku5vk5G5izv0jTsrMsA
         ddhzaZ2n4y5j0j3bIwz8dxDsuf/eyKteHsllI2xIT92JDicwid8SUkXMqRAMyqS/zx7W
         cNwuS9eFBPMBZoFS84OeIy9UaSsUa7HOjUrRPyYqTCtA5Ro9fiGw7J2Gt5h1oW1h1+mG
         Nq0oYcxZXAed+AlMtgMdYmvhEuIXxqmOzwD0Uk6bMmCTExQHQ9laAULFQSol0I34Ek2y
         oZ1g==
X-Gm-Message-State: APjAAAVlMo7Y8agRV6c5Vp0LzGfzpruSt/b5NVAEi8Y1zzVkyUxQECYZ
        G9NpmoQM0e+NTyxaBRh0HaPZvw==
X-Google-Smtp-Source: APXvYqxQmsT3xz0CBZrCiSA472UgfglVRfGZm5u9OAQIPSBLxsX3r/VA44xZ+WxLMb03U8CAncn0Ag==
X-Received: by 2002:a5d:6050:: with SMTP id j16mr6799737wrt.20.1560775869586;
        Mon, 17 Jun 2019 05:51:09 -0700 (PDT)
Received: from dell.watershed.co.uk ([2.27.35.243])
        by smtp.gmail.com with ESMTPSA id o11sm10477852wmh.37.2019.06.17.05.51.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 05:51:09 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     alokc@codeaurora.org, agross@kernel.org, david.brown@linaro.org,
        bjorn.andersson@linaro.org, balbi@kernel.org,
        gregkh@linuxfoundation.org, ard.biesheuvel@linaro.org,
        jlhugo@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, felipe.balbi@linux.intel.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [RESEND v4 1/4] soc: qcom: geni: Add support for ACPI
Date:   Mon, 17 Jun 2019 13:51:02 +0100
Message-Id: <20190617125105.6186-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190617125105.6186-1-lee.jones@linaro.org>
References: <20190617125105.6186-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When booting with ACPI as the active set of configuration tables,
all; clocks, regulators, pin functions ect are expected to be at
their ideal values/levels/rates, thus the associated frameworks
are unavailable.  Ensure calls to these APIs are shielded when
ACPI is enabled.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/soc/qcom/qcom-geni-se.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
index 6b8ef01472e9..d5cf953b4337 100644
--- a/drivers/soc/qcom/qcom-geni-se.c
+++ b/drivers/soc/qcom/qcom-geni-se.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
 
+#include <linux/acpi.h>
 #include <linux/clk.h>
 #include <linux/slab.h>
 #include <linux/dma-mapping.h>
@@ -450,6 +451,9 @@ int geni_se_resources_off(struct geni_se *se)
 {
 	int ret;
 
+	if (has_acpi_companion(se->dev))
+		return 0;
+
 	ret = pinctrl_pm_select_sleep_state(se->dev);
 	if (ret)
 		return ret;
@@ -487,6 +491,9 @@ int geni_se_resources_on(struct geni_se *se)
 {
 	int ret;
 
+	if (has_acpi_companion(se->dev))
+		return 0;
+
 	ret = geni_se_clks_on(se);
 	if (ret)
 		return ret;
@@ -724,12 +731,14 @@ static int geni_se_probe(struct platform_device *pdev)
 	if (IS_ERR(wrapper->base))
 		return PTR_ERR(wrapper->base);
 
-	wrapper->ahb_clks[0].id = "m-ahb";
-	wrapper->ahb_clks[1].id = "s-ahb";
-	ret = devm_clk_bulk_get(dev, NUM_AHB_CLKS, wrapper->ahb_clks);
-	if (ret) {
-		dev_err(dev, "Err getting AHB clks %d\n", ret);
-		return ret;
+	if (!has_acpi_companion(&pdev->dev)) {
+		wrapper->ahb_clks[0].id = "m-ahb";
+		wrapper->ahb_clks[1].id = "s-ahb";
+		ret = devm_clk_bulk_get(dev, NUM_AHB_CLKS, wrapper->ahb_clks);
+		if (ret) {
+			dev_err(dev, "Err getting AHB clks %d\n", ret);
+			return ret;
+		}
 	}
 
 	dev_set_drvdata(dev, wrapper);
-- 
2.17.1

