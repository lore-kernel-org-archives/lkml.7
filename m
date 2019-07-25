Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE53BC76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 22:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D9C222C7B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 22:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GWrdhk3b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbfGYWTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 18:19:52 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36002 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727327AbfGYWTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 18:19:49 -0400
Received: by mail-pf1-f193.google.com with SMTP id r7so23437371pfl.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 15:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=/nFT7aY+11WI394WPKOgkqXda4OYZ0oDO3kCARFs51M=;
        b=GWrdhk3bhTqlZTC/WMAEHdZVfSr4B1Pd39mel3VbpvzuIB7xxk5KSQqNv1k/8hPCJx
         3hXikhSNXs+PC2xSDqGk7UIQSH3UikR06q3iKd3D7TufSYX1didtRDvQxH/u5NqzZJJF
         hUDdCjvIVyTruCcyBN11bd2QNuq2y68AEyi9N7mcuCVo11vSGFhOedZ6nllosGplJrR+
         ikyvS5nf/xhL4TjFRg/6W4gmirbAXLWP2lk8Ex8HDBje033ejKifqvWQuqQrjIIsnPbr
         SDJGnuVk6ZcBawmxMIDMv5n3Y0870eXl03wLInNcxDa4wXaG6bdgCpiBjyoo/a4sTo+U
         3QLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=/nFT7aY+11WI394WPKOgkqXda4OYZ0oDO3kCARFs51M=;
        b=kPcRxApoeBaO7L8HBf+q74VSKZrPkbt+ZljeNlP37hJjw7zxstx6nWXg2yqpvszkm7
         QzgPkLaZv1X+IpzDnAVF0VLAwsXahqiITKbAZFFSQmBssH2BShUCmi59xK4kHMob1IzF
         BhzdDNF8wZqrwitIYpv3Y6rFuPCd/DciDBvucjB694pc+6+Wu6arnOkKaj3FtLvDl9YO
         lD81jbGEQcpJL1dTIjC0cdx2LN7vezghMHEt1JLgbt9EfG1vwFngimgl4wups1LSj24N
         6ZEOW8Cn9FX4ftgKWAg2hyzv8VQMEJNw/nFDj4f73vaGthY4U8yX3fHOZdjOvZGBT6sK
         TqLQ==
X-Gm-Message-State: APjAAAUWv0LL4AmsOWntsA5oeJoT4w5B/JIGLN71FQf5LVhwrXqOXJEF
        JxGTDUxVl+yyzhLlwcggQBSWvRnMTqb/mg==
X-Google-Smtp-Source: APXvYqy/+petdpPmtp/fEJ1LhtS1DTB7+MuTJsAg2Yg3r235rIBZuN2bYRCq1Ur3NWRwmAelhNbnXQ==
X-Received: by 2002:aa7:83ce:: with SMTP id j14mr18579789pfn.55.1564093188189;
        Thu, 25 Jul 2019 15:19:48 -0700 (PDT)
Received: from localhost ([49.248.170.216])
        by smtp.gmail.com with ESMTPSA id z6sm21560243pgk.18.2019.07.25.15.19.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jul 2019 15:19:47 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Andy Gross <agross@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH 14/15] drivers: thermal: tsens: Create function to return sign-extended temperature
Date:   Fri, 26 Jul 2019 03:48:49 +0530
Message-Id: <07de61a57cf2362169d3b128405d7305eb20785f.1564091601.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1564091601.git.amit.kucheria@linaro.org>
References: <cover.1564091601.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1564091601.git.amit.kucheria@linaro.org>
References: <cover.1564091601.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hide the details of how to convert values read from TSENS HW to mCelsius
behind a function. All versions of the IP can be supported as a result.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-common.c | 34 ++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index 7ab2e740a1da..13a875b99094 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -84,13 +84,35 @@ static inline int code_to_degc(u32 adc_code, const struct tsens_sensor *s)
 	return degc;
 }
 
+/**
+ * tsens_hw_to_mC - Return properly sign extended temperature in mCelsius,
+ * whether in ADC code or deciCelsius depending on IP version.
+ * This function handles the different widths of the signed integer across IPs.
+ */
+static int tsens_hw_to_mC(char *str, struct tsens_sensor *s, int field, int temp)
+{
+	struct tsens_priv *priv = s->priv;
+	u32 mask;
+
+	if (priv->feat->adc) {
+		/* Convert temperature from ADC code to milliCelsius */
+		return code_to_degc(temp, s) * 1000;
+	} else {
+		mask = GENMASK(priv->fields[field].msb,
+			       priv->fields[field].lsb) >> priv->fields[field].lsb;
+		dev_dbg(priv->dev, "%s: mask: %d\n", str, fls(mask));
+		/* Convert temperature from deciCelsius to milliCelsius */
+		return sign_extend32(temp, fls(mask) - 1) * 100;
+	}
+}
+
 int get_temp_tsens_valid(struct tsens_sensor *s, int *temp)
 {
 	struct tsens_priv *priv = s->priv;
 	int hw_id = s->hw_id;
 	u32 temp_idx = LAST_TEMP_0 + hw_id;
 	u32 valid_idx = VALID_0 + hw_id;
-	u32 last_temp = 0, valid, mask;
+	u32 last_temp = 0, valid;
 	int ret;
 
 	ret = regmap_field_read(priv->rf[valid_idx], &valid);
@@ -112,15 +134,7 @@ int get_temp_tsens_valid(struct tsens_sensor *s, int *temp)
 	if (ret)
 		return ret;
 
-	if (priv->feat->adc) {
-		/* Convert temperature from ADC code to milliCelsius */
-		*temp = code_to_degc(last_temp, s) * 1000;
-	} else {
-		mask = GENMASK(priv->fields[LAST_TEMP_0].msb,
-			       priv->fields[LAST_TEMP_0].lsb);
-		/* Convert temperature from deciCelsius to milliCelsius */
-		*temp = sign_extend32(last_temp, fls(mask) - 1) * 100;
-	}
+	*temp = tsens_hw_to_mC("get_temp", s, LAST_TEMP_0, last_temp);
 
 	return 0;
 }
-- 
2.17.1

