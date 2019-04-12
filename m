Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5768CC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 231A92171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="LjyO7Ryq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfDLOHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 10:07:23 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46063 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfDLOHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 10:07:20 -0400
Received: by mail-pf1-f196.google.com with SMTP id e24so5196464pfi.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 07:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LFvs6B93AWMpE9a4jl7A5cXw5LlsuQGgpQWwUBBEyYw=;
        b=LjyO7RyqSJXrGTsFsbYNu6/K2L+hviUiOBFipqMjvyBOKmrab6zQ+SHJURyt/54kaX
         6WkZPJohzMPemr3iSVYNsSUmVQxJyMDhu73uNycfGMuadtNWzD2Q9LTKv2ioL8my/awB
         RBWC2gxh1ktiunHzxZ1v1ck1yP1ufOzfnTIil9hO97yBLArSt5oJeB9NBZHCYC/AKDFn
         k3KGC5KTv0ALDKDnUjxkAmK5BtBeEG8+K4LgZEzrhbx9xXPHwO08Os9Zzly4qXvz+0c2
         WX9Tuslell02XSZ3nKgWt3O2VqvTW4u7fEw942z90aPMsf89JFDZ4Y8R3aydrY8btJH1
         HHOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LFvs6B93AWMpE9a4jl7A5cXw5LlsuQGgpQWwUBBEyYw=;
        b=VI4tFdOuLd4m2ZoUXJY6zuIVIPtMfPok+MhmWaOvdPE6cr0Ni9M5RhiDs6/GZaQVnu
         VXopE2oAc3Gg43PpVq7njCDinY8g93aQA8aJDp+oJnPc0Op2M7BG1STMWTsjEcCx9qsM
         KZlaxUoTwnCtZM6Eid/vBb1V2fzFxObkqnyYOGhvn7ex2abn7QI7C0Zumdw1RFzJ+O56
         CyexXjM8X3CdBwnHDKWUJjR5iVR9rIwa3S9wz5WjnmbzqOtqGLwzwi4zCSW+Y7ZC7tKI
         CBNQR2lyc2KlyzqHcYrO5QX6m8LNespHMpqHpMHixv0TcqgXumCCfdlytnk5T0Q66Zgy
         I9lw==
X-Gm-Message-State: APjAAAWBLqRSewjbj23XU/Bjus1qSLBPZHrSlX6FAuYGNtIYSYAU2XU7
        zebIHtox2p4rr69XmmEZ++6AnC+ebEg=
X-Google-Smtp-Source: APXvYqwdqX4QGcHRn70O4gRuDpeExbWjgyGTsYUvRgu0SFjcxbZ9SN0UQwWws65+NMGQTXG5YxhkNw==
X-Received: by 2002:a62:1690:: with SMTP id 138mr57716277pfw.28.1555078040147;
        Fri, 12 Apr 2019 07:07:20 -0700 (PDT)
Received: from localhost.localdomain (36-239-234-188.dynamic-ip.hinet.net. [36.239.234.188])
        by smtp.gmail.com with ESMTPSA id d68sm63862024pfg.16.2019.04.12.07.07.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 07:07:19 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Bengt Jonsson <bengt.g.jonsson@stericsson.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 3/3] regulator: ab8500-ext: Convert to use simplified DT parsing
Date:   Fri, 12 Apr 2019 22:06:58 +0800
Message-Id: <20190412140658.11754-3-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190412140658.11754-1-axel.lin@ingics.com>
References: <20190412140658.11754-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use regulator core's simplified DT parsing code to simplify the driver
implementation.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/ab8500-ext.c | 28 +++++-----------------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/drivers/regulator/ab8500-ext.c b/drivers/regulator/ab8500-ext.c
index 8e5365869c82..95704446d89e 100644
--- a/drivers/regulator/ab8500-ext.c
+++ b/drivers/regulator/ab8500-ext.c
@@ -733,6 +733,7 @@ static struct ab8500_ext_regulator_info
 	[AB8500_EXT_SUPPLY1] = {
 		.desc = {
 			.name		= "VEXTSUPPLY1",
+			.of_match	= of_match_ptr("ab8500_ext1"),
 			.ops		= &ab8500_ext_regulator_ops,
 			.type		= REGULATOR_VOLTAGE,
 			.id		= AB8500_EXT_SUPPLY1,
@@ -750,6 +751,7 @@ static struct ab8500_ext_regulator_info
 	[AB8500_EXT_SUPPLY2] = {
 		.desc = {
 			.name		= "VEXTSUPPLY2",
+			.of_match	= of_match_ptr("ab8500_ext2"),
 			.ops		= &ab8500_ext_regulator_ops,
 			.type		= REGULATOR_VOLTAGE,
 			.id		= AB8500_EXT_SUPPLY2,
@@ -767,6 +769,7 @@ static struct ab8500_ext_regulator_info
 	[AB8500_EXT_SUPPLY3] = {
 		.desc = {
 			.name		= "VEXTSUPPLY3",
+			.of_match	= of_match_ptr("ab8500_ext3"),
 			.ops		= &ab8500_ext_regulator_ops,
 			.type		= REGULATOR_VOLTAGE,
 			.id		= AB8500_EXT_SUPPLY3,
@@ -783,31 +786,13 @@ static struct ab8500_ext_regulator_info
 	},
 };
 
-static struct of_regulator_match ab8500_ext_regulator_match[] = {
-	{ .name = "ab8500_ext1", .driver_data = (void *) AB8500_EXT_SUPPLY1, },
-	{ .name = "ab8500_ext2", .driver_data = (void *) AB8500_EXT_SUPPLY2, },
-	{ .name = "ab8500_ext3", .driver_data = (void *) AB8500_EXT_SUPPLY3, },
-};
-
 static int ab8500_ext_regulator_probe(struct platform_device *pdev)
 {
 	struct ab8500 *ab8500 = dev_get_drvdata(pdev->dev.parent);
 	struct ab8500_regulator_platform_data *pdata = &ab8500_regulator_plat_data;
-	struct device_node *np = pdev->dev.of_node;
 	struct regulator_config config = { };
 	struct regulator_dev *rdev;
-	int i, err;
-
-	if (np) {
-		err = of_regulator_match(&pdev->dev, np,
-					 ab8500_ext_regulator_match,
-					 ARRAY_SIZE(ab8500_ext_regulator_match));
-		if (err < 0) {
-			dev_err(&pdev->dev,
-				"Error parsing regulator init data: %d\n", err);
-			return err;
-		}
-	}
+	int i;
 
 	if (!ab8500) {
 		dev_err(&pdev->dev, "null mfd parent\n");
@@ -843,10 +828,7 @@ static int ab8500_ext_regulator_probe(struct platform_device *pdev)
 
 		config.dev = &pdev->dev;
 		config.driver_data = info;
-		config.of_node = ab8500_ext_regulator_match[i].of_node;
-		config.init_data = (np) ?
-			ab8500_ext_regulator_match[i].init_data :
-			&pdata->ext_regulator[i];
+		config.init_data = &pdata->ext_regulator[i];
 
 		/* register regulator with framework */
 		rdev = devm_regulator_register(&pdev->dev, &info->desc,
-- 
2.17.1

