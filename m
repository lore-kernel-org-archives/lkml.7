Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FD4C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A56032184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="APhtF+fQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbfCTNSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 09:18:47 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36011 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728150AbfCTNSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 09:18:44 -0400
Received: by mail-pf1-f195.google.com with SMTP id p10so1933503pff.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 06:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=081b2WykrwcmfZxREyFy0rYtvIRmQI0giDh8mi53WU0=;
        b=APhtF+fQy9zajyek1wjxwkdSFjGJHyZgmJYPdiag42a9PW9HqSIWH+HWAYNujKgeUM
         cHuX+Ufg7sIBA5bZXKSYKAv4TXg0L9xW9s1DGSsJB/13IWxtdBgAOXRFy6E11L83fCb5
         cH04ZgXjMTxwpM7R/3AkmImHMatVQDCJ6xF+FwIHVH+e1SYZv6jOap5KzpZLuU94r65Y
         MXACy3Q55Pt9v8OqehXNjFn1C0XfU1upr/3awR7fhu2x934dWqOxi1Fo90/a0ORNGayJ
         2cmAn3cjIJgLXU7qps010YhSv/kHwukt2fECbHUJOBIfk4RyrzAGTuJqG3zhVFpnkbsU
         C5WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=081b2WykrwcmfZxREyFy0rYtvIRmQI0giDh8mi53WU0=;
        b=kHtzAWiuAT4Kf+E73+x/lH3t7oZvz+5R9+RyBoul4t98ZU/XABgX8EsaTj42P+IjXg
         uj9HTYj9806oueAiYwt27jpQ7P9YflA3MKnPykJmHzzHcDkxkk2DhfpPXwKYN+WD+SiE
         +8fT8IYy1eJDwOUHb+tA0pnDxYkn6Opn5zKRaEosOehiRZpsxONEa607ikyvzdxYkVAn
         4u5Cg0drHoXKsPo2AKilNe6y3yq6I3XJ9Rn0OjzyvyZ8jKoH3vPgOUAyPFNyG9sgPCvi
         OMEe/h4Dh1QgtrzmRvsf41cPEKnBsILKhY+WJaxAzuzsP2Tdi5GTn21B+2i9AomCC33E
         /tVQ==
X-Gm-Message-State: APjAAAV7Etk2DftVd8c/22wy9ex8Hgpw1UAhk+4psoGj9pE1AkjIQttQ
        /1/dsOUY1l9XScW38E10H/zIQp4h+Io=
X-Google-Smtp-Source: APXvYqx+qIZRHlxT1gbx5cVq+OErFaoo/HtW5LL3CzXUQcNvPGo2aRrBbjxzuA43EfJsTs2W81WOkQ==
X-Received: by 2002:a62:ed08:: with SMTP id u8mr7644659pfh.200.1553087923408;
        Wed, 20 Mar 2019 06:18:43 -0700 (PDT)
Received: from localhost ([114.143.122.221])
        by smtp.gmail.com with ESMTPSA id l84sm6734764pfb.113.2019.03.20.06.18.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 06:18:42 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCHv3 05/23] drivers: thermal: tsens: Use consistent names for variables
Date:   Wed, 20 Mar 2019 18:47:45 +0530
Message-Id: <3b4b55040759d823ae146e938e01be2e3a72257e.1553086065.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1553086065.git.amit.kucheria@linaro.org>
References: <cover.1553086065.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1553086065.git.amit.kucheria@linaro.org>
References: <cover.1553086065.git.amit.kucheria@linaro.org>
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

