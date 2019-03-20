Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0F6C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 665002184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MPJczgOj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfCTNTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 09:19:47 -0400
Received: from mail-pf1-f175.google.com ([209.85.210.175]:43101 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728340AbfCTNTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 09:19:44 -0400
Received: by mail-pf1-f175.google.com with SMTP id c8so1914753pfd.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 06:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=eZLwZQ47wxuBvZ6q3TSPmW1vGKe2aF0HDy1rDpmd+Ss=;
        b=MPJczgOjJmUhBYQKoKbU9bSLhArNwopkax7JT3vEzUuzHHXtHc5SqXNp4Z/+WxqfJT
         Q2ear0E8F0Jh/QdKFj5Aw2KrlqV91QxPI2IY9JDfIJMJykPADdp35v4LHhdalnzTe/kM
         ti+gcvVNMljW1LQhXZctmSGj46N4QAsWwMXdLoqYwOL5KsACR1sFtG1kuEUmQIcPD4wo
         zYiDYIJxgsxzPHWlOIsygC+2KQYlvYIlw07eQgPGxor6O6hEh1mZFuPVgVitFE9Hd7SZ
         Phakx9HpIn4g3zI7iYyXMDvM/F73ZcV47wEnZRaLe2cNiWpp23DCG4hgkEl7kyCfl4L4
         p67w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=eZLwZQ47wxuBvZ6q3TSPmW1vGKe2aF0HDy1rDpmd+Ss=;
        b=HCWu+wwFZNhA9+pDfF4DfnaQxqH/IQNlTi12bEQjxq8mTGAtkfUGgC0nUh9NdUv4Ua
         FAGx2FQdDLj8jfluZ3GOyJ3yD52AwZfeilMw+pwnXH1oi7GepWeKNd4+QhqJbnPfUFFh
         eb9jUGOsQyD7MdBg62JfBjNKDdppzPOFXEZXc1WXU5w+Mm12JrFUkxVxztY6i3lxk94K
         G+aY/xOWjOWPJZfHXhVaDhVZPt20wTyl1sXmFqunq/OpzgyPkcj1ak1jiVAZKx+3J0ia
         N8RYKtePuXsgAXrCqtI5oiyev7Oq47GnJIFbCpmFXVAmk7TcpQEuYl8teelXf/DBcBX9
         Xtew==
X-Gm-Message-State: APjAAAV3Zj+h+IW4wjGBn7rw81w5ogsol3S1HG1S1ZRfrCxkkb/eBqhL
        LtbUabuB54tDhq95EwSguOAztcxJp7s=
X-Google-Smtp-Source: APXvYqxbu6+O95110vR8QmoKmdIL1pQ6g1MzuFd/rLIhIf6GM+j37/boX7XzYhSTL49hS9hssBIkbQ==
X-Received: by 2002:a65:5281:: with SMTP id y1mr7598678pgp.59.1553087982607;
        Wed, 20 Mar 2019 06:19:42 -0700 (PDT)
Received: from localhost ([114.143.122.221])
        by smtp.gmail.com with ESMTPSA id a24sm2690021pfn.85.2019.03.20.06.19.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 06:19:41 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCHv3 18/23] drivers: thermal: tsens: Common get_temp() learns to do ADC conversion
Date:   Wed, 20 Mar 2019 18:47:58 +0530
Message-Id: <389f9e70f715e2884418d77c9ff06fad6878eacc.1553086065.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1553086065.git.amit.kucheria@linaro.org>
References: <cover.1553086065.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1553086065.git.amit.kucheria@linaro.org>
References: <cover.1553086065.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_temp() learns to return temperature regardless of whether it is
returned as ADC code or direct temperature.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-common.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index 5adbf1a2e0fb..92747ccb2850 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -129,10 +129,15 @@ int get_temp_tsens_valid(struct tsens_priv *priv, int i, int *temp)
 	if (ret)
 		return ret;
 
-	mask = GENMASK(priv->fields[LAST_TEMP_0].msb,
-		       priv->fields[LAST_TEMP_0].lsb);
-	/* Convert temperature from deciCelsius to milliCelsius */
-	*temp = sign_extend32(last_temp, fls(mask) - 1) * 100;
+	if (priv->feat->adc) {
+		/* Convert temperature from ADC code to milliCelsius */
+		*temp = code_to_degc(last_temp, s) * 1000;
+	} else {
+		mask = GENMASK(priv->fields[LAST_TEMP_0].msb,
+			       priv->fields[LAST_TEMP_0].lsb);
+		/* Convert temperature from deciCelsius to milliCelsius */
+		*temp = sign_extend32(last_temp, fls(mask) - 1) * 100;
+	}
 
 	return 0;
 }
-- 
2.17.1

