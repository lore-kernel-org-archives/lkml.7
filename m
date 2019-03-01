Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D70C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEE2C2084F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="IJO51RPL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388412AbfCAOVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 09:21:02 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43692 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387704AbfCAOVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 09:21:02 -0500
Received: by mail-pg1-f196.google.com with SMTP id l11so11506062pgq.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 06:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=bIZgpHCXYuftvVtoWB+zoIWTj1KLSVkbIPvFI4mG97U=;
        b=IJO51RPLhoPHdLLHz6ykHWfvV7HZ3RqEFAbNYd9f8aQNDj23UYxf1eqAHvdf450u/f
         R3J22TT8tfwRrnI2UeSj0QYKqs6k6lECQLvDrHUCMWv4ogtgG+RcTXapVWtZ33QaEa9L
         aKI5aIpnPoRaRSYaHuC7rTLwa1dg3+HN+GiHiwKbBUiT88ZTCoMjKj+DyjXVe9Jlq41X
         +gm/6K4LdG8XOXS2eeFx2onNwZaqne6nl8yOLQTazoLaw2f2TwkcoB69kYchCPE5g5xD
         54cAlTT6lZTD1kQy9LPmxqFyk4UiDrgmkSl9/kPpWut9tRhzDs6OgweMMSp6sTDpPXja
         VLLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bIZgpHCXYuftvVtoWB+zoIWTj1KLSVkbIPvFI4mG97U=;
        b=e8cHI2Ez4mJDbW+y44QHN/RNeVSiQznHfsVtAHr1KjNv2DPDZyzt0KAxk8uCM1pPyC
         Vujkm7s9JoN8nkhO5Xh0/6C/iAbyj38+MO0lgQTYonNnNJ6zRfZuYvGYIT8wt2lRO7A3
         7FIxV5n4IuhNfLc9vp4IeC5ree0+f5G3MKtkapmO9lR066XqfRnd7WRSjzYVo7UJF0o+
         1hzNKXl0Sn6w3wI+UWV6IvhBF4bgvPD3qtLJ/lube8Y1wwdsWQz3nRCpBFRtJI7pgCef
         dO/7SQ6DBjS4ZEPbl2glEAYdohDdlLqZ4ZDKn8k/Wf8Cpj6wbIRcZlNWgQ+X/RHh1Gur
         XnSA==
X-Gm-Message-State: APjAAAV0JVN/h3muWLNUvuhB4bL4lFTaKqX31ehuI9RjjYPfU6j8LYnF
        ra5ODc3b/eRVsmdVUVf1zxvxEHM8d/4CcA==
X-Google-Smtp-Source: APXvYqyLfqCXokiw1UwoY9Zw8KFI9c8y+axH8rqCKM71bPXDj9FWxQYbY+kC0qjP1JOq9JXPLQZiNQ==
X-Received: by 2002:a63:61d8:: with SMTP id v207mr5038585pgb.308.1551450061158;
        Fri, 01 Mar 2019 06:21:01 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e303-1426-2dd7-86e1-088f-ff18.emome-ip6.hinet.net. [2001:b400:e303:1426:2dd7:86e1:88f:ff18])
        by smtp.gmail.com with ESMTPSA id u24sm28088876pfm.140.2019.03.01.06.20.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 06:21:00 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Yong Shen <yong.shen@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: mc13xxx: Constify regulator_ops variables
Date:   Fri,  1 Mar 2019 22:20:53 +0800
Message-Id: <20190301142053.24166-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These regulator_ops variables should never change, make them const.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/mc13783-regulator.c      | 4 ++--
 drivers/regulator/mc13892-regulator.c      | 8 ++++----
 drivers/regulator/mc13xxx-regulator-core.c | 4 ++--
 drivers/regulator/mc13xxx.h                | 4 ++--
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/regulator/mc13783-regulator.c b/drivers/regulator/mc13783-regulator.c
index 887a1d1726ad..ab558b26cd7c 100644
--- a/drivers/regulator/mc13783-regulator.c
+++ b/drivers/regulator/mc13783-regulator.c
@@ -226,7 +226,7 @@ static const unsigned int mc13783_pwgtdrv_val[] = {
 	5500000,
 };
 
-static struct regulator_ops mc13783_gpo_regulator_ops;
+static const struct regulator_ops mc13783_gpo_regulator_ops;
 
 #define MC13783_DEFINE(prefix, name, node, reg, vsel_reg, voltages)	\
 	MC13xxx_DEFINE(MC13783_REG_, name, node, reg, vsel_reg, voltages, \
@@ -380,7 +380,7 @@ static int mc13783_gpo_regulator_is_enabled(struct regulator_dev *rdev)
 	return (val & mc13xxx_regulators[id].enable_bit) != 0;
 }
 
