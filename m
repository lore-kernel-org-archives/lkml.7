Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8E9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 03:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFA5F20872
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 03:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="suTAFWk4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbfCSDgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 23:36:24 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35740 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfCSDgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 23:36:23 -0400
Received: by mail-pg1-f194.google.com with SMTP id g8so2207380pgf.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 20:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kipVWcK5mC9HWcaQENwtXOxTjY9sgx+grBbuMH7Dh08=;
        b=suTAFWk4DlhxG6uIWZlqe+gbZOWVXf9CxetSNEtohLBeg78hB8p38pHDbezQNpq0ej
         dpCN1YHmMaZG3B3NsQ7kETD2rEVM1mKukLZ0cGSPD7+GJitkETfpR3c4suMudb3Pji1z
         Gvc+xGUCofP8f0PW95mKZ9MxMKS0XBvzvOZMI/DnxWrDy3BIxPBzitTwzCHtyTiZ9fLt
         okaCRT1MzJvzCRPpV1JnToHCa/jyGFM9meLKZbb6gOsW+lR3vno+d8E/8oKv4F94S6zn
         tQiv7AElX+bzCjR6J8kJ0dLx8XBZSmJFz6rYNitIxOs2NuN0dpvdZOBVB713EzSEcYcc
         RQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kipVWcK5mC9HWcaQENwtXOxTjY9sgx+grBbuMH7Dh08=;
        b=eQw2WaecbBmINQg7xsYwkGuXUqMfQ4FMgDF56QoKPeR+ftZ0kr6t8V7tr59SwtUhCG
         4xSG+8pp0wcXzkz20lYOOVuWqeBX0+EnSA7LocKBdL1MgUxgFUe7xYmUMIB6DGJxvP/0
         eMmr0/OvjtN3wSEtH8/VdlaEGOnp/L3lfpSR4X4wc1hBLQSVnX7Z8BLkrp9uz1QYelK4
         uyVtEuqf+i5CtihDRIswCGh32GX6C89PzCbK6TGdyrAd6A7czkINIcJjO+8sKlmqJliA
         Lgs38k0y0gM4rM5hen5VtCbbSB1bCgK3TmGTklZLy0GDhANVMtt6opFu53ABuzTv7UZt
         j9Hg==
X-Gm-Message-State: APjAAAVX7aLmWuNXdVDhLctns53056M0aalelZgdPkkhs4EOJ6CC1+qu
        2LkurOgtgNOKdpY2W1mbVgnYWA==
X-Google-Smtp-Source: APXvYqzh2EpWPD57MzBO0vsP3px+5c+RMxaKqib6cn2yxrNm7gxPcjpaI5FZKlyNXO2FPa7+3m2RmQ==
X-Received: by 2002:a63:5808:: with SMTP id m8mr21242892pgb.140.1552966582343;
        Mon, 18 Mar 2019 20:36:22 -0700 (PDT)
Received: from localhost.localdomain (118-171-142-96.dynamic-ip.hinet.net. [118.171.142.96])
        by smtp.gmail.com with ESMTPSA id h23sm15133538pfn.68.2019.03.18.20.36.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 20:36:21 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] regulator: axp20x: Use rdev_get_id at appropriate places
Date:   Tue, 19 Mar 2019 11:36:08 +0800
Message-Id: <20190319033608.6363-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190319033608.6363-1-axel.lin@ingics.com>
References: <20190319033608.6363-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use rdev_get_id() to simplify the code a bit.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/axp20x-regulator.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index 8a366f66208e..07e10c8b0a22 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -367,16 +367,14 @@ static const int axp209_dcdc2_ldo3_slew_rates[] = {
 static int axp20x_set_ramp_delay(struct regulator_dev *rdev, int ramp)
 {
 	struct axp20x_dev *axp20x = rdev_get_drvdata(rdev);
-	const struct regulator_desc *desc;
+	int id = rdev_get_id(rdev);
 	u8 reg, mask, enable, cfg = 0xff;
 	const int *slew_rates;
 	int rate_count = 0;
 
-	desc = rdev->desc;
-
 	switch (axp20x->variant) {
 	case AXP209_ID:
-		if (desc->id == AXP20X_DCDC2) {
+		if (id == AXP20X_DCDC2) {
 			slew_rates = axp209_dcdc2_ldo3_slew_rates;
 			rate_count = ARRAY_SIZE(axp209_dcdc2_ldo3_slew_rates);
 			reg = AXP20X_DCDC2_LDO3_V_RAMP;
@@ -388,7 +386,7 @@ static int axp20x_set_ramp_delay(struct regulator_dev *rdev, int ramp)
 			break;
 		}
 
-		if (desc->id == AXP20X_LDO3) {
+		if (id == AXP20X_LDO3) {
 			slew_rates = axp209_dcdc2_ldo3_slew_rates;
 			rate_count = ARRAY_SIZE(axp209_dcdc2_ldo3_slew_rates);
 			reg = AXP20X_DCDC2_LDO3_V_RAMP;
@@ -435,13 +433,11 @@ static int axp20x_set_ramp_delay(struct regulator_dev *rdev, int ramp)
 static int axp20x_regulator_enable_regmap(struct regulator_dev *rdev)
 {
 	struct axp20x_dev *axp20x = rdev_get_drvdata(rdev);
-	const struct regulator_desc *desc;
-
-	desc = rdev->desc;
+	int id = rdev_get_id(rdev);
 
 	switch (axp20x->variant) {
 	case AXP209_ID:
-		if ((desc->id == AXP20X_LDO3) &&
+		if ((id == AXP20X_LDO3) &&
 		    rdev->constraints && rdev->constraints->soft_start) {
 			int v_out;
 			int ret;
-- 
2.17.1

