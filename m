Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA33C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 14:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2470A205C9
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 14:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="YdLPiUFz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbfEBOWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 10:22:46 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43776 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfEBOWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 10:22:45 -0400
Received: by mail-pf1-f196.google.com with SMTP id e67so1198023pfe.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 07:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SaC3CyEpnIvyDl6CAhIhixQUIs6TW3hTPrV/tsa7jKQ=;
        b=YdLPiUFz+23S/TEzjzbgk+QjIRunn9ceVTO7eXkw4bP8J/N7AMEUCz4GF+kOt+8H43
         yqoHUil0onwgdjpqyz1drCYD3UyPRqLZyl8zm9Et8i1Baw3FEBQUtZKqqzegXPjliHVL
         Nr1HL6z2TGQUK3o0b/ryywyesEE8XB8m1GcMQTbnwtTm4jgio+f/2+W4OuMT/fwfk6fB
         DJ3rRFXXtwy1CSOXa7/Odsy9fcOjDUygMehG90HUEIHi2BPIy8A+cyqiB4OaKqs3u8e2
         cvh4liwtngh5H/4beEnT6IV4Yf8tYHRArtzyyZNEAcEu5RzotxzXPpDJrMYLKZQ7LAbZ
         wjew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SaC3CyEpnIvyDl6CAhIhixQUIs6TW3hTPrV/tsa7jKQ=;
        b=TKLbUu6BzWPrSwmr1xl1FSxhOxsKfuUpjk/LcMGCXucE9UfC++hQ3C7QWDZe2S1NL4
         5z/oivEgUUj/8uEd0VloK8Xq5Cs9AZREfIWMMNA9ZB/vu8QvwtCrNMB0gfnBArpL7rBH
         7BAuS1dAfOt7iFnzlxsrn1zc0BUFRQMuAVevt+47JIaH8+VuI759kekOMj8PV6BoNZOj
         m9ZhAI8cdHnduOfzkqfvNUazGlcu292x/uwiLxFGfV0auMYwMXiyDucsGCrm6+duZu60
         jNLdjzQsi6zn4zKOp/bV0XaXu/lacVW1HJIFzM1oGxSBqgl9uy0o06kwb8KoS/It+rpD
         2R5A==
X-Gm-Message-State: APjAAAX+QiCsdxrculeieacMEdNFM7L8KSZtsuejDORK+Muuk495NjEa
        Mtz18JFgA6wCvSwkmGgqD94KJA==
X-Google-Smtp-Source: APXvYqyKd4bnuBPmGZR0076mhJ+dFmgZh1uGwig14vOfQseYPw927HHy20YBPd1kn5v5lYZ2FgPB7w==
X-Received: by 2002:aa7:9285:: with SMTP id j5mr4453265pfa.129.1556806964838;
        Thu, 02 May 2019 07:22:44 -0700 (PDT)
Received: from localhost.localdomain (36-239-226-61.dynamic-ip.hinet.net. [36.239.226.61])
        by smtp.gmail.com with ESMTPSA id h127sm64750452pgc.31.2019.05.02.07.22.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 07:22:44 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] regulator: ab3100: Constify regulator_ops and ab3100_regulator_desc
Date:   Thu,  2 May 2019 22:22:32 +0800
Message-Id: <20190502142233.24730-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These regulator_ops variables and ab3100_regulator_desc array never need
to be modified, make them const so compiler can put them to .rodata.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/ab3100.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/regulator/ab3100.c b/drivers/regulator/ab3100.c
index c92966a79a7e..edde907a7062 100644
--- a/drivers/regulator/ab3100.c
+++ b/drivers/regulator/ab3100.c
@@ -353,14 +353,14 @@ static int ab3100_get_voltage_regulator_external(struct regulator_dev *reg)
 		return 0;
 }
 
-static struct regulator_ops regulator_ops_fixed = {
+static const struct regulator_ops regulator_ops_fixed = {
 	.list_voltage = regulator_list_voltage_linear,
 	.enable      = ab3100_enable_regulator,
 	.disable     = ab3100_disable_regulator,
 	.is_enabled  = ab3100_is_enabled_regulator,
 };
 
-static struct regulator_ops regulator_ops_variable = {
+static const struct regulator_ops regulator_ops_variable = {
 	.enable      = ab3100_enable_regulator,
 	.disable     = ab3100_disable_regulator,
 	.is_enabled  = ab3100_is_enabled_regulator,
@@ -369,7 +369,7 @@ static struct regulator_ops regulator_ops_variable = {
 	.list_voltage = regulator_list_voltage_table,
 };
 
-static struct regulator_ops regulator_ops_variable_sleepable = {
+static const struct regulator_ops regulator_ops_variable_sleepable = {
 	.enable      = ab3100_enable_regulator,
 	.disable     = ab3100_disable_regulator,
 	.is_enabled  = ab3100_is_enabled_regulator,
@@ -385,14 +385,14 @@ static struct regulator_ops regulator_ops_variable_sleepable = {
  * is an on/off switch plain an simple. The external
  * voltage is defined in the board set-up if any.
  */
-static struct regulator_ops regulator_ops_external = {
+static const struct regulator_ops regulator_ops_external = {
 	.enable      = ab3100_enable_regulator,
 	.disable     = ab3100_disable_regulator,
 	.is_enabled  = ab3100_is_enabled_regulator,
 	.get_voltage = ab3100_get_voltage_regulator_external,
 };
 
-static struct regulator_desc
+static const struct regulator_desc
 ab3100_regulator_desc[AB3100_NUM_REGULATORS] = {
 	{
 		.name = "LDO_A",
@@ -499,7 +499,7 @@ static int ab3100_regulator_register(struct platform_device *pdev,
 				     struct device_node *np,
 				     unsigned long id)
 {
-	struct regulator_desc *desc;
+	const struct regulator_desc *desc;
 	struct ab3100_regulator *reg;
 	struct regulator_dev *rdev;
 	struct regulator_config config = { };
@@ -688,7 +688,7 @@ static int ab3100_regulators_probe(struct platform_device *pdev)
 
 	/* Register the regulators */
 	for (i = 0; i < AB3100_NUM_REGULATORS; i++) {
-		struct regulator_desc *desc = &ab3100_regulator_desc[i];
+		const struct regulator_desc *desc = &ab3100_regulator_desc[i];
 
 		err = ab3100_regulator_register(pdev, plfdata, NULL, NULL,
 						desc->id);
-- 
2.20.1

