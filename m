Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE4CC4360D
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 02:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A2A420820
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 02:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="D6HIbcGc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfIVC3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 22:29:48 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38744 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbfIVC3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 22:29:48 -0400
Received: by mail-pf1-f195.google.com with SMTP id h195so6939104pfe.5
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2019 19:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IvKUda3wPP3iGFTGjdewk44E9Cz8OvmVZ56gL+Awvg0=;
        b=D6HIbcGcbVjHy2b7DlBfG9Y+aHK9QL6IyXoebFROZ29uGsG6aIHblPieZ7v6UxUElG
         5pnVfsZDALooIRBm4LBwiDgjxazF9tv0mBz766L1TK3JfFVBIyRen4jiscZ/G4hIx1ao
         ZC6a646ylKmE4GEjaFmg3JX0bTi193Dlt47Q3smyHKTzcQMmKhI9hNE6qBUZHPEv9AQV
         GG1NKH3v0Yc6RcL4SVaC2/nFWeVb+ZPU3wennCi3uSJswOW2ayv8opfg9IEt+cj4h0SF
         u5q5HaGCycT4Wiqel2m4hbKQaAtbBnlNgfGol01IgBwtmvRzFwbKwxWZcfNj4Fa/HwIq
         J6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IvKUda3wPP3iGFTGjdewk44E9Cz8OvmVZ56gL+Awvg0=;
        b=T9gxyJ9b6GrOrMvDv5oy4T4/i9FOaT1oaYLRrDzXVAYGD7Wr1PIZLuLgneQuisB2LO
         YvN6efGTnP8A3NTlnJK9qR5Y30oRwJwdVMBOym+V/R/jqCdi7hriiTapTRO9sLXqGbvI
         lmwv9YPmKwNJhm53EYyONzf/cToxZHV6h7Hw1plpSflZ9Dgu+dua0EMxii+HWhiOPRO+
         HqrStEWX5fNIGMyMJqhpnMUZ+kL8xcxy/veY0xC99LdX5ETTK8aQnd2+LBR4feSbT6/l
         bugYiice67NIEj4S35ax24uf8KM5BxuiIvwRUWyHzpEMXq1wrzWIAE1P/gv8GfFkNOzA
         7L6w==
X-Gm-Message-State: APjAAAU6mIjQgzDXIFBA+tOTLJ1mBrypE2TTHKIwiE5QoNQ+6yyUluOK
        JCtTycyM7yqyQBCtq5NtlhPFwhulpRU=
X-Google-Smtp-Source: APXvYqwGl1aIINKtWYdwPQC4cNT4BuSkU4fku8Fv7Ulxh40F2ddskKnghn4A6szxjTsGvRyimPm98A==
X-Received: by 2002:a17:90b:8cf:: with SMTP id ds15mr5296174pjb.36.1569119385495;
        Sat, 21 Sep 2019 19:29:45 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id h4sm6936386pfg.159.2019.09.21.19.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2019 19:29:44 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Philippe Schenker <philippe.schenker@toradex.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: fixed: Prevent NULL pointer dereference when !CONFIG_OF
Date:   Sun, 22 Sep 2019 10:29:28 +0800
Message-Id: <20190922022928.28355-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use of_device_get_match_data which has NULL test for match before
dereference match->data. Add NULL test for drvtype so it still works
for fixed_voltage_ops when !CONFIG_OF.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/fixed.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
index d90a6fd8cbc7..f81533070058 100644
--- a/drivers/regulator/fixed.c
+++ b/drivers/regulator/fixed.c
@@ -144,8 +144,7 @@ static int reg_fixed_voltage_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct fixed_voltage_config *config;
 	struct fixed_voltage_data *drvdata;
-	const struct fixed_dev_type *drvtype =
-		of_match_device(dev->driver->of_match_table, dev)->data;
+	const struct fixed_dev_type *drvtype = of_device_get_match_data(dev);
 	struct regulator_config cfg = { };
 	enum gpiod_flags gflags;
 	int ret;
@@ -177,7 +176,7 @@ static int reg_fixed_voltage_probe(struct platform_device *pdev)
 	drvdata->desc.type = REGULATOR_VOLTAGE;
 	drvdata->desc.owner = THIS_MODULE;
 
-	if (drvtype->has_enable_clock) {
+	if (drvtype && drvtype->has_enable_clock) {
 		drvdata->desc.ops = &fixed_voltage_clkenabled_ops;
 
 		drvdata->enable_clock = devm_clk_get(dev, NULL);
-- 
2.20.1

