Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381F2C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F735216C8
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="09u/NxWI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbfFZN1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 09:27:00 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42478 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfFZN06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 09:26:58 -0400
Received: by mail-pg1-f195.google.com with SMTP id k13so1223173pgq.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 06:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CnZRlxMkJ8QWPNCExoXHG85Nud/H8KSWURxzPJNnI3Y=;
        b=09u/NxWIpJ3th6ow4JUZeCOLMM0Tl/q5E0lOQ6y4xG7Gn1eK4XGG/P0tCunKC7D2Hm
         n/b+DyAlvPb9woiEUNm2vUrumM3B8zg8IGlSHu+ciiPzqh1lxuA8JikxSxx5lLHJcfdh
         UxfZwgtZ6PRY2PXsJRe5kFdzwKtDicHF7Psly9etMkN01zztVwGOvrB6dLK2vF0RudUN
         oO3EOnWdcEAwRhAN3+iCZyNmjzYiM6sq5atp8o9H55o67CsfI+kBnj88vggRK/Byzfo7
         umVwJV8hnrIa2QG/JAFfnNwt3H3z2Cl2xYo0K3aVfiPOjpDTbaq5rA/0xYf6b2vJDq88
         K+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CnZRlxMkJ8QWPNCExoXHG85Nud/H8KSWURxzPJNnI3Y=;
        b=uJDD2OLixbNfxRShWe/mxRaZzqxLhvhmP3smN0DT+SmATiv9LMLtzZKJ/B5awJsp58
         pqkJYB34Myb2uz2iURI5djCKIZjPGZQ7RUld+C8saObj1diKCTi0AtdvA9O6hAIobgBB
         e2yX0fd1x+gBLGTDhvG+tGjmGStg47+eVia+I+iV0CFLivkbWUyGPTtUXCKluWBQgLwU
         GF6lvt7fbKc6yYFdrSgS5zxBXUS622ytP3mXBYvcqooAtaFVFRX+OmcGUXeye/4o8N8v
         v9HHUL9cXftI0VxkekEmmHcJLjONjSP3V+br91VCjcd7BqCSPkm1URQ031j6BfBzIxVp
         x5Hg==
X-Gm-Message-State: APjAAAX8UzlGgrf3E+2KrkTSTioYVXNDZDHx3mVqQoI4tHPJ67FJg/dQ
        Y7Mu04ywnxRYi8FFhd6BJ3owNQ==
X-Google-Smtp-Source: APXvYqzWwJpIXMqV5zwqVjQlH3CJe4yRCDJF71dYu539l+5mX6Q6Zq6fRw08rYI6eSHWMLy1vDGMFw==
X-Received: by 2002:a17:90a:2ec2:: with SMTP id h2mr4754493pjs.119.1561555617638;
        Wed, 26 Jun 2019 06:26:57 -0700 (PDT)
Received: from localhost.localdomain (36-239-239-167.dynamic-ip.hinet.net. [36.239.239.167])
        by smtp.gmail.com with ESMTPSA id a21sm28649147pfi.27.2019.06.26.06.26.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 06:26:57 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Dan Murphy <dmurphy@ti.com>, Milo Kim <milo.kim@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [RFT][PATCH 2/2] regulator: lm363x: Fix n_voltages setting for lm36274
Date:   Wed, 26 Jun 2019 21:26:32 +0800
Message-Id: <20190626132632.32629-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190626132632.32629-1-axel.lin@ingics.com>
References: <20190626132632.32629-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the datasheet http://www.ti.com/lit/ds/symlink/lm36274.pdf:
Table 23. VPOS Bias Register Field Descriptions VPOS[5:0]:
VPOS voltage (50-mV steps): VPOS = 4 V + (Code × 50 mV), 6.5 V max
000000 = 4 V
000001 = 4.05 V
:
011110 = 5.5 V (Default)
:
110010 = 6.5 V
110011 to 111111 map to 6.5 V

So the LM36274_LDO_VSEL_MAX should be 0b110010 (0x32).
The valid selectors are 0 ... LM36274_LDO_VSEL_MAX, n_voltages should be
LM36274_LDO_VSEL_MAX + 1. Similarly, the n_voltages should be
LM36274_BOOST_VSEL_MAX + 1 for LM36274_BOOST.

Fixes: bff5e8071533 ("regulator: lm363x: Add support for LM36274")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/lm363x-regulator.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/lm363x-regulator.c b/drivers/regulator/lm363x-regulator.c
index e4a27d63bf90..4b9f618b07e9 100644
--- a/drivers/regulator/lm363x-regulator.c
+++ b/drivers/regulator/lm363x-regulator.c
@@ -36,7 +36,7 @@
 
 /* LM36274 */
 #define LM36274_BOOST_VSEL_MAX		0x3f
-#define LM36274_LDO_VSEL_MAX		0x34
+#define LM36274_LDO_VSEL_MAX		0x32
 #define LM36274_VOLTAGE_MIN		4000000
 
 /* Common */
@@ -226,7 +226,7 @@ static const struct regulator_desc lm363x_regulator_desc[] = {
 		.of_match	= "vboost",
 		.id             = LM36274_BOOST,
 		.ops            = &lm363x_boost_voltage_table_ops,
-		.n_voltages     = LM36274_BOOST_VSEL_MAX,
+		.n_voltages     = LM36274_BOOST_VSEL_MAX + 1,
 		.min_uV         = LM36274_VOLTAGE_MIN,
 		.uV_step        = LM363X_STEP_50mV,
 		.type           = REGULATOR_VOLTAGE,
@@ -239,7 +239,7 @@ static const struct regulator_desc lm363x_regulator_desc[] = {
 		.of_match	= "vpos",
 		.id             = LM36274_LDO_POS,
 		.ops            = &lm363x_regulator_voltage_table_ops,
-		.n_voltages     = LM36274_LDO_VSEL_MAX,
+		.n_voltages     = LM36274_LDO_VSEL_MAX + 1,
 		.min_uV         = LM36274_VOLTAGE_MIN,
 		.uV_step        = LM363X_STEP_50mV,
 		.type           = REGULATOR_VOLTAGE,
@@ -254,7 +254,7 @@ static const struct regulator_desc lm363x_regulator_desc[] = {
 		.of_match	= "vneg",
 		.id             = LM36274_LDO_NEG,
 		.ops            = &lm363x_regulator_voltage_table_ops,
-		.n_voltages     = LM36274_LDO_VSEL_MAX,
+		.n_voltages     = LM36274_LDO_VSEL_MAX + 1,
 		.min_uV         = LM36274_VOLTAGE_MIN,
 		.uV_step        = LM363X_STEP_50mV,
 		.type           = REGULATOR_VOLTAGE,
-- 
2.20.1

