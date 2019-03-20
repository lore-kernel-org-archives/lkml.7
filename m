Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 527B2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20BE52186A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="LlyhXyvL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfCTMLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:11:10 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45392 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfCTMLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 08:11:09 -0400
Received: by mail-pf1-f193.google.com with SMTP id v21so1780811pfm.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 05:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=JO0hRtirnbvAuYdx+9sUZT6fK1EoSxICeBDSVE6GYxM=;
        b=LlyhXyvLeRTjzqFsZBwwgqDH0XWjjULMpMGaX1Upp2NtS5m0nksY9ojY9B7XYgjgVq
         Loy72R9AasKPC7RnqkQoJGj1nhvwJijwXBRx7wu/UaIU0SCnQZ/2qNezxLpSxI/I29If
         aqqDvaotELYZO06NB6kekIlT9X7RPaOdqHbGWydnZOJDM0WjN7SUGKvDbvfNheq4dxto
         ZJp8ijLL3hD2e0HaUAOvqcO4o5nqtUruGqsaOvDxCtDNhAUg6FRcoyJ9SFQkqqOPYkVJ
         Uxh9dTcGY2FSkgQA8TiLNEaMM1TvE7nfPHVSobVhMknm6K3rcK3dzfWYKeYqUJZh+rPm
         kaYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JO0hRtirnbvAuYdx+9sUZT6fK1EoSxICeBDSVE6GYxM=;
        b=Vutbz8o8THYJFWnP+I4tQYWid0rajdINP3B4j8pEr0jblpkM+LBCcmdYDnMHU7D6HV
         rEJ1A+Wlj4nAoO2hvQRDTdE6C2BVO2g2EKJbmG5U+GHrkLbeq05H5Hzgh2FYzO5LlJSx
         STmtL6x+AVNoizdudDihzZKmBGw+Xpu/YA6TEJeLGh7AfxR4ORRzMDdT++1Kx0OrUcMA
         t/ZoAghSuM/Ye7P4pa2rLl6LYVGfHTA3kKQKMbQerqOjD/TJIYR7oJFG0J9WkRuQeN9h
         hibXz7ON18MBA3j6XkkLJBd2bNTk8WZSEqIdXsVZkG/H0l66CBJ4Rrq14/n3dH5ugo9g
         krEQ==
X-Gm-Message-State: APjAAAV61MsBpV3NDAXtKeadD8fXoZdfRXjSEJndoQdd4CqhJdm9jGAt
        e7ZmaTrmCY7jGzIGlSrf5ibf3Q==
X-Google-Smtp-Source: APXvYqyL/5BnbR7nIishvW7WPyZqAn8U0OUae4m6BaJBwmYaDhVQO6utmldOTRLWxLJKPePax34eQw==
X-Received: by 2002:a17:902:1101:: with SMTP id d1mr7396376pla.19.1553083868536;
        Wed, 20 Mar 2019 05:11:08 -0700 (PDT)
Received: from localhost.localdomain (118-171-142-96.dynamic-ip.hinet.net. [118.171.142.96])
        by smtp.gmail.com with ESMTPSA id 184sm2729937pff.149.2019.03.20.05.11.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 05:11:07 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Leonard Crestez <leonard.crestez@nxp.com>,
        Pierre-Hugues Husson <phh@phh.me>,
        Stefan Agner <stefan@agner.ch>,
        Beniamino Galvani <b.galvani@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: rn5t618: Constify regulator_desc
Date:   Wed, 20 Mar 2019 20:10:57 +0800
Message-Id: <20190320121057.31167-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regulator_desc never need to be modified, so define them as const as a
hint to the compiler that they can go into .rodata.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/rn5t618-regulator.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/rn5t618-regulator.c b/drivers/regulator/rn5t618-regulator.c
index 790a4a73ea2c..a79c0c43b9f8 100644
--- a/drivers/regulator/rn5t618-regulator.c
+++ b/drivers/regulator/rn5t618-regulator.c
@@ -46,7 +46,7 @@ static const struct regulator_ops rn5t618_reg_ops = {
 		.vsel_mask	= (vmask),				\
 	}
 
-static struct regulator_desc rn5t567_regulators[] = {
+static const struct regulator_desc rn5t567_regulators[] = {
 	/* DCDC */
 	REG(DCDC1, DC1CTL, BIT(0), DC1DAC, 0xff, 600000, 3500000, 12500),
 	REG(DCDC2, DC2CTL, BIT(0), DC2DAC, 0xff, 600000, 3500000, 12500),
@@ -63,7 +63,7 @@ static struct regulator_desc rn5t567_regulators[] = {
 	REG(LDORTC2, LDOEN2, BIT(5), LDORTC2DAC, 0x7f, 900000, 3500000, 25000),
 };
 
-static struct regulator_desc rn5t618_regulators[] = {
+static const struct regulator_desc rn5t618_regulators[] = {
 	/* DCDC */
 	REG(DCDC1, DC1CTL, BIT(0), DC1DAC, 0xff, 600000, 3500000, 12500),
 	REG(DCDC2, DC2CTL, BIT(0), DC2DAC, 0xff, 600000, 3500000, 12500),
@@ -79,7 +79,7 @@ static struct regulator_desc rn5t618_regulators[] = {
 	REG(LDORTC2, LDOEN2, BIT(5), LDORTC2DAC, 0x7f, 900000, 3500000, 25000),
 };
 
-static struct regulator_desc rc5t619_regulators[] = {
+static const struct regulator_desc rc5t619_regulators[] = {
 	/* DCDC */
 	REG(DCDC1, DC1CTL, BIT(0), DC1DAC, 0xff, 600000, 3500000, 12500),
 	REG(DCDC2, DC2CTL, BIT(0), DC2DAC, 0xff, 600000, 3500000, 12500),
@@ -107,7 +107,7 @@ static int rn5t618_regulator_probe(struct platform_device *pdev)
 	struct rn5t618 *rn5t618 = dev_get_drvdata(pdev->dev.parent);
 	struct regulator_config config = { };
 	struct regulator_dev *rdev;
-	struct regulator_desc *regulators;
+	const struct regulator_desc *regulators;
 	int i;
 	int num_regulators = 0;
 
-- 
2.17.1

