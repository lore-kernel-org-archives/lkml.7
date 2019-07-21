Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 406D2C76191
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 16:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14EB42083B
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 16:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfGUQDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 12:03:54 -0400
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:55508 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbfGUQDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 12:03:54 -0400
Received: from localhost.localdomain ([92.140.204.221])
        by mwinf5d01 with ME
        id fU3q2000X4n7eLC03U3rbD; Sun, 21 Jul 2019 18:03:52 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 21 Jul 2019 18:03:52 +0200
X-ME-IP: 92.140.204.221
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] power: supply: max17042_battery: Fix a typo in function names
Date:   Sun, 21 Jul 2019 18:03:28 +0200
Message-Id: <20190721160328.24660-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is likely that 'max10742_[un]lock_model()' functions should be
'max17042_[un]lock_model()'
(0 and 7 switched in 10742)

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/power/supply/max17042_battery.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 581c6bd23388..da3904822929 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -511,7 +511,7 @@ static inline void max17042_override_por(struct regmap *map,
 		regmap_write(map, reg, value);
 }
 
-static inline void max10742_unlock_model(struct max17042_chip *chip)
+static inline void max17042_unlock_model(struct max17042_chip *chip)
 {
 	struct regmap *map = chip->regmap;
 
@@ -519,7 +519,7 @@ static inline void max10742_unlock_model(struct max17042_chip *chip)
 	regmap_write(map, MAX17042_MLOCKReg2, MODEL_UNLOCK2);
 }
 
-static inline void max10742_lock_model(struct max17042_chip *chip)
+static inline void max17042_lock_model(struct max17042_chip *chip)
 {
 	struct regmap *map = chip->regmap;
 
@@ -577,7 +577,7 @@ static int max17042_init_model(struct max17042_chip *chip)
 	if (!temp_data)
 		return -ENOMEM;
 
-	max10742_unlock_model(chip);
+	max17042_unlock_model(chip);
 	max17042_write_model_data(chip, MAX17042_MODELChrTbl,
 				table_size);
 	max17042_read_model_data(chip, MAX17042_MODELChrTbl, temp_data,
@@ -589,7 +589,7 @@ static int max17042_init_model(struct max17042_chip *chip)
 		temp_data,
 		table_size);
 
-	max10742_lock_model(chip);
+	max17042_lock_model(chip);
 	kfree(temp_data);
 
 	return ret;
-- 
2.20.1

