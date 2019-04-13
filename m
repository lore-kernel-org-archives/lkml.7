Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDCEC282CE
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 08:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8B7C20869
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 08:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcF9A/A8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfDMI2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 04:28:13 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39042 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbfDMI2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 04:28:09 -0400
Received: by mail-pf1-f193.google.com with SMTP id i17so6242408pfo.6;
        Sat, 13 Apr 2019 01:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fZMH3N6CK8+z2Xeh76BH22qSd9J6H7b7QWjPNtZ5yH0=;
        b=QcF9A/A8vMx+hrAKIk1L/B12F8MZyj3K3eXeFKFS5fYYKqYw6BWEd0Vt54tfFm1qA2
         iW3f84sIMXHEUrUmBDhvMBMgaSXv3ILX3Y43tcXkY949271tbw6+PlQNNuTYrA5IxqSn
         eeCJRS3snztuf/aEHLvhbPk4kcl7aezucD+Ac5UsGfJxUwhBHEQFvg/lwAXSaNObVT9H
         vK3kCCkBGuBrXsopgRd5BhCVRUJWVPnLdB8rx2nqRr6sJ35gtD+72wHvJLqfuxlFnfyV
         HZxSUXntVkD6Pp0WqiWQB0H2mqBX3EX68v9hxMd4LCQNBxTG45rGl9KqfEgu4fq73d3o
         YErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fZMH3N6CK8+z2Xeh76BH22qSd9J6H7b7QWjPNtZ5yH0=;
        b=H487gD/lxoFrHPxZUfRy8JrmMJeI+U63roh1sF95AdEciYjyO6FCq4DNky1twkooSZ
         BwE4uqH+TJ0ZKhW0eydXdyuJmqnrpE8ZINHjH9TGOHIHeAppxd+yCY3I7vOqsc2PKHlL
         m95IrvW2BHJ9Lj1HPevbNR/Nz5lr0chmUQjhLqs3jvzvPUHHxZynBkx1hBgYBbCuq3sP
         s2rgcLq/1ZE3HehrWGikgrVRKncBsoBH1SXAHfbjHsCvk0CjdSYvmB/vlStodo5EHUuv
         QCgDiCo4kwTnLag14rfVCD2wiDDNzoDzYh3reMuU/6x1FPcm/6lB6Y3rLqpcrEeljmE7
         qMwQ==
X-Gm-Message-State: APjAAAV7mQxHCwCjlbCsq4K6r6g86dSOKxgam96CSt1oNYD7GceuzMq7
        mh8yd27fnnSnf6prolKF0M5xSAk9
X-Google-Smtp-Source: APXvYqxsESwLkAnf+JoVYH/W1xMrgqPWMok5GI7R8rqv2My1zQFUSLgVP8JUG8eqbCEEUZm7m15dYw==
X-Received: by 2002:a62:cfc4:: with SMTP id b187mr61258924pfg.130.1555144087322;
        Sat, 13 Apr 2019 01:28:07 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id z20sm58261328pgf.70.2019.04.13.01.28.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Apr 2019 01:28:06 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/12] thermal: qoriq: Add local struct device pointer
Date:   Sat, 13 Apr 2019 01:27:38 -0700
Message-Id: <20190413082748.29990-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190413082748.29990-1-andrew.smirnov@gmail.com>
References: <20190413082748.29990-1-andrew.smirnov@gmail.com>
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