-static struct regulator_ops mc13783_gpo_regulator_ops = {
+static const struct regulator_ops mc13783_gpo_regulator_ops = {
 	.enable = mc13783_gpo_regulator_enable,
 	.disable = mc13783_gpo_regulator_disable,
 	.is_enabled = mc13783_gpo_regulator_is_enabled,
diff --git a/drivers/regulator/mc13892-regulator.c b/drivers/regulator/mc13892-regulator.c
index b55894980066..a731e826a037 100644
--- a/drivers/regulator/mc13892-regulator.c
+++ b/drivers/regulator/mc13892-regulator.c
@@ -242,8 +242,8 @@ static const unsigned int mc13892_pwgtdrv[] = {
 	5000000,
 };
 
-static struct regulator_ops mc13892_gpo_regulator_ops;
-static struct regulator_ops mc13892_sw_regulator_ops;
+static const struct regulator_ops mc13892_gpo_regulator_ops;
+static const struct regulator_ops mc13892_sw_regulator_ops;
 
 
 #define MC13892_FIXED_DEFINE(name, node, reg, voltages)			\
@@ -387,7 +387,7 @@ static int mc13892_gpo_regulator_is_enabled(struct regulator_dev *rdev)
 }
 
 
-static struct regulator_ops mc13892_gpo_regulator_ops = {
+static const struct regulator_ops mc13892_gpo_regulator_ops = {
 	.enable = mc13892_gpo_regulator_enable,
 	.disable = mc13892_gpo_regulator_disable,
 	.is_enabled = mc13892_gpo_regulator_is_enabled,
@@ -479,7 +479,7 @@ static int mc13892_sw_regulator_set_voltage_sel(struct regulator_dev *rdev,
 	return ret;
 }
 
-static struct regulator_ops mc13892_sw_regulator_ops = {
+static const struct regulator_ops mc13892_sw_regulator_ops = {
 	.list_voltage = regulator_list_voltage_table,
 	.map_voltage = regulator_map_voltage_ascend,
 	.set_voltage_sel = mc13892_sw_regulator_set_voltage_sel,
diff --git a/drivers/regulator/mc13xxx-regulator-core.c b/drivers/regulator/mc13xxx-regulator-core.c
index 2243138d8a58..8ff19150ca92 100644
--- a/drivers/regulator/mc13xxx-regulator-core.c
+++ b/drivers/regulator/mc13xxx-regulator-core.c
@@ -99,7 +99,7 @@ static int mc13xxx_regulator_get_voltage(struct regulator_dev *rdev)
 	return rdev->desc->volt_table[val];
 }
 
-struct regulator_ops mc13xxx_regulator_ops = {
+const struct regulator_ops mc13xxx_regulator_ops = {
 	.enable = mc13xxx_regulator_enable,
 	.disable = mc13xxx_regulator_disable,
 	.is_enabled = mc13xxx_regulator_is_enabled,
@@ -127,7 +127,7 @@ int mc13xxx_fixed_regulator_set_voltage(struct regulator_dev *rdev, int min_uV,
 }
 EXPORT_SYMBOL_GPL(mc13xxx_fixed_regulator_set_voltage);
 
-struct regulator_ops mc13xxx_fixed_regulator_ops = {
+const struct regulator_ops mc13xxx_fixed_regulator_ops = {
 	.enable = mc13xxx_regulator_enable,
 	.disable = mc13xxx_regulator_disable,
 	.is_enabled = mc13xxx_regulator_is_enabled,
diff --git a/drivers/regulator/mc13xxx.h b/drivers/regulator/mc13xxx.h
index a602b08d4c9e..ba7eff1070bd 100644
--- a/drivers/regulator/mc13xxx.h
+++ b/drivers/regulator/mc13xxx.h
@@ -53,8 +53,8 @@ static inline struct mc13xxx_regulator_init_data *mc13xxx_parse_regulators_dt(
 }
 #endif
 
-extern struct regulator_ops mc13xxx_regulator_ops;
-extern struct regulator_ops mc13xxx_fixed_regulator_ops;
+extern const struct regulator_ops mc13xxx_regulator_ops;
+extern const struct regulator_ops mc13xxx_fixed_regulator_ops;
 
 #define MC13xxx_DEFINE(prefix, _name, _node, _reg, _vsel_reg, _voltages, _ops)	\
 	[prefix ## _name] = {				\
-- 
2.17.1

