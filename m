Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EDFC48BDB
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 22:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA1E820684
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 22:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dq658kTn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbfGGWfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 18:35:07 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42172 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727820AbfGGWfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 18:35:06 -0400
Received: by mail-qk1-f194.google.com with SMTP id 201so9736274qkm.9;
        Sun, 07 Jul 2019 15:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1GRslL4EnHGZP4FEUc01VEaloEpJ+EJtnU0AoEc0Vkg=;
        b=Dq658kTnH+bJmzzKQebxCm6H/b9auU3+xHq6E4Vyg8NWPr8ZkjuE/DSv89Xa+tBDPI
         fp/KIMEdyPRsjy/+/cCpv79CWzJAjx2eIRmK3P+H/suzHPe8IBYx0NsPvnyo88u/2+bC
         Vdi6wxkkuJShGaPt/Oy9/O+ycJECF4F2W58NKn9cJumIzij5uYTQBWkghBId/7q9VYL2
         3mAYBPoPFcznzz4cvASpU2WK4XBr5lBJWIrZU+S2RJqX0EykEIlR6q8olEk9UcBBpr1M
         MQcwjFX7FOzwld2aOgSz2QOH61l6Ih4N97WY90JGRIzreDIvld8PRX+wdvacOOGxQHrT
         DiWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1GRslL4EnHGZP4FEUc01VEaloEpJ+EJtnU0AoEc0Vkg=;
        b=ChkDmOXCju1B927M8iVGHQ+vviFD3LzT03AiRC3nq88N5g6Z3h3eqSDKfyHC+EPhIz
         Qw3Bw5KzJfW3x7Gif1oEYXfFZ7QjCFUKqhvckyqJGefFZbRvLXK1VZ2a6xPcrtt02MyR
         fksvHXa9K+e8d3BK3LApHaJH3kxBuNdjH933x8AgUD9VnIuC+fVbtVhFUFYLX8Mf9PWr
         L7zylNQ2ElAtiVjFTb3kqkmhCBcDrFyhBbXcBtjW5ZUxIsip7uQ1ukJKNZ7AJwqIawHT
         3tHG87Y7TgNaYRJ0kbyzgbuQzP+E5A3eywKsjD9pj9o3UO/Rczia11SFXt0xTK+xM0Nh
         //Xw==
X-Gm-Message-State: APjAAAVcXKq12saoHucXiqDH6CS8Zs0QIRXJ2TSv9MM+T8Oe6u+prdtk
        JclGnte5Sli0DiIXQqQM/Jc=
X-Google-Smtp-Source: APXvYqz76uLnxjafUBM8ZO38/c1vs0QZRfmgCmsQBNAxgX+a9o7Rr/QQXuIrld/Vmigs4TG7ehRvkw==
X-Received: by 2002:a37:a94:: with SMTP id 142mr10923891qkk.89.1562538904833;
        Sun, 07 Jul 2019 15:35:04 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id p4sm6998453qkb.84.2019.07.07.15.35.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jul 2019 15:35:04 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 01/24] PM / devfreq: tegra30: Change irq type to unsigned int
Date:   Mon,  8 Jul 2019 01:32:40 +0300
Message-Id: <20190707223303.6755-2-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190707223303.6755-1-digetx@gmail.com>
References: <20190707223303.6755-1-digetx@gmail.com>
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

