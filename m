Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057F8C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C28A320656
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pwZkHJZb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729965AbfDXGtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 02:49:18 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37384 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfDXGtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 02:49:15 -0400
Received: by mail-pf1-f193.google.com with SMTP id 8so8792431pfr.4;
        Tue, 23 Apr 2019 23:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WlG7d4QBTialW5xVs7obyd+KnKSwIPwM0LL6EORsTOM=;
        b=pwZkHJZb0U0MnP8CGbfsq0XHBhH1GIyWbL3idLKifqSsnMCaqOHU+GdatcStCZWqBq
         TJyL499vKcxWfJLrd3HvX1StjiRkm0iH1p544tpjYSvRPRxTHRfj6BGCq2p23fc2Ybso
         hLrRfTlgLUFcA9ZlualIeq8LWGudMHa/waEbD7WMJkqwOqOSTw/CTrPWWGvBbeAFqPzy
         ctMgweFFmH8jiBlyyEGqJI5c51gRNRhKx46mAfLSoPwLJE8zgNR+YL5NNhhgzy0klN3+
         rQ25qvCYh82QxhYsdmdgowEzDnE/6rHlytVrMymDOh5MAeU8sKCnoo6Nv/GTqaYpdVv1
         i3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WlG7d4QBTialW5xVs7obyd+KnKSwIPwM0LL6EORsTOM=;
        b=MR9T1Gu8DyayfjGyc/4Fk9jc12BmYP+iug7z/GqE/vyqNmWJbuDQpnzlTtE75SKHvz
         ManZHHJqYVfUdbrC7q2Na/cKAGIjEVCAR6rxQuF9O5/uD1a70J3CKcAIqlMJzIwePGL0
         vtTj8jvyH7iADgBiobDXt3I76UZgXSHEsBC82uDCX3ODjliuFV62nK2XdyGEO0kBqlmO
         ig9r8ZYHH5uchdBPjpAUL0VWVq7fLsGaNXIf5pUIU5ahXx4vAF7OdFK3W2og/GQFaLo+
         zfTLPihu2bUCHczIHr4D7BeICt/A9FNviYOqYlpdj0TmT06FVnD4LZnkyGKOUUp7TssY
         GMHg==
X-Gm-Message-State: APjAAAVEkar6174db9XMpJy/Y+cvL9GadscbE3Iy+sWu6IofW9qhcbVo
        KZrrUc1v89E5pOn1pY1ZPRQVivWQ2X4=
X-Google-Smtp-Source: APXvYqzTzdTTWKkZ3LxiXppkDZJf7UTsi84pWy3MvD2PDQ+w0xEx1m4XUoNAwO1qcQZK2SVx1evgAQ==
X-Received: by 2002:a63:dd58:: with SMTP id g24mr76075pgj.161.1556088554273;
        Tue, 23 Apr 2019 23:49:14 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id e13sm26332457pgb.37.2019.04.23.23.49.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 23:49:13 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 05/12] thermal: qoriq: Pass data to qoriq_tmu_register_tmu_zone() directly
Date:   Tue, 23 Apr 2019 23:48:23 -0700
Message-Id: <20190424064830.18179-6-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424064830.18179-1-andrew.smirnov@gmail.com>
References: <20190424064830.18179-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pass all necessary data to qoriq_tmu_register_tmu_zone() directly
instead of passing a paltform device and then deriving it. This is
done as a first step to simplify resource deallocation code.

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
 drivers/thermal/qoriq_thermal.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 3500e238fe3e..3419505a2f0a 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -95,15 +95,15 @@ static const struct thermal_zone_of_device_ops tmu_tz_ops = {
 	.get_temp_id = tmu_get_temp,
 };
 
-static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
+static int qoriq_tmu_register_tmu_zone(struct device *dev,
+				       struct qoriq_tmu_data *qdata)
 {
-	struct qoriq_tmu_data *qdata = platform_get_drvdata(pdev);
 	int id, sites = 0;
 
 	for (id = 0; id < SITES_MAX; id++) {
 		struct thermal_zone_device *tzd;
 
-		tzd = devm_thermal_zone_of_sensor_register(&pdev->dev, id,
+		tzd = devm_thermal_zone_of_sensor_register(dev, id,
 							   qdata, &tmu_tz_ops);
 		if (IS_ERR(tzd)) {
 			if (PTR_ERR(tzd) == -ENODEV)
@@ -198,7 +198,7 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_tmu;
 
-	ret = qoriq_tmu_register_tmu_zone(pdev);
+	ret = qoriq_tmu_register_tmu_zone(dev, data);
 	if (ret < 0) {
 		dev_err(dev, "Failed to register sensors\n");
 		ret = -ENODEV;
-- 
2.20.1

