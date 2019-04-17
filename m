Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0521DC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 19:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA08E2173C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 19:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FNfJ5k9a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733084AbfDQTYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 15:24:49 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:45477 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730037AbfDQTYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 15:24:48 -0400
Received: by mail-wr1-f41.google.com with SMTP id s15so33385107wra.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 12:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xbkDshoRwG+I0w+DmgS1Lh94U4IFVKrRkWhOXAIbiIg=;
        b=FNfJ5k9aN8Zj682O9MfPTUexqXnljpSE+IcdsbyHR8l2Bnzxzvg4S8Uo5wSntA01mS
         G2q1ycJGyJz7dZR5V7jZJtnYFQbFl4KGrsKqew9O3m7FJpxIKfBxQLMLwj80+I+GxCK8
         Z3cRfzvNHpsG8qtuH5QkWb0fCFOOm6rxampqAk+GWH7ioBIzn4x4H16z10fV6jLIP8hk
         23AAkndgENtkGk3VL4KvGyn4ROjQ5IBnxpaGopwqSQLaXVjbZB2LzPxdC42JyHCnE12o
         UFF5qnlNr4nXFQQQUqGNQpoUBI+x+fSLLUvkCgsfMPXC+DRiY//E2uxCVBySEu7a+Y/y
         nKrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xbkDshoRwG+I0w+DmgS1Lh94U4IFVKrRkWhOXAIbiIg=;
        b=pPr3LmUzJjEBsnT40FIrXE4g0llQZZ8lH0XWTKLi8gO9bksp1gUNZz4xzF+i9f1Uhw
         op9WKWzTGu9mt4Kyd5aM6K0/74BFQsYRayvT49HFdJGP/nKBfc2HNJJ7lsrR+xxLEGt7
         OpPHMEBzLnaSVaatVYGkKvQOViXlXX29ZcK38wUIaTY2TfDCkSjqBTIHX5mW/J1AK+g0
         dGPyd+QYE1ISoayT9ldItO97Gw16cy7rMR6Ec0WsgiwRH3MQeIcZ0xVwwNO++j4Ss/la
         6uqeC0KNNULcWwcnSOfOey3/zDGUSMwr1uo4f7xlHOkXiizFeXxYJFgEWMcG66KEeaOI
         X3/A==
X-Gm-Message-State: APjAAAXgh+DRrCnRhjmjoup52coFt+oqrdQ40G1+qY6pB7isj8b604En
        5jUonEvu+qMAsHj6UP77NlDFOg==
X-Google-Smtp-Source: APXvYqx+6GfTYL6uoPD6e0+k9tHnAgsXxxt339BV3J+oJyx4/Zgk7ewFPDr1b1fgk4dzJpuEyADWHg==
X-Received: by 2002:adf:f390:: with SMTP id m16mr4529765wro.25.1555529086982;
        Wed, 17 Apr 2019 12:24:46 -0700 (PDT)
Received: from localhost.localdomain (200.red-83-34-200.dynamicip.rima-tde.net. [83.34.200.200])
        by smtp.gmail.com with ESMTPSA id y9sm95076745wrn.18.2019.04.17.12.24.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Apr 2019 12:24:46 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        khasim.mohammed@linaro.org
Subject: [PATCH v2] regulator: core: do not report EPROBE_DEFER as error but as debug
Date:   Wed, 17 Apr 2019 21:24:43 +0200
Message-Id: <20190417192443.6501-1-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Temporary failures to get a regulator (EPROBE_DEFER) should be logged
as debug information instead of errors.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 drivers/regulator/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 186a37675b50..a2725269a94a 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4342,8 +4342,6 @@ int regulator_bulk_get(struct device *dev, int num_consumers,
 						      consumers[i].supply);
 		if (IS_ERR(consumers[i].consumer)) {
 			ret = PTR_ERR(consumers[i].consumer);
-			dev_err(dev, "Failed to get supply '%s': %d\n",
-				consumers[i].supply, ret);
 			consumers[i].consumer = NULL;
 			goto err;
 		}
@@ -4352,6 +4350,13 @@ int regulator_bulk_get(struct device *dev, int num_consumers,
 	return 0;
 
 err:
+	if (ret != -EPROBE_DEFER)
+		dev_err(dev, "Failed to get supply '%s': %d\n",
+			consumers[i].supply, ret);
+	else
+		dev_dbg(dev, "Failed to get supply '%s', deferring\n",
+			consumers[i].supply);
+
 	while (--i >= 0)
 		regulator_put(consumers[i].consumer);
 
-- 
2.21.0

