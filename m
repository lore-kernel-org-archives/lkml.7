Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405F9C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 22:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14D8C22C7B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 22:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bjUFoDkw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfGYWTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 18:19:08 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34496 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfGYWTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 18:19:06 -0400
Received: by mail-pf1-f193.google.com with SMTP id b13so23436832pfo.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 15:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=xgmSGdIDu0v4P5hRNEQENmsRjAPMzQvZ2XtfdY307wY=;
        b=bjUFoDkwwtUAE9rjXGY/yoZmv4SUpw3zs28N86CLMnkSz3U+2bn3+TLJS+4walCtmB
         PVQpuIprCpvqgGD1hWDh4l6z7HtvdCGuNaShzu+KiztS8VV1ubwC6cMtXT9B8gqsYZpA
         sP3T9ywIr4mAS+PZ98Ckn5ZGC1sZ/ATKTqJeDkZ6+0YlEmEEbN14p+4uUcVmseHdfP5s
         DHmjxk72WKm+GFVr/biN9GvWyyvLqP7zztIloxDv1rrIieRYpNA9mjJheq0ihmCV9jNW
         CXiQyERh4pgRHH5XRbCVnmwwLYv4sqP3LBIHGx5fH3LcaAWNjeAgBfH788SsDqKtqjyb
         eLyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=xgmSGdIDu0v4P5hRNEQENmsRjAPMzQvZ2XtfdY307wY=;
        b=cK78RPsQHf12oHsWed3yKWwAoGkyTM2g5SD+gRrT+Pe1BGXykRaUGseImtMvFxvikA
         T2K5PsMNJR1dO3fnk8sBU3zkL8XbZKMJyyp91YTeWbQVblGWVmnCcbzfohaaf6Q7gicQ
         kfxfVzAX+r1XGGDXdchW+k9+zGA3ZCQ5KU9BQFOBsKvotpLbqltD6v4nyCVet5gUblyf
         cISbTQ2/nx19BbSdeHOEFXCestlP/MXMrjQK/4rKaFYwswkGUHsWgLUzhg0hdaRsrd1f
         c+LritK+/RaQjmEN6zRO/3O2gp0mkf2lsuy0Ce1PlOWdYOYffu44tWIm9clCK0XcpnaN
         ZE2Q==
X-Gm-Message-State: APjAAAWsci//Jp0cE6cOsunrPIA/Y9hTrKBDLoLXfOYDwykbQnyZ/Qkb
        rYwpSWctDOBrGbZoC9D5C3Tu7Lkca3LsiQ==
X-Google-Smtp-Source: APXvYqwaSRF2/JeVa1u/7Y6W3dTGdYmgn066tsuvQjuj18nF/sNUfRqKZ0YJ1r2l5P9c6PXW8ZIQ8w==
X-Received: by 2002:a62:16:: with SMTP id 22mr19525541pfa.151.1564093145400;
        Thu, 25 Jul 2019 15:19:05 -0700 (PDT)
Received: from localhost ([49.248.170.216])
        by smtp.gmail.com with ESMTPSA id 21sm46989303pjh.25.2019.07.25.15.19.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jul 2019 15:19:04 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Andy Gross <agross@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH 02/15] drivers: thermal: tsens: Simplify code flow in tsens_probe
Date:   Fri, 26 Jul 2019 03:48:37 +0530
Message-Id: <355cd15c91e02716140d7114fd403559487b66b6.1564091601.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1564091601.git.amit.kucheria@linaro.org>
References: <cover.1564091601.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1564091601.git.amit.kucheria@linaro.org>
References: <cover.1564091601.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move platform_set_drvdata up to avoid an extra 'if (ret)' check after
the call to tsens_register.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 6ed687a6e53c..542a7f8c3d96 100644
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

