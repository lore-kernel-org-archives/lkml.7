Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4B5C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 12:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B15E420862
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 12:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="olYeCyoX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbfEPMsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 08:48:24 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45555 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbfEPMsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 08:48:24 -0400
Received: by mail-pg1-f194.google.com with SMTP id i21so1511879pgi.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 05:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QFQ0vCTZibp39rtYReGvbZc2l09EkKNU078CqjQxx5k=;
        b=olYeCyoXfwEQrLMwVFfWpx4IHOrCAHCanzOVjHe4n4J2QRYcRooRV1FevhmqFpEKf/
         OmYomktA9RVyb9dBNeZ4EnTsLdWlUEQDlcYGU5jqkWjsMdhuXbrC70QMRixkfOF6vQhG
         5547jFyqbwIgDSFiHpYeRw1Lxgwc3F1AQFVU+Q+fwsxz0yJblFsnrcsZUeqDy33vQcd8
         jCaZ+xUQ8vFvDqwMAe9YnuiUP26IX4LBORVpubGnqFqhfjqtsqSr8MeJy0Wyy52b+3rB
         Y2mbb+v5tYnpjrBYpY2ZJhV4i0KA/hEf7tp+WnSj0VuSYOjOiR60OANFSkjdmOkJStNZ
         KKQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QFQ0vCTZibp39rtYReGvbZc2l09EkKNU078CqjQxx5k=;
        b=JflEWHDoULG1wf4D/LMLqJ+aDQKoe3I95Wzav9TcALWb7e5eGN17vsRyBjeEVD1cjn
         N8yKKnSQj+7JV1n/R53ixiT8CbJ49m7N13BnqWMP18CRPTYmrLwUI4jJ2I35/lC5yPtk
         GzJSFwO5xLFZ5Sfs3upzoZHMhFwkq4xEUaEg7itVuoNVarubXl9Hyert04D9AZ+07b4d
         u52aJc5UnZWjxe3wXVf4X6xAuF8ro/JcsxELVdAkNg/+duwLqIpPTJ66yDRkdUt+Vg3O
         l8gRadmu9hW09sDWZM5/VdbeygtyBHAf/RIsyLoE6Ir68KMDN5EuqPYVYa3XU2br9L7S
         KfSg==
X-Gm-Message-State: APjAAAXHPtWVx1Eu9joNauB9lKHQo0Rg2qOsLx7cJZo0cz3kfLixckrc
        6bwRmwsSF8wvCMfWDFgkfYclaA==
X-Google-Smtp-Source: APXvYqzI7Q6YkT/Fwv3wD+W2jdGIpbuPvF4BgtWUtnZNiwJek6uUqMV8hw3GLu+ixUYNFrhM77rRDA==
X-Received: by 2002:a63:c750:: with SMTP id v16mr49384226pgg.409.1558010903580;
        Thu, 16 May 2019 05:48:23 -0700 (PDT)
Received: from localhost.localdomain (36-239-208-90.dynamic-ip.hinet.net. [36.239.208.90])
        by smtp.gmail.com with ESMTPSA id e16sm4960140pgv.89.2019.05.16.05.48.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 05:48:22 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Sekhar Nori <nsekhar@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH RFT] regulator: tps6507x: Fix boot regression due to testing wrong init_data pointer
Date:   Thu, 16 May 2019 20:48:08 +0800
Message-Id: <20190516124808.3335-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A NULL init_data once incremented will lead to oops, fix it.

Fixes: f979c08f7624 ("regulator: tps6507x: Convert to regulator core's simplified DT parsing code")
Reported-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
Hi Sekhar,
Please check if this patch works, thanks.
Axel
 drivers/regulator/tps6507x-regulator.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/tps6507x-regulator.c b/drivers/regulator/tps6507x-regulator.c
index a1b7fab91dd4..d2a8f69b2665 100644
--- a/drivers/regulator/tps6507x-regulator.c
+++ b/drivers/regulator/tps6507x-regulator.c
@@ -403,12 +403,12 @@ static int tps6507x_pmic_probe(struct platform_device *pdev)
 	/* common for all regulators */
 	tps->mfd = tps6507x_dev;
 
-	for (i = 0; i < TPS6507X_NUM_REGULATOR; i++, info++, init_data++) {
+	for (i = 0; i < TPS6507X_NUM_REGULATOR; i++, info++) {
 		/* Register the regulators */
 		tps->info[i] = info;
-		if (init_data && init_data->driver_data) {
+		if (init_data && init_data[i].driver_data) {
 			struct tps6507x_reg_platform_data *data =
-					init_data->driver_data;
+					init_data[i].driver_data;
 			info->defdcdc_default = data->defdcdc_default;
 		}
 
-- 
2.20.1

