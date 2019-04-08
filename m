Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD41C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A4DE21473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="YJm8ojcK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfDHMJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 08:09:52 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39393 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfDHMJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 08:09:50 -0400
Received: by mail-pg1-f193.google.com with SMTP id k3so7227037pga.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 05:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A1YfF/hshB2iAfKi6E7SFoea4tGLAi6w3xQRaZZQQqY=;
        b=YJm8ojcKX4tmKx4CERRuPfYYXwTTXQzNWfuA9QtWEMqpC0vS6GhOm5IwHGPE5/oU23
         ipOOtmRnfMKoqMl+rIfEQqHuDhfgvm0Xn5Xvb+ablreuBTzoUiViQvRuMxjVuLnTBopY
         tqEalZlsqZBV9Yx2P56z4tsn8w3pLXsuiQFO9xlqVJyMXctOJbPqaMm1lz3ob5xSRpqx
         1m8GL0ZO+mdIadFnNyL1l680uIk0ZbUTmD7k7yGHuPXmsP4aFwlNxkSeeeJ8r3RPFA5Y
         jns5k1gvzXLzpAZ/2iZmGvimX3VmRplKwopi1B8zkuLdbm4UiouDIc1ELrffrkn8elsJ
         6/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A1YfF/hshB2iAfKi6E7SFoea4tGLAi6w3xQRaZZQQqY=;
        b=kreokBeGh7Btd74YA4AUk37JUF3GtWFs604l193qsRV2ROOP94oSq0SN3v7iXGs/hZ
         0DV0SIjTjvtMnUEbggq6R0vgT4wereR3WEs2Yr5CZ6KpEo45W5ocaL6/UtJGqraMajFE
         s9myI+ZzqA7jBX18h7cS7f0H3BCUhMPKiq3GRR+bQd6Vre0R2nrJvP3E5MMQfBWJVsQq
         Tf4QhqQtY57MKvBR7RaTI7Cg9Fn3BUV/MaPOqiqGo12V5xKVP8LYgZqcC0cn6Ge9O5K3
         ntnscOpGVLE6w3VPz4EXAaDibTew9a6J+fZTfhxui0KmhLXhCNFVnTtBMqhChkFdUIY8
         zVnw==
X-Gm-Message-State: APjAAAV6ubc7OhtLOn7gNSWnrC2IJk+4a78oYzA1iKY7nldSGtQYln39
        weTAB+eD4Vwv9Y+2V3hSCqwF9Q==
X-Google-Smtp-Source: APXvYqzuYXU9bO1U4J1MUDixR1cGWREWtzLpYkjGkx3HUGbqFoR1xb93AembeLSIOfTugEMwfxtdJw==
X-Received: by 2002:a63:ef09:: with SMTP id u9mr28156423pgh.126.1554725389931;
        Mon, 08 Apr 2019 05:09:49 -0700 (PDT)
Received: from localhost.localdomain (36-239-234-159.dynamic-ip.hinet.net. [36.239.234.159])
        by smtp.gmail.com with ESMTPSA id a17sm50006562pfj.123.2019.04.08.05.09.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 05:09:49 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Chen Feng <puck.chen@hisilicon.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] regulator: hi655x: Remove ctrl_mask field from struct hi655x_regulator
Date:   Mon,  8 Apr 2019 20:09:33 +0800
Message-Id: <20190408120933.29945-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190408120933.29945-1-axel.lin@ingics.com>
References: <20190408120933.29945-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rdev->desc->enable_mask setting is always the same as
BIT(regulator->ctrl_mask), so just use rdev->desc->enable_mask instead.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/hi655x-regulator.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/regulator/hi655x-regulator.c b/drivers/regulator/hi655x-regulator.c
index 460ae70d8b04..6f6635daa026 100644
--- a/drivers/regulator/hi655x-regulator.c
+++ b/drivers/regulator/hi655x-regulator.c
@@ -28,7 +28,6 @@
 struct hi655x_regulator {
 	unsigned int disable_reg;
 	unsigned int status_reg;
-	unsigned int ctrl_mask;
 	struct regulator_desc rdesc;
 };
 
@@ -77,22 +76,18 @@ enum hi655x_regulator_id {
 static int hi655x_is_enabled(struct regulator_dev *rdev)
 {
 	unsigned int value = 0;
-
 	struct hi655x_regulator *regulator = rdev_get_drvdata(rdev);
 
 	regmap_read(rdev->regmap, regulator->status_reg, &value);
-	return (value & BIT(regulator->ctrl_mask));
+	return (value & rdev->desc->enable_mask);
 }
 
 static int hi655x_disable(struct regulator_dev *rdev)
 {
-	int ret = 0;
-
 	struct hi655x_regulator *regulator = rdev_get_drvdata(rdev);
 
-	ret = regmap_write(rdev->regmap, regulator->disable_reg,
-			   BIT(regulator->ctrl_mask));
-	return ret;
+	return regmap_write(rdev->regmap, regulator->disable_reg,
+			    rdev->desc->enable_mask);
 }
 
 static const struct regulator_ops hi655x_regulator_ops = {
@@ -132,7 +127,6 @@ static const struct regulator_ops hi655x_ldo_linear_ops = {
 	},                                                       \
 	.disable_reg = HI655X_BUS_ADDR(dreg),                    \
 	.status_reg = HI655X_BUS_ADDR(sreg),                     \
-	.ctrl_mask = cmask,                                      \
 }
 
 #define HI655X_LDO_LINEAR(_ID, vreg, vmask, ereg, dreg,          \
@@ -155,7 +149,6 @@ static const struct regulator_ops hi655x_ldo_linear_ops = {
 	},                                                       \
 	.disable_reg = HI655X_BUS_ADDR(dreg),                    \
 	.status_reg = HI655X_BUS_ADDR(sreg),                     \
-	.ctrl_mask = cmask,                                      \
 }
 
 static const struct hi655x_regulator regulators[] = {
-- 
2.17.1

