Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663D1C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FEBA215EA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xbo7XSFN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731354AbfFYQrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 12:47:47 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38215 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730679AbfFYQrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 12:47:43 -0400
Received: by mail-wm1-f65.google.com with SMTP id s15so3676191wmj.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 09:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DnmUUmlBFAOJ6r0lO2j/n/ft2AG+WeYI8h0EcXuhXCs=;
        b=Xbo7XSFN9rED5NZS/+c+eS51wLoYcSb+HfUkS0fXp+WEVZI/klmyc/xzDQcSk6kbda
         PLkTwD+LzBS3AZ94fFA8beUaDPzXToHiAtQGtYgMEa7xGSHRnmt9i8HHb4RkAENDHe5e
         IsL0oKoIDRchTHu/mEX4S5wUizdEf+RMRPLLMDrB7AmcmgO+P7E3pn73quB2Juy8UxTW
         jEED9bkXwE57LB6U9SOCXArx0Oju7R8iZ1WfU5HvlkhPqgCsPcO1+tnAvFeSoPUrrDae
         33cxR70DEVqATeHx9PamU6pz/v/4lzjTi/KGso5mz5Zz8Vhl6pl2nCo9mmky/EQOLFvo
         3uUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DnmUUmlBFAOJ6r0lO2j/n/ft2AG+WeYI8h0EcXuhXCs=;
        b=c06fX+t4rQ4K0csdOjJRNR7VIQ3qW4jNP44oJ1uyfUS8wpUAQDf7JJmlAq9gPzxZ3s
         2/qpTYlo+kowFKnoIC4FG3cImSVNQNa36bGRgzDwk3QjQdOL/IupLiazUDhvfe7xEDfL
         RCRvUa2Qh1PAid9Xw79FlBW7bo4Slm8NMNyF2tMglzAhcr5lKwWvqHr4eRwwIszJNafQ
         wsuHPCadEMGiUxEr7lzgJfR8pU8tfffWf3zhMjJ9Q2u1Vt9LtD/lDza7HwgaS7iRw85q
         pMjyXDHrMd4cFvsXJRg48Ttt/dvBAfZeAAw3fYQyUOxdxFt/M58sFaJ8uLnjGaIQPQSb
         AYJw==
X-Gm-Message-State: APjAAAXjC/GlgF8U4UH0Wgmv723uUiTCiNE5cAYNzylEJRBNs2GNBWAV
        L1WNydXtu7n5NYbOlTnayqWB8Q==
X-Google-Smtp-Source: APXvYqw0MlFamdgw8IfuZ/mw6IFGIsihCgTjA9lyv6BtUZRI3MTMXO+uUOMmyuh2w+RBxwxPXQqvxw==
X-Received: by 2002:a1c:cb4d:: with SMTP id b74mr14944322wmg.43.1561481260999;
        Tue, 25 Jun 2019 09:47:40 -0700 (PDT)
Received: from localhost.localdomain (30.red-83-34-200.dynamicip.rima-tde.net. [83.34.200.30])
        by smtp.gmail.com with ESMTPSA id d18sm42594476wrb.90.2019.06.25.09.47.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Jun 2019 09:47:40 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, david.brown@linaro.org,
        jassisinghbrar@gmail.com, mark.rutland@arm.com,
        mturquette@baylibre.com, robh+dt@kernel.org, will.deacon@arm.com,
        arnd@arndb.de, horms+renesas@verge.net.au, heiko@sntech.de,
        sibis@codeaurora.org, enric.balletbo@collabora.com,
        jagan@amarulasolutions.com, olof@lixom.net
Cc:     vkoul@kernel.org, niklas.cassel@linaro.org,
        georgi.djakov@linaro.org, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, khasim.mohammed@linaro.org
Subject: [PATCH v3 02/14] mbox: qcom: add APCS child device for QCS404
Date:   Tue, 25 Jun 2019 18:47:21 +0200
Message-Id: <20190625164733.11091-3-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190625164733.11091-1-jorge.ramirez-ortiz@linaro.org>
References: <20190625164733.11091-1-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is clock controller functionality in the APCS hardware block of
qcs404 devices similar to msm8916.

Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 drivers/mailbox/qcom-apcs-ipc-mailbox.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
index 705e17a5479c..a05dc3aabac7 100644
--- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
+++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
@@ -89,16 +89,18 @@ static int qcom_apcs_ipc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	if (of_device_is_compatible(np, "qcom,msm8916-apcs-kpss-global")) {
-		apcs->clk = platform_device_register_data(&pdev->dev,
-							  "qcom-apcs-msm8916-clk",
-							  -1, NULL, 0);
-		if (IS_ERR(apcs->clk))
-			dev_err(&pdev->dev, "failed to register APCS clk\n");
-	}
-
 	platform_set_drvdata(pdev, apcs);
 
+	if (!of_device_is_compatible(np, "qcom,msm8916-apcs-kpss-global") &&
+	    !of_device_is_compatible(np, "qcom,qcs404-apcs-apps-global"))
+		return 0;
+
+	apcs->clk = platform_device_register_data(&pdev->dev,
+						  "qcom-apcs-msm8916-clk",
+						  -1, NULL, 0);
+	if (IS_ERR(apcs->clk))
+		dev_err(&pdev->dev, "failed to register APCS clk\n");
+
 	return 0;
 }
 
-- 
2.21.0

