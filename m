Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C146C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 14:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FE7C20652
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 14:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="Y0uiQOIM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfEBOWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 10:22:50 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42832 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfEBOWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 10:22:48 -0400
Received: by mail-pf1-f194.google.com with SMTP id 13so894538pfw.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 07:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p52l1JMUqVjpIIvQ0IK0bbhCnN8h7Sg7nAN5A6Bw+JE=;
        b=Y0uiQOIMqnqE6oMTZhIB0z8XhBL3gXPsZSu8xLloaiAArPYDjPvbKhJ+vWCAgggpef
         Miu5Grf8igU2g1xDSWA9rade5GE+yRJ3AE5l9Bmbb/JRY1eP8tAVzkffkVfHbhXWJQ8c
         H5cA2CIZJLg6LgiRCIwPBaht+chqKmg6hpEFIBqsF+YnXtfotRR5IXOeVCs8KIlX7msC
         xQpnydczRs91FhQGbokFk+TTF/GVWNFwrgLZFt8c0xPACphFkSUYt5C5ptXsj5I77ADB
         Pa0mBqzcX5sC8JP5Hn90I701o3EFfCHk+6Qdt9BX2ny4ktbcVj4aWnhQhw7ZEI3SYZ/p
         o82g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p52l1JMUqVjpIIvQ0IK0bbhCnN8h7Sg7nAN5A6Bw+JE=;
        b=lyyCe6Orqhp9KKBZd4Lav4WoNypWJK8h+hrAiDDoPqsdFjQaXhcZG+aTmzCKJTI/JS
         pVfT/lHnYN6vjDg/mQBG0BvcG6JBToo9KsU06+dDLD8GVMiFtRT/CTfkRW65L6CcNAP8
         RIZtFpCb/I6yYfyAI6I3QGuV6bLVEwdwrE6CiK+yCJyvrUhLIzks2QhghkTthcNF2xIQ
         mXcJueC9o4SlKt2voEeuIAuKC19d3cN9C2z76CuFFCHXrXkzDanUNInmz/1RjJkB8CiZ
         2wgw0gfXP7J0GE6of9f2hXjWPsiwgZskluddEx002rYLy1zc4OjSGzxIRVPyXFJDYQRq
         plQw==
X-Gm-Message-State: APjAAAWg5+B8zohgnjRNOVvko11EDnnlA8gkPx+piGD9A2vJjJaAdqmy
        bQ315+zWElijP5CWdPjRYiuZJA==
X-Google-Smtp-Source: APXvYqyu/e4RWaWvf7otpYJVDOsJro3ZZzUK1coEjmRtSngjFCUfKRL/87LbY2pNbeAHWGBJ39j1rA==
X-Received: by 2002:a63:d713:: with SMTP id d19mr4306145pgg.145.1556806967627;
        Thu, 02 May 2019 07:22:47 -0700 (PDT)
Received: from localhost.localdomain (36-239-226-61.dynamic-ip.hinet.net. [36.239.226.61])
        by smtp.gmail.com with ESMTPSA id h127sm64750452pgc.31.2019.05.02.07.22.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 07:22:46 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] regulator: ab3100: Set fixed_uV instead of min_uV for fixed regulators
Date:   Thu,  2 May 2019 22:22:33 +0800
Message-Id: <20190502142233.24730-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502142233.24730-1-axel.lin@ingics.com>
References: <20190502142233.24730-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Slightly better readability by setting fixed_uV instead of min_uV.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/ab3100.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/ab3100.c b/drivers/regulator/ab3100.c
index edde907a7062..438509f55f05 100644
--- a/drivers/regulator/ab3100.c
+++ b/drivers/regulator/ab3100.c
@@ -354,7 +354,6 @@ static int ab3100_get_voltage_regulator_external(struct regulator_dev *reg)
 }
 
 static const struct regulator_ops regulator_ops_fixed = {
-	.list_voltage = regulator_list_voltage_linear,
 	.enable      = ab3100_enable_regulator,
 	.disable     = ab3100_disable_regulator,
 	.is_enabled  = ab3100_is_enabled_regulator,
@@ -401,7 +400,7 @@ ab3100_regulator_desc[AB3100_NUM_REGULATORS] = {
 		.n_voltages = 1,
 		.type = REGULATOR_VOLTAGE,
 		.owner = THIS_MODULE,
-		.min_uV = LDO_A_VOLTAGE,
+		.fixed_uV = LDO_A_VOLTAGE,
 		.enable_time = 200,
 	},
 	{
@@ -411,7 +410,7 @@ ab3100_regulator_desc[AB3100_NUM_REGULATORS] = {
 		.n_voltages = 1,
 		.type = REGULATOR_VOLTAGE,
 		.owner = THIS_MODULE,
-		.min_uV = LDO_C_VOLTAGE,
+		.fixed_uV = LDO_C_VOLTAGE,
 		.enable_time = 200,
 	},
 	{
@@ -421,7 +420,7 @@ ab3100_regulator_desc[AB3100_NUM_REGULATORS] = {
 		.n_voltages = 1,
 		.type = REGULATOR_VOLTAGE,
 		.owner = THIS_MODULE,
-		.min_uV = LDO_D_VOLTAGE,
+		.fixed_uV = LDO_D_VOLTAGE,
 		.enable_time = 200,
 	},
 	{
-- 
2.20.1

