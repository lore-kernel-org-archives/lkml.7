Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 994B2CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69C702084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F20sjx0y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbfJUKfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 06:35:52 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42008 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728212AbfJUKfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 06:35:50 -0400
Received: by mail-pg1-f194.google.com with SMTP id f14so7538140pgi.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 03:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ByQuSAprS9jXkayR9k8WNXgC0XRVOmuonTQ+tfTnFgQ=;
        b=F20sjx0yS3J6Y1j5JsXZ2Gpm20YNzlBp1Q9Sh/pFUqGmdiaOG2MjLbZMFn+mL+S7py
         7Djb+E855QkNZOggjigBXw87iY0cOhXI27sUJwGAlVjCuJi1TaE+qHGoc98Ek08e3cpu
         4vMffBQ+hcVwtddGYa1fPuYCu5mq2MYAL0l/iCEvWK+KdjIORO4pLVmaUmJjBpl8cJp3
         VaDydgsopnGKZJzZ82yjCH4xJNyw//AaQLkLHFubBpHqrwF0IouKcslwojVBzUtI2uaQ
         6r2SqNedzxv7HvJVJ0W+2OjkO81BdXDQfyVuPQoYVOccXuAZLQUY1J6qJhPiQWHpzpj0
         +dmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ByQuSAprS9jXkayR9k8WNXgC0XRVOmuonTQ+tfTnFgQ=;
        b=gbY3gRrcF4/RE4r8veXXVvWPNK2suPArMuJnz6AxbocADCoBrGWgS8LNc4BNEGpqLk
         cVnc60yZuY4QazyZQ6RG+calBKgGM7Wa68hfLgLhA2hCproBMmF0zr0JNJNHXxCxjZOM
         I7nlYXKWX3FX+N4XPBg4SHw4pQzCgYcLWiXDxFUr5mbzfLHtbaC3lSebXG5oqOtMCE89
         Qe7cfRSupiZg7Jaj9VhieIh2l/3rH4q+bXsyL07sByuuiVSXUl2yji/iFmbV4HQIBp2J
         QDzVL28vwiGwpaYIr+6Cnaraz6LFnwDznE/Jk8r0Q1eYq9E6Bcf4jokzYdQmgOEOYNpW
         DZ4w==
X-Gm-Message-State: APjAAAU7cQnPu84OOIFXZ1YvoBVh6iOOsBvvNpZV3VAhBY9QfPPAEQVs
        RwzVAcfDk2GGtW8U4+Ew+ktMK9JxZ/TXcA==
X-Google-Smtp-Source: APXvYqw8mOldgAv9TgODpiePm40wSv2U6xzhPuz5EzTZlRD31gCmwEJm055KUgqDoP55S4P5kUZ1Ow==
X-Received: by 2002:a17:90a:b304:: with SMTP id d4mr28610421pjr.27.1571654149379;
        Mon, 21 Oct 2019 03:35:49 -0700 (PDT)
Received: from localhost ([49.248.62.222])
        by smtp.gmail.com with ESMTPSA id k6sm20516678pfg.162.2019.10.21.03.35.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Oct 2019 03:35:48 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        masneyb@onstation.org, swboyd@chromium.org, julia.lawall@lip6.fr,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v6 02/15] drivers: thermal: tsens: Simplify code flow in tsens_probe
Date:   Mon, 21 Oct 2019 16:05:21 +0530
Message-Id: <184422dcc1c12553e71a58c62e01425fd7d1172a.1571652874.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1571652874.git.amit.kucheria@linaro.org>
References: <cover.1571652874.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1571652874.git.amit.kucheria@linaro.org>
References: <cover.1571652874.git.amit.kucheria@linaro.org>
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

