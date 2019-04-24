Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71A9C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 977132148D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4AjD9GW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729942AbfDXGsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 02:48:52 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37332 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729907AbfDXGsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 02:48:40 -0400
Received: by mail-pf1-f196.google.com with SMTP id 8so8791615pfr.4;
        Tue, 23 Apr 2019 23:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ro+sSwaq0kb1ZT2GhvuRgwM2VzyusGd+SZ1AlMib2OY=;
        b=j4AjD9GWly30TfxBD7gW3KlF5Zieeqe7XauomttYL+0F9F5PIGD0HfWZsPWfkI3bpc
         k3ZQMFzslz22NRpLmxPUKIoviQcGU0OVewfesqJbz06X2huUdWujWNCgbp62NnCFFHvW
         a+ISkmNAxgnLP/SSFHc4YQXIv2OH3+T9jMObr2RmofcaQBORkF09YQtfn8nR733EkYZJ
         vU9l+mehercjqg0aj6HrabrHwP4clx0+XvbcugO1UuNYj1a3hy2LixDsZfiJyJWZ4ovU
         h5WCpfRBTP+151S75KtZUTBFB0FfvZIbuAQjWRYv8vNAD6uuzrC6EEiutzmFWF1WKeKm
         XWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ro+sSwaq0kb1ZT2GhvuRgwM2VzyusGd+SZ1AlMib2OY=;
        b=G4Sccb0BZQuojnUOiAf656toOTgL2g6KWWxi4Zqg66UISxhNJPfz6t92FxmnT8xqwn
         1h/X0k9irCUJbmo+0pqypz41HRpfy+h30YZfZiHBRAOWalRR/M1y6YZNBuJxIQTtcTlq
         sPJx+OdVIvQvz+EkAM/BSOIODJNxnm99X1qSPWi83o5rtDX1uJadxAggQ7q8oi5kJoDb
         FfJ9Nh8rGjZ4VHuTSyralFevVjThaRjrW6igikcRkXso4nhxaxQJ52pUTKTnz8eLlK32
         iCHwboYv4YKrDBLoIfuDBiOnrXgf/Ern7xxxwl8riD71VpQGib+eX9AsJ7ixVEmwlQV5
         zlUQ==
X-Gm-Message-State: APjAAAWgS728Zd3cSFvQ5VQdUfIjpTO9KNu1P91vdg6NOWWzJR1MKSFE
        QSszLalcAI5ukhSJqQHnvZDAarRSy50=
X-Google-Smtp-Source: APXvYqzIY+BPtVBjOzSeayBQuAk7bci2DtQPUZLyf68tm8O58aIXu7iWssj/h7Z/AOB1zYY4PW+6AA==
X-Received: by 2002:a65:41ca:: with SMTP id b10mr29660852pgq.256.1556088519441;
        Tue, 23 Apr 2019 23:48:39 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id e13sm26332457pgb.37.2019.04.23.23.48.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 23:48:38 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 02/12] thermal: qoriq: Add local struct device pointer
Date:   Tue, 23 Apr 2019 23:48:20 -0700
Message-Id: <20190424064830.18179-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424064830.18179-1-andrew.smirnov@gmail.com>
References: <20190424064830.18179-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a local "struct device *dev" for brevity. No functional change
intended.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Tested-by: Lucas Stach <l.stach@pengutronix.de>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Angus Ainslie (Purism) <angus@akkea.ca>
Cc: linux-imx@nxp.com
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/thermal/qoriq_thermal.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 5828314ec74d..c3ed6ed81dfb 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -192,8 +192,9 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 	int ret;
 	struct qoriq_tmu_data *data;
 	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
 
-	data = devm_kzalloc(&pdev->dev, sizeof(struct qoriq_tmu_data),
+	data = devm_kzalloc(dev, sizeof(struct qoriq_tmu_data),
 			    GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
@@ -204,7 +205,7 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 
 	data->regs = of_iomap(np, 0);
 	if (!data->regs) {
-		dev_err(&pdev->dev, "Failed to get memory region\n");
+		dev_err(dev, "Failed to get memory region\n");
 		ret = -ENODEV;
 		goto err_iomap;
 	}
@@ -217,7 +218,7 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 
 	ret = qoriq_tmu_register_tmu_zone(pdev);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to register sensors\n");
+		dev_err(dev, "Failed to register sensors\n");
 		ret = -ENODEV;
 		goto err_iomap;
 	}
-- 
2.20.1

