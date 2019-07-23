Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DCAC7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 01:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D34722296
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 01:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="MuKW8WXb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387821AbfGWBlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 21:41:16 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38990 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728086AbfGWBlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 21:41:16 -0400
Received: by mail-pf1-f195.google.com with SMTP id f17so14255102pfn.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 18:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mtyYjbvYT2heRj7zhIigfjHr2V0fIIPHdJF4vL3wig8=;
        b=MuKW8WXbMGjrX3CvBpqSseFDEOZDQW5PQK9D0KNskjLQ0aZ2dUIi5OT6AxazSiKm5r
         VRHqkMAxaNb8aF0gGwvHpRZdAbO4RUdKJK1rcARlUsQpIv4C8NCx1G6S71pMzO/qVVCp
         CB91Fv1KROPWBTMvGjyP4FHZKXsf5KtCDCf6br11IX/DJqu3GkBJcHEZKYE8mdX5FEDq
         /O9iqMwsksX/rxEg5uMhmrj6IVc+CaxzSYJrfdCTRc0jKQHUblRuiktHBrLq0KwbBiYQ
         MaZFiBvB/VcXJt6VSuSqWYyLotKi0BRJpbGO0zkVQPxyLz5S2PtWZGfWQsW9+TVBPS9u
         KNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mtyYjbvYT2heRj7zhIigfjHr2V0fIIPHdJF4vL3wig8=;
        b=j5N5ptHKSLyLsldYgr+L6QpYlQwG+Bgoh0hu395t9jj02bYMANithoHHtdA9uGJlRM
         mGCNuQOUFezFwDoWOnzm9lmUEPbWTgeV8Ev+jPybwCrJNOxTDfbVaybwU2WKIaI4HseD
         u4UHyNHYIxgIzUWndFSZQDpqbsRfkAR8DCdU91uGKIbHnzUtLJFrdapUuxHj58f5D8qD
         F0RVOkjukfeH6/ma+7SEPIW+rusYeXgOsbRWNKmYXPfRkWySTWb806GRR7Jv+3kWi6wp
         Nkn866YjRT9L0CYHCuWK3NGlhqFaJMlK3gg8L9ziV12eJyU4dvQ/zEu+3/twuNO1C3gA
         x0AQ==
X-Gm-Message-State: APjAAAXcn1WqCqKY9ltw6y8LopXCtwrdHgvgH67LAkqCFLBC8dVIW0jV
        BIQXe2p03tlxpk3akt4tHgzdvsk/
X-Google-Smtp-Source: APXvYqy4owgCkNgFMI1V1j9i5eSd+HQLB/Rq4zAanIolUeAWZNYQnTbq9WyTNE1TBctUXR8odXTyZg==
X-Received: by 2002:a63:101b:: with SMTP id f27mr71422412pgl.291.1563846074972;
        Mon, 22 Jul 2019 18:41:14 -0700 (PDT)
Received: from localhost.localdomain (118-171-128-147.dynamic-ip.hinet.net. [118.171.128.147])
        by smtp.gmail.com with ESMTPSA id q22sm36525440pgh.49.2019.07.22.18.41.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 18:41:14 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Fabrice Gasnier <fabrice.gasnier@st.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: stm32-booster: Remove .min_uV and .list_voltage for fixed regulator
Date:   Tue, 23 Jul 2019 09:41:02 +0800
Message-Id: <20190723014102.25103-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting .n_voltages = 1 and .fixed_uV is enough for fixed regulator,
remove the redundant .min_uV and .list_voltage settings.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/stm32-booster.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/regulator/stm32-booster.c b/drivers/regulator/stm32-booster.c
index 2a897666c650..03f162ffd144 100644
--- a/drivers/regulator/stm32-booster.c
+++ b/drivers/regulator/stm32-booster.c
@@ -20,7 +20,6 @@
 #define STM32MP1_SYSCFG_EN_BOOSTER_MASK	BIT(8)
 
 static const struct regulator_ops stm32h7_booster_ops = {
-	.list_voltage	= regulator_list_voltage_linear,
 	.enable		= regulator_enable_regmap,
 	.disable	= regulator_disable_regmap,
 	.is_enabled	= regulator_is_enabled_regmap,
@@ -31,7 +30,6 @@ static const struct regulator_desc stm32h7_booster_desc = {
 	.supply_name = "vdda",
 	.n_voltages = 1,
 	.type = REGULATOR_VOLTAGE,
-	.min_uV = 3300000,
 	.fixed_uV = 3300000,
 	.ramp_delay = 66000, /* up to 50us to stabilize */
 	.ops = &stm32h7_booster_ops,
@@ -53,7 +51,6 @@ static int stm32mp1_booster_disable(struct regulator_dev *rdev)
 }
 
 static const struct regulator_ops stm32mp1_booster_ops = {
-	.list_voltage	= regulator_list_voltage_linear,
 	.enable		= stm32mp1_booster_enable,
 	.disable	= stm32mp1_booster_disable,
 	.is_enabled	= regulator_is_enabled_regmap,
@@ -64,7 +61,6 @@ static const struct regulator_desc stm32mp1_booster_desc = {
 	.supply_name = "vdda",
 	.n_voltages = 1,
 	.type = REGULATOR_VOLTAGE,
-	.min_uV = 3300000,
 	.fixed_uV = 3300000,
 	.ramp_delay = 66000,
 	.ops = &stm32mp1_booster_ops,
-- 
2.20.1

