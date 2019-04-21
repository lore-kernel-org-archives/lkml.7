Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC32C282E3
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 17:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AE852147C
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 17:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kumHUCwI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbfDURuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 13:50:00 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37034 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbfDURto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 13:49:44 -0400
Received: by mail-pl1-f193.google.com with SMTP id w23so4762508ply.4;
        Sun, 21 Apr 2019 10:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pwolm0wYaQsW4TCiJ23NvsAidX1qtREXRI4t9bNq3t4=;
        b=kumHUCwIUoicKVMidgvck21qRN0kWl8263cSCVMsR0ZJ04teu5qRgGw2cCK5RsV7+P
         HcEKJZFqNLmGCNAmbnbp7Ds0zExL2LhYfdslcIQx3yjHKCEJBEOUD11Lbo7PeYp3bjKL
         mR8cVhF7/HZ6GLAmo4z0QZU88xuQQPHK9hfWHdnBqx7pO3tGHid7oCv9YXuPZGeSr4GP
         9JoTpMio76b2RqFD+bkKQ91l+cStQbgUbrWOfgDkATU9UlUkfHZ+ljBNSJ3TRoc84RU0
         ILyCC+j7xAmjwwKqowK16UjY6PeTxqx/9Zqk5N3ZVA0rPxzWmR/FWX7zq2xNyJX4hKKz
         PSwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pwolm0wYaQsW4TCiJ23NvsAidX1qtREXRI4t9bNq3t4=;
        b=c9eqJ6VJXBvcR3il2kWqRPzuzfJwgDid5Dk5SfOmk7lFWVmT6v4YohNtNsRzdc6U6c
         do6VmJnWNqTtMA1OWFkqLfskK+kT3pb+0GWNhy5mJQHfEiOO+au5z3wXgLhrLiGLZAuC
         2TF7RxRgG+PgcPEQ7nQAjV4+Ueqviicnhj0RH6jM+5u0KZga24o5B7oacK1t63go9V6I
         j3aLXhXe4sceXhDtu+jjZfHrf9oKo19dgPoIBMTysqKEvwh8+CnkJo2At8tsE71v8i4r
         RnEwL7ANYg2/4fhlsZh1hb/a9QNly08lUVw5/qrztWTGCkl9zvDVqw+PtSehXo6Akjj+
         cPNA==
X-Gm-Message-State: APjAAAXNNlAd1gVMyeLEOU7EBYUpTecqyrgVDGZ9DfLCkWCaArZSZud9
        9YSAtea8/qdRu8axJ0D5Kdo=
X-Google-Smtp-Source: APXvYqwd0TiSWYl7isxd51Zdrf6b7zOPLxU72lFS+3VMMzfYuXUuPCvnDTq0s0D/7ZPlEvXpf39NaA==
X-Received: by 2002:a17:902:7081:: with SMTP id z1mr15447072plk.252.1555868983426;
        Sun, 21 Apr 2019 10:49:43 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id g63sm16279233pfc.127.2019.04.21.10.49.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Apr 2019 10:49:42 -0700 (PDT)
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
Subject: [PATCH v1 3/5] regulator: max77620: Support Maxim 77663
Date:   Sun, 21 Apr 2019 20:48:32 +0300
Message-Id: <20190421174834.9366-4-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190421174834.9366-1-digetx@gmail.com>
References: <20190421174834.9366-1-digetx@gmail.com>
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

