Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC45CC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3BEE206BF
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oFeXeHu8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbfH0MOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 08:14:33 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:47081 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729552AbfH0MOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 08:14:32 -0400
Received: by mail-pf1-f194.google.com with SMTP id q139so13988519pfc.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 05:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ByQuSAprS9jXkayR9k8WNXgC0XRVOmuonTQ+tfTnFgQ=;
        b=oFeXeHu81LKsmIt7qd79KgGaAgbRDvhtHEbzcJsDTIyDIb1vjLZzGCUYrlXBrhVh0H
         EHqo53y0jOX76nzMTDHT60A74TY5VPOzJaptg87naVQX71fv2xpUsxrdf4JTzLrG3P9y
         UL+fVDfDy5e0LgG3YOKlutwrj2KKTkzGaKwTcvEXR39Hw++yOHdyn+wW/CiylqacqCS6
         GlSyL25Rws+1zruhvD5N06QYOcT3XfLU/SmgccDhL185GVlWBljOK/DMxbk9IAphVKYL
         27bUZP8p16RYF5L+sU1wsRzIpSnaCjctervDPIayul04UHC9uV6HMHbAhT5l+AaamjTu
         da/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ByQuSAprS9jXkayR9k8WNXgC0XRVOmuonTQ+tfTnFgQ=;
        b=ugZ+kEYgyuoB0IfTWmUxaC7fb2YFgmVgveQ9gP01a3A3Aw/Stzc8BNd12uUpZT2sY8
         OrW6qadiTNguMrJnc71d28P3kWxNgPlfFZ2MJLSlnBGLbGbp8V49eHeuBNTGyQOAvN+e
         0kW96WvCLT6d60/CwUSRurjSsbXb5PRpqCPnBm4MZeaa7drcRGUcPGlYn8w7gMKPfRpU
         9a+BDJ9aH+9tQoKIYPHXaA+9ZlpaGN0YrPqgGAH08Q3QBtzVD7IBlwxM9FIdv6GBXf+m
         pUyAnUQVOUQJZ/pAa0syjrMsF9+/ZrRwr793n/GB0e4fzF/pFejXGuadQmOVaqQJsfqJ
         vxEQ==
X-Gm-Message-State: APjAAAW4qs9QNtcnZ5VJOFt9MyUVpzjp5JzUig4liSr7VhujiAHDtqgx
        9U08M5eSmNJgUsO3oMj3zdXjA0N28NpKuQ==
X-Google-Smtp-Source: APXvYqyftonu9jTlmH0ayDH7TOr6DaBwh6U/L04HWzIFTKUkLf8Jos0TyIP4+efo1N2uctISUk0afQ==
X-Received: by 2002:a63:3c5:: with SMTP id 188mr20528160pgd.394.1566908071328;
        Tue, 27 Aug 2019 05:14:31 -0700 (PDT)
Received: from localhost ([49.248.54.193])
        by smtp.gmail.com with ESMTPSA id e13sm18207682pfl.130.2019.08.27.05.14.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Aug 2019 05:14:30 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        sboyd@kernel.org, masneyb@onstation.org, marc.w.gonzalez@free.fr,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v2 02/15] drivers: thermal: tsens: Simplify code flow in tsens_probe
Date:   Tue, 27 Aug 2019 17:43:58 +0530
Message-Id: <e54d2381f481e688429b6910d2f76871b3b8fe9e.1566907161.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1566907161.git.amit.kucheria@linaro.org>
References: <cover.1566907161.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1566907161.git.amit.kucheria@linaro.org>
References: <cover.1566907161.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move platform_set_drvdata up to avoid an extra 'if (ret)' check after
the call to tsens_register.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/qcom/tsens.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 6ed687a6e53cd..542a7f8c3d962 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -149,6 +149,8 @@ static int tsens_probe(struct platform_device *pdev)
 	priv->feat = data->feat;
 	priv->fields = data->fields;
 
+	platform_set_drvdata(pdev, priv);
+
 	if (!priv->ops || !priv->ops->init || !priv->ops->get_temp)
 		return -EINVAL;
 
@@ -167,11 +169,7 @@ static int tsens_probe(struct platform_device *pdev)
 		}
 	}
 
-	ret = tsens_register(priv);
-
-	platform_set_drvdata(pdev, priv);
-
-	return ret;
+	return tsens_register(priv);
 }
 
 static int tsens_remove(struct platform_device *pdev)
-- 
2.17.1

