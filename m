Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1017C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 10:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B6322BEF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 10:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F2iHwiOM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390157AbfGYKmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 06:42:40 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39360 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389693AbfGYKmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 06:42:35 -0400
Received: by mail-lf1-f65.google.com with SMTP id v85so34141037lfa.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 03:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=78HcFQpe5dwNeXFNQEST3LONCweS/YxfhvN+bWwWiRM=;
        b=F2iHwiOM9Fg1pexm655bf4v/yYZ1JSSOG7bleCwne6gW1kURYh9WmgsHfmDGr0jn9u
         mXg+FeGbXJTdyLyGnZum8gMvonOtgrR8zidr8NKJCh+4g+s63bdI7lsKsB2yNhTIfC4+
         XemZWM+qeBL7ZzD1ibMR+ej5tRSaDVGRJkKF4sfbs7rbjz0Ae3I+FIp8Fm59/LZhUYA+
         fjSGf4KaEciiZ55GuXeegV0j8jJTq9jLYHlV1TGfxFVMjeXvDDdsu90xXcyhfgWB0CUw
         g/o8OzGz4g0QZQA1KvoGzS3EmNnTDOV9vtncpmP69nRLcAFrC2qqrei3ilVhiQZVrqgT
         xavA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=78HcFQpe5dwNeXFNQEST3LONCweS/YxfhvN+bWwWiRM=;
        b=JZrSNlwbFgnCvw+utwACvhloxkWcjqh/VGhz42MTr8aPlqLv8RYYUIQHe8NO5sKCN1
         uokhcHcVe9N9vGXF34XAey4e01iDsD1eU+eqO8pKyCjnN5G5sb7KwtIdK3bnJ9f96dqe
         qHjblBu0SvBg5fIAW8/Ft0Tg/HK932kGCaJcs5SDjfsn4JVePN8ceXQIxwBEWq0wdLlt
         tK/hGN9L0iPXqt23tycTq6Gzbkvn7V+mVag3Q1z7+e5BoprwxcCKZM3sYgeGwPSurr/O
         VJ7RIGpJx7/WnuuQk3PzeauOibYikcKEaViz5BQzgecoG2G3sHbHuLC3QGCXx9vTEQ7t
         VYxA==
X-Gm-Message-State: APjAAAXWbGl+wgMGaY2uxPLZnn3U8HVAnZI7Z7Qb+ekAtbolWmIwgj2R
        WOvhgCzrI3rEmB4G5TnNGDrAtg==
X-Google-Smtp-Source: APXvYqwAo84A238zF4AbQKdKLdydEBI6YuDKQ0X/EF/EfLAD0Iq2h3InFiMQDfmhmhF66iLOx1Epqw==
X-Received: by 2002:a19:c514:: with SMTP id w20mr41258688lfe.182.1564051353682;
        Thu, 25 Jul 2019 03:42:33 -0700 (PDT)
Received: from localhost.localdomain (ua-83-226-44-230.bbcust.telenor.se. [83.226.44.230])
        by smtp.gmail.com with ESMTPSA id k124sm7461299lfd.60.2019.07.25.03.42.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 03:42:33 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, jorge.ramirez-ortiz@linaro.org,
        sboyd@kernel.org, vireshk@kernel.org, bjorn.andersson@linaro.org,
        ulf.hansson@linaro.org, Niklas Cassel <niklas.cassel@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/14] cpufreq: Add qcs404 to cpufreq-dt-platdev blacklist
Date:   Thu, 25 Jul 2019 12:41:36 +0200
Message-Id: <20190725104144.22924-9-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190725104144.22924-1-niklas.cassel@linaro.org>
References: <20190725104144.22924-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>

Add qcs404 to cpufreq-dt-platdev blacklist.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index f9444ddd35ab..ec2057ddb4f4 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -125,6 +125,7 @@ static const struct of_device_id blacklist[] __initconst = {
 
 	{ .compatible = "qcom,apq8096", },
 	{ .compatible = "qcom,msm8996", },
+	{ .compatible = "qcom,qcs404", },
 
 	{ .compatible = "st,stih407", },
 	{ .compatible = "st,stih410", },
-- 
2.21.0

