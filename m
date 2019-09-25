Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD43C432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 10:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE1AE21D7C
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 10:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="VFiCfuf/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388118AbfIYKNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 06:13:30 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40725 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfIYKN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 06:13:29 -0400
Received: by mail-pg1-f195.google.com with SMTP id w10so2936546pgj.7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 03:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/NhZI90rJbGI4ye8q8X1WEIzUsZuKHPxvBAdA5erKpA=;
        b=VFiCfuf/Fu1BTfJ5/fJsYfkwe/XNh2DwW4rW/IICL8GKT0pCRGDYyg8XT+kipHnJXf
         tCuI3GL7AFJ1AApF/k7DGD3yIhpyKjfixt8+tTQcCf54tosJDN3RXrZ6WMJw7arIKC4A
         Jv7MW62kM938u18f1YHkQDzTerqBTf9unuAodagcryrL+WMCooSEoi0RY7AINOyPJPJp
         +d14Jy833/0i6FVl+9boa1eyzJMdSXwn+G5JqbQEBr6Ww1L6ah28OJth137SOpdRVQu9
         X6RSLIAfnHeNojSRSGvx53EQbPVFrtJjAl7J60Ey2GX0ApIXItwI6JkFedkYS/2iNaoA
         Cucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/NhZI90rJbGI4ye8q8X1WEIzUsZuKHPxvBAdA5erKpA=;
        b=j3scKYH4ZBejSabf9OY3AeKbjZueRDOjm8WTZTqzT9eNpS5z1R90DDDAzZXDgNDcxY
         h5/k+F/ZD7INW7Nzgx6ke2GUMKKMq/a/2Z6Fmx0+u8M5x2tJyIlTQm+qqT02uDqghDxx
         2P/x6qcxaJJjrF91ZpWtHcA/hxlQWAGordJlXpovIKTgrFH7RbVuqPE64Bk4xfwIRfOT
         URHTHEgUCdEGzKWUyPqdnw7PR5KuTDEgeFPkbSk+Jp/BjZljcWq1qZucpxlS6LfGH+be
         ssiSgXYMI8jMZOJv7BnrXZ8Fa9pYPk/f2gn3+WBuaqbYfyqu7EL9JbswQzxX7vEdFQIj
         6jNQ==
X-Gm-Message-State: APjAAAUt3UzTps+rmedcRw7yc/LOjbnrl0UUPeA20rQ5vKdrmdP7xqxT
        yK3kOir//nE7WI4OOMdTXCj0zrPDdfY=
X-Google-Smtp-Source: APXvYqxZXGeebmJlZhzAhuETUkGdx+PlzGj71lsc11awN9emPxOFKvb9YyUbgrrOEr0+EYmkJ6fJ7w==
X-Received: by 2002:a17:90a:17cb:: with SMTP id q69mr5453304pja.135.1569406408691;
        Wed, 25 Sep 2019 03:13:28 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id fa24sm2672624pjb.13.2019.09.25.03.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 03:13:27 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Balaji T K <balajitk@ti.com>, Ravikumar Kattekola <rk@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: pbias: Use of_device_get_match_data
Date:   Wed, 25 Sep 2019 18:12:56 +0800
Message-Id: <20190925101256.19030-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use of_device_get_match_data to simplify the code a bit.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/pbias-regulator.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/pbias-regulator.c b/drivers/regulator/pbias-regulator.c
index 92b41a6a4dc2..a59811060bdc 100644
--- a/drivers/regulator/pbias-regulator.c
+++ b/drivers/regulator/pbias-regulator.c
@@ -164,7 +164,6 @@ static int pbias_regulator_probe(struct platform_device *pdev)
 	const struct pbias_reg_info *info;
 	int ret = 0;
 	int count, idx, data_idx = 0;
-	const struct of_device_id *match;
 	const struct pbias_of_data *data;
 	unsigned int offset;
 
@@ -183,9 +182,8 @@ static int pbias_regulator_probe(struct platform_device *pdev)
 	if (IS_ERR(syscon))
 		return PTR_ERR(syscon);
 
-	match = of_match_device(of_match_ptr(pbias_of_match), &pdev->dev);
-	if (match && match->data) {
-		data = match->data;
+	data = of_device_get_match_data(&pdev->dev);
+	if (data) {
 		offset = data->offset;
 	} else {
 		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
2.20.1

