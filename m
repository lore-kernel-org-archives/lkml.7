Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47910C004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 15:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18BCC206DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 15:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n+LYGa2f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbfEEPsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 11:48:54 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36055 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbfEEPsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 11:48:40 -0400
Received: by mail-lj1-f193.google.com with SMTP id y8so8815037ljd.3;
        Sun, 05 May 2019 08:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wi5NVXtnZHEtDn7otTZBfkTlrRUfXOAkjzzEUQJdYMk=;
        b=n+LYGa2fvFpQYMARku/Km7h+eVqpSaLzrG470CuZ8vVI6Guu8iwFZ8UmezKhJUSwHL
         zBBeBMfzacKKVz+y5FuO0awvQurOYBLdJqc3sqRlySLQJxfVexTX5W9FNTXT/CAZbAH0
         x0k76YEH4xE91JgN24i82LkB4lE5LuvSvj60ZTqh+9amRcosJraA3XgPTHw2QGUrGGkD
         raj84BJ0JyDI4eJGZc05xi09r0xbHGYcXA0vH2vQVsfsgFeUHZcpDVLswPgyPlKDUcCN
         E8xst00y3i/X8BcM2iFBRtcPNS1uSgdQwgyoS97kavoyWnqBfKEKSTNOn0DLJBeXBUGR
         IseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wi5NVXtnZHEtDn7otTZBfkTlrRUfXOAkjzzEUQJdYMk=;
        b=SdB/nIVtUYALtiNYT/DUatNlcqknebU3gl65FlfcaCBGcUkyKa803ZZLJG2HRNRGHi
         T3HwlQHCPmhtP354ZpWp32iE+oOqKEEoVZ3twZBimX4m4enGZ3tsnk0iFB0u0qwE2+9B
         Ny+BgNBrRL4D4weQBY9Btjjn2Flye+o+qz0F1xBWZaJ1V/qfM2yAwqF4BpL+62O6YigE
         SFBLHcZ4KBnN9vHrn7b5EJP04NgvgQAj3Rm2d/mOY4K6RLheTz65llnbnW9pEfSS9sLP
         C3zBxiJZly8kwq2zcAxLOEY0TwnKaT5GGXvOt8PPFLK0SF70ivpQk79SKiHThB6wTodW
         oe3Q==
X-Gm-Message-State: APjAAAUewEhVP04Mftl+DQSshToOqDo5otCZdoSvZ371q3Zjt8TDRENp
        xebD5HVg5guCa3lNz8T/QlLo46F2
X-Google-Smtp-Source: APXvYqxRXVl7+hnxXsniJgdMRxAbjb6hsLVKmm9zT540i7EqW7fqSBISBINAJ6D+gUtFs5YC5FHLTg==
X-Received: by 2002:a2e:9546:: with SMTP id t6mr11047359ljh.51.1557071318863;
        Sun, 05 May 2019 08:48:38 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id d16sm1595278lfi.75.2019.05.05.08.48.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 May 2019 08:48:38 -0700 (PDT)
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
Subject: [PATCH v4 6/6] regulator: max77620: Support Maxim 77663
Date:   Sun,  5 May 2019 18:43:25 +0300
Message-Id: <20190505154325.30026-7-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190505154325.30026-1-digetx@gmail.com>
References: <20190505154325.30026-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Maxim 77663.

Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/regulator/max77620-regulator.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/max77620-regulator.c b/drivers/regulator/max77620-regulator.c
index 0ad91a7f9cb9..0ec9f81fe74a 100644
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

