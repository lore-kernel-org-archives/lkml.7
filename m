Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09644C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 22:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF848208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 22:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SoIVvGxk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbfIKWc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 18:32:57 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43014 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728943AbfIKWcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 18:32:55 -0400
Received: by mail-pg1-f193.google.com with SMTP id u72so12256414pgb.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 15:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=YaAXQthtgG2MBssj57BLbE1LV2recijh1io10AfY2RI=;
        b=SoIVvGxkGwPW0vjHAhCUlzzpEn9xEJSfQSimpj9zTEt4BwHqSc4RQt8PGb7NS2wwQI
         MhYocNB+PZRwHRxD7xWamn9kaMnMMNFyQZ/PMgAaSchdpk+KCJW4iF/a0camj1lHBNXe
         gAk7NUHUZSqSZqg8z09FQ1X/wB7/Qlem15ix4Cv5gqYobvooPwVi5Ot7F8W+6dVkNeqZ
         Du5lvxl4asoSRD8w0hTmhncU1ixJHcJIt7eQzR6/4dC+b69dfFMpDEwlLqkCRNZF6DzC
         66/gLhIIs5Mg2jNLNtKwcpyS5EB4onIogJxyGEVadt2e5jAZROo+0KdsR7Sb7zzG9mvR
         hWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=YaAXQthtgG2MBssj57BLbE1LV2recijh1io10AfY2RI=;
        b=bfBhUNaPXofBvjOZHl44frOkrDziNzI9v5ktazMo03Smkk47hZgUOgNXPvGcrR+AHE
         CbjJBeflwFcIDjyLtcfF+krA9D93EnBnFvmZax3c6y10DbzA1MiCg4baOcr5GZ8y3j9F
         mt6/wTjAVqE06ZrdzkjGK/bzV14lbpIuK25XFG4uSkiPJG4mfNYHviJY2A+VdJM6j80R
         Ia2XZPhh6Fd1W+CPho24eKMdrff1FaoSGMD4oJp2XAjkogTmacN7rAds+h6eo6628Xt4
         SVlrJNmXcpZZxAqVozdD0KKSAJFs/UKwmswCRq9qXY0mvuIRCs6ONpxcu/9Y8Zq+pMiV
         XCOQ==
X-Gm-Message-State: APjAAAUqzul1urzVXAu2culmHGecrINL92OeTEqMNI0RzUvBPXypwZzN
        eImMG0ucIRn51IDI6QupDFvMJTD25CE6Rg==
X-Google-Smtp-Source: APXvYqzDFsBhrW60Dw7QRdDgs4cVFH+08Im9dO91acdBcF+SuompVdjxW+lRm34AgGLVIEPXBnTneg==
X-Received: by 2002:a65:51c5:: with SMTP id i5mr34983569pgq.312.1568241174545;
        Wed, 11 Sep 2019 15:32:54 -0700 (PDT)
Received: from localhost ([49.248.179.160])
        by smtp.gmail.com with ESMTPSA id s13sm23641511pfm.12.2019.09.11.15.32.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Sep 2019 15:32:54 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        tdas@codeaurora.org, swboyd@chromium.org, ilina@codeaurora.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-clk@vger.kernel.org
Subject: [PATCH 4/5] clk: qcom: Initialise clock drivers earlier
Date:   Thu, 12 Sep 2019 04:02:33 +0530
Message-Id: <c88947d18c65a692a8f314e4ad996d9d2a997997.1568240476.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1568240476.git.amit.kucheria@linaro.org>
References: <cover.1568240476.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1568240476.git.amit.kucheria@linaro.org>
References: <cover.1568240476.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialise the clock drivers on sdm845 and qcs404 in core_initcall so we
can have earlier access to cpufreq during booting.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/clk/qcom/clk-rpmh.c   | 2 +-
 drivers/clk/qcom/gcc-qcs404.c | 2 +-
 drivers/clk/qcom/gcc-sdm845.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
index c3fd632af119..efed4e9d11cd 100644
--- a/drivers/clk/qcom/clk-rpmh.c
+++ b/drivers/clk/qcom/clk-rpmh.c
@@ -463,7 +463,7 @@ static int __init clk_rpmh_init(void)
 {
 	return platform_driver_register(&clk_rpmh_driver);
 }
-subsys_initcall(clk_rpmh_init);
+core_initcall(clk_rpmh_init);
 
 static void __exit clk_rpmh_exit(void)
 {
diff --git a/drivers/clk/qcom/gcc-qcs404.c b/drivers/clk/qcom/gcc-qcs404.c
index 29cf464dd2c8..50066a6e99aa 100644
--- a/drivers/clk/qcom/gcc-qcs404.c
+++ b/drivers/clk/qcom/gcc-qcs404.c
@@ -2825,7 +2825,7 @@ static int __init gcc_qcs404_init(void)
 {
 	return platform_driver_register(&gcc_qcs404_driver);
 }
-subsys_initcall(gcc_qcs404_init);
+core_initcall(gcc_qcs404_init);
 
 static void __exit gcc_qcs404_exit(void)
 {
diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
index 7131dcf9b060..13677c69932f 100644
--- a/drivers/clk/qcom/gcc-sdm845.c
+++ b/drivers/clk/qcom/gcc-sdm845.c
@@ -3628,7 +3628,7 @@ static int __init gcc_sdm845_init(void)
 {
 	return platform_driver_register(&gcc_sdm845_driver);
 }
-subsys_initcall(gcc_sdm845_init);
+core_initcall(gcc_sdm845_init);
 
 static void __exit gcc_sdm845_exit(void)
 {
-- 
2.17.1

