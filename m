Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26D7C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 15:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BA1921773
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 15:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBqHw7ZZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389594AbfEXPMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 11:12:14 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36528 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389129AbfEXPMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 11:12:14 -0400
Received: by mail-lf1-f67.google.com with SMTP id y10so7437117lfl.3;
        Fri, 24 May 2019 08:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3OFuz1ctW8EXs3j2sT/f6sr8fJB1b9c1HDH5fn4La0E=;
        b=EBqHw7ZZyrMIw0bwCg2e1yg65WCIXKALtx8Hsc5jm4dMOKXhXPyFRI4SBRnqNlKVV6
         4YKC8SqoVudMHhYj4vZ6fI5jw8C3tKqZrm+SAd5W31m5nucQEs8vobApXCmw5oI0mmQr
         o7J3fS4YvV2H8k6nwLnvsC/xzpYCN9ygTQ59dslzFkyuHguz2KE+UHOosbzdYpCIwAJX
         UssSzlD3bMNKe13sc66q8A8s5wwE7wudi1zTkfWBeZn5VGRjC7GUN1CzQnLuTqWOVmsN
         e6XNG++DJRWNiBycJLKn+U8OOpBE2T1GePW2BDv7oGk2IOOfcUlu+s1OOMnCKIRC6gOl
         x9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3OFuz1ctW8EXs3j2sT/f6sr8fJB1b9c1HDH5fn4La0E=;
        b=AnSdUcLB6Y99zuFKw/cPMDhi2rcIoqP6WhcTOU/YvZNOPGr1tctd8meAr2LzNWpe0Y
         4m2goG8w/ApPslaxJnjXbmpMUCCm+s5MMG8prO+WrB6Mpiqwlyu+tdtdCY40mkTRwJJR
         PiW/0ITnl5LQRs9IdL845g0PE+N2qAiylJBXBncxDYgEu0vk7puGvvawjRS+BcBsio7f
         Rx1yE5Q91elEloYD6SR6pQwBYmH8jscbb8Jl/4KDWVu3mMth/4pAXniV3dVMXTurkUvI
         DM3TwhqQklHsROSKFN5ubRtY1pgTSTq2FKtfy7QZ+LYIE0yE7plBghlYY8VIUC4kRE2k
         0DKA==
X-Gm-Message-State: APjAAAUDgrB8iyf6BsK+a2cWpVIgofM/uKdFWR+X6FaDUl79iFvrZ8Rw
        f9vQWfzsElpv2E6QrB6XxY8=
X-Google-Smtp-Source: APXvYqwoFDqcSsqo6ShH12EuQNSjowSOZvAbxkkXO/uL+eDvaYb9H6TBq+WVaIAaetlbdQcaZmIlfw==
X-Received: by 2002:ac2:4286:: with SMTP id m6mr10082691lfh.150.1558710731991;
        Fri, 24 May 2019 08:12:11 -0700 (PDT)
Received: from localhost.localdomain ([94.29.35.141])
        by smtp.gmail.com with ESMTPSA id w25sm860400lfl.0.2019.05.24.08.12.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 08:12:09 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Mallikarjun Kasoju <mkasoju@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 RE-SEND] regulator: max77620: Support Maxim 77663
Date:   Fri, 24 May 2019 18:10:34 +0300
Message-Id: <20190524151034.26048-1-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Maxim 77663.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---

This patch was a part of MFD/Regulator patch-series and the MFD patches are
already in v5.2, the regulator patch was left out because the MFD subsys
maintainer decided to not take it via the MFD tree. There are no changes in
v5 of this patch, this is merely a re-send of the patch.

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

