Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89ECC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4ECA20896
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYr8caM3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbfDVTTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:19:10 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37481 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728483AbfDVTTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:19:00 -0400
Received: by mail-lj1-f196.google.com with SMTP id v13so11260157ljk.4;
        Mon, 22 Apr 2019 12:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HnfsaQVDx7Y54QXh/MZkgYdypBQriZZ4UUY09gSW6Sg=;
        b=RYr8caM3koRTKtWePRmwHxdHhcWtKzrtDjkFvAGqhgP7gal0yd5TJto1hbcab0AFak
         f13ZI1V8kKPQGO3LbUASYpT5l8BE4jKWNtRIQm8wCFRpy5S8kYe70L/UTcPaEsnMGlt2
         XdI8bSwENM4cdgu6dLTl0dsWFGSeHHecM9vm1dIxXpwVVBZngZhx1uwKy5kuVnU46Wz1
         aYwOy0BZinKF9se8HpFoncLUJGprcofwznhjMvbRr0rOqvmD6pHLsglG3TIRWSszaeHr
         BGTdth6nPddQ/tEix/KvP8IA80QlSzIittD6Rfu86mgN9JfudB78dXDWfC/KRG52YNBQ
         UyUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HnfsaQVDx7Y54QXh/MZkgYdypBQriZZ4UUY09gSW6Sg=;
        b=b335ASdnzPiKhBbvRQGaRhZ7Bgv7PeEcy4A2umwhN0WabZ7hykIjcyplqQyblNWcBP
         RL89R1u+5o0Y9dTR0WLsNE62KVQnuQYINi1W0E+8E/xqocFHaCMdc8y2C+FvjnbNRMr5
         2DeSF2dUR5CpfFForgU4mslGRBWMflmDu4J9FGnY+ZxIwxlsENqQHZfhg4eaby59vT8u
         /FzGHzFu7twca0NO8hzXKpulsxfGXfQd2KukPlW9KSUeQYCq0WoX6uNWW8DETLbAqaHT
         peYMcDRcnhIZx9X3Jr0cayTZtsGFV/NIaYGk3lotJyCe44Z2RO+nGV9yILH/QLrUYKYY
         e6Sw==
X-Gm-Message-State: APjAAAWrefAli5k9dNazu4SuAjvvKYR2Sf9/8zwatUpIyAfJTVyDcJ2W
        TwKPTUGQ0Tbi4t6j5TEDrdo=
X-Google-Smtp-Source: APXvYqz6NHNTIBH8UJ+icj9VXTVN4h1hM8/qBUrhU51PGhKjwXDJoLlz82/h+u/VosO5SOGShvrVkg==
X-Received: by 2002:a2e:9d12:: with SMTP id t18mr11183714lji.163.1555960738203;
        Mon, 22 Apr 2019 12:18:58 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id l13sm2848762lji.39.2019.04.22.12.18.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 12:18:57 -0700 (PDT)
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
Subject: [PATCH v2 7/7] mfd: max77620: Provide system power-off functionality
Date:   Mon, 22 Apr 2019 22:13:50 +0300
Message-Id: <20190422191350.27527-8-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190422191350.27527-1-digetx@gmail.com>
References: <20190422191350.27527-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide system power-off functionality that allows to turn off machine
gracefully.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/mfd/max77620.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/mfd/max77620.c b/drivers/mfd/max77620.c
index b7a058069808..3b8fd0b45425 100644
--- a/drivers/mfd/max77620.c
+++ b/drivers/mfd/max77620.c
@@ -41,6 +41,8 @@ struct max77620_desc {
 	enum max77620_chip_id chip_id;
 };
 
+static struct max77620_chip *max77620_scratch;
+
 static const struct resource gpio_resources[] = {
 	DEFINE_RES_IRQ(MAX77620_IRQ_TOP_GPIO),
 };
@@ -485,6 +487,15 @@ static int max77620_read_es_version(struct max77620_chip *chip)
 	return ret;
 }
 
+static void max77620_pm_power_off(void)
+{
+	struct max77620_chip *chip = max77620_scratch;
+
+	regmap_update_bits(chip->rmap, MAX77620_REG_ONOFFCNFG1,
+			   MAX77620_ONOFFCNFG1_SFT_RST,
+			   MAX77620_ONOFFCNFG1_SFT_RST);
+}
+
 static int max77620_probe(struct i2c_client *client,
 			  const struct i2c_device_id *id)
 {
@@ -493,6 +504,7 @@ static int max77620_probe(struct i2c_client *client,
 	const struct mfd_cell *mfd_cells;
 	const struct max77620_desc *desc;
 	int n_mfd_cells;
+	bool pm_off;
 	int ret;
 
 	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
@@ -563,6 +575,13 @@ static int max77620_probe(struct i2c_client *client,
 		return ret;
 	}
 
+	pm_off = of_property_read_bool(client->dev.of_node,
+				       "maxim,system-power-controller");
+	if (pm_off && !pm_power_off) {
+		max77620_scratch = chip;
+		pm_power_off = max77620_pm_power_off;
+	}
+
 	return 0;
 }
 
-- 
2.21.0

