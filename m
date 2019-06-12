Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E388BC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 14:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDA062082C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 14:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NKgmSte+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439798AbfFLO1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 10:27:54 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34007 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439647AbfFLO1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 10:27:03 -0400
Received: by mail-wr1-f67.google.com with SMTP id e16so17183275wrn.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 07:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2zuxNNJ4iuFL5CUgXXBK/C8GK/Wfm+gcHDg2NkvAFB8=;
        b=NKgmSte+DXgDnofeK6HXXyqoIgzl+2wllid5N2Mb+2YYY8FLB9znpc53v8JSMYbfRU
         8ylKMJtnAGExDye874/mBlDb0yf4dCHHygLIwOxF/s3zzGlcc3f25hqRAoN4yuTZavOp
         FD49dnc3Zkf0lfeHqyPqHzZp4qCU5yYFihh5W6f5tCa8MuAPL898N1keR/Rp+zk2FI8N
         h/EQ4QyWTmdBRgyYCy0ZVodzzLsL3iqqevCwj6abO4xy5PcesDw/V+47H/LKfufv7KST
         yEF8pFE3JAL7BVu0jGU+bMdvD4JLZD3ywF1UJibJLLCCWcdP3HkG0DH6FQMkKiKoaghu
         4TsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2zuxNNJ4iuFL5CUgXXBK/C8GK/Wfm+gcHDg2NkvAFB8=;
        b=Y9TjdUE7yn6yJbGJkqojKg/NeCG3ANrsCyvXUWaHffmFizo0LPOJb/qMsjNnDsaXU4
         PtFhTGYsNkdmhDbMnlM4W8ceV4rckONvfa2QnoIdAHX95YdK/HZU6hHqfY2CNhDG2b3F
         T+6iOkUXB+uDnmWbawNlfmdtj408Sv9ypx0kMjqN64VP2fsW9RXk56HBnyboAFSuCjyJ
         ddJeNtlNoVH9Go0u92GnK7wiJ+4csW/Jjmh0Cjzt0gchhyI/izHfjDshu6byu8YNdEWz
         eU73Vv5fJzptO6bk5LqjFeB+heBmvqiHLWrrExoEc+i9R0sVWBH45XAvO5k/KlVcwHIc
         51Aw==
X-Gm-Message-State: APjAAAU5D6Hj2LpY/Z6XtLcYJIPXEDRDOS/aGF84L7O5UMjQJSrKPZpC
        ZIVfprJvgIjH8SiTYoHwK+nf3Q==
X-Google-Smtp-Source: APXvYqxekgeziKYqupgg3uCEJpmlgdAtBIp9jZkrHyLt6P3LyNI2hY9QxWfrOLqlb8Sqyx9aJJo6dQ==
X-Received: by 2002:adf:da48:: with SMTP id r8mr1540836wrl.18.1560349621530;
        Wed, 12 Jun 2019 07:27:01 -0700 (PDT)
Received: from dell.watershed.co.uk ([185.80.132.160])
        by smtp.gmail.com with ESMTPSA id y18sm203959wmd.29.2019.06.12.07.27.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 07:27:01 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     alokc@codeaurora.org, agross@kernel.org, david.brown@linaro.org,
        wsa+renesas@sang-engineering.com, bjorn.andersson@linaro.org,
        balbi@kernel.org, gregkh@linuxfoundation.org,
        ard.biesheuvel@linaro.org, jlhugo@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-usb@vger.kernel.or,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v4 3/6] soc: qcom: geni: Add support for ACPI
Date:   Wed, 12 Jun 2019 15:26:51 +0100
Message-Id: <20190612142654.9639-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190612142654.9639-1-lee.jones@linaro.org>
References: <20190612142654.9639-1-lee.jones@linaro.org>
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

