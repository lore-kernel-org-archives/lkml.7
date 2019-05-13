Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8323C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 14:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 799B32146F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 14:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="jleNO/Cd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730587AbfEMOVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 10:21:49 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46615 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730534AbfEMOVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 10:21:47 -0400
Received: by mail-wr1-f68.google.com with SMTP id r7so14873248wrr.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 07:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cSguXg1ULNsLVeUlyV/JBYC1DyTsN/aiCX3xWl5lL/w=;
        b=jleNO/Cdfykym1Iv62B4ZMzaeTMBfgLnbRfEOuZTYHQdFwoD/fE3Nu1uIO83bTuCb0
         WufTyu79QjpzY5s5s1Orw+T6OkXimC1WGuD0yHItW1LPMoPvqskys5DxO8pNyTC4ETUn
         89Ywwrps4NBIRn5o/0NOl6bzkn3fmWkCmrYM3/Grojkmqb4lW1xowhu96CezF4gLiK/1
         pDJQJQvPFq6JEytsSw8z70jl3Aeprsh4UCVcEIAsKpgSj9R8c3+d/jI7Jk6plZr47VhM
         Mb/gptNd4QJJZk6wUuG2U8eo6Ut7BoGxnUESQsUaQv5y5S+4390RDYWn7yytT4L9H7BN
         VSuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cSguXg1ULNsLVeUlyV/JBYC1DyTsN/aiCX3xWl5lL/w=;
        b=Q8GoiNGscT2/ZKYo4d3G7Oezknr5WkG9DHpk7FzUZMO97lMykappb52ZliKMEG/3KO
         3BhjJeS6dKt09ajy+P3FDDoBLCK92tzuC8+Ku9mmf8ctUgkvRAvpLFTUJvTrIV5kfOUf
         Z5ZNcD2jTqXyp/i6s/oeFieglNU5TJ1Iqq+V7XLgGf4ffyjLiFjl9pExDyD7xoNvcvGy
         eLcaeW12M0DL15dJEuEqruSc9bUTG7IlLbj+AfBwDIG//oK9h3BC4Wj7k2/hyTPDozdK
         zcsq/zpB1fyAls1tc4Qgwtpl0vaQJt7GJoL73VbmOfacrO1pVFdPvRj2mnacJiguM4CV
         AuJg==
X-Gm-Message-State: APjAAAWkff2En68oqUKlIUZpYt2Nb4hX6BN6fln1eh1Gxkz3fc3ZbSUJ
        k/C7KxxbgVC8NkHkw29x1QwD0Q==
X-Google-Smtp-Source: APXvYqyb7jvJZ+9TFKgT7DkyliaCtl4ZcjeYhYQ5a7ehr+YjdueGGPUKUKqqrkwlDWYC3gJx5sgcgQ==
X-Received: by 2002:adf:aa0a:: with SMTP id p10mr8675758wrd.125.1557757305028;
        Mon, 13 May 2019 07:21:45 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-11-31.w90-86.abo.wanadoo.fr. [90.86.214.31])
        by smtp.gmail.com with ESMTPSA id v184sm21133615wma.6.2019.05.13.07.21.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 07:21:44 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, matthias.bgg@gmail.com
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 2/2] input: keyboard: mtk-pmic-keys: add MT6392 support
Date:   Mon, 13 May 2019 16:21:20 +0200
Message-Id: <20190513142120.6527-2-fparent@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190513142120.6527-1-fparent@baylibre.com>
References: <20190513142120.6527-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for MT6392 PMIC's keys.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 drivers/input/keyboard/mtk-pmic-keys.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
index 8e6ebab05ab4..aaf68cbf7e5b 100644
--- a/drivers/input/keyboard/mtk-pmic-keys.c
+++ b/drivers/input/keyboard/mtk-pmic-keys.c
@@ -18,6 +18,7 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/mfd/mt6323/registers.h>
+#include <linux/mfd/mt6392/registers.h>
 #include <linux/mfd/mt6397/core.h>
 #include <linux/mfd/mt6397/registers.h>
 #include <linux/module.h>
@@ -83,6 +84,16 @@ static const struct mtk_pmic_regs mt6323_regs = {
 	.pmic_rst_reg = MT6323_TOP_RST_MISC,
 };
 
+static const struct mtk_pmic_regs mt6392_regs = {
+	.keys_regs[MTK_PMIC_PWRKEY_INDEX] =
+		MTK_PMIC_KEYS_REGS(MT6392_CHRSTATUS,
+		0x2, MT6392_INT_MISC_CON, 0x10),
+	.keys_regs[MTK_PMIC_HOMEKEY_INDEX] =
+		MTK_PMIC_KEYS_REGS(MT6392_CHRSTATUS,
+		0x4, MT6392_INT_MISC_CON, 0x8),
+	.pmic_rst_reg = MT6392_TOP_RST_MISC,
+};
+
 struct mtk_pmic_keys_info {
 	struct mtk_pmic_keys *keys;
 	const struct mtk_pmic_keys_regs *regs;
@@ -238,6 +249,9 @@ static const struct of_device_id of_mtk_pmic_keys_match_tbl[] = {
 	}, {
 		.compatible = "mediatek,mt6323-keys",
 		.data = &mt6323_regs,
+	}, {
+		.compatible = "mediatek,mt6392-keys",
+		.data = &mt6392_regs,
 	}, {
 		/* sentinel */
 	}
-- 
2.20.1

