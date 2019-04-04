Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACA4C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 05:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 199F820882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 05:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zaFrkFeG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfDDFKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 01:10:21 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38594 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbfDDFKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 01:10:20 -0400
Received: by mail-pg1-f193.google.com with SMTP id j26so616024pgl.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 22:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ehkR/1GrUqHc+K2ysjZCJjoQANvD8/DrGOzBtuCP+9I=;
        b=zaFrkFeGEoIflt4DxFfMZR70h9zISecbuJuzd4RMLbjRSkD3d6ajdUCH1h4vzRtSOo
         RNIBJP6aYaY8RoZSn95fy6b7RieioLzW/jC0qdFsDLBflUGEzaYe8gMIMl40m3wXgnzj
         6XINS36izQ/dLzcoirnK0oaqgb5wcpWffg21U6VUES4+XBiUsD7mS7mrchfSVL57F7v/
         wVfCkBuw5f+0UPbO1xWRCfOMvcderFpPZfoZ0Zu/An4bFeNpHEWjfH6EyX03ma5rUq5y
         WvOyxQaAevMKcBTT2LcEQmxY1lyJ8B9hOI7dUBHmwTeud7ziVfrkReV0QT5juM+vSNp4
         0tfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ehkR/1GrUqHc+K2ysjZCJjoQANvD8/DrGOzBtuCP+9I=;
        b=jQLX8WB34JFjYhUY2GJWTxmLLIHa8rGT4B4VIGiCL3uzOz0AKQFbUQE5mMtdoE9RuN
         d+VNcGowNoHrNNiUJOnvuq8lHpkhTQNLNel7sNyd0gG6buyCyh/Xt5dxd6DSwcSlJ2t6
         O63Unitbe85btvtDyrMV7JXBGCEzFnLr9/j03OQNKoo91c2XXMsR8ZOyy1/OY2QSTfxU
         a3B9lXf53xTbCgOEtZWC6QFKNftpcSFxXMpTr2NwAQxurNUVvGkg0osWt2s1kESGPosm
         MgDUQyiKhm94SZFKCG6WtLpdRfXdKL54IFqPTzQo6oIxjQOVCB6P+wcET9Bb5oqUtf17
         UTLw==
X-Gm-Message-State: APjAAAWkmSeAhCdvnT8AOJPWe0YTN5oTWaTBl++35ywG6l+h8juTJbuF
        uyhtRE6e6ClUYYyuGM1lRpOgfQ==
X-Google-Smtp-Source: APXvYqwZmBgzGzqkNBDaEm8/5ZqqkUWYqjdW/BAmxOxT6HZqgBcM7z+qJJrj3c9cqR5O8sPjNjPYSQ==
X-Received: by 2002:a63:dc50:: with SMTP id f16mr3761265pgj.396.1554354619147;
        Wed, 03 Apr 2019 22:10:19 -0700 (PDT)
Received: from centauri.imgcgcw.net ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id q80sm27623011pfa.66.2019.04.03.22.10.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 22:10:18 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, jorge.ramirez-ortiz@linaro.org,
        Niklas Cassel <niklas.cassel@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 5/9] cpufreq: Add qcs404 to cpufreq-dt-platdev blacklist
Date:   Thu,  4 Apr 2019 07:09:26 +0200
Message-Id: <20190404050931.9812-6-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190404050931.9812-1-niklas.cassel@linaro.org>
References: <20190404050931.9812-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 47729a22c159..6c7e42558a38 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -123,6 +123,7 @@ static const struct of_device_id blacklist[] __initconst = {
 
 	{ .compatible = "qcom,apq8096", },
 	{ .compatible = "qcom,msm8996", },
+	{ .compatible = "qcom,qcs404", },
 
 	{ .compatible = "st,stih407", },
 	{ .compatible = "st,stih410", },
-- 
2.20.1

