Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DC1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A046214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SSUDI98J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731382AbfB1MWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 07:22:05 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37338 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731712AbfB1MWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 07:22:04 -0500
Received: by mail-wr1-f65.google.com with SMTP id w6so18472926wrs.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 04:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=081b2WykrwcmfZxREyFy0rYtvIRmQI0giDh8mi53WU0=;
        b=SSUDI98JhBuJYOIQIJckoJiPkFY7IhNnVjf1LzteHJ9oPhs6Lqq6LfibMtXA73rofJ
         +VVQRZaiAHj0wVf4PWj/xTEvySE1HtT4+lasDMFaDemUjga8AmerGYfyjty2PZX2RRdF
         uQ8Yx8Q5FZyI6DJUtTsnbhlA4NjJ9zXmlGykZKE3TI5tO5cse3RKq2+OGZORrT2SwUvO
         oAcN0FQB7GseaQ3ZPvyNrJfmiUEx4gE3GvhhmrMXiu2pD303ft0jNNJATnrM0jOIXf0G
         nd068Bqo1CVon+QTxhqJNbs6Kg3/m88w0fTNC3E8TcAW/gEK/i54n1RY95i6fczxn5sb
         mMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=081b2WykrwcmfZxREyFy0rYtvIRmQI0giDh8mi53WU0=;
        b=l+y0qbjRnFHduhYTV9iupGagOSV/Ex6upu97p7rn7NRDYPqgfrYgaSkkWdBrLWNhKm
         5bHUuOvr8xGbaKf2f3V+Z0E+xj4ciUtpS0K31mv8Ihhqljzvt7rIdRNcV/JFEHS9TV4Q
         /8fhyhztX46nsqB/NRXCCNJpRyYI6okMtF61qERWO075shiWFII0GK8p5cEs3n5BA09d
         FW9cHAK3PYUcstWZjo1Qs0zADhlnvsSIND0fN11I40jOC0LLUT/0pVGtlkYlmBjCa60q
         tOo6giMpZkjzoJEe4jo8y1dgtq6toaJyx/aVITfQbDyx5FdGcVNR3Wae2mFuUXKpvfMW
         J3IA==
X-Gm-Message-State: APjAAAUHO8GqdZsKQWG+U1lBeUeBEyZUDYHK7W2G/9p6ZVqD1QDZmc4d
        0uluknw+gSbtyE5CoYFuXsh6nSENU1s=
X-Google-Smtp-Source: APXvYqxNnPj4qu6EFJ5Pedj4VPkYddlrwI59A+osU1Be+LmSNUEFrDnheAXvHKCna+3MhHV00Ix1Og==
X-Received: by 2002:a5d:6209:: with SMTP id y9mr6592393wru.140.1551356521970;
        Thu, 28 Feb 2019 04:22:01 -0800 (PST)
Received: from localhost ([49.248.54.130])
        by smtp.gmail.com with ESMTPSA id m26sm3601885wmg.13.2019.02.28.04.22.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 04:22:01 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v2 05/24] drivers: thermal: tsens: Use consistent names for variables
Date:   Thu, 28 Feb 2019 17:50:55 +0530
Message-Id: <22c775079adc2dae926cd71e6d6ebd429510eeba.1551355503.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1551355503.git.amit.kucheria@linaro.org>
References: <cover.1551355503.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1551355503.git.amit.kucheria@linaro.org>
References: <cover.1551355503.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tsens_get_temp() uses the name 'data' for the void pointer, use the same
in tsens_get_trend() for consistency.

Remove a stray space while we're at it.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 4582d2b30e94..0b5be08d515f 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -20,13 +20,13 @@ static int tsens_get_temp(void *data, int *temp)
 	return priv->ops->get_temp(priv, s->id, temp);
 }
 
-static int tsens_get_trend(void *p, int trip, enum thermal_trend *trend)
+static int tsens_get_trend(void *data, int trip, enum thermal_trend *trend)
 {
-	const struct tsens_sensor *s = p;
+	const struct tsens_sensor *s = data;
 	struct tsens_priv *priv = s->priv;
 
 	if (priv->ops->get_trend)
-		return  priv->ops->get_trend(priv, s->id, trend);
+		return priv->ops->get_trend(priv, s->id, trend);
 
 	return -ENOTSUPP;
 }
-- 
2.17.1

