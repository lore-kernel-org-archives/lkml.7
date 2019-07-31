Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09966C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 20:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D52B2214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 20:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TobnQ1A6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730927AbfGaUak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 16:30:40 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33463 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730588AbfGaU3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 16:29:39 -0400
Received: by mail-wm1-f68.google.com with SMTP id h19so2071143wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 13:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nxlnCpV0F3leEABjK0OQeWrArZ1TknDUFhS5oY3oysQ=;
        b=TobnQ1A6wip0UtD/g3bDWT+S5CD8CP1ZGTctAaOyZrq5umuF3Fsy0wdsk0Lw089w6R
         FO84q7Lw+RUUGLid2tdjgOQYVYSCnawnjla1ZdgyUXT1mw4Pj0nPsdBgyWiBbcC3NG7v
         Wcf6ktXpSNUlXwiugNEPgnDyvHRxFWNwyJlpiBxfaSK7C8RXOXoh/BbOflyAoO5EHgUi
         Rc91LfDiMW+QvAVNBHBPe1tiUJuxWToECnhIAy18MGrEQRl/wvoCoqK74VrQRTyiKgaY
         DoIaJGBAJXRKbLYn7eztJ5raJW/7LXxuu06tpn0PRPXk79oker2ESsHnT2FZyb/UALoJ
         V/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nxlnCpV0F3leEABjK0OQeWrArZ1TknDUFhS5oY3oysQ=;
        b=UiUp7jR5/NtLydCPNXtxyaBj8pWjE6hAKdLp1Op0XDkhRFN2YVsS5wMz0oF3/3IWn0
         S7nYymeqxx3rJmi7POWJoAscoUdxCHdLtmUJke2oRZXMNfG/3znF/A0pJfl9128Qo1MU
         XrTRHZmQqM75tOrrDMaARcZIueBTlmrW9hhsAY6Ac+pysihCufs19SZ9du8sTyS9KeBI
         O9Fkqh2qJQRLx31HR2Xd4vq3FjDrHkLNlBMZhROquBPEg5v8ZTVe24SshVEQEPAqOrbQ
         VAeq4xPZOfC2nD0mF9l84z1BWtoYfhuECry0e1fLfr0gV2BkXpvySFab1/goDYni1u5Q
         KZ9w==
X-Gm-Message-State: APjAAAUwfPYLAFIW4dbTXfGkf4/nq85EOs17FQn5DHuTJMMY3M3iAE+g
        oRcsmXjgWTm8c0VRgI5b70TS1A==
X-Google-Smtp-Source: APXvYqyyTC1stOjdGSZiXTNDxIBxPvxI8gB4mh/on+sczAEFRxCYUb1W4QtpSlahmmSy9W02gw2JvA==
X-Received: by 2002:a1c:7e90:: with SMTP id z138mr108712019wmc.128.1564604978346;
        Wed, 31 Jul 2019 13:29:38 -0700 (PDT)
Received: from localhost.localdomain (19.red-176-86-136.dynamicip.rima-tde.net. [176.86.136.19])
        by smtp.gmail.com with ESMTPSA id i18sm91905591wrp.91.2019.07.31.13.29.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 Jul 2019 13:29:37 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, bjorn.andersson@linaro.org,
        sboyd@kernel.org, david.brown@linaro.org, jassisinghbrar@gmail.com,
        mark.rutland@arm.com, mturquette@baylibre.com, robh+dt@kernel.org,
        will.deacon@arm.com, arnd@arndb.de, horms+renesas@verge.net.au,
        heiko@sntech.de, sibis@codeaurora.org,
        enric.balletbo@collabora.com, jagan@amarulasolutions.com,
        olof@lixom.net
Cc:     vkoul@kernel.org, niklas.cassel@linaro.org,
        georgi.djakov@linaro.org, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, khasim.mohammed@linaro.org
Subject: [PATCH v4 02/13] mbox: qcom: add APCS child device for QCS404
Date:   Wed, 31 Jul 2019 22:29:18 +0200
Message-Id: <20190731202929.16443-3-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190731202929.16443-1-jorge.ramirez-ortiz@linaro.org>
References: <20190731202929.16443-1-jorge.ramirez-ortiz@linaro.org>
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
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/mailbox/qcom-apcs-ipc-mailbox.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
index 705e17a5479c..76e1ad433b3f 100644
--- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
+++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
@@ -89,7 +89,11 @@ static int qcom_apcs_ipc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	if (of_device_is_compatible(np, "qcom,msm8916-apcs-kpss-global")) {
+	platform_set_drvdata(pdev, apcs);
+
+	if (of_device_is_compatible(np, "qcom,msm8916-apcs-kpss-global") ||
+	    of_device_is_compatible(np, "qcom,qcs404-apcs-apps-global")) {
+
 		apcs->clk = platform_device_register_data(&pdev->dev,
 							  "qcom-apcs-msm8916-clk",
 							  -1, NULL, 0);
@@ -97,8 +101,6 @@ static int qcom_apcs_ipc_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev, "failed to register APCS clk\n");
 	}
 
-	platform_set_drvdata(pdev, apcs);
-
 	return 0;
 }
 
-- 
2.22.0

