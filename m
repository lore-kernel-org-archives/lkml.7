Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7853BC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48DC0214C6
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7dEqTDn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbfDXWuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 18:50:15 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38034 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfDXWtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 18:49:45 -0400
Received: by mail-lj1-f193.google.com with SMTP id p14so18419576ljg.5;
        Wed, 24 Apr 2019 15:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pwolm0wYaQsW4TCiJ23NvsAidX1qtREXRI4t9bNq3t4=;
        b=T7dEqTDnOnEPiPQxEhSnYUahcVUvGeP13NfyKNeJGRUxozHmLDEOEsjGrI9N+m1cvp
         XKROFOBe9aunce8eDso5pd7tIh5AUPp4VWNiiDkhylIIEQmaU20OEMC19/do8ZGCYHFC
         rI9KACiqPowL9JW/1tOsm7FvJgaCCe7asNwwVCjXyrIHNBVBQHFvc/9J94WizxrbpWRk
         EkEIt8VVMu3a0P/d17OCq5RB/eoRocpmE4OCrds5fCo6jXAjJHCAXwQltDNmRSQa+pnw
         X/xuGZesxQHVJ/f1blx0qHeWOqkQ5QXGADZwhBjPtqeALX8TmxGP7Z3UP+kmxZ5pP/oA
         evnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pwolm0wYaQsW4TCiJ23NvsAidX1qtREXRI4t9bNq3t4=;
        b=abpE423wJHzzfEXmdMuS8iJf6nhNn6/CFPYP7hu6anZDk/rWsnCyu0vK/lHSjsQNP1
         eEJRFMTgcrI3yJwh91Cw8HXLbouLxCbdAuuosh0wX1I3OXR1CDr32tLxcmhMaQn/7iqt
         FrPTQgGDThqnln0x6sE16ub6SkOOVmKLIfIwdhd3TCO3lMBE0H7K83wOQQ2WwR2lqpX9
         zQXRv+sypTGFlDkfNMC0ENbIuaVs2YSMw2HGhRwofW8vBhpuQfqCMyZi/z7KONiQ8x+m
         RTq7pdGDYj4TKRsasbKSHmlCzH/ouDbRwz7v1xzOD2Evt6kHCL5lj1Xi3WanSaGC/Rhc
         wCfg==
X-Gm-Message-State: APjAAAXvd+eWxrgPU3Y3/43oHqRIoKuCE0TxIOzubX7AVktFHDTVLg9D
        1KCbRQoWEwI4gKfcFui5Vo4=
X-Google-Smtp-Source: APXvYqzg5HOV4K7u73Qs5DeN4VE0ULPrLp6KSTh3WTfz7zgbWT0DGJAkOvNhFMwDlHn3ZmyCMtxUEA==
X-Received: by 2002:a2e:99c5:: with SMTP id l5mr20044034ljj.55.1556146183564;
        Wed, 24 Apr 2019 15:49:43 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id s24sm4219879ljs.30.2019.04.24.15.49.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 15:49:42 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Mallikarjun Kasoju <mkasoju@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/6] regulator: max77620: Support Maxim 77663
Date:   Thu, 25 Apr 2019 01:48:57 +0300
Message-Id: <20190424224900.8018-4-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424224900.8018-1-digetx@gmail.com>
References: <20190424224900.8018-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Maxim 77663.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/regulator/max77620-regulator.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/max77620-regulator.c b/drivers/regulator/max77620-regulator.c
index 1607ac673e44..7d6b53828056 100644
--- a/drivers/regulator/max77620-regulator.c
+++ b/drivers/regulator/max77620-regulator.c
@@ -761,6 +761,24 @@ static struct max77620_regulator_info max20024_regs_info[MAX77620_NUM_REGS] = {
 	RAIL_LDO(LDO8, ldo8, "in-ldo7-8", N, 800000, 3950000, 50000),
 };
 
+static struct max77620_regulator_info max77663_regs_info[MAX77620_NUM_REGS] = {
+	RAIL_SD(SD0, sd0, "in-sd0", SD0, 600000, 3387500, 12500, 0xFF, NONE),
+	RAIL_SD(SD1, sd1, "in-sd1", SD1, 800000, 1587500, 12500, 0xFF, NONE),
+	RAIL_SD(SD2, sd2, "in-sd2", SDX, 600000, 3787500, 12500, 0xFF, NONE),
+	RAIL_SD(SD3, sd3, "in-sd3", SDX, 600000, 3787500, 12500, 0xFF, NONE),
+	RAIL_SD(SD4, sd4, "in-sd4", SDX, 600000, 3787500, 12500, 0xFF, NONE),
+
+	RAIL_LDO(LDO0, ldo0, "in-ldo0-1", N, 800000, 2375000, 25000),
+	RAIL_LDO(LDO1, ldo1, "in-ldo0-1", N, 800000, 2375000, 25000),
+	RAIL_LDO(LDO2, ldo2, "in-ldo2",   P, 800000, 3950000, 50000),
+	RAIL_LDO(LDO3, ldo3, "in-ldo3-5", P, 800000, 3950000, 50000),
+	RAIL_LDO(LDO4, ldo4, "in-ldo4-6", P, 800000, 1587500, 12500),
+	RAIL_LDO(LDO5, ldo5, "in-ldo3-5", P, 800000, 3950000, 50000),
+	RAIL_LDO(LDO6, ldo6, "in-ldo4-6", P, 800000, 3950000, 50000),
+	RAIL_LDO(LDO7, ldo7, "in-ldo7-8", N, 800000, 3950000, 50000),
+	RAIL_LDO(LDO8, ldo8, "in-ldo7-8", N, 800000, 3950000, 50000),
+};
+
 static int max77620_regulator_probe(struct platform_device *pdev)
 {
 	struct max77620_chip *max77620_chip = dev_get_drvdata(pdev->dev.parent);
@@ -785,9 +803,14 @@ static int max77620_regulator_probe(struct platform_device *pdev)
 	case MAX77620:
 		rinfo = max77620_regs_info;
 		break;
-	default:
+	case MAX20024:
 		rinfo = max20024_regs_info;
 		break;
+	case MAX77663:
+		rinfo = max77663_regs_info;
+		break;
+	default:
+		return -EINVAL;
 	}
 
 	config.regmap = pmic->rmap;
@@ -881,6 +904,7 @@ static const struct dev_pm_ops max77620_regulator_pm_ops = {
 static const struct platform_device_id max77620_regulator_devtype[] = {
 	{ .name = "max77620-pmic", },
 	{ .name = "max20024-pmic", },
+	{ .name = "max77663-pmic", },
 	{},
 };
 MODULE_DEVICE_TABLE(platform, max77620_regulator_devtype);
-- 
2.21.0

