Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE082C4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 21:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8CCB20B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 21:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pbbaGh7v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfF0VM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 17:12:27 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36154 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfF0VM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 17:12:26 -0400
Received: by mail-lf1-f68.google.com with SMTP id q26so2544372lfc.3;
        Thu, 27 Jun 2019 14:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1GRslL4EnHGZP4FEUc01VEaloEpJ+EJtnU0AoEc0Vkg=;
        b=pbbaGh7v8ZaYdMpfWw731SoqHCBkkJd3K4JRcapZAxeOyCmYZJLCAvV7KNdim3L2E4
         pMmG68PqCZLhbMJfSWgFO8RbmQsU7gzsJMxCDhjMoUVDfn2YrdjfUMdVqwbZeEK47wTw
         HrWPuNs/fmS5F1u2CsfC6TsEVJOSL/rfmI6Njmzv0J4S3QhTFm9tz174SHMnR+e4b7V8
         t6kAoVixLhE4TCTgunNKxaBCUS39N3Oi2lBgsb1umjNynxEdN8eTiIxC96f9J1stXwgt
         9WKdkJwOw4rimCQo9wDA6AxEvZ0FTArIkePzHkEUBMoLm9Iia0b577PyJ0BNen1F2JS3
         SneQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1GRslL4EnHGZP4FEUc01VEaloEpJ+EJtnU0AoEc0Vkg=;
        b=M7uFeXqH+/SdhZmpgBaCJXlHS3Y/e4gyYzHzYD8/UMT7FAkPvzkslIPp/M98yugZjI
         iN94s8wy6abEBx7DpZm2E1U1gj4gkVlLgj4QPeWjMRCbDBHRHG9T3UFXuIbg3wRO8a92
         lznP9ExSHPHLhkEkxzi+MpoMmeUCii6mgZfgFgznNcrNjdk39sXiAB2buJ8HeZQdvyBG
         kUm7MTdbW1AUtppGI4SkFFFkuybKAPG1ZzvgMZVKevUHlA4tyOdCI8xMHb/LrLW1iB08
         hAe8uXOU9VHe/oP4gGEiOiF1xmKb/qr/0HTBN69qZNMKpWfZV3ZOAmL3gjJFlHx9QVfg
         sdGw==
X-Gm-Message-State: APjAAAW0kGaPbnwNVRi6N4Erk0xTj43fqNqhPQ9fsKZUa+U2o6kT9LnY
        YJNNDJXeVPSmI9bUm3ifM4M=
X-Google-Smtp-Source: APXvYqxwB7CKpzsIWQezXxxnigBcxA7DelaubDIdD2Q804YoqUskH+Po9kFDmky7PrfeeWfDDzE8MQ==
X-Received: by 2002:ac2:5231:: with SMTP id i17mr3178240lfl.39.1561669944456;
        Thu, 27 Jun 2019 14:12:24 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id p29sm30485ljp.87.2019.06.27.14.12.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 14:12:23 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/22] PM / devfreq: tegra30: Change irq type to unsigned int
Date:   Fri, 28 Jun 2019 00:10:54 +0300
Message-Id: <20190627211115.21138-2-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190627211115.21138-1-digetx@gmail.com>
References: <20190627211115.21138-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IRQ numbers are always positive, hence the corresponding variable should
be unsigned to keep types consistent. This is a minor change that cleans
up code a tad more.

Suggested-by: Thierry Reding <thierry.reding@gmail.com>
Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index a6ba75f4106d..a27300f40b0b 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -160,7 +160,7 @@ struct tegra_devfreq {
 
 	struct tegra_devfreq_device devices[ARRAY_SIZE(actmon_device_configs)];
 
-	int irq;
+	unsigned int		irq;
 };
 
 struct tegra_actmon_emc_ratio {
@@ -618,12 +618,12 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 		return PTR_ERR(tegra->emc_clock);
 	}
 
-	tegra->irq = platform_get_irq(pdev, 0);
-	if (tegra->irq < 0) {
-		err = tegra->irq;
+	err = platform_get_irq(pdev, 0);
+	if (err < 0) {
 		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", err);
 		return err;
 	}
+	tegra->irq = err;
 
 	reset_control_assert(tegra->reset);
 
-- 
2.22.0

